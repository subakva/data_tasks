# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_tasks/version'

Gem::Specification.new do |s|
  s.name        = "data_tasks"
  s.version     = DataTasks::VERSION
  s.authors     = ["Jason Wadsworth"]
  s.email       = ["jdwadsworth@gmail.com"]
  s.homepage    = "https://github.com/subakva/data_tasks"
  s.summary     = "Adds a second migration phase to a Rails project."
  s.description = %{
    Adds a second migration phase to a Rails project for data migrations. Just
    like migrations, these can be run once and only once in each environment
    with a single command during every deployment.
  }

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.2.11"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "jquery-rails"
end
