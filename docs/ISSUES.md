# Issues / User Stories – Micro SaaS Cursos Online

Cada issue abaixo é uma história de usuário detalhada, derivada do plano do produto. Podem ser copiadas para o GitHub Issues ou outro tracker.

---

## Fase 1 – Fundação

### ISSUE-001: Autenticação – Registro de instrutor

**User story:**  
Como instrutor, quero me cadastrar na plataforma com email e senha, para que eu possa criar e gerenciar meus cursos.

**Descrição:**  
A plataforma deve oferecer uma tela de registro onde o usuário informa nome, email e senha. O sistema cria a conta (User), persiste com senha hasheada e redireciona para o dashboard. Não é necessário confirmação de email no MVP.

**Critérios de aceite:**
- [ ] Existe rota e página de registro (ex.: `/sign_up`).
- [ ] Formulário valida email único, senha com tamanho mínimo e confirmação de senha.
- [ ] Após registro, o usuário é logado automaticamente e redirecionado para a área logada.
- [ ] Senha é armazenada com hash (e.g. Bcrypt) via `phx.gen.auth` ou equivalente.
- [ ] Mensagens de erro claras para email já existente e validações de formulário.

**Notas técnicas:**  
Usar `mix phx.gen.auth` no course_core; contexto `Accounts`, schema `User`.

---

### ISSUE-002: Autenticação – Login do instrutor

**User story:**  
Como instrutor, quero fazer login com email e senha, para que eu acesse minha área de cursos.

**Descrição:**  
Tela de login com email e senha. Em caso de sucesso, sessão é criada e o usuário é redirecionado para o dashboard. Em caso de falha, mensagem genérica (ex.: “Email ou senha inválidos”) sem revelar se o email existe.

**Critérios de aceite:**
- [ ] Existe rota e página de login (ex.: `/log_in`).
- [ ] Login com credenciais válidas cria sessão e redireciona para dashboard.
- [ ] Login inválido exibe mensagem de erro sem indicar se o problema é email ou senha.
- [ ] Existe link “Esqueci minha senha” (pode levar a placeholder no MVP ou fluxo básico de reset).
- [ ] Usuário logado que acessa `/log_in` é redirecionado para o dashboard.

**Notas técnicas:**  
Sessão Phoenix; pipeline `:require_authenticated_user` para rotas do instrutor.

---

### ISSUE-003: Dashboard do instrutor – Listagem de cursos

**User story:**  
Como instrutor logado, quero ver a lista dos meus cursos na primeira tela após o login, para que eu saiba o que já criei e possa editar ou publicar.

**Descrição:**  
Após login, o instrutor cai em um dashboard que lista apenas os cursos de sua autoria. A listagem mostra título, status (rascunho/publicado) e ações rápidas (editar, ver página pública). Se não houver cursos, exibir mensagem e botão “Criar primeiro curso”.

**Critérios de aceite:**
- [ ] Rota protegida (ex.: `/dashboard` ou `/courses`) exige usuário logado.
- [ ] Listagem exibe apenas cursos do usuário logado.
- [ ] Para cada curso: título, status (rascunho/publicado), data de criação/atualização.
- [ ] Ações: “Editar” e “Ver página pública” (quando publicado).
- [ ] Estado vazio: mensagem amigável + CTA “Criar primeiro curso”.
- [ ] Botão ou link visível para “Criar novo curso”.

**Notas técnicas:**  
LiveView ou controller + view; contexto `Catalog` com `list_courses_by_user(user_id)`.

---

### ISSUE-004: CRUD de curso – Criar curso

**User story:**  
Como instrutor, quero criar um novo curso informando título, descrição e preço, para que eu possa depois adicionar módulos e aulas.

**Descrição:**  
Formulário para criação de curso: título (obrigatório), descrição (texto ou markdown), preço em reais (ou centavos no banco) e status inicial (rascunho). Ao salvar, o curso é criado e o usuário é redirecionado para a tela de edição do curso (onde poderá adicionar seções e aulas).

**Critérios de aceite:**
- [ ] Rota para “Novo curso” (ex.: `/courses/new`).
- [ ] Campos: título (obrigatório), descrição (opcional), preço (numérico, >= 0), status (rascunho/publicado).
- [ ] Validação: título não vazio; preço não negativo.
- [ ] Após criar, redirecionar para a página de edição do curso (ex.: `/courses/:id/edit`).
- [ ] Curso é associado ao usuário logado como dono.
- [ ] Flash de sucesso: “Curso criado com sucesso.”

**Notas técnicas:**  
Schema `Course` com `user_id`, `title`, `description`, `price_cents`, `status`; contexto `Catalog`.

---

### ISSUE-005: CRUD de curso – Editar curso

**User story:**  
Como instrutor, quero editar título, descrição, preço e status do meu curso, para que eu possa manter as informações corretas e publicar quando estiver pronto.

**Descrição:**  
Na tela de edição do curso, o instrutor pode alterar título, descrição, preço e status (rascunho/publicado). Apenas o dono do curso pode editar. Salvar persiste as alterações e exibe feedback.

**Critérios de aceite:**
- [ ] Rota de edição (ex.: `/courses/:id/edit`) protegida e restrita ao dono do curso.
- [ ] Formulário pré-preenchido com dados atuais do curso.
- [ ] Mesmas validações da criação (título, preço, status).
- [ ] Ao salvar, redirecionar para o mesmo curso ou para o dashboard com flash de sucesso.
- [ ] Retorno 404 ou “não autorizado” se o curso não existir ou não pertencer ao usuário.

**Notas técnicas:**  
`Catalog.get_course!(id)` com verificação de `user_id`; policy ou plug de autorização.

---

### ISSUE-006: CRUD de curso – Excluir curso (opcional no MVP)

**User story:**  
Como instrutor, quero poder excluir um curso que não quero mais oferecer, para que minha lista fique organizada.

**Descrição:**  
Na listagem ou na edição do curso, opção “Excluir curso”. Pode exigir confirmação (modal ou segunda tela). Ao excluir, o curso e dados dependentes (seções, aulas) são removidos ou soft-deleted conforme decisão de modelo.

**Critérios de aceite:**
- [ ] Ação “Excluir” visível apenas para o dono do curso.
- [ ] Confirmação antes de excluir (ex.: “Tem certeza? Esta ação não pode ser desfeita.”).
- [ ] Após exclusão, redirecionar para o dashboard e remover o curso da listagem.
- [ ] Se houver matrículas, definir comportamento: bloquear exclusão ou marcar curso como “arquivado”.

**Notas técnicas:**  
Decidir entre delete em cascata ou soft delete; considerar `Course.status = :archived`.

---

### ISSUE-007: Estrutura do curso – Seções (módulos)

**User story:**  
Como instrutor, quero organizar as aulas do meu curso em módulos (seções), para que o aluno siga uma ordem lógica (ex.: “Módulo 1 – Básico”, “Módulo 2 – Avançado”).

**Descrição:**  
Na tela de edição do curso, o instrutor pode adicionar, reordenar e editar seções. Cada seção tem título e ordem (position). As aulas são vinculadas a uma seção. Listagem em ordem de `position`.

**Critérios de aceite:**
- [ ] Na página do curso (edição), é possível adicionar uma seção com título.
- [ ] Seções exibidas em ordem (campo `position` ou `order`).
- [ ] Editar título da seção inline ou em formulário.
- [ ] Remover seção (com confirmação se houver aulas dentro).
- [ ] Reordenar seções (setas para cima/baixo ou drag-and-drop).

**Notas técnicas:**  
Schema `Section` com `course_id`, `title`, `position`; contexto `Catalog`.

---

### ISSUE-008: Estrutura do curso – Aulas tipo link (URL)

**User story:**  
Como instrutor, quero adicionar aulas que são apenas um link (ex.: vídeo no YouTube/Vimeo), para que o aluno seja direcionado ao conteúdo externo após a compra.

**Descrição:**  
Dentro de uma seção, o instrutor adiciona uma “aula” do tipo link: título e URL. O sistema valida URL (formato) e armazena. Na área do aluno, a aula será exibida como título + botão/link que abre a URL em nova aba.

**Critérios de aceite:**
- [ ] Na seção, botão “Adicionar aula” com opção “Link”.
- [ ] Campos: título (obrigatório), URL (obrigatório, formato válido).
- [ ] Aula salva com `type: :link` e `source_url` (ou equivalente).
- [ ] Ordenação de aulas dentro da seção (position).
- [ ] Editar e remover aula tipo link.
- [ ] Na área do aluno (Fase 2), exibir título e link que abre em nova aba.

**Notas técnicas:**  
Schema `Lesson` com `section_id`, `title`, `type` (enum: `:link`, `:attachment`), `source_url` (para link), `position`.

---

### ISSUE-009: Estrutura do curso – Aulas tipo anexo (placeholder para upload)

**User story:**  
Como instrutor, quero poder marcar uma aula como “arquivo para download”, para que na Fase 3 eu possa fazer upload de PDFs ou outros arquivos.

**Descrição:**  
No MVP, permitir criar uma aula do tipo “anexo” com apenas título e, opcionalmente, um placeholder (ex.: “Arquivo será disponibilizado em breve” ou campo de URL temporário). O fluxo de upload real e armazenamento S3 será implementado na Fase 3.

**Critérios de aceite:**
- [ ] Na seção, opção “Adicionar aula” → “Anexo”.
- [ ] Campo título obrigatório; sem upload ainda (ou campo URL temporário para link de arquivo externo).
- [ ] Aula salva com `type: :attachment`; se houver URL temporária, armazenar em campo (ex.: `attachment_url`).
- [ ] Na área do aluno, exibir título e mensagem “Download em breve” ou link se houver URL.
- [ ] Ordenação e edição/remoção consistentes com aulas tipo link.

**Notas técnicas:**  
`Lesson.type = :attachment`; campo `attachment_url` nullable; Fase 3 substituirá por upload + S3.

---

## Fase 2 – Pagamento e área do aluno

### ISSUE-010: Página pública do curso (landing para compra)

**User story:**  
Como visitante, quero ver a página pública de um curso com título, descrição e preço, para que eu decida se quero comprar.

**Descrição:**  
URL pública (ex.: `/cursos/:slug` ou `/courses/:id`) exibe informações do curso: título, descrição, preço e botão “Comprar”. Apenas cursos com status “publicado” são acessíveis; rascunho retorna 404 ou “não encontrado”. Não exige login.

**Critérios de aceite:**
- [ ] Rota pública sem autenticação.
- [ ] Exibe título, descrição formatada e preço formatado (ex.: R$ 97,00).
- [ ] Botão “Comprar” visível.
- [ ] Curso em rascunho não deve ser acessível por URL pública (404 ou redirect).
- [ ] Slug ou ID na URL; se usar slug, garantir unicidade por usuário ou global.

**Notas técnicas:**  
Controller ou LiveView público; `Catalog.get_published_course_by_slug!/1` ou `get!/1` com filtro `status: :published`.

---

### ISSUE-011: Checkout – Integração Stripe (pagamento)

**User story:**  
Como visitante, quero clicar em “Comprar” e ser levado a um fluxo de pagamento seguro (Stripe), para que eu pague pelo curso com cartão ou outro método.

**Descrição:**  
Ao clicar “Comprar”, o sistema cria uma sessão de checkout do Stripe (Checkout Session ou Payment Link) com o preço do curso, descrição e metadados (course_id, email do comprador se informado). O usuário é redirecionado para o Stripe e, após pagamento bem-sucedido, o Stripe redireciona de volta para uma URL de sucesso e dispara um webhook.

**Critérios de aceite:**
- [ ] Botão “Comprar” envia o usuário para o Stripe Checkout (ou Payment Link).
- [ ] Preço e nome do produto no Stripe refletem o curso.
- [ ] Metadados da sessão incluem `course_id` (e opcionalmente email).
- [ ] Após pagamento, redirecionamento para URL configurável (ex.: `/obrigado` ou `/acesso?token=...`).
- [ ] Em caso de cancelamento no Stripe, redirecionar para a página do curso com mensagem opcional.

**Notas técnicas:**  
Stripe API (Checkout Session); guardar `payment_intent_id` ou `session_id` para idempotência no webhook.

---

### ISSUE-012: Webhook Stripe – Criar matrícula ao confirmar pagamento

**User story:**  
Como sistema, quero que ao receber a confirmação de pagamento do Stripe seja criada automaticamente a matrícula do aluno no curso, para que ele possa acessar o conteúdo.

**Descrição:**  
Endpoint de webhook do Stripe (ex.: `POST /webhooks/stripe`) recebe o evento `checkout.session.completed` (ou equivalente). O payload contém o email do comprador e os metadados (course_id). O sistema cria um registro de Enrollment (curso + email do comprador + token de acesso único) e opcionalmente um registro em Payments. Deve ser idempotente (não criar matrícula duplicada para o mesmo session_id ou payment_intent_id).

**Critérios de aceite:**
- [ ] Webhook assinado e verificado com o Stripe signing secret.
- [ ] Tratamento do evento de pagamento concluído; extrair email e course_id dos metadados.
- [ ] Criar Enrollment (course_id, email, token único, data).
- [ ] Opcional: criar registro em tabela Payments (valor, status, referência externa).
- [ ] Idempotência: não criar segunda matrícula para o mesmo pagamento.
- [ ] Resposta 200 para o Stripe após processamento correto; 4xx/5xx em falha para retry.

**Notas técnicas:**  
Plug para verificar `Stripe-Signature`; contexto `Learning` com `create_enrollment_from_payment/1`; job assíncrono (Oban) opcional para não travar o webhook.

---

### ISSUE-013: Envio de email com link de acesso (pós-compra)

**User story:**  
Como aluno, quero receber um email após a compra com o link para acessar o curso, para que eu não dependa de guardar a URL na hora do redirecionamento.

**Descrição:**  
Após criar a Enrollment no webhook (ou em fluxo síncrono), o sistema envia um email ao comprador com um link único (ex.: `/acesso?token=...` ou `/minhas-aulas?token=...`) que identifica a matrícula. O link pode expirar após X dias ou ser permanente no MVP. O email deve conter nome do curso e instruções claras.

**Critérios de aceite:**
- [ ] Após criar Enrollment, disparar envio de email (Resend, SendGrid ou similar).
- [ ] Email contém: nome do curso, link de acesso com token único, texto amigável.
- [ ] Link abre a página “Minhas aulas” já com o curso liberado (token validado).
- [ ] Tratamento de falha de envio (log; opcional: retry via job).
- [ ] Configuração de remetente e provedor de email em config/runtime.

**Notas técnicas:**  
Biblioteca de email (Bamboo, Swoosh); template de email; token em Enrollment (único, indexado).

---

### ISSUE-014: Área do aluno – Acessar conteúdo por token (minhas aulas)

**User story:**  
Como aluno, quero abrir o link que recebi por email e ver a lista de módulos e aulas do curso que comprei, para que eu possa assistir e baixar o conteúdo.

**Descrição:**  
Página acessível por URL com token (ex.: `/acesso?token=...`). O token está associado a uma Enrollment. A página lista o curso, suas seções e aulas. Aula tipo link: exibe título e botão “Abrir link” (nova aba). Aula tipo anexo: exibe título e “Download” (ou “Em breve” se ainda não houver arquivo). Não exige login no MVP; o token é o fator de autenticação.

**Critérios de aceite:**
- [ ] Rota pública que aceita `token` (query param ou path).
- [ ] Token válido exibe: nome do curso, seções ordenadas, aulas ordenadas por tipo (link ou anexo).
- [ ] Aula link: botão/link que abre a URL em nova aba.
- [ ] Aula anexo: link de download se houver arquivo; caso contrário mensagem “Em breve”.
- [ ] Token inválido ou expirado: mensagem clara e sugestão de contato ou reenvio.
- [ ] Opcional: exibir “Você está logado como [email]” se o token estiver vinculado a um email.

**Notas técnicas:**  
`Learning.get_enrollment_by_token/1`; LiveView ou controller + view; policy de expiração do token (opcional no MVP).

---

## Fase 3 – Upload de arquivos

### ISSUE-015: Configuração de storage S3-compatível

**User story:**  
Como desenvolvedor/operador, quero que a aplicação use um bucket S3 (ou compatível) para armazenar arquivos de aula, para que os downloads sejam escaláveis e seguros.

**Descrição:**  
Configurar integração com S3 (AWS ou MinIO em dev): variáveis de ambiente para bucket, região e credenciais. Biblioteca (ex.: ex_aws) configurada; função helper para upload e geração de URL (pública ou assinada). Em desenvolvimento, pode-se usar MinIO no Docker Compose.

**Critérios de aceite:**
- [ ] Config em `config/runtime.exs` ou `config/config.exs` para bucket, região e credenciais.
- [ ] Função (ou contexto) que faz upload de arquivo e retorna chave/URL.
- [ ] Opção de URL assinada (temporária) para download seguro.
- [ ] Documentação no README ou em docs sobre variáveis necessárias e uso do MinIO em dev.
- [ ] Opcional: MinIO no `compose.yml` para desenvolvimento local.

**Notas técnicas:**  
`ex_aws` + `ex_aws_s3`; policy de bucket (leitura pública ou apenas URLs assinadas).

---

### ISSUE-016: Aula tipo anexo – Upload de arquivo pelo instrutor

**User story:**  
Como instrutor, quero fazer upload de um arquivo (ex.: PDF) para uma aula do tipo anexo, para que o aluno possa baixar o material após a compra.

**Descrição:**  
Na edição da aula tipo “anexo”, o instrutor pode enviar um arquivo (MVP: um arquivo por aula; tipos permitidos: ex.: PDF, DOC, tamanho máximo definido). O arquivo é enviado ao S3 e a chave/URL é salva no registro da aula (Lesson). Substituir o placeholder da ISSUE-009 pelo fluxo real de upload.

**Critérios de aceite:**
- [ ] Na edição da aula tipo anexo, campo de upload de arquivo (ou substituir URL temporária).
- [ ] Validação: tipo de arquivo (whitelist) e tamanho máximo (ex.: 10 MB).
- [ ] Upload para S3; persistir chave ou URL no `Lesson` (ex.: `attachment_key` ou `attachment_url`).
- [ ] Mensagem de sucesso; possível preview ou nome do arquivo exibido.
- [ ] Opção de “remover arquivo” e substituir por outro.
- [ ] Na área do aluno, link de download usando URL assinada (ou pública conforme política).

**Notas técnicas:**  
`Lesson.attachment_key` ou `attachment_url`; LiveView com upload (Phoenix.LiveView.upload); ex_aws S3 put_object e presign.

---

### ISSUE-017: Área do aluno – Download seguro do anexo

**User story:**  
Como aluno, quero baixar o arquivo da aula (PDF ou outro) por um link que funcione apenas por um tempo, para que eu acesse o material sem que o link vaze para terceiros.

**Descrição:**  
Na página “Minhas aulas”, para cada aula tipo anexo que possui arquivo, exibir um botão “Baixar”. O clique não expõe a URL interna do S3; o backend gera uma URL assinada (presigned) com validade limitada (ex.: 15 minutos) e redireciona o usuário para ela, permitindo o download. O token da matrícula já garante que apenas quem tem acesso ao curso pode solicitar o link.

**Critérios de aceite:**
- [ ] Botão “Baixar” só aparece para aula anexo com arquivo e para usuário com token válido (Enrollment).
- [ ] Ao clicar, o backend gera URL assinada (presigned) do S3 com expiração (ex.: 15 min).
- [ ] Redirecionamento HTTP para a URL assinada ou resposta que inicia o download.
- [ ] Não expor chave do S3 ou URL permanente na interface do cliente.
- [ ] Tratamento de erro (arquivo não encontrado, bucket indisponível) com mensagem amigável.

**Notas técnicas:**  
Endpoint ou LiveView callback que chama `S3.presign_get/2`; redirect ou `conn |> redirect(external: signed_url)`.

---

## Decisões e melhorias futuras (backlog)

### ISSUE-018: Conta do aluno (login para “Meus cursos”)

**User story:**  
Como aluno, quero ter uma conta e fazer login, para que eu veja todos os meus cursos em um único lugar e não dependa apenas do link por email.

**Descrição:**  
Estender o modelo de User para “aluno” (ou mesmo usuário que pode comprar). Após compra, opção de “Criar conta” com o email usado; ou registro antes da compra. Área “Meus cursos” lista todas as matrículas do usuário logado. Pode ser pós-MVP.

**Critérios de aceite:** (resumido)  
- [ ] Aluno pode se registrar com email (e senha); ou vínculo automático quando paga com email.  
- [ ] Login como aluno; página “Meus cursos” lista cursos comprados.  
- [ ] Acesso às aulas pelo mesmo fluxo de conteúdo, mas identificado por user_id + course_id em vez de só token.

---

### ISSUE-019: Recuperação de senha (instrutor)

**User story:**  
Como instrutor, quero redefinir minha senha por email quando esquecê-la, para que eu possa voltar a acessar minha conta.

**Descrição:**  
Fluxo “Esqueci minha senha”: usuário informa email; sistema envia link com token de reset com validade (ex.: 1 h). Página de nova senha valida o token e atualiza a senha. Pode ser implementado com `phx.gen.auth` (já gera os arquivos de reset) ou em issue dedicada.

**Critérios de aceite:** (resumido)  
- [ ] Rota “Esqueci minha senha” e envio de email com link.  
- [ ] Link contém token único e expirável.  
- [ ] Página “Nova senha” valida token e persiste nova senha; invalida o token após uso.

---

### ISSUE-020: Emails transacionais – Reenvio de link de acesso

**User story:**  
Como aluno, quero poder solicitar o reenvio do link de acesso ao curso, para que eu recupere o acesso se perdi o email.

**Descrição:**  
Página pública “Não encontrou o email? Informe seu email e o nome do curso” (ou seleção do curso). Sistema verifica se existe Enrollment com aquele email para o curso e reenvia o email com o link de acesso. Rate limit para evitar abuso.

**Critérios de aceite:** (resumido)  
- [ ] Formulário com email e identificação do curso (nome ou slug).  
- [ ] Se existir matrícula, reenviar email com link; senão, mensagem genérica (“Se existir matrícula, você receberá o link”).  
- [ ] Limite de tentativas por IP ou por email (ex.: 3 por hora).

---

## Resumo por fase

| Fase | Issues |
|------|--------|
| 1 – Fundação | 001 a 009 |
| 2 – Pagamento e aluno | 010 a 014 |
| 3 – Upload | 015 a 017 |
| Backlog | 018 a 020 |

Cada issue acima pode ser copiada para o GitHub (ou outro tracker) como uma issue com título, descrição e critérios de aceite. A numeração (ISSUE-001, etc.) pode ser substituída pela numeração nativa do tracker.
