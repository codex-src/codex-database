create table users (
  user_id               text        not null unique default new_url62(),
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now(),
  username              text        not null unique check ( username ~ '^[a-zA-Z_]\w{2,19}$' ),
  password_hash         bytea       not null,
  passcode              text        not null check ( passcode ~ '^\d{4}$') );

create table sessions (
  user_id               text        not null references users ( user_id ),
  session_id            uuid        not null unique default gen_random_uuid(),
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now(),
  expires_at            timestamptz not null,
  revoked_at            timestamptz     null );

create table billing (
  user_id               text        not null references users ( user_id ),
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now(),
  charge_month          boolean     not null,
  stripe_card_id        text        not null,
  stripe_card_brand     text        not null,
  stripe_card_last_four text        not null check ( stripe_card_last_four ~ '^\d{4}$' ),
  auto_renew            boolean     not null default true );

create table subscriptions (
  user_id               text        not null references users ( user_id ),
  subscription_id       text        not null unique default new_uuid(),
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now(),
  charge_month          boolean     not null,
  start_date            timestamptz not null,
  end_date              timestamptz not null,
  stripe_charge_id      text        not null,
  stripe_charge_amount  int         not null,
  stripe_card_brand     text        not null,
  stripe_card_last_four text        not null check ( stripe_card_last_four ~ '^\d{4}$') );

create table notes (
  user_id               text        not null references users ( user_id ),
  note_id               text        not null unique default new_uuid(),
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now(),
  title_utf8_count      int         not null check ( title_utf8_count <= 100 ),
  title                 text        not null,
  data_utf8_count       int         not null check ( data_utf8_count <= 10e3 ),
  data                  text        not null );
