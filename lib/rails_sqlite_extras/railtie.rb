# frozen_string_literal: true

class RailsSqliteExtras::Railtie < Rails::Railtie
  rake_tasks do
    load "rails_sqlite_extras/tasks/all.rake"
  end
end
