#mazetask.cmd
# .mazetask (search|weeds|corn|mice|coin|scarecrow)
#  designed to be called by .maze to use in the corn maze
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
# 2022-11-08
#   Copied mazesearch
#   integrating all the scripts that don't leave the first area
# 2022-11-10
#   into the repo
#debug 5

if matchre("%0", "help|HELP|Help|^$") then {
  put #printbox .mazetask (search;pull weeds;forage corn;wave(mice);build scarecrow)|  designed to be called by .maze to use in the corn maze
  goto end
  }

#### LOAD VARS ####
eval Scriptname titlecase(%scriptname)
eval SCRIPTNAME tocaps(%scriptname)
put #echo >User #FF00FF $time >%SCRIPTNAME
timer start
var path #goto 2|e|e|e|e|e|e|e|sw|n|w|s|w|w|s|e|s|ne|w|w|s|w|n|n|w|w|s|s|e|n|e|s|e|s|sw|n|w|w|s|e|s|n|w|s|s|s|s|s|s|s|e|w|s|e|e|w|s|w|s
var pathID 2|3|4|5|6|7|8|9|10|8|7|16|18|11|12|19|20|17|19|12|13|21|22|23|24|25|26|27|28|29|22|21|13|14|15|30|31|32|33|34|35|34|33|36|37|38|39|40|41|42|43|42|44|45|46|45|47|48|49
eval moveCount countsplit("%path", "|")
var activity %0
eval do replacere("%activity", " ", ".")
var done 0

#### LOAD ACTIONS ####
action goto end when "^A cheerful looking Halfling wearing a wide brimmed hat comes up to you and says, .It looks like you got lost in the maze!  I'm here to escort you out\..  He takes your hand and leads you through the twisting passages and brings you to the exit\.$"
action var done 1 when "ASK HALFLING ABOUT TASK again\.$"

#### ABORTS and PREP ####
if matchre("$monsterlist", "Merelew") then {goto HeadofMaze}
#find the index of the $halfling room
eval c replacere("%pathID", "\b$halfling\b.*", "")
eval c count("%c", "|")
if (%c >= %moveCount) then {
  put #printbox Halfling is not on the path!
  goto end
  }
goto loop

HeadofMaze:
  var c 0
  put %path[%c]
  waitforre You are already here|YOU HAVE ARRIVED!|a tall Merelew
  delay $pauseTime
  if !matchre("$monsterlist", "Merelew") then {
    put #printbox Navigate it to the head of the maze!
    waitfor a tall Merelew
    }
  put #var roomid %pathID[%c]

loop:
  gosub %do
  put #class +combat
  delay $pauseTime
  if ($roomid != %pathID[%c]) then {put #var roomid %pathID[%c]}
  if (%done) then {goto done}
  math c add 1
  if (%c >= %moveCount) then {
    put #var roomid 49
    goto HeadofMaze
    }
  gosub mover %path[%c]
  goto loop
####

done:
  gosub clear
  put #printbox CURRENT ROOM: $roomid, PATHID: pathID[%c], HALFLING: $halfling
  put #goto $halfling
  waitforre You are already here|YOU HAVE ARRIVED!
  delay $pauseTime
  put #var roomid $halfling
  timer stop
  eval seconds round(%t) % 60
  if (%seconds < 10) then {var seconds 0%seconds}
  eval minutes %t / 60
  eval minutes floor(%minutes)
  put #printbox %SCRIPTNAME took %minutes:%seconds (min)
  put #echo >user $time <%SCRIPTNAME: %minutes:%seconds (%t)
  put #echo >talk <%SCRIPTNAME: %do took %minutes:%seconds
  put #parse ** MAZETASK DONE **
end:
  exit

####  COMMON SUBROUTINES  ####
include mazeINC

#### TIME TO PICK SOME CORN ####
#### TIME TO WEED THE FIELDS ####
#### CHASE MICE OUT HERE IN THE FIELDS ####
#### SEARCH FOR TOKENS(COINS)/GRASSHOPPERS/TRAPS ####
coin:
trap:
wave:
token:
search:
pull.weed:
pull.weeds:
grasshopper:
forage.corn:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  if matchre("$lefthandnoun$righthandnoun", "corn") then {put drop my corn}
  matchre token ^\.\.\.wait|^Sorry,|^You are still stun|^You can't do that while entangled
  matchre trapDisarm ^You notice a (?!grasshopper)
  matchre return ^Roundtime|^You've already
  put %activity
  matchwait 5
  goto search
####

#### DISARM TRAPS IN THE MAZE ####
trapDisarm:
  put #class -combat
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre trapDisarm ^\.\.\.wait|^Sorry,|^You are still stun|^You can't do that while entangled
  matchre return ^You manage to|^You'll need to SEARCH|^You guess this still counts
  put disarm trap
  matchwait 2
  goto trapDisarm
####

#### DO YOU WANNA BUILD A SCARECROW? ####
scarecrow:
build.scarecrow:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  if matchre("$roomobjs", "corn husk scarecrow") then {return}
  matchre scarecrow ^\.\.\.wait|^Sorry,|^You are still stun|^You can't do that while entangled|^Roundtime: 
  matchre return ^You put the finishing touches|already built a scarecrow here
  put %activity
  matchwait
####
