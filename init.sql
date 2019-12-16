create extension pgcrypto;

create function rand_int(max int) returns int as $$
  select floor(random() * max)::int + 1;
$$ language sql;

create function new_uuid() returns text as $$
  select replace(gen_random_uuid()::text, '-', '');
$$ language sql;

create function new_url62() returns text as $$
declare
  url62_id text := '';
  base text :=
    'abcdefghijklmnopqrstuvwxyz' ||
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ' ||
    '0123456789';
begin
  for index in 1..11 loop
    url62_id := url62_id || substr(base, rand_int(length(base)), 1);
  end loop;
  return url62_id;
end;
$$ language plpgsql;

create function updated_at_trigger() returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;
