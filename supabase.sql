-- ═══════════════════════════════════════════════════════════════
--  Tabla de sincronización para la app de calistenia.
--  Pégalo entero en Supabase → SQL Editor → Run.
--  Solo hay que ejecutarlo UNA vez.
-- ═══════════════════════════════════════════════════════════════

create table if not exists calistenia (
  perfil      text primary key,
  data        jsonb       not null,
  updated_at  timestamptz not null default now()
);

alter table calistenia enable row level security;

-- La política se aplica al rol "anon" de Postgres, que es el que usa la app
-- tanto con la clave publishable nueva (sb_publishable_...) como con la
-- clave anon antigua. No hay que cambiar nada según el tipo de clave.
--
-- Cualquiera que tenga tu URL y tu clave puede leer y escribir esta tabla,
-- así que no las publiques. Para dos personas es suficiente; si algún día
-- queréis algo más cerrado, habría que añadir autenticación de usuarios.

drop policy if exists "acceso con clave publica" on calistenia;

create policy "acceso con clave publica"
  on calistenia
  for all
  to anon
  using (true)
  with check (true);
