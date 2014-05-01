class AddDeckcardsToDeck < ActiveRecord::Migration
  def change
    create_table :decks_cards do |t|
      t.belongs_to :deck
      t.belongs_to :card

      t.timestamps
    end
  end
end
