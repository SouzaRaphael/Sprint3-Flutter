# Lactare — rede digital de doação de leite humano

Aplicativo mobile em Flutter que conecta nutrizes doadoras a Bancos de Leite
Humano (BLHs), simulando o fluxo completo de doação com dados mockados.

---

## 1. Identificação

| | |
|---|---|
| **Projeto** | Lactare |
| **Equipe** | `<<PREENCHER: nome da equipe>>` |
| **Repositório** | `<<PREENCHER: link do repositório no GitHub>>` |
| **Vídeo de navegação** | `<<PREENCHER: link do vídeo demonstrando o app rodando>>` |

### Integrantes

| Nome | RM |
|---|---|
| `<<PREENCHER>>` | `<<PREENCHER>>` |
| `<<PREENCHER>>` | `<<PREENCHER>>` |
| `<<PREENCHER>>` | `<<PREENCHER>>` |
| `<<PREENCHER>>` | `<<PREENCHER>>` |

---

## 2. Objetivo do aplicativo

Bebês prematuros dependem de leite humano para sobreviver às primeiras semanas,
e os bancos de leite brasileiros operam sempre abaixo da demanda. O gargalo
raramente é a falta de doadoras — é a distância entre quem quer doar e quem
sabe como.

O **Lactare** encurta essa distância. O aplicativo permite que uma nutriz:

- entenda em minutos se pode doar e como funciona o processo;
- se cadastre pelo celular e passe pela triagem sem sair de casa;
- encontre o BLH ou posto de coleta mais próximo;
- agende a coleta domiciliar na data e janela de horário que couberem na rotina;
- **acompanhe o rastreio de cada doação**, do frasco recolhido em casa até a
  UTI neonatal que recebeu o leite;
- aprenda com conteúdo produzido pela rede e compartilhe sua história.

Nesta Sprint todos os dados são **mockados**: não há API, Firebase nem banco
local, conforme a especificação.

---

## 3. Telas implementadas

> **Prints:** as imagens abaixo devem ser substituídas por capturas do
> aplicativo em execução no emulador ou dispositivo. Salve os arquivos em
> `docs/screenshots/` com os nomes indicados.

### 3.1 Splash

![Splash](docs/screenshots/01-splash.png)

Abertura da marca. Após dois segundos leva à home pública.

### 3.2 Landing / Home pública — `/`

![Landing](docs/screenshots/02-landing.png)

Apresentação do produto: chamada principal, números da rede em faixa escura
(847 litros coletados, 8.470 bebês atendidos, 1.284 nutrizes, 17 BLHs),
a seção "Em 3 passos", convite às histórias, atalho para o mapa, bloco para
profissionais e rodapé. "Como funciona" rola a página até os três passos.

### 3.3 Login — `/login`

![Login](docs/screenshots/03-login.png)

Autenticação com validação de campos, alternância de visibilidade da senha e
estado de carregamento no botão. A caixa **Credenciais de teste** traz as duas
contas aceitas — **tocar em uma delas preenche o formulário**:

| Perfil | E-mail | Senha |
|---|---|---|
| Admin | `admin@lactare.com.br` | `admin123` |
| Doadora | `giovana@email.com` | `doadora123` |

Senha incorreta devolve mensagem de erro; senha correta abre a área da doadora.

### 3.4 Cadastro — `/cadastro`

![Cadastro](docs/screenshots/04-cadastro.png)

Formulário em **quatro etapas** com barra de progresso segmentada: *Sobre você*
→ *Onde você está* → *Saúde e triagem* → *Revise seus dados*. Cada etapa valida
os próprios campos antes de avançar, o botão "Voltar" recua uma etapa e a tela
final exibe a confirmação com os próximos passos.

### 3.5 Home da doadora — aba Início

![Home da doadora](docs/screenshots/05-home-doadora.png)

Saudação personalizada, card em gradiente com a **próxima coleta** e as ações
*Confirmar* / *Reagendar*, quatro atalhos rápidos, resumo de impacto pessoal
(14 doações · 3,2 L · ~9 bebês alcançados), prévia do rastreamento, mensagem da
equipe e carrossel de leituras da semana.

### 3.6 Agendar coleta — aba Doar

![Agendar coleta](docs/screenshots/06-agendar.png)

Formulário de agendamento: modalidade (coleta domiciliar, posto ou BLH), ponto
de entrega quando presencial, fita de datas dos próximos catorze dias, janela de
horário e observações. Ao confirmar, a coleta agendada passa a aparecer na aba
Início.

### 3.7 Mapa de BLHs — aba Pontos

![Mapa](docs/screenshots/07-mapa.png)

Mapa ilustrado desenhado com `CustomPainter` (sem SDK de mapas nem chave de
API), com marcadores dos pontos da rede, busca por nome ou bairro, alternador
"Aberto agora" e filtros por tipo. Tocar em um marcador abre o card do ponto;
tocar no card abre a tela de detalhes.

### 3.8 Conteúdo — aba Conteúdo

![Conteúdo](docs/screenshots/08-conteudo.png)

Biblioteca de oito artigos com filtro por categoria. Cada card leva ao artigo
completo, que pode ser salvo na lista de leitura.

### 3.9 Minha Área — aba Eu

![Minha Área](docs/screenshots/09-minha-area.png)

Card da jornada, botão de novo agendamento, **linha do tempo de rastreamento**
da doação atual, grade de seis conquistas (conquistada / em progresso /
bloqueada), convite para indicar uma amiga e lista de leituras.

### 3.10 Depoimentos — `/depoimentos`

![Depoimentos](docs/screenshots/10-depoimentos.png)

Histórias das doadoras, com filtro segmentado entre *Todos*, *Primeira doação*
e *Recorrentes*. O card final abre o formulário de escrita — o depoimento
publicado aparece imediatamente no topo da lista.

### 3.11 Telas de detalhe

![Detalhes](docs/screenshots/11-detalhes.png)

Três telas que recebem a entidade selecionada por `settings.arguments`:

- **Detalhe do artigo** — texto completo, autoria e ação de salvar;
- **Detalhe do ponto de coleta** — endereço, horário, distância e telefone;
- **Detalhe da doação** — volume, origem, destino e o percurso completo do leite.

---

## 4. Como executar

Pré-requisitos: Flutter 3.41+ e um emulador Android ou dispositivo conectado.

```bash
flutter pub get
```

```bash
flutter run
```

Para gerar o APK de depuração:

```bash
flutter build apk --debug
```

Para rodar os testes automatizados:

```bash
flutter test
```

> **Caminho do projeto:** o Android Gradle Plugin bloqueia builds em diretórios
> com caracteres acentuados. Como o caminho deste projeto contém "3° ano", o
> arquivo `android/gradle.properties` traz `android.overridePathCheck=true`. O
> build foi validado com esse ajuste. Alternativa: mover o projeto para um
> caminho sem acentos e remover a linha.

---

## 5. Arquitetura

O projeto segue **Clean Architecture**, com a dependência sempre apontando para
o domínio.

```
lib/
├── main.dart                        # composição do app e tema
├── core/
│   ├── di/service_locator.dart      # único ponto que liga data ↔ domain
│   ├── theme/                       # cores, espaçamentos, raios, tipografia
│   └── utils/formatters.dart        # formatação de datas, volumes e nomes
├── domain/                          # regra de negócio, sem Flutter
│   ├── entities/                    # 13 entidades
│   ├── repositories/                # 8 contratos abstratos
│   └── usecases/                    # 18 casos de uso, um por operação
├── data/
│   ├── datasources/                 # 8 fontes mockadas
│   └── repositories/                # implementações dos contratos
└── presentation/
    ├── navigation/                  # onGenerateRoute e nomes de rota
    ├── controllers/                 # 8 ChangeNotifier, um por tela com estado
    ├── shared/components/           # widgets reutilizados por 2+ telas
    └── screens/<feature>/           # tela + components/ da feature
```

**Regras respeitadas:**

- `presentation` **nunca** importa `data` — conversa apenas com casos de uso
  do domínio. A ligação concreta acontece só no `ServiceLocator`.
- `domain` não importa Flutter (exceto `dart:ui` para a cor de capa dos
  artigos).
- Nenhum dado de negócio é declarado em arquivo de tela: tudo vem dos
  datasources, atravessando repositório e caso de uso.
- Telas são finas — compõem widgets de `components/`; o estado vive nos
  controllers.

**Gerência de estado:** `ChangeNotifier` + `ListenableBuilder`, ambos do
próprio Flutter. Sem Provider, Bloc ou Riverpod.

**Dependência externa:** apenas `google_fonts` (tipografia Plus Jakarta Sans).
Sem SDK de mapas e sem arquivos de imagem — logo, blobs, avatares, capas de
artigo e mapa são todos desenhados em código.

---

## 6. Dados mockados

Ficam isolados em `lib/data/datasources/`, nunca nas telas:

| Arquivo | Conteúdo |
|---|---|
| `institutional_mock_datasource.dart` | Estatísticas da rede e os três passos da landing |
| `article_mock_datasource.dart` | 8 artigos com texto integral e autoria |
| `testimonial_mock_datasource.dart` | 6 depoimentos assinados |
| `collection_point_mock_datasource.dart` | 7 pontos da rede (BLHs, postos e coleta domiciliar) |
| `donor_mock_datasource.dart` | Perfil da doadora e 6 conquistas |
| `donation_mock_datasource.dart` | 3 doações com linha do tempo de rastreio |
| `schedule_mock_datasource.dart` | Agenda de coletas e janelas de horário |
| `auth_mock_datasource.dart` | Contas de teste do login |

Os repositórios simulam latência com `Future.delayed`, o que dá estados de
carregamento reais às telas. Alterações feitas durante o uso — confirmar uma
coleta, agendar outra data, publicar um depoimento — **persistem em memória** e
se refletem nas demais telas enquanto o app estiver aberto.

---

## 7. Navegação e passagem de parâmetros

A navegação é centralizada em `AppNavigation.generateRoutes`
(`lib/presentation/navigation/app_navigation.dart`). As telas recebem apenas
callbacks — nenhuma delas conhece o `Navigator` diretamente.

| Rota | Tela | Parâmetro recebido |
|---|---|---|
| `/splash` | Splash | — |
| `/` | Landing | — |
| `/login` | Login | — |
| `/cadastro` | Cadastro (4 etapas) | — |
| `/cadastro/sucesso` | Confirmação do cadastro | — |
| `/app` | Casca com as 5 abas | `ShellTab` (aba inicial) |
| `/depoimentos` | Depoimentos | — |
| `/depoimentos/novo` | Escrever depoimento | — |
| `/conteudo/artigo` | Detalhe do artigo | `Article` |
| `/pontos/detalhe` | Detalhe do ponto de coleta | `CollectionPoint` |
| `/doacoes/detalhe` | Detalhe da doação | `Donation` |

**Exemplo de passagem de parâmetros:** tocar em um card na aba Conteúdo empurra
`/conteudo/artigo` com o objeto `Article` em `arguments`; a rota faz o cast e
entrega a entidade à tela de detalhe, que exibe o texto daquele artigo
específico.

**Retorno visual:** toda ação responde imediatamente — botões com indicador de
carregamento, SnackBars padronizados em `AppFeedback` (sucesso, informação e
erro), estados de lista vazia quando um filtro não devolve resultados e
mudanças de estado visíveis (a coleta confirmada troca o rótulo do botão para
"Confirmada").

---

## 8. Verificação

Executado neste projeto:

```bash
flutter analyze     # No issues found!
flutter test        # 7 testes, todos passando
flutter build apk --debug   # APK gerado com sucesso
```

Os testes cobrem a inicialização do app (splash → landing) e os casos de uso
sobre os dados mockados: estatísticas da rede, filtro de conteúdo, filtros do
mapa, login com credencial válida e inválida, confirmação de coleta e
publicação de depoimento.

---

## 9. Design

O design implementado segue as telas de referência em
`docs/Lactare-Telas.pdf`. A paleta foi extraída diretamente das capturas e está
centralizada em `lib/core/theme/app_colors.dart`:

| Token | Hex | Uso |
|---|---|---|
| `primary` | `#00458B` | botões, ícone da aba ativa |
| `primaryDark` | `#002A55` | títulos das telas internas |
| `accent` | `#54B2E3` | destaques e bordas ativas |
| `ink` | `#101828` | texto forte e faixa de estatísticas |
| `inkMuted` | `#4A5565` | texto secundário |
| `bgApp` | `#F7FBFD` | fundo das telas |
| `tintBlue` | `#EAF6FC` | caixas de informação e chips |
| `successBg` / `successFg` | `#D8F7F5` / `#1B7F79` | etiqueta "Recorrente" |
| `pinkBg` / `pinkFg` | `#FDE6EF` / `#B53272` | etiqueta "1ª doação" |
