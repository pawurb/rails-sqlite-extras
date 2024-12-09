# Rails Sqlite Extras [![Gem Version](https://badge.fury.io/rb/rails-sqlite-extras.svg)](https://badge.fury.io/rb/rails-sqlite-extras) [![GH Actions](https://github.com/pawurb/rails-sqlite-extras/actions/workflows/ci.yml/badge.svg)](https://github.com/pawurb/rails-sqlite-extras/actions)

Copy/paste of [ecto_sqlite3_extras](https://github.com/orsinium-labs/ecto_sqlite3_extras). Helper queries available in Ruby and Rails rake tasks providing insights into the Sqlite database.

## Installation

`Gemfile`
```bash
gem "rails-sqlite-extras"
```

Some queries use `dbstat` table. You have to use [sqlite3 gem](https://github.com/sparklemotion/sqlite3-ruby) with version `>= 2.3.0` because it has this feature enabled by default:

`Gemfile`

```ruby
gem "sqlite3", "~> 2.3"
```

Alternatively, if you're stuck on lower version, you have to enable `dbstat` by setting a `SQLITE_ENABLE_DBSTAT_VTAB` compile flag:

```bash
bundle config set force_ruby_platform true
bundle config set build.sqlite3 "--with-sqlite-cflags='-DSQLITE_ENABLE_DBSTAT_VTAB=1'"
```

## Available queries

### `total_size`

```bash
rake sqlite_extras:total_size
```

```ruby
RailsSqliteExtras.total_size
```

The total size of all tables and indices. It's a summary table, it has only 2 columns: `name` and `value`. Rows:

- `cells`: The number of cells in the DB. Each value stored in the DB is represented as at least one cell. So, the number of cells correlates with the number of records in the DB.
- `payload_size`: How much space the actual useful payload takes in the DB.
- `unused_size`: How much space in the DB is reserved, not used yet, and can be used later to store more data. This is a surplus that occurs because SQLite allocates space for data in chunks ("pages").
- `vacuum_size`: How much space is unused and cannot be used for future data. You can run [VACUUM](https://www.sqlite.org/lang_vacuum.html) command to reduce it.
- `page_size`: The total space occupied by all pages. Each page is a single chunk of space allocated by SQLite. This number is the sum of `payload_size`, `unused_size`, and `vacuum_size`.
- `pages`: The total number of pages.
- `pages: leaf`: The pages that store the actual data. Read [SQLite Internals: Pages & B-trees](https://fly.io/blog/sqlite-internals-btree/) to learn more.
- `pages: internal`: The pages that store ranges for leaf pages for a faster lookup. Sometimes also called "interior pages".
- `pages: overflow`: The pages that store chunks of big data that don't fit in a single leaf page.
- `pages: table`: The pages used for storing data for tables.
- `pages: index`: The pages used for storing indices.

### `table_size`

```bash
rake sqlite_extras:table_size
```

```ruby
RailsSqliteExtras.table_size
```

Information about the space used (and unused) by all tables. Based on the [dbstat](https://www.sqlite.org/dbstat.html) virtual table.

- `name`: The table name.
- `payload_size`.
- `unused_size`.
- `vacuum_size`.
- `page_size`.
- `cells`.
- `pages`.
- `max_payload_size`: The size of the biggest payload in the table.

### `index_size`

```bash
rake sqlite_extras:index_size
```

```ruby
RailsSqliteExtras.index_size
```

Size of all indices.

- `name`: The index name.
- `table_name`: The table where the index is defined.
- `column_name`: The name of the column being indexed. This column is NULL if the column is the rowid or an expression.
- `payload_size`.
- `unused_size`.
- `page_size`.
- `cells`.
- `pages`.
- `max_payload_size`.

### `sequence_number`

```bash
rake sqlite_extras:sequence_number
```

```ruby
RailsSqliteExtras.sequence_number
```

Sequence numbers of autoincrement columns. Generated based on the [sqlite_sequence](https://renenyffenegger.ch/notes/development/databases/SQLite/internals/schema-objects/sqlite_sequence) table. The query will fail if there are no autoincrement columns in the DB yet.

- `table_name`.
- `sequence_number`.

### `pragma`

```bash
rake sqlite_extras:pragma
```

```ruby
RailsSqliteExtras.pragma
```

List values of PRAGMAs (settings). Only includes the ones that have an integer or a boolean value. For brevity, the ones with the `0` (`false`) value are excluded from the output (based on the observation that this is the default value for most of the PRAGMAs). Check out the SQLite documentation to learn more about what each PRAGMA means: [PRAGMA Statements](https://www.sqlite.org/pragma.html).

- `name`: the name of the PRAGMA as listed in the SQLite documentation.
- `value`: the value of the PRAGMA. The `true` value is converted into `1` (and `false` is simply excluded).

### `compile_options` 

```bash
rake sqlite_extras:compile_options
```

```ruby
RailsSqliteExtras.compile_options
```

List the [compile-time options](https://www.sqlite.org/compile.html) used when building SQLite, one option per row. The "SQLITE_" prefix is omitted from the returned option names. See [exqlite docs](https://github.com/elixir-sqlite/exqlite#defining-extra-compile-flags) on how to change these options.

### `integrity_check`

```bash
rake sqlite_extras:integrity_check
```

```ruby
RailsSqliteExtras.integrity_check
```

Run integrity checks on the database. Executes [PRAGMA integrity_check](https://www.sqlite.org/pragma.html#pragma_integrity_check) and returns the resulting messages.