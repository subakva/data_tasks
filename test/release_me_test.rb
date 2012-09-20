require 'test_helper'

class ReleaseMeTest < ActiveSupport::TestCase

  def execute(command)
    puts "\n=> Running: \"#{command}\"" #if ENV['VERBOSE']
    `#{command}`
  end

  def in_dummy_app(&block)
    FileUtils.chdir(@dummy_dir) do
      yield
    end
  end

  def assert_directory(path)
    assert File.directory?(path), "#{path} was not a directory"
  end

  def setup
    @dummy_dir = File.join('test', 'dummy')
    @dummy_tmp_dir = File.join('tmp')
    @dummy_task_dir = File.join('db', 'release_tasks')
    @dummy_migration_dir = File.join('db', 'migrate')
    @dummy_models_dir = File.join('app', 'models')

    FileUtils.rm_rf File.join(@dummy_dir, @dummy_task_dir)
    FileUtils.rm_rf File.join(@dummy_dir, @dummy_migration_dir)
    FileUtils.rm_rf File.join(@dummy_dir, @dummy_models_dir)
    FileUtils.rm_rf File.join(@dummy_dir, @dummy_tmp_dir)
  end

  def teardown
  end

  def insert_in_file(filename, lines_to_insert, options)
    lines_to_insert = [*lines_to_insert]
    tmp_filename = File.join(@dummy_tmp_dir, filename)
    FileUtils.mkdir_p(File.dirname(tmp_filename))

    File.open(tmp_filename, 'w') do |out|
      File.readlines(filename).each do |line|
        out.puts(line)
        if line =~ options[:after]
          lines_to_insert.each do |line_to_insert|
            out.puts line_to_insert
          end
        end
      end
    end

    FileUtils.mv(tmp_filename, filename)
  end

  test 'runs a release task with a rake task' do
    in_dummy_app do
      execute("rails generate model Farmer name:string --fixture false")
      execute("rake db:drop db:create db:migrate")
      execute("rails generate release_task add_farmer")

      filename = Dir[File.join(@dummy_task_dir, '*add_farmer*')].first
      insert_in_file(filename, 'class Farmer < ActiveRecord::Base; end', after: /class AddFarmer/)
      insert_in_file(filename, [
        'farmer = Farmer.new',
        'farmer.name = "Al"',
        'farmer.save!'
      ], after: /say_with_time/)

      execute("rake release:migrate")
      farmer_name = execute(%{rails runner "puts Farmer.find_by_name('Al').try(:name)"}).strip
      assert_equal 'Al', farmer_name
    end

  end

  test 'does not interfere with database rollback' do
    pending 'Implement the test'
  end

  test 'does not run the same task twice' do
    in_dummy_app do
      execute("rails generate model Record --fixture false")
      execute("rake db:drop db:create db:migrate")
      execute("rails generate release_task insert_record")

      filename = Dir[File.join(@dummy_task_dir, '*insert_record*')].first
      insert_in_file(filename, 'class Record < ActiveRecord::Base; end', after: /class InsertRecord/)
      insert_in_file(filename, 'Record.create!', after: /say_with_time/)
      execute("rake release:migrate")
      execute("rake release:migrate")

      record_count = execute(%{rails runner "puts Record.count"}).strip
      assert_equal '1', record_count
    end
  end

  test "generates a new release task" do
    in_dummy_app do
      execute("rails generate release_task do_something_awesome")

      assert_directory @dummy_task_dir

      task_files = Dir[File.join(@dummy_task_dir, '**')]
      assert_equal 1, task_files.size
      assert_match Regexp.new(File.join(@dummy_task_dir, '[0-9]*_do_something_awesome.rb')), task_files[0]
    end
  end
end
