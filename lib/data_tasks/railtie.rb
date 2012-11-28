require 'rails'

module DataTasks
  class Railtie < Rails::Railtie
    railtie_name :data_tasks

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), '..', 'tasks', '*.rake')].each { |f| load f }
    end
  end
end
