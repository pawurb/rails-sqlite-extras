# frozen_string_literal: true

module RailsSqliteExtras
  @@database_url = nil

  QUERIES = %i(
    compile_options
    index_size
    integrity_check
    pragma
    sequence_number
    table_size
    total_size
  )

  QUERIES.each do |query_name|
    define_singleton_method query_name do |options = {}|
      run_query(
        query_name: query_name,
        in_format: options.fetch(:in_format, :display_table),
      )
    end
  end

  def self.run_query(query_name:, in_format:)
    sql = sql_for(query_name: query_name)

    result = connection.execute(sql)

    self.display_result(
      result,
      title: self.description_for(query_name: query_name),
      in_format: in_format,
    )
  end

  def self.display_result(result, title:, in_format:)
    case in_format
    when :array
      result.values
    when :hash
      result.to_a
    when :raw
      result
    when :display_table
      headings = if result.count > 0
          result[0].keys
        else
          ["No results"]
        end

      puts Terminal::Table.new(
        title: title,
        headings: headings,
        rows: result.map(&:values),
      )
    else
      raise "Invalid in_format option"
    end
  end

  def self.sql_for(query_name:)
    File.read(
      sql_path_for(query_name: query_name)
    )
  end

  def self.description_for(query_name:)
    first_line = File.open(
      sql_path_for(query_name: query_name)
    ) { |f| f.readline }

    first_line[/\/\*(.*?)\*\//m, 1].strip
  end

  def self.sql_path_for(query_name:)
    File.join(File.dirname(__FILE__), "/rails_sqlite_extras/queries/#{query_name}.sql")
  end

  def self.connection
    if (db_url = ENV["RAILS_SQLITE_EXTRAS_DATABASE_URL"])
      ActiveRecord::Base.establish_connection(db_url).lease_connection
    else
      ActiveRecord::Base.connection
    end
  end

  def self.database_url=(value)
    @@database_url = value
  end

  def self.database_url
    @@database_url || ENV["RUBY_PG_EXTRAS_DATABASE_URL"] || ENV.fetch("DATABASE_URL")
  end
end

require "rails_sqlite_extras/railtie" if defined?(Rails)
