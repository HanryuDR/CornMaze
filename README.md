# CornMaze
Hanryu's Corn Maze Suite
start with .mazego at the halfling
if you're already in the maze, run back to the merelew (head of maze) and .maze
have a container for loot, $container_maze
have a backup mary poppins bag from the maze
  put put $righthandnoun in my hip pouch
now with a mazeConfirm global
  if everything works fine just set it to 0 to stop getting YES spam
There's a mazeCombat var now
  #var mazeCombat 1, you wanna fight!
  #var mazeCombat 0, skip these shit tasks
The `talk` window and a `user` window are handy for messages about scripts

Q: It looks like looting only works once, so every other time I cancel a combat task I should be searching for maze bosses?
A: You can force another loot if you want, just flip the mazeLooted variable to 1

The script will track if a boss has respawned.  You can go directly to the area with that boss with .mazewalk (spider|scarecrow)