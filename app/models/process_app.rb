class ProcessApp < ActiveRecord::Base
  has_many :snapshots

  attr_accessible :description, :guid, :name, :short_name

  def illegal
    dependencies = []
    illegals = {}
    snapshots = self.snapshots
    snapshots.each do |snap|
      dependencies << snap.dependencies
      dependencies.each do |x|
        names = []
        dups = []
        x.each do |y|
          names << y.name
        end
        names.detect do |name|
          if names.count(name) > 1
            dups << name
          end
        end
        if dups.count > 0
          illegals[snap.id] = dups
        end
      end
    end
    return illegals
  end
end
