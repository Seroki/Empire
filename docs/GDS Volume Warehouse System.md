# GDS Volume — Warehouse System

## 1. Overview
The Warehouse is the city’s defensive storage structure responsible for protecting a portion of the central stockpile from enemy raids. It also determines the maximum amount of resources the city can store before Auto‑Collection pauses.

The Warehouse:
- Protects ONLY the central stockpile
- NEVER protects Resource Field storage
- Determines maximum stockpile capacity
- Determines protected storage during raids
- Does NOT affect production or field capacity
- Does NOT affect Auto‑Collection triggers
- Interacts indirectly with valley bonuses through overflow risk

---

## 2. Core Mathematical Definitions

### 2.1 Base Storage Capacity Per Level (Evony Age I Verified)
WarehouseCapacity(L) is the maximum central stockpile storage before Auto‑Collection pauses.

| Level | Base Storage Capacity |
|-------|------------------------|
| 1 | 10,000 |
| 2 | 30,000 |
| 3 | 60,000 |
| 4 | 100,000 |
| 5 | 150,000 |
| 6 | 210,000 |
| 7 | 280,000 |
| 8 | 360,000 |
| 9 | 450,000 |
| 10 | 550,000 |

WarehouseCapacity applies **per resource type** (Food, Wood, Stone, Iron, Gold).

---

### 2.2 Stockpile Research Bonus
Stockpile research increases Warehouse storage capacity:

FinalWarehouseCapacity = BaseCapacity × (1.1 ^ StockpileLevel)

Example:
Level 10 Warehouse + Stockpile 10:
550,000 × (1.1^10) ≈ 1,424,500

---

### 2.3 Protected Storage Formula
ProtectedAmount = WarehouseLevel × ProtectionFactor

ProtectionFactor is defined in the global balancing tables.

ProtectedAmount applies ONLY to the central stockpile.

---

### 2.4 Privateering Protection Reduction
Privateering reduces Warehouse protection:

ProtectedAfterPrivateering = ProtectedAmount × (0.97 ^ PrivateeringLevel)

Example:
Privateering 10 reduces protection to ~73.7% of normal.

---

### 2.5 Vulnerable Storage Formula
VulnerableAmount = max(0, Stockpile − ProtectedAmount)

VulnerableAmount is fully plunderable during raids.

---

### 2.6 Field Storage Capacity (from Resource Field System)
FieldStorageCap = HourlyProduction × 16

Warehouse does not modify this value.

---

### 2.7 Auto‑Collection Trigger (from Resource Field System)
AutoCollectTrigger = FieldStorageCap × 0.90

Warehouse does not modify this threshold.

---

### 2.8 Valley Bonus Interaction (from Wilderness System)
FinalHourlyProduction = BaseYield × (1 + ValleyBonus)

Valley bonuses indirectly affect Warehouse behavior by increasing:
- FieldStorageCap
- AutoCollectTrigger
- Frequency of stockpile overflow

Warehouse does not modify valley bonuses.

---

## 3. Functional Requirements

### 3.1 Warehouse Protects Central Stockpile Only
- ProtectedAmount applies ONLY to the central stockpile.
- ProtectedAmount must NEVER apply to Resource Field storage.
- ProtectedAmount must be used during raid calculations.

### 3.2 Warehouse Does Not Protect Resource Fields
- Resource Field storage is ALWAYS plunderable.
- Each field is looted independently.
- Warehouse protection must not reduce field losses.

### 3.3 Warehouse Determines Stockpile Capacity
- WarehouseCapacity(L) defines maximum stockpile size.
- Auto‑Collection pauses when Stockpile ≥ WarehouseCapacity(L).

### 3.4 Warehouse Does Not Affect Production
- Warehouse must not modify HourlyProduction.
- Warehouse must not modify FieldStorageCap.
- Warehouse must not modify production halt behavior.

### 3.5 Warehouse Does Not Affect Auto‑Collection Trigger
- Auto‑Collection must operate regardless of Warehouse protection.
- Warehouse must not block Auto‑Collection.
- Warehouse must not prevent stockpile overflow.

### 3.6 Warehouse Does Not Affect Worker Reservation
- Worker reservation is determined by Town Hall level only.
- Warehouse must not modify worker requirements.

---

## 4. System Behavior

### 4.1 Raiding Logic
During a raid:
1. Compute ProtectedAmount.
2. Apply Privateering reduction if attacker has Privateering.
3. Compute VulnerableAmount.
4. Plunder VulnerableAmount.
5. Plunder ALL Resource Field storage.

Warehouse must never protect field storage.

---

### 4.2 Auto‑Collection Logic
Auto‑Collection triggers at 90% field capacity.

Warehouse effects:
- Does not block Auto‑Collection.
- Does not protect Auto‑Collected resources.
- Does not prevent stockpile overflow.

If stockpile is full:
- Auto‑Collection pauses.
- Fields continue filling until 100%.
- Production halts at 100%.

---

### 4.3 Manual Collection Logic
Manual collection:
- Transfers all field storage to stockpile.
- Must allow stockpile to exceed Warehouse protection.
- Must not block collection due to protection limits.

---

## 5. Interaction With Other Systems

### 5.1 Resource Fields (Volume XVII)
Warehouse does NOT affect:
- FieldStorageCap
- Production halt
- Auto‑Collection trigger
- Worker reservation
- Field plunder amounts

### 5.2 Valley Bonuses
Valley bonuses increase HourlyProduction.

This indirectly affects Warehouse by:
- Increasing FieldStorageCap
- Increasing AutoCollectTrigger
- Increasing stockpile overflow frequency

Warehouse must not modify valley bonuses.

### 5.3 Town Hall
Town Hall determines:
- Auto‑Collection unlock (TH6+)
- Worker reservation

Warehouse must not modify Town Hall requirements.

### 5.4 Combat & Raiding (Volume XV)
Warehouse determines:
- ProtectedAmount
- VulnerableAmount

Warehouse does NOT modify:
- Combat formulas
- Prestige gain
- NPC scaling
- Valley defender strength

---

## 6. State Matrix

| State | Warehouse Effect |
|-------|------------------|
| Field Storage (0–100%) | No protection |
| Stockpile ≤ ProtectedAmount | Fully protected |
| Stockpile > ProtectedAmount | Excess plunderable |
| Stockpile Full | Auto‑Collection paused |
| Field Storage Full | Production halted |

---

## 7. Design Summary

The Warehouse:
- Protects ONLY central stockpile resources
- NEVER protects Resource Field storage
- Determines stockpile capacity
- Determines protected storage during raids
- Does NOT affect production or field capacity
- Does NOT affect Auto‑Collection triggers
- Does NOT affect valley bonuses
- Interacts indirectly with valley bonuses through increased production overflow risk
- Must remain consistent across all raid, collection, and production systems

This document defines all mathematical and behavioral requirements needed to implement Warehouse functionality accurately and consistently across the entire resource system.

