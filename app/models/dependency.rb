class Dependency < ActiveRecord::Base
  belongs_to :proc_app_snap, class_name: 'Snapshot'
  belongs_to :toolkit_snap, class_name:  'Snapshot'

  attr_accessible :guid, :proc_app_snap_id, :toolkit_snap_id
end
