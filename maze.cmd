#maze.cmd
# Control script for corn maze
# .maze
#  Theoretically this will run the corn maze and stuff, but...
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
#
# Bits stolen from https://elanthipedia.play.net/Lich_script_repository#corn-maze
# Special thanks to Kiyora and Osin for providing passes so I can test!
#
# Buff PERCEPTION, OUTDOORSMANSHIP, ATHLETICS, ENGINEERING, LOCKSMITHING, PERFORMANCE, PERCEPTION
#  if you can
# 2020-11-13
# getting better about documentation
# rewriting for 2020 cornmaze
# it's hardcoded for a haversack and a 10-item hold-anything hip pouch
# 2021-11-10
#  put #goto 123 from 45
# 2021-11-12
#  fix %c loopahead, added more kill options
# 2021-11-15
#   Its mostly ok now, removing a lot of the debug stuff
# 2022-11-07
#   printbox and some copy/paste from commonINC
# 2022-11-08
#   O2 conversion
#   elegant location identification
# 2022-11-10
#   into the repo
# 2022-11-11
#   new way of handling tasks
#   gosub call
#debug 5

#### LOAD VARS ####
var task
var task_count 0
var good_task 0
var list_of_task
var scarecrow 0
var scarecrowTime 0
var weeds 0
var weedsTime 0
var traps 0
var trapsTime 0
var grasshopper 0
var grasshopperTime 0
var token 0
var tokenTime 0
var forage 0
var forageTime 0
var mice 0
var miceTime 0
var scream 0
var screamTime 0
var landmark 0
var landmarkTime 0
var poke 0
var pokeTime 0
var kill 0
var killTime 0
var TotalKernels 0
put #var AlreadyLooted False
var searchables basket|boulder|burrow|fence|hay|hut|pail|rake|spiderweb|statue|stones|straw|wagon|wheel|wood
var landmarks altar|basket|boulder|burrow|fence|hay|hut|pail|rake|scarecrow|spiderweb|statue|stones|straw|wagon|wheel|wood
var junk_list
#for early shutdown of script
var Kill 0

#### PATHS ####
var path #goto 2|e|e|e|e|e|e|e|sw|n|w|s|w|w|s|e|s|ne|w|w|s|w|n|n|w|w|s|s|e|n|e|s|e|s|sw|n|w|w|s|e|s|n|w|s|s|s|s|s|s|s|e|w|s|e|e|w|s|w|s
var pathID 2|3|4|5|6|7|8|9|10|8|7|16|18|11|12|19|20|17|19|12|13|21|22|23|24|25|26|27|28|29|22|21|13|14|15|30|31|32|33|34|35|34|33|36|37|38|39|40|41|42|43|42|44|45|46|45|47|48|49
eval moveCount countsplit("%path", "|")

#### LOAD ACTIONS ####
action goto done when "leads you through the twisting passages and brings you to the exit"
action put #echo >talk #FFFF00 $1 minutes remaining! when "^A barefoot Halfling trots up to you and says, .Hey, just to let you know you've only got (.+) minutes? of time left"
action put #echo >talk #00FF00 +$1 Kernels!!;math TotalKernels add $1 when "He dumps (\d+) silver kernels into your bottle and says"
action put #echo >talk #FFFF00 +20 Kernels from $1 KILL!;math TotalKernels add 20 when "^A shower of tiny silver kernels falls from the (Spider|Scarecrow)"
action put #echo >talk Boss $1 Active!;put #var AlreadyLooted False when "^You hear sinister laughter as the (Scarecrow) freely roams the ripened field of the Corn Maze!$|^You hear sinister laughter as the (Scarecrow) invades the Corn Maze!|^A hissing sound echoes through the Corn Maze as Harawep's (Spider) makes its appearance!|^You hear hissing noises as Harawep's (Spider) freely roams the green growth of the Corn Maze!"
action var $1 $2;put #echo >User #FF6666 %scriptname - SET [$1] TO [$2] when "^-setlocal %scriptname (\S+) (.*)"

#### ABORTS and PREP ####
put #window show talk

#### GET A TASK ####
ask:
#for early shutdown of script
  if (%Kill) then {goto done}
  if !matchre("$monsterlist", "Halfling") then {goto HeadOfMaze}
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre ask ^\.\.\.wait|^Sorry,|^You are still stun|^You can't do that while entangled
  match HeadOfMaze To whom are you
  match killPause You'll need to wait a bit before you can have another one.
  matchre doWhat ^(?:A cheerful Halfling smiles happily at you and replies|The Halfling looks at a scrap of paper in his pocket, then nods).+(forage|grasshopper|kill|landmark|mice|poke|scarecrow|scream|token|traps|weeds)
  put ask halfling about task
  put ask halfling for task
  matchwait
doWhat:
  if contains("$1", "$") then {goto ask}
  var task $1
  math %task add 1
  math task_count add 1
  var list_of_task %list_of_task|%task
  eval good_task %task_count - %kill - 1
  var taskTimeVar $gametime
  put #echo >talk #FFFF00 Maze Task: %task, Assigned: %task_count / Canceled: %kill / Finished: %good_task
  if ("%task" = "kill") then {goto kill}
#find the index of the $halfling room
  eval c replacere("%pathID", "\b$halfling\b.*", "")
  eval c count("%c", "|")
  if (%c >= %moveCount) then {
    put #printbox Halfling is not on the path!
    exit
    }
  if (($mazeConfirm) || ($roomid != %pathID[%c])) then {
    put #printbox I think the TaskGiver is in roomid: $roomid|pathID[c] = %pathID[%c]|Room set correctly?|Type YES to go do the task.
    waitforre ^A good positive attitude never hurts
    }
  put #var halfling $roomid
  gosub call maze%task
  eval %taskTime $gametime - %taskTimeVar
  var task
  var taskTimeVar
  if !matchre("$monsterlist", "cheerful Halfling") then {gosub findTaskGiver}
  goto ask
####

#### DONE ####
done:
  gosub clear
  pause 1
end:
  put #printbox ~~FINISHED MAZE @ $time~~|Completed %task_count tasks.|  built %scarecrow scarecrows (%scarecrowTime)|  pull %weeds weeds (%weedsTime)|  disarmed %traps trap (%trapsTime)|  found %grasshopper grasshoppers (%grasshopperTime)|  found %token tokens (%tokenTime)|  foraged %forage corn (%forageTime)|  scared %mice mice (%miceTime)|  yelled %scream times (%screamTime)|  touched %landmark landmarks (%landmarkTime)|  poked %poke halflings (%pokeTime)|  wasted time = %kill (%killTime)|List of task: %list_of_task|TOTAL KERNELS EARNED: %TotalKernels
  exit
####

#### Navigate to maze start (roomid = 2)
Start:
HeadOfMaze:
  if ($roomid != 2) then {
    put #goto 2
    waitforre You are already here|YOU HAVE ARRIVED!|a tall Merelew
    }
  delay 0.2
  if !matchre("$monsterlist", "Merelew") then {
    put #printbox Navigate to the head of the maze!
    waitfor tall Merelew
    }
  put #var roomid 2
  goto moveLoop
####

#### MOVE around the Maze ###
moveLoop:
  var c 0
NextRoom:
  if matchre("$monsterlist", "Halfling") then {goto ask}
  math c add 1
  if (%c >= %moveCount) then {
    put #var roomid 49
    goto HeadOfMaze
    }
  gosub mover %path[%c]
  delay $pauseTime
  if ($roomid != %pathID[%c]) then {put #var roomid %pathID[%c]}
  goto NextRoom
####

#### FIND TASKGIVER ####
findTaskGiver:
  put #printbox Find the cheerful Halfling, he was in room $halfling
  waitfor cheerful Halfling
  put #printbox I think the roomid is $roomid, use '#var roomid ##' to fix then type YES.
  waitforre ^A good positive attitude never hurts
#find the index of the $halfling room
  eval c replacere("%pathID", "\b$roomid\b.*", "")
  eval c count("%c", "|")
  if (%c >= %moveCount) then {
    put #printbox Halfling is not on the path!
    exit
    }
  put #var halfling $roomid
  return
####

#### BE A LOVER NOT A FIGHTER ####
kill:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre kill \.\.\.wait|^Sorry,|TASK CANCEL again
  match canceledTask Your current task has been canceled
  put task cancel
  matchwait
canceledTask:
  eval pauseTime $gametime + 285

goloot:
  put #printbox I think the TaskGiver is in room $roomid|Room set correctly?|Type YES to go LOOTING|HUM HAPPY to go MURDERING maze bosses|WAIT to just wait it out
  matchre lootrun ^A good positive attitude never hurts
  matchre bossrun ^You hum
  matchre killPause Time drags on by...
  matchwait 285
  goto killPause

lootrun:
  if matchre("$AlreadyLooted", "true|True|TRUE") then {goto bossrun}
  gosub call mazeloot
  put #var AlreadyLooted True
  goto killPause

bossrun:
  gosub call mazeboss
  goto killPause

killPause:
  if (%pauseTime > $gametime) then {
    eval pauseTime %pauseTime - $gametime
    put #printbox Pausing %pauseTime seconds
    pause %pauseTime
    eval killTime $gametime - %taskTimeVar
  }
  else {
    pause 1
    math killTime add 1
    }
  var task
  var taskTimeVar
  if !matchre("$monsterlist", "cheerful Halfling") then {gosub findTaskGiver}
  goto ask
####

#### I'm LOST! Try to reestablish bearings ####
Lost:
if matchre("$monsterlist", "Halfling") then {goto ask}
if matchre("$monsterlist", "Merelew") then {goto moveLoop}
if ($north) then {
  gosub mover north
  goto Lost
  }
if ($east) then {
  gosub mover east
  goto Lost
  }
if ($south) then {
  gosub mover south
  gosub mover south
  gosub mover east
  goto Lost
  }
var temp $west
math temp add $southwest
math temp add $east
math temp add $north
math temp add $south
math temp add southeast
math temp add northwest
math temp add northeast
if (%temp) then {
  gosub mover west
  gosub mover west
  goto Lost
  }
eval temp $west + $southwest
if (%temp = 2) then {
  gosub mover west
  gosub mover west
  gosub mover west
  gosub mover west
  goto Lost
  }
var task halfling
gosub findTaskGiver
goto Lost
####

####  COMMON SUBROUTINES  ####
include mazeINC
