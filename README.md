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
horário e observações.

Ao confirmar, a coleta **se propaga imediatamente** para o card da aba Início,
para a jornada da Minha Área e para o perfil. O mesmo vale para "Reagendar" e
para o botão "Confirmar" do card da home.

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

### 3.11 Meu perfil — `/perfil`

![Perfil](docs/screenshots/12-perfil.png)

Aberta ao tocar no avatar do cabeçalho da aba "Eu". Traz, no topo, o card
**Próxima coleta** — data, janela de horário, modalidade, local, observações e
o selo de situação (*Confirmada* ou *Aguardando confirmação*) — sempre com o
último agendamento, já que a tela busca a agenda a cada abertura. Sem coleta
marcada, o card vira um convite com atalho para a aba Doar.

Abaixo dele ficam **os dados informados no cadastro**: contato (e-mail,
telefone, nascimento), endereço completo e triagem (idade do bebê, amamentação,
medicamento contínuo), além do resumo da jornada. Encerra com "Sair da conta",
que volta para a home pública.

### 3.12 Telas de detalhe

![Detalhes](docs/screenshots/11-detalhes.png)

Três telas que recebem a entidade selecionada por `settings.arguments`:

- **Detalhe do artigo** — texto completo, autoria e ação de salvar;
- **Detalhe do ponto de coleta** — endereço, horário, distância e telefone;
- **Detalhe da doação** — volume, origem, destino e o percurso completo do leite.

---

### 3.13 Cadastro e login levam a experiências diferentes

O app tem duas portas de entrada, e elas **não** desembocam no mesmo estado.

**Entrando pelo cadastro**, o que foi digitado nas quatro etapas passa a ser o
perfil da sessão: a home saúda pelo nome informado e a tela de perfil mostra
e-mail, telefone, nascimento, endereço e triagem exatamente como preenchidos.
A jornada começa do zero, e o app assume isso explicitamente:

| Onde | O que aparece |
|---|---|
| Início — topo | "Vamos marcar a sua primeira coleta." + card "Nenhuma coleta agendada" com atalho para a aba Doar |
| Início — impacto | 0 doações, 0,0 L, ~0 bebês, e a faixa "Sua jornada começa agora" |
| Início e Minha Área — rastreamento | Card explicando que o percurso aparece após a primeira coleta |
| Minha Área — jornada | "Última doação: nenhuma ainda" · "Próximo agendamento: a marcar" |
| Minha Área — conquistas | "Primeira doação" em progresso, as demais bloqueadas |

Agendar uma coleta pela aba Doar preenche a agenda e o card de coleta assume o
lugar do estado vazio.

**Como a informação se mantém em dia.** As cinco abas vivem num `IndexedStack`
e não são descartadas ao trocar de aba, então cada uma revalida os dados ao
voltar a ficar visível: a casca informa qual aba está ativa e as telas Início e
Minha Área chamam um `refresh()` silencioso — sem indicador de carregamento,
para não piscar a cada troca. Como o gatilho é a visibilidade, e não um evento
específico, qualquer alteração (agendar, reagendar, confirmar) chega às demais
telas sem que a mutação precise avisar ninguém. O perfil não precisa disso: por
ser uma rota empurrada, lê a agenda do zero a cada abertura.

**Entrando pelo login** com `giovana@email.com`, o app carrega a persona de
demonstração completa — 14 doações, coleta marcada para 8 de maio e a doação
#LCT-2104 em rastreamento —, que é o estado retratado no protótipo original.

Para comparar os dois caminhos na mesma execução, use "Sair da conta" na tela
de perfil.

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
│   ├── datasources/                 # 9 fontes mockadas (inclui a sessão)
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

**Sessão:** `SessionMockDatasource` guarda quem está usando o app agora —
perfil, coleta agendada, doações e conquistas. Os demais datasources são
catálogo. Concluir o cadastro abre uma sessão com a pessoa registrada e a
jornada zerada; entrar pelas credenciais de teste abre a sessão da persona de
demonstração. É o que permite as duas experiências descritas em 3.13 sem
duplicar tela nenhuma.

Ausência é representada por `null`, não por objeto vazio: `getNextCollection()`
e `getCurrentDonation()` devolvem tipos anuláveis, e é isso que aciona os
estados vazios.

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
| `session_mock_datasource.dart` | Sessão atual: perfil, agenda, doações e conquistas em uso |

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
| `/perfil` | Meu perfil | `Donor` |

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
dart analyze
```

```bash
flutter test
```

```bash
flutter build apk --debug
```

Resultado: análise estática sem nenhuma issue, **13 testes** passando e APK
gerado com sucesso.

Os testes cobrem a inicialização do app (splash → landing), os casos de uso
sobre os dados mockados (estatísticas, filtros de conteúdo e do mapa, login
válido e inválido, confirmação de coleta, publicação de depoimento) e o fluxo
de cadastro descrito em 3.13: o perfil passa a refletir os dados digitados, a
pessoa recém-cadastrada começa sem coleta e sem doações, agendar preenche a
agenda vazia, e o login com a conta de teste devolve a persona demo.

Dois deles são testes de widget sobre a propagação da agenda: o perfil exibe a
coleta recém-marcada (e o estado vazio quando não há nenhuma), e agendar em uma
aba atualiza o card do Início e a jornada da Minha Área ao voltar a elas.

> **Por que `dart analyze` e não `flutter analyze`?** O `flutter analyze`
> aborta neste diretório com `FormatException` no servidor de análise, pelo
> mesmo motivo que trava o Gradle: o acento em "3° ano". Copiando o projeto
> para um caminho sem acentos, o `flutter analyze` roda e reporta
> "No issues found!". O `dart analyze` aplica as mesmas regras do
> `analysis_options.yaml` (que inclui o `flutter_lints`) e funciona aqui.

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
