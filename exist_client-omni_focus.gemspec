lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "exist_client/omni_focus/version"

Gem::Specification.new do |spec|
  spec.name          = "exist_client-omni_focus"
  spec.version       = ExistClient::OmniFocus::VERSION
  spec.authors       = ["Matt Wean"]
  spec.email         = ["matthew.wean@gmail.com"]

  spec.summary       = %q{A plugin for ExistClient that reports completed tasks from OmniFocus}
  spec.homepage      = "https://github.com/mwean/exist_client-omni_focus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
