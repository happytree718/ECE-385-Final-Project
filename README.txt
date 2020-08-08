To run the project, you should first compile the project and load it onto the FPGA board. 
The FPGA board should be connected with a VGA monitor and a USB keyboard.
Then, open eclipse and run the software code which drives the USB keyboard. 
The project should work properly now.

Operational Guidelines:
W:	To control the character to move upwards.
S:	To control the character to move downwards.
A:	To control the character to move to the left.
D:	To control the character to move to the right.
W,A:	To control the character to move up left.
W,D:	To control the character to move up right.
S,A:	To control the character to move down left.
S,D:	To control the character to move down right.
↑:	To fire a bullet up. 
←:	To fire a bullet to the left.
→:	To fire a bullet to the right.
↓:	To fire a bullet down.

How to Start/Restart the game:
At the main menu, it has an instruction saying ‘Press ENTER to Start’. 
In this case, simply press ENTER and the game would move to the first dungeon you should conquer. 
When you finish one attempt, either winning the game or losing the game, with the monitor displaying either ‘YOU WIN’ or ‘GAME OVER’, you need to press ‘Esc’ to go back to the main menu.

Goal:
There are in total three dungeons in the game, in each dungeon, there would be two monster minions inside. 
In order to win the game, the character should explore all dungeons and  kill all monster minions inside. 
In the second dungeon, a golden key would reveal. In the third dungeon, after finishing shooting down all monsters, the character should insert the golden key to the center of the altar to pass the game. 
However, two monsters in each dungeon are not harmless. One of them can shoot bullets to all four directions continuously and the other chases the character and rests at a duty cycle of about 50%. 
Each bullet hitting the character would reduce the health of the character by one heart, while the character has seven hearts by default. If the character fails to dodge the bullets from monsters and as soon as the character's health goes down to zero, the character would die and would therefore lose the game. 
But for the second monster that chases you, as long as the character gets caught, the character would lose the game immediately. 
