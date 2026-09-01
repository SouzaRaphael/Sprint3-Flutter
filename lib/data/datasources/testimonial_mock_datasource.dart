import 'package:lactarehub/domain/entities/testimonial.dart';

/// Depoimentos das doadoras da rede.
///
/// A lista é mutável porque a tela "Escrever depoimento" acrescenta itens
/// durante a sessão — não há persistência nesta Sprint.
abstract class TestimonialMockDatasource {
  static final List<Testimonial> items = [
    const Testimonial(
      id: 'dep-marina-costa',
      authorName: 'Marina Costa',
      city: 'São Paulo',
      state: 'SP',
      message: 'Doar foi a forma mais bonita de prolongar o cuidado que sinto '
          'pelo meu filho — agora chega a outras famílias.',
      type: TestimonialType.recorrente,
      avatarGradientIndex: 0,
    ),
    const Testimonial(
      id: 'dep-joana-ribeiro',
      authorName: 'Joana Ribeiro',
      city: 'Guarulhos',
      state: 'SP',
      message: 'A coleta domiciliar tornou tudo simples. Em poucas semanas eu '
          'já estava na minha terceira doação.',
      type: TestimonialType.recorrente,
      avatarGradientIndex: 1,
    ),
    const Testimonial(
      id: 'dep-bia-fernandes',
      authorName: 'Bia Fernandes',
      city: 'Osasco',
      state: 'SP',
      message: 'Saber que minhas gotinhas alimentam um bebê internado mudou '
          'minha rotina. Cada gota conta mesmo.',
      type: TestimonialType.primeiraDoacao,
      avatarGradientIndex: 2,
    ),
    const Testimonial(
      id: 'dep-ana-paula',
      authorName: 'Ana Paula Menezes',
      city: 'Santo André',
      state: 'SP',
      message: 'Cheguei insegura, achando que produzia pouco. A equipe me '
          'acolheu e mostrou que pequenas quantidades já fazem diferença.',
      type: TestimonialType.primeiraDoacao,
      avatarGradientIndex: 5,
    ),
    const Testimonial(
      id: 'dep-cris-tavares',
      authorName: 'Cris Tavares',
      city: 'São Paulo',
      state: 'SP',
      message: 'É bonito ver o trajeto da minha doação até o bebê. A timeline '
          'na área da doadora me emociona toda vez.',
      type: TestimonialType.recorrente,
      avatarGradientIndex: 3,
    ),
    const Testimonial(
      id: 'dep-leticia-m',
      authorName: 'Letícia Machado',
      city: 'São Bernardo',
      state: 'SP',
      message: 'Indiquei três amigas. A rede do Lactare cresce no boca a boca, '
          'sem complicação.',
      type: TestimonialType.primeiraDoacao,
      avatarGradientIndex: 4,
    ),
  ];
}
