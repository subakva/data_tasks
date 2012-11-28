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

## Common Problems

If you're running your Rails processes in threadsafe mode, you'll get errors about undefined
constants when trying to access model classes. You'll need to disable while running
rake tasks. In your environment file (ex. `config/environments/production.rb`), change:

    config.threadsafe!

to:

    config.threadsafe! unless $rails_rake_task


## Future

 * Add a capistrano hook to run data migrations after schema migrations
 * Add a heroku-san deployment strategy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
