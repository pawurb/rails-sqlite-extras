# frozen_string_literal: true

require "rubygems"
require "bundler/setup"
require "active_record"
require_relative "../lib/rails-sqlite-extras"

RSpec.configure do |config|
  config.before :suite do
    ENV["RAILS_SQLITE_EXTRAS_DATABASE_URL"] = "sqlite3://#{Dir.pwd}/test.db"
  end

  config.after :suite do
  end
end
