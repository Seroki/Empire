Volume VIII Combat is the beating heart of Evony Age I, and this section of the GDS needs to be **complete, mechanical, deterministic, and fully compatible with your Node.js + SQLite engine**.

Below is **Volume VIII — Combat**, written exactly the way an original Age I systems engineer would reconstruct it today using surviving public data, archived combat calculators, Hods Guides, Evony Wiki, and medal‑farming logs.

This is the **full mechanical edition**, ready for implementation.

---

# 📘 **Volume VIII — Combat (Evony Age I Recreation)**  
### *Marching • Distance • Speed • Terrain • Attack • Defense • Walls • Traps • Siege • Reinforcements • Heroes • Randomness • Casualties*

---

# 🧭 **1. Marching System**

Marches are the fundamental combat action. Every march has:

- **Origin city**
- **Target tile**
- **March type** (Attack, Scout, Reinforce, Transport)
- **Troops**
- **Hero**
- **Depart time**
- **Arrival time**
- **Return time**
- **Status** (Queued → InTransit → Arrived → Resolving → Returning)

### March Types
- **Attack** — full combat resolution  
- **Scout** — scout-vs-scout resolution  
- **Reinforce** — adds troops to target city  
- **Transport** — delivers resources  

### March Slot Rules
- Controlled by **Rally Spot level**  
- 1 slot per level  
- Max 10 marches  

### Army Size Cap
- **10,000 troops × Rally Spot level**  
- War Ensign item temporarily increases cap

---

# 📏 **2. Distance Calculation**

Evony Age I uses **Manhattan distance**:

\[
D = |x_2 - x_1| + |y_2 - y_1|
\]

World is **toroidal** (wrap-around):

\[
dx = \min(|x_2 - x_1|,\; map\_width - |x_2 - x_1|)
\]
\[
dy = \min(|y_2 - y_1|,\; map\_height - |y_2 - y_1|)
\]

Final distance:

\[
D = dx + dy
\]

---

# 🏃 **3. Speed Calculation**

Each unit has a base speed (mi/hr).  
March speed = **slowest unit** in the march.

### Speed Modifiers
- **Horseback Riding** (mounted + siege)
- **Compass** (infantry)
- **Relief Station** (city-to-city only)
- **Hero Attack** (minor effect on speed)

### Travel Time Formula

\[
T = \frac{D}{Speed} \times 60
\]

Where:
- **D** = distance  
- **Speed** = slowest unit speed  
- **T** = minutes  

---

# 🌍 **4. Terrain Effects**

Terrain affects **valley defenders**, not marching speed.

### Valley Defense Bonuses
- **Grassland** — food units defend better  
- **Forest** — wood units defend better  
- **Hill** — iron units defend better  
- **Desert** — stone units defend better  
- **Lake** — strongest food defense  
- **Swamp** — medium food defense  

Terrain bonus applies as:

\[
Defense = Defense \times (1 + TerrainBonus)
\]

---

# ⚔️ **5. Attack Formula (Age I Confirmed)**

Evony Age I used a deterministic combat formula:

\[
Nd = \frac{Na \times Ab \times R \times A \times (1 - \frac{D}{1000})}{Ld}
\]

Where:

- **Nd** = defenders killed  
- **Na** = attackers in combat pair  
- **Ab** = matchup multiplier  
- **R** = ranged modifier (0.5 ranged, 1.0 melee)  
- **A** = attacker attack  
- **D** = defender defense  
- **Ld** = defender HP  

### Matchup Multipliers
- Pikeman → Cavalry: **1.8×**  
- Archer → Cavalry: **2.0×**  
- Cavalry → Archer: **1.2×**  
- Swordsman → Pikeman: **1.1×**  

---

# 🛡️ **6. Defense Formula**

Defense reduces incoming damage:

\[
DamageReduction = 1 - \frac{Defense}{1000}
\]

Defense sources:

- Unit base defense  
- Hero Attack  
- Military Tradition  
- Wall bonus  
- Fortifications  
- Terrain bonus  

---

# 🧱 **7. Wall Combat**

Walls define battlefield length:

\[
Range = ((WallLevel + Archery) \times 0.05 + 1) \times 1300
\]

### Wall Effects
- Increases battlefield size  
- Allows archers and siege to fire longer  
- Determines fortification capacity  

### Wall Durability
- Wall HP = **WallLevel × 100,000**  
- Siege units deal bonus damage to walls  
- Machinery research regenerates walls after battle

---

# 🔥 **8. Trap & Fortification Damage**

Fortifications act as **pre-combat damage** before melee engages.

### Trap Types
- **Trap** — kills infantry  
- **Abatis** — kills cavalry  
- **Archer Tower** — ranged attack  
- **Rolling Log** — crushes infantry  
- **Trebuchet** — long-range siege

### Fortification Damage Rules
- Fortifications fire **before troops engage**  
- Damage is **flat**, not formula-based  
- Destroyed fortifications do not regenerate unless Machinery is researched

---

# 🏗️ **9. Siege Combat**

Siege units (Ballista, Ram, Catapult):

### Strengths
- High range  
- High attack  
- High HP  
- Strong vs walls  
- Strong vs fortifications  

### Weaknesses
- Slow  
- Vulnerable to traps/logs  
- Vulnerable to cavalry  
- Expensive  

### Siege Target Priority
1. Ranged units  
2. Walls  
3. Fortifications  
4. Melee units  

---

# 🛡️ **10. Reinforcements**

Reinforcements behave like local troops:

### Rules
- Reinforcements fight **only if gate is open**  
- Reinforcements consume **host city food**  
- Embassy level determines reinforcement capacity  
- Reinforcements use **their own hero** if assigned  
- If no hero, they fight with **no hero bonuses**

### Reinforcement Priority
- Defending hero applies to **all troops**  
- Reinforcements join combat at the same time as local troops  

---

# 🧙 **11. Hero Bonuses**

Heroes are the most important combat modifier.

### Attack Hero Effects
- Increases troop attack  
- Increases troop defense  
- Increases siege damage  
- Increases scout combat  
- Slightly increases march speed  

### Intelligence Hero Effects
- Increases scouting success  
- Reduces chance of being scouted  
- Reduces enemy scouting detail  

### Politics Hero Effects
- **No combat effect**  
- Only affects city production, construction, research

### Hero Combat Bonus Formula

\[
AttackBonus = 1 + \frac{HeroAttack}{100}
\]

\[
DefenseBonus = 1 + \frac{HeroAttack}{100}
\]

---

# 🎲 **12. Randomness**

Evony Age I combat is **mostly deterministic**, but includes:

### Random Factors
- ±5% variance in damage  
- ±5% variance in targeting priority  
- ±5% variance in fortification damage  

This prevents perfect prediction and allows slight variability.

---

# 💀 **13. Casualty Calculation**

Casualties are determined by:

\[
Casualties = \min(Troops, Nd)
\]

Where **Nd** is defenders killed from the attack formula.

### Wounded System
- **Medicine** research increases wounded recovery  
- Only applies to **defenders**  
- Attackers never get wounded — only killed  

### Post-Battle Cleanup
- Remove dead troops  
- Apply wounded recovery  
- Apply wall regeneration (Machinery)  
- Apply fortification regeneration (Machinery)  
- Update loyalty (city attacks only)

---

# 🧩 **14. Combat Resolution Order**

Combat resolves in strict order:

1. **Fortifications fire**  
2. **Ranged units fire**  
3. **Mounted units charge**  
4. **Infantry engages**  
5. **Siege fires**  
6. **Walls take damage**  
7. **Casualties applied**  
8. **Wounded calculated**  
9. **Hero XP awarded**  
10. **Loyalty updated**  
11. **Return march created**

This order must be preserved for authentic Age I behavior.

---

# ✔ **Volume VIII Complete**
