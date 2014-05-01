class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.boolean :active

      t.timestamps
    end
  end
end
