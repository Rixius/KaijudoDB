class Card < ActiveRecord::Base
    has_and_belongs_to_many :abilities
    has_and_belongs_to_many :races
    has_and_belongs_to_many :civs
    has_many :printings
end
