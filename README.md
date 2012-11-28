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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
