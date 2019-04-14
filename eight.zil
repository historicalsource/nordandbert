"EIGHT for
		             NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"scene is EIGHT"

<GLOBAL REAL-EIGHT <>>

<OBJECT EIGHT
	(LOC LOCAL-GLOBALS)
	(DESC "place")
	(PICK-IT "Meet the Mayor")
	(MAX-SCORE 14)
	(SCENE-SCORE 0)
	(SCENE-ROOM SQUARE)
	(SCENE-CUR 0)
	(SYNONYM SQUARE LOBBY BATHROOM PUBLIC ROOM)
	(ADJECTIVE PUBLIC)
	(FLAGS NDESCBIT SCENEBIT)
	(ACTION EIGHT-F)>

<ROUTINE EIGHT-F ()
	 <COND (<OR <NOUN-USED ,EIGHT ,W?BATHROOM>
		    <ADJ-USED ,EIGHT ,W?BATH>>
		<SETG REAL-EIGHT ,BATHROOM>)
	       (<OR <NOUN-USED ,EIGHT ,W?SQUARE ,W?PUBLIC>
		    <ADJ-USED ,EIGHT ,W?PUBLIC>>
		<SETG REAL-EIGHT ,SQUARE>)
	       (<NOUN-USED ,EIGHT ,W?LOBBY>
		<SETG REAL-EIGHT ,LOBBY>)
	       ;(T
	        <SETG REAL-EIGHT ,SQUARE>)>
	 <COND (<OR <NOT ,REAL-EIGHT>
		    <VERB? NO-VERB>
		    <AND <DONT-HANDLE ,EIGHT>
			 <NOT <VERB? WALK-TO>>>>
		<RFALSE>)
	       (<VERB? WALK-TO>
		<COND (<EQUAL? ,HERE ,REAL-EIGHT>
		       <TELL ,ARRIVED>)
		      (<EQUAL? ,HERE ,SQUARE>
		       <COND (<EQUAL? ,REAL-EIGHT ,LOBBY>
			      <DO-WALK ,P?IN>)
			     (<EQUAL? ,REAL-EIGHT ,BATHROOM>
			      <DO-FIRST "enter the town house">)>)
		      (<EQUAL? ,HERE ,LOBBY>
		       <COND (<EQUAL? ,REAL-EIGHT ,SQUARE>
			      <DO-WALK ,P?OUT>)
			     (<EQUAL? ,REAL-EIGHT ,BATHROOM>
			      <DO-WALK ,P?UP>)>)
		      (<EQUAL? ,HERE ,BATHROOM>
		       <COND (<EQUAL? ,REAL-EIGHT ,LOBBY>
			      <DO-WALK ,P?DOWN>)
			     (<EQUAL? ,REAL-EIGHT ,SQUARE>
			      <TELL 
"You flee down the stairs and out..." CR CR>
			      <GOTO ,SQUARE>)>)
		      (T
		       <TELL "You go there..." CR CR>
		       <GOTO ,REAL-EIGHT>)>)
	       (<NOT <EQUAL? ,HERE ,REAL-EIGHT>>
		<TELL "You're not there." CR>)
	       ;(T
		<CHANGE-OBJECT ,EIGHT ,GLOBAL-ROOM>
		<RTRUE>)>>

<OBJECT DECREE
	(DESC "decree")
	(SYNONYM DECREE)
	;(ADJECTIVE DIRTY SOILED)
	(FLAGS TAKEBIT)
	(ACTION DECREE-F)>

<ROUTINE DECREE-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL 
"The decree would outlaw all language play in town. There is a line at the
bottom for the mayor's signature." CR>)>>

<ROOM SQUARE 
      (LOC ROOMS)
      (DESC "Public Square")
      (IN PER LOBBY-ENTER)
      ;(FLAGS INDOORSBIT)
      (GLOBAL TOWN-HOUSE EIGHT)
      (ACTION SQUARE-F)>

<ROUTINE SQUARE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"You're in the public square. Facing one edge of the square stands an
impressive looking neo-colonial town house, which is decoratively fronted
by a row of laurel bushes.">)>>

;"One edge of the square has been advanced
upon by the encroaching forest, as it is dense with trees and shrubbery"
		
<ROUTINE LOBBY-ENTER ()
	 <COND (<AND <HELD? ,BLESSING>
		     <NOT <IN? ,BLESSING ,DISGUISE>>>
		<TELL 
"As you approach the column-lined town house through the path dividing the 
well-manicured lawn, you are overcome with fear and trembling and
are forced to turn back toward the square. It seems the idea of
entering such a reviled house of corruption with a blessing is spiritually
and realistically impossible." CR>
		<RFALSE>)
	       (<AND <HELD? ,BLESSING>
		     <IN? ,BLESSING ,DISGUISE>>
		<COND (<NOT <FSET? ,LOBBY ,TOUCHBIT>>
		       <UPDATE-SCORE>)>
		<TELL 
"Furtively, you pass through the yard into the town house." CR CR>
		<RETURN ,LOBBY>)
	       (T
		<RETURN ,LOBBY>)>>

<OBJECT TOWN-HOUSE
	(LOC LOCAL-GLOBALS)
	(DESC "town house")
	(SYNONYM HOUSE)
	(ADJECTIVE TOWN)
	(FLAGS NDESCBIT)
	(ACTION TOWN-HOUSE-F)>

<ROUTINE TOWN-HOUSE-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,LOBBY ,BATHROOM>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,SQUARE>
		       <DO-WALK ,P?IN>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,LOBBY>
		       <DO-WALK ,P?OUT>)
		      (<EQUAL? ,HERE ,BATHROOM>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,LOBBY ,BATHROOM>>
		<V-LOOK>)>>

<OBJECT BUSHES
	(LOC SQUARE)
	(DESC "laurel bushes")
	(SYNONYM BUSH BUSHES BRANCH BRANCHES LAUREL)
	(ADJECTIVE LAUREL)
	(FLAGS 
NDESCBIT TRYTAKEBIT PLURALBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT)
	(CAPACITY 0)
	(GENERIC GEN-LAUREL)
	(ACTION BUSHES-F)>

<ROUTINE BUSHES-F ()
	 <COND (<AND <VERB? SEARCH LOOK-INSIDE>
		     <ZERO? <LOC ,BLESSING>>>
		<UPDATE-SCORE>
		<MOVE ,BLESSING ,PROTAGONIST>
		<TELL 
"Beating around the bush, you come upon a ticket stub enmeshed in the
dense lower branches of the laurel. You pick it up and dust it off." CR>)
	       (<AND <VERB? SEARCH-WITH>
		     <PRSI? ,COMB>>
		<PERFORM ,V?SEARCH ,BUSHES>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The laurel bushes are a pleasant landscaping touch as frontage to the town
house." CR>) 
	       (<VERB? BOARD>
		<TELL "You can't rest on the bush itself." CR>)
	       (<VERB? TAKE MUNG PICK>
		<COND (<IN? ,LAUREL ,BUSHES>
		       <MOVE ,LAUREL ,PROTAGONIST>
		       <PUTP ,LAUREL ,P?SDESC "your laurels">
		       <FSET ,LAUREL ,NARTICLEBIT>
		       <TELL 
"With noble bearing, you study the laurel and proceed to break
off a few intertwined branches." CR>)
		      (T
		       <TELL
"You have harvested all the laurel that you require." CR>)>)>> 
	        
<OBJECT LAUREL
	(LOC BUSHES)
	(SDESC "laurels")
	(SYNONYM BRANCH BRANCHES LEAVES LAUREL CROWN WREATH LAURELS)
	(ADJECTIVE MY YOUR LAUREL)
	(FLAGS TAKEBIT PLURALBIT)
	(GENERIC GEN-LAUREL)
	(ACTION LAUREL-F)>

<GLOBAL CROWN-MADE <>>

<ROUTINE LAUREL-F ()
	 <COND (<AND <NOT ,CROWN-MADE>
		     <NOT <DONT-HANDLE ,LAUREL>>
		     <NOUN-USED ,LAUREL ,W?CROWN ,W?WREATH>>
		<CANT-SEE <> "crown">)
	       (<AND <OR <VERB? MAKE>
			 <AND <VERB? SET>
			      <PRSO? ,PRSI>>>
		     <NOUN-USED ,LAUREL ,W?CROWN ,W?WREATH>>
		<COND (<NOT <HELD? ,LAUREL>>
		       <TELL ,YNH AR ,LAUREL>)
		      (,CROWN-MADE
		       <TELL ,ALREADY-HAVE>)
		      (T
		       <SETG CROWN-MADE T>
		       <FSET ,LAUREL ,WEARBIT>
		       <FCLEAR ,LAUREL ,PLURALBIT>
		       <PUTP ,LAUREL ,P?SDESC "crown of laurel">
		       <TELL "You fashion a crown from the laurel." CR>)>)
	       (<VERB? BOARD SIT CLIMB-ON>
		<COND (,WON-GAME
		       <UPDATE-SCORE>
		       <TELL  
"With dreamy slowness you begin to fall back upon your laurels for the
long, soulful respite you have so well deserved. In the enclave of your dreams
the clarion voice of a herald is given forum:|
|
\"We, the members of the Citizens' Action Committee of Punster, do hereby
honor your exploits in delivering our town of the nefarious crime of
wordplay. Punster has once again returned to a life of trusting normalcy.|
|
For the McCleary Farm, the cows have truly come home. Audiences once again
revel in the gift of laughter. A pretty girl is rescued from the brink
of tragedy. You have made our town safe for shopping. The Teapot Cafe
is a homey hearth and nourishment to our
supping folk. A house for guests has gained back its repute. A neighboring
town must no longer live down its name.|
|
In gratitude to your selfless dedication to our humble town, we present you
with the Key to the City. May it unlock all the doors for you along life's
path.\"|
|
You fall still further into deep and luxurious sleep." CR>       
		       <FINISH>)
		      (T
		       <TELL 
"This is no time for such vain self-congratulation." CR>)>)>>

<ROUTINE GEN-LAUREL ()
	 ,LAUREL>

<OBJECT BLESSING
	;(LOC SQUARE)
	(DESC "blessing")
	(SYNONYM BLESSINGS BLESSING STUB TICKET)
	(ADJECTIVE TICKET YOUR MY)
	(FLAGS TAKEBIT)
	(ACTION BLESSING-F)>

;"PHRASEBIT = given it to mayor"
;"<MOVE ,BLESSING ,LOCAL-GLOBALS> after give blessing so wont find it again"

<ROUTINE BLESSING-F ()
	 <COND (<VERB? COUNT>
		<TELL 
"Though such expression is filled with gratitude, you count but one
blessing." CR>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,DUCK>
		     <FSET? ,DUCK ,PHRASEBIT>>
		<UPDATE-SCORE>
		<FSET ,BLESSING ,PHRASEBIT>
		;<REMOVE ,BLESSING>
		<MOVE ,BLESSING ,LOCAL-GLOBALS>
		<TELL 
"The air surrounding the mayor gradually turns pure and bright. An expansive
campaign-smile spreads across his face as he bathes in the saintliness of
the blessing bestowed. As the halo effect fades, it seems to have lifted away
the dread weight of the mayor's burdens." CR>)
	       (<VERB? EXAMINE READ>
		<TELL
"The ticket is issued by the First Church of the Heavenly Ferris Wheel,
the foremost religious institution in town. It decrees one blessing to
be given by the bearer of the ticket to any individual." CR>)>>

<OBJECT STUMP
	(LOC SQUARE)
	(DESC "tree stump")
	(DESCFCN STUMP-F)
	(SYNONYM STUMP TREE)
	(ADJECTIVE TREE)
	(FLAGS SURFACEBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT)
	(ACTION STUMP-F)>

<ROUTINE STUMP-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR 
"In the middle of the public square stands a thick, ten feet tall stump of a tree. Attached to the stump is a sheet of paper">
		<COND (<IN? ,HORN ,STUMP>
		       <TELL 
" and next to the paper hangs the horn of the town crier">)>
		<TELL ".">)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,STUMP>>
		<COND (<PRSO? ,HORN>
		       <TELL "Nope, it's yours and you're stuck with it">)
		      (T
		       <TELL "It won't attach to the bark">)>
		<TELL ,PERIOD>)
	       (<VERB? CLIMB-ON CLIMB-UP CLIMB BOARD>
		<TELL "There are no footholds." CR>)>>

<OBJECT LAWS
	(LOC STUMP)
	(DESC "laws of the land")
	(SYNONYM SHEET PAPER LAW LAWS LAND TENTHS NINE-TENTHS POSSESSION)
	(ADJECTIVE NINE POSSESSION)
	(FLAGS PLURALBIT TRYTAKEBIT)
	(GENERIC GEN-POSSESSION)
	(ACTION LAWS-F)>

<ROUTINE LAWS-F ()
	 <COND (<AND <FSET? ,HORN ,TRYTAKEBIT> 
		     <OR <NOUN-USED ,LAWS ,W?POSSESSION>
			 <ADJ-USED ,LAWS ,W?POSSESSION>>>
		<PUT ,P-NAMW 0 ,W?POSSESSION>
		<PERFORM ,V?TAKE ,HORN>
		<RTRUE>)
	       (<AND <VERB? MUNG>
		     <EQUAL? ,P-PRSA-WORD ,W?BREAK>>
		<TELL "That would be against the law." CR>)
	       (<VERB? READ EXAMINE>
		<TELL
"There is a list of \"Ten Laws of the Land.\" But the bottom of the
sheet is torn off, leaving only nine laws, which are:|
|
  No Running|
  No Panting Loons|
  No Skipping|
  Reptilian Volleyball is O-u-t|
  Honor Thy Fodder|
  No Chewing Gum|
  Defend your Landmother|
  No Pepper|
  Rip What You Sew|">)
	       (<VERB? TAKE>
		<TELL "That would be against the law." CR>)>> 

<OBJECT HORN
	(LOC STUMP)
	(SDESC "horn")
	(SYNONYM POSSESSION HORN)
	(ADJECTIVE POSSESSION OLD BRASS YOUR OWN MY)
	(FLAGS TRYTAKEBIT)
	(GENERIC GEN-POSSESSION)
	(ACTION HORN-F)>

;"PHRASEBIT = MAYOR HEARD YOU BLOW HORN"

<ROUTINE HORN-F ()
	 <COND (<AND <FSET? ,HORN ,TRYTAKEBIT> ;"just type POSSESSION"
		     <OR <NOUN-USED ,HORN ,W?POSSESSION>
			 <ADJ-USED ,HORN ,W?POSSESSION>>
		     <VERB? NO-VERB>
		     ;<NOT ,PRSI>>
		<PERFORM ,V?TAKE ,HORN>
		<RTRUE>)
	       (<AND <ADJ-USED ,HORN ,W?YOUR ,W?MY ,W?OWN>
		     <FSET? ,HORN ,TRYTAKEBIT>
		     <NOT <DONT-HANDLE ,HORN>>>
		<TELL "It's not yours." CR>)
	       (<VERB? EXAMINE>
		<TELL 
"The old brass horn">
		<COND (<IN? ,HORN ,STUMP>
		       <TELL 
", which hangs on the stump next to the sheet of paper,">)>
		<TELL 
" is dinged up and tarnished from seemingly centuries of use by the
town crier." CR>)
	       (<VERB? BLOW>
		<COND (<FSET? ,HORN ,TRYTAKEBIT>
		       <PERFORM ,V?TAKE ,HORN>
		       <RTRUE>)
		      (T
		       <TELL 
"You give the horn a big, brassy toot">
		       <COND (<AND <VISIBLE? ,DUCK>
				   <FSET? ,DUCK ,PHRASEBIT>>
			      <COND (<NOT <FSET? ,HORN ,PHRASEBIT>>
				     <UPDATE-SCORE>
				     <FSET ,HORN ,PHRASEBIT>
				     <TELL 
". It seems to be music to the mayor's ears, since he for the first time
really takes notice of you, and smiles upon your vainglorious trumpeting">)
				    (T
				     <TELL 
". \"Hey, don't let it go to your head,\" says the mayor">)>)
			     (<NOT <VISIBLE? ,DUCK>>
			      <TELL "; but no one is around to hear it">)>
		       <TELL ,PERIOD>)>)
	       (<VERB? TAKE>
		<COND (<AND <FSET? ,HORN ,TRYTAKEBIT>
			    <NOUN-USED ,HORN ,W?POSSESSION>>
		       <UPDATE-SCORE>
		       <FCLEAR ,HORN ,TRYTAKEBIT>
		       <FSET ,HORN ,TAKEBIT>
		       <FSET ,HORN ,NARTICLEBIT>
		       <MOVE ,HORN ,PROTAGONIST>
		       <PUTP ,HORN ,P?SDESC "your own horn">
		       <TELL
"The horn begins to trumpet out a stuttering protest, but the logic of
law is so compelling that it quits, and you take possession of the horn." CR>)
		      (<FSET? ,HORN ,TRYTAKEBIT>
		       <TELL 
"The old brass horn suddenly radiates through its tarnished surface a deep
amber glow of indignation, and trumpets out a sharp rebuke in a nasty off-key
pitch that seems to accuse you of taking hold of itself without rightfully
owning it." CR>)>)>>    

<ROUTINE GEN-POSSESSION ()
	 ,HORN>

<ROOM LOBBY 
      (LOC ROOMS)
      (DESC "Lobby")
      (UP TO BATHROOM)
      (OUT TO SQUARE)
      (FLAGS INDOORSBIT)
      (GLOBAL TOWN-HOUSE EIGHT STAIRS)
      (ACTION LOBBY-F)>

<ROUTINE LOBBY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"This is the lobby of the town hall, looking stately and deeply lacquered.
A boldly impressive staircase leads up">
		<COND (<IN? ,TUB ,BATHROOM>
		       <TELL 
" and you can see steam drifting out of a room at the top of it">)>
		<TELL 
". The main focus of attention in the lobby is an imposing, ornately framed
document hanging on the wall.">)>>

<OBJECT PRETENSES
	(LOC LOBBY)
	(DESC "document")
	(SYNONYM PRETENSES PRETENSE DOCUMENT PAPER)
	(ADJECTIVE FALSE FRAMED IMPOSING)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION PRETENSES-F)>

<ROUTINE PRETENSES-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"On brittle, yellowing paper you read the following:||  ">
		<HLIGHT ,H-BOLD>
		<TELL "P R E T E N S E S">
		<HLIGHT ,H-NORMAL>
		<CRLF> <CRLF>
		<TELL
"The World, verily, is proved to be flat!|
|
The Rule of the Great Kazooli shall spread to the corners of the World!|
|
And beloved shall be Our Mayor in the eyes of the World!|
|
Forsooth, His Rule shall endure a thousand years!|">)
	       (<VERB? TAKE>
		<TELL 
"The theft of such a hallowed document is utterly beyond the realm of
possibilities. Period." CR>)   
	       (<AND <VERB? TAKE-UNDER>
		     <PRSI? ,PRETENSES>>
		<COND (<AND <PRSO? ,SIX-PACK>
			    <FSET? ,SIX-PACK ,TRYTAKEBIT>>
		       <UPDATE-SCORE>
		       <FCLEAR ,SIX-PACK ,TRYTAKEBIT>
		       <MOVE ,SIX-PACK ,PROTAGONIST>
		       <TELL
"Yes, there's more than one way to steal a pack, but under false Pretenses
is surely not the worst way. You cradle the six-pack in your arms like
the mother's milk of local politics, which it is." CR>)
		      (T
		       <PERFORM ,V?TAKE ,PRSO>
		       <RTRUE>)>)>>

<OBJECT SIX-PACK
	(LOC LOBBY)
	(DESC "six-pack of beer")
	(FDESC 
"A six-pack of beer -- the loyal constituency of cigar-chomping, back-room
politicians -- sits on the floor beneath the document.")
	(SYNONYM SIX-PACK PACK BEER SIX DEEP-SIX CAN CANS)
	(ADJECTIVE DEEP)
	(FLAGS TRYTAKEBIT TAKEBIT)
	(ACTION SIX-PACK-F)>

<ROUTINE SIX-PACK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL 
"The cans of beer are tall and thick, each labeled with the brand name
\"Deep Six\" and each depicting the same bluish misty ocean scene." CR>)
	       (<AND <VERB? TAKE>
		     <FSET? ,SIX-PACK ,TRYTAKEBIT>>
		<TELL 
"It's no simple matter taking something that's not yours, and you're
unable to do it that way." CR>)
	       (<VERB? OPEN>
		<TELL
"\"Deep Six,\" being a nostalgic brand of beer marketed toward muscle-headed
rugged individualists, has not adopted the convenience of easy-opening
pop-top cans. And no can opener is available." CR>)
	       (<VERB? DRINK>
		<TELL "None of the cans is open." CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,SIX-PACK>
		     ;<NOUN-USED ,SIX-PACK ,W?SIX ,W?DEEP-SIX>>
		<COND (<AND <EQUAL? ,HERE ,BATHROOM>
			    <IN? ,TUB ,HERE>>
		       <COND (<NOT <HELD? ,PRSI>>
			      <TELL
"You can't \"give" T ,PRSI " the deep six\" without holding" TR ,PRSI>)
			     (<PRSI? ,SKELETON>
			      <UPDATE-SCORE>
			      <REMOVE ,SKELETON>
			      <FSET ,SKELETON ,PHRASEBIT>
			      <TELL "As you give the skeleton the
deep-six, the bones sink beneath the filmy surface of the water, slowly
twisting and sinking much deeper than the tub would seem to be, until
finally it disappears into the murky depths of Davey Jones' Locker.">
			      <COND (<FSET? ,DUCK ,PHRASEBIT>
				     <TELL 
" The mayor breathes a large foul-breathed sigh of relief.">)
				    (T
				     <TELL 
" The duck lets out a joyful \"quack.\"">)>
			      <CRLF>)
			     (T
			      <TELL
"But" T ,PRSI " doesn't need to be gotten rid of." CR>)>)
		      (T
		       <TELL 
"Giving" T ,PRSI " the deep six is impossible without water." CR>)>)>>

<ROOM BATHROOM 
      (LOC ROOMS)
      (DESC "Bathroom")
      (DOWN TO LOBBY)
      (FLAGS INDOORSBIT)
      (GLOBAL TOWN-HOUSE EIGHT WATER STAIRS)
      (ACTION BATHROOM-F)>

<ROUTINE BATHROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "The bathroom">
		<COND (<IN? ,TUB ,HERE>
		       <TELL ", thoroughly steamed up,">)>
		<TELL " is ample in space but untidy in appearance.">
		<COND (<FSET? ,LINEN ,NDESCBIT>
		       <TELL 
" A pile of dirty linen marks the entrance to the staircase.">)
		      (T
		       <TELL " A staircase leads down.">)>)>>  

<OBJECT JAR
	(LOC BATHROOM)
	(SDESC "\"a jar\"")
	(DESCFCN JAR-F)
	(SYNONYM JAR DOOR AJAR LID)
	(ADJECTIVE AJAR CLOSET)
	(FLAGS ;NDESCBIT NARTICLEBIT ;DOORBIT)
	(ACTION JAR-F)>

<ROUTINE JAR-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<CRLF>
		<COND (<FSET? ,JAR ,PHRASEBIT>
		       <TELL 
"The door to the closet is ">
		       <OPEN-CLOSED ,JAR>)
		      (T
		       <TELL
"Standing against one wall is the strange sight of a jar that stands nearly
as high as the ceiling">)>
		<TELL ".">
		<RTRUE>)
	       (<AND <FSET? ,JAR ,PHRASEBIT>
		     <NOUN-USED ,JAR ,W?JAR>>
		<TELL 
"The hinges creak eerily as the door moves slowly back and forth, but
nothing else happens." CR>
		<RTRUE>) ;"need rtrue, else printed twice" 
	       (<AND <OR <NOUN-USED ,JAR ,W?DOOR ,W?AJAR>
			 <ADJ-USED ,JAR ,W?AJAR ,W?CLOSET>>
		     <NOT <FSET? ,JAR ,PHRASEBIT>>>
		<UPDATE-SCORE>
		<PUTP ,JAR ,P?SDESC "door">
		<FCLEAR ,JAR ,NARTICLEBIT>
		<FSET ,JAR ,PHRASEBIT>
		<FSET ,JAR ,DOORBIT>
		<FSET ,JAR ,OPENBIT>
		<TELL  "From inside the big jar there comes a flash of
light which intensifies in several quick, increasingly brighter pulses.
Prismatically, the large surface  of the jar glows with the colors of
the rainbow. Then in a blink of your eyes, the light show is over and in
the place of the jar you observe a quite ordinary closet door, which is
now open." CR>
		;<STOP>
		<RTRUE>)
	       (<AND <NOUN-USED ,JAR ,W?LID>
		     <FSET? ,JAR ,PHRASEBIT>>
		<CANT-SEE <> "lid">
		<RTRUE>)>
	 <COND (<FSET? ,JAR ,PHRASEBIT>
		<COND (<VERB? ENTER>
		       <PERFORM ,V?ENTER ,CLOSET>
		       <RTRUE>)>)
	       ;(<VERB? OPEN>
		<TELL 
"You can barely reach the lid, and wouldn't be able to break the seal anyway."
CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "The voluminous, clear jar is empty." CR>)
	       (<VERB? CLOSE>
		<TELL ,ALREADY-IS>)
	       (<OR <AND <VERB? PUT>
		         <PRSI? ,JAR>>
		    <VERB? CLIMB-ON ENTER BOARD>>
		<TELL "The large lid on top is closed too tight." CR>)>>  
		       
<OBJECT CLOSET
	(LOC BATHROOM)
	(DESC "closet")
	(SYNONYM CLOSET)
	(FLAGS NDESCBIT)
	(ACTION CLOSET-F)>

<ROUTINE CLOSET-F ()
	 <COND (<AND <NOT <FSET? ,JAR ,PHRASEBIT>>
		     <NOT <DONT-HANDLE ,CLOSET>>>
		<CANT-SEE <> "closet">)
	       (<VERB? ENTER BOARD>
		<TELL "It's not a walk-in closet." CR>)
	       (<AND <VERB? LOOK-INSIDE REACH-IN SEARCH>
		     <NOT <FSET? ,JAR ,OPENBIT>>>
		<TELL "The closet door is closed." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,CLOSET>>
		<TELL 
"The mayor's got into enough trouble hiding things in the closet." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL 
"Darkness seems to radiate out of the closet." CR>)
	       (<VERB? REACH-IN SEARCH>
		<TELL
"You grope into the darkness but can't seem to put your hands on anything of
significance." CR>)
	       (<AND <VERB? SEARCH-WITH>
		     <PRSI? ,COMB>
		     <IN? ,SKELETON ,LOCAL-GLOBALS>> ;"a must"
	       <UPDATE-SCORE>
	       <MOVE ,SKELETON ,HERE>
	       <TELL
"Using the crack resources of the well-appointed sleuth, you painstakingly
search the closet high and search the closet low. Sounds of chattering
teeth and then of bones knocking together come out of the closet as you
seem to have stirred something up. There is again quiet for a moment,
and then a full skeleton is seen to feint out of the darkness, rattling to
the floor in a heap." CR>)
	       (<VERB? OPEN CLOSE>
		<PUT ,P-NAMW 0 ,W?DOOR>
		<PERFORM ,PRSA ,JAR>
		<RTRUE>)>>

<OBJECT SKELETON
	(LOC LOCAL-GLOBALS)
	(DESC "skeleton")
	(SYNONYM SKELETON SKELETONS)
	(FLAGS TAKEBIT)
	(ACTION SKELETON-F)>

;"PHRASEBIT = gotten rid of in tub by deep six"

<ROUTINE SKELETON-F ()
	 <COND (<VERB? BURY>
		<TELL "There's a better way to be rid of it." CR>)>>

<OBJECT TUB
	(LOC BATHROOM)
	(DESC "bathtub")
	(DESCFCN TUB-F)
	(SYNONYM BATHTUB ;BATH TUB)
	;(ADJECTIVE BATH)
	(FLAGS ;VEHBIT OPENBIT CONTBIT SEARCHBIT NO-D-CONT)
	(ACTION TUB-F)>

<ROUTINE TUB-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND ;(<EQUAL? .OARG ,M-BEG>
		       <RFALSE>)
		      (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<CRLF>
		<COND (<AND <IN? ,DUCK ,TUB>
			    <FSET? ,DUCK ,PHRASEBIT>>
		       <TELL "The mayor is sitting in the bathtub.">)
		      (<IN? ,DUCK ,TUB>
		       <TELL
"Against the far wall you can see a bathtub. Inside is a duck, which is
looking confused and swimming around in circles and figure-8's.">)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? CLEAN-IN>
		     <PRSO? ,LINEN>>
		<PERFORM ,V?PUT ,LINEN ,TUB>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,TUB>>
		<COND (<PRSO? ,LINEN>
		       <TELL 
"Washing the mayor's laundry might be politically worthwhile in the long
run, but this is usually done out in the open." CR>)
		      (<PRSO? ,SKELETON>
		       <TELL
"With that phraseology, it probably wouldn't go deep enough in the water
for you to get rid of it." CR>) 
		      (T
		       <TELL "But" T ,PRSO " doesn't need cleaning." CR>)>)
	       (<VERB? ENTER BOARD>
		<TELL 
"Congratulations on your personal hygiene, but" T ,DUCK " doesn't really
think it's appropriate to share his bath." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<FSET? ,DUCK ,PHRASEBIT>
		       <TELL
"Jimmy \"Fat Baby\" Kazooli reclines in the bathtub." CR>)
		      (T
		       <TELL 
"An angry duck is swimming around and around." CR>)>)>>
	       
<GLOBAL BABY-THROWN <>>

<OBJECT DUCK
	(LOC TUB)
	(SDESC "duck")
	(SYNONYM DUCK MAYOR BABY CAT)
	(ADJECTIVE LAME FAT ANGRY)
	(LDESC 
"The mayor, wearing a white terry cloth robe with his initials stitched on it,
is here pacing the floor and looking very philosophically concerned with
the Big Problems of Our Time.") 
	(FLAGS TRYTAKEBIT)
	(ACTION DUCK-F)>

<GLOBAL WON-GAME <>>

<ROUTINE DUCK-F ()
	 <COND (<AND <ADJ-USED ,DUCK ,W?LAME>
		     <NOT <FSET? ,DUCK ,PHRASEBIT>>>
		<UPDATE-SCORE>
		<FSET ,DUCK ,PHRASEBIT>
		<PUTP ,DUCK ,P?SDESC "mayor">
		<FSET ,DUCK ,ACTORBIT>
		<TELL
"Slapping its white wings against the surface of the water and quacking
up a storm, the angry duck creates nothing less than a raging cyclone in the
bathtub. When the bad weather passes, you can see the rotund figure of
the mayor, Jimmy \"Fat Baby\" Kazooli reclining in the tub." CR>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,DUCK ,W?MAYOR ,W?BABY>
			 <ADJ-USED ,DUCK ,W?FAT>>
		     <NOT <FSET? ,DUCK ,PHRASEBIT>>
		     <VISIBLE? ,DUCK>>	       
		<TELL 
"(Referring to the duck as such doesn't seem to transform it.)" CR>
		<RTRUE>)>	 
	 <COND (<OR <AND <FSET? ,DUCK ,PHRASEBIT>
		         <EQUAL? ,DUCK ,WINNER>>
		    <VERB? TELL>>
		<COND (<AND <VERB? SIGN>
			    <PRSO? ,DECREE>
			    <VISIBLE? ,DECREE>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?GIVE ,DECREE ,DUCK>
		       <SETG WINNER ,DUCK>
		       <RTRUE>)>
		<TELL 
"The mayor merely sighs heavily">
		<COND (<EQUAL? ,HERE ,LOBBY>
		       <TELL " and continues pacing">)>
		<TELL ,PERIOD>
		<STOP>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,DUCK ,PHRASEBIT>
		       <TELL
"The mayor has the wide girth and aloof manner of the washed-up fat cat." CR>)
		      (T
		       <TELL 
"Your first assumption, considering the circular swimming pattern, is
that this is one duck which doesn't have both oars in the water. On closer
examination, however, you determine that one of the duck's feet has been
injured, no doubt in some boating accident." CR>)>)
	       (<AND <VERB? TAKE>
		     <NOT <FSET? ,DUCK ,PHRASEBIT>>>
		<TELL 
"\"Quack!\" Splash. \"Quack!\" Splash. The duck eludes you." CR>)
	       (<VERB? GIVE SHOW>
		<COND (<PRSO? ,DECREE>
		       <COND (<NOT <FSET? ,DUCK ,PHRASEBIT>>
			      <TELL
			       "The duck emits the quackish sound of incredulity from its duck bill">)
			     (<IN? ,DUCK ,TUB>
			      <COND (<FSET? ,SKELETON ,PHRASEBIT>
				     <TELL 
"The mayor seems to want to finish his bath before endeavoring in any
official duties">)
				    (T
				     <TELL 
"A distrustful side-glance from the mayor indicates his lack of willingness to
deal with you">)>)
			     (<NOT <FSET? ,HORN ,PHRASEBIT>>
			      <TELL
"The mayor looks down upon you with a patronizing air about him, seeming to
regard you as a minor player in a lower league politically than himself">)
			     (<NOT <FSET? ,BLESSING ,PHRASEBIT>>
			      <TELL
"The mayor, pacing the floor and appearing cursed by the disasterous plague of
nonsense that has beset his town, ignores the decree">)
			     (<NOT <FSET? ,LINEN ,PHRASEBIT>>
			      <TELL
"With most of his political problems taken care of, the mayor briefly weighs
the importance of the decree, but concludes that his opposition would still
be able to find some dirt on him in the ensuing political struggle">)
			     (T
			      <REMOVE ,DUCK>
			      <SETG WON-GAME T>
			      <UPDATE-SCORE>
			      <TELL
"The mayor, finally convinced of the worthiness of the decree, breaks into
a broad smile and slaps you endearingly on the back, nearly causing
whiplash. He grabs the scrap of paper and signs it perfunctorily. He leaves,
happily">)>
		       <TELL ,PERIOD>)
		      (<AND <PRSO? ,SKELETON ,LINEN>
			    <FSET? ,DUCK ,PHRASEBIT>>
		       <TELL
"The " D ,DUCK " cringes at the spectacle of" T ,PRSO ", wishing to put such
liabilities behind him." CR>)
		      (<AND <PRSO? ,SIX-PACK>
			    <NOT <EQUAL? ,P-PRSA-WORD ,W?DEEP ,W?DEEP-SIX>>>
		       <TELL "He doesn't look to be thirsty." CR>)
		      (<AND <VERB? SHOW>
			    <PRSO? ,BLESSING>>
		       <TELL "He arches his eyebrow skeptically." CR>)>)    
	       (<AND <VERB? THROW-OUT>
		     <PRSI? ,WATER>>
		<UPDATE-SCORE>
		<FSET ,DUCK ,PHRASEBIT>
		<MOVE ,DUCK ,LOBBY>
		<REMOVE ,TUB>
		<TELL  "From the consequential uproar, there seems to be a
ring of truth in this phrase. In strong jets shooting at varying
trajectories, the bathwater in the tub begins first to spout off.
Suddenly, this messy but harmless spectacle of the spouts is over, and
angry riptides ruffle the water's surface. Now with the tidal force of
lunar determination, the bathwater polarizes itself around the edges of
the tub and even higher, engulfing the mayor and leaving a wide funnel
of air in the middle of the tub.|
|
As the gathering water reaches a critical peak, it pauses for one brief
moment, and now with an awful suddenness collapses into itself to form
a fearful wave of tubular shape and seismic strength. It gushes in front
of your face and toward the stairs in a torrent, through which you can
see the strange slow-motion figure of the mayor swimming half in air
and half in water. Following the mayor inside the wave and down the
stairway is the tub itself, which, out of your sight, makes the terrible
crashing noise of porcelain going to smithereens." CR>)>>

<OBJECT COMB
	(LOC BATHROOM)
	(DESC "comb")
	(FDESC 
"A comb lies in a puddle of water by the bathtub.")
	(SYNONYM COMB HAIR)
	(ADJECTIVE FINE TOOTH FINE-TOOTH)
	(FLAGS TAKEBIT)
	(ACTION COMB-F)>

<ROUTINE COMB-F ()
	 <COND (<NOUN-USED ,COMB ,W?HAIR>
		<CHANGE-OBJECT ,COMB ,HEAD>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL  "The comb is distinguished by having a series of
exceptionally fine teeth." CR>)>>

<OBJECT DISGUISE
	;(LOC BATHROOM)
	(DESC "disguise")
	(SYNONYM DISGUISE MASK)
	(ADJECTIVE PUNCHINELLO)
	(FLAGS TAKEBIT CONTBIT OPENBIT SEARCHBIT WEARBIT NO-D-CONT)
	(ACTION DISGUISE-F)>

<ROUTINE DISGUISE-F ()
	 <COND (<VERB? CLOSE>
		<CANT-VERB-A-PRSO "close">)
	       (<AND <VERB? PUT PUT-ON GIVE>
		     <PRSI? ,DISGUISE>
		     <NOT <PRSO? ,BLESSING>>>
		<TELL
"But \"" D ,PRSO " in disguise\" doesn't have the right ring to it." CR>)
	       (<AND <VERB? PUT PUT-ON GIVE>
		     <PRSO? ,BLESSING>
		     <NOT <FSET? ,DISGUISE ,PHRASEBIT>>>
		<FSET ,DISGUISE ,PHRASEBIT>
		<MOVE ,BLESSING ,DISGUISE>
		<UPDATE-SCORE>
		<TELL 
"Sure enough, now you've got a blessing in disguise." CR>) 
	       (<VERB? EXAMINE>
		<TELL
"This a grotesque, clownish, Punchinello mask, apparently worn by the mayor
when he travels incognito." CR>)
	       (<AND <VERB? WEAR>
		     <FIRST? ,DISGUISE>
		     <NOT <FSET? ,DISGUISE ,WORNBIT>>>
		<DO-FIRST "empty" ,DISGUISE>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,HEAD>>
		<PERFORM ,V?WEAR ,DISGUISE>
		<RTRUE>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,DUCK>
		     <FSET? ,DUCK ,PHRASEBIT>>
		<TELL 
"The mayor guides your hand away." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,DISGUISE>
		     <FSET? ,DISGUISE ,WORNBIT>>
		<TELL ,WEARING-IT>)>>

<OBJECT LINEN
	(LOC BATHROOM)
	(DESC "dirty linen")
	(SYNONYM LINEN GARMENT CLOTHES CLOTHING PILE LAUNDRY)
	(ADJECTIVE DIRTY SOILED YOUR MY)
	(FLAGS TAKEBIT NARTICLEBIT NDESCBIT)
	(ACTION LINEN-F)>

<ROUTINE LINEN-F ()
	 <COND (<AND <VERB? LOOK-INSIDE SEARCH MOVE LOOK-UNDER TAKE>
		     <ZERO? <LOC ,DISGUISE>>>
		<MOVE ,DISGUISE ,HERE>
		<TELL
"Keeping your nose at a distance from the soiled clothes, with an outstretched
arm and with the tips of your thumb and finger, you daintily lift a garment
off the top of the pile and then drop it. Some kind of disguise slides off
the pile." CR>
		<COND (<VERB? TAKE>
		       <CRLF>
		       <PERFORM ,V?TAKE ,LINEN>
		       <RTRUE>)>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<TELL "Reluctantly, you pick up the clothes." CR>)
	       (<AND <VERB? CLEAN-IN>
	             <PRSI? ,EIGHT>
		     <OR <EQUAL? <GET ,P-NAMW 1> ,W?PUBLIC>
			 <EQUAL? <GET ,P-ADJW 1> ,W?PUBLIC>>>
		<COND (<EQUAL? ,HERE ,SQUARE>
		       <REMOVE ,LINEN>
		       <UPDATE-SCORE>
		       <FSET ,LINEN ,PHRASEBIT>
		       <TELL "You manage to launder the mayor's dirty
linen, working it over with the sinewy resoluteness of a peasant. Though not
entirely a wholesome experience, you can feel from the stiff westerly
breeze that it's serving to clear the air and bring about a cleansing
effect on the mayor's reputation. The linen is finally caught up by one
especially strong gust -- each piece is filled with air like a sail and
drifts far away across the blue sky." CR>)
		      (T
		       <TELL "You're not in public." CR>)>)
	       (<VERB? CLEAN>
		<COND (<EQUAL? ,HERE ,SQUARE>
		       <PUT ,P-NAMW 1 ,W?PUBLIC>
		       <PERFORM ,V?CLEAN-IN ,LINEN ,EIGHT>
		       <RTRUE>)>
		<TELL "Doing it in private won't help." CR>)>>
  
