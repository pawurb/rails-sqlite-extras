# frozen_string_literal: true

require "rails-sqlite-extras"

namespace :sqlite_extras do
  RailsSqliteExtras::QUERIES.each do |query_name|
    desc RailsSqliteExtras.description_for(query_name: query_name)
    task query_name.to_sym => :environment do
      RailsSqliteExtras.public_send(query_name)
    end
  end
end
