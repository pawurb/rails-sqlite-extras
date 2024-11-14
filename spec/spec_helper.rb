# frozen_string_literal: true

require "rubygems"
require "bundler/setup"
require "active_record"
require_relative "../lib/rails-sqlite-extras"

RSpec.configure do |config|
  config.before :suite do
  end

  config.after :suite do
  end
end
