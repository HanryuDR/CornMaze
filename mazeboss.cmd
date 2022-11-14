#mazeboss.cmd
# .mazeboss
#  search the maze for the spider and the scarecrow
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
#2021
#   initial release
#2021-11-15
#   Its mostly ok now, removing a lot of the debug stuff
# 2022-11-07
#   Update for O2
# 2022-11-10
#   into the repo
# 2022-11-14
#   Now using include
#debug 5

#### LOAD VARS ####
eval Scriptname titlecase(%scriptname)
eval SCRIPTNAME tocaps(%scriptname)
put #echo >User #FF00FF >%SCRIPTNAME: $time
var totaltime $gametime
var path #goto 290|s|s|w|sw|e|n|e|e|n|s|w|n|n|e|e|e|e|w|w|n|w|ne|n|e|s|e|n|e|n|sw|s|w|s|e|e|n|s|s|s|w|s|w|s|e|e|n|s|s|s|w|s|w|s|e|s|se|n|n|n|s|w|w|n|n|n|e|w|w|n|n|n|e|w|s|s|w|w|se|se|s|#goto 104|s|s|s|s|s|e|e|e|s|e|s|s|s|e|e|e|e|w|n|n|e|s|n|ne|w|w|w|s|w|s|e|w|n|n|w|w|w|s|w|s|e|e|n|s|s|n|w|w|n|n|w|s|s|s|e|e|w|w|n|n|n|n|n|n|n|n|n|n|n
var pathID 290|320|321|323|324|325|323|321|347|348|347|321|320|290|346|341|342|343|342|341|344|292|293|294|295|296|297|298|300|299|298|297|296|301|302|303|349|303|304|305|306|307|308|309|310|311|350|311|312|313|314|315|316|317|318|333|332|331|319|330|319|318|317|316|329|334|335|334|335|337|339|340|345|340|339|337|338|322|326|327|328|104|105|106|107|108|109|114|115|116|117|129|149|148|147|146|145|143|144|143|139|138|137|142|137|136|135|134|133|132|131|141|140|141|131|130|129|117|118|119|120|122|123|124|125|124|126|124|123|122|120|121|110|111|112|113|127|128|127|113|112|111|110|109|108|107|106|105|104|103|102
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
  delay $pauseTime
  if !matchre("$roomobjs", "tunnel") then {
    put #printbox Navigate it to the tunnel, room 290!|Type YES
    waitfor A good positive
    delay $pauseTime
    }
  put #var roomid %pathID[%c]

#### MOVE around the Maze ###
moveLoop:
  if matchre("$roomobjs", "(?:the Scarecrow|Harawep's Spider)(?! (?:which|that) appears dead| \(dead\))") then {
    gosub KillBoss
    if (%pathID[%c] < 290) then {goto done}
    }
  math c add 1
  if (%c >= %moveCount) then {
    put #var roomid 102
    goto done
    }
  if contains("%path[%c]", "#goto") then {
# I've got to subtract one to ENSURE that roomid = the room we're in
    delay $pauseTime
    math c subtract 1
    put #var roomid %pathID[%c]
    math c add 1
#    put %path[%c] from $roomid
    put %path[%c]
    waitforre You are already here|YOU HAVE ARRIVED!
    } else {
    gosub mover %path[%c]
    }
  goto moveLoop
####

done:
  gosub clear
  put #printbox CURRENT ROOM: $roomid, HALFLING: $halfling
  put #goto $halfling
  waitforre You are already here|YOU HAVE ARRIVED!
  delay $pauseTime
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

####  COMMON SUBROUTINES  ####
include mazeINC
