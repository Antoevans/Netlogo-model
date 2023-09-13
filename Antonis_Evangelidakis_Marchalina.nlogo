;## Introduction

;Marchalina Hellenica is an endemic insect in the Mediterranean countries with huge populations in Turkey and Greece.
;It belongs to the family Margarodidae, of the Hemiptera-Cocoidae. The main tree which can be demoted from Marcalina is pinus.
;Especially in Greece, it attacks mainly Pinus halepensis and Pinus brutia. Sometimes we can found it on Pinus sylvestris, P. pinea, P. nigra in small populations.
;In Greece and Turkey it is considered beneficial for beekeepers because it provides food for honey bees (Apis mellifera)
;(Kailidis, 1965; Avtzis, 1985; Ciirkan, 1989). M. hellenica feeds on the sap of pines and excretes the excess sugar as droplets of honeydew,
;which is attractive to honey bees. It is estimated that more than 60-70% of the pine honey is produced by the excess sugar. M. hellenica
;reproduces by parthenogenesis once a year and lives in the gaps of the tree. It needs shadow and a temperature of 18-20 Celcius to lay eggs.
;According to K. Nikolopoulos (1965) the biological circle of the female includes four stages: egg, first stage, second stage as nymphs, and adulthood.
;During the second stage it overwinters dramatically increases the pumping of sap from the infected tree.
;There are needed 20 days for the oviposition period and 30 days for the hatching period (late of March until the end of May).
;Τhe spread of the insect is exponential and fast. It is estimated that, the time it takes to weaken a pine tree is more than 3 years.
;This insect is the first step for other diseases to act. Due to the large amount of honey that they produce various fungi grow,
;such as the genus Alternaria and the genus Cladosporium, which seem to be very destructive mainly to young, or very old trees and not so much in sturdy trees.




breed [trees tree]
breed [Marchalinas Marchalina]



globals [
 maximum_age
 year
 month
 reproduction
]

Marchalinas-own[
 age
]

trees-own [
   ;age of the tree
 stage ; growth stage
 maxage ; maximum age
 height
]

patches-own [food
 temperature
 humidity
]



to setup
 clear-all
 ask patches [ set pcolor white ] ;; set the color of patches white
   create-trees initial-number-trees [ ;create a slider that can reproduce trees, with maximum 3.000
  set shape "tree" ;the shape will be trees with size 1.5
  set size 1.5
 ]
 ask trees [setxy random-xcor random-ycor ;create the trees on random locations
  set color green
 ]
  create-Marchalinas initial-number-Marchalinas ;4 stages, 1st stage, 2nd stage, adults, eggs
 ask Marchalinas  [
   setxy random-xcor random-ycor ;create a number of Marchalinas which can be changed from the slider on the Interface
   set color yellow
   set shape "marchalina hellenica" ;I create a new Turtle shape editor and I named it Marchalina hellenica. Also another option could be bug shape because they have some similarities
   set size 3
 ]
   set maximum_age 3 * 12 ;3 years are the age that Marchalina can live
 reset-ticks
end


;if there is a tree nearby then they get infected too.
;in radius
;if there is a ifected tree nearby
;for random trees random insects occured

to setup-environment ;The environment is setup here
  set food 0
  set temperature 0
  set humidity 0
end




to go
  update_year_month
  eat-tree ;this is for Marchalinas
  move ;Marchalinas will move after the tree will die
  reproduce
  infected_trees
  get_older ; This is for Marchalina as well
  ask trees [
   if color = green and pcolor = yellow [ ;when Marchalina goes on the tree then it becomes yellow
   set color yellow
  ]
 ]
   ifelse ticks < temporal_extent ; temporal extent is for months which can be extented to 30.000 months
    [tick]
    [stop]
end

to update_year_month ;with this process we change the months
  set year 1
  if ticks / (12 * year) = 1 [set year year + 1] ;each tick is 1 month
  ifelse ticks < 12 ;12 months = 1 year
   [ set month ticks ] ;set month equal to tick
   [ set month ticks - (year - 1) * 12 ]

end


to eat-tree ;Marchalinas move randomly and when they found a tree(before they die) tree becomes yellow
  ask Marchalinas [
    set heading random 90
    forward 1
    if any? other Marchalinas-here with [color = yellow]
     [ set pcolor yellow ] ;set patch color equal to yellow (trees will become yellow when they get infected)
    if pcolor = green [
    set color white ;They are born with white colour and on the next stages they become white-yellow
  ]
 ]
  tick
end


to move ;Here we have a random movement of the insect in the map
  ask Marchalinas [
  if pcolor = white [
  rt random 90
  fd 1
  ]
 ]
end


to reproduce ; . It needs shadow and a temperature of 18-20 Celcius to lay eggs.
ask Marchalinas [
  if color = yellow and month = 4 [ ;month = 4 is April, the insect can reproduce it sheld 2 months per year. April - May.
  set age 0 ;We set the age of the new insects equal to 0
  hatch 10 ;hatch = 10 because the program crashed many times. The eggs that they can lay are on average 260.
   ]
 ]
end


to get_older
  ask Marchalinas [
   set age age + 1
  if age > maximum_age [die]
 ]
end


to infected_trees ;Here we have the infection of all the trees which are nearby.
  ask trees
  [if color = yellow and year = 1 [
  ask trees in-radius 1 ;when a tree get infected then the neaerby trees get infected too radius = 1
   [set color yellow]
  ]
 ]
end

;Results
;We can understand that when the forest diversity is pretty high then the insects can spread more quickly on the forest as a result, we will have more infected trees.





@#$#@#$#@
GRAPHICS-WINDOW
217
10
725
519
-1
-1
10.0
1
10
1
1
1
0
1
1
1
0
49
0
49
0
0
1
ticks
30.0

BUTTON
10
13
73
46
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
0
54
203
87
initial-number-trees
initial-number-trees
3000
5000
5000.0
10
1
trees
HORIZONTAL

BUTTON
106
13
169
46
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
0
104
204
137
initial-number-Marchalinas
initial-number-Marchalinas
2
20
20.0
1
1
Marchalinas
HORIZONTAL

SLIDER
1
156
194
189
temporal_extent
temporal_extent
0
300
35.0
5
1
months
HORIZONTAL

PLOT
849
54
1432
416
Infected trees
time
infected trees
0.0
100.0
0.0
5000.0
true
false
"" ""
PENS
"default" 1.0 0 -1184463 true "" "plot count trees with [color = yellow]"
"pen-1" 1.0 1 -7500403 true "" "plot count Marchalinas"

@#$#@#$#@
## Geberal information
Term paper: Simulation modelling
Student: Antonios Evangelidakis
Matrikelnummer: 27517784
Semester: 2nd


## Introduction

Marchalina Hellenica is an endemic insect in the Mediterranean countries with huge populations in Turkey and Greece. It belongs to the family Margarodidae, of the Hemiptera-Cocoidae. The main tree which can be demoted from Marcalina is pinus. Especially in Greece, it attacks mainly Pinus halepensis and Pinus brutia. Sometimes we can found it on Pinus sylvestris, P. pinea, P. nigra in small populations. In Greece and Turkey it is considered beneficial for beekeepers because it provides food for honey bees (Apis mellifera) (Kailidis, 1965; Avtzis, 1985; Ciirkan, 1989). M. hellenica feeds on the sap of pines and excretes the excess sugar as droplets of honeydew, which is attractive to honey bees. It is estimated that more than 60-70% of the pine honey is produced by the excess sugar. M. hellenica reproduces by parthenogenesis once a year and lives in the gaps of the tree. It needs shadow and a temperature of 18-20 Celcius to lay eggs. According to K. Nikolopoulos (1965) the biological circle of the female includes four stages: egg, first stage, second stage as nymphs, and adulthood. During the second stage it overwinters dramatically increases the pumping of sap from the infected tree. There are needed 20 days for the oviposition period and 30 days for the hatching period (late of March until the end of May). Τhe spread of the insect is exponential and fast. It is estimated that, the time it takes to weaken a pine tree is more than 3 years. This insect is the first step for other diseases to act. Due to the large amount of honey that they produce various fungi grow, such as the genus Alternaria and the genus Cladosporium, which seem to be very destructive mainly to young, or very old trees and not so much in sturdy trees.





## ODD PROTOCOL

## 1. Purpose

Question: How quickly can Marchalinas infect pine trees in a forest? 


On this model I tried to simulate the processes of Marcalina Helenica and how can demote and destroy a pine tree (forest) in some years. There are some reports said that if Marchalina has infected a tree for more than 3 years, then the tree start to die from the top of the canopy. 

The model is aimed at comparing scenarios how quickly can the insect (Marchalina) reproduce it shelf and how 	quickly can infect the trees in a pine forest.

## 2. Entities, State Variables and Scales

## 2.1 Entities

1) Marchalina Hellenica which is characterized by these state variables:

-Reproduction rate

-maximum age 

-and current age

Related global variables are:

-number of the insects

-movement

2) The second is trees which has these state variables:
  -stage

  -maxage

  -height

3) The third one are patches whcih characterized by these state variables:
-food

-temperature

-humidity

## Scales

1) Time step:
One tick (one time step) corresponds to 1 month

2) Temporal extent:
The model can be extented maximum to 300 months

3) Spatial grain:
One spatial unit (patch) corresponds to 49x49m

4)Spatial extent: 
The world covers an extent of 50x50 patches


## Process overview and scheduling

A lot of things are happening for each timestep:

1) Marchalinas start moving around (random move) until the found a tree.

2) They reproduce (Month 4th and hatch = 10). Those insects can reproduce their shelf from April to May. They can lay more than 250 eggs on average but then the program is crased. This is the main reason why hatch is equal to 10. The results could be more catastrophic

3) When they found a tree they stop there and the tree becoming yellow.

4)The trees nearby the infected tree get infected too.

5) Marchalina getting older for each timestep, maximum age = 3*12 (3 years).


## Design Concepts

1) Basic principles
The model assume that Marchalinas can reproduce their sheld pretty quickly and they can spread in a pine forest in some years.

2) Emergence
The main outputs of the model is the number of Marchalinas and the infected trees

3) Adaptation
Marchalinas adaptation due to the pine forest is different from mixed forests. They can reproduced more quickly as a result to spread their pollution more quickly in the forest.

4) Interaction
The main concept of the model is interaction. We can understand how quickly can Marchalina interact with pine trees and how quickly can reproduce their shelf.

5) Stochasticity
The movement of Marchalina is random inside the map but when they found a pine tree they stop and the tree is becoming yellow (infected). Also when the model is setup the location of the trees and Marchalinas all over the map is random.

6) Observation
The trees are with Green color.
Marchalinas are with yellow color.
Our outputs are getting update every timestep.


## Initialization

1) Hatch = 10 because when the number of reproduction is pretty higher (normal is 260) then the program is crased. The best number for the reproduction rate is 10. Hatch is for the reproduction of insect.

2) Marchalinas number 2-5 because it is easier to see their spread in the forest. Also 2 Marchalinas are pretty good numbers to pollute all the forest in 2-3 years.

3) The trees number could be from 3000-5000 all the numbers are pretty good to understand the degree of the problem which is pretty high. Less than 1000 trees would have smaller spread and reproduction.

4) Temporal extend shold be minimum 60 months to see the spread rate.


## Input Data
My model has not input data.All the information and the numbers for the procedures have been taken from other scientific papers that I mentioned on references.

## Submodels

Procedures:

1) Most of the paches are turned into trees.

2) Marchalinas are setup in random locations in numbers from 2-20. After a small movement when they find a tree they infect it and the tree become yellow and then, nearby trees also get infected from the isect, especially when the trees have pretty small distances from each other.

3)Trees have getting random location when we setup the model and their numbers are from 3000 up to 5000.

4) To set up environment we are giving some values for the environment parameters.

5)To update_year_month is the procedure which is responsible for the time and for ticks which are equal to month (1 tick = 1 month).

6) To eat-tree when they found a tree the tree is becoming yellow and after some years they are eating the tree.

7)To move is the procedure for the random moving of Marchalinas in the map.

8)To reproduce is the procedure for Marcalinas reproducing, but as I already mentioned the number of reproduction rate is not correct. The correct number should be more than 250 per insect but then the model is crasing and that is the reason why I write equal to 10.

9) To get_older is for Marclainas. When they get at age = 3 (3 years) then they will die.

10) To infected_trees when a tree is getting infected from the insect then the nearby trees will get infected also as soon as possible. 




## Credits and references
1.	Avtzis, N.1985. Marchalina hellenica (Monophlebus hellenicus) Genn. Greece’s most important honey-bearinginsect. Forestry Research, 6 (1): 51-64 (in Greek).

2.	Kailidis, D.L. (1965) Monophlebus hellenicus (Marchalina hellenica)
Gen. The melitogenic insect of the pine tree. Dasika Chronica
81182,1-15 (in Greek).

3.	Kailidis, D.S. (1991) Forest entomology and zoology. 4th edn.
Thessaloniki, Christodoulidis Press. (in Greek).

4.	Nikolopoulos, C. (1965) Morphology and biology of the species
Marchalina hellenica (Gennadius) (Hemiptera,
Margarodidae, Coclostomidiinae). Ecole de Hautes Etudes
Agronomique Athenes, Lab. Zool. Agr. Et Series, 1964, 3-31
(in Greek)
 
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

marchalina hellenica
true
4
Rectangle -1184463 true true 180 165 210 165
Line -1184463 true 135 150 135 150
Line -1184463 true 165 150 165 135
Rectangle -1184463 true true 165 135 165 135
Circle -1184463 true true 120 120 30
Circle -1184463 true true 120 120 30
Circle -1184463 true true 150 120 30
Circle -1184463 true true 180 120 30
Line -1184463 true 210 120 195 135
Line -1184463 true 210 150 195 135

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
