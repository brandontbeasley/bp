class CreateDependencies < ActiveRecord::Migration
  def change
    create_table :dependencies do |t|
      t.integer :proc_app_snap_id
      t.integer :toolkit_snap_id
      t.string :guid

      t.timestamps
    end
  end
end
