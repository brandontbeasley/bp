class CreateProcessApps < ActiveRecord::Migration
  def change
    create_table :process_apps do |t|
      t.string :guid
      t.string :name
      t.text :description
      t.string :short_name

      t.timestamps
    end
  end
end
