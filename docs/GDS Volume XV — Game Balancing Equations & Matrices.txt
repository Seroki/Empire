Volume XV — Game Balancing Equations & Matrices
1. Building Growth & Timing Equations
1.1 Building Cost Functions
Cost(L)=⌈BaseCost⋅(ϕbld)L−1⌉

Building Category Scaling Factors
Building Category	ϕ_bld	Examples
Defensive / Core	1.60	Walls
Primary Hub	1.50	Town Hall
Military & Tech	1.35	Barracks, Academy, Rally Spot, Feasting Hall
Resource Fields	1.25	Farm, Sawmill, Quarry, Ironmine
Residential / Misc	1.20	Cottage, Inn, Warehouse, Beacon Tower
Primary Building Resource Cost Table (Level 1 Base Costs)
Building	Food	Lumber	Stone	Iron	Gold
Town Hall	1,000	2,000	3,000	1,000	500
Barracks	200	500	200	100	100
Walls	500	1,000	5,000	1,000	500
Cottage	100	200	100	50	50
Academy	500	1,000	800	500	1,000
1.2 Build Time Reduction Equation
BuildTime(L)=BaseTime⋅(1.20)L−11+(0.05⋅ConstructionTech)+(0.005⋅MayorPolitics)

Modifiers

    Construction Tech: +5% speed per level

    Mayor Politics: +0.5% speed per point

2. Research Growth & Timing Equations
2.1 Research Cost Function
TechCost(L)=⌈BaseTechCost⋅(1.45)L−1⌉
2.2 Research Time Reduction Equation
ResearchTime(L)=BaseTechTime⋅(1.30)L−11+(0.10⋅InformaticsTech)+(0.005⋅MayorIntelligence)
3. Unit Stat Matrices & Training Curves
3.1 Unit Cost, Population, & Base Parameters
Unit	Food	Lumber	Stone	Iron	Gold	Pop	Speed	Range	Load
Worker	50	50	0	0	10	1	180	30	200
Warrior	100	50	0	20	20	1	200	30	80
Scout	100	100	0	100	50	1	3000	20	20
Pikeman	150	150	0	300	100	1	300	50	100
Swordsman	200	150	0	400	150	1	250	30	120
Archer	300	350	0	100	200	1	250	1200	140
Cavalry	1000	600	0	600	500	2	1000	100	250
Cataphract	2000	1000	0	1800	1000	3	750	100	350
Transporter	200	500	0	200	200	2	150	30	5000
Ballista	2000	2500	0	1500	1000	4	100	1400	3000
Ram	4000	3000	2000	3000	2000	5	120	60	4000
Catapult	5000	8000	3000	5000	3000	8	80	1500	5000
3.2 Training Time Reduction
TrainTimePerUnit=BaseTrainTime1+(0.10⋅MilitaryScience)+(0.005⋅MayorAttack)
4. Resource & Population Production Curves
4.1 Resource Field Base Yield
HourlyProduction(L)=BaseYield⋅(1.25)L−1
4.2 Total City Hourly Resource Yield
TotalYield=[∑i=1NHourlyProduction(Li)]⋅(1+0.05⋅TechLevel+MayorPolitics100+∑ValleyBuffs)
4.3 Population & Gold Income Mechanics

Cottage Capacity
MaxPop(L)=100⋅(1.30)L−1

Target Loyalty
Loyaltytarget=100−TaxRate

Hourly Gold
HourlyGold=CurrentPopulation⋅(TaxRate100)
5. Combat Parameter Modification Curves
5.1 Combat Attribute Modifiers

Effective Attack
Attackeff=BaseAttack⋅(1+0.05⋅MilitaryScience+0.01⋅HeroAttack)

Effective Defense
Defenseeff=BaseDefense⋅(1+0.05⋅IronWorking+0.01⋅HeroIntelligence)

Effective HP
HPeff=BaseHP⋅(1+0.05⋅Medicine)

Effective Range
Rangeeff=BaseRange⋅(1+0.05⋅ArcheryLevel)

Wall Range Bonus
WallRangebonus=100⋅WallLevel
6. NPC & Valley Scaling Matrices
6.1 Barbarian NPC City Scaling (Lv 1–10)
Level	Wall ATs	Total Troops	Avg Hero ATK	Food Loot	Gold Loot
1	200	1,000	15	100,000	10,000
2	650	3,000	25	300,000	30,000
3	1,300	8,000	40	800,000	80,000
4	2,000	18,000	60	1,800,000	180,000
5	3,000	40,000	85	4,500,000	450,000
6	4,500	90,000	115	9,000,000	900,000
7	6,000	180,000	150	18,000,000	1,800,000
8	8,000	350,000	190	36,000,000	3,600,000
9	10,500	600,000	240	72,000,000	7,200,000
10	14,000	1,100,000	300	150,000,000	15,000,000
6.2 Valley Resource Bonus Scaling
Valley Type	Bonus per Level	Max Bonus	Resource
Lake	+5%	+50%	Food
Forest	+3%	+30%	Lumber
Hill	+3%	+30%	Iron
Swamp	+3%	+30%	Food / Lumber
Desert	+3%	+30%	Stone
Grassland	+2%	+20%	Food
7. Prestige System Formula Matrix
PrestigeGained=∑u∈KilledUnits(Foodu+Lumberu+Stoneu+Ironu+Goldu100)⋅λdefender

Where:

    λdefender=1.0 for players

    λdefender=0.5 for NPCs / Valleys
