module PostgramRaidexes
  class Railtie < Rails::Railtie
    initializer "postgram_raidexes.postgresql_overrides" do
      require "postgram_raidexes/pg_opclass_support" if using_postgresql?
    end

    def using_postgresql?
      ActiveRecord::Base.configurations[Rails.env]['adapter'].casecmp('postgresql').zero?
    end
  end
end