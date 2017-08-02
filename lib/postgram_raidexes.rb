require "postgram_raidexes/version"

# TODO: Rails is not defined
if defined?(Rails)
  require "postgram_raidexes/railtie"
  require "postgram_raidexes/pg_opclass_support"
end

module PostgramRaidexes
end
