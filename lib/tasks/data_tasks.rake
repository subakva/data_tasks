namespace :data do

  desc 'Runs any data tasks that have not yet been executed.'
  task migrate: :environment do
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate(['db/data_tasks'], ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
end
