class AddAssignedToToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :assigned_to, :integer
  end
end
