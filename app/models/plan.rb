class Plan < ApplicationRecord
  belongs_to :manager, class_name: 'User'

  has_and_belongs_to_many :features

  before_save :update_plan_fee

  def update_plan_fee
    self.monthly_fee = features.reduce(0) { |sum, feature| sum + feature.unit_price }
  end
end
