class User < ActiveRecord::Base

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  acts_as_messageable
	has_many :arrangements
	has_many :timeslots, through: :arrangements
	has_many :bookmarks
	has_many :bookmarked_events, through: :bookmarks, source: :event, class_name: "Event"
	has_many :managed_organizations, class_name: "Organization"
	has_and_belongs_to_many :interests
	has_and_belongs_to_many :skills

  validates :password, length: { minimum: 3 }, if: :password_exists?
  validates :password, confirmation: true, if: :password_exists?
  validates :password_confirmation, presence: true, if: :password_exists?
  validates :email, presence: true, uniqueness: true

	has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  def name
    if self.first_name.present? && self.last_name.present? && self.email.present?
      "#{self.first_name} #{self.last_name[0]} (#{self.email})"
    elsif self.first_name.present? && self.email.present?
      "#{self.first_name} (#{self.email})"
    elsif self.email.present?
      "User #{self.id} (#{self.email})"
    else
      "User #{self.id}"
    end
  end

	def has_interest?(interest)
		self.interests.include?(interest)
	end

  def has_skill?(skill)
    self.skills.include?(skill)
  end

  def password_exists?
    password.present? || password_confirmation.present?
  end

  def manages_organizations?
    self.managed_organizations.any?
  end

  def is_authorized?(organization)
    self.managed_organizations.include?(organization)
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end
end
