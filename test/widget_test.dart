import 'package:flutter_test/flutter_test.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/domain/entities/testimonial.dart';
import 'package:lactarehub/main.dart';

void main() {
  setUpAll(ServiceLocator.setUp);

  testWidgets('o splash abre e leva à home pública', (tester) async {
    await tester.pumpWidget(const LactareApp());

    // Splash.
    expect(find.text('Rede de bancos de leite humano'), findsOneWidget);

    // Após o tempo do splash, a landing assume e carrega os dados mockados.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Quero doar leite'), findsOneWidget);
    expect(find.textContaining('17 BLHs'), findsOneWidget);
  });

  group('casos de uso sobre os dados mockados', () {
    test('a landing recebe as estatísticas da rede', () async {
      final stats = await ServiceLocator.getImpactStats();

      expect(stats.connectedBanks, 17);
      expect(stats.donorsInNetwork, 1284);
      expect(stats.highlightedStates, isNotEmpty);
    });

    test('o filtro de conteúdo devolve só a categoria pedida', () async {
      final all = await ServiceLocator.listArticles();
      final cuidados = await ServiceLocator.listArticles(
        category: ArticleCategory.cuidados,
      );

      expect(all.length, greaterThan(cuidados.length));
      expect(
        cuidados.every((a) => a.category == ArticleCategory.cuidados),
        isTrue,
      );
    });

    test('o mapa filtra por tipo e por "aberto agora"', () async {
      final blhs = await ServiceLocator.listCollectionPoints(
        type: CollectionPointType.blh,
      );
      final abertos = await ServiceLocator.listCollectionPoints(
        onlyOpenNow: true,
      );

      expect(blhs.every((p) => p.type == CollectionPointType.blh), isTrue);
      expect(abertos.every((p) => p.isOpenNow), isTrue);
    });

    test('o login aceita a credencial de teste e recusa a errada', () async {
      final session = await ServiceLocator.signIn(
        email: 'giovana@email.com',
        password: 'doadora123',
      );
      expect(session.name, 'Giovana');

      expect(
        () => ServiceLocator.signIn(
          email: 'giovana@email.com',
          password: 'senha-errada',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('confirmar a coleta persiste durante a sessão', () async {
      final before = await ServiceLocator.getNextCollection();
      expect(before.isConfirmed, isFalse);

      await ServiceLocator.confirmCollection();

      final after = await ServiceLocator.getNextCollection();
      expect(after.isConfirmed, isTrue);
    });

    test('um depoimento publicado entra no topo da lista', () async {
      final before = await ServiceLocator.listTestimonials();

      await ServiceLocator.submitTestimonial(
        const Testimonial(
          id: 'dep-teste-widget',
          authorName: 'Giovana Aparecida Ramos',
          city: 'São Paulo',
          state: 'SP',
          message: 'Doar virou parte da minha rotina de cuidado.',
          type: TestimonialType.recorrente,
          avatarGradientIndex: 0,
        ),
      );

      final after = await ServiceLocator.listTestimonials();
      expect(after.length, before.length + 1);
      expect(after.first.id, 'dep-teste-widget');
    });
  });
}
