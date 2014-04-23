require 'nokogiri'
require 'pathname'
require 'pp'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
civs = {
    :light    => {name: 'Light', icon: ''},
    :water    => {name: 'Water', icon: ''},
    :darkness => {name: 'Darkness', icon: ''},
    :fire     => {name: 'Fire', icon: ''},
    :nature   => {name: 'Nature', icon: ''}
}
races = {
    :angel_command      => {name: 'Angel Command'},
    :battle_sphere      => {name: 'Battle Sphere'},
    :celestial_dragon   => {name: 'Celestial Dragon'},
    :enforcer           => {name: 'Enforcer'},
    :fractal            => {name: 'Fractal'},
    :invader            => {name: 'Invader'},
    :mecha_thunder      => {name: 'Mecha Thunder'},
    :sky_weaver         => {name: 'Sky Weaver'},
    :skyforce_champion  => {name: 'Skyforce Champion'},
    :star_sentinel      => {name: 'Star Sentinel'},
    :storm_patrol       => {name: 'Storm Patrol'},
    :aquan              => {name: 'Aquan'},
    :cyber_complex      => {name: 'Cyber Complex'},
    :cyber_lord         => {name: 'Cyber Lord'},
    :cyber_virus        => {name: 'Cyber Virus'},
    :earth_eater        => {name: 'Earth Eater'},
    :leviathan          => {name: 'Leviathan'},
    :riptide_champion   => {name: 'Riptide Champion'},
    :trench_hunter      => {name: 'Trench Hunter'},
    :tsunami_dragon     => {name: 'Tsunami Dragon'},
    :undertow_engine    => {name: 'Undertow Engine'},
    :brain_jacker       => {name: 'Brain Jacker'},
    :chimera            => {name: 'Chimera'},
    :dark_lord          => {name: 'Dark Lord'},
    :dread_mask         => {name: 'Dread Mask'},
    :evil_toy           => {name: 'Evil Toy'},
    :mimic              => {name: 'Mimic'},
    :rot_worm           => {name: 'Rot Worm'},
    :shadow_champion    => {name: 'Shadow Champion'},
    :specter            => {name: 'Specter'},
    :tarborg            => {name: 'Tarborg'},
    :terror_dragon      => {name: 'Terror Dragon'},
    :zombie             => {name: 'Zombie'},
    :armored_dragon     => {name: 'Armored Dragon'},
    :attack_raptor      => {name: 'Attack Raptor'},
    :berserker          => {name: 'Berserker'},
    :blaze_champion     => {name: 'Blaze Champion'},
    :burn_belly         => {name: 'Burn Belly'},
    :drakon             => {name: 'Drakon'},
    :dune_gecko         => {name: 'Dune Gecko'},
    :fire_bird          => {name: 'Fire Bird'},
    :inferno_complex    => {name: 'Inferno Complex'},
    :melt_warrior       => {name: 'Melt Warrior'},
    :rock_brute         => {name: 'Rock Brute'},
    :stomper            => {name: 'Stomper'},
    :beast_kin          => {name: 'Beast Kin'},
    :colossus           => {name: 'Colossus'},
    :earthstrike_dragon => {name: 'Earthstrike Dragon'},
    :flying_fungus      => {name: 'Flying Fungus'},
    :living_city        => {name: 'Living City'},
    :megabug            => {name: 'Megabug'},
    :primal_champion    => {name: 'Primal Champion'},
    :snow_sprite        => {name: 'Snow Sprite'},
    :spirit_totem       => {name: 'Spirit Totem'},
    :tree_kin           => {name: 'Tree Kin'},
    :tusker             => {name: 'Tusker'},
    :wild_veggie        => {name: 'Wild Veggie'},
    :spirit_quartz      => {name: 'Spirit Quartz'},
    :human              => {name: 'Human'},
    :corrupted          => {name: 'Corrupted'},
    :monarch            => {name: 'Monarch'},
    :mystic             => {name: 'Mystic'}
}
sets = {
    :tvr => {name: 'Battle Decks: Tatsurion vs Razorkinder', short: '1TVR'},
    :evo => {name: 'Evo Fury', short: '4EVO'},
    :inv => {name: 'Invasion Earth', short: '10INV'},
    :ris => {name: 'Rise of the Duel Masters', short: '3RIS'},
    :dsi => {name: 'DragonStrike Infernus', short: '6DSI'},
    :mys => {name: 'The 5 Mystics', short: '12MYS'},
    :tri => {name: 'Elite Series - Triple Strike', short: '8TRI'},
    :cla => {name: 'Clash of the Duel Masters', short: '7CLA'},
    :ded => {name: 'Dojo Edition', short: '2DED'},
    :sha => {name: 'Shattered Alliances', short: '9SHA'},
    :dra => {name: 'Dragon Master Collection Kit', short: '5DRA'},
    :bbr => {name: 'Booster Brawl', short: '11BBR'},
    :ga1 => {name: 'Quest for the Gauntlet', short: '13GA1'},
    :prm1 => {name: 'Year 1 Promos', short: 'Y1PRM'},
    :prm2 => {name: 'Year 2 Promos', short: 'Y2PRM'}
}
abilities = {
    :multi_civ => {reminder: '(This card enters your mana zone tapped.)'},
    :blocker => {name: 'Blocker', reminder: '(You may tap this creature to change an enemy creature\'s attack to this creature.)', icon: ''},
    :protector => {name: 'protector', reminder: '(You may tap this creature to change an attack on one of your other creatures to this creature.)', icon: ''},
    :double_breaker => {name: 'Double Breaker', reminder: '(This creature breaks 2 shields.)', icon: ''},
    :triple_breaker => {name: 'Triple Breaker', reminder: '(This creature breaks 3 shields.)', icon: ''},
    :shield_blast => {name: 'Shield Blast', reminder: '(Instead of putting this spell into your hand from a broken shield, you may cast it for free.)', icon: ''},
    :fast_attack => {name: 'Fast Attack', reminder: '(This creature can attack on the turn it enters the battle zone.)', icon: ''},
    :powerful_attack_1000 => {name: 'Powerful Attack +1000', reminder: '(While attacking, this creature gets +1000 power.)', icon: ''},
    :powerful_attack_2000 => {name: 'Powerful Attack +2000', reminder: '(While attacking, this creature gets +2000 power.)', icon: ''},
    :powerful_attack_3000 => {name: 'Powerful Attack +3000', reminder: '(While attacking, this creature gets +3000 power.)', icon: ''},
    :powerful_attack_4000 => {name: 'Powerful Attack +4000', reminder: '(While attacking, this creature gets +4000 power.)', icon: ''},
    :powerful_attack_5000 => {name: 'Powerful Attack +5000', reminder: '(While attacking, this creature gets +5000 power.)', icon: ''},
    :powerful_attack_6000 => {name: 'Powerful Attack +6000', reminder: '(While attacking, this creature gets +6000 power.)', icon: ''},
    :powerful_attack_7000 => {name: 'Powerful Attack +7000', reminder: '(While attacking, this creature gets +7000 power.)', icon: ''},
    :slayer => {name: 'Slayer', reminder: '(When this creature loses a battle, banish the other creature.)', icon: ''},
    :skirmisher => {name: 'Skirmisher', text: '(This creature can attack only creatures.)', icon: ''}
}

Civ.create(civs.map do |k,v| v end).each do |civ|
    civs[civ.name.downcase.to_sym] = civ
end
Race.create(races.map do |k,v| v end).each do |race|
    races[race.name.downcase.gsub(' ','_').to_sym] = race
end
Cardset.create(sets.map do |k,v| v end).each do |cardset|
    sets[cardset.short.downcase.gsub(/^[0-9]+/, '').to_sym] = cardset
end
Ability.create(abilities.map do |k,v| v end).each do |ability|
    if ability.name
        abilities[ability.name.downcase.gsub(' ','_').to_sym] = ability
    else
        abilities[:multi_civ] = ability
    end
end

cards = {}
abilityregex = /^(?<name>[A-Za-z0-9 ']+[A-Za-z0-9!])?( ?(?<reminder>\([A-Za-z0-9 .,:;-]+\)))?( [-—] (?<text>[A-Za-z0-9 .,'":;-]+))?/
set = Dir.glob './vendor/cards/game/Sets/*/set.xml'
set.each do |path|
    File.open(path, 'r') do |file|
        xml = Nokogiri::XML(file.read)
        xml.xpath('set/cards/card').each do |card|
            if ! Card.find_by_name(card['name'])
                card_hash = {
                    name: card['name'],
                    slug: card['name'].downcase.gsub(' ','_'),
                    cost: Integer(card.xpath("property[@name='Level']").first['value']),
                    ctype: Card.ctypes[card.xpath("property[@name='Type']").first['value'].split.first.downcase.to_sym],
                    civs: card.xpath("property[@name='Civilization']").first['value'].split(" / ").map do |civ|
                        out = civs[civ.downcase.to_sym]
                        puts civ if ! out
                        puts card['name'] if ! out
                        puts path if ! out
                        out
                    end,
                    abilities: [],
                }
                if card_hash[:ctype] < 2
                    card_hash[:power] = Integer(card.xpath("property[@name='Power']").first['value'].gsub('+', ''))
                    card_hash[:races] =  card.xpath("property[@name='Race']").first['value'].split(" / ").map do |race|
                        out = races[race.downcase.gsub(' ', '_').to_sym]
                        puts race if ! out
                        puts card_hash[:name] if ! out
                        puts path if ! out
                        out
                    end
                end

                card.xpath('property[@name="Rules"]').first['value'].split("\r\n").each do |ability|
                    matches = abilityregex.match ability
                    if matches && matches['name']
                        dbability = Ability.where('name LIKE ?', matches['name']).where('reminder LIKE ?', matches['reminder']).limit(1).first
                        if !dbability.nil?
                            card_hash[:abilities] << dbability
                        else
                            card_hash[:abilities] << Ability.create(name: matches['name'],
                                text: matches['text'])
                        end
                    else
                        if matches['reminder']
                            card_hash[:abilities] << abilities[:multi_civ]
                        else
                            card_hash[:abilities] << Ability.create(text: matches['text'])
                        end
                    end
                end

                cards[card_hash[:name].downcase.gsub(' ','_').to_sym] = card_hash
            end
        end
    end
end
Card.create(cards.map do |k,v| v end).each do |card|
    cards[card.name.downcase.gsub(' ','_').to_sym] = card
end

set.each do |path|
    File.open(path, 'r') do |file|
        xml = Nokogiri::XML(file.read)
        set_information = {
            name: xml.xpath('set').first['name'],
            id: xml.xpath('set').first['id']
        }
        set_information[:record] = Cardset.find_by_name set_information[:name]
        xml.xpath('set/cards/card').each do |card|
            card_record = Card.find_by_name card['name']
            printing = Printing.new cardset: set_information[:record]
            printing.card = card_record
            printing.art = "/images/#{set_information[:id]}/#{card['id']}.png"
            case card.xpath('property[@name="Rarity"]').first['value']
            when "Common"
                printing.rarity = 1
            when "Uncommon"
                printing.rarity = 2
            when "Rare"
                printing.rarity = 3
            when "Very Rare"
                printing.rarity = 4
            when "Super Rare"
                printing.rarity = 5
            when "Promo"
                printing.rarity = 5
            when "11BBR"
                printing.cardset = Cardset.find_by_short '11BBR'
                printing.rarity = 5
            end
            printing.save
        end
    end
end
