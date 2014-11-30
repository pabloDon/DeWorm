class AddLastProjectSelectedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_project, :integer
  end
end
