class CreateApps < ActiveRecord::Migration[5.2]

  def change
    create_table :apps do |t|
      t.string :name
      t.string :category
      t.integer :total_reviews
      t.integer :avg_rating
      t.integer :user_id
      t.integer :review_id
    end
  end

end
