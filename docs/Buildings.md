### Executive Summary & System Notes

**Volume III — Buildings** forms the structural and logistical foundation of the *Evony Age I* game loop. In the original Flash/Java client engine, buildings served as hard dependency gates, queue managers, resource sinks, and spatial constraints.

#### Key Architectural Rules for Recreation:

1. **Mathematical Base Scaling:**
* **Resource Costs:** Standard buildings scale exponentially using a standard base formula of $C_{L} = C_{1} \times 2^{L-1}$ for resources, with specialized primary structures (like Town Hall and Academy) following fixed historic scaling curves.
* **Construction Time:** Time in seconds follows:

$$\text{Time} = \frac{\text{Total Resources}}{1000} \times 3600 \times (0.95^{\text{Construction Tech}}) \times \left(1 - \frac{\text{Mayor Politics}}{100}\right)$$




2. **Item Gates (Michelangelo's Script):**
* Upgrading **any** building or structure to **Level 10** requires exactly 1× **Michelangelo's Script** (Item ID: `item_michelangelo_script`).


3. **Queue Architecture:**
* Standard building queues allow only **1 active construction job per city** at a time (unless accelerated or expanded via specific items like Bernini's Hammer).


4. **Demolition / Downgrade Logic:**
* Demolishing a building returns $0\%$ resources but frees up structural space and city land slots. Level-by-level deconstruction takes time equal to half the construction time of that level.



---

# 📘 **Volume III — Buildings (Full Mechanical Reference)**

---

## **1. Town Hall**

### **Description**

The central administrative hub of the city. It governs land expansion, city status, taxation, field allocations, and structural limits across all other city plots.

### **Purpose**

Controls max building levels in the city, total field plots available in the outer perimeter, maximum valley conquest allowance, tax collection, and beginner protection status.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 200 | Wood: 3,000 | Stone: 2,500 | Iron: 100
* **Level 2:** Food: 400 | Wood: 6,000 | Stone: 5,000 | Iron: 200
* **Level 3:** Food: 800 | Wood: 12,000 | Stone: 10,000 | Iron: 400
* **Level 4:** Food: 1,600 | Wood: 24,000 | Stone: 20,000 | Iron: 800
* **Level 5:** Food: 3,200 | Wood: 48,000 | Stone: 40,000 | Iron: 1,600
* **Level 6:** Food: 6,400 | Wood: 96,000 | Stone: 80,000 | Iron: 3,200
* **Level 7:** Food: 12,800 | Wood: 192,000 | Stone: 160,000 | Iron: 6,400
* **Level 8:** Food: 25,600 | Wood: 284,000 | Stone: 320,000 | Iron: 12,800
* **Level 9:** Food: 51,200 | Wood: 768,000 | Stone: 640,000 | Iron: 25,600
* **Level 10:** Food: 102,400 | Wood: 1,536,000 | Stone: 1,280,000 | Iron: 51,200 + 1× Michelangelo's Script

### ** Starting Package**

* **Workers 200

### **Upgrade Scaling**

* **Resource Field Slots:** $+3$ Outer Field Slots per level (Level 1 = 3 slots, Level 10 = 30 slots + 1 bonus = 31 total fields).
* **Valley Capacity:** $+1$ conquerable Valley Slot per level (Cap $= \text{Town Hall Level}$).
* **Building Level Cap:** Max level of any other building $= \text{Town Hall Level}$.

### **Effects**

* Sets maximum building tier cap for the host city.
* Grants tax rate controls ($0\% \text{ to } 100\%$) yielding Gold hourly based on Population.
* Allows Levy actions (Food, Wood, Stone, Iron, Gold) once every 15 minutes at the cost of Public Grievance.

### **Dependencies**

* None (Default main structure).

### **Unlocks**

* **Town Hall 1:** Cottage, Resource Fields, Inn, Rally Spot, Feasting Hall, Marketplace, Academy.
* **Town Hall 2:** Warehouse, Barracks, Walls, Forge.
* **Town Hall 3:** Embassy, Beacon Tower.
* **Town Hall 5:** Stable (Requires Barracks 5).
* **Town Hall 7:** Workshop (Requires Forge 5).

### **UI**

* **Main Overview:** Shows Tax Rate slider, Public Loyalty, Public Grievance, Max Population, Current Gold Income.
* **Valleys Tab:** List of controlled wilderness plots with direct coordinates and abandon options.
* **Levy/Comforting Tab:** Buttons for Levy Resources and Comforting actions (Disaster Relief, Grand Feast, Tax Relief, Pray).

### **Original Age I Behavior**

* Upgrading Town Hall to **Level 5** immediately breaks **Beginner's Protection** status regardless of the 7-day timer.
* Tax Rate directly adjusts Population over time according to:

$$\text{Target Loyalty} = 100 - \text{Tax Rate} - \text{Public Grievance}$$



### **Notes for Recreation**

* Must implement hard check on upgrading to Level 5 to throw a prompt warning the user that Beginner's Protection will terminate.
* Must enforce `Max_Building_Level <= Town_Hall_Level`.

---

## **2. Cottage**

### **Description**

Residential structure providing shelter for citizens who perform labor, generate taxes, and enlist in military forces.

### **Purpose**

Increases Maximum Population capacity of the city.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 100 | Wood: 500 | Stone: 100 | Iron: 50
* **Level 2:** Food: 200 | Wood: 1,000 | Stone: 200 | Iron: 100
* **Level 3:** Food: 400 | Wood: 2,000 | Stone: 400 | Iron: 200
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* **Population Base:**
* Level 1: 100
* Level 2: 200
* Level 3: 300
* Level 4: 500
* Level 5: 800
* Level 6: 1,200
* Level 7: 1,700
* Level 8: 2,300
* Level 9: 3,000
* Level 10: 5,000



### **Effects**

* Increases maximum population capacity.
* Increases available idle labor pool for resource field production.

### **Dependencies**

* Town Hall 1

### **Unlocks**

* Indirectly gates troop training (troops consume active population upon queue creation).

### **UI**

* Shows current cottage population contribution, total population limit, and upgrade costs.

### **Original Age I Behavior**

* Population regenerates dynamically every server tick toward Target Population:

$$\text{Target Population} = \text{Max Population} \times \left(\frac{\text{Loyalty}}{100}\right)$$



### **Notes for Recreation**

* Multiple Cottages can be built in city slots. Total Population Cap = $\sum (\text{Cottage Limits})$.

---

## **3. Warehouse**

### **Description**

Reinforced storage structure designed to safeguard resources from enemy plundering during city raids.

### **Purpose**

Protects a base amount and percentage of Food, Wood, Stone, and Iron from being stolen when a city's defenses fall.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 200 | Wood: 1,000 | Stone: 1,000 | Iron: 500
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* **Protected Units:**
* Level 1: 10,000 per resource
* Level 2: 20,000 per resource
* Level 3: 40,000 per resource
* Level 4: 80,000 per resource
* Level 5: 160,000 per resource
* Level 6: 320,000 per resource
* Level 7: 640,000 per resource
* Level 8: 1,280,000 per resource
* Level 9: 2,560,000 per resource
* Level 10: 5,000,000 per resource



### **Effects**

* Safeguards resource quantities up to capacity.
* Stockpile Research increases protected proportion by $+10\%$ per research level.

### **Dependencies**

* Town Hall 2

### **Unlocks**

* None

### **UI**

* Sliders allowing players to distribute total protection allocation percentages across Food, Wood, Stone, and Iron (default $25\%$ each).

### **Original Age I Behavior**

* Plunder math checks Warehouse protection before calculating troop load limits. Protected resources cannot be taken under any circumstance.

### **Notes for Recreation**

* Ensure protection allocation sliders sum to exactly $100\%$.

---

## **4. Barracks**

### **Description**

Military training facility responsible for enlisting and equipping infantry units and scouts.

### **Purpose**

Trains Workers, Warriors, Scouts, Pikemen, Swordsmen, and Archers.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 200 | Wood: 500 | Stone: 800 | Iron: 300
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* **Queue Slots:** Each Barracks Level allows longer single-queue training capacities.
* **Speed:** Training speed increases by $1\%$ per Barracks level.

### **Effects**

* High-tier infantry units require specific Barracks level thresholds.

### **Dependencies**

* Town Hall 2

### **Unlocks**

* **Barracks Level 1:** Worker, Warrior
* **Barracks Level 2:** Scout (Requires Informatics 1)
* **Barracks Level 3:** Pikeman (Requires Iron Working 1)
* **Barracks Level 4:** Swordsman (Requires Iron Working 2)
* **Barracks Level 5:** Archer (Requires Archery 2)

### **UI**

* Grid selection of available infantry units, unit stats, total buildable quantity calculation, population requirements, and queue progress bar.

### **Original Age I Behavior**

* Having multiple Barracks in a single city allows **parallel training queues**. Players standardly built 12–15 Barracks per city for mass unit production.

### **Notes for Recreation**

* Training time formula:

$$\text{Training Time} = \frac{\text{Base Unit Time}}{(1 + \text{Mayor Attack} \times 0.01 + \text{Military Science} \times 0.10)}$$



---

## **5. Stable**

### **Description**

Equestrian military complex dedicated to breeding, equipping, and training mounted combat units.

### **Purpose**

Trains Cavalry and Cataphract units.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 1,000 | Wood: 2,000 | Stone: 3,000 | Iron: 2,000
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Reduces training time of mounted units.
* Gates maximum technology level of Horseback Riding.

### **Effects**

* Unlocks mounted troop production.

### **Dependencies**

* Town Hall 5
* Barracks Level 5

### **Unlocks**

* **Stable Level 1:** Cavalry (Requires Horseback Riding 3)
* **Stable Level 3:** Cataphract (Requires Horseback Riding 5, Iron Working 6)

### **UI**

* Mounted unit training queue interface with resource cost summaries.

### **Original Age I Behavior**

* Stables are single-instance per city (cannot build multiple Stables in one city).

### **Notes for Recreation**

* Ensure building validation enforces maximum 1 Stable per city.

---

## **6. Workshop**

### **Description**

Heavy engineering yard specializing in the construction of siege engines and war machines.

### **Purpose**

Produces Transporters, Ballistas, Battering Rams, and Catapults.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 2,000 | Wood: 10,000 | Stone: 10,000 | Iron: 5,000
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Unlocks higher siege engine tiers and decreases production build time.

### **Effects**

* Required prerequisite for Engineering and Machinery research in Academy.

### **Dependencies**

* Town Hall 7
* Forge Level 5

### **Unlocks**

* **Workshop Level 1:** Transporter (Requires Logistics 2)
* **Workshop Level 2:** Ballista (Requires Archery 6, Metal Casting 5)
* **Workshop Level 5:** Battering Ram (Requires Engineering 5)
* **Workshop Level 10:** Catapult (Requires Archery 10, Metal Casting 10)

### **UI**

* Siege equipment manufacturing screen showing individual unit carry capacities, speeds, and range statistics.

### **Original Age I Behavior**

* Workshop Level 10 is one of the highest endgame gates due to the requirement for Catapult production and level 10 Wall defenses.

### **Notes for Recreation**

* Single-instance per city structure limit.

---

## **7. Forge**

### **Description**

Metallurgical forge that develops advanced armaments and structural materials for city growth.

### **Purpose**

Acts as an intermediate prerequisite building for heavy military and siege development.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 500 | Wood: 2,000 | Stone: 3,000 | Iron: 3,000
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Unlocks prerequisite gates for Workshop and advanced research levels (Metal Casting, Iron Working).

### **Effects**

* Prerequisite for Workshop construction and high-tier armor/weapon tech.

### **Dependencies**

* Town Hall 4

### **Unlocks**

* Workshop (at Forge Level 5)
* Metal Casting research (Academy)
* Iron Working research (Academy)

### **UI**

* Status panel displaying current forge level and dependent tech unlocks.

### **Original Age I Behavior**

* Forge has no active queue of its own; it acts purely as a structural gate.

### **Notes for Recreation**

* Often demolished late-game by players if space is needed for additional Barracks, but **must be preserved** if players plan to upgrade Workshops further.

---

## **8. Marketplace**

### **Description**

Commercial trade center enabling resource buy/sell orders and commercial shipments between cities.

### **Purpose**

Facilitates open-market resource trading using Gold and controls resource transit batches.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 200 | Wood: 1,000 | Stone: 1,000 | Iron: 200
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* **Trade Capacity:** $+10,000$ resource unit trading volume limit per level per transaction.
* **Concurrent Deals:** $+1$ active market order slot per level.

### **Effects**

* Enables buying and selling of Food, Wood, Stone, and Iron for Gold.
* Transaction fee scales down with higher Market levels / Commerce research.

### **Dependencies**

* Town Hall 3

### **Unlocks**

* Resource market trading system.

### **UI**

* **Buy/Sell Tabs:** Real-time market order book, offer placement inputs, price history, transaction tax indicator.

### **Original Age I Behavior**

* Uses a global server-wide order book where players set unit prices. Includes a $0.5\%$ transaction tax per deal.

### **Notes for Recreation**

* Server market system requires explicit transaction locking to prevent duping during concurrent buy/sell fulfillment.

---

## **9. Academy**

### **Description**

Center of academic and technological research. Technologies researched apply to all cities owned by the player, provided the local city's Academy meets level requirements.

### **Purpose**

Researches production, combat, mobility, and defensive technologies.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 120 | Wood: 2,500 | Stone: 1,500 | Iron: 200
* **Level 2:** Food: 240 | Wood: 5,000 | Stone: 3,000 | Iron: 400
* **Level 3:** Food: 480 | Wood: 10,000 | Stone: 6,000 | Iron: 800
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Gates local activation level of globally researched technologies.

### **Effects**

* Enables technological research queue.
* **Local Tech Activation Rule:** If player has global Archery Level 10, but City B only has Academy Level 4, City B only receives benefits of Archery Level 4 until the Academy is upgraded.

### **Dependencies**

* Town Hall 2

### **Unlocks**

* Full Research Tree (Agriculture, Lumbering, Masonry, Mining, Metal Casting, Informatics, Military Science, Military Tradition, Horseback Riding, Archery, Logistics, Compass, Construction, Medicine, Iron Working, Engineering, Machinery, Stockpile, Privateering).

### **UI**

* **Tech Tree Interface:** Lists all technologies, current global level, local effective level, requirement tree, research costs, and active queue timer.

### **Original Age I Behavior**

* Research speed is significantly enhanced by assigning a High-Intelligence Mayor to the Feasting Hall before starting research.

### **Notes for Recreation**

* Always check `Effective_Tech_Level = MIN(Global_Player_Tech_Level, Local_City_Academy_Level)`.

---

## **10. Embassy**

### **Description**

Diplomatic headquarters enabling alliance integration, member communications, and allied troop housing.

### **Purpose**

Allows allied alliance members to station defensive garrison armies inside your city.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 200 | Wood: 1,000 | Stone: 500 | Iron: 200
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* **Garrison Capacity:** Allows $+1$ max allied march wave and increased unit caps per level (Level 1 = 1 wave / 10k troops, Level 10 = 10 waves / 100k troops total).

### **Effects**

* Unlocks alliance creation/joining functionality.
* Provides direct garrison housing for allied troops.

### **Dependencies**

* Town Hall 3

### **Unlocks**

* Alliance System integration, Allied Troop Stationing.

### **UI**

* Alliance Overview, List of Stationed Allied Troops, Option to expel/return allied garrisons.

### **Original Age I Behavior**

* **Crucial Mechanic:** Stationed allied troops consume Food directly from the **host city's food supply**, not the sender's! If the host runs out of food, allied troops will starve/refugee.

### **Notes for Recreation**

* Ensure host city tick calculations account for `Host_Troop_Upkeep + Stationed_Allied_Troop_Upkeep`.

---

## **11. Inn**

### **Description**

Tavern and lodging area where traveling Heroes congregate looking for employment.

### **Purpose**

Generates candidate Heroes for recruitment.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 100 | Wood: 500 | Stone: 500 | Iron: 100
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Higher Inn levels yield higher base stats and level ranges for recruiting Heroes in the recruitment list.

### **Effects**

* Refreshes available recruitment pool automatically or via dynamic items (e.g., Portrait Table).

### **Dependencies**

* Town Hall 1

### **Unlocks**

* Hero Recruitment.

### **UI**

* Candidate Hero roster displaying Hero Name, Level, Base Politics, Base Attack, Base Intelligence, Salary, and Gold Recruitment Cost.

### **Original Age I Behavior**

* Hero refresh timer generates new candidates every hour. Stat distribution is randomized based on weighted rolls.

### **Notes for Recreation**

* Formula for recruitment cost:

$$\text{Gold Cost} = \text{Hero Level} \times 1000$$



---

## **12. Feasting Hall**

### **Description**

Command headquarters where recruited Heroes reside, gain experience, and are assigned duties.

### **Purpose**

Stores owned Heroes, manages assignments (Mayor, March Captain), handles salary payment, and upgrades attributes.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 500 | Wood: 1,000 | Stone: 1,000 | Iron: 500
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* **Hero Capacity:** Allows $+1$ Hero slot per level (Level 1 = 1 Hero, Level 10 = 10 Heroes).

### **Effects**

* Allows Mayor appointment to govern the city:
* **Politics:** Increases resource production rate and decreases building construction time.
* **Attack:** Decreases troop training time in Barracks/Stables/Workshops.
* **Intelligence:** Decreases research time in Academy and increases scouting success rates.



### **Dependencies**

* Town Hall 1
* Inn Level 1

### **Unlocks**

* Mayor Assignment, Hero Command.

### **UI**

* **Hero List:** Status (Idle, Mayor, Marching), Base Stats, Loyalty, Salary, Upgrade Stat buttons, Reward button.

### **Original Age I Behavior**

* If Hero loyalty drops below 20 (due to unpaid hourly salary or losing battles), the Hero risks deserting upon defeat.

### **Notes for Recreation**

* Must track individual hero hourly salaries:

$$\text{Hourly Gold Cost} = \text{Hero Level} \times 100$$



---

## **13. Rally Spot**

### **Description**

Military dispatch center governing march logistics, troop movements, exercise simulations, and gate operations.

### **Purpose**

Controls max dispatchable march waves, troop troop limits per march, target dispatching, and City Defense Gate states.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 200 | Wood: 500 | Stone: 500 | Iron: 200
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* **March Slots:** $+1$ Simultaneous March Slot per level (Level 1 = 1 march, Level 10 = 10 marches).
* **Troop Limit per March:**

$$\text{Max Troop Cap} = \text{Rally Spot Level} \times 10,000$$



*(Can be expanded to 125,000 with War Ensign item)*.

### **Effects**

* Houses the **Open/Closed Gate Toggle** switch.
* Contains Military Exercise simulator.

### **Dependencies**

* Town Hall 1

### **Unlocks**

* March Dispatch System, Gate Defense controls.

### **UI**

* **March Screen:** Target coordinates, mission selector (Scout, Transport, Reinforce, Attack, Reclaim), unit counters, hero selector.
* **Gate Switch:** Checkbox for "Open Gate to Fight".
* **War Operations:** Overview of incoming/outgoing movements.

### **Original Age I Behavior**

* **Gate Logic:** If the Gate is **CLOSED**, incoming attacks fight **ONLY** Wall Fortifications (Archer Towers, Traps, etc.). Land troops sit idle and suffer no casualties unless all fortifications are wiped and loyalty reaches zero. If Gate is **OPEN**, city garrison troops join the battle on Round 1.

### **Notes for Recreation**

* Gate state must be evaluated instantly upon combat tick resolution.

---

## **14. Beacon Tower**

### **Description**

Early warning observation post that detects approaching enemy marches and analyzes their composition.

### **Purpose**

Provides detailed warning alerts and intel metrics on incoming hostiles.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 500 | Wood: 1,000 | Stone: 2,000 | Iron: 500
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Increases detail level of incoming march notifications.

### **Effects**

* **Intel Unlocks by Level:**
* **Level 1:** Warns of incoming attack and arrival time.
* **Level 2:** Shows origin city coordinates.
* **Level 3:** Shows exact arrival time countdown.
* **Level 4:** Shows attacker lord name.
* **Level 5:** Shows approximate army size numbers.
* **Level 6:** Shows exact total troop numbers.
* **Level 7:** Shows exact troop types and individual counts.
* **Level 8:** Shows incoming hero name and level.
* **Level 9:** Shows incoming hero stats.
* **Level 10:** Shows target city's technologies and exact unit breakdown.



### **Dependencies**

* Town Hall 3
* Walls Level 1

### **Unlocks**

* Advanced Radar / Warning HUD notifications.

### **UI**

* Flashing red banner on UI when under target lock, expandable details panel rendering intel based on tower level.

### **Original Age I Behavior**

* Intel visibility is modified by comparing defender's `Beacon Tower + Informatics Tech` against attacker's `Informatics Tech + Hero Intelligence`.

### **Notes for Recreation**

* Essential for preventing blind-siding; alerts must fire websocket notifications to client instantly.

---

## **15. Relief Station**

### **Description**

Logistical transit hub that drastically accelerates march speeds between your own cities and alliance members' cities.

### **Purpose**

Increases movement speed for friendly supply transport, reinforcements, and re-deployments.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 1,000 | Wood: 5,000 | Stone: 5,000 | Iron: 2,000
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* **Speed Multiplier:** Increases march velocity for friendly travel beyond base map range:
* Level 1: $+50\%$ speed boost
* Level 2: $+100\%$ speed boost
* Level 3: $+150\%$ speed boost
* Level 10: $+500\%$ speed boost



### **Effects**

* Accelerates transit speed between friendly cities.

### **Dependencies**

* Town Hall 1
* Horseback Riding Tech Level 1

### **Unlocks**

* Rapid logistics networks.

### **UI**

* Speed multiplier indicator displayed during march destination setup.

### **Original Age I Behavior**

* The speed boost **only activates** for movement between owned cities or friendly alliance member cities. It does **NOT** apply to hostiles or wilderness valleys.

### **Notes for Recreation**

* Apply speed multiplier formula only after validating `Target_Owner_Alliance_ID == Source_Owner_Alliance_ID`.

---

# 🛡️ **WALLS & FORTIFICATIONS**

---

## **16. Walls**

### **Description**

Perimeter defense fortifications surrounding the inner city, providing baseline hit points and space for static defensive structures.

### **Purpose**

Protects the city, provides range bonuses to defenders, and dictates total wall fortification capacity.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 500 | Wood: 2,000 | Stone: 5,000 | Iron: 2,000
* **Scaling:** Multiplies by $2.0\times$ per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* **Durability (HP):**
* Level 1: 1,000,000
* Level 2: 2,000,000
* Level 3: 4,500,000
* Level 10: 300,000,000


* **Fortification Space Cap:**

$$\text{Space Capacity} = \text{Wall Level} \times 10,000$$



### **Effects**

* Adds static Durability HP to the city.
* Grants defensive unit range bonuses:

$$\text{Ranged Unit Distance Bonus} = \text{Base Range} \times (1 + 0.05 \times \text{Wall Level})$$



### **Dependencies**

* Town Hall 2

### **Unlocks**

* Traps, Abatis, Archer Towers, Rolling Logs, Trebuchets.

### **UI**

* Wall Durability Bar, Defense Construction Queue, Fortification Space Allocator.

### **Original Age I Behavior**

* Wall Durability acts as a structural force field. Attackers must breach Wall HP to capture a city if gates are closed, or bring loyalty to zero through repeated strikes.

### **Notes for Recreation**

* Crucial combat calculation: Level 10 walls grant $+50\%$ bonus range to defending Archer Towers and Archers!

---

## **17. Traps**

### **Description**

Hidden pit traps and snare mechanisms built outside the city walls to eliminate enemy foot soldiers.

### **Purpose**

Anti-infantry static defense.

### **Maximum Level**

Gated by Wall Space Cap (1 Space per Trap).

### **Costs**

* Food: 10 | Wood: 100 | Stone: 100 | Iron: 50

### **Upgrade Scaling**

* Built in numerical quantities up to Wall Space capacity.

### **Effects**

* Destroys 1 enemy infantry unit (Worker, Warrior, Scout, Pikeman, Swordsman) per trap triggered during battle start.

### **Dependencies**

* Walls Level 1
* Mechanics Tech Level 1

### **Unlocks**

* None

### **UI**

* Built within the Wall Interface.

### **Original Age I Behavior**

* Traps trigger instantly at Round 1 start, reducing incoming enemy infantry ranks before melee engagement begins. Consumed upon activation.

### **Notes for Recreation**

* Traps **do not** affect mounted or siege units.

---

## **18. Abatis**

### **Description**

Interlocking wooden stakes and spiked barricades pointed outward to stop charging mounted units.

### **Purpose**

Anti-cavalry static defense.

### **Maximum Level**

Gated by Wall Space Cap (2 Spaces per Abatis).

### **Costs**

* Food: 20 | Wood: 200 | Stone: 50 | Iron: 100

### **Upgrade Scaling**

* Built in numerical quantities up to Wall Space capacity.

### **Effects**

* Destroys 1 enemy mounted unit (Cavalry, Cataphract) per Abatis triggered.

### **Dependencies**

* Walls Level 2
* Mechanics Tech Level 1
* Horseback Riding Tech Level 1

### **Unlocks**

* None

### **UI**

* Wall Interface.

### **Original Age I Behavior**

* Sets starting combat distance to 5,000 when present, giving ranged towers extra rounds to fire at incoming armies. Consumed upon activation.

### **Notes for Recreation**

* Essential tactical component: Even 1 Abatis forces initial combat distance to 5,000.

---

## **19. Archer Tower (AT)**

### **Description**

Elevated fortified towers populated by elite bowmen firing down on besieging armies.

### **Purpose**

Primary static defensive attack mechanism.

### **Maximum Level**

Gated by Wall Space Cap (3 Spaces per Archer Tower).

### **Costs**

* Food: 300 | Wood: 1,000 | Stone: 2,000 | Iron: 500

### **Upgrade Scaling**

* Built in numerical quantities. Maximum AT count on Level 10 Wall $= 15,000$ ATs (if no other defenses built).

### **Effects**

* High damage ranged defense. Fires every round at enemy targets within range.
* Range $= 1300 \times (1 + 0.05 \times \text{Wall Level} + 0.05 \times \text{Archery Tech Level})$.

### **Dependencies**

* Walls Level 3
* Archery Tech Level 1
* Mechanics Tech Level 1

### **Unlocks**

* None

### **UI**

* Wall Interface.

### **Original Age I Behavior**

* Archer Towers are the core defense of Age I. They act as immobile high-HP archers that gain full benefits from Wall Range bonuses.

### **Notes for Recreation**

* Priority targeting system: ATs target incoming ranged units and siege engines before foot soldiers if in range.

---

## **20. Rolling Log**

### **Description**

Heavy timber logs wrapped in spikes suspended on the walls, dropped onto advancing ground forces.

### **Purpose**

Heavy anti-infantry defense.

### **Maximum Level**

Gated by Wall Space Cap (4 Spaces per Rolling Log).

### **Costs**

* Food: 500 | Wood: 2,000 | Stone: 500 | Iron: 500

### **Upgrade Scaling**

* Built in numerical quantities up to space capacity.

### **Effects**

* Crushes incoming infantry in massive waves when enemy troops close range.

### **Dependencies**

* Walls Level 5
* Engineering Tech Level 1
* Mechanics Tech Level 2

### **Unlocks**

* None

### **UI**

* Wall Interface.

### **Original Age I Behavior**

* Consumed upon activation during defense combat sequence.

### **Notes for Recreation**

* High damage multiplier against dense layers of Pikemen and Swordsmen.

---

## **21. Defensive Trebuchet**

### **Description**

Counter-weight siege engines mounted on wall towers designed to hurl massive stone boulders at enemy siege units.

### **Purpose**

Ultra-long-range bombardment defense aimed at enemy siege engines.

### **Maximum Level**

Gated by Wall Space Cap (5 Spaces per Trebuchet).

### **Costs**

* Food: 1,000 | Wood: 3,000 | Stone: 5,000 | Iron: 2,000

### **Upgrade Scaling**

* Built in numerical quantities up to space capacity.

### **Effects**

* Range: 5,000 distance units.
* Decimates incoming Battering Rams, Ballistas, and Catapults.

### **Dependencies**

* Walls Level 7
* Engineering Tech Level 3
* Machinery Tech Level 3

### **Unlocks**

* None

### **UI**

* Wall Interface.

### **Original Age I Behavior**

* Trebuchets trigger at maximum range (5,000) and have a chance to be repaired automatically after battle if player possesses high **Machinery** research.

### **Notes for Recreation**

* Repair chance formula:

$$\text{Recovery Ratio} = \text{Machinery Tech Level} \times 8\%$$



---

# ⛏️ **OUTER RESOURCE FIELDS**

*(Occupies outer perimeter field plots; max field capacity dictated by Town Hall Level).*

---

## **22. Farm**

### **Description**

Agricultural land producing Food required to sustain population and feed station armies.

### **Purpose**

Food production.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 200 | Wood: 200 | Stone: 100 | Iron: 100
* **Scaling:** Multiplies exponentially per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Hourly base production:
* Level 1: $+100$/hr
* Level 2: $+300$/hr
* Level 3: $+600$/hr
* Level 4: $+1,000$/hr
* Level 5: $+1,500$/hr
* Level 6: $+2,100$/hr
* Level 7: $+2,800$/hr
* Level 8: $+3,600$/hr
* Level 9: $+4,500$/hr
* Level 10: $+5,500$/hr



### **Effects**

* Generates hourly Food output.
* Production modified by Agriculture Tech and Mayor Politics.

### **Dependencies**

* Town Hall 1

### **Unlocks**

* Food logistics.

### **UI**

* Outer Field plot selector, production summary breakdown.

### **Original Age I Behavior**

* If Food output drops below troop upkeep costs, net production turns negative. If net food reaches 0, troops starve and enter **Refugee Status** ($10\%$ of troops desert per tick).

### **Notes for Recreation**

* Hourly production formula:

$$\text{Net Food} = \text{Base Output} \times \left(1 + \text{Agriculture Tech} \times 0.10 + \frac{\text{Mayor Politics}}{100} + \text{Valleys Bonus}\right) - \text{Troop Upkeep}$$



---

## **23. Sawmill**

### **Description**

Lumber yard for harvesting and processing timber required for bowmen, siege, and construction.

### **Purpose**

Wood / Lumber production.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 100 | Wood: 100 | Stone: 250 | Iron: 300
* **Scaling:** Multiplies exponentially per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Same production step pattern as Farm ($+100, +300, +600... +5,500$/hr at Level 10).

### **Effects**

* Generates hourly Wood output.
* Production modified by Lumbering Tech and Mayor Politics.

### **Dependencies**

* Town Hall 1

### **Unlocks**

* None

### **UI**

* Outer Field plot selector.

### **Original Age I Behavior**

* Wood is the primary bottleneck resource for building Archer towers and Archer armies.

### **Notes for Recreation**

* Standard resource field mechanics apply.

---

## **24. Quarry**

### **Description**

Stone extraction pit providing raw stone for walls, fortifications, and high-tier buildings.

### **Purpose**

Stone production.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 300 | Wood: 200 | Stone: 100 | Iron: 300
* **Scaling:** Multiplies exponentially per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Same production step pattern as Farm ($+100, +300, +600... +5,500$/hr at Level 10).

### **Effects**

* Generates hourly Stone output.
* Production modified by Masonry Tech and Mayor Politics.

### **Dependencies**

* Town Hall 1

### **Unlocks**

* None

### **UI**

* Outer Field plot selector.

### **Original Age I Behavior**

* Essential for heavy wall construction early on; often demolished for Sawmills in mid-to-late game.

### **Notes for Recreation**

* Allow seamless demolition to free field plots for re-specialization.

---

## **25. Iron Mine**

### **Description**

Deep mining shaft extracting iron ore for weapons, armor, and siege machinery.

### **Purpose**

Iron production.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 300 | Wood: 300 | Stone: 300 | Iron: 100
* **Scaling:** Multiplies exponentially per level. Level 10 requires 1× Michelangelo's Script.

### **Upgrade Scaling**

* Same production step pattern as Farm ($+100, +300, +600... +5,500$/hr at Level 10).

### **Effects**

* Generates hourly Iron output.
* Production modified by Mining Tech and Mayor Politics.

### **Dependencies**

* Town Hall 1

### **Unlocks**

* None

### **UI**

* Outer Field plot selector.

### **Original Age I Behavior**

* Iron is vital for high-tier Armored units (Swordsmen, Cataphracts, Battering Rams).

### **Notes for Recreation**

* Enforce field slot validation against `Town_Hall_Max_Fields`.

---

# 📊 **BUILDING DATABASE MASTER SCHEMA**

To directly implement this document into the server backend, here is the complete relational Postgres database table definition for Volume III:

```sql
-- Building Type Master Definition Table
CREATE TABLE building_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL UNIQUE,
    code VARCHAR(32) NOT NULL UNIQUE,
    category VARCHAR(32) NOT NULL, -- 'INNER', 'WALL', 'FIELD'
    max_level INT DEFAULT 10,
    is_unique_per_city BOOLEAN DEFAULT TRUE,
    description TEXT
);

-- City Building Instances Table
CREATE TABLE city_buildings (
    id BIGSERIAL PRIMARY KEY,
    city_id BIGINT NOT NULL REFERENCES cities(id) ON DELETE CASCADE,
    building_type_id INT NOT NULL REFERENCES building_types(id),
    slot_index INT NOT NULL, -- 1-32 for Inner, 1-31 for Outer Field, 0 for Wall
    level INT DEFAULT 1,
    is_upgrading BOOLEAN DEFAULT FALSE,
    upgrade_end_time TIMESTAMP WITH TIME ZONE NULL,
    CONSTRAINT unique_city_slot UNIQUE(city_id, slot_index)
);

-- Building Upgrade Requirements Configuration Table
CREATE TABLE building_upgrade_costs (
    building_type_id INT NOT NULL REFERENCES building_types(id),
    level INT NOT NULL,
    food_cost BIGINT NOT NULL,
    wood_cost BIGINT NOT NULL,
    stone_cost BIGINT NOT NULL,
    iron_cost BIGINT NOT NULL,
    gold_cost BIGINT DEFAULT 0,
    item_required_key VARCHAR(64) DEFAULT NULL, -- e.g. 'michelangelos_script'
    item_required_count INT DEFAULT 0,
    build_time_seconds INT NOT NULL,
    PRIMARY KEY(building_type_id, level)
);

```
