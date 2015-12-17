class Event < ActiveRecord::Base
	has_many :timeslots
	has_many :arrangements, through: :timeslots
  belongs_to :organization
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :skills

  searchable do
    text :name, :location
    text :organization_name

  end

  def organization_name
    Organization.find(organization_id).name
  end

  def start_time
  	self.timeslots.order(start_time: :asc).first.start_time
  end

  def end_time
  	self.timeslots.order(end_time: :asc).last.end_time
  end
end
