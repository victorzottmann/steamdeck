class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :edition
      t.integer :pages
      t.date :date
      t.string :format
      t.integer :price
      t.integer :quantity
      t.boolean :available
      t.references :author, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :publisher, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
