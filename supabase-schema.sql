-- KABUCULA: executar este SQL no Supabase > SQL Editor.
-- Antes de criar utilizadores, desactive o registo público em Authentication > Settings.
create table if not exists public.content_items (
  id uuid primary key default gen_random_uuid(),
  type text not null check (type in ('project','news','job','gallery','info')),
  title text not null,
  body text not null default '',
  image_url text,
  published boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.content_items enable row level security;
drop policy if exists "Public can read published content" on public.content_items;
create policy "Public can read published content" on public.content_items
for select using (published = true);
drop policy if exists "Authenticated admins manage content" on public.content_items;
create policy "Authenticated admins manage content" on public.content_items
for all to authenticated using (true) with check (true);

-- Bucket público para imagens que aparecem no website.
insert into storage.buckets (id, name, public)
values ('kabucula-media', 'kabucula-media', true)
on conflict (id) do update set public = true;

drop policy if exists "Public read KABUCULA media" on storage.objects;
create policy "Public read KABUCULA media" on storage.objects
for select using (bucket_id = 'kabucula-media');
drop policy if exists "Admins upload KABUCULA media" on storage.objects;
create policy "Admins upload KABUCULA media" on storage.objects
for insert to authenticated with check (bucket_id = 'kabucula-media');
drop policy if exists "Admins update KABUCULA media" on storage.objects;
create policy "Admins update KABUCULA media" on storage.objects
for update to authenticated using (bucket_id = 'kabucula-media') with check (bucket_id = 'kabucula-media');
drop policy if exists "Admins delete KABUCULA media" on storage.objects;
create policy "Admins delete KABUCULA media" on storage.objects
for delete to authenticated using (bucket_id = 'kabucula-media');
