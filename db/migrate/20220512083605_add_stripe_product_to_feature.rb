class AddStripeProductToFeature < ActiveRecord::Migration[6.1]
  def change
    add_column :features, :stripe_product, :string
  end
end
