class CreateBugHistorics < ActiveRecord::Migration
  def change
    create_table :bug_historics do |t|
      t.integer :bug_id
      t.integer :ref

      t.timestamps
    end
  end
end
