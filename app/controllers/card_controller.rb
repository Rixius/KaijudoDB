class CardController < ApplicationController
    class QueryParser
        attr :query, :parts
        CivMap = {
            'l' => 'Light',
            'w' => 'Water',
            'd' => 'Darkness',
            'f' => 'Fire',
            'n' => 'Nature'
        }

        def initialize query
            @query = Card.order('name')
            @parts = query.downcase.gsub(/"(\w+) (\w+)"/, '"\1☃\2"').split.each do |part|
                part.gsub!(/"(\w+)☃(\w+)"/, '\1 \2')
            end
        end
        def parse
            @parts.each do |part|
                if part.match(/.+[!:].+/)
                    if part[':']
                        part = part.split ':'
                        case part.first
                        when "set"
                            set part
                        when "race"
                            race part
                        when "civ"
                            civ part
                        end
                    else
                        part = part.split '!'
                        case part.first
                        when "civ"
                            civ! part
                        end
                    end
                elsif part.match(/[<>=!]/)
                    part = /(.+)([<>=]{1,2})(.+)/.match(part)
                    case part[1]
                    when 'rarity'
                        rarity part
                    when 'cost', 'power'
                        @query = @query.where("#{part[1]} #{part[2]} ?", Integer(part[3]))
                    end
                else
                    @query = @query.where('cards.name ILIKE ?', "%"+part+"%")
                end
            end
            self
        end
        private
        def set part
            @query = @query
            .joins(:printings)
            .joins(:printings => :cardset)
            .where("cardsets.name ILIKE ? OR cardsets.short ILIKE ?", "%#{part.last}%", "%#{part.last}%")
        end
        def rarity part
            @query = @query
            .joins(:printings)
            .where("printings.rarity #{part[2]} ?", Integer(part[3]))
        end
        def race part
            @query = @query
            .joins(:races)
            .where('races.name ILIKE ?', "%#{part.last}%")
        end
        def civ! part
            return civmulti!(part) if part.last.match(/[mM]$/)
            parts = {}
            part.last.gsub(/[mM]/, '').split('').map do |civshort|
                parts[civshort] = CivMap[civshort]
            end
            parts = (CivMap.values - parts.values).map do |v|
                Civ.find_by_name v
            end
            @query = @query
            .where('cards.id NOT IN (select card_id from cards_civs WHERE civ_id IN (?))', parts)

            #@query = @query.joins(:civs)
            #.group('cards_civs.card_id')
            #.having('cards_civs.civ_id NOT IN (?)', parts)
        end
        def civmulti! part
            parts = {}
            part.last.gsub(/[mM]/, '').split('').map do |civshort|
                parts[civshort] = CivMap[civshort]
            end
            @query = @query.where('cards.id IN (SELECT card_id FROM cards_civs WHERE civ_id NOT IN (?) GROUP BY card_id HAVING count(card_id) > 1)', (CivMap.values - parts.values).map do |v|
                Civ.find_by_name v
            end)
        end
        def civ part
            @query = @query.joins(:civs)
            .where('civs.id IN (?)', part.last.gsub(/[mM]/, '').split('').map do |civshort|
                Civ.find_by_name CivMap[civshort]
            end)
            civmulti if part.last.match(/[mM]$/)
        end
        def civmulti
            @query = @query.where('cards.id IN (SELECT card_id FROM cards_civs GROUP BY card_id HAVING count(card_id) > 1)')
            #@query = @query.group('cards_civs.card_id').having('count(cards_civs.card_id) > 1')
        end
    end
    def list
        @cards = Card.all
    end
    def show
        @card = Card.find_by_slug params[:slug]
    end
    def search
        @querystring = params[:q]
        @queryobject = QueryParser.new params[:q]
        @cards = @queryobject.parse.query
    end
end
