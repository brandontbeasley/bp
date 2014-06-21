class Snapshot < ActiveRecord::Base
  belongs_to :process_app
  has_many :process_dependencies, class_name: 'Dependency', foreign_key: 'toolkit_snap_id'
  has_many :toolkit_dependencies, class_name: 'Dependency', foreign_key: 'proc_app_snap_id'
  has_many :toolkit_snaps,		:through => :toolkit_dependencies
  has_many  :process_snaps,		:through => :process_dependencies

  attr_accessible :guid, :name, :process_app_id, :type

  def dependencies
    proc_app = []
    if self.process_app.type == "Toolkit"
      dependencies = Dependency.where(toolkit_snap_id: self.id)
      dependencies.each do |dependency|
        snapshot = Snapshot.find(dependency.proc_app_snap_id)
        proc_app << snapshot.process_app
      end
    else
      dependencies = Dependency.where(proc_app_snap_id: self.id)
      dependencies.each do |dependency|
        snapshot = Snapshot.find(dependency.toolkit_snap_id)
        proc_app << snapshot.process_app
      end
    end
    return proc_app
  end

end
