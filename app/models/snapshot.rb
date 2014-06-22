class Snapshot < ActiveRecord::Base
  belongs_to :process_app
  has_many :process_dependencies, class_name: 'Dependency', foreign_key: 'toolkit_snap_id'
  has_many :toolkit_dependencies, class_name: 'Dependency', foreign_key: 'proc_app_snap_id'
  has_many :toolkit_snaps,		:through => :toolkit_dependencies
  has_many  :process_snaps,		:through => :process_dependencies

  attr_accessible :guid, :name, :process_app_id, :type

  def illegal
    proc_app = []
    papp = []
    dups = []
    if self.process_app.type == "Toolkit"
      dependencies = Dependency.where(toolkit_snap_id: self.id)
      dependencies.each do |dependency|
        snapshot = Snapshot.find(dependency.proc_app_snap_id)
        proc_app << snapshot
      end
    else
      dependencies = Dependency.where(proc_app_snap_id: self.id)
      dependencies.each do |dependency|
        snapshot = Snapshot.find(dependency.toolkit_snap_id)
        proc_app << snapshot
      end
    end
    proc_app.each do |dep|
      if papp.include?(dep.process_app)
        dups << dep
      else
        papp << dep.process_app
      end
    end
    return dups, proc_app
  end




  #     dependencies.each do |x|
  #       names = []
  #       dups = []
  #       x.each do |y|
  #         names << y.name
  #       end
  #       names.detect do |name|
  #         if names.count(name) > 1
  #           dups << name
  #         end
  #       end
  #       if dups.count > 0
  #         illegals[snap.id] = dups
  #       end
  #     end
  #   end
  #   return illegals
  # end

end
