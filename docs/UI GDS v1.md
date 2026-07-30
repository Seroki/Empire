# UI GDS (v1)

## Purpose
Define the core GUI layout, required data fields, and user interactions for the city interface.

## Required Panels
1. Resource Bar
   - wood
   - stone
   - iron
   - food
   - gold

2. Population Panel
   - population
   - maxPopulation
   - loyalty

3. City Overview Panel
   - cityName
   - mayorName
   - politics
   - buildingList (name, level, type)

4. Gate Panel
   - gateStatus (open/closed)
   - fortifications (traps, abatis, logs, towers, trebuchets)

## Required User Interactions
- Click building → open building dialog
- Click Gatehouse → open Gate panel
- Hover resource → show production rate
- Refresh city → fetch /city/:id JSON

## Required Data Fields From Backend
- population
- maxPopulation
- loyalty
- resources (wood, stone, iron, food, gold)
- buildings (array)
- mayor (name, politics)
- fortifications
- gateStatus

## Update Rules
- GUI must refresh when /city/:id returns new JSON
- GUI must display all fields listed above
- GUI must not invent fields not defined in this GDS

