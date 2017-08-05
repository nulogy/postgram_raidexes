# postgram_raidexes

## *Post*(gres) (Tri)*gram* *Rai*(ls) (In)*dexes*

This gem adds [trigram](https://www.postgresql.org/docs/current/static/pgtrgm.html) index support to Rails [`SchemaDumper`](http://edgeguides.rubyonrails.org/active_record_migrations.html#schema-dumping-and-you).

This repo gemifies code from [GitLab EE](https://gitlab.com/gitlab-org/gitlab-ee), specifically, [this commit](https://gitlab.com/gitlab-org/gitlab-ee/commit/70bf6dc702b6354c3a00d0b81e7d7c10be25ffb8).

Currently supports Rails `4.x`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postgram_raidexes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install postgram_raidexes

## TODO

- [x] add Rails 4.2 support
- [ ] add Rails 4.1 support
- [ ] add note on `DROP EXTENSION pg_trgm CASCADE` when removing trigram support
- [ ] investigate extending `SchemaDumper`, rather than monkeypatching

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
     ...
   end
 ```

3. Run the migration:

 ```
  $ rake db:migrate
 ```

4. And you should the `add_index` statement from Step 2 in `schema.rb`:

 ```ruby
  add_index "users", ["email"], name: "index_users_on_email_trigram", using: :gin, opclasses: {"email"=>"gin_trgm_ops"}
 ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/postgram_raidexes.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
