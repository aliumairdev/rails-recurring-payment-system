class User < ApplicationRecord
  pay_customer
  rolify
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :manager, class_name: 'User', foreign_key: :invited_by_id, optional: true
  has_many :buyers, class_name: 'User', foreign_key: :invited_by_id

  # Manager associations
  has_many :features, foreign_key: 'manager_id'
  has_many :plans, foreign_key: 'manager_id'

  before_invitation_created :add_user_role

  def add_user_role
    add_role :buyer
  end
end
