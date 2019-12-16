create trigger users_updated_at_trigger
  before update on users
    for each row execute procedure updated_at_trigger();

create trigger sessions_updated_at_trigger
  before update on sessions
    for each row execute procedure updated_at_trigger();

create trigger billing_updated_at_trigger
  before update on billing
    for each row execute procedure updated_at_trigger();

create trigger subscriptions_updated_at_trigger
  before update on subscriptions
    for each row execute procedure updated_at_trigger();

create trigger notes_updated_at_trigger
  before update on notes
    for each row execute procedure updated_at_trigger();
