class AddFarmer < ActiveRecord::Migration
class Farmer < ActiveRecord::Base; end
  def up
    say_with_time "migrating data" do
farmer = Farmer.new
farmer.name = "Al"
farmer.save!
    end
  end
end
