# KABUCULA — Empresa Mineira

Website institucional estático para GitHub Pages, com painel administrativo em `admin.html` e base de dados/autenticação no Supabase.

## Configuração necessária (gratuita para começar)

1. Criar um projecto no Supabase.
2. Em **SQL Editor**, executar todo o conteúdo de `supabase-schema.sql`.
3. Em **Authentication > Settings**, desactivar o registo público de novos utilizadores.
4. Em **Authentication > Users**, criar o utilizador administrativo com email e palavra-passe fortes.
5. Em **Project Settings > API**, copiar o **Project URL** e a chave **anon/public**.
6. Editar `supabase-config.js` e substituir os dois textos `COLOQUE_AQUI...` pelos valores copiados. A chave anon/public é própria para uso no browser com RLS; nunca colocar a chave service_role no site.
7. Em GitHub, confirmar **Settings > Pages > Build and deployment > Source: GitHub Actions**.

## Administração

Depois da publicação, abrir `https://gideaonauegi-png.github.io/kabucula/admin.html` e entrar com o utilizador criado no Supabase.

O painel permite criar, editar e eliminar projectos, notícias, vagas, imagens e informações. As imagens são guardadas no bucket público `kabucula-media`.

## Segurança

- Não activar registo público de utilizadores.
- Nunca publicar a chave `service_role`.
- Manter RLS activo. O SQL disponibilizado permite leitura pública apenas de conteúdos publicados e gestão por utilizadores autenticados. Criar apenas contas administrativas de confiança.
- Plano gratuito tem limites de utilização e pode estar sujeito a suspensão/pausa por inactividade conforme as condições do fornecedor.

## Nota

O GitHub Pages aloja o frontend. Supabase fornece autenticação, base de dados e armazenamento de imagens. Não é necessário PHP ou servidor próprio.
