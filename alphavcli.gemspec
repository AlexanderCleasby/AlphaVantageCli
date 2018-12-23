
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "alphavcli/version"

Gem::Specification.new do |spec|
  spec.name          = "alphavcli"
  spec.version       = Alphavcli::VERSION
  spec.authors       = ["alexandercleasby"]
  spec.email         = ["cleasby.alex@gmail.com"]

  spec.summary       = %q{pfff.}
  spec.description   = %q{flk.}
  spec.homepage      = ""



  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["alphavcli"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
