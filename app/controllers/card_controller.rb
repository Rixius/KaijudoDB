class CardController < ApplicationController
    def index
        @cards = Card.all
    end
    def show
        @card = Card.find_by_slug params[:slug]
    end
    def search
        @civs = {
            'L' => 'Light',
            'W' => 'Water',
            'D' => 'Darkness',
            'F' => 'Fire',
            'N' => 'Nature'
        }
        @queryparts = params[:q].gsub(/"(\w+) (\w+)"/, '"\1☃\2"').split
        @query = Card.order('name')
        @queryparts.each do |part|
            part.gsub!(/"(\w+)☃(\w+)"/, '\1 \2')
            if part[':']
                part = part.split ':'
                case part.first
                when "civ"
                    @query = @query.joins(:civs)
                    .where('civs.id IN (?)', part.last.split('').map do |civshort|
                        Civ.find_by_name @civs[civshort]
                    end)
                end
            elsif part.match(/[<>=]/)
                part = /(.+)([<>=]{1,2})(.+)/.match(part)
                case part[1]
                when 'cost', 'power'
                    @query = @query.where("#{part[1]} #{part[2]} ?", Integer(part[3]))
                end
            else
                @query = @query.where('cards.name LIKE ?', "%"+part+"%")
            end
        end
    end
end
