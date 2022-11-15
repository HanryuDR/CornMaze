#mazego.cmd
# .mazego
#  start me at the halfing
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Oulander, http://outlanderapp.com
# 2022-11-10
#   initial release
#   into the repo

var startKernel 0
put ticket
put yes
waitforre Corn Maze - (\d*) kernels|A good positive
if ($1 > 0) then {var startKernel $1}

send get my corn pass
wait
pause 0.1

send redeem my pass
wait
pause 0.1

send redeem my pass
wait
pause 0.1

send ASK HALF ABOUT ACCESS
waitfor Stay close, I'll escort you in...
send put my corn pass in my $container_cloak
pause 0.1
if ("$righthand" != "Empty") then {send stow right}
if ("$lefthand" != "Empty") then {send stow left}

put #var roomid 2
pause 0.1
put #echo >talk #00FF00 Started Maze @ $time with %startKernel kernels
put .maze
exit
