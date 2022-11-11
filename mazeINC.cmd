####  COMMON SUBROUTINES  ####
#include mazeINC
# mazeINC.cmd
# all the stuff you need!
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
# 2022-11-10
#   copied commonINC
#   inital released
# 2022-11-11
#   gosub call

#### STOW (or PUT ___ in _____) ####
stow:
  var stowVar &0
  var stowError 0
stow_retry:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre stow_retry ^\.\.\.wait|^Sorry,|^\[CAUTION!|^You are still stunned|^You can't do that while entangled
  matchre return ^You (?:roll|combine|put|carefully|open your pouch and put)|^But that is already in your|^That can't be picked up
  matchre stowError What were you|Stow what
  matchre stowError You need a free|The .+too (long|wide)|^There isn't any more room|^That's too heavy
  match stowError I can't find your container for stowing things in!
  if matchre("%stowVar", " in | on ") then {put put %stowVar}
  else {put stow %stowVar}
  matchwait
stowError:
  if matchre("%stowVar", "\b(?:feet|pins?|oil)\b") then {return}
  var stowError 1
  return
####

#### RETURN ####
return:
returner:
  return
####

#### STANCE CHANGER ####
stance:
  var stanceVar &0
stance_retry:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre stance_retry ^\.\.\.wait|^Sorry,|^You are still stunned|^You can't do that while entangled|^Please wait\.
  matchre return ^Setting your Evasion stance|^You are now set to use your
  put stance %stanceVar
  matchwait
####

#### STOP PLAYING ####
playStop:
stopPlay:
  put #var playing 0
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre stopPlay ^\.\.\.wait|^Sorry,|^You are still stun|^You can't do that while entangled
  matchre return You stop playing|In the name of love
  put stop play
  matchwait
####

#### RETREAT ####
retreat:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre retreat ^\.\.\.wait|^Sorry,|^You are still stun|^You can't do that while entangled|^You (?:try to sneak|sneak|retreat back)|discovers you trying to sneak out
  matchre return ^You (?:are already |sneak back out of combat|retreat from combat)
  put retreat;retreat
  matchwait
####

#### MOVE a room ####
mover:
  var direction &0
mover_retry:
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  if (!$standing) then {gosub stand}
  matchre mover_retry ^\.\.\.wait|^Sorry,|^You are still stun|^You can't do that while entangled
  matchre moverRetreat ^You are engaged|^You can't do that while engaged
  matchre moverStand ^You can't do that while lying
  matchre dropInviso ^You can't move in that direction while unseen.
  match moveError You can't go there.
  if contains("%direction", "#goto") then {matchre returner You are already here|YOU HAVE ARRIVED!}
  else {matchre returner ^(?:Obvious|Ship) (?:paths|exits):}
  put %direction
  matchwait
moverRetreat:
  gosub retreat
  goto mover_retry
moverStand:
  gosub stand
  goto mover_retry
dropInviso:
  gosub release blend
  send shiver
  goto mover_retry
moveError:
  put #printbox You screwed up the script!Try to get back on track.|Type YES to continue.
  waitfor A good positive attitude never hurts.
  if ("$monsterlist", "Merelew") then {goto Start}
  return
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

#### RELEASE ####
release:
  var releaseVar &0
release_retry:
  var targeting 0
  var prepping 0
  put #var preparedspell None
  put #var fullprep 0
  if ($roundtime > 0) then {pause $pauseTime}
  if (($webbed) || ($stunned)) then {pause 0.1}
  matchre release_retry ^\.\.\.wait|^Sorry,|^You are still stunned\.|^You can't do that while entangled
  matchre return ^Release what|^You fade into view|^You let your concentration|^You aren't preparing|^You release|^As your Skein of Shadows disperses|^The shimmering ethereal shield|^The air around you shimmers|^Your skin loses its|^Your body feels more weighty and inflexible|^You sense the sliver|^The world seems to|^You have no cyclic|^The lingering effects of your|^As the Absolution spell fails|^Your increased sense
  put release %releaseVar
  matchwait 5
  put #echo #FF6600 DEBUG: release timed out
  put #echo >talk #FF6600 [$time]DEBUG: release timed out
  wait
  goto release
####

#### CALL a script and wait for it to finish ####
call:
  var callVar &0
  if matchre("%callVar", "travel") then {gosub clearWindow}
  eval CALLVAR tocaps(&1)
  put .%callVar
callError:
  matchre return ^\*\* %CALLVAR DONE \*\*|^MOVE ON
  matchwait
  put #printbox CALL ERROR|matchwait fell thru|%CALLVAR|%callVar
  goto callError
####
