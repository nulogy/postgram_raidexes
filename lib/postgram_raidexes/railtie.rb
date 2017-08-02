module PostgramRaidexes
  class Railtie < Rails::Railtie
    initializer "postgram_raidexes.postgresql_overrides" do
      require "postgram_raidexes/pg_opclass_support"
    end
  end
end