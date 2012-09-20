$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "release_me/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "release_me"
  s.version     = ReleaseMe::VERSION
  s.authors     = ["Jason Wadsworth"]
  s.email       = ["jdwadsworth@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ReleaseMe."
  s.description = "TODO: Description of ReleaseMe."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"

  s.add_development_dependency "sqlite3"
end
