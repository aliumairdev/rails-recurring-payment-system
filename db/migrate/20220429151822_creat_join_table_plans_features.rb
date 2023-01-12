class CreatJoinTablePlansFeatures < ActiveRecord::Migration[5.2]
  def change
    create_join_table :plans, :features do |t|
      t.index %i[plan_id feature_id]
      t.index %i[feature_id plan_id]
    end
  end
end
