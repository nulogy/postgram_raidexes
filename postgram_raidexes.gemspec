# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "postgram_raidexes/version"

Gem::Specification.new do |spec|
  spec.name          = "postgram_raidexes"
  spec.version       = PostgramRaidexes::VERSION
  spec.authors       = ["Jason Schweier"]
  spec.email         = ["jasons@nulogy.com"]

  spec.summary       = %q{Add postgres trigram index support to Rails}
  spec.homepage      = "https://github.com/nulogy/postgram_raidexes"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rails", "~> 4.0"
  spec.add_development_dependency "pg", "~> 0.18"
end
