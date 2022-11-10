#mazelandmarks.cmd
# .mazelandmarks
#  designed to be called by .maze to use in the corn maze
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
#2020
#   initial release, still buggy
#2021
#   working now
#2021-11-15
#   Its mostly ok now, removing a lot of the debug stuff
# 2022-11-07
#   Update for O2
#   elegant location identification
#   elengantly starts at the halfling
#I just found a situation where if you get two landmark touch tasks in a row, the script will just keep looping since there aren't 20 things on the route.  I paused, ran to other parts of the maze, touched manually, resumed, typed task to trigger the "you're done" message and it finished.  I'll probably hard-code all the searchables to the touch task now.... but that's for next year.
#I added a few landmarks, up to 14 now I think
#debug 5

#### LOAD VARS ####
eval Scriptname titlecase(%scriptname)
eval SCRIPTNAME tocaps(%scriptname)
put #echo >User #FF00FF >%SCRIPTNAME: $time
var totaltime $gametime
var path #goto 2|e|e|e|e|e|e|e|sw|n|w|s|w|w|s|e|s|ne|w|w|s|w|n|n|w|w|s|s|e|n|e|s|e|s|sw|n|w|w|s|e|s|n|w|s|s|s|s|s|s|s|e|w|s|e|e|w|s|w|s|go tunnel|s|s|go tunnel|n|n|#goto 99|#goto 52|#goto 59|#goto 61|#goto 79|#goto 96|#goto 93|#goto 86|#goto 79
var pathID 2|3|4|5|6|7|8|9|10|8|7|16|18|11|12|19|20|17|19|12|13|21|22|23|24|25|26|27|28|29|22|21|13|14|15|30|31|32|33|34|35|34|33|36|37|38|39|40|41|42|43|42|44|45|46|45|47|48|49|102|103|104|150|151|152|99|52|59|61|79|96|93|86|79
eval moveCount countsplit("%path", "|")
var c 0
var done 0

#### LOAD ACTIONS ####
action goto end when "^A cheerful looking Halfling wearing a wide brimmed hat comes up to you and says, .It looks like you got lost in the maze!  I'm here to escort you out\..  He takes your hand and leads you through the twisting passages and brings you to the exit\.$"
action var done 1 when "ASK HALFLING ABOUT TASK again\.$"

if (matchre("$monsterlist", "Merelew") || ($halfling = 2)) then {goto Start}
#find the index of the $halfling room
eval c replacere("%pathID", "\b$halfling\b.*", "")
eval c count("%c", "|")
if (%c >= %moveCount) then {
  put #printbox Halfling is not on the path!
  exit
  }
goto loop

Start:
  var c 0
  put %path[%c]
  waitforre You are already here|YOU HAVE ARRIVED!|a tall Merelew
  delay 0.2
  if !matchre("$monsterlist", "Merelew") then {
    put #printbox Navigate it to the head of the maze!
    waitfor tall Merelew
    }
  put #var roomid %pathID[%c]

loop:
  if (%done) then {goto done}
  math c add 1
  if (%c >= %moveCount) then {
    put #var roomid 39
    goto Start
    }
  if contains("%path[%c]", "#goto") then {
    put %path[%c]
    waitforre You are already here|YOU HAVE ARRIVED!
    delay $pauseTime
    if matchre("$roomobjs", "\b(altar|basket|boulder|burrow|fencepost|hay|hut|pail|rake|scarecrow|spiderweb|statue|stones|straw|wagon|wheelbarrow|wood)\b") then {
      var searchitem $1
      gosub research
      }
    }
  else {gosub mover}
  delay $pauseTime
  if ($roomid != %pathID[%c]) then {put #var roomid %pathID[%c]}
  goto loop

done:
  gosub clear
  delay 0.2
  put #printbox CURRENT ROOM: $roomid, PATHID: pathID[%c], HALFLING: $halfling
#  put #goto $halfling from %pathID[%c]
  put #goto $halfling
  waitforre You are already here|YOU HAVE ARRIVED!
  delay 0.2
  put #var roomid $halfling

end:
  math totaltime subtract $gametime
  math totaltime multiply -1
  var minutes %totaltime
  var seconds %totaltime
  math seconds modulus 60
  if (%seconds < 10) then {var seconds 0%seconds}
  math minutes divide 60
  if matchre("%minutes", "(\d+)\.\d*") then {var minutes $1}
  put #printbox %SCRIPTNAME took %minutes:%seconds (min)
  put #echo >user <%SCRIPTNAME: %minutes:%seconds
  put #parse ** MAZETASK DONE **
  exit

#### MOVER ####
mover:
remover:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  if (!$standing) then {gosub stand}
  matchre remover ^\.\.\.wait|^Sorry,|^You are still stun|^You can't do that while entangled
  matchre touch \b(altar|basket|boulder|burrow|fencepost|hay|hut|pail|rake|scarecrow|spiderweb|statue|stones|straw|wagon|wheelbarrow|wood)\b
  matchre returner ^(?:Obvious|Ship) (?:paths|exits):
  match moveError You can't go there.
  match retreat You are engaged
  put %path[%c]
  matchwait

moveError:
  echo **********************************
  echo **  You screwed up the script!  **
  echo **  Try to get back on track.   **
  echo **  Type YES to continue.       **
  echo **********************************
  waitfor A good positive attitude never hurts.
  goto returner
####

#### STAND ####
stand:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  match dead You are a ghost!
  matchre stand ^\.\.\.wait|^Sorry,|^You can't do that while entangled|^You are still
  matchre return ^You (?:stand|are already standing)
  matchre stand ^You must stand first\.$|^You are so unbalanced you cannot manage to stand\.$|^The weight of all your possessions prevents you from standing\.$
  put stand
  matchwait
####

#### RETREAT ####
retreat:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre retreat ^\.\.\.wait|^Sorry,|^You are still stun|^You can't do that while entangled|^You (?:try to sneak|sneak|retreat back)|discovers you trying to sneak out
  matchre mover ^You (?:are already |sneak back out of combat|retreat from combat)
  put retreat;retreat
  matchwait
####

#### TOUCHY TOUCHY ####
touch:
  var searchitem $1
research:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre research ^\.\.\.wait|^Sorry,|^You can't do that while entangled|^You are still
  matchre returner ^You reach out|^A tingle runs|^Touch what|^You've already|^You're pretty sure
  put touch %searchitem
  matchwait
####

#### RETURN ####
return:
returner:
  return
####
