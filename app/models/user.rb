class User < ActiveRecord::Base
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts

  def self.find_for_database_authentication(warden_conditions)
	conditions = warden_conditions.dup
	if login = conditions.delete(:login)
	  where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	else
	  where(conditions.to_h).first
	end
  end

  has_attached_file :avatar, :styles => { :large => "300x300#",medium: "40x40", :thumb => "30x30#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

  acts_as_followable
  acts_as_follower
  acts_as_liker
end
