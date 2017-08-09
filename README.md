# postgram_raidexes

## *Post*(gres) (Tri)*gram* *Rai*(ls) (In)*dexes*

This gem adds [trigram](https://www.postgresql.org/docs/current/static/pgtrgm.html) index support to Rails' [`SchemaDumper`](http://edgeguides.rubyonrails.org/active_record_migrations.html#schema-dumping-and-you).

This repo gemifies code from [GitLab EE](https://gitlab.com/gitlab-org/gitlab-ee), specifically, [this commit](https://gitlab.com/gitlab-org/gitlab-ee/commit/70bf6dc702b6354c3a00d0b81e7d7c10be25ffb8).

Currently supports Rails `4.1` and `4.2`. Note that Rails 5 now has [native support](https://github.com/rails/rails/pull/23393).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postgram_raidexes', git: 'https://github.com/nulogy/postgram_raidexes'
```

And then execute:

    $ bundle

## Usage

1. In a migration, enable the `pg_trgm` extension in postgres:
 ```ruby
  class EnableTrigramExtension < ActiveRecord::Migration
    def up
      enable_extension :pg_trgm
    end
    ...
  end
 ```

2. Add a trigram index to a text field:

 ```ruby
   def up
     add_index "users", ["email"], name: "index_users_on_email_trigram", using: :gin, opclasses: {"email"=>"gin_trgm_ops"}
   end

   def down
     remove_index "users", name: "index_users_on_email_trigram"
   end
 ```

3. Run the migration:

 ```
  $ rake db:migrate
 ```

4. And you should the `add_index` statement from Step 2 in your `schema.rb`:

 ```ruby
  add_index "users", ["email"], name: "index_users_on_email_trigram", using: :gin, opclasses: {"email"=>"gin_trgm_ops"}
 ```

## TODO

- [ ] add to RubyGems
- [ ] setup TravisCI
- [ ] add note on `DROP EXTENSION pg_trgm CASCADE` when removing trigram support
- [ ] support `gist` indexes
- [ ] investigate extending `SchemaDumper` (Module.prepend or a Refinement) rather than monkeypatching

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

There is a test application in `spec/support/test_app` (Rails 4.2) that the current tests run against. It contains a simple `User` model with a couple simple trigram indexes. The specs migrate this application, then check its `db/schema.rb` file for the expected `add_index` statements.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nulogy/postgram_raidexes.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
