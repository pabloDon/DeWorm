class AddUserIdToBugHistorics < ActiveRecord::Migration
  def change
    add_column :bug_historics, :user_id, :integer
  end
end
