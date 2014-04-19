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
    :tvr => {name: 'Tatsurion vs. Razorkinder Battle Decks', short: '1TVR'},
    :ded => {name: 'The Dojo Edition', short: '2DED'},
    :ris => {name: 'Rise of the Duel Masters', short: '3RIS'},
    :evo => {name: 'Evo Fury', short: '4EVO'},
    :dra => {name: 'Dragon Master Collection Kit', short: '5DRA'},
    :dsi => {name: 'DragonStrike Infernus', short: '6DSI'},
    :cla => {name: 'Clash of the Duel Masters', short: '7CLA'},
    :tri => {name: 'Triple Strike', short: '8TRI'},
    :sha => {name: 'Shattered Alliances', short: '9SHA'},
    :inv => {name: 'Invasion Earth', short: '10INV'},
    :bbr => {name: 'Booster Brawl', short: '11BBR'},
    :mys => {name: 'The 5 Mystics', short: '12MYS'},
    :ga1 => {name: 'Quest for the Gauntlet', short: '13GA1'}
}
abilities = {
    #:blocker => {},
    #:protector => {},
    :double_breaker => {name: 'Double Breaker', text: '(This creature breaks 2 shields.)', icon: ''},
    :triple_breaker => {name: 'Triple Breaker', text: '(This creature breaks 3 shields.)', icon: ''},
    #:shield_blast => {},
    :fast_attack => {name: 'Fast Attack', text: '(This creature can attack on the turn it enters the battle zone.)', icon: ''},
    #:powerful_attack_1000 => {},
    :slayer => {name: 'Slayer', text: '(When this creature loses a battle, banish the other creature.)', icon: ''},
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
    abilities[ability.name.downcase.gsub(' ','_').to_sym] = ability
end


#__END__
demobugforce = Card.create name: 'Demo, the Megaenforcertoid',
    slug: 'demo_the_megaenforcertoid',
    power: 11500,
    cost: 12

demobugforce.ctype = Card.ctypes[:creature]
demobugforce.races << races[:enforcer]
demobugforce.races << races[:megabug]
demobugforce.races << races[:human]
demobugforce.civs << civs[:light]
demobugforce.civs << civs[:nature]
demobugforce.abilities << abilities[:double_breaker]
demobugforce.abilities << abilities[:fast_attack]

demobugforce.save

Printing.create([
    {card: demobugforce, cardset: sets[:sha], rarity: 5, flavor:  'Something or other', art: 'http://placekitten.com/100/300', illustrator: 'Someone', number: 'S5'},
    {card: demobugforce, cardset: sets[:tri], rarity: 5, flavor:  'Something or other', art: 'http://placekitten.com/100/300', illustrator: 'Someone', number: 'S5'}
])

pp demobugforce
pp demobugforce.races
pp demobugforce.civs
