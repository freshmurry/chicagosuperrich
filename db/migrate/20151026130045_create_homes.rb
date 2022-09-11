class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :home_type
      t.integer :bedroom
      t.integer :bathroom
      t.string :listing_name
      t.text :summary
      t.string :occupation
      t.string :address
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end