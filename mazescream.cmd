#mazescream.cmd
# .mazescream
#  designed to be called by .maze to use in the corn maze
#  Go scream in 5 sections of the maze
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
#2020
#   initial release
#2021-11-10
#   robustification
#2021-11-15
#   Its mostly ok now, removing a lot of the debug stuff
# 2022-11-07
#   Update for O2
# 2022-11-10
#   into the repo
#debug 5

#### LOAD VARS ####
eval Scriptname titlecase(%scriptname)
eval SCRIPTNAME tocaps(%scriptname)
put #echo >User #FF00FF >%SCRIPTNAME: $time
var totaltime $gametime
var done 0

#### LOAD ACTIONS ####
action goto end when "^A cheerful looking Halfling wearing a wide brimmed hat comes up to you and says, .It looks like you got lost in the maze!  I'm here to escort you out\..  He takes your hand and leads you through the twisting passages and brings you to the exit\.$"
action var done 1 when "ASK HALFLING ABOUT TASK again\.$"

put #echo >User #FF00FF >MAZESCREAM: $time

Start:
  put #goto 39
  waitforre You are already here|YOU HAVE ARRIVED!
  delay $pauseTime
  if !matchre"($roomobjs", "tunnel") then {
    put #printbox Navigate it to the tunnel, room 39!
    waitfor You also see a small tunnel through the corn.
    }
  put #var roomid 39
  gosub scream
  gosub mover go tunnel
  gosub scream
  gosub mover e
  gosub mover s
  gosub mover s
  gosub mover se
  gosub mover se
  gosub mover ne
  gosub mover ne
  gosub mover go tunnel
  gosub scream
  gosub mover go tunnel
  gosub clear
  gosub mover sw
  gosub mover sw
  gosub mover go tunnel
  gosub scream
  gosub mover sw
  gosub mover sw
  gosub mover s
  gosub mover s
  gosub mover go tunnel
  gosub scream
  gosub mover n
  gosub mover n
  gosub mover go tunnel

done:
  gosub clear
  put #var roomid 49
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

#### PURIEL WITH THE SCREAMY WEAMYS ####
scream:
  matchre scream \.\.\.wait|^Sorry,
  match returner You lift
  match returner You've aready
  put scream
  put task
  matchwait
####

#### MOVER ####
mover:
  var direction &0
remover:
  if ($standing != 1) then {put stand}
  if (%done) then {match done cheerful Halfling}
  matchre remover \.\.\.wait|^Sorry,|You stand|You are still stunned\.
  matchre returner ^Obvious
  match moveError You can't go there.
  match retreat You are engaged
  put %direction
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
  matchre stand \.\.\.wait|^Sorry,|cannot manage to stand\.|The weight of all your possessions
  matchre return You stand|You are already standing
  put stand
  matchwait
####

#### RETREAT and MOVE ####
retreat:
  match retreat ...wait
  match retreat Sorry,
  match retreat You retreat back
  match mover You retreat from combat
  match mover You are already as far away as you can get!
  put retreat
  matchwait
####

#### RETURN ####
return:
returner:
  return
