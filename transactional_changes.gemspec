
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "transactional_changes/version"

Gem::Specification.new do |spec|
  spec.name          = "transactional_changes"
  spec.version       = TransactionalChanges::VERSION
  spec.authors       = ["Vikash Singh"]
  spec.email         = ["vikash.singh@bizongo.in"]

  spec.summary       = %q{Track the attribute changes in an transaction}
  spec.description   = %q{Enhancement of rails dirty previous_changes method which only returns last save changes. This will track all the changes that has been done in one transaction.}
  spec.homepage      = "https://bizongo.in"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "activesupport", ">=4.2.0"
  spec.add_development_dependency "activerecord", ">= 4.0"
  spec.add_development_dependency "sqlite3", ">= 1.3"
end
