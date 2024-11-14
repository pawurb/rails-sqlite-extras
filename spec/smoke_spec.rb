# frozen_string_literal: true

require "spec_helper"
require "rails-sqlite-extras"

describe RailsSqliteExtras do
  it "works" do
    expect(RailsSqliteExtras.hello).to eq("there")
  end
end
