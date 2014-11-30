class AddProjectIdToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :project_id, :integer
  end
end
