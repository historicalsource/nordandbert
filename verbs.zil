"VERBS for
		           NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"subtitle game commands"

<GLOBAL VERBOSITY 1> ;"0 = super-brief, 1 = brief, 2 = verbose"

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <COND (,PRSO
		<RECOGNIZE>)
	       (T
		<SETG VERBOSITY 0>
	 	<TELL "Super-brief descriptions." CR>)>>

<ROUTINE V-SAVE ("AUX" X)
	 <PUTB ,OOPS-INBUF 1 0>
	 <SETG P-CONT <>> ;"flush anything on input line after SAVE"
	 <SETG QUOTE-FLAG <>>
	 <SET X <SAVE>>
	 <COND (<ZERO? .X>
	        <TELL "Save, failed." CR>
		<RFATAL>)
	       (<EQUAL? .X 1>
		<TELL "Save, completed." CR>
		<V-$REFRESH T> ;"screen had been clearing"
		<PUT 0 8 <BAND <GET 0 8> -5>> ;"so screen won't clear"
		<RFATAL>)>
	 <TELL "Okay, restored." CR>
	 <SETG OLD-HERE <>>
	 <SETG UPDATE-SCORE? T>
         <V-$REFRESH T>
	 <PUT 0 8 <BAND <GET 0 8> -5>> ;"to prevent screen clearing on restore"
	 <CRLF>
	 <V-LOOK>
	 <RFATAL>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
	        <TELL ,OK>)
	       (T
		<TELL ,FAILED>)>>

<ROUTINE V-SCRIPT ()
         ;<COND (<WRONG-WINNER?>
	       	<RFATAL>)>
	 <TELL "[Scripting on.]" CR>
	 <DIROUT ,D-PRINTER-ON>
	 <CORP-NOTICE "begins">	 
	 <RTRUE>>

<ROUTINE V-UNSCRIPT ()
	 ;<COND (<WRONG-WINNER?>
	        <RFATAL>)>
	 <CORP-NOTICE "ends">
	 <DIROUT ,D-PRINTER-OFF>
	 <TELL "[Scripting off.]" CR>
	 <RTRUE>>

<ROUTINE CORP-NOTICE (STRING)
	 <DIROUT ,D-SCREEN-OFF>
	 <TELL
"Here " .STRING " a transcript of interaction with Nord and Bert Couldn't
Make Head or Tail of It" ,PERIOD>
	 <DIROUT ,D-SCREEN-ON>
	 <RTRUE>>

<ROUTINE V-DIAGNOSE ()
	 <TELL "You're as fit as a fiddle">
	 <TELL ,PERIOD>>	 

<ROUTINE V-INVENTORY ()
	 <COND (<EQUAL? ,SCENE ,RESTAURANT>
		<TELL
"You're cross-eyed with anger, which means a jaundiced eye points this way,
and an evil eye points that way. ">
		<COND (<FSET? ,SPLEEN ,PHRASEBIT>
		       <TELL 
"But you feel some justification in having vented your spleen. ">)
		      (T
		       <TELL
"You can trace a strong burning sensation to the area of your
spleen." CR CR>)>)>
	 <COND (<NOT <FIRST? ,PROTAGONIST>>
		<TELL "You're empty-handed." CR>
		<RTRUE>)>
	 <D-CONTENTS ,PROTAGONIST <>>
	 <COND (<AND <FSET? ,MOLEHILL ,PHRASEBIT>
		     <NOT <FSET? ,HANDS ,RMUNGBIT>>
		     <EQUAL? ,SCENE ,FARM>>
		<FSET ,HANDS ,RMUNGBIT>
		<TELL " You also notice a green tint to your thumb.">)> 
	 <CRLF>>

<ROUTINE V-QUIT ()
	 ;<TELL-SCORE>
	 <DO-YOU-WISH "leave the game">
	 <COND (<YES?>
		<QUIT>)
	       (T
		<TELL ,OK>)>>

<ROUTINE V-RESTART ()
	 ;<TELL-SCORE>
	 <DO-YOU-WISH "restart">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL ,FAILED>)>>

<ROUTINE DO-YOU-WISH (STRING)
	 <TELL CR "Do you wish to " .STRING "? (Y is affirmative): ">>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<YES-WORD <GET ,P-LEXV 1>>
		<RTRUE>)
	       (<OR <NO-WORD <GET ,P-LEXV 1>>
		    <EQUAL? <GET ,P-LEXV 1> ,W?N>>
		<RFALSE>)
	       (T
		<TELL "Please answer YES or NO. ">
		<AGAIN>)>>

<ROUTINE FINISH ("AUX" (REPEATING <>) (CNT 0))
	 <PROG ()
	       <CRLF>
	       <COND (<NOT .REPEATING>
		      <SET REPEATING T>
		      ;<TELL-SCORE>)>
	       <STATUS-LINE>
	       <TELL
"Would you like to start over, restore a saved position, or end this
session of the game?|
(Type RESTART, RESTORE, or QUIT): >">
	       <PUTB ,P-LEXV 0 10>
	       <READ ,P-INBUF ,P-LEXV>
	       <PUTB ,P-LEXV 0 60>
	       <SET CNT <+ .CNT 1>>
	       <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTART>
	              <RESTART>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<AND <EQUAL? <GET ,P-LEXV 1> ,W?RESTORE>
		      	   <NOT <RESTORE>>>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<OR <EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
			  <G? .CNT 10>>
		      <QUIT>)>
	       <AGAIN>>>

<ROUTINE V-VERSION ("AUX" (CNT 17) V)
	 <SET V <BAND <GET 0 1> *3777*>>
	 ;<TELL 
"Nord and Bert Couldn't Make Head or Tail of It|
Infocom interactive fiction|
Copyright (c) 1987 by Infocom, Inc. All rights reserved.|
Nord and Bert... is a trademark of Infocom, Inc.|
Beta Release for Donald Abernathie (IBM) / Serial number ">
	 <TELL 
"Nord and Bert Couldn't Make Head or Tail of It|
Infocom interactive fiction|
Copyright (c) 1987 by Infocom, Inc. All rights reserved.|
Nord and Bert Couldn't Make Head or Tail of It|
is a trademark of Infocom, Inc. ">
	 <V-$ID>
	 <TELL "Release " N .V " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

;<CONSTANT D-RECORD-ON 4>
;<CONSTANT D-RECORD-OFF -4>

;<ROUTINE V-$COMMAND ()
	 <DIRIN 1>
	 <RTRUE>>

;<ROUTINE V-$RANDOM ()
	 <COND (<NOT <PRSO? ,INTNUM>>
		<TELL "ILLEGAL." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

;<ROUTINE V-$RECORD ()
	 <DIROUT ,D-RECORD-ON> ;"all READS and INPUTS get sent to command file"
	 <RTRUE>>

;<ROUTINE V-$UNRECORD ()
	 <DIROUT ,D-RECORD-OFF>
	 <RTRUE>>

<ROUTINE V-$ID ()
	 <TELL "Interpreter ">
	 <PRINTN <GETB 0 30>>
	 <TELL " Version ">
	 <PRINTC <GETB 0 31>>
	 <CRLF>
	 <RTRUE>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <EQUAL? ,P-NUMBER 232>>
		<TELL N ,SERIAL CR>)
	       (T
		<V-$ID>
		<TELL CR "[Verifying.]" CR>
	 	<COND (<VERIFY>
		       <TELL ,OK>)
	       	      (T
		       <TELL CR "** Bad **" CR>)>)>>

<CONSTANT SERIAL 0>

<ROUTINE V-$REFRESH ("OPTIONAL" (DONT-CLEAR <>))
	 <COND (.DONT-CLEAR ;"the screen"
		<INIT-STATUS-LINE T>)
	       (T
		<INIT-STATUS-LINE>)>
	 <STATUS-LINE>
	 ;<CRLF>
	 <RTRUE>>

;<GLOBAL DEBUG <>>

;<ROUTINE V-$DEBUG ()
	 <TELL "O">
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "ff">)
	       (T
		<SETG DEBUG T>
		<TELL "n">)>
	 <TELL ,PERIOD>>

;"subtitle real verbs"

<ROUTINE V-ALARM ()
	 <COND (<PRSO? ,ROOMS ,ME>
		<PERFORM-PRSA ,ME>
		<RTRUE>)
	       (T
		<TELL "But" T ,PRSO " isn't catching 40 winks." CR>)>>

;<ROUTINE V-ANSWER ()
	 <COND (<AND ,AWAITING-REPLY
		     <YES-WORD <GET ,P-LEXV ,P-CONT>>>
	        <V-YES>
		<STOP>)
	       (<AND ,AWAITING-REPLY
		     <NO-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-NO>
		<STOP>)
	       (T
		<TELL "Nobody is awaiting your answer." CR>
	        <STOP>)>>

;<ROUTINE ORPHAN-VERB ()
	 <COND (<NOT <EQUAL? ,HERE ,AUDIENCE-CHAMBER ,BEDROOM>>
		<SETG AWAITING-FAKE-ORPHAN <>>
		<RFALSE>)>
	 <PUT ,P-VTBL 0 ,W?ZZMGCK>
	 <PUT ,P-OVTBL 0 ,W?ANSWER>	;"maybe fix 'what do you want to'"
	 <PUT ,P-OTBL ,P-VERB ,ACT?ZZMGCK>
	 <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
	 <PUT ,P-OTBL ,P-PREP1 0>
	 <PUT ,P-OTBL ,P-PREP1N 0>
	 <PUT ,P-OTBL ,P-PREP2 0>
	 <PUT ,P-OTBL 5 0>
	 <PUT ,P-OTBL ,P-NC1 1>
	 <PUT ,P-OTBL ,P-NC1L 0>
	 <PUT ,P-OTBL ,P-NC2 0>
	 <PUT ,P-OTBL ,P-NC2L 0>
	 <SETG P-OFLAG T>>

<ROUTINE V-APPLAUD ()
	 <TELL "\"Clap.\"" CR>>

;<ROUTINE PRE-SPEAK ()
	 <COND (,GONE-APE
		<TELL
"You open " 'MOUTH " to speak, but all that comes out are a few grunts." CR>
		<STOP>)
	       (<FSET? ,EARS ,MUNGBIT>
		<TELL ,YOU-CANT "carry on a conversation when " 'EARS " are">
		<COND (<EQUAL? ,EARS ,HAND-COVER>
		       <TELL " covered">)
		      (T
		       <TELL " plugged up">)>
		<TELL ,PERIOD>
		<STOP>)>>

<ROUTINE V-ASK-ABOUT ("AUX" OWINNER)
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	        ;(<FSET? ,PRSO ,ACTORBIT>
		    ;<AND <PRSO? ,INTNUM>
			 <EQUAL? ,P-NUMBER ,CHOICE-NUMBER>
		     	 <IN? ,SULTANS-WIFE ,HERE>>
		<SET OWINNER ,WINNER>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?TELL-ABOUT ,ME ,PRSI>
		<SETG WINNER .OWINNER>
		<THIS-IS-IT ,PRSI>
		<THIS-IS-IT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-FOR ()
	 <TELL "Unsurprisingly," T ,PRSO " doesn't oblige." CR>>

<ROUTINE V-ASK-NO-ONE-FOR ("AUX" ACTOR)
	 <COND (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT>>
		<PERFORM ,V?ASK-FOR .ACTOR ,PRSO>
		<RTRUE>)
	       (T
		<NO-ONE-HERE "ask">)>>

;<ROUTINE V-BARTER-WITH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "But" T ,PRSO " has nothing worth trading for." CR>)
	       (T
		<IMPOSSIBLES>)>>

;<ROUTINE V-BARTER-FOR ()
	 <IMPOSSIBLES>>

<ROUTINE V-BEND ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?SPREAD>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <V-BOARD>)
		      (T
		       <HACK-HACK "Spreading">)>)
	       (T
	        <HACK-HACK "Bending">)>>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE V-BLESS ()
	 <COND (<HELD? ,BLESSING>
		<PERFORM ,V?GIVE ,BLESSING ,PRSO>
		<RTRUE>)
	       (T
		<TELL ,YNH AR ,BLESSING>)>>

<ROUTINE V-BLOW ()
	 <CANT-VERB-A-PRSO "blow">>

<ROUTINE PRE-BOARD ()
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<COND (<AND <EQUAL? ,P-PRSA-WORD ,W?RIDE ,W?PEDDLE>
		            <PRSO? ,ICICLE>>
		       <TELL "Indicate where you want to go." CR>)
		      (T
		       <TELL ,LOOK-AROUND>)>)	       
	       (<AND <HELD? ,PRSO>
		     <NOT <PRSO? ,LAUREL>>>
		<COND (<PRSO? ,ICICLE>
		       <MOVE ,ICICLE ,HERE>
		       <RFALSE>)>
		<TELL ,HOLDING-IT>)
	       (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>)>>

<ROUTINE V-BOARD ("AUX" (AV <LOC ,PROTAGONIST>))
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<NOT <EQUAL? <LOC ,PRSO> ,HERE ,LOCAL-GLOBALS>>
		       <TELL ,YOU-CANT "board" T ,PRSO " when it's ">
		       <COND (<FSET? <LOC ,PRSO> ,SURFACEBIT>
			      <TELL "on">)
			     (T
			      <TELL "in">)>
		       <TELL TR <LOC ,PRSO>>
		       <RTRUE>)>
		<MOVE ,PROTAGONIST ,PRSO>
		<SETG OLD-HERE <>>
		<COND (<AND <PRSO? ,REST-CHAIR>
			    <NOT <FSET? ,REST-CHAIR ,RMUNGBIT>>>
		       <TELL 
"As you brush against the table it swivels slightly. ">)>
		<TELL "You are now ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n" T ,PRSO ".">
		<COND (<AND <IN? ,OLD-DOG ,HERE>
			    <FSET? ,OLD-DOG ,PHRASEBIT>>
		       <MOVE ,OLD-DOG ,PRSO>
		       <TELL " The old dog hops in with you.">)>
		<FSET ,PRSO ,TOUCHBIT>
		<CRLF>)
	       ;(<FSET? ,PRSO ,ACTORBIT>
		<TELL
"Let's not beat around the bush. Come out and say what you mean." CR>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN>
		<CANT-VERB-A-PRSO "get into">)
	       (T
		<CANT-VERB-A-PRSO "get onto">)>>

;<ROUTINE V-BOARD-DIR ()
	 <RECOGNIZE>>

<ROUTINE V-BOO ()
	 <TELL "What did you expect -- art?" CR>>

<ROUTINE V-BURN ()
	 <COND (<NOT ,PRSI>
		<COND (<AND <HELD? ,MATCH>
			    <FSET? ,MATCH ,ONBIT>>
		       <SETG PRSI ,MATCH>
		       <TELL "[with the match]" CR>)
		      (<EQUAL? ,HERE ,FACTORY>
		       <COND (<NOT <HELD? ,PRSO>>
			      <TELL ,YNH TR ,PRSO>
			      <RTRUE>)
			     (T
			      <REMOVE ,PRSO>
			      <TELL 
"With much snapping, crackling and popping the bonfire consumes" TR ,PRSO>
			      <RTRUE>)>)
		      (T
		       <TELL "You have no source of fire." CR>
		       <RTRUE>)>)>
	 <COND (<NOT <PRSI? ,MATCH>>
		<TELL ,YOU-CANT "burn something with" AR ,PRSI>)
	       (<NOT <FSET? ,MATCH ,ONBIT>>
		<TELL "It's not lit." CR>)
	       (<PRSO? ,BOB-SHOE>
		<PERFORM ,V?PUT ,MATCH ,BOB-SHOE>
		<RTRUE>)
	       (T
		<TELL 
"Somebody yelling \"Fire\" in the crowded theater is enough to stop you."
CR>)>>

<ROUTINE V-BURY ()
	 <COND (,PRSI
		<COND (<AND <PRSO? ,HATCHET>
			    <PRSI? ,OX>>
		       <SETG P-PRSA-WORD ,W?GORE>
		       <PERFORM ,V?KILL ,OX>
		       <RTRUE>)>
		<PERFORM ,V?KILL ,PRSI ,PRSO>
		<RTRUE>)
	       (<PRSO? ,HATCHET>
		<SETG ORPHAN-FLAG ,HATCHET>
		<QUEUE I-ORPHAN 2>
		<TELL
"Into whom do you want to bury the hatchet?" CR>)
	       (<FSET? ,HERE ,INDOORSBIT>
		<IMPOSSIBLES>)
	       (T
		<WASTES>)>>

<GLOBAL ITEM-BOUGHT <>> ;"in store"

<ROUTINE V-BUY ()
	 <COND (<EQUAL? ,SCENE ,AISLE>
		<COND (<AND <PRSO? ,TACKS>
			    <NOT <FSET? ,TACKS ,OLDBIT>>>
		       <TELL ,NO-SALE>
		       <RTRUE>)
		      (<OR <NOT <HELD? ,SCENT>>
			   <FSET? ,SCENT ,OLDBIT>>
		       <TELL "You don't have any money">)
		      (<OR <NOT <IN? ,PRSO ,SAIL>>
			   <FSET? ,SAIL ,OLDBIT>>
		       <TELL
"If" T ,PRSO " were only on sale, you might be able to afford it">)
		      (<OR <NOT <EQUAL? ,HERE ,CELLAR-ROOM>>
			   <FSET? ,CELLAR ,OLDBIT>>
		       <TELL
"You may be a willing buyer, but where is the willing seller?" CR>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,CELLAR-ROOM>
		       <COND (<AND <HELD? ,TACKS>
				   <NOT <FSET? ,TACKS ,OLDBIT>>>
			      <REMOVE ,SCENT>
			      <REMOVE ,TACKS>
			      <SETG ITEM-BOUGHT ,PRSO>
			      <UPDATE-SCORE>
			      <QUEUE I-END-SCENE 1>
			      <TELL 
"Okay, you buy" T ,PRSO ", handing the cent and the tax to the seller." CR>
			      <RTRUE>)
			     (T
			      <TELL
"\"Within your price range, yes,\" says the seller, \"but it looks like
you can't afford the tax.\"" CR>)>
		       <RTRUE>)
		      (T	        
		       <TELL "Sorry, there aren't any on sale here">)>
	 <TELL ,PERIOD>)
	       (<NOUN-USED ,FARM ,W?FARM>
		<PERFORM ,V?BUY ,START-OBJ>
		<RTRUE>)
	       (T
		<TELL ,NO-SALE>)>>

<ROUTINE V-BUY-IN ()
	 <TELL ,YOU-CANT "buy" A ,PRSO " in" AR ,PRSI>>

<ROUTINE V-BUY-WITH ()
	 <COND (<OR <EQUAL? ,PRSI ,PENNY>
		    <AND <PRSI? ,SCENT>
			 <NOT <FSET? ,SCENT ,OLDBIT>>>>
		<PERFORM ,V?BUY ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"It's doubtful" T ,PRSO " could pass as anything but funny money." CR>)>>

<ROUTINE V-CALL ()
	 <PERFORM ,V?TELL ,PRSO>
	 <RTRUE>>

<ROUTINE V-CATCH ()
	 <TELL 
"You can catch as catch can, but you can't catch" TR ,PRSO>>

<ROUTINE V-CHASTISE ()
	 <COND (<PRSO? ,INTDIR>
		<TELL
,YOULL-HAVE-TO "go in that direction to see what's there." CR>)
	       (T
		<TELL
"Use prepositions to indicate precisely what you want to do: LOOK AT the
object, LOOK INSIDE it, LOOK UNDER it, etc." CR>)>>

<ROUTINE V-CHEER ()
	 <COND (<PRSO? ,ROOMS>
		<TELL ,OK>)
	       (T
		<TELL "Probably," T ,PRSO " is as happy as possible." CR>)>>

<ROUTINE V-CHOO ()
	 <COND (<EQUAL? ,ORPHAN-FLAG ,FLOUR>
		<TELL "Bless you." CR>)
	       (T
		<TELL "Frustratingly, you can't quite muster a sneeze." CR>)>>

<ROUTINE V-CLEAN ()
	 ;<SETG AWAITING-REPLY 2>
	 ;<QUEUE I-REPLY 2>
	 <TELL "Do you also do windows?" CR>>

<ROUTINE V-CLEAN-IN ()
	 <V-CLEAN>>

;<ROUTINE V-CLICK ()
	 <TELL "\"Click.\"" CR>>

<ROUTINE V-CLIMB ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       ;(<AND <FSET? ,PRSO ,ACTORBIT> ;"GO DOWN ON OBJECT"
		     <EQUAL? ,P-PRSA-WORD ,W?GO>>
		<PERFORM ,V?EAT ,PRSO>
		<RTRUE>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<OR <FSET? ,PRSO ,VEHBIT>
		    <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN ;,PR?INSIDE>
		<CANT-VERB-A-PRSO "climb into">)
	       (T
		<CANT-VERB-A-PRSO "climb onto">)>>

<ROUTINE V-CLIMB-OVER ()
	 <COND (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
	 	<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLOSE ()
	 <COND (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,VEHBIT>>
		<CANT-VERB-A-PRSO "close">)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,CONTBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Okay," T ,PRSO " is now closed." CR>
		       ;<NOW-DARK?>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (T
		<CANT-VERB-A-PRSO "close">)>>

<ROUTINE V-COMB ()
	 <COND (<HELD? ,COMB>
		<COND (<PRSO? ,HEAD>
		       <WASTES>
		       <RTRUE>)>
		<PERFORM ,V?SEARCH-WITH ,PRSO ,COMB>
		<RTRUE>)
	       (T
		<TELL ,YNH AR ,COMB>)>>

<ROUTINE V-COOK ()
	 <COND (<AND <NOT ,PRSO>
		     <EQUAL? ,ORPHAN-FLAG ,HATCHET>>
		<PERFORM ,V?NO-VERB ,COOK>
		<RTRUE>)
	       (T
		<TELL "Too many cooks spoil the broth." CR>)>>

<ROUTINE V-COUNT ()
	 <IMPOSSIBLES>>

<ROUTINE V-CRAWL ()
	 <COND (<EQUAL? ,ORPHAN-FLAG ,SHOULDER>
		<PERFORM ,V?NO-VERB ,SHOULDER>
		<RTRUE>)
	       (T
		<WASTES>)>>

<ROUTINE V-CRAWL-UNDER ()
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
	        <TELL-HIT-HEAD>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CROSS ()
	 <V-WALK-AROUND>>

<ROUTINE V-CRY ()
	 <COND (,PRSO
		<TELL "But" A ,PRSO " is not worth crying over">)
	       (T
		<TELL "Boo hoo">)>
	 <TELL ,PERIOD>>

<ROUTINE V-CUT ()
	 <COND (<NOT ,PRSI>
		<IMPOSSIBLES>)
	       (<PRSI? ,PIECE-OF-METAL ,HATCHET>
		<TELL 
"Brandishing" T ,PRSI " before" T ,PRSO " just won't cut the mustard." CR>)
	       (T
		<TELL
"To put it bluntly, neither" T ,PRSI " nor you are very sharp." CR>)>>

<ROUTINE V-DECODE ()
	 <TELL ,YOULL-HAVE-TO "figure it out yourself." CR>>

<ROUTINE V-DEEP-SIX ()
	 <COND (,PRSI  ;"deep object object"
		<COND (<NOT <VISIBLE? ,SIX-PACK>>
		       <CANT-SEE <> "deep six">)
		      (<PRSI? ,ROOMS>
		       <PERFORM ,V?EXAMINE ,SIX-PACK>
		       <RTRUE>)
		      (<PRSO? ,SIX-PACK>
		       <PERFORM ,V?GIVE ,SIX-PACK ,PRSI>
		       <RTRUE>)
		      (T
		       <RECOGNIZE>)>)
	       (<VISIBLE? ,SIX-PACK>
		<PERFORM ,V?GIVE ,SIX-PACK ,PRSO>
		<RTRUE>)
	       (T
		<CANT-SEE <> "deep six">)>>

<ROUTINE V-DEFLATE ()
	 <IMPOSSIBLES>>

<ROUTINE V-DIG ()
	 <WASTES>>

;<ROUTINE V-DINE-ON ()
	 <PERFORM ,V?EAT ,PRSO>
	 <RTRUE>>

<ROUTINE V-DISEMBARK ()
	 <COND (<NOT ,PRSO>
		<COND (<NOT <IN? ,PROTAGONIST ,HERE>>
		       <PERFORM-PRSA <LOC ,PROTAGONIST>>
		       <RTRUE>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<EQUAL? ,P-PRSA-WORD ,W?TAKE> ;"since GET OUT is also TAKE OUT"
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<NOT <IN? ,PROTAGONIST ,PRSO>>
		<TELL ,LOOK-AROUND>
		<RFATAL>)
	       (T
		<MOVE ,PROTAGONIST ,HERE>
		<SETG OLD-HERE <>>
		<TELL "You">		
		<COND (<AND <IN? ,OLD-DOG ,PRSO>
			    <FSET? ,OLD-DOG ,PHRASEBIT>>
		      <MOVE ,OLD-DOG ,HERE>
		      <TELL ", along with the old dog,">)>
		<TELL " get o">
		<COND (<OFF-VEHICLE? ,PRSO>
		       <TELL "ff">)
		      (T
		       <TELL "ut of">)>
		<TELL T ,PRSO ".">		
		<CRLF>)>>

;<ROUTINE V-DRESS ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <COND (<FSET? ,PRSO ,FEMALEBIT>
			      <TELL "Sh">)
			     (T
			      <TELL "H">)>
		       <TELL "e is dressed!" CR>)
		      (T
		       <IMPOSSIBLES>)>)
	       (T
		<SETG PRSO ,ROOMS>
		<V-GET-DRESSED>)>>

<ROUTINE V-DRINK ()
	 <CANT-VERB-A-PRSO "drink">>

<ROUTINE V-DRINK-FROM ()
	 <IMPOSSIBLES>>

<ROUTINE V-DROP ()
	 <COND (<NOT <SPECIAL-DROP>>
		;<COND (<OR <EQUAL? <LOC ,PROTAGONIST> ,BARGE ,RAFT>
			   <EQUAL? <LOC ,PROTAGONIST> ,TREE-HOLE ,CAGE>>
		       <MOVE ,PRSO <LOC ,PROTAGONIST>>)>
		      
		       <MOVE ,PRSO ,HERE>
		<TELL "Dropped." CR>)>>

<ROUTINE SPECIAL-DROP () ;"used by drop and throw"
	 <RFALSE> 
	 ;<COND (<IN-CATACOMBS>
		<REMOVE ,PRSO>
		<TELL "With a splash," T ,PRSO " is lost forever." CR>)
	       (<IN-SPACE?>
		<MOVE ,PRSO ,PROTAGONIST>
		<TELL
"In the absence of gravity," T ,PRSO " floats back into " 'HANDS "s." CR>)
	       (<EQUAL? ,HERE ,EXIT-SHOP>
		<MOVE ,PRSO ,DUST>
		<TELL "You lose" T ,PRSO " in the dust." CR>)
	       (<AND <PRSO? ,TORCH>
		     <FSET? ,TORCH ,ONBIT>
		     <IN? ,PROTAGONIST ,BARGE>>
		<PERFORM ,V?PUT ,TORCH ,BARGE>
		<RTRUE>)>>

<ROUTINE V-EAT ()
	 <COND (<PRSO? ,GRAIN ,APPLE ,PEPPERS ,OATS ,APPLE-CART>
		<TELL 
"This is no time for pigging out on">
		<COND (<PRSO? ,APPLE ,APPLE-CART>
		       <TELL " apples">)
		      (T
		       <TELL T ,PRSO>)>
		<TELL ,PERIOD>)
	       (<FSET? ,PRSO ,FOODBIT>
		<TELL 
"Actually," T-IS-ARE ,PRSO "not all that appetizing." CR>)
	       (T
		<TELL "That's pretty nutty." CR>)>>
;"How do you want that cooked?"

<ROUTINE V-EMPTY ("AUX" OBJ NXT)
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,GROUND>)>
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL ,HUH>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "But" T ,PRSO " isn't open." CR>)
	       (<NOT <FIRST? ,PRSO>>
		<TELL "But" T ,PRSO " is already empty!" CR>)
	       (<AND <PRSI? <FIRST? ,PRSO>>
		     <NOT <NEXT? ,PRSI>>>
		<TELL ,THERES-NOTHING "in" T ,PRSO " but" TR ,PRSI>)
	       (T
		<SET OBJ <FIRST? ,PRSO>>
		<REPEAT ()
			<SET NXT <NEXT? .OBJ>>
			<COND (<NOT <EQUAL? .OBJ ,PROTAGONIST>>
			       <TELL D .OBJ ": ">
			       <COND (<FSET? .OBJ ,TAKEBIT>
				      <MOVE .OBJ ,PROTAGONIST>
				      <COND (<PRSI? ,HANDS>
					     <TELL "Taken." CR>)
					    (<PRSI? ,GROUND>
					     <PERFORM ,V?DROP .OBJ>)
					    (<FSET? ,PRSI ,SURFACEBIT>
					     <PERFORM ,V?PUT-ON .OBJ ,PRSI>)
					    (T
					     <PERFORM ,V?PUT .OBJ ,PRSI>)>)
				     (T
				      <YUKS>)>)>
			<COND (.NXT
			       <SET OBJ .NXT>)
			      (T
			       <RETURN>)>>)>>

<ROUTINE V-EMPTY-FROM ()
	 <COND (<IN? ,PRSO ,PRSI>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <MOVE ,PRSO ,PROTAGONIST>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (T
		       <YUKS>)>)
	       (T
		<NOT-IN>)>>

<ROUTINE V-ENTER ()
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<FSET? ,PRSO ,ACTORBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL-HIT-HEAD>)
	      (<HELD? ,PRSO>
	       <TELL ,HOLDING-IT>
	       <RTRUE>)
	      (T
	       <IMPOSSIBLES>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<AND ,PRSI ;"l at obj with obj"
		     <NOT <EQUAL? ,PRSI ,EYES>>>
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<COND (<AND <FIRST? ,PRSO>
			    <NOT <PRSO? ,CLIENT>>>
		       <PERFORM ,V?LOOK-INSIDE ,PRSO>
		       <RTRUE>)
		      (T
		       <NOTHING-INTERESTING>
		       <TELL "about" TR ,PRSO>)>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,SURFACEBIT>>
		<V-LOOK-INSIDE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <EQUAL? ,PRSO ,OLIVE-TREE>>>
		<COND (<FSET? ,PRSO ,OPENBIT>			    
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "It's closed." CR>)>)
	       ;(<FSET? ,PRSO ,LIGHTBIT>
		<TELL "It's o">
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ,PERIOD>)
	       (<FSET? ,PRSO ,READBIT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       ;(<FSET? ,PRSO ,NARTICLEBIT>
		<SENSE-OBJECT "look">)
	       ;(<OR <PROB 25>
		    <PRSO? ,PSEUDO-OBJECT>>
		<TELL "Totally ordinary looking " D ,PRSO ,PERIOD>)
	       (<OR <PROB 60>
		    <PRSO? ,DEVICES ,FOOT>
		    <FSET? ,PRSO ,PLURALBIT>>
		<NOTHING-INTERESTING>
		<TELL "about" TR ,PRSO>)
	       (T
	        <PRONOUN>
		<TELL " look">
		<COND (<AND <NOT <FSET? ,PRSO ,PLURALBIT>>
			    <NOT <PRSO? ,ME>>>
		       <TELL "s">)>
		<TELL " like every other " D ,PRSO " you've ever seen." CR>)>>

<ROUTINE NOTHING-INTERESTING ()
	 <TELL ,THERES-NOTHING>
	 <COND (<PROB 25>
		<TELL "unusual">)
	       (<PROB 33>
		<TELL "noteworthy">)
	       (<PROB 50>
		<TELL "eye-catching">)
	       (T
		<TELL "special">)>
	 <TELL " ">>

<ROUTINE V-EXIT ()
	 <COND (<AND ,PRSO
		     <FSET? ,PRSO ,VEHBIT>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (<NOT <IN-EXITABLE-VEHICLE?>>
		<DO-WALK ,P?OUT>)>>

<ROUTINE IN-EXITABLE-VEHICLE? ("AUX" AV)
	 <SET AV <LOC ,PROTAGONIST>>
	 <COND (<EQUAL? .AV ,CART ,PAN ,HOT-TUB>
		<PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-FEED ("AUX" FOOD)
         <COND (<SET FOOD <FIND-IN ,PROTAGONIST ,FOODBIT>>
		<PERFORM ,V?GIVE .FOOD ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have no food for" TR ,PRSO>)>>

<ROUTINE V-FILL ()
	 <COND ;(<AND <OR <FSET? ,PRSO ,CONTBIT>
			 <AND <PRSO? ,STAIN ,CREAM>
		     	      <FSET? ,STAIN ,MUNGBIT>>>
		     <OR <PRSI? ,WATER>
			 <GLOBAL-IN? ,WATER ,HERE>>>
		<WASTES>)
	       (<NOT ,PRSI>
		<TELL ,THERES-NOTHING "to fill it with." CR>)
	       (T 
		<IMPOSSIBLES>)>>

<ROUTINE V-FIND ("OPTIONAL" (WHERE <>) "AUX" (L <LOC ,PRSO>))
	 <COND (<NOT .L>
		<PRONOUN>
		<TELL " could be anywhere!" CR>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<TELL "You have it!" CR>)
	       (<IN? ,PRSO ,HERE>
		<TELL "Right in front of you." CR>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<V-DECODE>)
	       (<AND <FSET? .L ,ACTORBIT>
		     <VISIBLE? .L>>
		<TELL "Looks as if" T .L " has it." CR>)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? ,PRSO>
		     <NOT <IN? .L ,GLOBAL-OBJECTS>>>
		<COND (<FSET? .L ,SURFACEBIT>
		       <TELL "O">)
		      (<AND <FSET? .L ,VEHBIT>
			    <NOT <FSET? .L ,INBIT>>>
		       <TELL "O">)
		      (T
		       <TELL "I">)>
		<TELL "n" TR .L>)
	       (.WHERE
		<TELL "Beats me." CR>)
	       (T
		<V-DECODE>)>>

;<ROUTINE V-FLUSH ()
	 <TELL "It's your brain that needs flushing." CR>>

<ROUTINE V-FOLLOW ()
	 <COND (<VISIBLE? ,PRSO>
		<TELL "But" T-IS-ARE ,PRSO "right here!" CR>)
	       (<AND <NOT <FSET? ,PRSO ,ACTORBIT>>
		     <NOT <PRSO? ,PEARL>>>
		<IMPOSSIBLES>)
	       (T
		<TELL "You have no idea where" T ,PRSO>
		<COND (<FSET? ,PRSO ,PLURALBIT>
		       <TELL " are">)
		      (T
		       <TELL " is">)>
		<TELL ,PERIOD>)>>

<GLOBAL FOLLOW-FLAG <>>

<ROUTINE I-FOLLOW ()
	 <SETG FOLLOW-FLAG <>>
	 <RFALSE>>

<ROUTINE PRE-GIVE ()
	 <COND (<AND <VERB? GIVE>
		     <PRSO? ,HANDS>>
		<PERFORM ,V?SHAKE-WITH ,PRSI>
		<RTRUE>)
	       (<PRSO? ,EYES>
		<PRE-SWITCH>
		<PERFORM ,V?EXAMINE ,PRSI ,EYES>
		<RTRUE>)
	       (<AND <EQUAL? ,P-PRSA-WORD ,W?FEED>
		     <NOT <FSET? ,PRSO ,FOODBIT>>>
		<TELL "That's not food!" CR>)
	       (<AND <PRSO? ,FOOT>
		     <ADJ-USED ,FOOT ,W?HOT>>
		<TELL "How?" CR>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-GARBLE ("AUX" X (NUM 0)) 
	 <REPEAT ()
		 <COND (<ZERO? .NUM>
			<TELL ">">)>
		 <SET X <INPUT 1>>
	 	 <COND (<OR <EQUAL? .X 69 101> ;"ASCII values of E and e"
			    <EQUAL? .X 197 229>> ;"plus 128, to prevent bug"
			<PUTB ,P-INBUF .NUM 67>
			<PRINTC 67>)
		       (<OR <EQUAL? .X 78 110> ;"ASCII values of N and n"
			    <EQUAL? .X 206 238>>
			<PRINTC 80>
			<PUTB ,P-INBUF .NUM 80>)
		       (<EQUAL? .X 10 13>  ;"carriage return"
			<PUTB ,P-LEXV 0 59>
			<MAIN-LOOP>
			<AGAIN>
			<RETURN>)
		       (T
			<PRINTC .X>
			<PUTB ,P-INBUF .NUM .X>)>
		 <INC NUM>>
	 <RTRUE>>

<ROUTINE V-GIVE ()
	 <COND (<PRSI? ,MURDERER>
		<GIVE-TO-MURDERER>)
	       (<PRSI? ,ROCKS>
		<GIVE-TO-ROCKS>)
	       (<AND <PRSI? ,CELLAR>
		     <NOT <FSET? ,CELLAR ,OLDBIT>>>
		<GIVE-TO-SELLER>)
	       (<AND <PRSI? ,CLIENT>
		     <EQUAL? ,HERE ,CLOUD-ROOM>>
		<GIVE-TO-CLIENT>)
	       (<AND <PRSI? ,PEARL>
		     <PRSO? ,MARE>
		     <NOT <FSET? ,PEARL ,OLDBIT>>>
		<UPDATE-SCORE>
		<REMOVE ,MARE>
		<TELL 
"Wide-eyed, the girl turns" T ,MARE " in her hands, marveling at the
exactitude of its right angles. She then hungrily devours it in several
large neck-stretching gulps." CR>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<TELL 
"Briskly," T ,PRSI " refuse">
		<COND (<NOT <FSET? ,PRSI ,PLURALBIT>>
		       <TELL "s">)>
		<TELL " your offer." CR>)
	       (<OR <FSET? ,PRSI ,SCENEBIT> ;"give old bottle to room"
		    <PRSI? ,GLOBAL-ROOM>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<AND <PRSO? ,BLUSHING-CROW>
		     <NOT <FSET? ,BLUSHING-CROW ,OLDBIT>>>
		<PERFORM ,V?KILL ,PRSI ,BLUSHING-CROW>
		<RTRUE>)
	       (T
		<TELL ,YOU-CANT "give" A ,PRSO " to" A ,PRSI "!" CR>)>>

<ROUTINE GIVE-TO-MURDERER ("AUX" STR)
	 <REMOVE ,PRSO>
	 <COND (<FSET? ,PRSO ,PLURALBIT>
		<SET STR "them">)
	       (T
		<SET STR "it">)>
	 <TELL 
"You toss" T ,PRSO " down the aisle to him. He summarily bites " .STR ", then
flings " .STR " away over the shelves" >
	 <COND (<AND <PRSO? ,MINCE>
		     <EQUAL? <GET ,P-NAMW 0> ,W?MINT ,W?MINTS>
		     <NOT <FSET? ,MINCE ,OLDBIT>>>
		<UPDATE-SCORE>
		<SETG MINCE-EATEN T>
		<TELL
		 ". There's a noticable improvement in his breath, even from here">)>
		<TELL ,PERIOD>>

<ROUTINE GIVE-TO-ROCKS ()
	 <COND (<AND <PRSO? ,PAN-OF-KEYS>
		     <NOT <FSET? ,PAN-OF-KEYS ,OLDBIT>>>
		<UPDATE-SCORE>
		<FSET ,ROCKS ,RMUNGBIT>
		<FSET ,ROCKS ,SEENBIT>
		<REMOVE ,PAN-OF-KEYS>
		<PUTP ,ROCKS ,P?OLDDESC "fed rocks">
		<TELL
"You scatter the green peas among the hungry rocks, who crack heads with each
other in their eagerness to gobble them up. When the peas are gone, they
devour even the tin can, which is loudly crushed as it disappears between
several of the fed rocks." CR>)
	       (T
		<TELL "\"No! Feed us!\"" CR>)>>

<ROUTINE GIVE-TO-CLIENT ()
	 <COND (<OR <PRSO? ,HOUSE>
		    <AND <PRSO? ,RAT>
			 <IN? ,HOUSE ,RAT>>>
		<TELL
"The giant greedily snatches your offering">
		<MOVE ,PRSO ,CLIENT>
		<COND (<OR <NOUN-USED ,HOUSE ,W?HOUSE>
		           <ADJ-USED ,HOUSE ,W?LEAD>>
		       <TELL 
". In the time it takes Mr. Clean to get a closer look at it, you">
		       <CLIENT-FALL>)
		      (T
		       <TELL " and eyes it with suspicion." CR>)>)
	       (T
		<WASTES>)>>     

<ROUTINE GIVE-TO-SELLER ()
	 <COND (<OR <AND <PRSO? ,SCENT>
			 <NOT <FSET? ,SCENT ,OLDBIT>>>
		    <AND <PRSO? ,TACKS>
			 <NOT <FSET? ,SCENT ,OLDBIT>>>>
		<SETG ORPHAN-FLAG ,CELLAR>
		<QUEUE I-ORPHAN 2>
		<TELL
"\"Exactly what is it you want to buy?\"" CR>
		<RFATAL>)
	       (T
		<THIS-IS-IT ,PRSO>
		<TELL
"The seller offhandedly rejects" T ,PRSO ".||
\"I'm a seller, not a receiver, damn it. You want to buy something, then
buy it.\"" CR>
		<RFATAL>)>> 
		 
<ROUTINE V-GIVE-UP ()
	 <COND (<PRSO? ,ROOMS>
		<V-QUIT>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-GOOSE ()
	 <TELL "No. Just flatly no." CR>>

<ROUTINE V-GRIND ()
	 <COND (<EQUAL? ,HERE ,LOFT ,KITCHEN>
		<TELL "There's no point in that." CR>)
	       (T
		<CANT-SEE <> "grindstone">)>>

<ROUTINE V-HAIR ()
	 <COND (<AND <PRSO? ,EXPERIENCE>
		     ,TRANS-PRINTED>
		;<PUT ,P-ADJW 0 ,W?HAIR>
		;<PERFORM ,V?NO-VERB ,EXPERIENCE>
		<RTRUE>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-HAMMER ()
	 <TELL 
"No matter how hard you hit" T ,PRSO ", it'd never turn into " AR ,PRSI>>

<ROUTINE V-HELLO ()
       <COND (,PRSO
	      <TELL
"[The proper way to talk to characters in the story is PERSON, HELLO.]" CR>)
	     (T
	      <PERFORM ,V?TELL ,ME>
	      <RTRUE>)>>

<ROUTINE V-HIDE ()
	 <TELL ,YOU-CANT "hide ">
	 <COND (,PRSO
		<TELL "t">)>
	 <TELL "here." CR>>

<ROUTINE V-HINTS-NO ()
	 <COND (<NOT <PRSO? ,ROOMS>>
		<RECOGNIZE>
		<RTRUE>)
	       (<NOT ,HINTS-OFF>
		<TELL "[Okay, you will">)
	       (T
		<TELL "[You">)>
	 <SETG HINTS-OFF T>
	 <TELL " have no access to help in this session.]" CR>
	 <RTRUE>>

<ROUTINE V-IN ("AUX" VEHICLE)
	 <DO-WALK ,P?IN>>

<ROUTINE V-INFLATE ()
	 <IMPOSSIBLES>>

;<ROUTINE V-INHALE ()
	 <COND (<NOT ,PRSO>
		<TELL ,OK>)
	       (<PRSO? ,ROOMS>
		<TELL "You begin to get light-headed." CR>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <TELL 
"The pun is mightier than the sword." CR>>

<ROUTINE V-KISS ()
	<COND (<FSET? ,PRSO ,ACTORBIT>
	       <TELL
"Since" T-IS-ARE ,PRSO "not a kissing cousin, you'd sooner kiss off or
accept the kiss of death than to take it on the kisser." CR>)
	      (T
	       <IMPOSSIBLES>)>>

;<ROUTINE V-KNEEL ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?BOW>
		<SORE "waist">)
	       (<NOT <PRE-POUR>>
	 	<SORE "knee">)>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Silence answers back." CR>)
	       (T
		<HACK-HACK "Knocking on">)>>

<ROUTINE V-KNOCK-OFF ()
	 <COND (<NOT ,PRSI>
		<SETG PRSI <LOC ,PRSO>>)>
	 <COND (<NOT <IN? ,PRSO ,PRSI>>
		<NOT-IN>)
	       (<AND <FSET? ,PRSI ,SURFACEBIT>
		     <FSET? ,PRSO ,TAKEBIT>
		     <NOT <FSET? ,PRSO ,TRYTAKEBIT>>>
		<MOVE ,PRSO ,HERE>
		<TELL "Knocked off." CR>)
	       (T
		<IMPOSSIBLES>)>>
		
;<ROUTINE V-LAND ()
	 <COND (<AND <NOT ,PRSO>
		     <EQUAL? <LOC ,PROTAGONIST> ,RAFT ,BARGE>>
		<PERFORM-PRSA <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
	 	<TELL ,HUH>)>>

<ROUTINE V-LEAP ()
	 <COND (<OR <PRSO? ,ROOMS>
		    <NOT ,PRSO>>
		<WEE>)
	       (<AND ,PRSO
		     <NOT <IN? ,PRSO ,HERE>>>
		<IMPOSSIBLES>)
	       (T
		<WEE>)>>

<ROUTINE V-LEAP-OFF ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?LEAP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LEAVE ()
	 <COND (<NOT ,PRSO>
		<SETG PRSO ,ROOMS>)>
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?OUT>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LEAVE-TO ()
	 <TELL "Left." CR>>

<ROUTINE V-LET-OUT ()
	 <TELL "But" T ,PRSO " isn't all that confined." CR>>

;<ROUTINE V-LICK ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?EAT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TASTE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LIE-DOWN ()
	 ;<COND (<AND <EQUAL? ,HERE ,BEDROOM>
		     <PRSO? ,ROOMS>>
		<SETG PRSO ,BED>)>
	 ;<COND (<OR <FSET? ,PRSO ,VEHBIT>
		    <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)>
	       
	        <WASTES>>

;<ROUTINE V-LIMBER ()
	 <TELL "Ahhh. Nothing like a little muscle-loosening." CR>>

;<ROUTINE PRE-LISTEN ()
	 <COND (<AND <FSET? ,EARS ,MUNGBIT>
		     <NOT ,GONE-APE>>
		<TELL "You hear the sound of ">
		<COND (<EQUAL? ,EARS ,HAND-COVER>
		       <TELL "sweating palms">)
		      (T
		       <TELL "rustling cotton">)>
		<TELL ,PERIOD>)>>

<ROUTINE V-LISTEN ()
	 <COND (,PRSO
	 	<SENSE-OBJECT "sound">)
	       (T
		<TELL "You hear nothing of interest." CR>)>>

<ROUTINE V-LOCK ()
	 ;<COND (<EQUAL? ,P-PRSA-WORD ,W?LOX>
		<COND (<AND <NOT <FSET? ,LOCKS ,OLDBIT>>
		            <VISIBLE? ,LOCKS>>
		       <PERFORM ,V?PUT ,LOCKS ,PRSO>
		       <RTRUE>)
		      (T
		       <CANT-SEE <> "lox">)>)>
	 <YUKS>>

;<ROUTINE PRE-LOOK ()
	 <COND (<PLAYER-CANT-SEE>
	 	<RTRUE>)>>

<ROUTINE V-LOOK ()
	 ;<COND (<EQUAL? ,HAND-COVER ,EYES>
		<UNIFORMLY-COLORED "Palm" "hands over your eyes">)
	        (<FSET? ,EYES ,MUNGBIT>
		<UNIFORMLY-COLORED "Eyelids" "eyes closed">)>
	       <COND (<D-ROOM T>
	 	      <D-OBJECTS>)>
	       <RTRUE>>

;<ROUTINE UNIFORMLY-COLORED (ROOM-NAME STRING)
	 <TELL .ROOM-NAME " Room|
   This location is dim and uniformly colored, resembling what you see
when you have your " .STRING ". In fact, you have your "
.STRING ,PERIOD>>

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>
	 <TELL "There is nothing behind" TR ,PRSO>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<COND (<AND <EQUAL? ,HERE ,ATTIC>
			    <NOT <FSET? ,ATTIC ,PHRASEBIT>>>
		       <PERFORM ,V?EXAMINE ,CEILING>)
		      (T
		       <PERFORM ,V?EXAMINE ,GROUND>)>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL ,IT-SEEMS-THAT T ,PRSO " has">
		<COND (<NOT <D-NOTHING>>
		       <TELL ,PERIOD>)>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<D-VEHICLE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "All you can tell is that" T ,PRSO " is ">
		<OPEN-CLOSED ,PRSO>
		<TELL ,PERIOD>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?OUT ,W?OUTSIDE>
		<TELL "You see nothing special." CR>)
	       (<FSET? ,PRSO ,SURFACEBIT>		
		<TELL "On" T ,PRSO " you see">
		<COND (<NOT <D-NOTHING>>
		       <TELL ,PERIOD>)>
		<RTRUE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<SEE-INSIDE? ,PRSO>
		       <TELL "Inside" T ,PRSO " you see">
		       <COND (<NOT <D-NOTHING>>
		              <TELL ,PERIOD>)>
		       <RTRUE>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <COND (<PRE-TOUCH>
			      <RTRUE>)>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (T
		       <DO-FIRST "open" ,PRSO>)>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN ;,PR?INSIDE>
		<CANT-VERB-A-PRSO "look inside">)
	       (T
		<TELL
"Even Superman would have trouble seeing through" AR ,PRSO>)>>

<ROUTINE V-LOOK-OBJECT-IN ()
	 <COND (<AND <FSET? ,PRSO ,ACTORBIT>
		     <PRSI? ,MOUTH>>
		<TELL "It looks like ten percent fewer cavities." CR>)
	       (T
		<IMPOSSIBLES>)>>
		
<ROUTINE V-LOOK-OVER ()
	 <V-EXAMINE>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<HELD? ,PRSO>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL ,WEARING-IT>)
		      (T
		       <TELL ,HOLDING-IT>)>)
	       (T
		<NOTHING-INTERESTING>
		<TELL "under" TR ,PRSO>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<PRSO? ,ROOMS>
		<COND ;(<EQUAL? ,HERE ,WELL-BOTTOM>
		       <TELL ,YOU-SEE " a dot of light." CR>)
		      ;(<IN-CATACOMBS>
		       <TELL ,ONLY-BLACKNESS>)
		      (<FSET? ,HERE ,INDOORSBIT>
		       <COND (<AND <EQUAL? ,HERE ,ATTIC>
				   <NOT <FSET? ,ATTIC ,PHRASEBIT>>>
			      <PERFORM ,V?EXAMINE ,GROUND>)
			     (T
			      <PERFORM ,V?EXAMINE ,CEILING>)>
		       <RTRUE>)
		      (T
		       <TELL "The sky is an inky black." CR>)>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

;<ROUTINE V-LOVE ()
	 <TELL "Not difficult, considering how lovable" T ,PRSO " ">
	 <COND (<FSET? ,PRSO ,PLURALBIT>
		<TELL "are">)
	       (T
		<TELL "is">)>
	 <TELL ,PERIOD>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

<ROUTINE V-MAKE ()
	 <COND (<GET ,P-OFW 0>
		<TELL
"[Use the word \"out.\" For example, MAKE A VIRTUE OUT OF NECESSITY.]">)
	       (T
		<TELL ,YOU-CANT "just make" A ,PRSO " out of thin air.">)>
	 <CRLF>
	 <RTRUE>>

<ROUTINE V-MAKE-OBJECT-DRINK ()
	 <COND (<AND ,PRSI
		     <NOT <PRSI? ,WATER>>>
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "But" T ,PRSO " isn't particularly thirsty." CR>)
	       (T
		<IMPOSSIBLES>)>> 

;<ROUTINE V-MAKE-LOVE ()
	 <COND (<PRSO? ,LOVE>
		<PERFORM ,V?FUCK ,PRSI>
		<RTRUE>)
	       (T
		<RECOGNIZE>)>>

;<ROUTINE V-MAKE-OUT ("AUX" KISSEE)
	 <COND (<NOT <PRSO? ,ROOMS>>
		<SET KISSEE ,PRSO>)
	       (<NOT <SET KISSEE <FIND-IN ,HERE ,ACTORBIT "with">>>
		<SET KISSEE ,ME>)>
	 <PERFORM ,V?KISS .KISSEE>
	 <RTRUE>>

<ROUTINE V-MAKE-WITH ()
	 <COND (<AND <PRSO? ,SMOCK>
		     <NOUN-USED ,SMOCK ,W?TALK>>
		<PERFORM ,V?TELL ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?SET ,PRSI ,PRSO>
		<RTRUE>)>>

;<ROUTINE V-MARRY ()
	 <TELL "I doubt that" T ,PRSO " is the marrying type." CR>>

;<ROUTINE V-MASTURBATE ()
	 <COND (<AND ,PRSO ;"for JERK OFF OBJECT (FIND RLANDBIT)"
		     <NOT <PRSO? ,ROOMS>>>
		<RECOGNIZE>)
	       (<EQUAL? ,NAUGHTY-LEVEL 0>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Don't you know that this causes blindness?" CR>)
	       (T
		<PERFORM ,V?FUCK ,ME>
		<RTRUE>)>>

<ROUTINE V-MEET ()
	 <PERFORM ,V?TELL ,PRSO>
	 <RTRUE>>

;<ROUTINE V-MEASURE ()
	 <COND (<OR <FSET? ,PRSO ,PARTBIT>
		    <PRSO? ,ME>>
		<TELL "Usual size." CR>)
	       (T
	 	<TELL "The same size as any other " D ,PRSO ,PERIOD>)>>

;<ROUTINE V-MOAN ()
	 <TELL "\"Ohhhh...\"" CR>>

<ROUTINE V-MOVE ()
	 <COND (<AND <EQUAL? ,P-PRSA-WORD ,W?LEAD>
		     <EQUAL? <GET ,P-NAMW 0> ,W?HOUSE>>
		<PUT ,P-ADJW 0 ,W?LEAD>
		<PUT ,P-NAMW 0 ,W?HOUSE>
		<PERFORM ,V?NO-VERB ,HOUSE>
		<RTRUE>)
	       (<HELD? ,PRSO>
		<WASTES>)
	       (<FSET? ,PRSO ,INTEGRALBIT>
		<PART-OF>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<AND ,PRSI
		     <FSET? ,PRSO ,ACTORBIT>>
		<TELL "Now," T ,PRSO "'s stubborn as a mule." CR>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving" T ,PRSO " reveals nothing." CR>)
	       (<EQUAL? ,P-PRSA-WORD ,W?PULL>
		<HACK-HACK "Pulling">)
	       (T
		<CANT-VERB-A-PRSO "move">)>>

<ROUTINE V-MUNG ()
         <HACK-HACK "Trying to destroy">>

<ROUTINE V-NO ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<COND (<FSET? ,MANTEL ,HEARDBIT>
		       <TELL 
"No? Oh, I think it would look ">
		       <ITALICIZE "wonderful">
		       <TELL " there">)
		      (T
		       <TELL "Yes, yes.... I'd tend to agree with you">)>
		<TELL ,PERIOD>)
	       (T
		<YOU-SOUND "nega">)>>

<ROUTINE V-NO-VERB ()
	 <COND ;(,PRSI       ;"generic prso is horn"
		<COND (<AND <EQUAL? <GET ,P-NAMW 0> ,W?POSSESSION>
		            <EQUAL? <GET ,P-NAMW 1> ,W?NINE-TENTHS ,W?LAW>>
		       <COND (<AND <FSET? ,HORN ,TRYTAKEBIT>
			           <EQUAL? ,HERE ,SQUARE>>
		              <PERFORM ,V?TAKE ,HORN> ;"generic prso is horn" 
		              <RTRUE>)
			     (T
			      <TELL "Sometimes, yes." CR>)>)
		      (T
		       <RECOGNIZE>)>)
	       (<NOUN-USED ,ME ,W?I>
		<V-INVENTORY>)
	       (,TRANS-PRINTED
		<RTRUE>)
	       (,TURN-KLUDGE       ;"PRSO"
		<TELL "It seems" T ,PRSO " doesn't change." CR>)
	       (<AND <EQUAL? ,SCENE ,AISLE>
		     <PRSO? ,DESSERTS>
		     <OR <NOUN-USED ,DESSERTS ,W?DESSERT ,W?DESSERTS>
			 <NOUN-USED ,DESSERTS ,W?DESS>
			 <ADJ-USED ,DESSERTS ,W?DESS>>>
		<SETG REAL-AISLE ,DESSERT-ROOM>
		<PERFORM ,V?WALK-TO ,AISLE>
		<RTRUE>)
	       (<AND <PRSO? ,START-OBJ>
		     <NOUN-USED ,START-OBJ ,W?BEGIN ,W?BEGINNING>>
		<RE-BEGIN>
		<RTRUE>)
	       (<AND <FSET? ,PRSO ,SCENEBIT>
		     <NOT <EQUAL? ,PRSO ,SCENE>>>
		<CANT-GET-THERE>)
	       (<FSET? ,PRSO ,SCENEBIT>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (,ORPHAN-FLAG
		<COND (<EQUAL? ,ORPHAN-FLAG ,CELLAR>
		       <COND (<NOT <VISIBLE? ,PRSO>>
			      <CANT-SEE ,PRSO>)
			     (T
			      <PERFORM ,V?BUY ,PRSO>
			      <RTRUE>)>)
		      (<EQUAL? ,ORPHAN-FLAG ,REST-TABLE>
		       <COND (<NOT <VISIBLE? ,PRSO>>
			      <CANT-SEE ,PRSO>)
			     (T
			      <PERFORM ,V?TURN-OBJECT-ON ,REST-TABLE ,PRSO>
			      <RTRUE>)>)
		      (<AND <EQUAL? ,ORPHAN-FLAG ,NEEDLE>
		            <EQUAL? ,PRSO ,NEEDLE>>
		       <PERFORM ,V?SEARCH-OBJECT-FOR ,HAYSTACK ,PRSO>
		       <RTRUE>)
		      (<EQUAL? ,ORPHAN-FLAG ,SMOCK>
		       <PUT ,P-NAMW 0 ,W?TALK>
		       <PERFORM ,V?MAKE-WITH ,SMOCK ,PRSO>
		       <RTRUE>)
		      (<EQUAL? ,ORPHAN-FLAG ,HATCHET>
		       <PERFORM ,V?BURY ,HATCHET ,PRSO>
		       <RTRUE>)
		      (<AND <EQUAL? ,ORPHAN-FLAG ,SHOULDER>
			    <EQUAL? ,PRSO ,SHOULDER>>
		       <SETG ORPHAN-FLAG <>>
		       <UPDATE-SCORE>
		       <TELL "The crowd eats it up." CR>)
		      (<EQUAL? ,ORPHAN-FLAG ,LOUIS-CHAIR>
		       <UPDATE-SCORE>
		       <COND (<EQUAL? ,PRSO ,LOUIS-CHAIR>
			      <ITALICIZE "Give">
			      <FCLEAR ,LOUIS-CHAIR ,TRYTAKEBIT>
			      <TELL 
" the " D ,LOUIS-CHAIR " to you -- never! Well, yes, you may borrow it. I don't even want to ">
		              <ITALICIZE "know">
		              <TELL " what you're going to use it for." CR>)
			     (<EQUAL? ,PRSO ,OLD-BOTTLE>
			      <PERFORM ,V?TAKE ,OLD-BOTTLE>
			      <RTRUE>)
			     (<NOT <VISIBLE? ,PRSO>>
			      <CANT-SEE ,PRSO>)
			     (<FSET? ,PRSO ,TAKEBIT>
			      <TELL "It's yours for the taking." CR>)
			     (T
			      <IMPOSSIBLES>)>)
		      (T
		       <WASTES>)>)
	       (<NOT <VISIBLE? ,PRSO>>
		<CANT-SEE ,PRSO>)
	       ;(<FSET? ,PRSO ,ACTORBIT> 
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)
	       (,P-CONT
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)
	       (T
		;<TELL "[Examine" T ,PRSO "]" CR CR>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)>>

<GLOBAL ORPHAN-FLAG <>> ;"object associated with an orphan question"

<ROUTINE I-ORPHAN ()
	 <SETG ORPHAN-FLAG <>>
	 ;<COND (<EQUAL? ,ORPHAN-FLAG ,SHOULDER>)>
		
	 <RFALSE>>

<ROUTINE NO-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?NO ,W?NOPE>
		    <EQUAL? .WRD ,W?NAH ,W?UH-UH>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <FCLEAR ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now off." CR>
		       ;<NOW-DARK?>)
		      (T
		       <TELL "It isn't on!" CR>)>)
	       (T
		<CANT-TURN "ff">)>>

<ROUTINE V-ON ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Hopefully, your sexy body will do the trick." CR>)
	       (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now on." CR>
		       ;<NOW-LIT?>)>)
	       (T
		<CANT-TURN "n">)>>

<ROUTINE CANT-TURN (STRING)
	 <TELL ,YOU-CANT "turn that o" .STRING ,PERIOD>>

<ROUTINE V-OPEN ()
	 <COND (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,VEHBIT>>
		<IMPOSSIBLES>)
	       (<AND <FSET? ,PRSO ,OPENBIT>
		     <NOT <NOUN-USED ,CRANK ,W?CRANK>>
		     <NOT <FSET? ,PRSO ,LOCKEDBIT>>> ;"for shining-door"
		<TELL ,ALREADY-IS>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <AND <EQUAL? ,PRSO ,SAFE>
			 <FSET? ,SAFE ,LOCKEDBIT>>>
		<COND (<FSET? ,PRSO ,LOCKEDBIT>
		       <TELL "The " D ,PRSO " is locked." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <TELL "The " D ,PRSO " swings open." CR>)>)
	       (<FSET? ,PRSO ,CONTBIT>
		<FSET ,PRSO ,OPENBIT>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (<OR <NOT <FIRST? ,PRSO>>
			   <FSET? ,PRSO ,TRANSBIT>>
		       <TELL "Opened." CR>)
		      (T
		       <TELL "Opening" T ,PRSO " reveals">
		       <COND (<NOT <D-NOTHING>>
			      <TELL ,PERIOD>)>
		       ;<NOW-LIT?>)>)
	       (T
		<CANT-VERB-A-PRSO "open">)>>

<ROUTINE V-PASS ()
	 <COND (<HELD? ,PRSO>
		<TELL ,YOULL-HAVE-TO "say who you want to pass it to." CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-PAY ()
	 <COND (<HELD? ,PENNY>
		<COND (<PRSO? ,PIPER>
		       <PERFORM ,V?BUY-IN ,PIG ,CAT-BAG>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?GIVE ,PENNY ,PRSO>
		       <RTRUE>)>)
	       ;(<HELD? ,TEN-MARSMID-COIN>
		<PERFORM ,V?GIVE ,TEN-MARSMID-COIN ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have no money!" CR>)>>

;<ROUTINE V-PHONE ()
	 <COND (<EQUAL? ,HERE ,VIZICOMM-BOOTH>
		<V-CALL>)
	       (T
		<TELL ,YOU-CANT-SEE-ANY "phone here!" CR>)>>

<ROUTINE V-PICK ()
	 <CANT-VERB-A-PRSO "pick">>

<ROUTINE V-PICK-UP ()
	 <PERFORM ,V?TAKE ,PRSO ,PRSI>
	 <RTRUE>>

<ROUTINE V-PIN ()
	 <COND (<NOT <HELD? ,NEEDLE>>
		<TELL "You may be on pins and needles, but you have none." CR>)
	       (T
		<V-POINT>)>>

<ROUTINE V-PLAY ()
	 <COND (<EQUAL? <GET ,P-NAMW 0> ,W?JACK ,W?JACKS>
		<COND (<EQUAL? ,SCENE ,JOAT>
		       <TELL "You already are." CR>)
		      (T
		       <CANT-GET-THERE>)>)
	       (T
		<CANT-VERB-A-PRSO "play">)>>

<ROUTINE V-PLUG ()
	 <IMPOSSIBLES>>

<ROUTINE V-POINT ()
	 <TELL "That would be pointless." CR>>

<ROUTINE V-POSSESSION ()
	 <COND (<AND <PRSO? ,ROOMS ,LAWS>
		     <FSET? ,HORN ,TRYTAKEBIT>
		     <EQUAL? ,HERE ,SQUARE>>
		<PUT ,P-NAMW 0 ,W?POSSESSION>
		<PERFORM ,V?TAKE ,HORN>
		<RTRUE>)
	       (<PRSO? ,ROOMS>
		<TELL "If you want something take it." CR>)
	       (T
		<TELL "Not necessarily." CR>)>>
		    

<ROUTINE PRE-POUR ()
	 <RFALSE> 
	 ;<COND (<IN-SPACE?>
		<TELL "There's no gravity!" CR>)>>

<ROUTINE V-POUR ()
	 <IMPOSSIBLES>>

<ROUTINE V-PULL-OVER ()
	 <HACK-HACK "Pulling">>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing">>

<ROUTINE V-PUSH-DIR ()
	 <COND (<PRSI? ,INTDIR>
		<V-PUSH>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-PUSH-OFF ()
	 ;<COND (<AND <PRSO? ,ROOMS ,DOCK-OBJECT ,RAFT ,BARGE>
		     <NOT <IN? ,PROTAGONIST ,HERE>>>
		<PERFORM ,V?LAUNCH <LOC ,PROTAGONIST>>
		<RTRUE>)>
	       
		<TELL ,HUH>>

<ROUTINE PRE-PUT ()
	 <COND (<PRSI? ,GROUND>
		<COND (<AND <EQUAL? ,HERE ,ATTIC>
			    <NOT <FSET? ,ATTIC ,PHRASEBIT>>>
		       <RFALSE>)>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<AND <PRSI? ,CEILING>
		     <EQUAL? ,HERE ,ATTIC>
		     <NOT <FSET? ,ATTIC ,PHRASEBIT>>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<PRSO? ,HANDS>
		<COND (<AND <VERB? PUT-ON PUT>
			    <FSET? ,PRSI ,PARTBIT>>
		       <RFALSE>)
		      (<VERB? PUT>
		       <PERFORM ,V?REACH-IN ,PRSI>
		       <RTRUE>)
		      (T
		       <IMPOSSIBLES>)>)
	       ;(<AND <NOT <FSET? ,PRSI ,PARTBIT>>
		     <PLAYER-CANT-SEE>>		     
		<RTRUE>)
	       (<HELD? ,PRSI ,PRSO>
		;<COND (<AND <PRSO? ,BABY>
			     <PRSI? ,BLANKET>>
			<TELL ,ALREADY-IS>)>		      
		<TELL ,YOU-CANT "put" T ,PRSO>
		<COND (<EQUAL? <GET ,P-ITBL ,P-PREP2> ,PR?ON>
		       <TELL " on">)
		      (T
		       <TELL " in">)>
		<TELL T ,PRSI " when" T ,PRSI " is already ">
		<COND (<FSET? ,PRSO ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSO "!" CR>)
	       ;(<AND <VERB? PUT-ON>
		     <PRSO? ,SOD>
		     <PRSI? ,HOLE>>
		<RFALSE>)
	       (<UNTOUCHABLE? ,PRSI>
		<CANT-REACH ,PRSI>)
	       (,IN-FRONT-FLAG  ;"you dont have to have it"
		<PERFORM ,V?PUT-IN-FRONT ,PRSO ,PRSI>
		<RTRUE>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-PUT ()
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL ,YOU-CANT "put" T ,PRSO " in" A ,PRSI "!" CR>)
	       (<OR <PRSI? ,PRSO>
		    <AND <HELD? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<TELL "How can you do that?" CR>)
	       (<FSET? ,PRSI ,DOORBIT>
		<TELL ,CANT-FROM-HERE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<THIS-IS-IT ,PRSI>
		<DO-FIRST "open" ,PRSI>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "But" T ,PRSO " is already in" TR ,PRSI>)
	       (<FSET? ,PRSI ,ACTORBIT>
		    ;<PRSI? ,STALLION ,BABY>
		<TELL ,HUH>)
	       (<AND <G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
			    <GETP ,PRSI ,P?SIZE>>
		    	 <GETP ,PRSI ,P?CAPACITY>>
		     <NOT <HELD? ,PRSO ,PRSI>>>
		<TELL "There's no room ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSI " for" TR ,PRSO>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       ;(<AND <OR <PRSO? ,TORCH>
			 <HELD? ,TORCH ,PRSO>>
		     <FSET? ,TORCH ,ONBIT>
		     <PRSI? ,BASKET ,SACK>>
		<DO-FIRST "extinguish" ,TORCH>)
	       ;(<IN? ,PRSI ,ODD-MACHINE>
		<TELL ,ONLY-ONE-THING-IN-COMPARTMENT>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-AGAINST ()
	 <WASTES>>

<ROUTINE V-PUT-BEHIND ()
	 <WASTES>>

<ROUTINE V-PUT-IN-FRONT ()
	 <WASTES>>

<ROUTINE V-PUT-NEAR ()
	 <WASTES>>

<ROUTINE V-PUT-ON ()
	 <COND (<PRSI? ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (<AND <FSET? ,PRSI ,ACTORBIT>
		     <FSET? ,PRSO ,WEARBIT>>
		<TELL "But it's not" T ,PRSI"'s size." CR>)
	       (T
		<TELL "There's no good surface on" TR ,PRSI>)>>

<ROUTINE V-PUT-THROUGH ()
	 <COND (<FSET? ,PRSI ,DOORBIT>
		<COND (<FSET? ,PRSI ,OPENBIT>
		       <V-THROW>)
		      (T
		       <DO-FIRST "open" ,PRSI>)>)
	       (<AND <PRSI? <LOC ,PROTAGONIST>>
		     <EQUAL? ,P-PRSA-WORD ,W?THROW ,W?TOSS ,W?HURL>>
		<SETG PRSI <>>
		<V-THROW>)
	       (T
	 	<IMPOSSIBLES>)>>

<ROUTINE V-PUT-TO ()
	 <WASTES>>

<ROUTINE V-PUT-UNDER ()
         <WASTES>>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Playing in this way with">>

;<ROUTINE RETURN-TRUE>

<ROUTINE PRE-RAKE ()
	 <COND (<NOT <HELD? ,RAKE>>
		<TELL ,YNH " a rake." CR>)>>

<ROUTINE V-RAKE ()
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,RAKE>)>
	 <COND (<PRSI? ,RAKE>
		<WASTES>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-RAKE-OVER ()
	 <TELL "That would be excessively rakish behavior." CR>>

;<ROUTINE V-RAPE ()
	 <TELL "Unacceptably ungallant behavior." CR>>

<ROUTINE V-SRIDE-OBJECT-TO () ;"go to market in cart"
	 <PERFORM ,V?RIDE-OBJECT-TO ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-RIDE-OBJECT-TO ()
	 <COND (<NOT <IN? ,PROTAGONIST ,PRSO>> ;"ride obj to obj"
		<PERFORM ,V?BOARD ,PRSO>
		<COND (<IN? ,PROTAGONIST ,PRSO>
		       <PERFORM ,V?WALK-TO ,PRSI>)>
		<RTRUE>)
	       (T
		<PERFORM ,V?WALK-TO ,PRSI> ;"ride obj to obj" 
		<RTRUE>)>>

<ROUTINE V-RIDE-TO ("AUX" V)
	 <COND (<EQUAL? <LOC ,PROTAGONIST> ,CART ,ICICLE>
		<PERFORM ,V?WALK-TO ,PRSO>)
	       ;(<SET V <FIND-IN ,HERE ,VEHBIT>>
		    ;<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<PERFORM ,V?BOARD .V>
		<COND (<AND <IN? ,PROTAGONIST .V>
			    <EQUAL? .V ,CART ,ICICLE>>
		       <PERFORM ,V?WALK-TO ,PRSO>)>)
	       (T
		<TELL "There's nothing to ride." CR>)>
	 <RTRUE>>
		      
<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<OR <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,SURFACEBIT>
		    <NOT <FSET? ,PRSO ,CONTBIT>>>
		<YUKS>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<DO-FIRST "open" ,PRSO>)
	       (<OR <NOT .OBJ>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL ,THERES-NOTHING "in" TR ,PRSO>)
	       (T
		<TELL "You feel something inside" TR ,PRSO>)>>

<ROUTINE V-READ ()
	 <COND (<FSET? ,PRSO ,READBIT>
		<TELL "[PLACEHOLDER]" ;<GETP ,PRSO ,P?TEXT> CR>)
               (T
                <CANT-VERB-A-PRSO "read">)>>

<ROUTINE V-READ-BETWEEN ()
	 <CANT-VERB-A-PRSO "read between">>

<ROUTINE V-SREAD-TO ()
	 <PERFORM ,V?READ-TO ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-READ-TO ()
	 <COND (<OR <NOT <FSET? ,PRSO ,READBIT>>
		    <NOT <FSET? ,PRSI ,ACTORBIT>>>
		<IMPOSSIBLES>)
	       (T
		<TELL "Nice voice, but" T ,PRSO " is not soothed." CR>)>>

;<ROUTINE V-RELIEVE ()
	 <TELL ,HUH>>

<ROUTINE V-REMOVE ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)
	       ;(<AND <PRSO? ,HANDS>
		     ,HAND-COVER>
		<PERFORM ,V?UNCOVER ,HAND-COVER>
		<RTRUE>)
	       ;(<AND <PRSO? ,HANDS>
		     ,RAFT-HELD>
		<PERFORM ,V?DROP ,RAFT>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-REVOLVE ("AUX" X)
	 <COND (<NOT <HELD? ,REVOLUTION>>
		<TELL ,YNH AR ,REVOLUTION>)
	       (<OR <AND <PRSO? ,GLOBAL-ROOM>
			 <EQUAL? ,HERE ,ATTIC>>
		    <AND <PRSO? ,DUELING>
		         <NOUN-USED ,DUELING ,W?ATTIC>>>		    
		<REMOVE ,REVOLUTION>
		<UPDATE-SCORE>
		<FSET ,ATTIC ,PHRASEBIT>
		<QUEUE I-END-SCENE 1>
		<TELL 
"You get that long, drawn-out sudden feeling of movement in the pit of your
stomach as the attic begins tilting straight up to one side, and it continues
tilting until you're in a figurative sense literally climbing the walls
and fall...|
|
\"CRUNCH!\" Your shoulders slam softly against the hardwood floor">
		<ROB ,PROTAGONIST ,HERE>
		<COND (<G? <CCOUNT ,PROTAGONIST> 1>
		       <TELL 
", and your belongings scatter neatly into a pile next to you">)
		      (<SET X <FIRST? ,PROTAGONIST>>
		       <TELL 
", and" T .X " breaks its fall by landing on you">)>
		<TELL 
". Wobbly but with steadiness, you regain your feet. Wait! You can hear the
screeching voices of disembodied spirits converge in a fright and then
around the entrance to the manor, and then grow faint in the distance." CR>)
	       (T
		<TELL
"What goes around comes around, and so it goes with" T ,PRSO ", which ends
up in exactly the same spot as it was before." CR>)>>

<ROUTINE V-RETURN ("AUX" ACTOR)
	 <COND (<NOT ,PRSI>
		<COND (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT "to">>
		       <PERFORM ,V?GIVE ,PRSO .ACTOR>
		       <RTRUE>)
		      (T
		       <NO-ONE-HERE "return it to">)>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-RIDDLE ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?FIDDLE>
		<WASTES>)
	       (<VISIBLE? ,RIDDLE-BOOK>
		<PERFORM ,V?READ ,RIDDLE-BOOK>
		<RTRUE>)
	       (,PRSI
		<RECOGNIZE>)
	       (T
		<CANT-SEE <> "book">)>>

;<ROUTINE V-RIP ()
	 <COND (<PRSO? ,SCRAP-OF-PAPER ,CODED-MESSAGE ,MATCHBOOK ,MAP>
		<WASTES>)
	       (T
	 	<TELL "Unrippable." CR>)>>

<ROUTINE V-ROLL ()
	 <TELL "A rolling " D ,PRSO " gathers no moss." CR>>

<ROUTINE V-RUB ()
	 <PERFORM ,V?TOUCH ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SAVE-SOMETHING ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?HELP>
		<TELL "Sorry, but" T ,PRSO " is beyond help." CR>)
	       (T
		<PERFORM ,V?HINT>
		<RTRUE>)>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<AND ,AWAITING-REPLY
		     <YES-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-YES>
		<STOP>)
	       (<AND ,AWAITING-REPLY
		     <NO-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-NO>
		<STOP>)
	       ;(<RUNNING? ,I-SNEEZE>
		<RIDDLE-ANSWER>)
	       ;(<IN? ,HAREM-GUARD ,HERE>
		<PICK-WIFE>)
	       ;(<EQUAL? <GET ,P-LEXV ,P-CONT> ,W?KWEEPA>
		<V-KWEEPA>
		<STOP>)	       
	       (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "You must address" T .V " directly." CR>
		<STOP>)
	       (T
		<PERFORM ,V?TELL ,ME>
		<STOP>)>>

<ROUTINE V-SCORE ("AUX" SC (SOME <>) (NUM 0))
	 <REPEAT ()
		 ;"Mayor scene not in rank table"
		 <SET SC <PICK-NEXT ,RANK-TABLE>>
		 <COND (<EQUAL? .NUM 7>
			<RETURN>)
		       (<NOT <ZERO? <GETP .SC ,P?SCENE-SCORE>>>
			<SET SOME T>
			<TELL-SCORE .SC>
			<CRLF>)>
		 <SET NUM <+ .NUM 1>>>
	 <COND (<NOT <ZERO? <GETP ,EIGHT ,P?SCENE-SCORE>>>
		<SET SOME T>
		<TELL-SCORE ,EIGHT>
		<CRLF>)>
	 <COND (<NOT .SOME>
		<TELL "Zero." CR>)>
	 <RTRUE>>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<V-SHAKE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<D-VEHICLE>)
	       (<OR <FSET? ,PRSO ,SCENEBIT>
		    <EQUAL? ,PRSO ,GRAIN>>
		<TELL ,NOTHING-NEW>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<DO-FIRST "open" ,PRSO>)
	       (<FSET? ,PRSO ,CONTBIT>
		<TELL "You find">
		<COND (<NOT <D-NOTHING>>
		       <TELL ,PERIOD>)>
		<RTRUE>)
	       (T
		<CANT-VERB-A-PRSO "search">)>>

<ROUTINE V-SSEARCH-OBJECT-FOR ()
	 <PERFORM ,V?SEARCH-OBJECT-FOR ,PRSI, PRSO>
	 <RTRUE>>

<ROUTINE V-SEARCH-OBJECT-FOR ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?SEARCH ,PRSO>
		<RTRUE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<DO-FIRST "open" ,PRSO>)
	       (<OR <IN? ,PRSI ,PRSO>
		    <IN? ,PRSI ,HERE>>
		<TELL "Very observant. There "
			<COND (<FSET? ,PRSI ,FEMALEBIT> "she")
			      (<FSET? ,PRSI ,ACTORBIT> "he")
			      (T "it")>
			" is." CR>)
	       (T 
		<TELL "You don't find" T ,PRSI " there." CR>)>>

<ROUTINE V-SEARCH-WITH ()
	 ;<COND (<PRSI? ,COMB>
		<PERFORM ,V?SEARCH ,PRSO>
		<RTRUE>)>
	 <TELL 
"It seems that" T ,PRSI " is no help in searching" TR ,PRSO>>

<ROUTINE V-SSET ()      ;"make obj out of obj"
	 <PERFORM ,V?SET ,PRSI ,PRSO>
	 <RTRUE>>

<GLOBAL TURN-KLUDGE <>>

<ROUTINE PRE-SET ()
	 <COND (<AND <EQUAL? ,P-PRSA-WORD ,W?TURN ,W?MAKE>
		     ,PRSI
		     <GETP ,PRSO ,P?OLDDESC>>
		<PUT ,P-NAMW 0 <GET ,P-NAMW 1>>
		<PUT ,P-ADJW 0 <GET ,P-ADJW 1>>
		<SETG TURN-KLUDGE T>
		<PERFORM ,V?NO-VERB ,PRSI>
		<SETG TURN-KLUDGE <>>
		<RTRUE>)>>		
		
<ROUTINE V-SET ()
	 <COND (<PRSO? ,ROOMS>
		<WEE>)
	       (<NOT ,PRSI>
		<COND (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?AROUND>
		       <PERFORM ,V?REVOLVE ,PRSO>
		       <RTRUE>)
		      (<OR <FSET? ,PRSO ,TAKEBIT>
			   <FSET? ,PRSO ,INTEGRALBIT>>
		       <HACK-HACK "Turning">)
		      (T
		       <TELL ,YNH TR ,PRSO>)>)
	       (<EQUAL? ,P-PRSA-WORD ,W?TURN ,W?MAKE>
		<TELL
"It would take more than a turn of phrase to ">
		<COND (<PRSO? ,PRSI>
		       <TELL "do that">)
		      (T
		       <TELL "turn" A ,PRSO " into" A ,PRSI>)>
		<TELL ,PERIOD>) 
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHAKE ("AUX" PERSON)
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "That wouldn't be polite." CR>)
	       ;(<EQUAL? ,PRSO ,HANDS> ;"in hands-f"
		<COND (<SET PERSON <FIND-IN ,HERE ,ACTORBIT "with">>
		       <PERFORM ,V?SHAKE-WITH ,PRSO .PERSON>
		       <RTRUE>)>)
	       (T
		<HACK-HACK "Shaking">)>>

<ROUTINE V-SHAKE-WITH ()
	 <COND (<NOT ,PRSI>
		<PERFORM ,V?SHAKE-WITH ,HANDS ,PRSO>
		<RTRUE>)
	       (<NOT <PRSO? ,HANDS>>
		<RECOGNIZE>)
	       (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "I don't think" T ,PRSI " even has hands." CR>)
	       (T
		<PERFORM ,V?THANK ,PRSI>
		<RTRUE>)>>

<ROUTINE V-SHINE ()
	 <COND (<EQUAL? ,HERE ,CLEARING>
		<PUT ,P-NAMW 0 ,W?DOOR>
		<PERFORM ,V?NO-VERB ,SHINING-DOOR>
		<RTRUE>)
	       (<EQUAL? ,HERE ,SHORE>
		<PUT ,P-NAMW 0 ,W?DOOR>
		<PERFORM ,V?NO-VERB ,RHINES>
		<RTRUE>)
	       (T
		<PERFORM ,V?CLEAN ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SHOCK ()
	 <TELL "How?" CR>>

<ROUTINE V-SHOW ("AUX" ACTOR)
	 <COND (<AND <NOT ,PRSI>
		     <SET ACTOR <FIND-IN ,HERE ,ACTORBIT>>>
		<PERFORM ,V?SHOW ,PRSO .ACTOR>
		<RTRUE>)
	       (<NOT ,PRSI>
		<TELL "There's no one here to show it to." CR>)
	       (T
		<TELL 
"It doesn't look like" T-IS-ARE ,PRSI "interested." CR>)>>

<ROUTINE V-SHUT-UP ()
	 <COND (<PRSO? ,ROOMS>
		<TELL "[I hope you're not addressing me...]" CR>)
	       (T
		<PERFORM ,V?CLOSE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SIGN ()
	 <TELL ,YNH " a writing utensil." CR>>

<ROUTINE V-SINK ()
	 <IMPOSSIBLES>>

<ROUTINE V-SIT ("AUX" VEHICLE)
	 <COND (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
               (T
		<WASTES>)>>

<ROUTINE V-SKIP ()
	 <WEE>>

<ROUTINE V-SLEEP ()
	 <TELL "You're not tired." CR>>

;<ROUTINE PRE-SMELL ()
	 <COND (<AND <FSET? ,NOSE ,MUNGBIT>
		     <NOT ,GONE-APE>>
		<TELL ,YOU-CANT "smell a thing with " 'NOSE " blocked." CR>)>>

<ROUTINE V-SMELL ()
	 <COND (<NOT ,PRSO>
		<TELL "Smells like..." CR>
		<RTRUE>)
	       (T
		<SENSE-OBJECT "smell">)>>

<ROUTINE V-SOW ()
	 <IMPOSSIBLES>>

<ROUTINE SENSE-OBJECT (STRING)
	 <PRONOUN>
	 <TELL " " .STRING>
	 <COND (<AND <NOT <FSET? ,PRSO ,PLURALBIT>>
		     <NOT <PRSO? ,ME>>>
		<TELL "s">)>
	 <TELL " just like" AR ,PRSO>>

<ROUTINE V-SPUT-ON ()
         <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SRUB ()
	 <PERFORM ,V?RUB ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?HOLD> ;"for HOLD UP OBJECT"
		<WASTES>)
	       (<AND <EQUAL? ,P-PRSA-WORD ,W?GET> ;"for GET UP ON OBJECT"
		     ,PRSO
		     <NOT <PRSO? ,ROOMS>>> ;"not GET UP"
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)	       
	       (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		     ;<NOT <EQUAL? <LOC ,PROTAGONIST> ,TREE-HOLE ,CAGE>>
		<PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (<AND ,PRSO
		     <FSET? ,PRSO ,TAKEBIT>
		     <EQUAL? ,P-PRSA-WORD ,W?STAND>>
		<WASTES>)
	       (<AND <NOT <PRSO? ,ROOMS <>>>
		     <NOT <EQUAL? ,P-PRSA-WORD ,W?STAND>>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You're already standing." CR>)>>

<ROUTINE V-STAND-ON ()
	 ;<COND (<PRSO? ,STOOL>
		<PERFORM ,V?BOARD ,STOOL>
		<RTRUE>)>
	       
	  	<WASTES>>

<ROUTINE V-STELL ()
	 <PERFORM ,V?TELL ,PRSI>
	 <RTRUE>>

<ROUTINE V-STHROW ()
	 <PERFORM ,V?THROW-TO ,PRSI ,PRSO>
	 <RTRUE>>

;<ROUTINE V-SUCKLE ()
	 <IMPOSSIBLES>>

;<ROUTINE V-SWHIP ()
	 <PERFORM ,V?WHIP ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SWIM ()
	 <COND (<OR <AND <EQUAL? ,HERE ,SHORE>
		         <NOT ,PRSO>>
		    <AND <EQUAL? ,HERE ,SHORE>
			 <PRSO? ,WATER>>>
		<PERFORM ,V?SWIM ,RHINES>
		<RTRUE>)
	       (<OR <PRSO? ,WATER>
		    <AND <NOT ,PRSO>
		    	 <GLOBAL-IN? ,WATER ,HERE>>>
		<TELL "This is no time for">)
	       (T
		<TELL "Your head must be">)>
	 <TELL " swimming." CR>>

<ROUTINE V-SWING ()
	 <COND (,PRSI
		<PERFORM ,V?KILL ,PRSI ,PRSO>
		<RTRUE>)
	       (T
		<TELL "\"Whoosh.\"" CR>)>>

;"called from syntaxes that switch the prso and prsi"
<ROUTINE PRE-SWITCH ("AUX" I O IA OA)
	 <SET O <GET ,P-NAMW 0>>
	 <SET I <GET ,P-NAMW 1>>
	 <SET OA <GET ,P-ADJW 0>>
	 <SET IA <GET ,P-ADJW 1>>
	 <PUT ,P-NAMW 0 .I>
	 <PUT ,P-NAMW 1 .O>
	 <PUT ,P-ADJW 0 .IA>
	 <PUT ,P-ADJW 1 .OA> 
	 <RFALSE>>		

<ROUTINE V-SWRAP ()
	 <PERFORM ,V?WRAP ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-TAKE ()
	 <COND ;(<AND <NOT <FSET? ,PRSO ,PARTBIT>>
		     <PLAYER-CANT-SEE>>
		<RTRUE>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<FSET? ,PRSO ,INTEGRALBIT>
		     ;<EQUAL? ,PRSI <LOC ,PRSO>>
		<RFALSE>)
	       (<AND <PRSO? ,HOT-TUB>
		     <NOUN-USED ,HOT-TUB ,W?PLUG>>
		<RFALSE>)
	       (<IN? ,PROTAGONIST ,PRSO>		     
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n it!" CR>)
	       (<AND <PRSO? ,HOUSE>
		     <HELD? ,HOUSE>
		     ,LOUSE-ON-HEAD>
		<RFALSE>)
	       ;"moved to ITAKE so obj.s can transform"
	       ;(<OR <IN? ,PRSO ,PROTAGONIST>
		    <AND <HELD? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>
			 <NOT <NOUN-USED ,PRSO ,W?CENT>>>>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You're already wearing">)
		      (T
		       <TELL "You already have">)>
		<TELL T ,PRSO ,PERIOD>)
	       (<NOT ,PRSI>
		<RFALSE>)
	       (<IN? ,PRSO ,PRSI>
		<RFALSE>)
	       (<PRSO? ,ME>
		<PERFORM ,V?DROP ,PRSI>
		<RTRUE>)
	       (<AND <PRSO? ,ICE>
		     <PRSI? ,SIGN>
		     <EQUAL? ,HERE ,NEAR-POND>>
		<RFALSE>)
	       (<AND <PRSO? ,DUCK>
		     <PRSI? ,WATER>>
		<RFALSE>)
	       (<AND <PRSO? ,PAN-OF-KEYS>
		     <PRSI? ,PAN-OF-KEYS>>
		<RFALSE>)
	       (<AND <PRSI? ,SHOULDER>
		     <NOT <EQUAL? <GET ,P-ADJW 1> ,W?MY>>>
		<RFALSE>) ;"FOR, remove chip from her shoulder"
	       (<AND <IN? ,GRAIN-OF-SALT ,LOCAL-GLOBALS>
		     <PRSO? ,SALT-SHAKER> ;"for, GET GRAIN OF SALT FROM SHAKER"
		     <PRSI? ,SALT-SHAKER>>
		<PERFORM ,V?SHAKE ,SALT-SHAKER>
		<RTRUE>)
	       (<PRSI? ,FARM> ;"lead horse out of barn"
		<RFALSE>)
	       (<NOT <IN? ,PRSO ,PRSI>>
		<NOT-IN>)
	       (T
		<SETG PRSI <>>
		<RFALSE>)>>

<ROUTINE V-TAKE ()
	 <COND (<NOT <EQUAL? <ITAKE T> ,M-FATAL <>>>
		<TELL "Taken." CR>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND ;(<PRSO? ,ROOMS>
	        <TELL >
	        <RTRUE>)
	       (<FSET? ,PRSO ,WORNBIT>
		<FCLEAR ,PRSO ,WORNBIT>
		<THIS-IS-IT ,PRSO>
		<TELL "You remove" TR ,PRSO>)
	       (<EQUAL? ,P-PRSA-WORD ,W?SHAKE>
		<COND (<FSET? ,PRSO ,PARTBIT>
		       <TELL 
"You shake it just about until you break it, but" T ,PRSO ", though numbed,
stays attached." CR>)
		      (T
		       <IMPOSSIBLES>)>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You aren't wearing" TR ,PRSO>)>>

<ROUTINE V-TAKE-UNDER ()
	 <TELL "That phrase have the right ring to it." CR>>

<ROUTINE V-TAKE-WITH ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL ,YNH TR ,PRSO>)
	       (<PRSI? ,GRAIN-OF-SALT ,SALT-SHAKER>
		<TELL 
"Taking" T ,PRSO " lightly is par for the course, but it doesn't seem
to affect" T ,PRSI " one iota." CR>)
	       (T
		<TELL "Sorry," T-IS-ARE ,PRSI "no help in getting" TR ,PRSO>)>>

<ROUTINE V-TASTE ()
	 <SENSE-OBJECT "taste">>

<ROUTINE V-STEACH ()
	 <PERFORM ,V?TEACH ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-TEACH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<WASTES>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE PRE-TELL ()
	 ;"was word AND, not a comma. EG, MINCE AND STAKE"
	 <COND (<AND ,AND-FLAG
		     <NOT <EQUAL? ,PRSO ,HAZING>>>  
		;<PREGNANT>
		<TELL "You can't use \"and\" that way." CR> 
		<STOP>)
	       (<AND ,PICKED-FLAG
		     <NOT <EQUAL? ,PRSO ,PIPER>>>
		<RECOGNIZE>)
	       (<AND <NOT <FSET? ,PRSO ,ACTORBIT>>
		     <NOT <PRSO? ,MAN-WOMAN ,HAZING ,ME>>>
		<V-TELL>
		<STOP>)>>

<ROUTINE V-TELL ()
	 <COND (<OR <FSET? ,PRSO ,ACTORBIT>
		    <PRSO? ,ME ,HAZING>> ;"jack and the bean stalk"
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG CLOCK-WAIT T>
		       <RTRUE>)
		      (T
		       <TELL
"Hmmm..." T ,PRSO " looks at you expectantly,
as if you seemed to be about to talk." CR>)>)
	       (T
	        <CANT-VERB-A-PRSO "talk to">
	        <STOP>)>>

<ROUTINE V-TELL-ABOUT ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?WHAT ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?SHOW ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-THANK ()
	 <COND (<NOT ,PRSO>
		<TELL "[Just doing my job.]" CR>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL
"It seems" T ,PRSO " is unmoved by your politeness." CR>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-THROW ()
	 <COND (<NOT <SPECIAL-DROP>>
	 	<COND ;(<EQUAL? ,HERE ,CANAL>
		       <PERFORM ,V?PUT ,PRSO ,CANAL-OBJECT>
		       <RTRUE>)
		      (,PRSI
		       <MOVE ,PRSO ,HERE>
		       <TELL "You missed." CR>)
		      (T
		       <MOVE ,PRSO ,HERE>
		       <THIS-IS-IT ,PRSO>
		       <TELL "Thrown." CR>)>)>>

;"idrop is not called first for v-throw-out"
<ROUTINE V-THROW-OUT ()
	 <COND (<OR <EQUAL? <GET ,P-ITBL ,P-PREP2> ,PR?WITH>
		    <NOT <GET ,P-ITBL ,P-PREP2> ,W?OF>>
		<V-TAKE-UNDER>
		;<PERFORM ,V?THROW ,PRSO>
		;<CRLF>
		;<PERFORM ,V?THROW ,PRSI>
		;<RTRUE>)
	       (T
		<PERFORM ,V?PUT-THROUGH ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-THROW-TO ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?THROW ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-TIE ()
	 <TELL "You can't tie" TR ,PRSO>>

<ROUTINE V-TIE-TOGETHER ()
	 <IMPOSSIBLES>>

<ROUTINE PRE-TOUCH ()
	 <COND (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>
		<RTRUE>)
	       (<AND <VERB? TOUCH>
		     ,PRSI
		     <NOT <HELD? ,PRSI>>>
		<TELL ,YNH TR ,PRSI>)
	       (<AND <VERB? TOUCH>
		     <PRSI? ,NEEDLE>>
		<PERFORM ,V?KILL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-STOUCH ()
	 <PERFORM ,V?TOUCH ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-TOUCH ()
	 <COND (<LOC-CLOSED>
		<RTRUE>)
	       (<AND <EQUAL? ,P-PRSA-WORD ,W?POKE>
		     <OR <FSET? ,PRSO ,ACTORBIT>
			 <PRSO? ,CAT-BAG>>>
		<TELL
"That'd be worse than a poke in the eye with a sharp stick." CR>)
	       (<PROB 30>
		<HACK-HACK "Touching">)
	       (<PROB 40>
		<HACK-HACK "Keeping in touch with">)
	       (T
		<HACK-HACK "Putting the touch on">)>>

<ROUTINE V-TURN-OBJECT-ON ()
	 <IMPOSSIBLES>>

<ROUTINE V-UNLOCK ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?UNLOX>
		<COND (<AND <NOT <FSET? ,LOCKS ,OLDBIT>>
		            <VISIBLE? ,LOCKS>>
		       <PERFORM ,V?TAKE ,LOCKS>
		       <RTRUE>)
		      (T
		       <CANT-SEE <> "lox">)>)
	       (,PRSI
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,LOCKEDBIT>
		;<SETG AWAITING-REPLY 2>
		;<QUEUE I-REPLY 2>
		<TELL 
"You must indicate what to unlock" T ,PRSO " with." CR>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <EQUAL? ,PRSO ,SAFE>>
		<TELL "But" T ,PRSO " isn't locked." CR>)
	       (T
		<YUKS>)>>

<ROUTINE V-UNPLUG ()
	 <IMPOSSIBLES>>

<ROUTINE V-UNTIE ()
	 <IMPOSSIBLES>>

<ROUTINE V-UPSET ()
	 <TELL "Well," T ,PRSO " doesn't seem too upset." CR>>

<ROUTINE V-USE ()
	 <TELL
,YOULL-HAVE-TO "be more specific about how you want to use" TR ,PRSO>>

;<ROUTINE V-USE-QUOTES ()
	 <COND (<IN? ,HAREM-GUARD ,HERE>
		<PICK-WIFE ,PRSO>)
	       (T
	 	<SEE-MANUAL "say something \"out loud.\"">)>>

<ROUTINE V-VENT ()
	 <COND (<AND <FSET? ,PRSI ,ACTORBIT>
		     <PRSO? ,SPLEEN>>
		<PERFORM ,V?KILL ,PRSI>
		<RTRUE>)
	       (T
		<IMPOSSIBLES>)>>

;<ROUTINE V-VOMIT ()
	 <COND (<AND <IN? ,PIZZA ,HERE>
		     <FSET? ,PIZZA ,TOUCHBIT>>
		<TELL "Just keep trying to eat that " D ,PIZZA ,PERIOD>)
	       (T
		<TELL
"You stick a finger down your throat, but to no avail." CR>)>>

<ROUTINE V-WALK ("AUX" AV VEHICLE PT PTS STR OBJ RM)
	 <SET AV <LOC ,PROTAGONIST>>
	 <COND (<NOT ,P-WALK-DIR>		     
		;<PERFORM ,V?WALK-TO ,PRSO> ;"caused 0 arg bug in pre-walk-to"
		<V-WALK-AROUND>
		<RTRUE>)
	       (<AND <PRSO? ,P?OUT>
		     <IN-EXITABLE-VEHICLE?>>
		<RTRUE>)	        
	       (<AND <PRSO? ,P?IN>
		     <NOT <GETPT ,HERE ,P?IN>>
		     <SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		     <NOT <HELD? .VEHICLE>>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
	       (<FSET? .AV ,VEHBIT>
		     ;<NOT <EQUAL? .AV ,ICICLE>> ;"cant go up to cloud on it"
		 <NOT-GOING-ANYWHERE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <;GETB GET .PT ,REXIT>>) ;"zip to ezip"
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      ;<COND (<EQUAL? .RM ,ROOMS> ;"catacomb fake-move"
				     <RTRUE>)>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <;GETB GET .PT ,REXIT>>) ;"zip to ezip"
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL ,CANT-GO>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <;GETB GET .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <;GETB GET .PT ,REXIT>>) ;"zip to ezip"
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <THIS-IS-IT .OBJ>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <THIS-IS-IT .OBJ>
			      <DO-FIRST "open" .OBJ>
			      <RFATAL>)>)>)
	       (T
		;<COND (<PRSO? ,P?OUT ,P?IN>
		       <V-WALK-AROUND>)
		      (T
		       <TELL ,CANT-GO>)>
		<V-WALK-AROUND>
		<RFATAL>)>>

<ROUTINE V-WATCH-GROW ()
	 <TELL "Well," T ,PRSO " doesn't seem to grow much." CR>>

<ROUTINE NOT-GOING-ANYWHERE ("AUX" AV)
	 <SET AV <LOC ,PROTAGONIST>>
	 <TELL "You're not going anywhere until you get ">
	 <COND (<OFF-VEHICLE? .AV>
		<TELL "off">)
	       (T
		<TELL "out of">)>
	 <TELL TR .AV>
	 <RFATAL>>

<ROUTINE V-WALK-AROUND ()
	 <TELL
"[Refer to the top of the screen to find out where you can go.]" CR>>

<ROUTINE PRE-WALK-TO (AUX L)
	 <SET L <META-LOC ,PRSO>>
	 <COND (<EQUAL? ,PRSO ,START-OBJ>
		<RFALSE>)
	       ;(<AND <NOT <IN? ,PROTAGONIST ,HERE>>
		     <OR <NOT <LOC ,PROTAGONIST> ,ICICLE ,CART>>
			 <EQUAL? ,P-PRSA-WORD ,W?RUN ,W?WALK>>
		<NOT-GOING-ANYWHERE>)
	       (<AND <FSET? ,PRSO ,SCENEBIT>
		     <NOT <PRSO? ,SCENE>>>
		<CANT-GET-THERE>)
	       (<AND <GLOBAL-IN? ,RESTAURANT ,HERE>
		     <PRSO? ,RESTAURANT>
		     <NOUN-USED ,RESTAURANT ,W?KITCHEN>>
		<RFALSE>) ;"handled in restaurant-f"
	       (<OR <IN? ,PRSO ,HERE>
		    <AND <GLOBAL-IN? ,PRSO ,HERE>
			 <NOT <EQUAL? ,PRSO ,AISLE ,FARM ,EIGHT ,DUELING
			               ,HAZING ,COMEDY>>>>
		                            ;"could be another aisle"
	        <COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "He's">)
		      (T
		       <TELL "It's">)>
		<TELL " here!" CR>)
	       ;(<AND .L  ;"L = META-LOC, MUSTN'T BE FALSE"
		     <IN? <META-LOC ,PRSO> ,ROOMS>
		     <NOT <EQUAL? <META-LOC ,PRSO> ,HERE>>
		     <EQUAL? ,SCENE ,AISLE>>
		<TELL "You run..." CR CR>
		<GOTO <META-LOC ,PRSO>>
		<CRLF>
		<APPLY <GETP ,PRSO ,P?ACTION>> ;"to AISLE object also: handled"
		<RTRUE>)>>

<ROUTINE V-WALK-TO ()
	 ;<COND 
	       (<IN? <META-LOC ,PRSO> ,ROOMS>
		<COND (<EQUAL? ,SCENE ,AISLE>
		       <GOTO <META-LOC ,PRSO>>)>)>
	 <COND (<AND <PRSO? ,START-OBJ>
		     <NOUN-USED ,START-OBJ ,W?BEGINNING ,W?BEGIN>>
		<RE-BEGIN>
		<RTRUE>)
	       (<OR <AND <FSET? ,PRSO ,SCENEBIT>
		         <NOT <EQUAL? ,PRSO ,SCENE>>>
		    <PRSO? ,START-OBJ>>
		<CANT-GET-THERE>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE CANT-GET-THERE ()
	 <TELL "You can't get there from here." CR>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<VISIBLE? ,PRSO>
		<V-FOLLOW>)
	       (T
	 	<TELL "You may be waiting quite a while." CR>)>>

<ROUTINE V-WAVE ()
	 <COND (<AND ,PRSI
		     <NOT ,IN-FRONT-FLAG>>
		<RECOGNIZE>)
	       (<HELD? ,PRSO>
		<WASTES>)	       	       
	       (T
		<TELL ,YNH TR ,PRSO>)>>

<ROUTINE PRE-WEAR ()
	 <COND (<EQUAL? <GET ,P-NAMW 0> ,W?SHOE ,W?SHOES>
		<RFALSE>)
	       (<NOT <HELD? ,PRSO>>
		<TELL ,YNH TR ,PRSO>)
	       (T
		<RFALSE>)>>

<ROUTINE V-WEAR ()
         <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<CANT-VERB-A-PRSO "wear">)
	       (T
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "already">)
		      (T
		       <MOVE ,PRSO ,PROTAGONIST>
		       <FSET ,PRSO ,WORNBIT>
		       <TELL "now">)>
		<TELL " wearing" TR ,PRSO>)>>

<ROUTINE V-WHAT ()
	 <TELL "Good question." CR>>

;<ROUTINE V-WHATS-GOOD ()
	 <TELL "Yes, true." CR>>

<ROUTINE V-WHERE ()
	 <V-FIND T>>

<ROUTINE V-WHO ()
	 <COND (<NOT ,PRSO>
		<TELL "You." CR>)
	       (<AND <RUNNING? ,I-KNOCK>
		     <EQUAL? ,KNOCK-N 1 2>>
	        <COND (<EQUAL? ,KNOCK-JOKE ,W?BOB>
		       <COND (<AND <EQUAL? ,KNOCK-N 1>
				   <PRSO? ,GLOBAL-ROOM>>
			      <INC KNOCK-N>
			      <TELL "\"Bob.\"" CR>)
			     (<AND <EQUAL? ,KNOCK-N 2>
				   <PRSO? ,BOB>
				   <NOUN-USED ,BOB ,W?BOB>>
			      <UPDATE-SCORE>
			      <SETG KNOCK-JOKE <>>
			      <SETG KNOCK-N 3>
			      <QUEUE I-KNOCK 2>
			      <MOVE ,BOB ,FRONT-ROOM>
			      <TELL 
"\"Ba ba ba, ba ba ba-ran....\"|
|
The door swings open and in walks your
irrepressible, long-lost (\"but not long enough\") brother-in-law Bob.
\"Howdy, Sammy! Just flew in from Pittsburgh. Boy are my arms tired,\"
he says, flapping and smiling goonily. Bob extends his hand to you in
greeting..." CR>)
			     (T
			      <V-WHAT>)>)
		      (<EQUAL? ,KNOCK-JOKE ,W?DWAYNE>
		       <COND (<AND <EQUAL? ,KNOCK-N 1>
				   <PRSO? ,GLOBAL-ROOM>>
			      <INC KNOCK-N>
			      <TELL "\"Dwayne.\"" CR>)
			     (<AND <EQUAL? ,KNOCK-N 2>
				   <PRSO? ,BOB>
				   <NOUN-USED ,BOB ,W?DWAYNE>>
			      <DEQUEUE I-KNOCK>
			      <UPDATE-SCORE>
			      <SETG KNOCK-JOKE <>>
			      <SETG KNOCK-N 0>
			      <MOVE ,BOB ,YOUR-CHAIR>
			      <TELL 
"\"Dwayne the bathtub, I'm dwownin'!\"" CR CR>
			      <COND (<IN? ,PROTAGONIST ,YOUR-CHAIR>
				     <MOVE ,PROTAGONIST ,HERE>
				     <SETG OLD-HERE T>
				     <TELL
"Following the script, you rise emotionally from the chair and">)
				    (T
				     <TELL "You">)>
			      <TELL
" hear a suppressed cackle from behind the
bathroom door, which slowly opens to reveal the figure of your Bob,
looking sheepish but with his hurt feelings mended. He shuts the door
and slides back into your chair." CR>)
			     (T
			      <V-WHAT>)>)
		      (<EQUAL? ,KNOCK-JOKE ,W?GORILLA>
		       <COND (<AND <EQUAL? ,KNOCK-N 1>
				   <PRSO? ,GLOBAL-ROOM>>
			      <INC KNOCK-N>
			      <TELL "\"Gorilla.\"" CR>)
			     (<AND <EQUAL? ,KNOCK-N 2>
				   <PRSO? ,WIFE>
				   <NOUN-USED ,WIFE ,W?GORILLA>>
			      <DEQUEUE I-KNOCK>
			      <SETG KNOCK-JOKE <>>
			      <SETG KNOCK-N 0>
			      <UPDATE-SCORE>
			      <MOVE ,WIFE ,FRONT-ROOM>
			      <QUEUE I-WIFE -1>
			      <TELL
"\"Girl of your dreams!\"|
|
A lady enters the living room and, narrowing her eyes, begins sizing up the
situation." CR>)
			     (T
			      <V-WHAT>)>)
		      (T
		       <V-WHAT>)>)
	       (T
		<V-WHAT>)>>

<ROUTINE V-WRAP ()
	 <WASTES>>

<ROUTINE V-YELL ()
	 <SORE "throat">
	 <STOP>>

<ROUTINE I-REPLY ()
	 <FCLEAR ,OLD-BOTTLE ,HEARDBIT>
	 <SETG AWAITING-REPLY <>>
	 <RFALSE>>

<GLOBAL AWAITING-REPLY <>>

<ROUTINE V-YES ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<COND (<FSET? ,OLD-BOTTLE ,HEARDBIT>
		       <MOVE ,OLD-BOTTLE ,MANTEL>
		       <UPDATE-SCORE>
		       <TELL 
"Mmmmm. You know I really think you might be right. Yes, yes, the cherished
memento look.|
|
You carefully place the antique bottle upon the mantel.|
|
Yes, heavens yes, it really ">
		       <ITALICIZE "says">
		       <TELL  
" something there. Oh, such a prized antique, what could I ">
		       <ITALICIZE "ever">
		       <SETG ORPHAN-FLAG ,LOUIS-CHAIR>
		       <QUEUE I-ORPHAN 2>
		       <TELL " give you in return?">)
		      (T
		       <TELL "Oh, you really think so? I must disagree.">)>
		<CRLF>)
	       ;(<EQUAL? ,AWAITING-REPLY 2>
		<TELL"Well, I have ">
		<ITALICIZE "experienced">
		<TELL 
" such insolence such I have just heard. Okay, smart aleck, see if you can
do better describing things. Ummm.... Let's see....
||
>EXAMINE THE MANTEL">
		<SAVE-INPUT ,FIRST-BUFFER>) 
	       ;(T
		<TELL "That was just a rhetorical question." CR>) 
	       (T
	 	<YOU-SOUND "posi">)>>

<ROUTINE YOU-SOUND (STRING)
	 <TELL "You sound rather " .STRING "tive." CR>>

<ROUTINE YES-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?YES ,W?Y ,W?YUP>
		    <EQUAL? .WRD ,W?OK ,W?OKAY ,W?SURE>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;"subtitle object manipulation"

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" ;CNT OBJ)
	 <COND (<FSET? ,PRSO ,INTEGRALBIT>
		<COND (.VB
		       <PART-OF>)>
		<RFATAL>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <YUKS>)>
		<RFATAL>)
	       (<PRE-TOUCH>
		<RFATAL>)
	       ;"next clause used to be in pre-take"
	       (<OR <IN? ,PRSO ,PROTAGONIST>
		    <AND <HELD? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>
			 <NOT <NOUN-USED ,PRSO ,W?CENT>>>>
		<COND (.VB
		       <COND (<FSET? ,PRSO ,WORNBIT>
			      <TELL "You're already wearing">)
			     (T
			      <TELL "You already have">)>
		       <TELL T ,PRSO ,PERIOD>)>
		<RFATAL>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,PROTAGONIST>> 100>>
		<COND (.VB
		       <TELL
"It's too heavy, considering your current load." CR>)>
		<RFATAL>)
	       (<G? <CCOUNT ,PROTAGONIST> 10>
		<COND (.VB
		       <TELL
"You're already juggling as many items as you could possibly carry." CR>)>
		<RFATAL>)>
	 <FSET ,PRSO ,TOUCHBIT>
	 <FCLEAR ,PRSO ,NDESCBIT>
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<RFALSE> ;"Hope this is right -- pdl 4/22/86")
	       ;(<AND <PRSO? ,RAFT>
		     ,RAFT-HELD>
		<SETG RAFT-HELD <>>)>
	 <MOVE ,PRSO ,PROTAGONIST>>

;"IDROP is called by PRE-GIVE and PRE-PUT.
  IDROP acts directly as PRE-DROP, PRE-THROW and PRE-PUT-THROUGH."
<ROUTINE IDROP ()
	 <COND (<PRSO? ,HANDS>
		<COND (<VERB? DROP THROW GIVE>
		       <IMPOSSIBLES>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? THROW>
		     <PRSO? ,EYES>>
		<COND (<NOT ,PRSI>
		       <COND (<VISIBLE? ,WAITRESS>
			      <SETG PRSI ,WAITRESS>)
			     (T
			      <V-LOOK>
			      <RTRUE>)>)>
		<PRE-SWITCH>
		<PERFORM ,V?EXAMINE ,PRSI ,EYES>
		<RTRUE>)
	       (<AND <PRSO? ,MUSSELS>
		     <NOT <FSET? ,MUSSELS ,OLDBIT>>>
		<TELL "That would be extremely painful." CR>)
	       (<AND <PRSO? ,ME>
		     <VERB? PUT>
		     <FSET? ,PRSI ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSI>
		<RTRUE>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,LOBOTOMY>>
		<RFALSE>)
	       (<AND <PRSI? ,ME>
		     <VERB? PUT>
		     <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<PRSO? ,INTNUM> ;"intnum-f will 'cant see' number"
		<RFALSE>)	       
	       (<IN? ,JOAT ,GLOBAL-OBJECTS>		     
		  ;<VISIBLE? ,JACK-IS>
		<RFALSE>)
	       (<NOT <HELD? ,PRSO>>
		<COND (<OR <PRSO? ,ME>
			   <FSET? ,PRSO ,PARTBIT>>
		       <IMPOSSIBLES>)
		      (<AND <PRSO? ,BOB>
			    <EQUAL? <GET ,P-NAMW 0> ,W?SPONGE>>
		       <RFALSE>) ;"handled in bob-f"
		      (T
		       <TELL
"That's easy for you to say since you don't even have" TR ,PRSO>)>
		<RFATAL>)
	       (<AND <EQUAL? ,PRSO ,ELECTRICAL-SWITCH>
		     <VERB? THROW>
		     <NOT ,PRSI>>
		<RFALSE>)
	       (<AND <VERB? PUT>
		     <PRSO? ,CLOCK-KEY>
		     <PRSI? ,SAFE>>
		<PERFORM ,V?UNLOCK ,SAFE ,CLOCK-KEY>
		<RTRUE>)
	       (<FSET? ,PRSO ,INTEGRALBIT>
		<PART-OF>)
	       (<AND <NOT <IN? ,PRSO ,PROTAGONIST>>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<DO-FIRST "open" <LOC ,PRSO>>)
	       (<FSET? ,PRSO ,WORNBIT>
		<DO-FIRST "remove" ,PRSO>)
	       (T
		<RFALSE>)>>

<ROUTINE CCOUNT	(OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"Gets SIZE of supplied object, recursing to nth level."
<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<SET WT <+ .WT <WEIGHT .CONT>>>
			<COND (<NOT <SET CONT <NEXT? .CONT>>>
			       <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

;"subtitle describers"

<GLOBAL FIRST-TIME <>> ;"if T room is being decribed the first time.
			 set to <> in start of parser"

<GLOBAL ROOM-DESC-PRINTED <>> ;"if T room desc is printed in this turn,
			       set to <> in parser"

<ROUTINE D-ROOM ("OPTIONAL" (VERB-IS-LOOK <>)
			"AUX" (FIRST-VISIT <>) (NUM 0))
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		;<FSET ,HERE ,TOUCHBIT>
		<SET FIRST-VISIT T>
		<SETG FIRST-TIME T>)>
	 <COND (<NOT ,KREMLIN-ENTER>
		<HLIGHT ,H-BOLD>
	 	<SAY-HERE>
	 	;<CRLF> ;"cause of previous bug"
	 	<HLIGHT ,H-NORMAL>
		<CRLF>)>
	 <COND (<OR .VERB-IS-LOOK
		    <EQUAL? ,VERBOSITY 2>
		    <AND .FIRST-VISIT
			 <EQUAL? ,VERBOSITY 1>>>
		<SETG ROOM-DESC-PRINTED T>
		<CRLF>
		<COND (<NOT <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <TELL <GETP ,HERE ,P?LDESC>>)>
		<FSET ,HERE ,TOUCHBIT>
		<CRLF>)>
	 <SETG KREMLIN-ENTER <>>
	 <RTRUE>>

;"Print FDESCs, then DESCFCNs and LDESCs, then everything else. DESCFCNs
must handle M-OBJDESC? by RTRUEing (but not printing) if the DESCFCN would
like to handle printing the object's description. RFALSE otherwise. DESCFCNs
are responsible for doing the beginning-of-paragraph indentation."

<ROUTINE D-OBJECTS ("AUX" O STR (1ST? T) (AV <LOC ,WINNER>))
	 <SET O <FIRST? ,HERE>>
	 <COND (<NOT .O>
		<RFALSE>)>
	 <REPEAT () ;"FDESCS and MISC."
		 <COND (<NOT .O>
			<RETURN>)
		       (<AND <DESCRIBABLE? .O>
			     <NOT <FSET? .O ,TOUCHBIT>>
			     <SET STR <GETP .O ,P?FDESC>>>
			<TELL CR .STR> ;"used to be indent"
			<COND (<AND <FSET? .O ,CONTBIT>
				    <NOT <FSET? .O ,NO-D-CONT>>> ;"added"
			       <D-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <SET O <FIRST? ,HERE>>
	 <SET 1ST? T>
	 <REPEAT () ;"DESCFCNS"
		 <COND (<NOT .O>
			<RETURN>)
		       (<OR <NOT <DESCRIBABLE? .O>>
			    <AND <GETP .O ,P?FDESC>
				 <NOT <FSET? .O ,TOUCHBIT>>>>
			T)
		       (<AND <SET STR <GETP .O ,P?DESCFCN>>
			     <SET STR <APPLY .STR ,M-OBJDESC>>>
			;" *** make sure descfcns rtrue, after printing!"
			;<CRLF> ;"CRLF before! a descfcn in j3"
			<COND (<AND <FSET? .O ,CONTBIT>
				    <N==? .STR ,M-FATAL>
				    <NOT <FSET? .O ,NO-D-CONT>>> ;"added"
			       <D-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)
		       (<SET STR <GETP .O ,P?LDESC>>
			<TELL CR .STR> ;"used to be indent"
			<COND (<AND <FSET? .O ,CONTBIT>
				    <NOT <FSET? .O ,NO-D-CONT>>
				    <OR <NOT <FSET? .O ,NO-D-CONT>> ;"added"
				        <NOT <FSET? .O ,DESC-IN-ROOMBIT>>>>
			                               ;"rest-table case"
			       <D-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <D-CONTENTS ,HERE <> 0>
	 <COND (<AND .AV <NOT <EQUAL? ,HERE .AV>>>
		<D-CONTENTS .AV <> 0>)>>

<CONSTANT D-ALL? 1> ;"print everything?"
<CONSTANT D-PARA? 2> ;"started paragraph?"

"<D-CONTENTS ,OBJECT-WHOSE-CONTENTS-YOU-WANT-DESCRIBED
		    level: -1 means only top level
			    0 means top-level (include crlf)
			    1 for all other levels
			    or string to print
		    all?: t if not being called from room-desc >"

<ROUTINE D-CONTENTS (OBJ "OPTIONAL" (LEVEL -1) (ALL? ,D-ALL?)
			    "AUX" (F <>) N (1ST? T) (IT? <>)
			    (START? <>) (TWO? <>) (PARA? <>))
  <COND (<EQUAL? .LEVEL 2>
	 <SET LEVEL T>
	 <SET PARA? T>
	 <SET START? T>)
	(<BTST .ALL? ,D-PARA?>
	 <SET PARA? T>)>
  <SET N <FIRST? .OBJ>>
  <COND (<OR .START?
	     <IN? .OBJ ,ROOMS>
	     <FSET? .OBJ ,ACTORBIT>
	     <AND <FSET? .OBJ ,CONTBIT>
		  ;<NOT <FSET? .OBJ ,NO-D-CONT>> ;"used above"
		  <OR <FSET? .OBJ ,OPENBIT>
		      <FSET? .OBJ ,TRANSBIT>>
		  <FSET? .OBJ ,SEARCHBIT>
		  .N>>
	 <REPEAT ()
	  <COND (<OR <NOT .N>
		     <AND <DESCRIBABLE? .N>
			  <OR <BTST .ALL? ,D-ALL?>
			      <SIMPLE-DESC? .N>>>>
		 <COND
		  (.F
		   <COND
		    (.1ST?
		     <SET 1ST? <>>
		     <COND (<EQUAL? .LEVEL <> T>
			    <COND (<NOT .START?>
				   <COND (<NOT .PARA?>
					  <COND (<NOT <EQUAL? .OBJ
							      ,PROTAGONIST>>
						 ;<CRLF>)>;"used to be indent"
					  <SET PARA? T>)
					 (<EQUAL? .LEVEL T>
					  <TELL " ">)>
				   <COND (<EQUAL? .OBJ ,HERE>
					  <TELL CR ,YOU-SEE>)
					 (<EQUAL? .OBJ ,PROTAGONIST>
					  <TELL "You have">)
					 (<FSET? .OBJ ,SURFACEBIT>
					  <TELL CR "Sitting on" T .OBJ>
					 <COND (<AND <OR <EQUAL? <CCOUNT .OBJ>
								  1>
							 <AND 
							  <EQUAL? <CCOUNT .OBJ>
								 2>
							  <IN? ,PROTAGONIST
							       .OBJ>>>
						     <NOT <FSET? <FIRST? .OBJ>
							    ,PLURALBIT>>>
						 <TELL " is">)
						(T
						 <TELL " are">)>)
					 (T
					  <TELL CR ,IT-SEEMS-THAT T .OBJ>
					  <COND (<FSET? .OBJ ,ACTORBIT>
						 <TELL " has">)
						(T
						 <TELL " contains">)>)>)>)
			   (<NOT <EQUAL? .LEVEL -1>>
			    <TELL .LEVEL>)>)
		    (T
		     <COND (.N
			    <TELL ",">)
			   (T
			    <TELL " and">)>)>
		   <COND (<AND <EQUAL? .F ,DISGUISE>
			       <IN? ,BLESSING ,DISGUISE>>
			  <TELL " a blessing in disguise">)
			 (T
			  <TELL A .F>)>
		   <COND (<AND <EQUAL? .F ,HOUSE>
			       ,LOUSE-ON-HEAD>
			  <TELL " (crawling about on your skull)">)
			 (<FSET? .F ,WORNBIT>
			  ;<COND (<EQUAL? .F ,CLOTHES-PIN>
				 <TELL " (pinned to " 'NOSE ")">)>
				
				 <TELL " (being worn)">)
			 (<EQUAL? .F ,ITEM-BOUGHT>
			  <TELL " (bought and paid for)">)
			 ;(<FSET? .F ,ONBIT>
			  <TELL " (providing light)">)
			 ;(<EQUAL? .F ,COMIC-BOOK>
			  <TELL " (stuck in your back pocket)">)>
		   <COND (<AND <NOT .IT?> <NOT .TWO?>>
			  <SET IT? .F>)
			 (T
			  <SET TWO? T>
			  <SET IT? <>>)>)>
		 <SET F .N>)>
	  <COND (.N
		 <SET N <NEXT? .N>>)>
	  <COND (<AND <NOT .F>
		      <NOT .N>>
		 <COND (<AND .IT?
			     <NOT .TWO?>>
			<THIS-IS-IT .IT?>)>
		 <COND (<AND .1ST? .START?>
			;<SET 1ST? <>>
			<TELL " nothing">
			<RFALSE>)>
		 <COND (<AND <NOT .1ST?>
			     <EQUAL? .LEVEL <> T>>
			<COND (<EQUAL? .OBJ ,HERE>
			       <TELL " here">)>
			<TELL ".">)>
		 <RETURN>)>>
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (<AND <FSET? .F ,CONTBIT>
			     <DESCRIBABLE? .F T>
			     <NOT <FSET? .F ,NO-D-CONT>> ;"for things with
							   a simple desc"
			     <OR <BTST .ALL? ,D-ALL?>
				 <SIMPLE-DESC? .F>>>
			<COND (<D-CONTENTS .F T
						  <COND (.PARA?
							 <+ ,D-ALL? ,D-PARA?>)
							(T
							 ,D-ALL?)>>
			       <SET 1ST? <>>
			       <SET PARA? T>)>)>
		 <SET F <NEXT? .F>>>
	 <COND (<AND <NOT .1ST?>
		     <EQUAL? .LEVEL <> T>
		     <EQUAL? .OBJ ,HERE <LOC ,WINNER>>>
		<CRLF>)>
	 <NOT .1ST?>)>>

<ROUTINE DESCRIBABLE? (OBJ "OPT" (CONT? <>))
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<AND <FSET? .OBJ ,FIRST-TIMEBIT> 
		    ,FIRST-TIME> ;"obj. described in JUST first M-look of room"
	        <RFALSE>)
	       (<AND <FSET? .OBJ ,DESC-IN-ROOMBIT>
		     ,ROOM-DESC-PRINTED>  ;"obj. ALWAYS described in room-desc"
		<RFALSE>)                 ;"but if no room desc printed will"
	       (<EQUAL? .OBJ ,WINNER>     ;"print 'theres a schmoo here'"
		<RFALSE>)
	       (<AND <EQUAL? .OBJ <LOC ,WINNER>>
		     <NOT <EQUAL? ,HERE <LOC ,WINNER>>>>
		<RFALSE>)
	       (<AND <NOT .CONT?>
		     <FSET? .OBJ ,NDESCBIT>>
		<RFALSE>)	       
	       ;(<AND <EQUAL? .OBJ ,RAFT ,BARGE>
		     <EQUAL? ,HERE ,CANAL>
		     <NOT <HELD? .OBJ>>
		     <NOT <IN? .OBJ ,BARGE>>
	             <NOT <EQUAL? ,RAFT-LOC-NUM ,BARGE-LOC-NUM>>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE SIMPLE-DESC? (OBJ "AUX" STR)
	 <COND (<AND <GETP .OBJ ,P?FDESC>
		     <NOT <FSET? .OBJ ,TOUCHBIT>>>
		<RFALSE>)
	       (<AND <SET STR <GETP .OBJ ,P?DESCFCN>>
		     <APPLY .STR ,M-OBJDESC?>>
		<RFALSE>)
	       (<GETP .OBJ ,P?LDESC>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE D-VEHICLE () ;"for LOOK AT/IN vehicle when you're in it"
	 <COND (<PRSO? ,HOT-TUB>
		<COND (<AND <IN? ,MERMAID ,HOT-TUB>
			    <NOT <EQUAL? <GET ,P-NAMW 0> ,W?PLUG>>>
		       <TELL 
"The mermaid is swimming circles around you in the well-insulated hot
tub, her long silken blond hair streaming through the steamy water. ">)
		      (<NOT <EQUAL? <GET ,P-NAMW 0> ,W?PLUG>>
		       <TELL 
"The well-insulated tub's full of hot steamy water and you. ">)>
		<TELL "There's a plug at the bottom of the hot tub." CR>)
	       (T
		<TELL "Other than yourself, you can see"> 
	 	<COND (<NOT <D-NOTHING>>
		       <COND (<FSET? ,PRSO ,INBIT>
			      <TELL " in">)
			     (T
			      <TELL " on">)>
		       <TELL TR ,PRSO>)>
		<RTRUE>)>>

<ROUTINE D-NOTHING ()
	 <COND (<D-CONTENTS ,PRSO 2>
	 	<COND (<NOT <IN? ,PROTAGONIST ,PRSO>>
		       <CRLF>)>
		<RTRUE>)
	       (T ;"nothing"
		<RFALSE>)>>

;"subtitle movement and death"

<CONSTANT REXIT 0> ;"changed to amvf-numbers from lgop constant numbers"
<CONSTANT UEXIT 2>
<CONSTANT NEXIT 3>
<CONSTANT FEXIT 4>
<CONSTANT CEXIT 5>
<CONSTANT DEXIT 6>

<CONSTANT NEXITSTR 0>  ;"changed to amvf-numbers from lgop constant numbers"
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 2>

<ROUTINE GOTO (NEW-LOC "AUX" OLD-HERE)
	 <SET OLD-HERE ,HERE>
	 ;"if your in not moveable veh. it will be caught in PRE-WALK-TO"
	 <COND (<NOT <FSET? <LOC ,PROTAGONIST> ,VEHBIT>>
		<MOVE ,PROTAGONIST .NEW-LOC>)>
	 ;"if player wants to move with veh., move the veh before this"
	 <COND (<IN? .NEW-LOC ,ROOMS>
		<SETG HERE .NEW-LOC>)
	       (T
		<SETG HERE <LOC .NEW-LOC>>)>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<AND <D-ROOM>
		     <NOT <EQUAL? ,VERBOSITY 0>>>
		<D-OBJECTS>)>
	 <RTRUE>>

;<ROUTINE SIDEKICK-FOLLOWS-YOU ()
	 <COND (<EQUAL? ,HERE ,BOUDOIR>
		<MOVE ,SIDEKICK ,HERE>)
	       (T
		<MOVE ,SIDEKICK <LOC ,PROTAGONIST>>)>
	 <COND (,HOLE-MOVE
		<TELL "   A few seconds later, you ">
		<COND (<LIT? ,HERE>
		       <TELL "see ">)
		      (T
		       <TELL "feel ">)>
		<TELL
D ,SIDEKICK "'s " <PICK-ONE ,SIDEKICK-PARTS> " appear,
followed almost immediately by the rest of ">
		<HIM-HER>
		<TELL ,PERIOD>)
	       (T
		<NORMAL-SIDEKICK-FOLLOW>)>>

;<ROUTINE NORMAL-SIDEKICK-FOLLOW ()
	 <TELL "   " D ,SIDEKICK <PICK-ONE ,FOLLOWS> CR>>

;<GLOBAL SIDEKICK-PARTS
	<LTABLE
	 0
	 "earlobe"
	 "nose"
	 "big toe"
	 "elbow"
	 "left buttock">>

;<GLOBAL FOLLOWS
	<LTABLE
	 0
	 " trails along."
	 " follows you."
	 " enters just a few steps behind you."
	 " loyally stays at your side.">>

<ROUTINE JIGS-UP (DESC)
	 <TELL .DESC>
	 <TELL CR CR
"      ****  You have died  ****" CR>
	 <FINISH>>

;"subtitle useful utility routines"

<ROUTINE ACCESSIBLE? (OBJ "AUX" L) ;"revised 2/18/86 by SEM"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       ;(<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE ,PROTAGONIST>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" L) ;"revised 5/2/84 by SEM and SWG"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE UNTOUCHABLE? (OBJ)
;"figures out whether, due to vehicle-related locations, object is touchable"
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       ;"next four clauses are special cases"
	       (<OR <HELD? .OBJ ,SAFE>
		    <EQUAL? .OBJ ,MARX ,SAFE>>
		<COND (<IN? ,PROTAGONIST ,LOUIS-CHAIR>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<AND <OR <IN? .OBJ ,REST-TABLE>
			 <EQUAL? .OBJ ,REST-TABLE>>
		     <IN? ,PROTAGONIST ,REST-CHAIR>>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ ,FIRE>
		     <IN? ,PROTAGONIST ,PAN>>
		<RFALSE>)
	       (<IN? ,PROTAGONIST ,HERE>
		<RFALSE>)
	       (<OR <HELD? .OBJ <LOC ,PROTAGONIST>>
		    <EQUAL? .OBJ <LOC ,PROTAGONIST>>
		    <IN? .OBJ ,GLOBAL-OBJECTS> ;"me, hands, etc.">
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TEE) ;"finds room on others side of door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T
			<SET TEE <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TEE> ,DEXIT>
				    <EQUAL? <;GETB GET .TEE ,DEXITOBJ> .DOBJ>>
			                     ;"zip to ezip"
			       <RETURN .P>)>)>>>

<ROUTINE HELD? (OBJ "OPTIONAL" (CONT <>)) ;"formerly ULTIMATELY-IN?"
	 <COND (<NOT .CONT>
		<SET CONT ,PROTAGONIST>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ .CONT>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       ;(<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<HELD? <LOC .OBJ> .CONT>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND .OBJ
	      <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<SET TEE <GETPT .OBJ2 ,P?GLOBAL>>
		<INTBL? .OBJ1 .TEE </ <PTSIZE .TEE> 2>>)>>
	;"zip to ezip"

<ROUTINE FIND-IN (WHERE FLAG-IN-QUESTION
		  "OPTIONAL" (STRING <>) "AUX" OBJ RECURSIVE-OBJ)
	 <SET OBJ <FIRST? .WHERE>>
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .OBJ .FLAG-IN-QUESTION>
			     <NOT <FSET? .OBJ ,INVISIBLE>>>
			<COND (.STRING
			       <TELL "[" .STRING T .OBJ "]" CR>)>
			<RETURN .OBJ>)
		       (<SET RECURSIVE-OBJ <FIND-IN .OBJ .FLAG-IN-QUESTION>>
			<RETURN .RECURSIVE-OBJ>)
		       (<NOT <SET OBJ <NEXT? .OBJ>>>
			<RETURN <>>)>>>

;<ROUTINE DIRECTION? (OBJ)
	 <COND (<OR <EQUAL? .OBJ ,P?NORTH ,P?SOUTH ,P?EAST>
		    <EQUAL? .OBJ ,P?WEST ,P?NE ,P?NW>
		    <EQUAL? .OBJ ,P?SE ,P?SW>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<ROUTINE NOW-DARK? ()
	 <COND (<AND ,LIT
		     <NOT <LIT? ,HERE>>>
		<SETG LIT <>>
		<TELL "   It is now too dark to see." CR>)>>

;<ROUTINE NOW-LIT? ()
	 <COND (<AND <NOT ,LIT>
		     <LIT? ,HERE>>
		<SETG LIT T>
		<CRLF>
		<V-LOOK>)>>

<ROUTINE LOC-CLOSED ("AUX" (L <LOC ,PRSO>))
	 <COND (<AND <FSET? .L ,CONTBIT>
		     <NOT <FSET? .L ,OPENBIT>>
		     <FSET? ,PRSO ,TAKEBIT>
		     <NOT <EQUAL? .L ,CAT-BAG>>>
		<DO-FIRST "open" .L>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE STOP ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<ROUTINE ROB (WHO "OPTIONAL" (WHERE <>) "AUX" N X)
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<ZERO? .X>
			<RETURN>)>
		 <SET N <NEXT? .X>>
		 <MOVE .X .WHERE>
		 <FCLEAR .X ,WORNBIT>
		 <SET X .N>>>

;<ROUTINE WRONG-SEX-WORD (OBJ MALE-WORD FEMALE-WORD)
	 <COND (<NOT ,SEX-CHOSEN>
		<RFALSE>)
	       (<OR <AND ,MALE
			 <NOUN-USED .FEMALE-WORD .OBJ>>
		    <AND <NOT ,MALE>
			 <NOUN-USED .MALE-WORD .OBJ>>>
		<TELL "There's no">
		<COND (<EQUAL? .OBJ ,SIDEKICK>
		       <TELL " one by that name">)
		      (<PRSO? .OBJ>
		       <PRSO-PRINT>)
		      (T
		       <PRSI-PRINT>)>
		<TELL " here.">
		<COND (<NOT <EQUAL? ,NAUGHTY-LEVEL 0>>
		       <TELL
" [I see you've been playing both as a male and as a female! I guess
you're the type who goes both ways, eh? Nudge, nudge, wink, wink!]">)>
		<SETG P-WON <>>
		<CRLF>)
	       (T
		<RFALSE>)>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR T ,PRSO>
	 <HO-HUM>>

<ROUTINE HO-HUM ()
	 <TELL <PICK-ONE ,HO-HUM-LIST> CR>>

<GLOBAL HO-HUM-LIST
	<LTABLE
	 0 
	 " doesn't do anything."
	 " accomplishes nothing."
	 " has no desirable effect.">>		 

<ROUTINE YUKS ()
	 <TELL <PICK-ONE ,YUK-LIST> CR>>

<GLOBAL YUK-LIST
	<LTABLE
	 0 
	 "What a concept."
         "Nice try."
	 "You've gotta be kidding."
	 "Never in a thousand years.">>

<ROUTINE IMPOSSIBLES ()
	 <TELL <PICK-ONE ,IMPOSSIBLE-LIST> CR>>

<GLOBAL IMPOSSIBLE-LIST
	<LTABLE
	 0
	 "Fat chance."
	 "Imposterous!"
	 "Dream on."
	 "Prepossible!"
	 "No dice."
	 "Out of the question.">>

<ROUTINE WASTES ()
	 <TELL <PICK-ONE ,WASTE-LIST> CR>>

<GLOBAL WASTE-LIST
	<LTABLE 0
"You're barking up the wrong tree."
"It's not worth it. Believe me."
"There's no utility in doing that."
"There's another turn down the drain."
"Why bother?">>