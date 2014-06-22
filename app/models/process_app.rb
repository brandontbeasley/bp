class ProcessApp < ActiveRecord::Base
  has_many :snapshots

  attr_accessible :description, :guid, :name, :short_name


end
