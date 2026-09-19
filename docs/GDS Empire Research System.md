# GDS Empire Research System — Consolidated GDS  
### Version 3.0 — July 2026  
### Author: Empire Core Systems Team  

---

# 1. Overview

The Empire Research System merges:

- **Evony Tier I** technologies (Levels 1–10)  
- **Tier II** technologies unlocked at Level 10  
- **Puzzles & Conquest** combat, economy, and development tech absorbed into Tier II  
- **Cross‑technology dependencies** at Level 10  
- **Single global research queue**  
- **Account‑wide unlocks**  
- **Tier I capped by Academy**  
- **Tier II ignores Academy caps**  
- **Tier II includes global combat bonuses**  
- **Tier II uses exponential cost/time scaling**  

This GDS defines:

- Full research tree  
- Dependencies  
- Effects  
- Combat bonuses  
- SQL schema  
- SQL routes  
- Research services  
- Queue logic  
- Validation rules  
- Progression rules  
- Balancing tables  
- Engine integration  

---

# 2. Research Building: Academy

### Purpose
The Academy enables research progression across economic, military, logistics, and intelligence systems.

### Max Level
10

### Tier I Rule
Tier I research effects are capped by the **local Academy level**.

### Tier II Rule
Tier II research effects are **global** and **not capped** by Academy.

### Queue Rule
Only **one** research project may be active account‑wide.

---

# 3. Universal Research Formula

### Research Time


\[
ActualTime = \frac{BaseTime}{1 + (MayorINT / 100)} \times 0.95^{(AcademyLevel - 1)}
\]



### Effective Tech Level (Tier I only)


\[
EffectiveLevel = \min(GlobalLevel, LocalAcademyLevel)
\]



Tier II ignores Academy caps.

---

# 4. Full Research Tree (Tier I + Tier II)

---

## 4.1 Tier I — Evony Technologies (Levels 1–10)

### Economy
- Agriculture  
- Lumbering  
- Masonry  
- Mining  
- Stockpile  

### Construction
- Construction  

### Military
- Military Science  
- Military Tradition  
- Iron Working  
- Archery  
- Horseback Riding  
- Engineering  
- Metal Casting  

### Intelligence
- Informatics  

### Movement
- Compass  

### Defense
- Machinery  

---

## 4.2 Tier II — New Technologies (Levels 1–10)

### *Unlocked when parent Tier I reaches Level 10*  
### *Requires cross‑tech Level‑10 dependencies*  
### *No building requirements*  
### *Absorbs P&C tech effects*  
### *Includes global combat bonuses*  

---

# Tier II Technology List (Final)

### Economy Tier II
- Agriculture II  
- Lumbering II  
- Masonry II  
- Mining II  

### Construction Tier II
- Construction II  
- Logistics II  
- Medicine II  

### Military Tier II
- Military Science II  
- Military Tradition II  
- Iron Working II  
- Archery II  
- Horseback Riding II  
- Compass II  

### Siege Tier II
- Engineering II  
- Metal Casting II  
- Machinery II  

### Intelligence Tier II
- Informatics II  

### Storage Tier II
- Stockpile II  

---

# 5. Tier II Cross‑Tech Dependencies

| Tier II Tech | Requires Level 10 In | Secondary Requirement |
|--------------|----------------------|------------------------|
| Agriculture II | Agriculture | Logistics |
| Lumbering II | Lumbering | Construction |
| Masonry II | Masonry | Construction |
| Mining II | Mining | Metal Casting |
| Construction II | Construction | Masonry |
| Logistics II | Logistics | Agriculture |
| Medicine II | Medicine | Agriculture |
| Military Science II | Military Science | Construction |
| Military Tradition II | Military Tradition | Military Science |
| Iron Working II | Iron Working | Metal Casting |
| Archery II | Archery | Military Science |
| Horseback Riding II | Horseback Riding | Military Tradition |
| Compass II | Compass | Horseback Riding |
| Engineering II | Engineering | Metal Casting |
| Metal Casting II | Metal Casting | Mining |
| Machinery II | Machinery | Engineering |
| Informatics II | Informatics | Military Science |
| Stockpile II | Stockpile | Logistics |

---

# 6. Tier II Combat Enhancements (Expanded)

Tier II technologies absorb P&C combat depth and apply bonuses across **all troop classes**, not just archers.

Combat bonuses include:

- Attack Speed  
- Flat Combat Bonus  
- Attack %  
- Defense %  
- HP %  
- Range %  
- Movement Speed %  
- Siege Damage %  
- Mounted Damage %  
- Infantry Damage %  
- Scout Efficiency %  

---

## 🏹 Archery II — Archer Combat Enhancements
**Requires:** Archery 10 + Military Science 10  

### Per Level
- +2.5% Archer Range  
- +3% Archer Attack  
- +3 Archer Combat Bonus (flat)  
- +1.5% Attack Speed  

---

## ⚔️ Military Tradition II — Global Combat Enhancements
**Requires:** Military Tradition 10 + Military Science 10  

### Per Level
- +3% Attack  
- +3% HP  
- +2% Attack Speed  
- +2 All‑Troop Combat Bonus (flat)  

---

## 🛡 Iron Working II — Infantry Combat Enhancements
**Requires:** Iron Working 10 + Metal Casting 10  

### Per Level
- +3% Infantry Defense  
- +3% Infantry HP  
- +1% Attack Speed  
- +2 Infantry Combat Bonus (flat)  

---

## 🐎 Horseback Riding II — Mounted Combat Enhancements
**Requires:** Horseback Riding 10 + Military Tradition 10  

### Per Level
- +3% Mounted Speed  
- +3% Mounted Attack  
- +2% Attack Speed  
- +2 Mounted Combat Bonus (flat)  

---

## ⚙️ Engineering II — Siege Defense Enhancements
**Requires:** Engineering 10 + Metal Casting 10  

### Per Level
- +3% Siege HP  
- +3% Siege Defense  
- +1% Attack Speed  
- +2 Siege Combat Bonus (flat)  

---

## 🔩 Metal Casting II — Siege Attack Enhancements
**Requires:** Metal Casting 10 + Mining 10  

### Per Level
- +3% Siege Attack  
- +3% Siege HP  
- +1% Attack Speed  
- +2 Siege Damage Bonus (flat)  

---

## 🧭 Compass II — Infantry & Scout Enhancements
**Requires:** Compass 10 + Horseback Riding 10  

### Per Level
- +3% Infantry Speed  
- +3% Scout Speed  
- +1% Attack Speed  
- +2 Scout Combat Bonus (flat)  

---

## 🕵️ Informatics II — Scout Combat Enhancements
**Requires:** Informatics 10 + Military Science 10  

### Per Level
- +3% Scout Accuracy  
- +3% Anti‑Scout Counter  
- +1% Attack Speed  
- +2 Scout Combat Bonus (flat)  

---

# 7. Attack Speed — System Definition

Attack Speed modifies the **time between strikes** in combat simulation.



\[
StrikeInterval = BaseInterval \times (1 - AttackSpeedBonus)
\]



---

# 8. Archery Combat Bonus — System Definition



\[
ArcherCombat = BaseCombat + ArcheryCombatBonus
\]



Applies to:

- Archer units  
- Archer Towers  
- Defensive Archer formations  

---

# 9. Tier II Cost & Time Model

---

## 9.1 Tier II Base Cost (Level 1)

| Resource | Base Cost (Level 1) |
|----------|----------------------|
| Food     | 25,000,000 |
| Wood     | 25,000,000 |
| Stone    | 20,000,000 |
| Iron     | 15,000,000 |
| Gold     | 500,000 |

---

## 9.2 Tier II Cost Scaling Formula



\[
Cost_{n} = BaseCost \times (1.35^{(n-1)})
\]



---

## 9.3 Tier II Research Time Scaling

### Base Time (Level 1)


\[
BaseTime_{1} = 168 \text{ hours} \quad (7 \text{ days})
\]



### Time Formula


\[
Time_{n} = 168h \times (1.5^{(n-1)})
\]



---

# 10. SQL Schema

### `research_topics`
```sql
id UUID PRIMARY KEY,
code TEXT UNIQUE,
name TEXT,
tier INT,
category TEXT,
max_level INT,
base_time INT,
effect_type TEXT,
effect_value FLOAT,
requires_research TEXT,
requires_level INT,
requires_cross TEXT,
food_cost INT,
wood_cost INT,
stone_cost INT,
iron_cost INT,
gold_cost INT,
tier2_cost_multiplier FLOAT DEFAULT 1.35,
tier2_time_base INT DEFAULT 604800,
tier2_time_multiplier FLOAT DEFAULT 1.5

