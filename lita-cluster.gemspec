Gem::Specification.new do |spec|
  spec.name          = "lita-cluster"
  spec.version       = "0.1.0"
  spec.authors       = ["catiger1974"]
  spec.email         = ["catiger1974@gmail.com"]
  spec.description   = "Lita Cluster extention"
  spec.summary       = "Lita Cluster"
  spec.homepage      = "https://github.com/catiger1974/lita-cluster"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "extension" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.7"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
