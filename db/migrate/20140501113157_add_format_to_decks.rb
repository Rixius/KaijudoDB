class AddFormatToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :format, :string
  end
end
