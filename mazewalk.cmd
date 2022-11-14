#mazewalk.cmd
#handle poke, loot, boss
# maybe we do this next year

# 2022-11-14
#   
#debug 5

#### LOAD VARS ####
eval Scriptname titlecase(%scriptname)
eval SCRIPTNAME tocaps(%scriptname)
put #echo >User #FF00FF >%SCRIPTNAME: $time
var totaltime $gametime
var leftwing #goto 50|e|s|s|se|se|nw|nw|n|n|n|ne|ne|ne|ne|ne|ne|ne|n|se|s|sw|sw|sw|sw|sw|sw|sw|s|se|se|w|e|n|nw|n|ne|ne|ne|ne|ne|ne|sw|s|sw|sw|sw|sw|e|s|n|se|n|n|e|n|s|s|sw|sw|nw|se
var pathID 50|51|97|98|99|100|99|98|97|51|52|53|54|55|56|57|58|59|60|61|62|75|76|77|78|79|80|81|82|83|84|101|84|71|70|69|68|67|66|65|64|63|64|85|86|87|88|89|74|73|74|94|93|92|91|90|91|95|94|72|96|72
var rightwing #goto 227|ne|s|ne|ne|ne|n|n|n|ne|ne|ne|ne|e|e|e|e|e|e|sw|w|w|w|w|sw|sw|sw|sw|s|ne|ne|ne|ne|ne|e|sw|sw|sw|sw|sw|s|e|sw|w|n|sw|s|n|sw|sw|sw|sw|w|ne|sw|e|ne|e|ne|e|ne|w|e|ne|ne|ne|ne|n|ne|ne|sw|sw|s|sw|sw|sw|sw
var pathID 227|279|228|280|281|282|283|284|285|291|260|259|258|257|256|255|254|251|252|253|250|249|261|262|263|264|265|266|271|270|269|268|267|261|249|248|272|273|274|275|276|243|242|277|278|234|235|234|233|232|286|231|230|229|230|231|286|236|237|238|239|240|239|241|242|243|244|245|246|247|246|245|244|243|242|241|239
var field #goto 290|s|s|w|sw|e|n|e|e|n|s|w|n|n|e|e|e|e|w|w|n|w|ne|n|e|s|e|n|e|n|sw|s|w|s|e|e|n|s|s|s|w|s|w|s|e|e|n|s|s|s|w|s|w|s|e|s|se|n|n|n|s|w|w|n|n|n|e|w|w|n|n|n|e|w|s|s|w|w|se|se|s
var pathID 290|320|321|323|324|325|323|321|347|348|347|321|320|290|346|341|342|343|342|341|344|292|293|294|295|296|297|298|300|299|298|297|296|301|302|303|349|303|304|305|306|307|308|309|310|311|350|311|312|313|314|315|316|317|318|333|332|331|319|330|319|318|317|316|329|334|335|334|335|337|339|340|345|340|339|337|338|322|326|327|328
var back1 #goto 289|#goto 386|#goto 359|#goto 366|#goto 371
var pathID 289|386|359|366|371
var blight #goto 395|s|s|w|w|e|e|e|e|w|n|e|e|s|e|n|n|e|e|e|n|e|n|s|s|s|w|s|e|w|w|w|n|e|w|w|s|w|n|n|w|w|w
var pathID 395|422|404|405|406|405|404|402|403|402|401|400|399|407|408|409|421|420|419|418|417|415|416|415|414|413|412|425|442|425|424|423|410|411|410|409|408|407|399|398|397|396|395
var back2 #goto 377|#goto 382|#goto 388|#goto 394
var pathID 377|382|388|394
var belly #goto 212|n|w|nw|e|nw|w|nw|e|nw|n|s|w|sw|sw|w|ne|w|ne|w|ne|e|n|ne|sw|w|w|w|sw|sw|sw|w|ne|sw|w|ne|e|ne|n|e|w|sw|w|sw
var pathID 212|211|213|214|210|209|215|216|208|206|207|206|205|204|203|202|201|200|199|198|197|196|194|195|194|193|192|191|224|223|222|221|225|221|220|219|218|217|189|190|189|188|187|186
var head #goto 185|sw|s|se|e|e|e|nw|e|se|e|nw|se|e|se|e|se|w|w|w|sw|w|ne|nw|se|sw|w|ne|w|w|w|w|w|nw|nw|n|n|n|ne|ne
var pathID 185|184|183|182|181|180|179|178|176|177|174|175|174|173|172|171|170|169|168|167|166|163|164|165|164|163|162|161|160|159|158|157|156|155|154|150|151|152|153|226
var growth #goto 104|s|s|s|s|s|e|e|e|s|e|s|s|s|e|e|e|e|w|n|n|e|s|n|ne|w|w|w|s|w|s|e|w|n|n|w|w|w|s|w|s|e|e|n|s|s|n|w|w|n|n|w|s|s|s|e|e|w|w|n|n|n|n|n|n|n|n|n|n|n
var pathID 104|105|106|107|108|109|114|115|116|117|129|149|148|147|146|145|143|144|143|139|138|137|142|137|136|135|134|133|132|131|141|140|141|131|130|129|117|118|119|120|122|123|124|125|124|126|124|123|122|120|121|110|111|112|113|127|128|127|113|112|111|110|109|108|107|106|105|104|103|102
var labyrinth #goto 49|n|e|n|w|n|n|n|n|n|n|n|n|e|e|n|e|n|w|n|w|s|w|n|n|e|e|s|s|e|n|e|e|n|n|w|w|w|w|w
var pathID 49|48|47|45|44|42|41|40|39|38|37|36|33|34|15|30|14|13|21|22|29|28|27|26|25|34|23|22|21|13|12|19|17|16|7|6|5|4|3|2
eval moveCount countsplit("%path", "|")
var c 0
var done 0

#### LOAD ACTIONS ####
action goto end when "^A cheerful looking Halfling wearing a wide brimmed hat comes up to you and says, .It looks like you got lost in the maze!  I'm here to escort you out\..  He takes your hand and leads you through the twisting passages and brings you to the exit\.$"
action var done 1 when "ASK HALFLING ABOUT TASK again\.$"

