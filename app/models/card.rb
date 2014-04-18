class Card < ActiveRecord::Base
    enum type: [:creature, :evolution, :spell]
    has_and_belongs_to_many :abilities
    has_and_belongs_to_many :races
    has_and_belongs_to_many :civs
    has_many :printings
end
