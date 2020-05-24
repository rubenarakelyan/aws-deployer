class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: true, unique: true
      t.string :name, null: false
      t.string :avatar_url
      t.timestamps
    end
  end
end
