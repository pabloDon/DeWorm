class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.integer :priority
      t.integer :severity
      t.integer :status
      t.integer :resolution
      t.string :version_planned
      t.string :version_solved
      t.text :summary
      t.text :description

      t.timestamps
    end
  end
end
