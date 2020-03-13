create function updated_at_trigger() returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger users_updated_at_trigger
  before update on users
    for each row execute procedure updated_at_trigger();

create trigger notes_updated_at_trigger
  before update on notes
    for each row execute procedure updated_at_trigger();
