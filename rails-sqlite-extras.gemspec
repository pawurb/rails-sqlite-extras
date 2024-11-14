# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_sqlite_extras/version"

Gem::Specification.new do |s|
  s.name = "rails-sqlite-extras"
  s.version = RailsSqliteExtras::VERSION
  s.authors = ["pawurb"]
  s.email = ["contact@pawelurbanek.com"]
  s.summary = %q{ Rails Sqlite database insights. }
  s.description = %q{ Helper queries providing insights into the Sqlite database for Rails apps. }
  s.homepage = "http://github.com/pawurb/rails-sqlite-extras"
  s.files = `git ls-files`.split("\n").reject { |f| f.match?(/\.db$/) }
  s.test_files = s.files.grep(%r{^(spec)/})
  s.require_paths = ["lib"]
  s.license = "MIT"
  s.add_dependency "rails"
  s.add_dependency "sqlite3"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rufo"

  if s.respond_to?(:metadata=)
    s.metadata = { "rubygems_mfa_required" => "true" }
  end
end
