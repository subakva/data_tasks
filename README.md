# DataTasks

Adds a second migration phase to a Rails project for data migrations. Just
like migrations, these can be run once and only once in each environment
with a single command during every deployment.

## Installation

Add this line to your application's Gemfile:

    gem 'data_tasks'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install empty_gem

## Usage

To generate a data migration, use the rails generator:

    rails generate data_task MigrateSomeData

This will create:

    db/data_tasks/20120822023011_migrate_some_data.rb

Run all pending data tasks with rake:

    rake data:migrate

When re-building an empty development database with no data, you probably want to skip running the data tasks. To mark
all pending tasks complete:

    rake data:assume_migrated

## Common Problems

If you're running your Rails processes in threadsafe mode, you'll get errors about undefined
constants when trying to access model classes. You'll need to disable while running
rake tasks. In your environment file (ex. `config/environments/production.rb`), change:

    config.threadsafe!

to:

    config.threadsafe! unless $rails_rake_task

If you don't want to make that change, you can explicitly load the required model classes
inside the migration class, or define stub model classes. For example, if you wanted to
add a new SideHatch record in the migration, you could define:

    class SideHatch < ActiveRecord::Base; end

    class CreateSideHatch < ActiveRecord::Migration
      def up
        SideHatch.create!(size: 49)
      end
    end

## Future

 * Add a capistrano hook to run data migrations after schema migrations
 * Add a heroku-san deployment strategy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
