"FARM for
		             NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<OBJECT FARM
	(LOC LOCAL-GLOBALS)
	(DESC "farm")
	(PICK-IT "Buy the Farm")
	(MAX-SCORE 19)
	(SCENE-SCORE 0)
	(SCENE-ROOM ROAD)
	(SCENE-CUR 0)
	(SYNONYM BARN LOFT BARNYARD YARD STABLE STABLES FIELD FIELDS
		 MARKET CROP ROAD FARM)
	(ADJECTIVE BARN)
	(FLAGS NDESCBIT SCENEBIT)
	(GENERIC GEN-BARN)
	(ACTION FARM-F)>

<GLOBAL REAL-FARM <>>

<ROUTINE FARM-F ()
	 <COND (<NOUN-USED ,FARM ,W?BARN>
		<SETG REAL-FARM ,BARN>)   ;"name of room or farm object"
	       (<NOUN-USED ,FARM ,W?BARNYARD ,W?YARD>
		<SETG REAL-FARM ,BARNYARD>)
	       (<NOUN-USED ,FARM ,W?LOFT>
		<SETG REAL-FARM ,LOFT>)
	       (<NOUN-USED ,FARM ,W?STABLE ,W?STABLES>
		<SETG REAL-FARM ,STABLE>)
	       (<NOUN-USED ,FARM ,W?FIELD ,W?FIELDS ,W?CROP>
		<SETG REAL-FARM ,FIELD>)
	       (<NOUN-USED ,FARM ,W?MARKET>
		<SETG REAL-FARM ,MARKET>)
	       (<NOUN-USED ,FARM ,W?ROAD>
		<SETG REAL-FARM ,ROAD>)
	       (<NOUN-USED ,FARM ,W?FARM>
		<SETG REAL-FARM ,FARM>)
	       ;(T
	        <SETG REAL-FARM ,BARNYARD>)>
	 <COND (<OR <NOT ,REAL-FARM>
		    <VERB? NO-VERB>
		    <AND <DONT-HANDLE ,FARM>
			 <NOT <VERB? WALK-TO>>>>
		<RFALSE>)
	       (<VERB? WALK-TO ENTER>
		<COND (<AND <EQUAL? ,HERE ,MARKET>
		            <NOT <EQUAL? ,REAL-FARM ,MARKET>>>
		       <SETG REAL-FARM ,ROAD>)>
		<COND (<OR <EQUAL? ,HERE ,REAL-FARM>
			   <AND <NOT <EQUAL? ,HERE ,MARKET>>
				<EQUAL? ,REAL-FARM ,FARM>>>
		       <TELL ,ARRIVED>)
		      (<AND <NOT <IN? ,PROTAGONIST ,CART>>
			    <OR <EQUAL? ,REAL-FARM ,MARKET>
				<EQUAL? ,HERE ,MARKET>>>
		       <TELL "It's really too long a walk." CR>)
		      (<IN? ,PROTAGONIST ,CART>
		       <COND (<NOT ,HORSE-TO-CART>
			      <TELL "You've got no horse to drive it." CR>)
			     (<EQUAL? ,REAL-FARM ,ROAD ,MARKET>
			      <MOVE ,HORSE ,REAL-FARM>
			      <MOVE ,CART ,REAL-FARM>			      
			      <TELL 
"With the horse pushing rather than pulling the cart, you follow a
crooked and bumpy road for some time">
			      <COND (<OR <EQUAL? ,REAL-FARM ,ROAD>
					 <FSET? ,MARKET ,TOUCHBIT>>
				     <TELL "..." CR CR>
				     <GOTO ,REAL-FARM>)
				    (T
				     <SETG HERE ,MARKET>
				     <SETG OLD-HERE <>>
				     <FSET ,MARKET ,TOUCHBIT>
				     <TELL ". You faintly hear
sweet music from a woodwind drifting toward you, and sure enough, around
the next bend you come upon a man playing music on a flute. You pull the
cart to a rumbling halt, and the horse gives a snort.|
|
Seeing you, the piper plays a short flat note, draws the pipe from his
mouth, and takes quick inventory of the wares he is peddling: a cart full
of apples, a rumpled canvas bag, and some strong-smelling peppers." CR>
				     <RTRUE>)>)
			     (T
			      <TELL 
"This is no off-road, all-terrain, 4x4 vehicle you've got here." CR>)>)
		      (T
		       <COND (<EQUAL? ,REAL-FARM ,STABLE>
			      <TELL "You follow your nose to the stable...">)
			     (<EQUAL? ,REAL-FARM ,BARN>
			      <TELL 
"You kick up a little sawdust as you enter the barn...">)
			     (T
			      <TELL 
"You trudge along and get there...">)>
		       <CRLF> <CRLF>
		       <GOTO ,REAL-FARM>
		       <COND (<AND <NOT <EQUAL? ,REAL-FARM ,LOFT>>
				   <NOT <IN? ,OLD-DOG ,HERE>>
				   <FSET? ,OLD-DOG ,PHRASEBIT>
				   <OR <NOT <FSET? ,MILK ,RMUNGBIT>>
				       <FSET? ,MILK ,PHRASEBIT>>>
			      <COND (<AND <EQUAL? ,HERE ,BARN>
					  <NOT <FSET? ,MILK ,RMUNGBIT>>>
				     <FSET ,MILK ,RMUNGBIT>
				     ;<PUTP ,MILK ,P?SDESC "spilt milk"> 
				     <TELL CR
"The old dog enthusiastically bounds into the barn after you, and heedless of
where it's going crashes into the canister of milk, spilling it in a wide
puddle on the floor of the barn.|
|
The dog looks sheepish, and exits the barn with its tail between its
legs.">)
				    (<AND <FSET? ,MILK ,RMUNGBIT>
					  <NOT <FSET? ,MILK ,PHRASEBIT>>>
				     ;"old dog is hidden away"
				     <CRLF>
				     <RTRUE>)
				    (T
			      	     <MOVE ,OLD-DOG ,HERE>
			      	     <TELL CR 
"The old dog follows behind you.">)>
			      <CRLF>)>
		       <RTRUE>)>)
	       (<AND <NOT <EQUAL? ,HERE ,REAL-FARM>>
		     <NOT <EQUAL? ,REAL-FARM ,FARM>>>
		<CANT-SEE <> "such place">)
	       (<AND <VERB? OPEN CLOSE EMPTY-FROM TAKE>
		     <EQUAL? ,REAL-FARM ,STABLE ,BARN>>
		<WASTES>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<EQUAL? ,REAL-FARM ,BARN>
		<CHANGE-OBJECT ,FARM ,BARN>
		<RTRUE>)>>

<ROOM ROAD
      (LOC ROOMS)
      (DESC "Road")
      (LDESC 
"The telltail smell of grain and dung drifts by. You're on a dusty
road in front of abandoned farm -- a nice-sized spread of land that
stretches far out to meet the horizon.")
      (GLOBAL FARM)
      (ACTION ROAD-F)>

<ROUTINE ROAD-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <FSET? ,MARKET ,TOUCHBIT>
		     <FSET? ,SOW-EAR ,PHRASEBIT>
		     <NOT <IN? ,DONKEY ,STABLE>>>
		<MOVE ,DONKEY ,STABLE>
		<TELL CR
"As you stop in the road, suddenly a bucking donkey with a swarm of
buzzing flies chasing it crosses the road in front of you and heads towards the
stable." CR>)>>

<OBJECT OLD-DOG
	(LOC ROAD)
	(DESC "old dog")
	(DESCFCN OLD-DOG-F)
	(SYNONYM DOG)
	(ADJECTIVE OLD)
	(FLAGS ACTORBIT CONTBIT OPENBIT VOWELBIT SEARCHBIT)
	(ACTION OLD-DOG-F)>

<ROUTINE OLD-DOG-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<COND (<FSET? ,OLD-DOG ,PHRASEBIT>
		       <TELL CR  
"A youthful-looking old dog is here, " <PICK-ONE ,DOG-PLAYS>>)
		      (T
		       <TELL CR
"An " D ,OLD-DOG " sits in the dust at the side of the road, feeling all of the spirit of gravity, looking dog-eared and worn out by a lifetime on
the farm">)>
		<TELL ".">)
	       (<VERB? TELL>
		<COND (<FSET? ,OLD-DOG ,PHRASEBIT>
		       <TELL "The dog is too busy " <PICK-ONE ,DOG-PLAYS>
		              " to pay attention">)
		      (T
		       <TELL  "You lift a limp ear and issue your
command. The old dog lets out a big yawn">)>
		<TELL ,PERIOD>
		<STOP>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,OLD-DOG ,PHRASEBIT>
		       <TELL 
"The dog has a shiny black coat, and displays the abundant energy of a
hungry hunting dog">)
		      (T
		       <TELL 
"The dog looks as old and worn out as the Sphinx">
		       <COND (<IN? ,STONE ,OLD-DOG>
			      <TELL
". There's a stone in its mouth">)>)>
		<TELL ,PERIOD>)
	       (<AND <VERB? TEACH>
		     <OR <PRSO? ,TRICKS>
			 <AND <PRSO? ,OLD-DOG>
			      <NOT ,PRSI>>>>
		<COND (<FSET? ,OLD-DOG ,PHRASEBIT>
		       <TELL 
"You've already taught him all the tricks you know">)
		      (T
		       <UPDATE-SCORE>
		       <FSET ,OLD-DOG ,PHRASEBIT>
		       <MOVE ,STONE ,OLD-DOG>
		       <TELL
"The " D ,OLD-DOG " perks up one of its dog-eared ears, then the other.
Its tail emerges from the surrounding dust and begins oscillating back
and forth with such intensity that you'd think it was a case of the tail
wagging the dog.|
|
In turn the old boy goes through a series of back flips, chases its tail,
walks around on his hind legs, and howls at the moon. The dog, bursting
with energy through its shiny new coat, is no longer dry as the dust that
surrounds it.|
|
Suddenly by leaps and bounds, the old dog bolts away, and comes back with
one stone in its slobbery mouth">)>
		<TELL ,PERIOD>)
	       (<VERB? TOUCH>
		<COND (<FSET? ,OLD-DOG ,PHRASEBIT>
		       <TELL 
"He rubs his snout against your arm, and thumps his tail">)
		      (T
		       <TELL 
"As you pat the motionless old dog, dust clouds burst forth from its coat">)>
		<TELL ,PERIOD>)>>
	       
<GLOBAL DOG-PLAYS
	<LTABLE 0
"chasing his tail"
"baying at the moon"
"tripping around on his hind legs" 
"sitting up"
"doing back flips into the air"
"wagging his tail">>

<OBJECT TRICKS
	(LOC GLOBAL-OBJECTS)
	(DESC "new tricks")
	(SYNONYM TRICK TRICKS)
	(ADJECTIVE NEW)
	(FLAGS PLURALBIT)>

<OBJECT STONE	
	(DESC "one stone")
	(SYNONYM STONE)
	(ADJECTIVE NUMBER) ;"number added per Z6"
	(FLAGS NARTICLEBIT TAKEBIT)
	(GENERIC GEN-DEVICE)
	(ACTION STONE-F)>

<ROUTINE STONE-F ()
	 <COND (<AND <NOT <ZERO? ,P-NUMBER>>
		     <ADJ-USED ,STONE ,W?NUMBER>
		     <G? ,P-NUMBER 1>>
		<IMPOSSIBLES>)
	       (<OR <AND <VERB? THROW>
		         <IN? ,OLD-DOG ,HERE>>
		    <AND <VERB? THROW-TO THROW>
			 <PRSI? ,OLD-DOG>>>		
		<MOVE ,STONE ,OLD-DOG>
		<TELL
"The old dog tears out after the stone and retrieves it back to you,
panting and holding it in his slobbery mouth." CR>)>>
		
<OBJECT CART	
	(LOC ROAD)
	(DESC "wooden cart")
	(DESCFCN CART-F)
	(SYNONYM CART)
	(ADJECTIVE WOODEN)
	(FLAGS VEHBIT INBIT CONTBIT OPENBIT SEARCHBIT)
	(GENERIC GEN-APPLE) ;"for apple cart confusion"
	(ACTION CART-F)>

;"PHRASEBIT = PUT CART BEFORE HORSE"

<GLOBAL HORSE-TO-CART <>>

<ROUTINE CART-F ("OPTIONAL" (OARG <>))
	 <COND (<EQUAL? .OARG ,M-OBJDESC ,M-OBJDESC?>
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR "A wooden cart">
		<COND (,HORSE-TO-CART
		       <TELL " with a horse hooked up to it">)>
		<TELL " sits in the dusty road here.">)
	       (<EQUAL? .OARG ,M-BEG>
		<COND (<OR <AND ,PRSO
				<IN? ,PRSO ,HERE>
				<NOT <EQUAL? ,PRSO ,CART>>>
			   <AND ,PRSI
				<IN? ,PRSI ,HERE>
				<NOT <EQUAL? ,PRSI ,CART>>>>
		       <MOVE ,PROTAGONIST ,HERE>
		       <SETG OLD-HERE <>> ;"so here in stat line will change"
		       <TELL "[getting out of the cart first]" CR>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<COND (,HORSE-TO-CART
		       <TELL
"The horse is hooked up to it. ">
		       <RFALSE>)			     
		      (T
		       <TELL
"This is simple a wooden cart, made to be drawn by a beast of burden">)>
		<TELL ,PERIOD>)>> 

<ROOM BARNYARD
      (LOC ROOMS)
      (DESC "Barnyard")
      (GLOBAL FARM SIDE-OF-BARN)
      (ACTION BARNYARD-F)>

<ROUTINE BARNYARD-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You're standing here in the barnyard, a meager patch of scratched earth. ">
		<COND (<AND <FSET? ,TAIL ,NDESCBIT>
			    <FSET? ,SOW-EAR ,NDESCBIT>>
		       <TELL
"You can tell right away what a dog-eat-dog world the farm can be, as you
see lying on the ground a sow's ear, and then some poor animal's tail.">)>
		<FCLEAR ,TAIL ,NDESCBIT>
		<FCLEAR ,SOW-EAR ,NDESCBIT>
		<RTRUE>)>>

<OBJECT TAIL	
	(LOC BARNYARD)
	(DESC "tail")
	(SYNONYM TAIL)
	(FLAGS TAKEBIT NDESCBIT)
	(ACTION TAIL-F)>

<ROUTINE TAIL-F ()
	 <COND (<AND <IN? ,TAIL ,DONKEY>
		     <VERB? TAKE REMOVE>>
		<TELL
"You are behooved to lay off, as the donkey jacks its rear hooves dangerously
close to your face." CR>)
	       (<VERB? TAKE>
		<FCLEAR ,SOW-EAR ,NDESCBIT>
		<RFALSE>)>>  

<OBJECT SOW-EAR	
	(LOC BARNYARD)
	(DESC "sow's ear")
	(SYNONYM EAR)
	(ADJECTIVE ;SOW SOWS SOW\'S) ;"SOW OBJECT won't work with sow as adj"
	(FLAGS TAKEBIT NDESCBIT)
	(ACTION SOW-EAR-F)>

<ROUTINE SOW-EAR-F () ;"if removed, player's ear will be found in syntax"
	 <COND ;(<AND <IN? ,SOW-EAR ,GLOBAL-OBJECTS>
		     <NOT <DONT-HANDLE ,SOW-EAR>>>
		<CANT-SEE ,SOW-EAR>)
	       (<VERB? TAKE>
		<FCLEAR ,TAIL ,NDESCBIT>
		<RFALSE>)
	       (<AND <VERB? SET>
		     <PRSO? ,SOW-EAR>
		     <PRSI? ,PURSE>>
		<COND (<HELD? ,NEEDLE>
		       <UPDATE-SCORE>
		       <FSET ,SOW-EAR ,PHRASEBIT>
		       <FCLEAR ,SOW-EAR ,NDESCBIT>
		       <MOVE ,PURSE <LOC ,SOW-EAR>>
		       <REMOVE ,SOW-EAR>
		       <TELL
"After working your fingers to the bone and using some rather amazing stitches,
you finally tie up the last thread, taking pride in the silky radiance
of the lavender purse">)
		      (T
		       <TELL 
"It seams like a difficult thing to make, but surely impossible without a
needle">)>
		<TELL ,PERIOD>)>>		       
		
<OBJECT PURSE	
	;(LOC GLOBAL-OBJECTS)
	(DESC "silk purse")
	(SYNONYM PURSE)
	(ADJECTIVE SILK)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(CAPACITY 3)
	(ACTION PURSE-F)>

<ROUTINE PURSE-F ()
	 <COND ;(<AND <IN? ,PURSE ,GLOBAL-OBJECTS>
		     <NOT <DONT-HANDLE ,PURSE>>>
		<CANT-SEE ,PURSE>)
	       (<AND <VERB? SET>
		     <PRSI? ,SOW-EAR>>
		<TELL 
"The spiraled seams flex and tighten, but that's it." CR>
		;<MOVE ,SOW-EAR <LOC ,PURSE>>
		;<REMOVE ,PURSE>
		;<MOVE ,PURSE ,GLOBAL-OBJECTS>
		;<TELL 
"It goes back to a sow's ear. (for pig missing ear)" CR>)>>

<OBJECT PENNY
	(LOC PURSE)
	(DESC "pretty penny")
        (SYNONYM PENNY COIN CENT)
	(ADJECTIVE PRETTY)
	(FLAGS TAKEBIT)
	(SIZE 2)
	(ACTION PENNY-F)>

<ROUTINE PENNY-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,PENNY ,TRYTAKEBIT>>
		<TELL "The piper withdraws it from you." CR>)
	       (<VERB? EXAMINE>
		<TELL "It shines pleasantly." CR>)
	       (<AND <VERB? SET>
		     <EQUAL? ,P-PRSA-WORD ,W?FLIP>
		     <IN? ,PENNY ,PROTAGONIST>>
		<TELL 
"You flip it, but can't seem to make head or tail of it." CR>)>>

<OBJECT SWORDS	
	(LOC BARNYARD)
	(DESC "full complement of swords")
	(LDESC 
"You can see a full complement of swords leaning up against the broad
side of the barn, looking very out of place here on the farm.")
	(SYNONYM COMPLEMENT SWORDS SWORD)
	(ADJECTIVE FULL)
	(FLAGS TRYTAKEBIT)
	(ACTION SWORDS-F)>

<ROUTINE SWORDS-F ()
	 <COND (<AND <VERB? TAKE>
		     <NOUN-USED ,SWORDS ,W?COMPLEMENT>
		     <ZERO? <GET ,P-OFW 0>>>
		<TELL "You're very welcome." CR>)
	       (<VERB? TAKE>
		<TELL 
"These implements of ancient warfare have nothing to do with your task
on the farm." CR>)
	       (<AND <VERB? HAMMER>
		     <PRSI? ,PLOWSHARES>>
		<COND (<HELD? ,HAMMER>
		       <FSET ,SWORDS ,PHRASEBIT>
		       <UPDATE-SCORE>
		       <MOVE ,PLOWSHARES ,BARNYARD>
		       <REMOVE ,SWORDS>
		       <TELL
"With your best craftsmanship, you fashion the swords into plowshares with
the gold-glowing hammer">)
		      (T
		       <TELL ,IF-HAMMER>
		       <RTRUE>)>
		<TELL ,PERIOD>)		
	       (<AND <VERB? SET>
		     <PRSI? ,PLOWSHARES>>
		<COND (<HELD? ,HAMMER>
		       <TELL "[with the hammer]" CR>
		       <PERFORM ,V?HAMMER ,SWORDS ,PLOWSHARES>
		       <RTRUE>)
		      (T
		       <TELL ,IF-HAMMER>)>)>>

<OBJECT PLOWSHARES	
	;(LOC BARNYARD)
	(DESC "plowshares")
	(LDESC 
"A lot of plowshares are lying over by the broad side of the barn.")
	(SYNONYM SHARES PLOWSHARES PLOUGHSHARE)
	(ADJECTIVE PLOUGH PLOW)
	(FLAGS PLURALBIT TRYTAKEBIT)
	(ACTION PLOWSHARES-F)>

<ROUTINE PLOWSHARES-F ()
	 <COND (<VERB? TAKE>
		<TELL "Those won't be needed until planting time." CR>)>>

<OBJECT SIDE-OF-BARN	
	(LOC LOCAL-GLOBALS)
	(DESC "broad side of a barn")
	(SYNONYM BROADSIDE SIDE BARN)
	(ADJECTIVE BROAD SIDE BARN)
	(FLAGS NDESCBIT)
	(GENERIC GEN-BARN)
	(ACTION SIDE-OF-BARN-F)>

<ROUTINE SIDE-OF-BARN-F ()
	 <COND (<AND <VERB? MUNG>
		     <EQUAL? ,P-PRSA-WORD ,W?HIT>>
		<COND (<NOT <FSET? ,SIDE-OF-BARN ,PHRASEBIT>>
		       <FSET ,SIDE-OF-BARN ,PHRASEBIT>
		       <UPDATE-SCORE>
		       <TELL 
"You wind up, haul off, and throw a haymaker at the barn.|
|
\"Thump.\"|
|
No one can ever challenge your accuracy after this." CR>)
		      (T
		       <TELL "Okay, don't get carried away." CR>)>)>>

<ROUTINE GEN-BARN ()
	 <COND (<VERB? WALK-TO ENTER NO-VERB ;EXAMINE ;LOOK-INSIDE>
		,FARM)
	       (T
		,SIDE-OF-BARN)>>

<ROOM BARN
      (LOC ROOMS)
      (DESC "Barn")
      ;(LDESC "This is barn. Ladder up.")
      (UP TO LOFT)
      (GLOBAL SIDE-OF-BARN LADDER FARM GRAIN MICE)
      (ACTION BARN-F)>

<ROUTINE BARN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You're surrounded by the deep shade of a nearly abandoned barn, with very
little activity but for an occasional hoot of an owl.">
		<COND (<NOT <FSET? ,GRAIN ,RMUNGBIT>>;"else there's grain here"
		       <TELL
" Yet toward the rear of the barn, under the loft, a cascading
spillage of grain is creating an ever-widening pile.">)>
		<TELL-LADDER>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <FSET? ,MILK ,RMUNGBIT>
		     <ZERO? <LOC ,CAT>>>
		<MOVE ,CAT ,BARN>
		<FSET ,CAT ,NDESCBIT>)>>

<OBJECT MILK
	(LOC BARN)
	(SDESC "canister of milk")
	(DESCFCN MILK-F)
	(SYNONYM MILK CANISTER CANNISTER ;PUDDLE)
	(ADJECTIVE SPILT SPILLED)
	(FLAGS TRYTAKEBIT)
	(ACTION MILK-F)>

;"rmungbit = milk is spilled"

<ROUTINE MILK-F ("OPTIONAL" (OARG <>)) ;"you shouldn't be able to spill"
	 <COND (<FSET? ,MILK ,RMUNGBIT>
		<COND (<NOUN-USED ,MILK ,W?CANISTER>
		       <PUTP ,MILK ,P?SDESC "canister">)
		      (T
		       <PUTP ,MILK ,P?SDESC "spilt milk">)>)>
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR 
"Over near the wide entrance to the barn, there ">
		<COND (<FSET? ,MILK ,RMUNGBIT>
		       <TELL "lies ">)
		      (T
		       <TELL "stands a ">)>
		<TELL D ,MILK ".">
		<COND (<AND <FSET? ,MILK ,RMUNGBIT>
			    <IN? ,CAT ,HERE>>
		       <TELL " A cat is licking up the milk.">)>
		<RTRUE>)
	       (<AND <NOT <FSET? ,MILK ,RMUNGBIT>>
		     <NOT <DONT-HANDLE ,MILK>>
		     ;<NOUN-USED ,MILK ,W?PUDDLE>
		     <ADJ-USED ,MILK ,W?SPILLED ,W?SPILT>>
		<CANT-SEE <> "spilt milk">)
	       (<VERB? STAND-ON ENTER>
		<WASTES>)
	       (<VERB? CRY>
		<COND (,DONT-FLAG
		       <COND (<FSET? ,MILK ,PHRASEBIT>
			      <TELL "You already haven't">)
			     (T
		       	      <MOVE ,OLD-DOG ,HERE>
			      <UPDATE-SCORE>
			      <FSET ,MILK ,PHRASEBIT>
		       	      <TELL 
"You manage the ol' stiff upper lip, and the dog comes bounding back up to
you">)>)
		      (<NOT <IN? ,OLD-DOG ,HERE>> ;"CRY over milk"
		       <TELL 
"In throwing your fit, you can hear the poor ol' dog yowling in the
distance">)
		      (T
		       <TELL "It's already water over the dam">)>
		<TELL ,PERIOD>)
	       (<VERB? REACH-IN>
		<TELL "It's too milky." CR>)
	       (<AND <VERB? KNOCK-OFF MOVE POUR>
		     <NOT <FSET? ,MILK ,RMUNGBIT>>>
		<TELL "This is not government surplus milk." CR>)		
	       (<VERB? TAKE>
		<COND (<AND <FSET? ,MILK ,RMUNGBIT>
			    <NOT <NOUN-USED ,MILK ,W?CANISTER>>
			    <ZERO? <GET ,P-OFW 0>>>
		       <TELL "It drips between your fingers">)
		      (<AND <FSET? ,MILK ,RMUNGBIT>
			    <NOUN-USED ,MILK ,W?CANISTER ,W?CANNISTER>>
		       <TELL "You don't need that old thing">)
		      (T
		       <TELL "The canister is too heavy to be picked up">)>
		<TELL ,PERIOD>)
	       (<VERB? LOOK-INSIDE>
		<COND (<FSET? ,MILK ,RMUNGBIT>
		       <TELL "It's empty">)
		      (T
		       <TELL "It's full of milk">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? PUT>
		     <PRSI? ,MILK>>
		<WASTES>)
	       (<VERB? DRINK>
		<TELL 
"It's neither homogenized nor pasteurized." CR>)>>

<OBJECT LADDER
	(LOC LOCAL-GLOBALS)
	(DESC "wooden ladder")
	(SYNONYM LADDER)
	(ADJECTIVE WOODEN)
	(FLAGS TRYTAKEBIT)
	(ACTION LADDER-F)>

<ROUTINE LADDER-F ()
	 <COND (<VERB? TAKE>
		;<COND (<EQUAL? ,HERE ,BARN>
		       <DO-WALK ,P?UP>)
		      (T
		       <DO-WALK ,P?DOWN>)>
		<TELL "It's not detachable." CR>)
	       (<AND <VERB? CLIMB CLIMB-ON CLIMB-UP>
		     <EQUAL? ,HERE ,BARN>>
		<DO-WALK ,P?UP>)
	       (<AND <VERB? CLIMB CLIMB-ON CLIMB-DOWN>
		     <EQUAL? ,HERE ,LOFT>>
		<DO-WALK ,P?DOWN>)
	       (<VERB? CLIMB-UP CLIMB-DOWN>
		<TELL ,LOOK-AROUND>)>>

<ROUTINE TELL-LADDER ()
	 <TELL CR CR "A " D ,LADDER " leads">
	 <COND (<EQUAL? ,HERE ,BARN>
		<TELL ", presumably, up to">)
	       (T
		<TELL " down from">)>
	 <TELL " the loft.">>

<OBJECT GRAIN
	(LOC BARN)
	(SDESC "grain")
	(DESCFCN GRAIN-F)
	(SYNONYM PILE PILES GRAIN GRAINFALL CORN SPILLAGE)
	(ADJECTIVE BARLEY)
	(FLAGS TRYTAKEBIT DESC-IN-ROOMBIT NOA)
	(ACTION GRAIN-F)>

;"rmungbit = grain is stoped falling"

<ROUTINE GRAIN-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<COND (<NOT <FSET? ,GRAIN ,RMUNGBIT>>
		       <TELL 
"A cascading grainfall is spilling onto the barn floor. Mice appear to be
riding the grain down.">)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,GRAIN>>
		<WASTES>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<NOT <FSET? ,GRAIN ,RMUNGBIT>>
		       <TELL 
"You can see, falling down within the silky stream of golden grain, a
succession of little mice spread-eagled and smiling widely, some giggling,
others tumbling head over heels. They each splash deeply into the
ever-widening pile of grain, and then burrow out the side of it, and
disappear somewhere in the barn." CR>)
		      (T
		       <PERFORM ,V?TAKE ,GRAIN>
		       <RTRUE>)>)
	       (<AND <VERB? REACH-IN>
		     <NOT <FSET? ,GRAIN ,RMUNGBIT>>>
		<PERFORM ,V?TAKE ,MICE>
		<RTRUE>)
	       (<VERB? TAKE>
		<TELL 
"The golden grain spills between your fingers. You determine
the barley corn to be of fair quality." CR>)>>

<OBJECT MICE
	(LOC LOCAL-GLOBALS)
	(DESC "mice")
	(SYNONYM MOUSE MICE)
	(FLAGS PLURALBIT TRYTAKEBIT)
	(ACTION MICE-F)>

<ROUTINE MICE-F ()
	 <COND (<VERB? TAKE CATCH>
		<COND (<AND <EQUAL? ,HERE ,BARN>
			    <NOT <FSET? ,GRAIN ,RMUNGBIT>>
			    <NOT <VERB? FOLLOW>>>
		       <TELL "A mouse bounces off">
		       <COND (,PRSI
			      <TELL " the edge of" T ,PRSI>)
			     (T
			      <TELL " your hand">)>
		       <TELL 
" with a \"squeak,\" hits the ground running, and scampers away out of
sight." CR>)
		      (T
		       <PERFORM ,V?EXAMINE ,MICE>
		       <RTRUE>)>)
	       (<AND <SEEING? ,MICE>
		     ;<EQUAL? ,HERE ,LOFT>
		     <FSET? ,GRAIN ,RMUNGBIT>>
		<TELL "The mice are nowhere to be seen." CR>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,BARN>
		       <PERFORM ,V?EXAMINE ,GRAIN>
		       <RTRUE>)>
		<TELL "The mice are wildly enjoying the grain." CR>)>>
		       
<ROOM LOFT
      (LOC ROOMS)
      (DESC "Loft")
      (DOWN TO BARN)
      (GLOBAL GRAIN LADDER FARM MICE)
      (ACTION LOFT-F)>

;"With your upturned face anxiously upturned, you acsend the ladder."
<ROUTINE LOFT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"It's humid up here in the loft, muggy with the heavy smell of barley corn
in summer. Bags of the pungent grain, all of them torn up and derelict,
are strewn about the edge of the loft">
		<COND (<NOT <FSET? ,GRAIN ,RMUNGBIT>>
		       <TELL 
", creating a constant spillage over the side into which mice are leaping">)>
		<TELL ,PERIOD CR
"This area at one time must have been used by a handyman, for against one wall
a grindstone sits idle">
		<COND (<FSET? ,HAMMER ,NDESCBIT>
		       <TELL " with a hammer next to it">)>
		<TELL ".">
		<TELL-LADDER>
		<RTRUE>)>> 

<OBJECT BAGS-OF-GRAIN
	(LOC LOFT)
	(DESC "bags of grain")
	;(LDESC 
"Bags of grain, many damaged by rodents, piled into stacks next to the edge
of the loft.")
	(SYNONYM BAG BAGS GRAIN STACKS STACK GRAINFALL)
	(ADJECTIVE BARLEY)
	(FLAGS PLURALBIT TRYTAKEBIT DESC-IN-ROOMBIT)
	(GENERIC GEN-BAG)
	(ACTION BAGS-OF-GRAIN-F)>

<ROUTINE BAGS-OF-GRAIN-F (;WORD)
	 ;<COND (<NOUN-USED ,BAGS-OF-GRAIN ,W?BAG ,W?BAGS>
		<SET WORD ,W?BAG>)>
	 <COND (<AND <NOUN-USED ,BAGS-OF-GRAIN ,W?GRAINFALL>
		     <FSET? ,GRAIN ,RMUNGBIT>
		     <NOT <DONT-HANDLE ,BAGS-OF-GRAIN>>>
		<CANT-SEE <> "grainfall">)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<NOT <FSET? ,GRAIN ,RMUNGBIT>>
		       <TELL 
"Grain is spilling from the bags over the loft." CR>)
		      (T
		       <TELL "It's a major-league mess." CR>)>)		
	       (<VERB? TAKE CLEAN>
		<TELL 
"Without heavy farm machinery, you could never tidy up this mess." CR>)>>

<ROUTINE GEN-BAG ()
	 ,CAT-BAG>

<OBJECT HAMMER
	(LOC LOFT)
	(DESC "hammer")
	(SYNONYM HAMMER)
	(FLAGS TAKEBIT NDESCBIT)
	;(ACTION FARM-F)>

<OBJECT GRINDSTONE
	;(LOC LOCAL-GLOBALS) ;"formerly in loft"
	(DESC "grindstone")	
        (SYNONYM GRINDSTONE STONE DEVICE)
	(FLAGS DESC-IN-ROOMBIT)
	(GENERIC GEN-DEVICE)
	(ACTION GRINDSTONE-F)>

<ROUTINE GRINDSTONE-F ()
	 <COND (<AND <VERB? PUT-TO>
		     <PRSO? ,NOSE>>
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <TELL "Okay. Fine. You resolve to work harder">)
		      (<FSET? ,GRINDSTONE ,PHRASEBIT>
		       <TELL "Not again...">)
		      (T
		       <UPDATE-SCORE>
		       <FSET ,GRINDSTONE ,PHRASEBIT>
		       <TELL 
"It's no skin off your nose, but the gesture of good labor stiffens your
resolve to salvage the farm">)>
		<TELL ,PERIOD>)
	       (<VERB? ON>
		<TELL "The dusty old thing hasn't worked for years." CR>)>>

<ROOM STABLE
      (LOC ROOMS)
      (DESC "Stable")
      (GLOBAL FARM WATER)
      (ACTION STABLE-F)>

<ROUTINE STABLE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The strong, earthy smell in this wide-open area reminds you that you're|
on a farm">
		<COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		       <TELL 
". So meet the primary interior decorator of the stable: a very odd-looking
horse who snorts when it sees you">)>
		<TELL ".">)>>     

<OBJECT TROUGH
	(LOC STABLE)
	(DESC "rusty tin trough")
	(SYNONYM TROUGH)
	(ADJECTIVE RUSTY OLD TIN)
	(FLAGS CONTBIT OPENBIT SEARCHBIT NO-D-CONT)
	(ACTION TROUGH-F)>

;"PHRASEBIT = MAKE HORSE DRINK"

<ROUTINE TROUGH-F ()
	 <COND (<VERB? BOARD>
		<V-SWIM>)
	       (<VERB? LOOK-INSIDE EXAMINE> ;"in d-cont, exception"
		<TELL
"The rusty old trough is divided into two parts, containing water ">
		<COND (<NOT <IN? ,OATS ,TROUGH>>
		       <TELL "but devoid of">)
		      (T
		       <TELL "and">)>
		<TELL " wild oats." CR>)>>

<OBJECT OATS
	(LOC TROUGH)
	(DESC "wild oats")
	(SYNONYM OATS FOOD)
	(ADJECTIVE WILD MY)
	(FLAGS TAKEBIT PLURALBIT FOODBIT)
	(ACTION OATS-F)>

<ROUTINE OATS-F ()
	 <COND (<VERB? EAT>
		<TELL "Hay is for horses! Uh, er, so are oats." CR>)
	       (<VERB? SOW>
		<COND (<NOT <FSET? ,OATS ,PHRASEBIT>>
		       <FSET ,OATS ,PHRASEBIT>
		       <UPDATE-SCORE>)>
		<TELL "You haven't even met the farmer's daughter yet." CR>)>>

<OBJECT DONKEY
	;(LOC STABLE)
	(DESC "donkey")
	(DESCFCN DONKEY-F)
	(SYNONYM DONKEY MULE ASS)
	(FLAGS CONTBIT OPENBIT SEARCHBIT NO-D-CONT)
	(ACTION DONKEY-F)>
  
<ROUTINE DONKEY-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<CRLF>
		<COND (<IN? ,TAIL ,DONKEY>
		       <TELL 
"A donkey here contentedly swats away flies with its newly acquired tail.">)
		      (T
		       <TELL 
"A donkey is being chased willy-nilly around the stable being followed by a
swarm of flies in hot and pesky pursuit.">)>)
	       (<VERB? EXAMINE>
		<COND (<IN? ,TAIL ,DONKEY>
		       <TELL "He is serenely swatting flies">)
		      (T
		       <TELL 
"With no tail for protection, the flies are feasting on him">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? PIN PUT PUT-ON>
		     <PRSO? ,TAIL>
		     <HELD? ,TAIL>>
		<COND (<AND <HELD? ,NEEDLE>
			    <VISIBLE? ,NEEDLE>>
		       <MOVE ,TAIL ,DONKEY>
		       <FSET ,TAIL ,TRYTAKEBIT>
		       <REMOVE ,NEEDLE>
		       <COND (<NOT <FSET? ,DONKEY ,PHRASEBIT>>
			      <FSET ,DONKEY ,PHRASEBIT>
			      <UPDATE-SCORE>)>
		       <TELL
"It's so easy, you could do this blindfolded. Smarting from the sharpness
of the needle, the donkey jacks its hooves into the air, narrowly missing
your chin. But the beast of burden soon settles down, and starts shooing
flies with its newly-won tail." CR>)
		      (T
		       <TELL
"You can't see anything to pin the tail with." CR>)>)>>

<OBJECT HORSE
	(LOC STABLE)
	(DESC "gift horse")
	(LDESC 
"An odd-looking horse stands here, nonchalantly shooing at flies with
its tail.")
        (SYNONYM HORSE)
	(ADJECTIVE GIFT ODD-LOOKING ODD)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT FIRST-TIMEBIT)
	(ACTION HORSE-F)>

<GLOBAL HORSE-TO-TROUGH <>>

<ROUTINE HORSE-F ()
	 <COND (<EQUAL? ,HORSE ,WINNER>
		<COND (<AND <VERB? DRINK>
			    <PRSO? ,WATER>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?MAKE-OBJECT-DRINK ,HORSE>
		       <SETG WINNER ,HORSE>
		       <RTRUE>)
		      (T
		       <TELL
"A horse is a horse, of course, of course, and no one can talk to a horse,
of course." CR>
		<STOP>)>)
	       (<VERB? EXAMINE>
		<TELL 
"The horse, which is a hackney, is wearing a large red-ribbon bow in place of a saddle">
		<COND (,HORSE-TO-CART
		       <TELL  " and is hooked up to the cart">)>
		<TELL ". It continues shooing at flies with its tail." CR>)
	       (<VERB? RIDE-OBJECT-TO BOARD>
		<TELL "This is a beast of burden, not a riding horse." CR>)
	       (<AND <VERB? LOOK-OBJECT-IN>
		     <PRSI? ,MOUTH>>
		<COND (<NOT <FSET? ,HORSE ,PHRASEBIT>>
		       <FSET ,HORSE ,PHRASEBIT>
		       <UPDATE-SCORE>)>
		<COND (<FSET? ,HORSE ,RMUNGBIT>
		       <TELL 
"It looks like the horse has drunk a lot of water." CR>)
		      (T
		       <TELL 
"Its mouth appears dry as a ditch." CR>)>)
	       (<AND <VERB? MOVE>
		     <PRSI? ,WATER>>
		<COND (<FSET? ,HORSE ,RMUNGBIT>
		       <PERFORM ,V?MAKE-OBJECT-DRINK ,HORSE>
		       <RTRUE>)
		      (T
		       <SETG HORSE-TO-TROUGH T>
		       <COND (<NOT <FSET? ,WATER ,PHRASEBIT>>
			      <FSET ,WATER ,PHRASEBIT>
			      <UPDATE-SCORE>)>
		       <THIS-IS-IT ,HORSE>
		       <TELL
"You lead the horse, suddenly trusting of you, over to the trough." CR>)>)
	       (<AND <VERB? MOVE>
		     <PRSO? ,HORSE>>
		<TELL "He's stubborn as a mule." CR>)
	       (<VERB? MAKE-OBJECT-DRINK>			 
		<COND (,HORSE-TO-TROUGH
		       <FSET ,HORSE ,RMUNGBIT>
		       <SETG HORSE-TO-TROUGH <>>
		       <MOVE ,HORSE ,ROAD>
		       <COND (<NOT <FSET? ,TROUGH ,PHRASEBIT>>
			      <FSET ,TROUGH ,PHRASEBIT>
			      <UPDATE-SCORE>)>
		       <TELL
"Not only can you lead a horse to water, but contrary to popular belief,
you CAN make him drink. He slurps his fill of water, and with unbridled
energy, he trots away toward the road">)
		      (<FSET? ,HORSE ,RMUNGBIT>
		       <TELL "This is a horse, not a camel">)
		      (T
		       <TELL "The horse isn't near the water">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? PUT-IN-FRONT>
		     <PRSO? ,CART>>
		<COND (,HORSE-TO-CART
		       <TELL ,ALREADY-IS>
		       <RTRUE>)
		      (T
		       <SETG HORSE-TO-CART T>
		       <FSET ,HORSE ,NDESCBIT>
		       <COND (<NOT <FSET? ,CART ,PHRASEBIT>>
			      <FSET ,CART ,PHRASEBIT>
			      <UPDATE-SCORE>)>
		       <TELL 
"Using perfectly backward logic, you put the cart before the horse">)>
		<TELL ,PERIOD>)
	       (<OR <AND <VERB? TIE> ;"hook up horse to cart"
			 <OR <PRSO? ,CART>
			     <PRSI? ,CART>>>
		    <AND <VERB? PUT-IN-FRONT>
			 <PRSO? ,HORSE>
			 <PRSI? ,CART>>>
		<COND (<AND ,HORSE-TO-CART
			    <NOT <VERB? PUT-IN-FRONT>>> 
		       <TELL ,ALREADY-IS>
		       <RTRUE>)
		      (T
		       <TELL 
"The horse snorts and rears. It seems paranoid about having the cart behind
it">)>
		<TELL ,PERIOD>)>>

<OBJECT HORSE-RIBBON
	(LOC HORSE)
	(DESC "red-ribbon bow")
	(SYNONYM RIBBON BOW)
	(ADJECTIVE RED RED-RIBBON)
	(FLAGS TRYTAKEBIT)
	(ACTION HORSE-RIBBON-F)>
	       
<ROUTINE HORSE-RIBBON-F ()
	 <COND (<VERB? TAKE UNTIE READ EXAMINE>
		<COND (<VERB? TAKE UNTIE OPEN>
		       <TELL "You can't, since it">)
		      (T
		       <TELL "It">)>
		<TELL 
" says, \"Do not open till Christmas.\"" CR>)>>

<ROOM FIELD
      (LOC ROOMS)
      (DESC "Field")
      (GLOBAL FARM)
      (ACTION FIELD-F)>

<ROUTINE FIELD-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<IN? ,MOLEHILL ,HERE>
		       <TELL
"You are standing at the edge of a barren field that is reminiscent of the dust
bowl days. A steady wind, having secreted away the topsoil, is now drifting
sandy dirt across the plain. A scant sign of life here is a freshly burrowed
molehill on the ground.">)
		      (T
		       <TELL 
"You are standing in a fertile valley among the tall and lush crops in
the field. Mountains bordering the valley serve to shield the fields
from damaging wind storms.">)>)>>
  
<OBJECT HAYSTACK	
	(LOC FIELD)
	(DESC "haystack")
	(LDESC 
"Marking the corner of the property is a large stack of hay, whose musty odor
sticks in your nostrils.")
	(SYNONYM HAYSTACK HAY STACK)
	(ADJECTIVE HAY)
	;(FLAGS TRYTAKEBIT)
	(ACTION HAYSTACK-F)>

<ROUTINE HAYSTACK-F ()
	 <COND (<VERB? SEARCH-OBJECT-FOR>
		<COND (<PRSI? ,NEEDLE>
		       <COND (<ZERO? <LOC ,NEEDLE>>
			      <MOVE ,NEEDLE ,PROTAGONIST>
			      <COND (<NOT <FSET? ,HAYSTACK ,PHRASEBIT>>
			             <FSET ,HAYSTACK ,PHRASEBIT>
			             <UPDATE-SCORE>)>
			      <THIS-IS-IT ,NEEDLE>
			      <TELL 
"It's hard, of course, because all those stalks of hay look like needles
themselves. The needle is found twinkling brightly silver among the
yellow stalks of hay grass. You grab it">)
			    (T
			      <TELL ,ALREADY-HAVE>
			      <RTRUE>)>)
		      (T
		       <TELL 
"Finding" A ,PRSI " in a haystack is even less likey than finding
a needle there">)>
		<TELL ,PERIOD>)
	       (<VERB? SEARCH>
		<COND (<ZERO? <LOC ,NEEDLE>>
		       <SETG ORPHAN-FLAG ,NEEDLE>
		       <QUEUE I-ORPHAN 2>
		      <TELL
"What on earth do you expect to find in a haystack?" CR>)
		      (T
		       <TELL "You arleady have." CR>)>)
	       (<VERB? CLIMB-UP CLIMB CLIMB-ON ENTER BOARD>
		<TELL 
"You step up the pungent haystack, and slide back down." CR>) 
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,HAYSTACK>>
		<TELL
"No need to worry about anybody running off with your" TR ,PRSO>)>>

<OBJECT NEEDLE
	;(LOC GLOBAL-OBJECTS)
	(DESC "needle")
	(SYNONYM NEEDLE)
	(FLAGS TAKEBIT)
	(GENERIC GEN-NEEDLE)
	;(ACTION NEEDLE-F)>

<OBJECT MOLEHILL
	(LOC FIELD)
	(DESC "molehill")
	(SYNONYM HILL MOLEHILL)
	(ADJECTIVE MOLE)
	(FLAGS DESC-IN-ROOMBIT)
	(ACTION MOLEHILL-F)>

<ROUTINE MOLEHILL-F ()
	 <COND (<AND <ADJ-USED ,MOLEHILL ,W?MOLE>
		     <NOT <NOUN-USED ,MOLEHILL ,W?HILL ,W?MOLEHILL>>>
		<TELL "[the molehill]" CR CR>)>
	 <COND (<AND <VERB? SET>
		     <PRSI? ,MOUNTAIN>>
		<MOVE ,MOUNTAIN ,HERE ;<LOC ,MOLEHILL>>
		<REMOVE ,MOLEHILL>
		<MOVE ,BIRDS ,HERE>
		<MOVE ,CROPS ,HERE>
		<UPDATE-SCORE>
		<FSET ,MOLEHILL ,PHRASEBIT>
		<TELL 
"There is a tremendous rumbling in the distance, getting louder and louder,
until it is deafening. The ground shakes with violence from the mammoth
pressures of the earth's crust. The dirt around the molehill crumbles away as
mighty, jagged granite peaks begin to emerge from deep underneath it, and
you are knocked back as the mountain continues to rise majestically.|
|
The surrounding landscape, once bleak, now undergoes
transformation into a fertile valley before your very eyes. Crops sprout
and grow tall with the crisp snapping sound of fresh corn being husked.|
|
Yet with the abundance comes new dangers, as two birds can be seen circling
above, surveying the lush crops." CR>)>>

<OBJECT MOUNTAIN
	(DESC "mountain")
	(SYNONYM MOUNTAIN MOUNTAINS MT)
	;(ADJECTIVE MOLE)
	(FLAGS NDESCBIT)
	;(ACTION MOUNTAIN-F)>

;<ROUTINE MOUNTAIN-F ()
	 <COND (<AND <VERB? SET>
		     <PRSI? ,MOLEHILL>>
		<MOVE ,MOUNTAIN ,HERE ;<LOC ,MOLEHILL>>
		<REMOVE ,MOUNTAIN>
		<TELL 
"It turns back to molehill." CR>)>>

<OBJECT CROPS
	;(LOC FIELD)
	(DESC "crops")
	(SYNONYM CROP CROPS)
	(ADJECTIVE LUSH)
	(FLAGS NDESCBIT)
	(ACTION CROPS-F)>

<ROUTINE CROPS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL 
"The lush crops, gently waving in the breeze, stretch far to the horizon." CR>)
	       (<VERB? PICK>
		<TELL 
"That's best left for the professionals." CR>)>> 

<OBJECT BIRDS
	;(LOC FIELD)
	(DESC "two birds")
	(LDESC
"Two birds are circling high above, and every once in a while swoop down
upon the field to despoil the green acres.")
	(SYNONYM BIRDS BIRD)
	(ADJECTIVE NUMBER TWO) ;"number added per z6"
	(FLAGS TRYTAKEBIT PLURALBIT ;TAKEBIT)
	(ACTION BIRDS-F)>

<ROUTINE BIRDS-F ()
	 <COND (<AND <NOT <ZERO? ,P-NUMBER>>
		     <G? ,P-NUMBER 2>>
		<IMPOSSIBLES>)
	       (<VERB? EXAMINE>
		<TELL 
"Hovering above, the two birds appear as menacing as vultures and seem to be
having a field day with the crops." CR>)
	       (<AND <VERB? KILL THROW>
		     <OR <AND <PRSO? ,STONE>
			      <VERB? THROW>>
			 <AND <PRSI? ,STONE>
			      <VERB? KILL>>
			 <AND <NOT ,PRSI>
			      <HELD? ,STONE>>>>
		<COND (<OR <NOT <NOUN-USED ,BIRDS ,W?BIRDS>>
			   <NOT ,PRSI>>
		       <TELL 
"The phrasing, like your crooked aim, seems off." CR>
		       <RTRUE>)> 
		<FSET ,BIRDS ,PHRASEBIT>
		<UPDATE-SCORE>
		<MOVE ,OLD-DOG ,HERE>
		<REMOVE ,BIRDS>		
		<FSET ,BIRDS ,RMUNGBIT>
		<REMOVE ,STONE>
		<TELL
"Sensing their impending doom, the birds flutter down to take refuge within
the dense, green acreage. Just now, the old dog, looking as spritely as ever,
comes bouncing upon the scene. Intensely, the old boy scours back and forth
between the furrows, finally scratching to a stop.|
|
He freezes, raises one paw, and stiffens his tail parallel to the ground.|
|
The flush is made! The birds pop up frantically from the cover, criss-crossing
each other's heavenward flight path.|
|
You take aim and throw, and the birds explode in rapid succession like clay
pigeons.|
|
The old dog lets out a long, wolfish howl which echoes thoughout the
valley." CR>)
	       (<VERB? KILL>
		<COND (,PRSI
		       <TELL "Never with" A ,PRSI "!" CR>)
		      (T
		       <TELL "You're not properly \"stoned.\"" CR>)>)
	       (<VERB? TAKE CATCH>
		<TELL 
"A bird in the hand is worth two in the sky. Unfortunately, none are at
hand." CR>)>>

<ROOM MARKET
      (LOC ROOMS)
      (DESC "Market")
      (LDESC 
"Here is what's left of the town marketplace. In days of yore,
denizens of Punster gathered here to sell their wares and
hunt down a bargain, often crowding around carts bulging with a
cornucopian harvest.")
      (GLOBAL FARM)>

<OBJECT PIPER
	(LOC MARKET)
	(DESC "piper")
        (LDESC 
"Along side the road stands a man playing a pipe and selling his wares.")
	(SYNONYM PETER PIPER)
	(ADJECTIVE PETER)
	(FLAGS NO-D-CONT ACTORBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION PIPER-F)>

<ROUTINE PIPER-F ()
	 <COND (<EQUAL? ,PIPER ,WINNER>
		<COND (<AND <VERB? NO-VERB>
		            <PRSO? ,PEPPERS>
			    <FSET? ,PEPPERS ,TRYTAKEBIT>>
		       <TELL 
"Indeed he already has, but you haven't." CR>)
		      (T
		       <SETG PICKED-FLAG <>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?TELL ,PIPER>
		       <SETG WINNER ,PIPER>
		       <RTRUE>)>)
	       (<AND <VERB? TELL>
		     <NOT ,PICKED-FLAG>>
		<TELL 
"The piper responds with some short musical phrasing of his own." CR>
		<STOP>)
	       (<AND <VERB? GIVE SHOW>
		     <PRSO? ,PENNY>
		     <HELD? ,PENNY>>
		<PERFORM ,V?BUY-WITH ,PIG ,PENNY>
		<RTRUE>)>>

<OBJECT PIPE
	(LOC PIPER)
	(DESC "pipe")
        (SYNONYM FLUTE PIPE)
	(FLAGS TRYTAKEBIT)
	(ACTION PIPE-F)>

;"RMUNGBIT = played flute like police"

<ROUTINE PIPE-F ()
	 <COND (<VERB? TAKE>
		<TELL 
"The piper is so lively in his playing of the pipe, it's like grasping at
straws." CR>)>>

<ROUTINE WHISTLE (OBJ)
	 <COND (<NOT <FSET? ,PIPE ,RMUNGBIT>>
		<FSET ,PIPE ,RMUNGBIT>
		<TELL
"The piper strikes a high shrill note, like that of a policeman's whistle.
\"Hands off the merchandise,\" he says, and then goes on piping a merrier
tune." CR>)
	       (T
		<TELL "You must first acquire the " D .OBJ "." CR>)>>

<OBJECT PEPPERS	
	(LOC MARKET)
	(SDESC "strong-smelling peppers")
	(SYNONYM PEPPERS PECK PEPPER FOOD)
	(ADJECTIVE STRONG-SMELLING PICKLED)
	(FLAGS TAKEBIT TRYTAKEBIT PLURALBIT)
	(ACTION PEPPERS-F)>

<ROUTINE PEPPERS-F ()
	 <COND (<OR <NOUN-USED ,PEPPERS ,W?PECK>
		    <ADJ-USED ,PEPPERS ,W?PICKLED>>
		<PUTP ,PEPPERS ,P?SDESC "peck of pickled peppers">)>
	 <COND (<VERB? EXAMINE>
		<TELL 
"With narrowed eyes you take stock: There seems to be about a peck." CR>)
	       (<VERB? SMELL>
		<TELL 
"A strong vinegar smell indicates the peppers have been pickled." CR>)
	       (<AND <FSET? ,PEPPERS ,TRYTAKEBIT>
		     <OR <VERB? BUY TAKE>
		         <AND <VERB? BUY-WITH>
			      <PRSI? ,PENNY>>>>
		<TELL 
"The piper tells you the peppers are not for sale, but can be gotten with
the proper phrase. He plays a short lyrical phrase on his flute." CR>)
	       (<AND <VERB? PICK>
		     <FSET? ,PEPPERS ,TRYTAKEBIT>>
		<COND (<AND <NOUN-USED ,PEPPERS ,W?PEPPERS>
			    <EQUAL? <GET ,P-OFW 0> ,W?PECK>
			    <ADJ-USED ,PEPPERS ,W?PICKLED>>
		       <FCLEAR ,PEPPERS ,TRYTAKEBIT>
		       <FSET ,PEPPERS ,PHRASEBIT>
		       <UPDATE-SCORE>
		       <TELL
"\"That's easy for you to say,\" says the piper, and with a sweep of his
pipe, allows you to take away peppers." CR>)
		      (T
		       <TELL 
"\"Not quite the right phrasing,\" says the piper." CR>)>)
	       (<VERB? PICK>
		<PERFORM ,V?TAKE ,PEPPERS>
		<RTRUE>)>>

<OBJECT CAT-BAG
	(LOC MARKET)
	(DESC "canvas bag")
	(SYNONYM BAG POKE)
	(ADJECTIVE CANVAS RUMPLED)
	(FLAGS TRYTAKEBIT TAKEBIT CONTBIT SEARCHBIT TRANSBIT NO-D-CONT)
	(GENERIC GEN-BAG)
	(ACTION CAT-BAG-F)>

;"rmungbit = in COST-YOU routine"

<ROUTINE CAT-BAG-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,CAT-BAG ,TRYTAKEBIT>
		       <TELL
"The piper quickly tells you there's a pig in the bag." CR>)
		      (<IN? ,CAT ,CAT-BAG>
		       <TELL 
"The bag, which seems to have no opening, is slowly undulating." CR>)>)
	       (<AND <VERB? BUY>
		     <IN? ,CAT ,CAT-BAG>>
		<PERFORM ,V?BUY ,PIG>
		<RTRUE>)
	       (<VERB? OPEN LOOK-INSIDE>
		<COND (<FSET? ,CAT-BAG ,TRYTAKEBIT>
		       <TELL
"\"No need for that,\" says the piper. \"A pig's in there. And he might
escape.\"" CR>)
		      (T
		       <TELL "Strangely, ">
		       <COND (<HELD? ,CAT-BAG>
			      <TELL "as you turn the bag in your hands, ">)>
		       <TELL 
"the bag appears to have no opening." CR>)>)
	       (<AND <VERB? BUY BUY-WITH BUY-IN>
		     <PRSO? ,CAT-BAG>
		     <NOT <FSET? ,CAT-BAG ,TRYTAKEBIT>>>
		<PERFORM ,PRSA ,CAT-BAG ,PRSI>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <FSET? ,CAT-BAG ,TRYTAKEBIT>>
		<WHISTLE ,CAT-BAG>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,CAT-BAG>
		     ;<EQUAL? <ITAKE> T>
		     <IN? ,CAT ,CAT-BAG>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<TELL 
"As you touch the bag you hear \"Meow... Meow.\" You gingerly pick up the
bag. It continues moving slowly in your hands." CR>)>>

<OBJECT CAT
	(LOC CAT-BAG)
	(DESC "cat")	
	(SYNONYM CAT)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION CAT-F)>

<ROUTINE CAT-F ()                       ;"IE, LET CAT OUT OF BAG"
	 <COND (<AND <VERB? EMPTY-FROM> ;"must be holding it (HAVE)"
		     <PRSI? ,CAT-BAG>
		     <IN? ,CAT ,CAT-BAG>>
		<COND (<FSET? ,CAT-BAG ,TRYTAKEBIT>
		       <TELL
"The piper's face turns red, and he forces a very shrill note out of his
pipe. Then he explains that he is simply trying to sell a pig in the bag,
and that you must first buy it before you begin fiddling with it." CR>)
		      (T
		       <COND (<IN? ,PIPER ,HERE>
		       	      <TELL 
"\"All sales are final!\" pipes the piper. ">)>
		       <TELL
"Just now a furry cat appears out of one of the folds in the bag">
		       <COND (<EQUAL? ,HERE ,BARN ,LOFT>
			      ;<FCLEAR ,CAT ,TRYTAKEBIT>
		       	      <UPDATE-SCORE>
		       	      <FSET ,CAT ,PHRASEBIT>
			      <FSET ,GRAIN ,RMUNGBIT>
			      <FCLEAR ,GRAIN ,DESC-IN-ROOMBIT>
			      <PUTP ,GRAIN ,P?SDESC "pile of grain">
			      <TELL
". Suddenly the cat lets out an electrified scream">
			      <COND (<HELD? ,CAT>
				     <TELL " in your arms. You feel
keenly its needle claws emerge from hitherto cottony paws, and
the cat shoots out of your arms">)>
			      <TELL ". Now the feline makes a beeline toward
the grain. Like a fiery pin ball, the cat ricochets around the barn until the
place is rocked into full tilt.|
|
As the excitement dies down, you see the grainfall slow to a
trickle and then the last bits of grain hit the pile with a \"tick...
tick.\"|
|
The mice are no longer to be seen." CR>
			      <REMOVE ,CAT>)
			     (T
			      <TELL 
". But finding nothing of particular interest, it rolls itself back into the
bag." CR>)>)>
		<RTRUE>)

	        (<AND <VERB? TAKE LET-OUT REMOVE>
		      <PRSO? ,CAT>
		      <IN? ,CAT ,CAT-BAG>>
		<COND (<FSET? ,CAT-BAG ,TRYTAKEBIT>
		       <PERFORM ,V?TAKE ,CAT-BAG>
		       <RTRUE>)
		      (T
		       <TELL 
"You might have to rephrase that in a \"cat\"-chier way to make
it work." CR>)>)
		(<AND <NOT <DONT-HANDLE ,CAT>>
		      <IN? ,CAT ,CAT-BAG>
		      <FSET? ,CAT-BAG ,TRYTAKEBIT>>
		 <CANT-SEE <> "cat">)
		(<AND <NOT <DONT-HANDLE ,CAT>>
		      <IN? ,CAT ,CAT-BAG>
		      <OR <TOUCHING? ,CAT>
			  <SEEING? ,CAT>>>
		 <TELL "You can't do that with the cat in the bag." CR>)
		(<AND <VERB? TAKE>
		      <EQUAL? ,HERE ,BARN>>
		 <TELL "The cat dances out of your reach." CR>)
		(<VERB? TOUCH>
		 <TELL 
"The cat unfurls and furls its tail contentedly, and begins idling with
a steady purr." CR>)>>

<OBJECT PIG
	;(LOC CAT-BAG)
	(DESC "pig")	
	(SYNONYM PIG)
	(FLAGS TRYTAKEBIT)
	(ACTION PIG-F)>

<ROUTINE PIG-F ()
	 <COND (<AND <VERB? BUY-IN>		
		     <PRSI? ,CAT-BAG>>
		<COND (,DONT-FLAG
			    ;<NOT <FSET? ,PIG ,PHRASEBIT>>
		       <TELL
"But it seems the piper doesn't do business any other way." CR>)
		      (<FSET? ,CAT-BAG ,TRYTAKEBIT>
		       <COND (<AND <EQUAL? ,HERE ,MARKET>
				   <HELD? ,PENNY>
				   <VISIBLE? ,PENNY>>
			      <MOVE ,PENNY ,PIPER>
			      <FSET ,PIG ,PHRASEBIT>
			      <UPDATE-SCORE>
			      <FSET ,PENNY ,TRYTAKEBIT>
			      <FCLEAR ,CAT-BAG ,TRYTAKEBIT>
			      <THIS-IS-IT ,CAT-BAG>
			      <TELL 
"\"It's a deal!\" says the man. \"I like the way you do business -- buying
a pig in a poke.\" You pay the piper and he plucks the pretty penny from
you. \"Okay, she's yours. Take it.\"" CR>)
			     (T
			      <COST-YOU>)>)
		      (T
		       <TELL ,ALREADY-HAVE>)>)
	       (<AND <IN? ,PIPER ,HERE>
		     <VERB? BUY-WITH>
		     <PRSI? ,PENNY>
		     <FSET? ,CAT-BAG ,TRYTAKEBIT>>
		<TELL
"\"The price is right for the pig, yes, but that's not quite the way
I do business.\" The piper plays a long low note." CR>)
	       (<AND <VERB? BUY>
		     <EQUAL? ,HERE ,MARKET>>
		<COND (<AND <HELD? ,PENNY>
			    <VISIBLE? ,PENNY>>
		       <TELL "[with the " D ,PENNY "]" CR>
		       <PERFORM ,V?BUY-WITH ,PIG ,PENNY>
		       <RTRUE>)
		      (T
		       <COST-YOU>)>)>>

<ROUTINE COST-YOU ()
	 <TELL 
"\"It'll cost you a pretty penny">
	 <COND (<NOT <FSET? ,CAT-BAG ,RMUNGBIT>>
		<FSET ,CAT-BAG ,RMUNGBIT>
		<TELL 
", one fine sow, she is, she is">)>
	 <TELL ",\" says the piper." CR>>

<OBJECT APPLE	
	(LOC APPLE-CART)
	(DESC "apple")
	(SYNONYM APPLE FOOD)
	;(ADJECTIVE)
	(FLAGS TAKEBIT TRYTAKEBIT VOWELBIT)
	(GENERIC GEN-APPLE)
	(ACTION APPLE-F)>

<ROUTINE APPLE-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,APPLE ,TRYTAKEBIT>>
		<TELL 
"The apples are stacked in such way that it is impossible to pry one apple
away from the rest." CR>)>>

<ROUTINE GEN-APPLE () ;"for APPLE, APPLE-CART and CART"
	 <COND (<AND <OR <EQUAL? <GET ,P-NAMW 0> ,W?APPLE>
		         <EQUAL? <GET ,P-NAMW 1> ,W?APPLE>>
		     <VISIBLE? ,APPLE>>
		,APPLE)
	       (<OR <EQUAL? <GET ,P-NAMW 0> ,W?CART>			 
		    <EQUAL? <GET ,P-NAMW 1> ,W?CART>>
		<COND (<VERB? DISEMBARK BOARD>
		       ,CART)
		      (T
		       <RFALSE>)>)
	       (T
		,APPLE)>>

<OBJECT APPLE-CART	
	(LOC MARKET)
	(DESC "applecart")
	(SYNONYM CART APPLE APPLES APPLECART)
	(ADJECTIVE APPLE)
	(FLAGS TRYTAKEBIT VOWELBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT)
	(GENERIC GEN-APPLE)
	(ACTION APPLE-CART-F)> 

<ROUTINE APPLE-CART-F ()
	 <COND (<AND <VERB? PUSH MOVE KILL MUNG>
		     <NOT <FSET? ,APPLE-CART ,PHRASEBIT>>>
		<TELL
"The apples remain undisturbed. The piper intones, \"Pick your words
as carefully as you would an apple from the bottom of the stack.\"" CR>)
	       (<AND <NOUN-USED ,APPLE-CART ,W?APPLE ,W?APPLES>
		     <VERB? TAKE>>
		<COND (<FSET? ,APPLE-CART ,PHRASEBIT>
		       <PERFORM ,V?UPSET ,APPLE-CART>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?TAKE ,APPLE>
		       <RTRUE>)>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL 
"The apples in the cart are stacked tightly together." CR>) 
	       (<VERB? UPSET>
		<COND (<FSET? ,APPLE-CART ,PHRASEBIT>
		       <TELL "\"Limit one per customer,\" says the piper">)
		      (T
		       <UPDATE-SCORE>
		       <FSET ,APPLE-CART ,PHRASEBIT>
		       <REMOVE ,APPLE>
		       <TELL
"Visibly perturbed, the stacked apples begin to tremble and quake, until
one apple heaves up out of the pile and into the air. Your horsey
companion eyeballs the apple, bares his teeth, tilts back his
long mane, and catches it. He loudly chomps it into a pulp, and swallows">)>
		<TELL ,PERIOD>)>>