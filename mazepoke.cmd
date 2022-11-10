#mazepoke.cmd
# .mazepoke
#  designed to be called by .maze to use in the corn maze
#  Go poke all the halflings and the tog
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
#2020
#   initial release
#2021-11-09
#   speed run if $AlreadyLooted True
#   added retreat after killing the KillBoss
#   changed KillBoss to goto and retreat to remover
#2021-11-11
#   total rewrite of the way it handles pathing
#   just poke, ignore just about everything else, if you want to loot do that elsewhere
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
var path #goto 39|#goto 50|e|s|s|se|se|nw|nw|n|n|n|ne|ne|ne|ne|ne|ne|ne|n|se|s|sw|sw|sw|sw|sw|sw|sw|s|se|se|w|e|n|nw|n|ne|ne|ne|ne|ne|ne|sw|s|sw|sw|sw|sw|e|s|n|se|n|n|e|n|s|s|sw|sw|nw|se|#goto 227|ne|s|ne|ne|ne|n|n|n|ne|ne|ne|ne|e|e|e|e|e|e|sw|w|w|w|w|sw|sw|sw|sw|s|ne|ne|ne|ne|ne|e|sw|sw|sw|sw|sw|s|e|sw|w|n|sw|s|n|sw|sw|sw|sw|w|ne|sw|e|ne|e|ne|e|ne|w|e|ne|ne|ne|ne|n|ne|ne|sw|sw|s|sw|sw|sw|sw|#goto 395|s|s|w|w|e|e|e|e|w|n|e|e|s|e|n|n|e|e|e|n|e|n|s|s|s|w|s|e|w|w|w|n|e|w|w|s|w|n|n|w|w|w|#goto 212|n|w|nw|e|nw|w|nw|e|nw|n|s|w|sw|sw|w|ne|w|ne|w|ne|e|n|ne|sw|w|w|w|sw|sw|sw|w|ne|sw|w|ne|e|ne|n|e|w|sw|w|sw|#goto 185|sw|s|se|e|e|e|nw|e|se|e|nw|se|e|se|e|se|w|w|w|sw|w|ne|nw|se|sw|w|ne|w|w|w|w|w|nw|nw|n|n|n|ne|ne
var pathID 39|50|51|97|98|99|100|99|98|97|51|52|53|54|55|56|57|58|59|60|61|62|75|76|77|78|79|80|81|82|83|84|101|84|71|70|69|68|67|66|65|64|63|64|85|86|87|88|89|74|73|74|94|93|92|91|90|91|95|94|72|96|72|227|279|228|280|281|282|283|284|285|291|260|259|258|257|256|255|254|251|252|253|250|249|261|262|263|264|265|266|271|270|269|268|267|261|249|248|272|273|274|275|276|243|242|277|278|234|235|234|233|232|286|231|230|229|230|231|286|236|237|238|239|240|239|241|242|243|244|245|246|247|246|245|244|243|242|241|239|395|422|404|405|406|405|404|402|403|402|401|400|399|407|408|409|421|420|419|418|417|415|416|415|414|413|412|425|442|425|424|423|410|411|410|409|408|407|399|398|397|396|395|212|211|213|214|210|209|215|216|208|206|207|206|205|204|203|202|201|200|199|198|197|196|194|195|194|193|192|191|224|223|222|221|225|221|220|219|218|217|189|190|189|188|187|186|185|184|183|182|181|180|179|178|176|177|174|175|174|173|172|171|170|169|168|167|166|163|164|165|164|163|162|161|160|159|158|157|156|155|154|150|151|152|153|226
eval moveCount countsplit("%path", "|")
var c 0
var done 0

#### LOAD ACTIONS ####
action goto end when "^A cheerful looking Halfling wearing a wide brimmed hat comes up to you and says, .It looks like you got lost in the maze!  I'm here to escort you out\..  He takes your hand and leads you through the twisting passages and brings you to the exit\.$"
action var done 1 when "ASK HALFLING ABOUT TASK again\.$"

Start:
  var c 0
  put %path[%c]
  waitforre You are already here|YOU HAVE ARRIVED!
  delay 0.2
  if !matchre("$roomobjs", "tunnel") then {
    put #printbox Navigate it to the tunnel, room 39!
    waitfor You also see a small tunnel through the corn.
    delay 0.2
    }
  put #var roomid %pathID[%c]

#### MOVE around the Maze ###
moveLoop:
  if matchre("$roomobjs", "(?:the Scarecrow|Harawep's Spider)(?! (?:which|that) appears dead| \(dead\))") then {gosub KillBoss}
  if matchre("$monsterlist", "(Halfling|Gor'Tog)") then {gosub poke $1}
  if (%done) then {goto done}
  math c add 1
  if (%c >= %moveCount) then {
    put #var roomid 226
    goto done
    }
  if contains(%path[%c], " ") then {
    put %path[%c]
    waitforre You are already here\!|YOU HAVE ARRIVED!
    } else {
    gosub mover
    }
  goto moveLoop
####

#### MOVER ####
engaged:
  gosub retreat
mover:
remover:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  if ($standing != 1) then {gosub stand}
  matchre remover ^\.\.\.wait|^Sorry,|You must be standing
  if ("$AlreadyLooted" != "True") then {matchre search \b(altar|basket|boulder|burrow|fencepost|hay|hut|pail|rake|spiderweb|statue|stone|straw|wagon|wheelbarrow|wood)\b}
  match stun You are still stunned.
  matchre returner ^Obvious
  match moveError You can't go there.
  match engaged You are engaged
  put %path[%c]
  matchwait

stun:
  pause
  if ($stunned) then {goto stun}
  goto remover

KillBoss:
  echo ********************************
  echo **  Time for Combat!          **
  echo **  Type HUM HAPPY when done  **
  echo ********************************
  waitforre You hum happily to yourself|^A shower of tiny silver kernels falls from the
  put #script abort repeat
  pause 0.1
  send loot treasure
  wait
  if ("$righthand" != "Empty") then {send stow right}
  if ("$lefthand" != "Empty") then {send stow left}
  goto retreat

moveError:
  echo **********************************
  echo **  You screwed up the script!  **
  echo **  Try to get back on track.   **
  echo **  Type YES to continue.       **
  echo **********************************
  waitfor A good positive attitude never hurts.
  goto remover
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
  match returner You retreat from combat
  match returner You are already as far away as you can get!
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
  matchwait
pokePause:
  delay $pauseTime
  pause $pauseTime
#I know this is silly, but script is so fast that on the last one you need a pause
  if (%done) then {goto done}
AdvancePathIDValue:
  #poke done, loop ahead to next area
  math c add 1
  if (%c >= %moveCount) then {goto done}
  delay $automapper.loop
  if !contains("%path[%c]", "#goto") then {goto AdvancePathIDValue}
  #gotta subtract, because you're about to advance the counter as soon as you return
  math c subtract 1
  put #class +combat
  return
####

#### SEARCH LANDMARKS FOR HAWT LEWTZ ####
search:
  var searchitem $1
  if matchre("$roomobjs", "(?:the Scarecrow|Harawep's Spider)(?! (?:which|that) appears dead| \(dead\))") then {gosub KillBoss}
  math searches add 1
research:
  matchre research ^\.\.\.wait|^Sorry,
  matchre returner Sadly, you don't find|already been picked clean|The only thing you're|You find nothing|I could not find
  matchre stow You manage to find (.+)!
  put search %searchitem
  matchwait

stow:
  put #echo >talk Searching %searchitem...
  put #echo >talk #00FF00     You found $1
  math finds add 1
restow:
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

#### RETURN ####
return:
returner:
  return
