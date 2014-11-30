class AddBugIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :bug_id, :integer
  end
end
