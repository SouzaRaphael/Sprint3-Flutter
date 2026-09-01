import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/domain/entities/article.dart';

/// Biblioteca de conteúdo educativo do Lactare.
///
/// Dados simulados desta Sprint: nenhuma chamada de rede é feita.
abstract class ArticleMockDatasource {
  static const List<Article> items = [
    Article(
      id: 'art-doar-transforma',
      title: 'Por que doar leite humano transforma vidas',
      summary: 'Entenda como cada gota fortalece bebês prematuros em UTIs.',
      category: ArticleCategory.beneficios,
      readingMinutes: 5,
      coverColor: AppColors.coverBlue,
      author: 'Enfª Renata Padilha · BLH IFF',
      paragraphs: [
        'Um bebê que nasce antes das 37 semanas chega ao mundo com o '
            'intestino ainda imaturo. O leite humano é o único alimento capaz '
            'de proteger essa parede intestinal frágil enquanto ela termina de '
            'se formar.',
        'Em unidades neonatais, receber leite humano pastorizado reduz de '
            'forma expressiva os casos de enterocolite necrosante, uma das '
            'complicações mais graves da prematuridade. Também encurta o tempo '
            'de internação e melhora a tolerância alimentar.',
        'A conta é surpreendente: 1 mililitro alimenta um recém-nascido de '
            'muito baixo peso em uma única refeição. Um frasco de 200 ml pode '
            'sustentar até dez bebês por um dia inteiro.',
        'Doar não exige excedente enorme nem rotina rígida. A maior parte das '
            'nutrizes da rede doa entre 50 ml e 150 ml por coleta, algumas '
            'vezes por mês, sem prejuízo algum para a amamentação do próprio '
            'filho.',
      ],
    ),
    Article(
      id: 'art-quem-pode-doar',
      title: 'Quem pode ser pessoa doadora?',
      summary: 'Critérios simples para iniciar sua jornada de doação.',
      category: ArticleCategory.beneficios,
      readingMinutes: 4,
      coverColor: AppColors.coverLilac,
      author: 'Equipe Lactare',
      paragraphs: [
        'Pode doar quem está amamentando, tem leite além da necessidade do '
            'próprio bebê e goza de boa saúde. Não é preciso ter uma produção '
            'excepcional — a rede se sustenta em muitas doações pequenas.',
        'A triagem verifica três pontos: ausência de doenças transmissíveis '
            'pelo leite, uso de medicamentos compatíveis com a amamentação e '
            'exames de pré-natal em dia. Boa parte dos remédios de uso comum é '
            'permitida.',
        'Não podem doar pessoas que fumam mais do que dez cigarros por dia, '
            'fazem uso de drogas ilícitas ou tomam medicamentos incompatíveis. '
            'Em caso de dúvida, a equipe do banco de leite avalia cada '
            'situação individualmente.',
        'Todo o processo começa com um cadastro de dois minutos pelo celular. '
            'A partir daí, um enfermeiro do BLH mais próximo entra em contato '
            'para concluir a triagem.',
      ],
    ),
    Article(
      id: 'art-primeira-doacao',
      title: 'Primeira doação: o que esperar no dia',
      summary: 'Um roteiro do agendamento até a saída do frasco de casa.',
      category: ArticleCategory.cuidados,
      readingMinutes: 6,
      coverColor: AppColors.coverMint,
      author: 'Enfª Camila Furtado',
      paragraphs: [
        'A primeira coleta costuma gerar mais ansiedade do que trabalho. Na '
            'véspera, separe frascos de vidro com tampa plástica, já '
            'fervidos por quinze minutos e secos de boca para baixo.',
        'No dia, escolha um horário tranquilo. Prenda os cabelos, use máscara, '
            'lave as mãos e os antebraços por um minuto e despreze os '
            'primeiros jatos de leite.',
        'A ordenha manual costuma render mais do que a bomba nas primeiras '
            'vezes. Massageie a mama em movimentos circulares, comprima a '
            'aréola entre o polegar e o indicador e deixe o leite escorrer '
            'diretamente no frasco.',
        'Feche, identifique com data e horário e leve imediatamente ao '
            'congelador. Na coleta domiciliar, a equipe chega com caixa '
            'térmica e faz a conferência na sua porta — leva menos de cinco '
            'minutos.',
      ],
    ),
    Article(
      id: 'art-armazenar-em-casa',
      title: 'Como armazenar leite humano em casa',
      summary: 'Passo a passo seguro, do recipiente ao freezer.',
      category: ArticleCategory.comoArmazenar,
      readingMinutes: 3,
      coverColor: AppColors.coverPeach,
      author: 'Equipe Lactare',
      paragraphs: [
        'Use apenas vidro com tampa plástica rosqueável. Potes de café solúvel '
            'servem muito bem: retire o rótulo e o papelão da tampa, ferva por '
            'quinze minutos e seque naturalmente.',
        'No congelador, o leite cru se mantém por até quinze dias. Na '
            'geladeira, apenas doze horas. Nunca armazene na porta do freezer, '
            'onde a temperatura oscila a cada abertura.',
        'É possível completar o mesmo frasco em coletas diferentes. Resfrie o '
            'leite novo na geladeira antes de somá-lo ao que já está '
            'congelado, e mantenha sempre a data da primeira coleta na '
            'etiqueta.',
        'Deixe um espaço de dois dedos abaixo da tampa: o leite se expande ao '
            'congelar. E jamais use micro-ondas para degelar — o calor '
            'destrói os fatores de proteção.',
      ],
    ),
    Article(
      id: 'art-higiene-coleta',
      title: 'Higiene e cuidados na coleta',
      summary: 'Pequenos rituais que garantem qualidade do leite.',
      category: ArticleCategory.cuidados,
      readingMinutes: 4,
      coverColor: AppColors.coverBlue,
      author: 'Enfª Renata Padilha · BLH IFF',
      paragraphs: [
        'O leite humano sai estéril da mama. Quase toda contaminação vem do '
            'ambiente, das mãos e da fala sobre o frasco aberto — por isso a '
            'máscara não é excesso de zelo.',
        'Escolha um cômodo longe do banheiro e da cozinha em uso. Limpe a '
            'bancada, desligue o ventilador e evite animais no ambiente '
            'durante a ordenha.',
        'Água e sabão nas mamas bastam. Não use álcool, cremes ou antissépticos '
            'na aréola: além de ressecarem, alteram o sabor e afastam o bebê.',
        'Se precisar interromper, feche o frasco e retome depois. Leite que '
            'ficou mais de uma hora em temperatura ambiente deve ser '
            'descartado.',
      ],
    ),
    Article(
      id: 'art-retorno-ao-trabalho',
      title: 'Amamentação e retorno ao trabalho',
      summary: 'Estratégias para conciliar rotina e amamentação.',
      category: ArticleCategory.amamentacao,
      readingMinutes: 7,
      coverColor: AppColors.coverRose,
      author: 'Consultora Marina Duarte, IBCLC',
      paragraphs: [
        'Comece a formar estoque cerca de três semanas antes da volta ao '
            'trabalho, com uma ordenha diária em horário fixo. O corpo entende '
            'o pedido e ajusta a produção.',
        'A lei brasileira garante dois intervalos de trinta minutos por dia '
            'para amamentar ou ordenhar até o bebê completar seis meses. '
            'Muitas empresas ampliam esse direito quando provocadas.',
        'Uma bolsa térmica com gelo reutilizável conserva o leite por até doze '
            'horas — tempo suficiente para a jornada e o deslocamento. Ao '
            'chegar, transfira imediatamente para a geladeira ou o freezer.',
        'Mantenha as mamadas livres nos fins de semana e à noite. O contato '
            'direto sustenta a produção melhor do que qualquer bomba e protege '
            'o vínculo nos dias corridos.',
      ],
    ),
    Article(
      id: 'art-frio-inverno',
      title: 'Como o frio afeta a doação no inverno',
      summary: 'O que muda no transporte e na conservação nos meses frios.',
      category: ArticleCategory.cuidados,
      readingMinutes: 4,
      coverColor: AppColors.coverBlue,
      author: 'Equipe Lactare',
      paragraphs: [
        'No inverno, a demanda das UTIs neonatais cresce: infecções '
            'respiratórias aumentam as internações e o leite humano vira '
            'ainda mais decisivo na recuperação.',
        'O frio ajuda no transporte, mas não dispensa a caixa térmica. A '
            'regra segue a mesma: o leite não pode descongelar no caminho, '
            'nem parcialmente.',
        'Mãos ressecadas e fissuras são mais comuns nessa época. Hidrate as '
            'mãos após a higienização e use o próprio leite materno nas '
            'rachaduras da aréola.',
        'Se você adoecer com um resfriado comum, pode continuar doando. '
            'Gripes e viroses respiratórias não contraindicam a doação — '
            'reforce a máscara e avise a equipe do banco.',
      ],
    ),
    Article(
      id: 'art-jornada-uti',
      title: 'A jornada do leite humano até a UTI',
      summary: 'O caminho completo, da sua casa ao bebê internado.',
      category: ArticleCategory.bastidores,
      readingMinutes: 6,
      coverColor: AppColors.coverLilac,
      author: 'Equipe Lactare',
      paragraphs: [
        'Recolhido na sua casa, o frasco viaja em caixa térmica monitorada e '
            'chega ao banco de leite ainda congelado. É registrado, pesado e '
            'recebe um código de rastreio — o mesmo que você acompanha no '
            'aplicativo.',
        'No degelo, o leite passa por seleção: cor, odor, acidez Dornic e '
            'presença de sujidades. O que não passa é descartado, e a doadora '
            'recebe orientação para a próxima coleta.',
        'Vem então a pasteurização, a 62,5 °C por trinta minutos. A '
            'temperatura elimina agentes infecciosos e preserva a maior parte '
            'dos fatores imunológicos.',
        'Cada lote aprovado é analisado microbiologicamente antes de ser '
            'liberado. Só então o leite é distribuído às unidades neonatais, '
            'com prescrição individual para cada bebê — como um medicamento.',
      ],
    ),
  ];

  /// Leituras destacadas nos carrosséis das telas da doadora.
  static const List<String> featuredIds = ['art-frio-inverno', 'art-jornada-uti'];
}
