#mazewalk.cmd
# .mazetask (poke|loot|boss)
#   handle poke, loot, boss, spider, scarecrow
#   designed to be called by .maze to use in the corn maze
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
# 2022-11-16
#   initial release, merged poke/loot/boss
# 2022-11-17
#hrm I need an elegant way to just target the scarecrow OR the spider
#   ok call by name and target a boss
debug 5

if matchre("%0", "help|HELP|Help|^$") then {
  put #printbox .mazewalk (poke;loot;boss;spider;scarecrow)|  designed to be called by .maze to use in the corn maze
  goto end
  }

#### LOAD VARS ####
eval Scriptname titlecase(%scriptname)
eval SCRIPTNAME tocaps(%scriptname)
put #echo >User #FF00FF >%SCRIPTNAME: $time
timer start
var leftwing #goto 50|e|s|s|se|se|nw|nw|n|n|n|ne|ne|ne|ne|ne|ne|ne|n|se|s|sw|sw|sw|sw|sw|sw|sw|s|se|se|w|e|n|nw|n|ne|ne|ne|ne|ne|ne|sw|s|sw|sw|sw|sw|e|s|n|se|n|n|e|n|s|s|sw|sw|nw|se
var leftwing_pathID 50|51|97|98|99|100|99|98|97|51|52|53|54|55|56|57|58|59|60|61|62|75|76|77|78|79|80|81|82|83|84|101|84|71|70|69|68|67|66|65|64|63|64|85|86|87|88|89|74|73|74|94|93|92|91|90|91|95|94|72|96|72
var rightwing #goto 227|ne|s|ne|ne|ne|n|n|n|ne|ne|ne|ne|e|e|e|e|e|e|sw|w|w|w|w|sw|sw|sw|sw|s|ne|ne|ne|ne|ne|e|sw|sw|sw|sw|sw|s|e|sw|w|n|sw|s|n|sw|sw|sw|sw|w|ne|sw|e|ne|e|ne|e|ne|w|e|ne|ne|ne|ne|n|ne|ne|sw|sw|s|sw|sw|sw|sw
var rightwing_pathID 227|279|228|280|281|282|283|284|285|291|260|259|258|257|256|255|254|251|252|253|250|249|261|262|263|264|265|266|271|270|269|268|267|261|249|248|272|273|274|275|276|243|242|277|278|234|235|234|233|232|286|231|230|229|230|231|286|236|237|238|239|240|239|241|242|243|244|245|246|247|246|245|244|243|242|241|239
var field #goto 290|s|s|w|sw|e|n|e|e|n|s|w|n|n|e|e|e|e|w|w|n|w|ne|n|e|s|e|n|e|n|sw|s|w|s|e|e|n|s|s|s|w|s|w|s|e|e|n|s|s|s|w|s|w|s|e|s|se|n|n|n|s|w|w|n|n|n|e|w|w|n|n|n|e|w|s|s|w|w|se|se|s
var field_pathID 290|320|321|323|324|325|323|321|347|348|347|321|320|290|346|341|342|343|342|341|344|292|293|294|295|296|297|298|300|299|298|297|296|301|302|303|349|303|304|305|306|307|308|309|310|311|350|311|312|313|314|315|316|317|318|333|332|331|319|330|319|318|317|316|329|334|335|334|335|337|339|340|345|340|339|337|338|322|326|327|328
var back1 #goto 289|#goto 386|#goto 359|#goto 366|#goto 371
var back1_pathID 289|386|359|366|371
var blight #goto 395|s|s|w|w|e|e|e|e|w|n|e|e|s|e|n|n|e|e|e|n|e|n|s|s|s|w|s|e|w|w|w|n|e|w|w|s|w|n|n|w|w|w
var blight_pathID 395|422|404|405|406|405|404|402|403|402|401|400|399|407|408|409|421|420|419|418|417|415|416|415|414|413|412|425|442|425|424|423|410|411|410|409|408|407|399|398|397|396|395
var back2 #goto 377|#goto 382|#goto 388|#goto 394
var back2_pathID 377|382|388|394
var belly #goto 212|n|w|nw|e|nw|w|nw|e|nw|n|s|w|sw|sw|w|ne|w|ne|w|ne|e|n|ne|sw|w|w|w|sw|sw|sw|w|ne|sw|w|ne|e|ne|n|e|w|sw|w|sw
var belly_pathID 212|211|213|214|210|209|215|216|208|206|207|206|205|204|203|202|201|200|199|198|197|196|194|195|194|193|192|191|224|223|222|221|225|221|220|219|218|217|189|190|189|188|187|186
var head #goto 185|sw|s|se|e|e|e|nw|e|se|e|nw|se|e|se|e|se|w|w|w|sw|w|ne|nw|se|sw|w|ne|w|w|w|w|w|nw|nw|n|n|n|ne|ne
var head_pathID 185|184|183|182|181|180|179|178|176|177|174|175|174|173|172|171|170|169|168|167|166|163|164|165|164|163|162|161|160|159|158|157|156|155|154|150|151|152|153|226
var growth #goto 104|s|s|s|s|s|e|e|e|s|e|s|s|s|e|e|e|e|w|n|n|e|s|n|ne|w|w|w|s|w|s|e|w|n|n|w|w|w|s|w|s|e|e|n|s|s|n|w|w|n|n|w|s|s|s|e|e|w|w|n|n|n|n|n|n|n|n|n|n|n
var growth_pathID 104|105|106|107|108|109|114|115|116|117|129|149|148|147|146|145|143|144|143|139|138|137|142|137|136|135|134|133|132|131|141|140|141|131|130|129|117|118|119|120|122|123|124|125|124|126|124|123|122|120|121|110|111|112|113|127|128|127|113|112|111|110|109|108|107|106|105|104|103|102
var labyrinth #goto 49|n|e|n|w|n|n|n|n|n|n|n|n|e|e|n|e|n|w|n|w|s|w|n|n|e|e|s|s|e|n|e|e|n|n|w|w|w|w|w
var labyrinth_pathID 49|48|47|45|44|42|41|40|39|38|37|36|33|34|15|30|14|13|21|22|29|28|27|26|25|34|23|22|21|13|12|19|17|16|7|6|5|4|3|2
var c 0
var done 0

#### LOAD ACTIONS ####
action goto end when "^A cheerful looking Halfling wearing a wide brimmed hat comes up to you and says, .It looks like you got lost in the maze!  I'm here to escort you out\..  He takes your hand and leads you through the twisting passages and brings you to the exit\.$"
action var done 1 when "ASK HALFLING ABOUT TASK again\.$"

#### ABORTS and PREP ####
var activity %0
goto %activity
boss:
  var path %field|#|%growth
  var pathID %field_pathID|#|%growth_pathID
  eval moveCount countsplit("%path", "|")
  goto Start
spider:
  var activity boss
  var path %field
  var pathID %field_pathID
  eval moveCount countsplit("%path", "|")
  goto Start
scarecrow:
  var activity boss
  var path %growth
  var pathID %growth_pathID
  eval moveCount countsplit("%path", "|")
  goto Start
poke:
  var path %leftwing|#|%rightwing|#|%blight|#|%belly|#|%head
  var pathID %leftwing_pathID|#|%rightwing_pathID|#|%blight_pathID|#|%belly_pathID|#|%head_pathID
  eval moveCount countsplit("%path", "|")
  goto Start
loot:
  var path %leftwing|%rightwing|%field|%back1|%blight|%back2|%belly|%head|%growth|%labyrinth
  var pathID %leftwing_pathID|%rightwing_pathID|%field_pathID|%back1_pathID|%blight_pathID|%belly_pathID|%head_pathID|%growth_pathID|%labyrinth_pathID
  eval moveCount countsplit("%path", "|")
  goto Start

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
  if (matchre("$monsterlist", "(Halfling|Gor'Tog)") && matchre("%activity", "poke")) then {gosub pokeHalfling $1}
  if (matchre("$roomobjs", "\b(altar|basket|boulder|burrow|fencepost|hay|hut|pail|rake|spiderweb|statue|stones|straw|wagon|wheelbarrow|wood)\b") && matchre("%activity", "loot")) then {gosub search $1}
  if ((%done) || (%c >= %moveCount)) then {goto done}
  math c add 1
  if !contains(%pathID[%c], "#") then {gosub mover %path[%c]}
  if ($roomid != %pathID[%c]) then {put #var roomid %pathID[%c]}
  goto moveLoop
####

done:
  put #class +combat
  gosub clear
  delay 0.2
  put #printbox CURRENT ROOM: $roomid, PATHID: pathID[%c], HALFLING: $halfling
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
  put #echo >talk <%SCRIPTNAME: %minutes:%seconds
  put #parse ** MAZETASK DONE **
  exit

####  COMMON SUBROUTINES  ####
include mazeINC

#### POKE? REALLY? ####
pokeHalfling:
  var pokeVar &0
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
#I know this is silly, but script is so fast that on the last one you need a pause
  delay $pauseTime
  pause $pauseTime
  if (%done) then {goto done}
  put #class +combat
  goto advancePath
  return
####

#### SEARCH LANDMARKS FOR HAWT LEWTZ ####
search:
  var searchVar &0
  math searches add 1
research:
  matchre research ^\.\.\.wait|^Sorry,
  matchre returner Sadly, you don't find|already been picked clean|The only thing you're|You find nothing|I could not find
  matchre searchStow You manage to find (.+)!
  put search %searchVar
  matchwait

searchStow:
  put #echo >talk Searching %searchVar...
  put #echo >talk #00FF00     You found $1
  math finds add 1
  gosub stow $righthandnoun in my $container_mazerighthandnoun
  return
####

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
# if you killed the spider (300+ numbered rooms), go looking for the scarecrow, otherwise, go home
  if (%pathID[%c] < 290) then {goto done}
  gosub advancePath
  goto retreat
####

#### Finished with a section?  Adance to the next! ####
advancePath:
  if matchre("%path", "^.+?#\|(.+)") then {var path $1}
  if matchre("%pathID", "^.+?#\|(.+)") then {var pathID $1}
  eval moveCount countsplit("%path", "|")
  var c 0
  return
####