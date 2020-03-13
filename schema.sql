create table users (
  user_id        text        not null unique,
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now(),
  email          text        not null,
  email_verified boolean     not null,
  auth_provider  text        not null,
  photo_url      text        null,
  display_name   text        null,
  username       text        null     unique check ( username ~ '^[a-zA-Z_]\w{2,19}$' )
);

create table notes (
  user_id        text        not null references users ( user_id ),
  note_id        text        not null unique,
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now(),
  data           text        not null
);
