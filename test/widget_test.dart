import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/core/theme/app_theme.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/entities/registration_draft.dart';
import 'package:lactarehub/domain/entities/donor.dart';
import 'package:lactarehub/domain/entities/testimonial.dart';
import 'package:lactarehub/main.dart';
import 'package:lactarehub/presentation/screens/profile/profile_screen.dart';
import 'package:lactarehub/presentation/screens/shell/main_shell_screen.dart';
import 'package:lactarehub/presentation/screens/shell/shell_tab.dart';

/// Cadastro completo usado nos testes do fluxo de registro.
const _draft = RegistrationDraft(
  fullName: 'Helena Braga Nogueira',
  email: 'helena.braga@email.com',
  phone: '(21) 99630-4477',
  birthDate: '02/09/1996',
  zipCode: '22250-040',
  street: 'Rua das Laranjeiras',
  number: '480',
  neighborhood: 'Laranjeiras',
  city: 'Rio de Janeiro',
  state: 'RJ',
  babyAgeMonths: '3',
  isBreastfeeding: true,
  takesMedication: false,
  acceptedTerms: true,
);

void main() {
  setUpAll(ServiceLocator.setUp);

  // Cada teste começa na sessão de demonstração: o estado mockado é global
  // e sobrevive entre os casos.
  setUp(() => ServiceLocator.signOut());

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
      expect(before!.isConfirmed, isFalse);

      await ServiceLocator.confirmCollection();

      final after = await ServiceLocator.getNextCollection();
      expect(after!.isConfirmed, isTrue);
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

  group('perfil vindo do cadastro', () {
    test('o perfil passa a exibir os dados informados no cadastro', () async {
      await ServiceLocator.registerDonor(_draft);

      final donor = await ServiceLocator.getDonorProfile();

      expect(donor.fullName, 'Helena Braga Nogueira');
      expect(donor.firstName, 'Helena');
      expect(donor.email, 'helena.braga@email.com');
      expect(donor.phone, '(21) 99630-4477');
      expect(donor.birthDate, '02/09/1996');
      expect(donor.zipCode, '22250-040');
      expect(donor.cityAndState, 'Rio de Janeiro, RJ');
      expect(
        donor.formattedAddress,
        'Rua das Laranjeiras, 480 — Laranjeiras, Rio de Janeiro/RJ',
      );
      expect(donor.babyAgeMonths, '3');
      expect(donor.isBreastfeeding, isTrue);
      expect(donor.takesMedication, isFalse);
    });

    test('quem acabou de se cadastrar começa sem histórico', () async {
      await ServiceLocator.registerDonor(_draft);

      final donor = await ServiceLocator.getDonorProfile();
      expect(donor.completedDonations, 0);
      expect(donor.donatedMilliliters, 0);
      expect(donor.babiesReached, 0);
      expect(donor.daysSinceLastDonation, isNull);
      expect(donor.isStartingJourney, isTrue);

      expect(await ServiceLocator.getNextCollection(), isNull);
      expect(await ServiceLocator.getCurrentDonation(), isNull);
      expect(await ServiceLocator.listDonations(), isEmpty);

      // Nenhuma medalha conquistada ainda.
      final achievements = await ServiceLocator.getAchievements();
      expect(achievements, isNotEmpty);
      expect(
        achievements.any((a) => a.progressLabel == 'Conquistada'),
        isFalse,
      );
    });

    test('agendar a primeira coleta preenche a agenda vazia', () async {
      await ServiceLocator.registerDonor(_draft);
      expect(await ServiceLocator.getNextCollection(), isNull);

      final today = ServiceLocator.getReferenceDate();
      await ServiceLocator.scheduleCollection(
        CollectionSchedule(
          id: 'agd-teste',
          scheduledAt: DateTime(today.year, today.month, today.day + 3, 10),
          timeWindow: '10h às 12h',
          mode: CollectionMode.domiciliar,
          place: 'Laranjeiras',
          isConfirmed: true,
          referenceToday: today,
        ),
      );

      final scheduled = await ServiceLocator.getNextCollection();
      expect(scheduled, isNotNull);
      expect(scheduled!.place, 'Laranjeiras');
      expect(scheduled.timeWindow, '10h às 12h');
    });

    test('entrar com a conta de teste devolve a persona demo', () async {
      await ServiceLocator.registerDonor(_draft);
      expect((await ServiceLocator.getDonorProfile()).firstName, 'Helena');

      await ServiceLocator.signIn(
        email: 'giovana@email.com',
        password: 'doadora123',
      );

      final donor = await ServiceLocator.getDonorProfile();
      expect(donor.firstName, 'Giovana');
      expect(donor.completedDonations, 14);
      expect(await ServiceLocator.getNextCollection(), isNotNull);
      expect(await ServiceLocator.listDonations(), isNotEmpty);
    });
  });

  group('a coleta agendada chega ao perfil e às abas', () {
    // Dentro de `testWidgets` o relógio é falso: um `await` direto sobre a
    // latência simulada dos repositórios nunca resolveria. `runAsync` executa
    // essas chamadas no tempo real, fora do relógio do teste.

    /// Agenda uma coleta distinta da que vem no mock de demonstração.
    Future<CollectionSchedule> agendarQuintaAs16(WidgetTester tester) async {
      late CollectionSchedule schedule;
      await tester.runAsync(() async {
        final today = ServiceLocator.getReferenceDate();
        schedule = await ServiceLocator.scheduleCollection(
          CollectionSchedule(
            id: 'agd-teste-sincronia',
            scheduledAt: DateTime(today.year, today.month, today.day + 3, 16),
            timeWindow: '16h às 18h',
            mode: CollectionMode.postoDeColeta,
            place: 'BLH Hospital Universitário da USP',
            isConfirmed: true,
            referenceToday: today,
          ),
        );
      });
      return schedule;
    }

    /// Troca de aba e espera a revalidação concluir.
    ///
    /// Ela é silenciosa — não exibe indicador —, então não agenda quadros que
    /// o `pumpAndSettle` sozinho pudesse seguir: é preciso avançar o relógio.
    Future<void> trocarAba(WidgetTester tester, String label) async {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
    }

    Widget montarPerfil(Donor donor) => MaterialApp(
      theme: AppTheme.light,
      home: ProfileScreen(
        donor: donor,
        goBack: () {},
        onScheduleCollection: () {},
        onSignedOut: () {},
      ),
    );

    testWidgets('o perfil mostra a coleta marcada e o estado vazio sem ela', (
      tester,
    ) async {
      // Quem acabou de se cadastrar não tem coleta: o perfil convida a marcar.
      late Donor donor;
      await tester.runAsync(() async {
        await ServiceLocator.registerDonor(_draft);
        donor = await ServiceLocator.getDonorProfile();
      });

      await tester.pumpWidget(montarPerfil(donor));
      await tester.pumpAndSettle();

      expect(find.text('Nenhuma coleta agendada'), findsOneWidget);
      expect(find.text('Próxima coleta'), findsNothing);

      // Depois de agendar, reabrir o perfil passa a exibir os dados da coleta.
      final schedule = await agendarQuintaAs16(tester);

      // Desmonta antes de montar de novo: sem isso o Flutter reaproveitaria o
      // State existente e o `initState` não buscaria a agenda outra vez.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(montarPerfil(donor));
      await tester.pumpAndSettle();

      expect(find.text('Próxima coleta'), findsOneWidget);
      expect(find.text('Confirmada'), findsOneWidget);
      expect(find.text('16h às 18h'), findsOneWidget);
      expect(find.text('Levar a um posto'), findsOneWidget);
      expect(find.text('BLH Hospital Universitário da USP'), findsOneWidget);
      expect(find.text('Nenhuma coleta agendada'), findsNothing);

      // E a data confere com o que foi gravado.
      expect(
        find.textContaining(Formatters.weekdayAndDate(schedule.scheduledAt)),
        findsWidgets,
      );
    });

    testWidgets('agendar em uma aba atualiza Início e Minha Área', (
      tester,
    ) async {
      late CollectionSchedule inicial;
      await tester.runAsync(() async {
        inicial = (await ServiceLocator.getNextCollection())!;
      });
      final textoInicial =
          '${Formatters.weekdayAndDate(inicial.scheduledAt)} · '
          '${inicial.scheduledAt.hour}h';

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: MainShellScreen(
            initialTab: ShellTab.inicio,
            onOpenTestimonials: () {},
            onOpenArticle: (_) {},
            onOpenCollectionPoint: (_) {},
            onOpenDonation: (_) {},
            onOpenProfile: (_) async => null,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(textoInicial), findsWidgets);

      // A coleta muda enquanto o usuário está em outra aba.
      final nova = await agendarQuintaAs16(tester);
      final textoNovo =
          '${Formatters.weekdayAndDate(nova.scheduledAt)} · '
          '${nova.scheduledAt.hour}h';

      // Sair do Início e voltar dispara a revalidação silenciosa.
      await trocarAba(tester, 'Doar');
      await trocarAba(tester, 'Início');

      expect(find.text(textoNovo), findsWidgets);

      // A aba Eu revalida quando recebe foco: aí o dado antigo some de vez.
      await trocarAba(tester, 'Eu');

      expect(find.text(textoNovo), findsWidgets);
      expect(find.text(textoInicial), findsNothing);
    });
  });
}
