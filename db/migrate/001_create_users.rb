class CreateUsers < ActiveRecord::Migration[5.2]

  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :app_id
      t.integer :review_id
    end
  end
end
