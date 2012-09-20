class ReleaseTaskGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  def create_migration_file
    migration_template "release_task.rb", "db/release_tasks/#{file_name}.rb"
  end

  def self.next_migration_number(dirname) #:nodoc:
    next_migration_number = current_migration_number(dirname) + 1
    ActiveRecord::Migration.next_migration_number(next_migration_number)
  end
end
