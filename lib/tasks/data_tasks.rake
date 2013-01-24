namespace :data do

  DATA_MIGRATIONS_PATHS = ['db/data_tasks']

  desc 'Prevents existing data tasks from being run'
  task assume_migrated: :environment  do
    migrations_paths = DATA_MIGRATIONS_PATHS
    paths = migrations_paths.map {|p| "#{p}/[0-9]*_*.rb" }
    versions = Dir[*paths].map do |filename|
      filename.split('/').last.split('_').first.to_i
    end

    sm_table = ActiveRecord::Schema.quote_table_name(ActiveRecord::Migrator.schema_migrations_table_name)
    migrated = ActiveRecord::Schema.select_values("SELECT version FROM #{sm_table}").map { |v| v.to_i }
    versions_to_insert = (versions - migrated).uniq

    versions_to_insert.each do |version|
      ActiveRecord::Schema.execute "INSERT INTO #{sm_table} (version) VALUES ('#{version}')"
    end
  end

  desc 'Runs any data tasks that have not yet been executed.'
  task migrate: :environment do
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate(DATA_MIGRATIONS_PATHS, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
end
