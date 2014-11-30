class AddReportedByToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :reported_by, :integer
  end
end
