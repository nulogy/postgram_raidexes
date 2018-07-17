module PostgramRaidexes
  class Railtie < Rails::Railtie
    initializer "postgram_raidexes.postgresql_overrides" do
      break unless using_postgresql?

      rails_version = Rails::VERSION::STRING

      if rails_version.start_with?("4.1")
        require "postgram_raidexes/pg_opclass_support_rails_41"
      elsif rails_version.start_with?("4.2")
        require "postgram_raidexes/pg_opclass_support_rails_42"
      elsif rails_version.start_with?("5.0")
        require "postgram_raidexes/pg_opclass_support_rails_50"
      else
        raise "Only Rails 4.1, 4.2 and 5.0 are supported at this time"
      end
    end

    def using_postgresql?
      ActiveRecord::Base.configurations[Rails.env]['adapter'].casecmp('postgresql').zero?
    end
  end
end