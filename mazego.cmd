#mazego.cmd

put ticket
waitforre Corn Maze - (\d*) kernels.
var startKernel $1

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

put #var roomid 2
pause 0.1
put #echo >talk #00FF00 Started Maze @ $time with %startKernel kernels
put .maze
exit
