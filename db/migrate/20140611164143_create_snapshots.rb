class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.string :name
      t.string :guid
      t.integer :process_app_id
      t.string :type

      t.timestamps
    end
  end
end
