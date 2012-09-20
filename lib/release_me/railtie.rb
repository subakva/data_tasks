require 'rails'

module ReleaseMe
  class Railtie < Rails::Railtie
    railtie_name :release_me

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), '..', 'tasks', '*.rake')].each { |f| load f }
    end
  end
end
