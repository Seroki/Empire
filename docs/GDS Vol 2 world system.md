Volume II — World Systems: 
Based on Research into Original Evony Age I Mechanics

Research date: July 25, 2026
Sources: Evony Wiki (Fandom), official bbs.evony.com forum threads, fan guide blogs, player recollections
Corrections to Your Current Document

Before addressing gaps, three factual corrections to your existing Volume II:
1. "Mountain" valley type does not exist in Age I

The seven terrain types are: Flat, Grassland, Swamp, Lake, Hill, Desert, Forest (Evony Wiki – Valley). There is no "Mountain." Hill is the iron bonus tile.
2. Swamp has no "mixed resource bonus"

Every non-Flat valley type buffs exactly one resource:

    Lake → Food

    Swamp → Food (weaker than Lake, stronger than Grassland)

    Grassland → Food (weakest food bonus)

    Hill → Iron

    Desert → Stone

    Forest → Lumber

There is no mixed-bonus tile in Age I (Evony Wiki – Valley).
3. Map is toroidal, not bounded

The map tessellates — "there are no 'edges', but it keeps on repeating" (Evony Wiki – Map). This means distance calculations must account for wraparound.
Solution 1: World Map Definition
What the research found
Property	Value	Source
Map bounds	0,0 to 799,799 (800×800 = 640,000 tiles) on most servers; older servers possibly 500×500	Evony Wiki – Map
Coordinate format	X,Y, zero-padded 3-digit (e.g. 100,700)	Evony Wiki – Coordinates
Origin	0,0	Evony Wiki – Map
Wraparound	Toroidal — map repeats on all edges	Evony Wiki – Map
Tile scale	1 tile = 1 square mile	Evony Wiki – Coordinates
Subdivisions	16 states in a 4×4 grid, each 200×200 tiles (on 800-wide servers)	Evony Wiki – World Map
No fog of war	Entire map browsable; no hidden tiles	Evony Wiki – Map
Proposed Volume II data model

text
WorldConfig {
  map_width: 800
  map_height: 800
  origin: (0, 0)
  wraparound: true          // toroidal
  tile_scale: 1 mile²
  states: 16               // 4×4 grid, each 200×200
  state_names: [Friesland, Saxony, North March, Bohemia,
                Lower Lorraine, Franconia, Thuringia, Moravia,
                Upper Lorraine, Swabia, Bavaria, Carinthia,
                Burgundy, Lombardy, Tuscany, Romagna]
}

WorldTile {
  x: int (0-799)
  y: int (0-799)
  type: enum(Flat, Grassland, Swamp, Lake, Hill, Desert, Forest, NPC_City, Player_City)
  level: int (1-10)          // for valleys/flats; equals building level for NPCs
  owner_id: UUID?            // player who owns the city on this tile
  occupant_id: UUID?         // player who controls the valley
  state_id: int (0-15)
  spawn_protected: bool
  last_maintenance_at: timestamp
}

Toroidal distance formula

python
def tile_distance(x1, y1, x2, y2, map_size=800):
    dx = abs(x2 - x1)
    dy = abs(y2 - y1)
    # Wraparound: take the shorter path
    if dx > map_size / 2:
        dx = map_size - dx
    if dy > map_size / 2:
        dy = map_size - dy
    # Euclidean (most likely based on TKR formula evidence, though Age I exact metric is unconfirmed)
    return math.sqrt(dx*dx + dy*dy)

Note: The exact Age I distance metric (Euclidean vs Manhattan) could not be confirmed from any source. The modern TKR game uses Euclidean (Reddit r/Evony_TKR). An Age I combat calculator exists at dxcalc.com/age1 but does not expose its formula. Recommendation: Use Euclidean with toroidal wraparound as the default, and document this as an unconfirmed assumption.
Solution 2: Valley System — Complete Tables
Valley bonus percentages by type and level

Canonical table from the Evony Wiki Valley page, cross-referenced with bbs.evony.com – All About Resources:
Level	Flat	Grassland (Food)	Swamp (Food)	Lake (Food)	Hill (Iron)	Desert (Stone)	Forest (Lumber)
1	0%	3%	5%	8%	5%	5%	5%
2	0%	4%	7%	11%	7%	7%	7%
3	0%	5%	9%	14%	9%	9%	9%
4	0%	6%	11%	17%	11%	11%	11%
5	0%	7%	13%	20%	13%	13%	13%
6	0%	8%	15%	23%	15%	15%	15%
7	0%	9%	17%	26%	17%	17%	17%
8	0%	10%	19%	29%	19%	19%	19%
9	0%	11%	21%	32%	21%	21%	21%
10	0%	12%	23%	35%	23%	23%	23%

Derived formulas:

    Grassland: 2 + 1 × Level %

    Swamp / Hill / Desert / Forest: 3 + 2 × Level %

    Lake: 5 + 3 × Level %

    Flat: 0%

Valley cap per city

Valleys per city = Town Hall level (max 10). Confirmed by five independent sources (Evony Wiki – Town hall, bbs.evony.com thread 22859, Hods – Town Hall, Evony Avengers FAQ, bbs.evony.com thread 65413).
Town Hall Level	Max Valleys
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
Bonus stacking rules

    Additive on base production, per-city — Valley Bonus = sum(Valley_Bonus_Percent) × BASE_PRODUCTION (bbs.evony.com – All About Resources)

    Bonuses stack across identical types: 10 × Level 10 Forest = +230% lumber on base

    Bonuses apply only to the city that conquered the valley, not the player account

    Bonus is additive alongside other multipliers: Total = BASE + Politics_Bonus + Tech_Bonus + Valley_Bonus

Valley mechanics rules
Mechanic	Rule	Source
Occupation	Win battle against NPC defenders → automatic occupation (no separate button)	Evony Avengers FAQ
Garrison required?	No — bonus persists without troops stationed	Evony Wiki Q&A
Camped troops food cost	Double normal food upkeep	Evony Wiki Q&A
Abandoning	Town Hall → Valleys tab → Abandon; stationed troops return automatically	AlteredGamer
Stealing valleys	Yes — if ungarrisoned, 1 troop captures it	Evony Wiki Q&A
Defender regeneration	1 hour to full; tied to 6-minute server tick	bbs.evony.com – Medal Farming Guide, Hods – Getting Medals
Conquer-then-abandon	Resets garrison instantly	Evony Wiki – Medal Farming
Level cycling	+1 level per daily maintenance, caps at 10, resets to 1	Evony Wiki – Valley
Terrain type	Never changes	Evony Wiki Q&A
Plunder without occupying	If valley slots are full, you plunder resources instead of conquering	Evony Hookups
Teleporting loses valleys	Using any City Teleporter forfeits all owned valleys	Evony Wiki Q&A
BP interaction	Scouting/attacking valleys does not break Beginner's Protection	Evony Wiki – Valley
Valley defender compositions

No canonical per-level garrison table exists in any source. Valley garrisons are randomized per tile and re-rolled on scout/abandon/level-up (bbs.evony.com thread 122036). What is confirmed:

    Troop types: Warrior, Pikeman, Swordsman, Archer, Cavalry only — no fortifications

    Tech level = valley level: "Lv.4 valleys have all Lv.4 research for their troops" (Evony Wiki Q&A)

    Growth stages: L1-3 (weak), L4-6 (medium), L7-10 (strong) (bbs.evony.com thread 122036)

    Defending hero is re-rolled on each scout (bbs.evony.com thread 56832)

    Scale: L4 ~150 troops, L10 ~10,000-40,000 troops (varies wildly)

Proxy table — "Troops needed to win" (archers + 4 layers) from Evony Beginners Guide:
Valley Level	Archers	Warriors-only
1	50	700
2	100	1,300
3	200	1,800
4	400	2,400
5	750	3,200
6	1,500	3,800
7	3,000	5,200
8	7,500	9,000
9	n.a.	16,000
10	n.a.	22,000

Recommendation for your recreation: Generate valley garrisons procedurally using a randomized composition with min/max troop counts scaled by level. Use the growth-stage bands and the tech-level-equals-valley-level rule. Scouting should be required to reveal the actual garrison.
Solution 3: NPC City System — Complete Tables
NPC city troop compositions by level

From Evony Wiki – NPC, cross-referenced with iGaming Age 1:
NPC Level	Warrior	Pikeman	Swordsman	Archer	Cavalry
1	50	40	35	15	8
2	50	45	40	30	25
3	200	160	65	40	60
4	400	400	100	100	150
5	750	1,000	350	250	200
6	4,000	750	550	500	450
7	12,000	3,000	750	800	750
8	15,000	6,750	4,000	3,000	2,000
9	60,000	18,000	2,000	6,750	2,500
10	400,000	0	0	0	0

Key detail: Level 10 NPCs contain only 400,000 Warriors — no other troop types.
NPC city fortifications by level
NPC Level	Traps	Abatis	Archer Towers	Rolling Logs	Defensive Trebuchets
1	1,000	0	0	0	0
2	1,850	550	0	0	0
3	2,000	1,000	650	0	0
4	4,500	1,875	550	0	0
5	3,750	1,875	1,250	750	0
6	4,250	1,500	1,500	950	400
7	5,600	2,800	1,850	1,100	700
8	7,200	3,600	2,400	1,440	900
9	9,000	4,500	3,000	1,800	1,150
10	11,000	5,500	3,666	2,200	1,375

Critical threshold: Levels 1-5 have no Defensive Trebuchets (range 5,000), making zero-loss farming possible. Level 6+ always inflicts casualties (Evony Praetors).
NPC city resources by level
NPC Level	Food	Lumber	Stone	Iron	Gold	Total
1	100,000	20,000	20,000	20,000	55,000	215,000
2	200,000	30,000	30,000	30,000	65,000	355,000
3	900,000	75,000	75,000	75,000	75,000	1,200,000
4	1,600,000	120,000	120,000	120,000	300,000	2,260,000
5	3,000,000	180,000	180,000	180,000	450,000	3,990,000
6	4,000,000	200,000	200,000	200,000	600,000	5,200,000
7	4,500,000	500,000	500,000	500,000	800,000	6,800,000
8	8,000,000	800,000	800,000	800,000	1,000,000	11,400,000
9	14,000,000	550,000	550,000	550,000	1,200,000	16,850,000
10	19,000,000	600,000	600,000	600,000	1,500,000	22,300,000

NPCs have no Warehouse, so the full listed amount is plunderable (Evony Wiki – NPC).
NPC city wall level

All buildings in an NPC are at the NPC's own level — so a Level N NPC has Level N Walls (Evony Wiki – NPC, bbs.evony.com thread 86770). See the wall durability table in Solution 6.
NPC regeneration timers
Mechanic	Timer	Source
Resources full regen	8 hours	Evony Wiki – NPC
Troops + fortifications full regen	1 hour (10% per 6-minute server tick)	Evony Wiki – NPC
Instant wall unit respawn after battle	~18% of destroyed wall units return immediately	Evony Praetors
Max wall fortifications removable per attack	86%	Evony Praetors
Loyalty regen	+3 per 6-minute tick	Evony Praetors
Full-loot farming frequency	3 times/day (or 4× exploiting maintenance)	Evony Wiki – NPC
Experience farming frequency	24 times/day (troop regen hourly)	Evony Wiki – NPC
Player-built NPCs wiped at maintenance	Yes — all player-created NPCs revert to flats	Evony Wiki – Maintenance
NPC conquest rules

    Yes, NPC cities can be permanently conquered — requires a free city slot (title-gated) and loyalty driven to exactly 0 (bbs.evony.com thread 86770)

    Gates open at loyalty 5 — garrison joins the fight at that point (Evony Wiki Q&A)

    Level 1 NPC: ~20 waves, ~15 minutes to conquer

    Level 10 NPC: ~180,000 archers + 150,000 warriors + 6-10 heroes, ~2 hours (Evony Wiki – NPC/Conquer Level 10)

    NPCs never attack player cities (Evony Wiki – NPC)

    Capturing an NPC gives you all its level-N buildings, including 37 level-10 farms at L10

Proposed NPC data model

text
NPCCity {
  x, y: int
  level: int (1-10)
  troops: {
    warrior: int
    pikeman: int
    swordsman: int
    archer: int
    cavalry: int
  }
  fortifications: {
    traps: int
    abatis: int
    archer_tower: int
    rolling_log: int
    defensive_trebuchet: int
  }
  resources: { food, lumber, stone, iron, gold: int }
  wall_level: int          // = NPC level
  loyalty: int              // starts ~90, regen +3/tick
  defending_hero: Hero     // randomized, re-rolled on scout
  last_plundered_at: timestamp
  last_defeated_at: timestamp
}

Solution 4: March & Travel System
Troop speed table (Age I)

From Evony Wiki – Troops:
Unit	Speed (mi/hr)	Speed (mi/1000min)	Carry Load	Food Upkeep	Range
Worker	10.8	180	200	2	10
Warrior	12	200	20	3	20
Scout	180	3,000	5	5	20
Pikeman	18	300	40	6	50
Swordsman	16.5	275	30	7	30
Archer	15	250	25	9	1,200
Cavalry	60	1,000	100	18	100
Cataphract	45	750	80	35	80
Transporter	9	150	5,000	10	10
Ballista	6	100	35	50	1,400
Battering Ram	7.2	120	45	100	600
Catapult	4.8	80	75	250	1,500
March speed rules

    Slowest unit sets the pace for the entire march (bbs.evony.com – AGE ONE exp farming)

    No hero attribute modifies march speed in Age I — hero Attack affects combat, Intelligence affects scouting/defense, Politics affects production/construction (bbs.evony.com – A Guide to Heroes)

    Compass research enhances infantry movement speed (hods.com – Academy)

    Horseback Riding research enhances mounted/mechanical movement speed (scouts, cavalry, cataphracts, ballista, transporters, rams, catapults) (hods.com – Academy)

    Relief Station speeds up city-to-city travel up to 5×, determined by the sending city's Relief Station level (Evony Wiki Q&A)

    Exact per-level percentages for Compass, HBR, and Relief Station: n.a. — the wiki pages for these were robots-blocked and no other source publishes the numbers

Proposed travel time formula

Since the exact Age I formula was never published, reconstruct from empirical data:

python
def calculate_travel_time(distance_miles, slowest_unit_speed_mi_hr,
                          compass_level=0, hbr_level=0,
                          relief_station_level=0, is_city_to_city=False):
    # Base travel time in seconds (one-way)
    base_speed = slowest_unit_speed_mi_hr  # miles per hour
    
    # Apply research modifiers (estimated — exact % unknown)
    # Compass affects infantry; HBR affects mounted/mechanical
    if unit_is_infantry:
        speed_modifier = 1 + (compass_level * 0.05)  # estimated 5% per level
    else:
        speed_modifier = 1 + (hbr_level * 0.05)      # estimated 5% per level
    
    # Relief Station for city-to-city only
    if is_city_to_city and relief_station_level > 0:
        relief_multiplier = 1 + (relief_station_level * 0.4)  # up to 5× at level 10
    else:
        relief_multiplier = 1.0
    
    effective_speed = base_speed * speed_modifier * relief_multiplier
    
    # Travel time in seconds
    travel_time_seconds = (distance_miles / effective_speed) * 3600
    
    return travel_time_seconds

Important: The 5% per level for Compass/HBR and 0.4 per level for Relief Station are estimated placeholders. The real values could not be confirmed. The Relief Station's aggregate "up to 5×" is confirmed, so level 10 = 5× implies a linear 1 + 0.4 × level multiplier.
March slots and army size

March slots are governed by the Rally Spot level (bbs.evony.com – Rally Spot Limits, Evony Wiki – Rally spot):
Rally Spot Level	Simultaneous Marches	Army Size Limit
1	1	10,000
2	2	20,000
3	3	30,000
4	4	40,000
5	5	50,000
6	6	60,000
7	7	70,000
8	8	80,000
9	9	90,000
10	10	100,000

    War Ensign item increases army size limit by 25% (100,000 → 125,000 at L10) (Evony Wiki – Attacking)

    Camped and returning troops consume march slots (bbs.evony.com – Rally Spot Limits)

    Feasting Hall governs hero capacity (1 hero per level, max 10), not march slots (Evony Wiki – Feasting hall)

    Embassy governs incoming allied garrisons: +1 reinforcement wave per level (Evony Wiki – Embassy)

Logistics research — load capacity
Logistics Level	Transporter Load	Bonus
0	5,000	0%
1	5,500	10%
2	6,000	20%
3	6,500	30%
4	7,000	40%
5	7,500	50%
6	8,000	60%
7	8,500	70%
8	9,000	80%
9	9,500	90%
10	10,000	100%

Source: Evony Wiki – Transporter
March types and recall
Type	Hero Required	Key Rules
Attack	Yes	Army cap 10,000 × Rally Spot; return trip slower than outbound
Scout	No	Requires Scout troops; detail gated by Informatics vs target level
Transport	No	Equal speed both ways; requires food for march
Reinforce	No	Troops defend only; sender retains control; eats host city's food; Age I troops can starve

Recall methods (bbs.evony.com – How do I recall my troops?):

    Reports → Army Movement → Recall button

    Feasting Hall → Recall the hero

    Valley → Enter → Recall (for camped troops)

Interception: No — marches cannot be intercepted en route in Age I. The only en-route interference is via stratagem items that affect march duration or force recall (Evony Wiki – List of Stratagem items).
Solution 5: Combat Handoff Contract
The Age I damage formula

From evonyguideage1 – Combat Formula:
Nd=Na×Ab×R×A×(1−D1000)Ld
Nd​=Ld​Na​×Ab​×R×A×(1−1000D​)​
Symbol	Meaning
NdNd​	Defending units killed this round
NaNa​	Attacking units in the combat pair
AA	Attack value of attacking unit
AbAb​	Attack bonus (matchup multiplier)
RR	Ranged modifier (0.5 for ranged, 1.0 for melee)
DD	Defense value of defending unit
LdLd​	Life (HP) of defending unit
Attack bonus matchup table
Attacker → Defender	AbAb​
any → Worker	0.96
any → Scout	0.97
baseline	1.00
Swordsman → Pikeman	1.10
Cavalry/Cataphract → Archer	1.20
Pikeman → Cavalry/Cataphract	1.80
Archer/Ballista/Catapult → Cavalry	2.00
Round structure

From evony-tricks – Combat Mechanics:

    Battlefield length = longest base range of any unit present + 200 yards. If traps/abatis present, battlefield = ~5,000-5,200 yards.

    Each round: Move → Unit Battle → Fortification Battle

    Movement: fastest unit first (defender wins ties)

    Units don't move if they already have a target in range

    Melee targets highest total attack value in range

    Ranged targets enemy ranged first (Archer Towers priority), then fastest melee

    One troop type hits one troop type per round

    Both sides execute simultaneously; deaths subtracted at end of round

    Decimals round up; any unit losing 1 HP dies

    100-round rule: if attacker can't break walls in 100 rounds, attacker loses and hero loses 5 loyalty (Evony Wiki – Walls)

Hero effects in combat (Age I)
Hero Attribute	Combat Effect	Source
Attack	Attack bonus to all attacking troops; reduces training time	Evony Wiki – Hero
Intelligence	Increases defense as a percentage (capped at 50% damage reduction); 50 INT turns def 50→75; 100 INT doubles it	bbs.evony.com – Combat Calculator
Politics	Not relevant to combat; affects production and construction	Evony Wiki – Stats

Exact numeric hero-attack damage formula for Age I: n.a. — only Age II formulae are documented.
Proposed combat handoff contract

text
// World System provides to Combat System:
CombatRequest {
  attacker_march: March          // troops, hero, items
  defender_tile: WorldTile       // terrain, owner, level
  defender_troops: TroopStack    // city garrison or valley garrison
  defender_fortifications: FortStack  // walls, traps, ATs, etc.
  defender_hero: Hero?
  terrain_type: enum
  defender_tech_level: int       // = valley/NPC level for non-player tiles
  timestamp: timestamp
}

// Combat System returns to World System:
CombatResult {
  winner: enum(Attacker, Defender, Draw)
  attacker_losses: TroopStack    // per-unit-type killed
  defender_losses: TroopStack
  attacker_wounded: TroopStack   // healable in Medic Camp
  defender_wounded: TroopStack
  fortifications_destroyed: FortStack
  plunder: { food, lumber, stone, iron, gold: int }
  occupation_result: enum(None, Plundered, Valley_Captured, Loyalty_Decreased, City_Captured)
  loyalty_change: int           // for city attacks
  hero_xp_gained: int
  battle_report: BattleReport
}

Solution 6: Walls & Fortifications
Wall level table

From Evony Wiki – Walls:
Wall Level	Durability	Fortified Spaces
1	10,000	1,000
2	30,000	3,000
3	60,000	6,000
4	100,000	10,000
5	150,000	15,000
6	210,000	21,000
7	280,000	28,000
8	360,000	36,000
9	450,000	45,000
10	550,000	55,000

Level 10 walls require Michelangelo's Script item.
Fortification types
Fortification	Unlocked at Wall	Space Cost	Attack	Range	Key Behavior
Trap	1	1	n.a.	5,000	Only affects workers, warriors, scouts, archers, swordsmen
Abatis	2	2	n.a.	5,000	Only affects mounted units (cav, cataphract)
Archer Tower	3	3	300	1,300	Range = ((Wall_Lvl + Archery) × 0.05 + 1) × 1300
Rolling Log	5	4	500	1,300	One-shot per attack
Defensive Trebuchet	7	5	800	5,000	One-shot; Machinery research enables regeneration
Gate control

The Rally Spot has an "Open gate to fight" checkbox:

    Open = garrison joins wall defenses in battle

    Closed = only fortifications fight; troops stay safe in barracks (Evony Wiki – Rally spot)

Solution 7: Scouting & Visibility
No fog of war

The entire map is browsable — all tiles, cities, and valleys are visible. However, troop counts and city internals require scouting (Evony Wiki – Map, Evony Wiki – Scouting).
Visibility matrix
Target	Visible Without Scouting	After Scouting
Own city	Everything	N/A
Alliance city	Owner, coords, flag color	Requires permission
Enemy city	Owner, coords, flag color, status (Truce/Peacetime), prestige, honor, rank, title, alliance	Troops, wall level, fortifications, resources, hero
NPC city	Level, coords	Troop composition, fortifications, resources
Valley	Type, level, coords, owner (if occupied)	Defender composition, hero level
Incoming march	See Beacon Tower table below	N/A
Flag colors

    Green = your alliance

    Blue = friendly

    Red = at war

    Black/grey = neutral/plunderable

Scout report detail gating

    Informatics must be ≥ target level for any information

    Below target level: no information

    Equal to target level: vague word descriptions (Few, Pack, Lots, Horde, Throng, Swarm, Zounds, Legion, Bulk, Giga)

    Above target level: exact numbers

    Send 10 scouts per target level for best detail (Evony Wiki – Scouting)

Vague troop-count scale
Word	Count Range
Few	1–24
Pack	25–49
Lots	50–99
Horde	100–249
Throng	250–499
Swarm	500–999
Zounds	1,000–2,499
Legion	2,500–4,999
Bulk	5,000–9,999
Giga	10,000+
Beacon Tower — incoming attack intelligence
Beacon Tower Level	Information Revealed
1	Pre-informed of invasion
2	Enemy's purpose
3	Arrival time
4	Enemy Lord's status
5	Departure location
6	Troop types (arms branch)
7	Approximate numbers
8	Exact numbers
9	Hero level leading the charge
10	Enemy's military technology level

Source: Evony Wiki – Beacon tower
Solution 8: Occupation & Ownership Transitions
City attack outcomes — three distinct actions
Action	Definition	Key Requirements
Plunder	Win battle, haul resources home	Enough carrying capacity (transporters/workers)
Conquer	Grind loyalty to 0, take ownership	Free city slot (title-gated); can't take last city
Colonize	Found a new city on an empty Flat	Knight title, 250 workers, 10,000 of each resource
City conquest mechanics

From bbs.evony.com – Lowering loyalty and Evony Wiki Q&A:

    Clear wall defenses first

    ~5,000 warriors per wave drops loyalty 2-4 points (modified by defender's Iron Working)

    From loyalty 15 down, loyalty decreases 1 point per 6 minutes regardless of wave count — space waves 6 minutes apart

    Gates open at loyalty 5 — garrison joins the fight; city becomes conquerable

    Loyalty 0 → city becomes yours

    Surviving traps/abatis transfer to the new owner

    Cannot conquer a player's last city

    Conquered city can be deleted → becomes an NPC

    "Scout spamming" (1 scout + 1 hero per wave) is the classic loyalty-grinding technique

Ownership transition table
Action	Target	Possible Outcomes
Attack player city	Player city (loyalty > 0)	Plunder resources / reduce loyalty
Attack player city	Player city (loyalty = 0)	Conquer city (if free slot available)
Attack player city	Player's last city	Can plunder/reduce loyalty but cannot conquer
Attack NPC city	NPC city (loyalty > 0)	Plunder resources / reduce loyalty
Attack NPC city	NPC city (loyalty = 0)	Conquer city permanently
Attack unoccupied valley	Valley	Occupy (if valley slot available) / Plunder (if slots full)
Attack occupied valley	Valley (ungarrisoned)	Capture with 1 troop
Attack occupied valley	Valley (garrisoned)	Must defeat garrison in battle
Protection mechanics
Mechanic	Duration	Rules
Beginner's Protection	7 days from account creation	Can't be attacked; can't attack cities; can attack NPCs/valleys; own valleys exposed; ends early if any Town Hall reaches level 5
Truce Agreement	12 hours	Can't attack or be attacked; 12-hour cooldown; doesn't protect valleys; one truce covers all cities; can't activate if troops are marching
Last city immunity	Permanent	Player's final city cannot be conquered

Sources: Evony official tutorial, Evony Wiki – Questions and Answers, bbs.evony.com – Age I vs Age II
Solution 9: Teleport & Relocation
Item	Effect	Cost	Restrictions
City Teleporter	Random location within chosen state	30 cents	Flats only; must be empty; recall all troops first
Adv City Teleporter	Teleport to exact coordinates	90 cents	Flats only; must be empty; recall all troops first

Both teleporters:

    Lose all owned valleys/flats

    24-hour march lockout after use (no scouting, transporting, attacking, reinforcing)

    City is still attackable during the lockout

    Cannot be trading/exporting/building

Sources: Evony Wiki – Adv City Teleporter, Evony Secrets Vol. 8, se7ensins Age 1 Guide
Solution 10: World Generation
What is confirmed

    Servers are independent worlds with their own maps (Evony Wiki – Servers)

    Historic cities (Age II) are on a deterministic grid; everything else is server-specific: "All the maps are the same in terms of Historic Cities, but Valleys, Cities, and NPCs are different" (Evony Wiki – Servers)

    16 states in a 4×4 grid, each 200×200 tiles

    Players choose their state at account creation; exact tile within the state is assigned (Armor Games Age I Guide)

    No separate beginner zone — protection is time/TH-level-based, not zone-based

    Valley/flat level cycling: +1 per daily maintenance, caps at 10, resets to 1

    Player-built NPCs are wiped at maintenance and revert to flats

    No seasons, no scheduled resets; servers merge instead of wiping

    Tile distribution percentages, total flat count, total NPC count: n.a. — no source publishes these

Proposed world generation parameters

text
WorldGenerationConfig {
  seed: int                    // for reproducibility
  map_width: 800
  map_height: 800
  states: 16                   // 4×4 grid
  
  // Tile distribution (estimated — no source confirms actual percentages)
  // Based on gameplay descriptions of the map being "mostly valleys with
  // scattered flats, NPCs, and player cities"
  tile_distribution: {
    grassland: 25%,            // food bonus
    forest: 15%,               // lumber bonus
    hill: 10%,                 // iron bonus
    desert: 10%,               // stone bonus
    lake: 8%,                  // food bonus (best)
    swamp: 7%,                 // food bonus
    flat: 20%,                 // buildable
    npc_city: 5%               // AI cities
  }
  
  // NPC city level distribution (estimated from gameplay guides)
  npc_level_distribution: {
    L1: 25%, L2: 20%, L3: 15%, L4: 12%, L5: 10%,
    L6: 7%, L7: 5%, L8: 3%, L9: 2%, L10: 1%
  }
  
  // Valley level distribution (starts at L1, cycles daily)
  initial_valley_levels: random(1, 5)  // fresh servers start low
  
  // Placement constraints
  min_npc_spacing: 10 tiles     // estimated — no grid rule documented for Age I
  spawn_protection_radius: 0    // protection is time-based, not zone-based
  
  // State assignment
  player_chooses_state: true
  player_chooses_tile: false    // assigned randomly within state
}

Solution 11: Server Tick Model
The 6-minute tick

All server-regeneration mechanics are tied to a 6-minute server tick — the same moment that taxes/gold, loyalty, and population update (Evony Wiki Q&A):
Tick Event	Effect
NPC troop regen	10% of maximum per tick (full in 1 hour / 10 ticks)
NPC resource regen	12.5% of maximum per tick (full in 8 hours / 80 ticks)
NPC loyalty regen	+3 per tick
Valley defender regen	Tied to same tick; full regen in 1 hour
City loyalty change	+1 per tick (from loyalty 15 downward during conquest)
Wall fortification instant respawn	~18% of destroyed units return immediately after battle
Proposed server architecture

text
ServerTick {
  interval: 6 minutes
  
  on_tick:
    1. Update all NPC cities: troops +10%, resources +12.5%, loyalty +3
    2. Update all valleys: defender regen toward full
    3. Process city loyalty changes (+1 for cities under attack)
    4. Update tax/gold/population for all cities
    5. Process wounded troop attrition (~10% of unhealed wounded die per hour)
  
  on_daily_maintenance:
    1. Valley/flat level cycling: +1 (reset to 1 at 10)
    2. Wipe all player-built NPCs → revert to flats
    3. Refill all NPC cities to full resources
    4. Delete inactive accounts (< 10,000 prestige after 7 days; < 5,000 prestige after 60 days)
}

Solution 12: Reinforcement Mechanics

From Evony Wiki – Reinforce and bbs.evony.com – reinforcing an ally's city:
Rule	Detail
Host requirement	Embassy with "Allows troops of allied members to garrison" checked
Embassy level	+1 reinforcement wave per level (1-10)
Combat role	Reinforcing troops can only defend — cannot attack
Control	Sender retains control; host cannot command them
Recall	Sender recalls via Reports → Army Movement → Recall, or Feasting Hall → Recall hero
Food	Reinforcements eat the host city's food; in Age I, troops can starve to death
Gate interaction	Reinforcements only fight if host has gates open
Own-city reinforcement	Troops sent to your own city cannot be recalled — must be sent back with a new march
Valley reinforcement	Troops can reinforce your own valleys; eat double food while camped
Solution 13: Items & Stratagems Affecting World

From Evony Wiki – List of Stratagem items:
Item	Effect	Cost
Item	Effect	Cost
Cicada Sheds Its Skin	Increase troops' returning speed by 30%	40
Entrapping	Increases opponent's troops marching duration by 30%	30
Bluffing	Marching troops appear 5-10× bigger, 12 hours	15
Besiege Enemy's Fort to Rescue Ally's City	Troops sent from affected city are recalled compulsorily	90
Ambush from All Sides	Troops in affected city cannot be deployed for 2 hours	15
War Ensign	Army size limit +25%	—
Truce Agreement	12 hours of peace	30
Summary: What Could Not Be Confirmed (n.a.)

These values could not be found in any surviving Age I source and will need to be estimated or reverse-engineered for your recreation:
Gap	Status	Recommendation
Exact Age I march-time formula	n.a.	Reconstruct from troop speed table + Euclidean distance
Age I distance metric (Euclidean vs Manhattan)	n.a.	Use Euclidean with toroidal wraparound (TKR uses Euclidean)
Compass % speed bonus per level	n.a.	Estimate 5% per level (10 levels = 50% total)
Horseback Riding % speed bonus per level	n.a.	Estimate 5% per level
Relief Station per-level speed table	n.a.	Linear interpolation: L1 = 1.4× → L10 = 5.0×
Hero attribute → march speed	n.a. (no effect in Age I)	Do not implement hero speed bonuses on marches
Exact Age I hero-attack combat formula	n.a.	Use Age II formula as base, adapt for Age I INT=defense rule
Valley defender composition per level	n.a. (randomized)	Procedurally generate with level-based min/max ranges
Tile distribution percentages	n.a.	Estimate from gameplay descriptions
Total NPC count per server	n.a.	Procedurally place based on density parameter
Whether owned valley level keeps cycling after capture	n.a.	Implement as: frozen at capture level (safer design choice)
Trap/Abatis numeric attack values	n.a.	Only range (5,000) is confirmed; assign reasonable attack values
Complete battle report field list	n.a.	Design from combat result schema
Priority Implementation Order

    World tile model — 800×800 toroidal grid, 16 states, tile types

    Valley bonus tables — the confirmed 7-type × 10-level matrix with formulas

    NPC city tables — troops, fortifications, resources, regen timers

    March system — Rally Spot slots, troop speeds, load capacity, travel formula

    Combat handoff contract — damage formula, round structure, hero effects

    Scouting system — Informatics gating, word scale, Beacon Tower table

    Ownership transitions — plunder vs conquer vs colonize, loyalty mechanics

    Server tick model — 6-minute tick, daily maintenance, regen rates

    Protection mechanics — 7-day BP, Truce Agreement, last-city immunity

    Teleport system — City Teleporter vs Adv City Teleporter rules

    World generation — tile distribution, NPC placement, valley cycling

    Fill n.a. gaps — estimate unconfirmed values, document as assumptions
