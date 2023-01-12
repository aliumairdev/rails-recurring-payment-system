class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :monthly_fee
      t.references :manager, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
