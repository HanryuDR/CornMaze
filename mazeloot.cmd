#mazeloot.cmd
# .mazeloot
#  designed to be called by .maze to use in the corn maze
#  Search the corn maze for all the intractable objects
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
#2020
#   initial release
#2021-11-10
# added retreat after killing the KillBoss
# changed KillBoss to goto and retreat to remover
#2021-11-15
#   Its mostly ok now, removing a lot of the debug stuff
# 2022-11-07
#   bug where goes GOTO retreat instead of return afterkill
#   Update for O2
# 2022-11-10
#   into the repo
#debug 5

#### LOAD VARS ####
eval Scriptname titlecase(%scriptname)
eval SCRIPTNAME tocaps(%scriptname)
put #echo >User #FF00FF >%SCRIPTNAME: $time
var totaltime $gametime
var searches 0
var finds 0
var poke 0
if contains("%0", "poke") then {var poke 1}

Start:
  put #goto 39
  waitforre You are already here|YOU HAVE ARRIVED!
  delay $pauseTime
  if !matchre("$roomobjs", "tunnel") then {
    put #printbox  Navigate it to the tunnel!
    waitfor You also see a small tunnel through the corn.
    delay 0.2
    }
  put #var roomid 39

gosub mover go tunnel
gosub mover e
gosub mover n
#SHOULD BE A TREASURE HERE 1
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover ne
#SHOULD BE A TREASURE HERE 2
gosub mover n
gosub mover se
#SHOULD BE A TREASURE HERE 3
gosub mover s
gosub mover sw
gosub mover sw
gosub mover sw
gosub mover sw
gosub mover sw
#SHOULD BE A TREASURE HERE 4
gosub mover sw
gosub mover sw
gosub mover s
gosub mover se
gosub mover se
gosub mover n
gosub mover nw
gosub mover n
#SHOULD BE A TREASURE HERE 5
gosub mover s
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover ne
#SHOULD BE A TREASURE HERE 6
gosub mover s
gosub mover s
gosub mover w
gosub mover s
#SHOULD BE A TREASURE HERE 7
gosub mover s
gosub mover sw
gosub mover nw
#SHOULD BE A TREASURE HERE 8
gosub mover se
gosub mover sw
gosub mover sw
gosub mover nw
#SHOULD BE A TREASURE HERE 9
gosub mover se
gosub mover ne
gosub mover ne
#DONE WITH LEFT WING
gosub clear
gosub mover go tunnel
gosub mover e
gosub mover sw
gosub mover sw
gosub mover e
#SHOULD BE A TREASURE HERE 10
gosub mover w
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover ne
#SHOULD BE A TREASURE HERE 11
gosub mover n
gosub mover n
gosub mover n
gosub mover ne
gosub mover ne
#SHOULD BE A TREASURE HERE 12
gosub mover ne
gosub mover ne
gosub mover e
gosub mover e
gosub mover e
gosub mover e
gosub mover e
#SHOULD BE A TREASURE HERE 13
gosub mover sw
gosub mover w
gosub mover w
gosub mover w
#SHOULD BE A TREASURE HERE 14
gosub mover sw
gosub mover sw
gosub mover sw
gosub mover sw
gosub mover s
#SHOULD BE A TREASURE HERE 15
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover ne
gosub mover e
gosub mover sw
gosub mover sw
gosub mover sw
#SHOULD BE A TREASURE HERE 16
gosub mover sw
gosub mover sw
gosub mover s
gosub mover e
gosub mover sw
gosub mover sw
gosub mover sw
#SHOULD BE A TREASURE HERE 17
gosub mover ne
gosub mover ne
gosub mover w
gosub mover n
gosub mover sw
#SHOULD BE A TREASURE HERE 18
gosub mover ne
gosub mover s
gosub mover e
gosub mover ne
gosub mover ne
#SHOULD BE A TREASURE HERE 19
gosub mover n
gosub mover ne
#DONE WITH RIGHT WING
gosub clear
gosub mover go tunnel
gosub mover s
#SHOULD BE A TREASURE HERE 20
gosub mover s
gosub mover w
gosub mover sw
#SHOULD BE A TREASURE HERE 21
gosub mover e
gosub mover n
gosub mover e
gosub mover e
gosub mover n
gosub mover s
gosub mover w
#now in room 321
gosub mover n
gosub mover n
gosub mover e
gosub mover e
gosub mover e
gosub mover e
gosub mover w
gosub mover w
gosub mover n
gosub mover w
gosub mover ne
#SHOULD BE A TREASURE HERE 22
gosub mover n
gosub mover e
gosub mover s
gosub mover e
#SHOULD BE A TREASURE HERE 23
gosub mover n
gosub mover e
gosub mover n
gosub mover sw
gosub mover s
gosub mover w
gosub mover s
gosub mover e
gosub mover e
gosub mover n
#SHOULD BE A TREASURE HERE 24
gosub mover s
gosub mover s
gosub mover s
gosub mover w
gosub mover s
gosub mover w
gosub mover s
gosub mover e
gosub mover e
#SHOULD BE A TREASURE HERE 25
gosub mover n
gosub mover s
gosub mover s
gosub mover s
gosub mover w
gosub mover s
gosub mover w
gosub mover s
#SHOULD BE A TREASURE HERE 26
gosub mover e
gosub mover s
#SHOULD BE A TREASURE HERE 27
gosub mover se
gosub mover n
gosub mover n
gosub mover n
gosub mover s
gosub mover w
gosub mover w
gosub mover n
gosub mover n
gosub mover n
gosub mover e
gosub mover w
gosub mover w
#SHOULD BE A TREASURE HERE 28
gosub mover n
gosub mover n
gosub mover n
#SHOULD BE A TREASURE HERE 29
gosub mover e
gosub mover w
gosub mover s
gosub mover s
gosub mover w
gosub mover w
gosub mover se
gosub mover se
#SHOULD BE A TREASURE HERE 30
gosub mover s
#DONE WITH FIELD
gosub clear
gosub mover go tunnel
gosub mover w
gosub mover n
gosub mover w
gosub mover n
#SHOULD BE A TREASURE HERE 31
gosub mover sw
gosub mover w
gosub mover n
gosub mover w
#SHOULD BE A TREASURE HERE 32
gosub mover se
gosub mover e
gosub mover e
gosub mover se
gosub mover se
gosub mover s
#SHOULD BE A TREASURE HERE 33
gosub mover se
gosub mover se
gosub mover se
gosub mover se
#SHOULD BE A TREASURE HERE 34
gosub mover sw
gosub mover s
gosub mover s
gosub mover sw
gosub mover sw
#SHOULD BE A TREASURE HERE 35
gosub mover w
gosub mover w
gosub mover w
gosub mover w
gosub mover w
gosub mover sw
#SHOULD BE A TREASURE HERE 36
#DONE WITH PART OF TAIL
gosub clear
gosub mover go tunnel
gosub mover s
gosub mover s
gosub mover e
#SHOULD BE A TREASURE HERE 37
gosub mover n
gosub mover n
gosub mover e
gosub mover e
#SHOULD BE A TREASURE HERE 38
gosub mover s
gosub mover s
gosub mover e
gosub mover n
gosub mover e
gosub mover e
gosub mover e
gosub mover e
#SHOULD BE A TREASURE HERE 39
gosub mover w
gosub mover s
#SHOULD BE A TREASURE HERE 40
gosub mover n
gosub mover n
gosub mover w
gosub mover w
#SHOULD BE A TREASURE HERE 41
gosub mover w
gosub mover s
gosub mover s
gosub mover w
gosub mover n
gosub mover n
gosub mover w
gosub mover w
gosub mover w
#DONE WITH BLIGHT
gosub clear
gosub mover go tunnel
gosub mover sw
gosub mover sw
gosub mover sw
gosub mover n
gosub mover ne
#SHOULD BE A TREASURE HERE 42
gosub mover ne
gosub mover ne
gosub mover e
gosub mover e
#SHOULD BE A TREASURE HERE 43
gosub mover e
gosub mover e
gosub mover ne
#SHOULD BE A TREASURE HERE 44
#DONE WITH REST OF TAIL
gosub clear
gosub mover go tunnel
gosub mover n
#SHOULD BE A TREASURE HERE 45
gosub mover nw
gosub mover nw
gosub mover nw
#SHOULD BE A TREASURE HERE 46
gosub mover w
gosub mover nw
gosub mover sw
gosub mover sw
gosub mover w
gosub mover ne
#SHOULD BE A TREASURE HERE 47
gosub mover w
gosub mover ne
gosub mover w
gosub mover ne
gosub mover e
gosub mover n
gosub mover ne
#SHOULD BE A TREASURE HERE 48
gosub mover sw
gosub mover w
gosub mover w
gosub mover w
gosub mover sw
gosub mover sw
gosub mover sw
#SHOULD BE A TREASURE HERE 49
gosub mover w
gosub mover w
gosub mover ne
gosub mover e
#SHOULD BE A TREASURE HERE 50
gosub mover ne
gosub mover n
gosub mover sw
gosub mover w
gosub mover sw
#SHOULD BE A TREASURE HERE 51
#DONE WITH LEGS
gosub clear
gosub mover go tunnel
gosub mover sw
gosub mover s
gosub mover se
gosub mover e
gosub mover e
gosub mover e
gosub mover nw
#SHOULD BE A TREASURE HERE 52
gosub mover e
gosub mover e
gosub mover se
#SHOULD BE A TREASURE HERE 53
gosub mover e
gosub mover se
gosub mover e
gosub mover se
gosub mover w
#SHOULD BE A TREASURE HERE 54
gosub mover w
gosub mover w
gosub mover sw
gosub mover w
#SHOULD BE A TREASURE HERE 55
gosub mover w
gosub mover ne
gosub mover w
gosub mover w
gosub mover w
#SHOULD BE A TREASURE HERE 56
gosub mover w
gosub mover w
gosub mover nw
gosub mover nw
gosub mover n
gosub mover n
gosub mover n
#SHOULD BE A TREASURE HERE 57
gosub mover s
gosub mover s
#DONE WITH NECK
gosub clear
gosub mover go tunnel
#SHOULD BE A TREASURE HERE 58
gosub mover s
gosub mover s
gosub mover s
gosub mover s
gosub mover s
gosub mover e
gosub mover e
#SHOULD BE A TREASURE HERE 59
gosub mover e
gosub mover s
gosub mover e
gosub mover s
gosub mover s
gosub mover s
#SHOULD BE A TREASURE HERE 60
gosub mover e
gosub mover e
gosub mover e
gosub mover e
gosub mover w
gosub mover n
gosub mover n
gosub mover e
#SHOULD BE A TREASURE HERE 61
gosub mover s
gosub mover n
gosub mover ne
gosub mover w
gosub mover w
gosub mover w
#SHOULD BE A TREASURE HERE 62
gosub mover s
gosub mover w
gosub mover s
#SHOULD BE A TREASURE HERE 63
gosub mover e
gosub mover w
gosub mover n
gosub mover n
gosub mover w
gosub mover w
gosub mover w
gosub mover s
gosub mover w
#SHOULD BE A TREASURE HERE 64
gosub mover n
gosub mover s
gosub mover s
gosub mover e
gosub mover e
gosub mover n
#SHOULD BE A TREASURE HERE 65
gosub mover s
gosub mover s
gosub mover n
gosub mover w
gosub mover w
gosub mover n
gosub mover n
gosub mover w
gosub mover s
#SHOULD BE A TREASURE HERE 66
gosub mover s
gosub mover s
gosub mover e
gosub mover e
gosub mover w
gosub mover w
gosub mover n
gosub mover n
gosub mover n
gosub mover n
gosub mover n
gosub mover n
gosub mover n
gosub mover n
gosub mover n
gosub mover n
#SHOULD BE A TREASURE HERE 67
gosub mover n
#DONE WITH GROWTH
gosub clear
gosub mover go tunnel
gosub mover n
gosub mover e
#SHOULD BE A TREASURE HERE 68
gosub mover n
gosub mover w
gosub mover n
#SHOULD BE A TREASURE HERE 69
gosub mover n
gosub mover n
gosub mover n
gosub mover n
#SHOULD BE A TREASURE HERE 70
gosub mover n
gosub mover n
gosub mover n
gosub mover e
gosub mover e
#SHOULD BE A TREASURE HERE 71
gosub mover n
#SHOULD BE A TREASURE HERE 72
gosub mover e
gosub mover n
gosub mover w
gosub mover n
#SHOULD BE A TREASURE HERE 73
gosub mover w
gosub mover s
gosub mover w
gosub mover n
#SHOULD BE A TREASURE HERE 74
gosub mover n
gosub mover e
gosub mover e
gosub mover s
gosub mover s
gosub mover e
gosub mover n
gosub mover e
gosub mover e
#SHOULD BE A TREASURE HERE 75
gosub mover n
#SHOULD BE A TREASURE HERE 76
gosub mover n
gosub mover w
gosub mover w
#SHOULD BE A TREASURE HERE 77
gosub mover w
gosub mover w
gosub mover w
#SHOULD BE IN MAZE START
put #var roomid 2

done:
  gosub clear
  delay 0.1
  put #var mazeLooted 1
  put #echo >talk Finding the halfling, He was in room $halfling
  put #goto $halfling
  waitforre You are already here|YOU HAVE ARRIVED!|^A good positive
  delay 0.1
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
  put #printbox %SCRIPTNAME took %minutes:%seconds (min) to find %finds after searching %searches times!
  put #echo >user <%SCRIPTNAME: %minutes:%seconds (min) %finds items / %searches searches
  put #parse ** MAZETASK DONE **
  exit

mover:
  var direction &0
remover:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  if (!$standing) then {gosub stand}
  if matchre("$roomobjs", "(?:the Scarecrow|Harawep's Spider)(?! (?:which|that) appears dead| \(dead\))") then {gosub KillBoss}
  matchre remover \.\.\.wait|^Sorry,|You stand
  if (%poke) then {matchre poke (Halfling|Gor'Tog)}
  matchre search \b(altar|basket|boulder|burrow|fencepost|hay|hut|pail|rake|spiderweb|statue|stones|straw|wagon|wheelbarrow|wood)\b
  matchre returner ^Obvious
  match moveError You can't go there.
  match retreat You are engaged
  put %direction
  matchwait

#### Kill the boss! ####
KillBoss:
  var bossTimer $gametime
  put #printbox Time for Combat!|Type HUM HAPPY when done
  waitforre You hum happily to yourself|^A shower of tiny silver kernels falls from the
  put #script abort repeat
  eval bossTimer $gametime - %bossTimer
  if (%bossTimer > 15) then {put #echo >talk #FF0000 Killing the boss took %bossTimer seconds}
  delay $pauseTime
  if ($roundtime > 0) then {pause $pauseTime}
  send loot treasure
  wait
  if ("$righthand" != "Empty") then {send stow right}
  if ("$lefthand" != "Empty") then {send stow left}
  goto retreat
####

moveError:
  echo **********************************
  echo **  You screwed up the script!  **
  echo **  Try to get back on track.   **
  echo **  Type YES to continue.       **
  echo **********************************
  waitfor A good positive attitude never hurts.
  goto returner
####

#### SEARCH LANDMARKS FOR HAWT LEWTZ ####
search:
  var searchitem $1
  if matchre("$roomobjs", "(?:the Scarecrow|Harawep's Spider)(?! (?:which|that) appears dead| \(dead\))") then {gosub KillBoss}
  math searches add 1
research:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre research \.\.\.wait|^Sorry,
  matchre returner Sadly, you don't|has already been picked clean|The only thing you're going|You find nothing|I could not find
  matchre stow You manage to find (.+)!
  put search %searchitem
  matchwait

stow:
  put #echo >talk Searching %searchitem...
  put #echo >talk #00FF00     You found $1
  math finds add 1
restow:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre restow ^\.\.\.wait|^Sorry,
  matchre returner ^You put|^But that|^That can't be|^Stow what
  match stowError2 You need a free hand to pick that up.
  matchre stowError3 too (long|wide) to fit in|There isn't any more room|There's no room in the
  put put $righthandnoun in my $container_maze
  matchwait
stowError1:
stowError2:
  echo **********************************
  echo **  Fix the error and type YES  **
  echo **********************************
  waitfor positive attitude
  return
stowError3:
  put put $righthandnoun in my hip pouch
  waitfor You put
  return
####

#### RETURN ####
return:
returner:
  return
####

#### STAND ####
stand:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre stand \.\.\.wait|^Sorry,|cannot manage to stand\.|The weight of all your possessions
  matchre return You stand|You are already standing
  put stand
  matchwait
####

#### RETREAT and MOVE ####
retreat:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  match retreat ...wait
  match retreat Sorry,
  match retreat You retreat back
  match remover You retreat from combat
  match remover You are already as far away as you can get!
  put retreat
  matchwait
####

#### POKE? REALLY? ####
poke:
  var pokeVar $1
  delay 0.1
  if ($roomid != %pathID[%c]) then {put #var roomid %pathID[%c]}
  put #class -combat
repoke:
  matchre repoke ^\.\.\.wait|^Sorry,
  match pokePause You think that definitely counted toward your
  matchre returner ^What were you referring|^You're pretty sure you're|^A cheerful Halfling squirms and laughs at
  put poke %pokeVar
  matchwait 3
  goto repoke
pokePause:
  delay $pauseTime
  pause $pauseTime
  put #class +combat
  return
####