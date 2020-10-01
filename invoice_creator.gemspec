require_relative 'lib/invoice_creator/version'

Gem::Specification.new do |spec|
  spec.name          = "invoice_creator"
  spec.version       = InvoiceCreator::VERSION
  spec.authors       = ["Nicholas Pufal"]
  spec.email         = ["github@npufal.com"]
  spec.summary       = %q{A simple invoice creation tool to help you bill your tech clients.}
  spec.homepage      = "https://github.com/nicholaspufal/invoice_creator"
  spec.license       = "MIT"
  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "prawn", "2.2.2"
  spec.add_runtime_dependency "prawn-table", "0.2.2"
  spec.add_runtime_dependency "thor", "0.20.0"

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
