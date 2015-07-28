class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders

  validates_presence_of :name

  before_create :set_as_admin_if_first_user

  private

  def set_as_admin_if_first_user
    unless User.any?
      self.name  = "Launches Admin"
      self.admin = true
    end
  end
end
