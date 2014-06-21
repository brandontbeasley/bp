class AddTypeToProcessApp < ActiveRecord::Migration
  def change
    add_column :process_apps, :type, :string
  end
end
