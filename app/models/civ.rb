class Civ < ActiveRecord::Base
    has_and_belongs_to_many :cards
end
