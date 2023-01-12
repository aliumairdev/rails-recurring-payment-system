class Feature < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :manager, class_name: 'User'

  has_and_belongs_to_many :plans

  after_create :create_stripe_product
  before_update :update_stripe_product

  def create_stripe_product
    StripeServices::ProductService.create(self)
  end

  def update_stripe_product
    StripeServices::PriceService.update(self) if unit_price_changed?
    StripeServices::ProductService.update(self) if name_changed?
  end
end
