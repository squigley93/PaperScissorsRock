# PaperScissorsRock
Paper, scissors, rock (if you're Matt) ie. rock, paper, scissors for everyone else.

I assume most people are familar with the rules of rock, paper, scissors but if not here are the basics:
```rock crushes scissors, paper covers rock, scissors cuts paper```


This game can be played as a normal 2 players game or if any even number of players greater than 2 play it will work as a knockout tournament.


Once the game begins there will be a countdown of ```paper, scissors, rock, GO!```. The players will then have a couple of seconds to enter their choice. The players choice and the result of the match will then be shown to each client. 


If this is a tournament game all matches are played at the same time with all the match results shown after. 


If any draws occur during these matches the players involved will play rematchs to resolve the draws. Once all draws are resolved the round will end and round results will be shown to see who progresses. 
Play will continue like this until only one player is left.

## Installation
Clone this repo 

## How to start

### Server
Load the paperScissorsRock.q file into q eg. ```q paperScissorsRock.q```
This will use port 15000 by default but can be changed within the file.

### Client
Players should then hopen to the server port from a q session eg. q)h:hopen ``` `::15000```

### Game On
Once all players are connected the game can be started by either running ```q)janken[0b;players]``` on the server or a player can type ```"start"``` on their client side.
