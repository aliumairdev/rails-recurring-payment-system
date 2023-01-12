class AddStripePriceToFeature < ActiveRecord::Migration[5.2]
  def change
    add_column :features, :stripe_metered_price, :string
    add_column :features, :stripe_price, :string
  end
end
