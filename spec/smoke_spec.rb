# frozen_string_literal: true

require "spec_helper"
require "rails-sqlite-extras"

describe RailsSqliteExtras do
  RailsSqliteExtras::QUERIES.each do |query_name|
    it "#{query_name} description can be read" do
      expect do
        RailsSqliteExtras.description_for(
          query_name: query_name,
        )
      end.not_to raise_error
    end
  end

  RailsSqliteExtras::QUERIES.reject { |q| q == :kill_all }.each do |query_name|
    it "#{query_name} query can be executed" do
      expect do
        RailsSqliteExtras.run_query(
          query_name: query_name,
          in_format: :display_table,
        )
      end.not_to raise_error
    end
  end
end
