class CreateInitialTables < ActiveRecord::Migration
    def change
        create_table :abilities do |t|
          t.string :name, limit: 100
          t.string :text
          t.string :icon, limit: 100

          t.timestamps
        end
        create_table :races do |t|
          t.string :name, limit: 30

          t.timestamps
        end
        create_table :cardsets do |t|
          t.string :name
          t.string :short, limit: 50

          t.timestamps
        end
        create_table :civs do |t|
          t.string :name
          t.string :icon

          t.timestamps
        end

        create_table :cards do |t|
          t.string :name
          t.string :slug
          t.integer :power
          t.integer :cost
          t.integer :ctype

          t.timestamps
        end

        create_table :cards_civs do |t|
            t.belongs_to :card
            t.belongs_to :civ
        end
        create_table :cards_races do |t|
            t.belongs_to :card
            t.belongs_to :race
        end
        create_table :abilities_cards do |t|
            t.belongs_to :card
            t.belongs_to :ability
        end

        create_table :printings do |t|
          t.belongs_to :card
          t.belongs_to :cardset
          t.integer :rarity
          t.string :flavor
          t.string :art
          t.string :illustrator
          t.string :number, limit: 25

          t.timestamps
        end
    end
end
