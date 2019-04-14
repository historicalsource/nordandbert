"GLOBALS for
		            NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<DIRECTIONS ;"Do not change the order of the first 8 without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

;<ADJ-SYNONYM LARGE LARGER HUGE HUGER BIG BIGGER GIANT GIGANTIC TREMENDOUS
	     MIGHTY MIGHTIER MASSIVE>

;<ADJ-SYNONYM WIDE BROAD>

;<ADJ-SYNONYM SMALL SMALLER TINY TINIER LITTLE PETITE TEENSY WEENSY>

;<ADJ-SYNONYM MY MINE>

;<GLOBAL LIT T>

<GLOBAL MOVES 0>

;<GLOBAL SCORE 0>

<GLOBAL HERE <>>

<OBJECT GLOBAL-OBJECTS
	(SYNONYM ZZMGCK) ;"No, this synonym doesn't need to exist... sigh"
	(DESC "it")
	(FLAGS INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT OPENBIT SEARCHBIT
	       TRANSBIT WEARBIT ONBIT LIGHTBIT RLANDBIT WORNBIT
	       VEHBIT INDOORSBIT CONTBIT VOWELBIT LOCKEDBIT NDESCBIT DOORBIT
	       ACTORBIT PARTBIT INBIT FEMALEBIT KLUDGEBIT OLDBIT TRANSFORMED
	       RMUNGBIT SEENBIT HEARDBIT PHRASEBIT NO-D-CONT FIRST-TIMEBIT
	       DESC-IN-ROOMBIT FOODBIT WONBIT RANKBIT NOA)>

;"DESC-IN-ROOMBIT = if room desc is printed, then dont print
  		    desc of obj in d-objects. if just enter
  		    room, do say 'There's a shmoo here.'"

;"DESC-IN-ROOMBIT = if obj with this is container, in a look the contents
		    must be printed in the m-look. If you enter room,
		    contents printed in usual way. Sitting on the..."

<OBJECT LOCAL-GLOBALS
	(LOC GLOBAL-OBJECTS)
	(DESC "it")
	(SYNONYM ZZMGCK) ;"Yes, this synonym needs to exist... sigh"
	;(DESCFCN 0)
        ;(GLOBAL GLOBAL-OBJECTS)
	;(FDESC "F")
	;(LDESC "F")
	;(SIZE 0)
	;(TEXT "")
	;(CAPACITY 0)
	;(THINGS <PSEUDO (ZZMGCK ZZMGCK ME-F)>)>

<OBJECT ROOMS
	(IN TO ROOMS)
	(DESC "it")>

<OBJECT INTDIR
	(LOC GLOBAL-OBJECTS)
	(DESC "direction")
	(SYNONYM DIRECT)
	(ADJECTIVE NORTH SOUTH EAST WEST NW NE SW SE)
	;(ACTION INTDIR-F)>

;<ROUTINE INTDIR-F ()
	 <COND (<AND <VERB? BOARD>
		     <EQUAL? ,P-PRSA-WORD ,W?RIDE>>
		<COND (<IN? ,PROTAGONIST ,STALLION>
		       <DO-WALK ,P-DIRECTION>)
		      (<IN? ,STALLION ,HERE>
		       <DO-FIRST "mount">)
		      (T
		       <TELL ,THERES-NOTHING "to ride!" CR>)>)>>

<OBJECT INTNUM
	(LOC GLOBAL-OBJECTS)
	(DESC "number")
	(SYNONYM NUMBER NUMBERS)
	(ADJECTIVE INTNUM)
	(ACTION INTNUM-F)>

<ROUTINE INTNUM-F ()
	 <COND (<AND <VISIBLE? ,PI>
		     <OR <ZERO? ,P-NUMBER> ;"input was 'number'"
			 <AND <EQUAL? ,P-EXCHANGE 22>
			      <EQUAL? ,P-NUMBER 7>>>>
	        <FSET ,PI ,OLDBIT>
		<FSET ,PI ,NARTICLEBIT>		
		<COND (<NOT ,TRANS-PRINTED>
		       <CHANGE-OBJECT ,INTNUM ,PI>)>
		<RTRUE>)
	       (<NOT <EQUAL? ,P-NUMBER 232>>;"secret num. for outside testers"
		<CANT-SEE ,INTNUM>)>>

<OBJECT IT
	(LOC GLOBAL-OBJECTS)
	(SYNONYM IT THEM)
	(DESC "it")
	(FLAGS VOWELBIT NARTICLEBIT TOUCHBIT)>

<OBJECT HIM
	(LOC GLOBAL-OBJECTS)
	(SYNONYM HIM HIMSELF)
	(DESC "him")
	(FLAGS NARTICLEBIT TOUCHBIT)>

<OBJECT HER
	(LOC GLOBAL-OBJECTS)
	(SYNONYM HER HERSELF)
	(DESC "her")
	(FLAGS NARTICLEBIT TOUCHBIT)>

<OBJECT EACH-OTHER
	(LOC GLOBAL-OBJECTS)
	(DESC "it")
	(SYNONYM OTHER ITSELF)
	(ADJECTIVE EACH)
	(ACTION EACH-OTHER-F)>

<ROUTINE EACH-OTHER-F ()
	 <COND (<PRSI? ,EACH-OTHER>
		<PERFORM-PRSA ,PRSO ,PRSO>
		<RTRUE>)
	       ;(<NOT <NOUN-USED ,W?ITSELF ,EACH-OTHER>>
		<SETG P-WON <>>
		<COND (<ADJ-USED ,A?EACH>
		       <CANT-USE ,A?EACH T>)
		      (T
		       <CANT-USE ,W?OTHER T>)>
		<RTRUE>)>>

<OBJECT MAN-WOMAN
	(LOC GLOBAL-OBJECTS)
	(SDESC "")
	(SYNONYM MAN WOMAN LADY)
	(ACTION MAN-WOMAN-F)>

<ROUTINE MAN-WOMAN-F ("AUX" PERSON)
	 <COND ;(<VERB? FOLLOW> ;"for YOUNG WOMAN"
		<COND (<EQUAL? ,FOLLOW-FLAG 4>
		       <TELL ,DONT-WANT-TO>)
		      (<EQUAL? ,FOLLOW-FLAG 5>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,FOLLOW-FLAG 6>
		       <DO-WALK ,P?EAST>)
		      (T
		       <V-WALK-AROUND>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 0> ,W?MAN> ;"MAN is the PRSO"
		     <PRSO? ,MAN-WOMAN> ;"in case PRSI is also MAN or WOMAN">
		<COND (<SET PERSON <FIND-MAN>>
		       <PERFORM-PRSA .PERSON ,PRSI>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN-WOMAN>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 0> ,W?WOMAN ,W?LADY> ;"WOMAN is PRSO"
		     <PRSO? ,MAN-WOMAN> ;"in case PRSI is also MAN or WOMAN">
		<COND (<SET PERSON <FIND-WOMAN>>
		       <PERFORM-PRSA .PERSON ,PRSI>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN-WOMAN>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 1> ,W?MAN> ;"MAN is the PRSI"
		     <PRSI? ,MAN-WOMAN> ;"in case PRSO is also MAN or WOMAN">
		<COND (<SET PERSON <FIND-MAN>>
		       <PERFORM-PRSA ,PRSO .PERSON>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN-WOMAN>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 1> ,W?LADY ,W?WOMAN> ;"WOMAN is PRSI"
		     <PRSI? ,MAN-WOMAN> ;"in case PRSO is also MAN or WOMAN">
		<COND (<SET PERSON <FIND-WOMAN>>
		       <PERFORM-PRSA ,PRSO .PERSON>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN-WOMAN>)>)>>

<ROUTINE FIND-MAN ()
	 <PUTP ,MAN-WOMAN ,P?SDESC "man">
	 <COND (<IN? ,MURDERER ,HERE>
		<RETURN ,MURDERER>)
	       (<IN? ,FROST ,HERE>
		<RETURN ,FROST>)
	       (<IN? ,CLIENT ,HERE>
		<RETURN ,CLIENT>)
	       (<OR <IN? ,BOB ,HERE>
		    <AND <EQUAL? ,HERE ,FRONT-ROOM>
			 <IN? ,BOB ,YOUR-CHAIR>>>
		<RETURN ,BOB>)
	       (<IN? ,COOK ,HERE>
		<RETURN ,COOK>)
	       (<AND <IN? ,DEAN ,HERE>
		     <FSET? ,DEAN ,OLDBIT>>
		<RETURN ,DEAN>)
	       (<AND <IN? ,LEOPARD ,HERE>
		     <NOT <FSET? ,LEOPARD ,OLDBIT>>>
		<RETURN ,LEOPARD>)
	       (<IN? ,PIPER ,HERE>
		<RETURN ,PIPER>)
	       (<AND <VISIBLE? ,DUCK>
		     <OR <IN? ,DUCK ,HERE>
		         <NOT <FSET? ,DUCK ,PHRASEBIT>>>>
		<RETURN ,DUCK>)
	       (<IN? ,ELF ,HERE>
		<RETURN ,ELF>)
	       (T
		<RFALSE>)>>

<ROUTINE FIND-WOMAN ()
	 <PUTP ,MAN-WOMAN ,P?SDESC "woman">
	 <COND (<AND <IN? ,ANTS ,HERE>
		     <NOT <FSET? ,ANTS ,OLDBIT>>>
		<RETURN ,ANTS>)
	       (<VISIBLE? ,MERMAID>
		<RETURN ,MERMAID>)
	       (<VISIBLE? ,WIFE>
		<RETURN ,WIFE>)
	       (<AND <IN? ,DEAN ,HERE>
		     <NOT <FSET? ,DEAN ,OLDBIT>>>
		<RETURN ,DEAN>)
	       (<AND <VISIBLE? ,PEARL>
		     <NOT <FSET? ,PEARL ,OLDBIT>>>
	        <RETURN ,PEARL>)
	       (<VISIBLE? ,WAITRESS>
		<RETURN ,WAITRESS>)
	       (T
		<RFALSE>)>>

<OBJECT NOT-HERE-OBJECT
	(DESC "it")
	(FLAGS NARTICLEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ (X <>))
	 <COND (<AND <PRSO? ,NOT-HERE-OBJECT>
		     <PRSI? ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       ;(<AND <EQUAL? ,P-XNAM ,W?BODY>
		     <EQUAL? ,P-XADJ ,W?MY <>>>
		<COND (<PRSO? ,NOT-HERE-OBJECT>
		       <SETG PRSO ,ME>)
		      (T
		       <SETG PRSI ,ME>)>
		<RFALSE>)
	       (<EQUAL? ,P-XNAM ,W?HAIR> ;"as syn for hair-raising experience"
		<WASTES>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <OR <EQUAL? ,P-XNAM ,W?POSSESSION>
			 <EQUAL? <GET ,P-OFW 0> ,W?POSSESSION>>>
		<TELL "You're getting too \"possessive\" now." CR>
		<RTRUE>)
	       (<AND <VERB? MAKE> ;"make adj obj of obj - to avoid 'be specif'"
		     <NOT <ZERO? <GET ,P-OFW 0>>>>
		<V-MAKE>
		<RTRUE>)
	       (<AND <EQUAL? ,P-XNAM ,W?HAND ,W?HANDS>
		     <EQUAL? ,P-XADJ ,W?BROTHER-IN-LAW ,W?BOB\'S ,W?BOBS>
		     <VERB? SHAKE TAKE>>
		<PERFORM ,V?SHAKE-WITH ,HANDS ,BOB>
		<RTRUE>)
	       (<AND <EQUAL? ,P-XNAM ,W?EYE ,W?EYES>
		     <EQUAL? ,P-XADJ ,W?HER>>
		<COND (<PRSO? ,NOT-HERE-OBJECT>
		       <SETG PRSO ,EYES>)
		      (T
		       <SETG PRSI ,EYES>)>
		<RFALSE>)
	       (<AND <EQUAL? ,P-XNAM ,W?SHOULDER>
		     <EQUAL? ,P-XADJ ,W?HER>>
		<COND (<PRSO? ,NOT-HERE-OBJECT>
		       <SETG PRSO ,SHOULDER>)
		      (T
		       <SETG PRSI ,SHOULDER>)>
		<RFALSE>)
	       (<AND <EQUAL? ,P-XNAM ,W?COMEUPPANCE>
		     <EQUAL? ,P-XADJ ,W?HER>>
		<COND (<PRSO? ,NOT-HERE-OBJECT>
		       <SETG PRSO ,COMEUPPANCE>)
		      (T
		       <SETG PRSI ,COMEUPPANCE>)>
		<RFALSE>) 
	       (<AND <EQUAL? ,P-XNAM ,W?DESSERTS>
		     <EQUAL? ,P-XADJ ,W?HER>>
		<COND (<PRSO? ,NOT-HERE-OBJECT>
		       <SETG PRSO ,DESSERTS>)
		      (T
		       <SETG PRSI ,DESSERTS>)>
		<RFALSE>)
	       (<AND <OR <EQUAL? ,P-XNAM ,W?HANDS ,W?HAND ,W?PALM>
			 <EQUAL? ,P-XNAM ,W?FINGER ,W?EYE ,W?EYES>
			 <EQUAL? ,P-XNAM ,W?FOOT ,W?FEET ,W?TOE ,W?TOES>
			 <EQUAL? ,P-XNAM ,W?NOSE ,W?MOUTH ,W?LIP ,W?LIPS>
			 <EQUAL? ,P-XNAM ,W?HEAD ,W?SPLEEN ,W?SHOULDER>>
		     <EQUAL? ,P-XADJ ,W?BOB\'S ,W?WAITRESS
			     ,W?PIPER\'S ,W?HORSE\'S ,W?DONKEY\'S
			     ,W?DOG\'S ,W?WIFE\'S ,W?LADY\'S ,W?GIRL\'S
			     ,W?JENNY\'S ,W?QUEEN\'S ,W?DEAN\'S
			     ,W?LEOPARD\'S ,W?GIANT\'S ,W?CLIENT\'S
			     ,W?ELF\'S ,W?JACK\'S ,W?MERMAID\'S ,W?WOMAN\'S
			     ,W?DUCK\'S ,W?MAYOR\'S ,W?MAN\'S ,W?HIS>>
		<TELL
"[You don't need to refer to that body part in such a manner.]" CR>
		<RTRUE>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (<AND .PRSO?
		     <PRSO-MOBY-VERB?>>
		<SET X T>)
	       (<AND <NOT .PRSO?>
		     <PRSI-MOBY-VERB?>>
		<SET X T>)>
	 <COND (.X ;"the verb is a moby-find verb"
		<COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		       <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
			      <RTRUE>)>)
		      (T
		       <RFALSE>)>
		<COND (<VERB? WALK-TO FOLLOW>
		       <V-WALK-AROUND>)
		      (T
		       <BE-MORE-SPECIFIC>)>)
	       (T
		<COND (<EQUAL? ,WINNER ,ME> ;"for YOU CANT VERB OBJECT"
		       <RFALSE>)            ;"OBJECT need not be here"
		      (<EQUAL? ,WINNER ,PROTAGONIST>
		       <TELL "You">)
		      (T
		       <TELL "Looking confused," T ,WINNER " says, \"I">)>
		<TELL " can't see">
		;<COND (<EQUAL? ,P-XNAM ,W?ODOR ,W?SMELL ,W?SCENT>
		       <TELL "smell">)
		      (T
		       <TELL "see">)>
		<COND (<NOT <NAME? ,P-XNAM>>
		       <TELL " any">)> 
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!">
		<COND (<NOT <EQUAL? ,WINNER ,PROTAGONIST>>
		       <TELL "\"">)>
		<CRLF>)>
	 <STOP>>

<ROUTINE PRSO-MOBY-VERB? ()
	 <COND (<OR <EQUAL? ,PRSA ,V?WHAT ,V?WHERE ,V?SSET>
		    <EQUAL? ,PRSA ,V?WAIT-FOR ,V?WALK-TO ,V?MAKE>
		    <EQUAL? ,PRSA ,V?BUY ,V?CALL ,V?SAY>
		    <EQUAL? ,PRSA ,V?FIND ,V?FOLLOW ,V?SSEARCH-OBJECT-FOR>
		    <EQUAL? ,PRSA ,V?NO-VERB ,V?RIDE-TO ,V?BUY-WITH>
		    <EQUAL? ,PRSA ,V?BUY-IN ,V?WHO ,W?PLAY>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRSI-MOBY-VERB? ()
	 <COND (<EQUAL? ,PRSA ,V?ASK-ABOUT ,V?ASK-FOR ,V?TELL-ABOUT ,V?SET
			      ,V?HAMMER ,V?SEARCH-OBJECT-FOR ,V?RIDE-OBJECT-TO
			      ,V?MOVE ,V?CLEAN-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

                   ;"Protocol: returns .OBJ if that's the one to use
  		    ,NOT-HERE-OBJECT if case was handled and msg TELLed
		    <> if WHICH-PRINT should be called"
<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
;"Special-case code goes here. <MOBY-FIND .TBL> returns # of matches. If 1,
then P-MOBY-FOUND is it. You can treat the 0 and >1 cases alike or differently.
Always return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	;<COND (,DEBUG
	       <TELL "[Found " N .M-F " obj]" CR>)>
	<COND (<EQUAL? 1 .M-F>
	       ;<COND (,DEBUG
		      <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<AND <L? 1 .M-F>
		    <SET OBJ <APPLY <GETP <SET OBJ <GET .TBL 1>> ,P?GENERIC>>>>
		   
		   ;"Protocol: returns .OBJ if that's the one to use
  		    ,NOT-HERE-OBJECT if case was handled and msg TELLed
		    <> if WHICH-PRINT should be called"
	       
	       ;<COND (,DEBUG
		      <TELL "[Generic: " D .OBJ "]" CR>)>
	       <COND (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
		      <RTRUE>)
		     (.PRSO?
		      <SETG PRSO .OBJ>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI .OBJ>)>
	       <RFALSE>)
	      (T
	       ,NOT-HERE-OBJECT)>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
	 <COND (,P-OFLAG
	        <COND (,P-XADJ
		       <TELL " ">
		       <PRINTB ,P-XADJ ;,P-XADJN>)> ;"classic to ezip"
	        <COND (,P-XNAM
		       <TELL " ">
		       <PRINTB ,P-XNAM>)>)
               (.PRSO?
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
               (T
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

;<OBJECT LOVE ;"for MAKE LOVE TO someone"
	(LOC GLOBAL-OBJECTS)
	(DESC "love")
	(SYNONYM LOVE)
	(FLAGS NARTICLEBIT)
	(ACTION LOVE-F)>

;<ROUTINE LOVE-F ("AUX" LOVER)
	 <COND (<VERB? MAKE>
		<COND (<SET LOVER <FIND-IN ,HERE ,ACTORBIT "to">>
		       <PERFORM ,V?FUCK .LOVER>
		       <RTRUE>)
		      (T
		       <TELL "Alone? How odd." CR>)>)>>

<OBJECT GLOBAL-SLEEP
	(LOC GLOBAL-OBJECTS)
	(DESC "sleep")
	(SYNONYM SLEEP NAP SNOOZE)
	(FLAGS NARTICLEBIT)
	(ACTION GLOBAL-SLEEP-F)>

<ROUTINE GLOBAL-SLEEP-F ()
	 <COND (<VERB? WALK-TO TAKE NO-VERB>
		<PERFORM ,V?SLEEP>
		<RTRUE>)
	       (<AND <VERB? PUT-TO>
		     <PRSI? ,GLOBAL-SLEEP>>
		<TELL "You're not a hypnotist." CR>)>>

<OBJECT GROUND
	(LOC GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND RUG CARPET)
	(SDESC "ground")
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<FSET? ,HERE ,INDOORSBIT>
		<PUTP ,GROUND ,P?SDESC "floor">)
	       (<EQUAL? ,HERE ,FLOOR-2>
		<PUTP ,GROUND ,P?SDESC "carpet">)
	       (T
		<PUTP ,GROUND ,P?SDESC "ground">)>
	 <COND (<AND <NOUN-USED ,GROUND ,W?CARPET ,W?RUG>
		     <NOT <EQUAL? ,HERE ,FLOOR-2>>>
		<CANT-SEE <> "carpet">)
	       (<AND <VERB? CLEAN>
		     <IN? ,BAD-BLOOD ,HERE>>
		<PERFORM ,V?CLEAN ,BAD-BLOOD>
		<RTRUE>)
	       (<AND <VERB? CALL>
		     <PRSO? ,WAITRESS>>
		<OFFENCE ,GROUND>)
	       (<AND <VERB? LOOK-UNDER>
		     <NOT <NOUN-USED ,GROUND ,W?CARPET>>>
		<IMPOSSIBLES>)
	       (<AND <NOUN-USED ,GROUND ,W?RUG ,W?CARPET>
		     <VERB? EXAMINE>>
		<TELL "It makes you think of the waitress's calling card." CR>)
	       (<VERB? MOVE ROLL>
		<TELL "It's a wall-to-wall carpet." CR>)
	       (<VERB? CLIMB-UP CLIMB-ON CLIMB BOARD>
		<COND (<AND <EQUAL? ,HERE ,ATTIC>
			    <FSET? ,ATTIC ,PHRASEBIT>>
		       <TELL 
"You climb the walls but can't get to the floor." CR>)
		      (T
		       <WASTES>)>)
	       (<VERB? LEAVE>
		<DO-WALK ,P?UP>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,BRITISH-ROOM>>
		<BRITISH-ROOM-F ,M-LOOK>
		<CRLF>)>>

<OBJECT WALL
	(LOC GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	(ACTION WALL-F)>

<ROUTINE WALL-F ()
	 <COND (<AND <NOT <FSET? ,HERE ,INDOORSBIT>>
		     <NOT <DONT-HANDLE ,WALL>>>
		<CANT-SEE ,WALL>)>>
               
<OBJECT CEILING
	(LOC GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILING ROOF)
	;(ADJECTIVE TOWERING)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<NOT <FSET? ,HERE ,INDOORSBIT>>
		<CANT-SEE ,CEILING>)
	       (<AND <VERB? MUNG RAISE>
		     <EQUAL? ,P-PRSA-WORD ,W?HIT ,W?RAISE>
		     <EQUAL? ,SCENE ,RESTAURANT>>
		<OFFENCE>)
	       (<VERB? LOOK-UNDER>
		<PERFORM ,V?LOOK>
		<RTRUE>)>>

<OBJECT WATER
	(LOC LOCAL-GLOBALS)
	(DESC "water")
	(SYNONYM WATER BATH BATHWATER)	
	(ADJECTIVE BATH HOT)
	(FLAGS NARTICLEBIT NDESCBIT TRYTAKEBIT)
	(ACTION WATER-F)>

;"PHRASEBIT = LEAD A HORSE TO WATER"

<ROUTINE WATER-F ()
	 <COND (<AND <NOT <DONT-HANDLE ,WATER>>
		     <EQUAL? ,HERE ,POND-ROOM>
		     <NOT <FSET? ,ICE ,RMUNGBIT>>
		     <NOT <IN? ,HOT-TUB ,HERE>>> ;"added"
		<CANT-SEE ,WATER>)
	       (<OR <AND <NOT <DONT-HANDLE ,WATER>>
		         <EQUAL? ,HERE ,BATHROOM>
		         ,BABY-THROWN>
		    <AND <NOT <EQUAL? ,HERE ,BATHROOM>>
			 <OR <NOUN-USED ,WATER ,W?BATHWATER>
			     <ADJ-USED ,WATER ,W?BATH>>>>
		<CANT-SEE ,WATER>)
	       (<VERB? DRINK BUY>
		<TELL "You're not thirsty." CR>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER EXAMINE>
		<TELL "The water is dark and murky." CR>)
	       (<VERB? REACH-IN>
		<TELL "Your hand is now wet." CR>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,WATER>>
		<PERFORM ,V?PUT ,PRSO ,WATER>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,WATER>
		     <EQUAL? ,HERE ,POND-ROOM>>
		<WASTES>)
	       (<AND <VERB? PUT>
		     <PRSI? ,WATER>
		     <EQUAL? ,HERE ,BATHROOM>>
		<PERFORM ,V?PUT ,PRSO ,TUB>
		<RTRUE>)
	       (<OR <VERB? ENTER BOARD>
		    <AND <VERB? TAKE>
			 <NOUN-USED ,WATER ,W?BATH>>>
		<COND (<EQUAL? ,HERE ,POND-ROOM>
		       <PERFORM ,V?ENTER ,ICE>
		       <RTRUE>)
		      (<VISIBLE? ,TUB>
		       <PERFORM ,V?ENTER ,TUB>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,SHORE>
		       <PERFORM ,V?SWIM ,RHINES>
		       <RTRUE>)>)
	       (<VERB? BOARD ENTER CRAWL-UNDER>
		<V-SWIM>)>>

;<OBJECT SKY
	(LOC GLOBAL-OBJECTS)
	(DESC "sky")
	(SYNONYM SKY)
	(ACTION SKY-F)>

;<ROUTINE SKY-F ()
	 <COND (<FSET? ,HERE ,INDOORSBIT>
		<CANT-SEE ,SKY>)>>

<OBJECT HANDS
	(LOC GLOBAL-OBJECTS)
	(SYNONYM HANDS HAND PALM FINGER)
	(ADJECTIVE BARE MY YOUR)
	(DESC "your hand")
	(FLAGS NDESCBIT TOUCHBIT NARTICLEBIT PARTBIT)
	(ACTION HANDS-F)>

;"RMUNGBIT = green thumb told in inventory"

<ROUTINE HANDS-F ("AUX" ACTOR)
	 <COND ;(<VERB? APPLAUD>
		<SETG PRSO <>>
		<V-APPLAUD>)
	       (<VERB? CLEAN>
		<WASTES>)  
	       (<VERB? SHAKE>
		<COND (<VISIBLE? ,BOB>
		       <PERFORM ,V?SHAKE-WITH ,HANDS ,BOB>
		       <RTRUE>)
		      (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT "with">>
		       <PERFORM ,V?SHAKE-WITH ,HANDS .ACTOR>
		       <RTRUE>)
		      (T
		       <TELL 
"There's no one here to shake hands with." CR>)>)
	       ;(<VERB? COUNT>
		<COND (<NOUN-USED ,W?FINGER ,HANDS>
		       <TELL "Ten">)
		      (T
		       <TELL "Two">)>
		<TELL ", as usual." CR>)
	       ;(<VERB? CLEAN>
		<TELL "Done." CR>)
	       (<AND <VERB? TAKE-WITH>
		     <PRSI? ,HANDS>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       ;(<AND <VERB? PUT-ON>
		     <PRSI? ,EYES>>
		<PERFORM ,V?SPUT-ON ,EYES ,HANDS>
		<RTRUE>)
	       ;(<AND <VERB? PUT-ON PUT>
		     <PRSI? ,EARS>>
		<PERFORM ,V?SPUT-ON ,EARS ,HANDS>
		<RTRUE>)>>

<OBJECT FOOT
	(LOC GLOBAL-OBJECTS)
	(SYNONYM FOOT FEET SHOE SHOES TOES TOE)
	(ADJECTIVE MY YOUR HOT)
	(SDESC "your foot")
	(FLAGS NDESCBIT TOUCHBIT NARTICLEBIT PARTBIT)
	(ACTION FOOT-F)>

;"WORNBIT = wearing your shoes"

<ROUTINE FOOT-F ()
	 <COND (<NOUN-USED ,FOOT ,W?SHOE ,W?SHOES>
		<PUTP ,FOOT ,P?SDESC "your shoe">)
	       (T
		<PUTP ,FOOT ,P?SDESC "your foot">)>
	 <COND (<AND <EQUAL? ,SCENE ,HAZING>
		     ,SWUM-IN-RHINES
		     <NOUN-USED ,FOOT ,W?SHOE ,W?SHOES>>
		<COND (<FSET? ,FOOT ,SEENBIT>
		       <TELL "You can't find, and don't need, your shoes">)
		      (T
		       <TELL 
"As so often happens after swimming
at the beach, you can't seem to locate where you left your shoes">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? TAKE-OFF>
		     <NOUN-USED ,FOOT ,W?SHOE ,W?SHOES>>
		<COND (<EQUAL? ,HERE ,SHORE>
		       <COND (<AND <EQUAL? ,P-PRSA-WORD ,W?SHAKE>
				   <NOUN-USED ,FOOT ,W?TOES ,W?TOE>>
			      <TELL
"Despite your wild shaking and gyrating, which recalls the most ambitious
of the early 60's beach-blanket movies, your toes stay on." CR>)
			     ;(,SWUM-IN-RHINES
			      <PERFORM ,V?SWIM ,RHINES>
			      <RTRUE>)
			     (<NOT ,PEARL-TO-RIVER>
			      <PERFORM ,V?SWIM ,RHINES> ;"ie, stay out"
			      <RTRUE>)
			     (T
			      <SETG SWUM-IN-RHINES T>
			      <MOVE ,PEARL ,PROTAGONIST>
			      <UPDATE-SCORE>
			      <TELL 
"Though you feel like a real beach nut, it does the trick. You now dive
deep into danger and pull out a gritty pearl from the bottom
of the river and come back to shore." CR>)>);"and put on your shoes. NO"
		      (T
		       <WASTES>)>)
	       (<AND <VERB? WEAR>
		     <NOUN-USED ,FOOT ,W?SHOE ,W?SHOES>>
		<TELL "You already are." CR>)>>
	       
;<ROUTINE ITEMS-CARRIED ("AUX" X (CNT 0))
	 <SET X <FIRST? ,PROTAGONIST>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN>)
		       (T ;<AND <NOT <FSET? .X ,WORNBIT>>
			     <NOT <EQUAL? .X ,COMIC-BOOK>>>
			<SET CNT <+ .CNT 1>>)>
		 <SET X <NEXT? .X>>>
	 <RETURN .CNT>>


;<GLOBAL HAND-COVER <>>

<OBJECT HEAD
	(LOC GLOBAL-OBJECTS)
	(DESC "your head")
	(SYNONYM HEAD ;HAIR)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PARTBIT)
	(ACTION HEAD-F)>

<ROUTINE HEAD-F ()
	 <COND (<AND <PRSO? ,HOUSE>
		     <NOT <FSET? ,HOUSE ,OLDBIT>>>
		<MOVE ,HOUSE ,PROTAGONIST>
		<SETG LOUSE-ON-HEAD T>
		<TELL "Done." CR>)
	       (<AND <VERB? TOUCH>
		     ,LOUSE-ON-HEAD>
		<PERFORM ,V?TAKE ,HOUSE>
		<RTRUE>)>>

<OBJECT SHOULDER
	(LOC GLOBAL-OBJECTS)
	(DESC "your shoulder")
	(SYNONYM SHOULDER SHOULDERS BREASTSTROKE SWIMMING
	         BACKSTROKE BACK-STROKE STROKE CRAWL)
	(ADJECTIVE YOUR MY BACK)
	(FLAGS NARTICLEBIT PARTBIT)
	(ACTION SHOULDER-F)>

;"seenbit = fly question m-beg"

<ROUTINE SHOULDER-F ()
	 <COND (<AND <VERB? NO-VERB>
		     <NOT <QUEUED? ,I-ORPHAN>>
		     <OR <NOUN-USED ,SHOULDER ,W?BACKSTROKE ,W?BACK-STROKE
				    ,W?BREASTSTROKE>
			 <NOUN-USED ,SHOULDER ,W?SWIMMING ,W?CRAWL>>>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)>>

<OBJECT SPLEEN
	(LOC GLOBAL-OBJECTS)
	(DESC "your spleen")
	(SYNONYM SPLEEN)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PARTBIT)
	(ACTION SPLEEN-F)>

<ROUTINE SPLEEN-F ()
	 <COND (<AND <VERB? VENT>
		     <PRSI? ,WAITRESS>>
		<OFFENCE>)
	       (<SEEING? ,SPLEEN>
		<PERFORM ,V?LOOK-INSIDE ,ME>
		<RTRUE>)>>

<OBJECT EYES
	(LOC GLOBAL-OBJECTS)
	(DESC "your eyes")
	(SYNONYM EYE EYES)
	(ADJECTIVE YOUR MY EVIL JAUNDICED)
	(FLAGS NARTICLEBIT PLURALBIT PARTBIT)
	(ACTION EYES-F)>

;"RMUNGBIT = used as phrasebit for evil eye case in restaurant"

<ROUTINE EYES-F ("AUX" ADJ)
	 <COND (<OR <ADJ-USED ,EYES ,W?EVIL>
		    <ADJ-USED ,EYES ,W?JAUNDICED>>
		<COND (<AND <NOT <EQUAL? ,SCENE ,RESTAURANT>>
		            <NOT <DONT-HANDLE ,EYES>>>
		       <TELL "You don't have such an eye now." CR>)
		      (<AND <ADJ-USED ,EYES ,W?EVIL ,W?JAUNDICED>
			    <VERB? EXAMINE>>
		       <COND (<PRSO? ,WAITRESS> ;"pre-give preforms examine"
		              <OFFENCE ,EYES>)
			     (<PRSO? ,COOK>
			      <TELL
"Such a glare couldn't melt butter in this joint." CR>)>)>)>>

;<OBJECT EARS
	(LOC GLOBAL-OBJECTS)
	(DESC "your ears")
	(SYNONYM EAR EARS)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PLURALBIT PARTBIT)
	;(ACTION EARS-F)>

<OBJECT NOSE
	(LOC GLOBAL-OBJECTS)
	(DESC "your nose")
	(SYNONYM NOSE NOSTRIL)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PARTBIT)
	;(ACTION NOSE-F)>

;<ROUTINE NOSE-F ()
	 <COND (<VERB? BLOW PICK>
		<TELL ,YECHH>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,P-PRSA-WORD ,W?HOLD>>
		<PERFORM ,V?SPUT-ON ,NOSE ,HANDS>
		<RTRUE>)
	       (<AND <VERB? UNCOVER>
		     <FSET? ,CLOTHES-PIN ,WORNBIT>
		     <NOT ,GONE-APE>>
		<COND (<EQUAL? ,NOSE ,HAND-COVER>
		       <SETG HAND-COVER <>>)>
		<PERFORM ,V?REMOVE ,CLOTHES-PIN>
		<RTRUE>)>>

<OBJECT MOUTH
	(LOC GLOBAL-OBJECTS)
	(DESC "your mouth")
	(SYNONYM MOUTH LIP LIPS)
	(ADJECTIVE YOUR MY)
	(FLAGS SEENBIT NARTICLEBIT PARTBIT)
	(ACTION MOUTH-F)>

<ROUTINE MOUTH-F ()
	 <COND (<AND <VERB? PUT>
		     <PRSI? ,MOUTH>>
		<PERFORM ,V?EAT ,PRSO>
		<RTRUE>)>>

;"Sheriff stands here next to his cop cars with triwrling silent blue lights
arranged in a road block just outside of town, tumbleweeds. Tall, muscular
square-jawed mirror-black glasses. Tilted. silent man with a toothpick angling out of his mouth. Tight-lipped. Leaning back against the care with his legs
and arms crossed.
If you want to try and help, I can deputize you. You are given a short
oath, and conclude it with I Do. (Now, we're just waiting
for the national guard, we've sent a messanger on foot, since all
communications have been jammed by whoever's messed up this town.) You can't
go beyond this point though. Three of my finest deputies have entered and
never come back... Need to be cool as a cucumber..."

;(LDESC  "[Hiking around in the country one day, you come upon a
wind-blown newspaper, pick it up and begin reading it while slowly
continuing to walk. From the unbelievable things you read, the paper
seems to be some kind of foolish joke, but you keep reading while not
being mindful of where you're going. When you finally decide the stories
are just too far-fetched and you're about to let fly with the newspaper,
your thoughts are abruptly interrupted as you bump into a road block and
hear the words:|
|
\"Whoa there!\"|
|
A sheriff is leaning against a
police car whose blue lights are silently rotating. He tilts his hat
back and sizes you up for a moment. \"Civic-minded,\" he says. \"Well,
so you've read about the troubles. It's good to see a new volunteer.\"
The sheriff recites a short oath. Stunned, you respond \"I do?\"|
|
\"Good enough. Okay, Deputy, you can do one of the following:|
|
"Go to
the Shopping Bizarre, Play Jacks, Buy the Farm, Eat your Words, Act the
Part, Visit the Manor of Speaking, Shake a Tower, or Meet the Mayor."]|
|
[To try another scene, restart back to here. The status line will tell
you exactly where you can go. Within each part of the story, you can
type just the name of the room you want to go to, rather than GO TO
(ROOM).]")

<ROOM STARTING-ROOM
      (LOC ROOMS)
      (DESC "Beginning")
      ;"when the leading figures of the town are those of speech" 
      (ACTION STARTING-ROOM-F)>  
   
<ROUTINE STARTING-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <CLOCKER-VERB?>
		     <OR <AND ,PRSO
		              <NOT <EQUAL? ,PRSO ,START-OBJ ,RANKS>>>
			 <NOT ,PRSO>>>
		<SHERIFF-ASKS T>
		<CRLF>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<COND (<FSET? ,STARTING-ROOM ,TOUCHBIT>
		       <SHERIFF-ASKS>
		       <RTRUE>)>
		<TELL
"We, the members of the Citizens' Action Committee, welcome you to our
mixed-up Town of Punster. You have no doubt already heard
about the nature of our troubles. Very giving of yourself indeed it is, for
you to help cleanse the land of every wrongful, wordful deed. In this time
when phraseology is practiced with mischief as the sole black art, when the
currency is debased with the ceaseless random coinage of words, when
verbicide is statistically the common household tragedy -- now is the time
when such a doer of good words is most welcome.|
|
We can see you are anxious to go now. So be off, but pick your words carefully;
weigh them upon the most delicate of scales. Watch out not only for your
P's and Q's, but your K's and M's as well. And while you're at it, watch
your R's.|
|
You can do one of the following: " <GETP ,AISLE ,P?PICK-IT> ", " 
<GETP ,JOAT ,P?PICK-IT> ", " <GETP ,FARM ,P?PICK-IT> ", "
<GETP ,RESTAURANT ,P?PICK-IT> ", " <GETP ,COMEDY ,P?PICK-IT> ", "
<GETP ,DUELING ,P?PICK-IT> ", " <GETP ,HAZING ,P?PICK-IT> ", or "
<GETP ,EIGHT ,P?PICK-IT> ".||
If at any time in your travels you wish to tackle another situation, indicate
BEGINNING, and you shall return here empty-handed.">)>>  

;">Play Jacks|
>Buy the Farm|
>Eat your Words|
>Act the Part|
>Visit the Manor of Speaking|
>Shake a Tower
>Meet the Mayor"

<GLOBAL MENU-FLAG <>>

<ROUTINE SHERIFF-ASKS ("OPT" (DAWDLE <>))
	 <COND (,MENU-FLAG
		<RTRUE>)>
	 <SETG MENU-FLAG T>
	 <COND (.DAWDLE
		<TELL
"There's no time to dawdle. You must">) 
	       (T
		<TELL "You now have the opportunity to">)>
	 <TELL " do one of the following:|">
	 <COND (<NOT <FSET? ,AISLE ,WONBIT>>
		<TELL CR ">" <GETP ,AISLE ,P?PICK-IT>>)>
	 <COND (<NOT <FSET? ,JOAT ,WONBIT>>
		<TELL CR ">" <GETP ,JOAT ,P?PICK-IT>>)>
	 <COND (<NOT <FSET? ,FARM ,WONBIT>>
		<TELL CR ">" <GETP ,FARM ,P?PICK-IT>>)>
	 <COND (<NOT <FSET? ,RESTAURANT ,WONBIT>>
		<TELL CR ">" <GETP ,RESTAURANT ,P?PICK-IT>>)>
	 <COND (<NOT <FSET? ,COMEDY ,WONBIT>>
		<TELL CR ">" <GETP ,COMEDY ,P?PICK-IT>>)>
	 <COND (<NOT <FSET? ,DUELING ,WONBIT>>
		<TELL CR ">" <GETP ,DUELING ,P?PICK-IT>>)>
	 <COND (<NOT <FSET? ,HAZING, WONBIT>>
		<TELL CR ">" <GETP ,HAZING ,P?PICK-IT>>)>
	 <COND (<NOT <FSET? ,EIGHT ,WONBIT>>
		<TELL CR ">" <GETP ,EIGHT ,P?PICK-IT>>)>
	 <RTRUE>>

<OBJECT START-OBJ 
	(LOC GLOBAL-OBJECTS)
	(DESC "scenario")
	(SYNONYM 
BIZARRE JACK JACKS FARM WORD WORDS PART MANOR SPEAKING TOWER MAYOR BEGINNING
BEGIN SCENARIO)
	(ADJECTIVE SHOPPING MY YOUR)
	(FLAGS NDESCBIT)
	(ACTION START-OBJ-F)>
;"Go to the Shopping Bizarre, Play Jacks, Buy the Farm, Eat your Words,
Act the Part, Visit the Manor of Speaking, or Shake a Tower."

<GLOBAL SCENE <>>

;<GLOBAL MAYOR-TOLD <>>

<GLOBAL RECORDS-SHOW <>>

<ROUTINE START-OBJ-F ("AUX" OBJ (CNT 0))
	 <COND ;(<AND <VERB? WALK-TO> ;"this moved to routine FINISHED"
		     <NOT <NOUN-USED ,START-OBJ ,W?BEGIN ,W?BEGINNING>>
		     <NOT <EQUAL? ,HERE ,STARTING-ROOM>>>
		<TELL
"You must first go to the BEGINNING before playing another scenario." CR>)
	       (<AND <VERB? WALK-TO NO-VERB>
		     <NOUN-USED ,START-OBJ ,W?BEGIN ,W?BEGINNING>>
		<RE-BEGIN>
		<RTRUE>)
	       (<VERB? WALK-TO>
		     ;<EQUAL? ,HERE ,STARTING-ROOM>
		<COND (<NOUN-USED ,START-OBJ ,W?FARM>
		       <COND (<FINISHED? ,FARM>
			      <RTRUE>)>
		       <MOVE ,GRINDSTONE ,LOFT>
		       <SETG HINT-TBL ,FARM-HINTS>
		       <TELL
"The farm crisis never seemed so desperate as it has this planting season
in Punster. One such family farm on the edge of town, the McCleary's, has
been especially blighted. The family, though well accustomed to hard work,
suddenly lost the ability to perform even the simplist of chores necessary to
scratch a living from the soil. They have since been driven from the land,
and join with their fellow Punster neighbors in urging you to somehow save the
family farm." CR CR>
		       <GO-TO-SCENE ,FARM>)
		      (<NOUN-USED ,START-OBJ ,W?JACKS ,W?JACK>
		       <SETG HINT-TBL ,JOAT-HINTS>
		       <COND (<FINISHED? ,JOAT>
			      <RTRUE>)>
		       <TELL 
"The oddities of language have been so prevalant in the town of Punster,
that surrounding communities have been similarly affected. One such bordering
town is Jackville, located in the northern backwoods region, but still
well within the realm of possibilities." CR CR>
		       <GO-TO-SCENE ,JOAT>)
		      (<NOUN-USED ,START-OBJ ,W?TOWER>
		       <COND (<FINISHED? ,HAZING>
			      <RTRUE>)>
		       <COND (,RESUME-DEAN
			      <SETG RESUME-DEAN <>>
			      <QUEUE I-DEAN -1>)>
		       <SETG HINT-TBL ,HAZING-HINTS>
		       <TELL
"In the dark forest outside the town boundries of Punster, chaos has been
the order of the day. On a recent afternoon the daughter of a leading citizen
of our town, out for a stroll among the tall pines, disappeared without
apparent trace. Rumor has it that one strange, stand-alone door is the only
means of escape from the forest. But no volunteer has yet been found to face
the oddball nature of the place. That is, until now." CR CR> 
		       <GO-TO-SCENE ,HAZING>)
		      (<NOUN-USED ,START-OBJ ,W?BIZARRE>
		       <COND (<FINISHED? ,AISLE>
			      <RTRUE>)>
		       <SETG HINT-TBL ,AISLE-HINTS>
		       <TELL "On a recent Friday night at the
Supermarket, the usual shopping frenzy suddenly turned into shopping
panic. Crazed bargain-hunters, recklessly pushing shopping carts before
them, were observed to stream from the aisles and out the market, many
of whom not even stopping to pause in the parking lot. Whatever it was
that caused the panic, one thing's for sure -- business has never been
the same. By restoring some semblance of order to this bizarre
situation, and perhaps purchasing some item or another, you can begin to
rebuild customer confidence." CR CR>
		       <COND (,RESUME-BRAT
			      <SETG RESUME-BRAT <>>
			      <QUEUE I-BRAT -1>)>
		       <COND (,RESUME-ANTS
			      <SETG RESUME-ANTS <>>
			      <QUEUE I-ANTS -1>)>
		       <GO-TO-SCENE ,AISLE>)
		      (<NOUN-USED ,START-OBJ ,W?WORDS ,W?WORD>
		       <SETG HINT-TBL ,RESTAURANT-HINTS>
		       <COND (<FINISHED? ,RESTAURANT>
			      <RTRUE>)>
		       <MOVE ,GRINDSTONE ,KITCHEN>
		       <TELL
"Indeed, eat your words. So widespread has this language virus become in
the Town of Punster, that the simple act of going out for a bite to eat
turns into a whole new adventure of its own. Enjoy." CR CR>  
		       <GO-TO-SCENE ,RESTAURANT>)
		      (<NOUN-USED ,START-OBJ ,W?PART>
		       <SETG HINT-TBL ,COMEDY-HINTS>
		       <COND (<FINISHED? ,COMEDY>
			      <RTRUE>)>
		       <TELL
"The foremost star of stage and scream in Punster, Brad Watkins, has left
behind our small-town difficulties in search of fame and fortune beyond
the purple horizon. We of course wish him the very worst of luck. It has
been very dashing of you to take the stage in his absence. With the proper
make-up applied, you're a side-splitting image." CR CR>
		       <MOVE ,COAT ,PROTAGONIST>
	               <FSET ,COAT ,WORNBIT>
	               <COND (<NOT <FSET? ,WIFE ,SEENBIT>>
			      <QUEUE I-WIFE -1>)>
		       <COND (<NOT <FSET? ,FRONT-ROOM ,TOUCHBIT>>
			      <SETG KNOCK-JOKE ,W?BOB>
			      <QUEUE I-KNOCK -1>)>
		       <GO-TO-SCENE ,COMEDY>)
		      (<NOUN-USED ,START-OBJ ,W?MANOR ,W?SPEAKING>
		       <SETG HINT-TBL ,DUELING-HINTS>
		       <COND (<FINISHED? ,DUELING>
			      <RTRUE>)>
		       <TELL
"The sad truth here is that the Manor of Speaking once enjoyed the reputation
as one of ">
		       <ITALICIZE "the">
		       <TELL " finest guest houses in the entire region
around Punster. But queer indeed is the fate it has suffered. The
various rooms of the house are actually possessed by the warped personalities
of by-gone visitors. The experience of a present-day guest to each of
the rooms is colored very strongly by the thoughts and indeed voice of
each ghostly presence. Needless to say, vacancy rates have gone through
the roof. Which leads us to the crucial problem with the Manor. Its
attic, as you will notice, is radically out of joint, situated ">
		       <ITALICIZE "below">
		       <TELL 
" the level of the first floor. It has been theorized that if this misplacement
could be dramatically rectified, the spirits who've worn out their welcome
might flee in horror. This is our hope, may it be your quest." CR CR> 
		       <GO-TO-SCENE ,DUELING>)
		      (<NOUN-USED ,START-OBJ ,W?MAYOR>
		       <COND (<FSET? ,SQUARE ,TOUCHBIT>
			      <FCLEAR ,SQUARE ,TOUCHBIT>
			      <SETG HINT-TBL ,EIGHT-HINTS>
			      <MOVE ,DECREE ,PROTAGONIST>
			      <SETG SCENE ,EIGHT>
			      <GOTO ,SQUARE>			      
			      <V-$REFRESH T> ;"so INIT-STATUS-LINE is called"
			      <RTRUE>)
			     (<TO-MAYOR?>
			      <RTRUE>)>
		       <REPEAT ()
			       <SET OBJ <PICK-NEXT ,RANK-TABLE>>
			       <COND (<EQUAL? .CNT 7>
				      <RETURN>) ;"passed test" 
				     (<NOT <FSET? .OBJ ,RANKBIT>>
				      <SETG RANK-Q .OBJ>
				      <RETURN>)>
			       <SET CNT <+ .CNT 1>>>
		       <COND (<AND <NOT <FSET? .OBJ ,RANKBIT>>
				   <EQUAL? ,HERE ,STARTING-ROOM>>
			      <QUEUE I-RANK 2>
			      <COND (<FSET? ,MOUTH ,SEENBIT>
				     <FCLEAR ,MOUTH ,SEENBIT>
				     <TELL
"The Committee has determined thus: The Mayor needs to be lobbied would
that he lay down the law regarding all manner of language play in the Town
of Punster. Only someone intimately familiar with our problems could
hope to succeed in winning over the Mayor, who has himself been beleaguered
by such problems." CR CR>)>
			      <COND (<NOT ,RECORDS-SHOW>
				     <SETG RECORDS-SHOW T>
			             <TELL
"Our records show you have not satisfactorily played " 
<GETP .OBJ ,P?PICK-IT> ". If we're mistaken you can prove it -- w">)
				    (T
				     <TELL "W">)>
			      <TELL
"hat is the rank from \"" <GETP .OBJ ,P?PICK-IT> "?\"" CR>
			      <RTRUE>)>
		       <RTRUE>)>)
	       (<AND <VERB? PLAY NO-VERB>
		     <NOUN-USED ,START-OBJ ,W?JACKS ,W?JACK>>
		<PERFORM ,V?WALK-TO ,START-OBJ>
		<RTRUE>)
	       (<AND <VERB? NO-VERB>
		     <OR <NOUN-USED ,START-OBJ ,W?BIZARRE>
			 <ADJ-USED ,START-OBJ ,W?SHOPPING>>>
		<PERFORM ,V?WALK-TO ,START-OBJ>
		<RTRUE>)
	       (<AND <VERB? BUY NO-VERB>
		     <NOUN-USED ,START-OBJ ,W?FARM>>
		<PERFORM ,V?WALK-TO ,START-OBJ>
		<RTRUE>)
	       (<AND <VERB? EAT NO-VERB>
		     <NOUN-USED ,START-OBJ ,W?WORD ,W?WORDS>>
		<PERFORM ,V?WALK-TO ,START-OBJ>
		<RTRUE>)
	       (<AND <VERB? PLAY NO-VERB>
		     <NOUN-USED ,START-OBJ ,W?PART>>
		<PERFORM ,V?WALK-TO ,START-OBJ>
		<RTRUE>)
	       (<AND <VERB? SHAKE NO-VERB>
		     <NOUN-USED ,START-OBJ ,W?TOWER>>
		<PERFORM ,V?WALK-TO ,START-OBJ>
		<RTRUE>)
	       (<AND <VERB? SHAKE NO-VERB>
		     <NOUN-USED ,START-OBJ ,W?MANOR ,W?SPEAKING>>
		<PERFORM ,V?WALK-TO ,START-OBJ>
		<RTRUE>)
	       (<AND <VERB? MEET NO-VERB>
		     <NOUN-USED ,START-OBJ ,W?MAYOR>>
		;<TELL 
"[Sheriff first will check knowledge of past scenes...]" CR CR>
		<PERFORM ,V?WALK-TO ,START-OBJ>
		<RTRUE>)
	       (<EQUAL? ,HERE ,STARTING-ROOM>
		<SHERIFF-ASKS T>
		<CRLF>
		<RTRUE>)
	       (T
		<CANT-SEE <> "such thing">)>>

<OBJECT RANKS 
	(LOC STARTING-ROOM)
	(DESC "ranking")
	(SYNONYM SUPERSAVER SODBUSTER GUEST JACKSTER KING COMEDY CUSTOMER KONG
	         SAVER CONG)
	(ADJECTIVE SUPER HONORED SATISFIED KINKERING)
	(FLAGS NDESCBIT)
	(ACTION RANKS-F)>

<GLOBAL RANK-Q <>> ;"scene of question of rank"

<ROUTINE I-RANK ()
	 <SETG RANK-Q <>>
	 <RFALSE>>

;"used with pick-next, score and rank-questions, element no. 1 is 2"
<GLOBAL RANK-TABLE
	<LTABLE
	 2
	 JOAT
	 AISLE
	 HAZING
	 DUELING
	 COMEDY
         FARM
	 RESTAURANT>>

<ROUTINE RANKS-F ()
	 <COND (<AND ,RANK-Q
		     <VERB? NO-VERB SUPER-BRIEF>> ;"for Super saver"
		<COND (<AND <EQUAL? ,RANK-Q ,JOAT>
			    <NOUN-USED ,RANKS ,W?JACKSTER>>
		       <YES-RIGHT>)
		      (<AND <EQUAL? ,RANK-Q ,COMEDY>
			    <NOUN-USED ,RANKS ,W?KING ,W?COMEDY>>
		       <YES-RIGHT>)
		      (<AND <EQUAL? ,RANK-Q ,FARM>
			    <NOUN-USED ,RANKS ,W?SODBUSTER>>
		       <YES-RIGHT>)
		      (<AND <EQUAL? ,RANK-Q ,DUELING>
			    <OR <NOUN-USED ,RANKS ,W?GUEST>
				<ADJ-USED ,RANKS ,W?HONORED>>>
		       <YES-RIGHT>)
		      (<AND <EQUAL? ,RANK-Q ,HAZING>
			    <OR <NOUN-USED ,RANKS ,W?CONG ,W?KONG>
				<ADJ-USED ,RANKS ,W?KINKERING>>>
		       <YES-RIGHT>)
		      (<AND <EQUAL? ,RANK-Q ,AISLE>
			    <OR <NOUN-USED ,RANKS ,W?SUPERSAVER ,W?SAVER>
				<ADJ-USED ,RANKS ,W?SUPER>>>
		       <YES-RIGHT>)
		      (<AND <EQUAL? ,RANK-Q ,RESTAURANT>
			    <OR <NOUN-USED ,RANKS ,W?CUSTOMER>
				<ADJ-USED ,RANKS ,W?SATISFIED>>>
		       <YES-RIGHT>)>)
	       (,RANK-Q
		<TELL 
"No, that's wrong. It is the determination of the Committee that it would
be fool-hardy to send you to lobby the Mayor without the invaluable experience
of \"" <GETP ,RANK-Q ,P?PICK-IT> ".\"" CR>)
	       (<VERB? NO-VERB>
		<TELL "You were asked no question." CR>)
	       (T
		<SHERIFF-ASKS T>
		<CRLF>)>>
	      
<ROUTINE YES-RIGHT ()
	 <FSET ,RANK-Q ,RANKBIT>
	 <COND (<TO-MAYOR?>
		<RTRUE>)>
	 <TELL "Yes, and..." CR CR>
	 <PUT ,P-NAMW 0 ,W?MAYOR>
	 <PERFORM ,V?MEET ,START-OBJ>
	 <RTRUE>>

<ROUTINE TO-MAYOR? ()
	 <COND (<AND <FSET? ,JOAT ,RANKBIT>
		     <FSET? ,RESTAURANT ,RANKBIT>
		     <FSET? ,DUELING ,RANKBIT>
		     <FSET? ,HAZING ,RANKBIT>
		     <FSET? ,COMEDY ,RANKBIT>
		     <FSET? ,AISLE ,RANKBIT>
		     <FSET? ,FARM ,RANKBIT>>
		<TELL 
"Okay, you have proved to the Committee wide knowledge of the nature of
our problems in Punster. You have now within your grasp the decree that
would legislate against, ban from the town, outlaw forever, all the
wordplayful shenanigans that have so tortured us. May our Mayor, the
honorable Jimmy \"Fat Baby\" Kazooli, act in the best interest of his
citizenry. You are sent..." CR CR>
		<SETG HINT-TBL ,EIGHT-HINTS>
		<SETG SCENE ,EIGHT>
		<MOVE ,DECREE ,PROTAGONIST>
		<GOTO ,SQUARE>
		<V-$REFRESH T> ;"so init-status is called"
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GO-TO-SCENE (SCENE-OBJ)
	 <SETG SCENE .SCENE-OBJ>
	 <FCLEAR <GETP .SCENE-OBJ ,P?SCENE-ROOM> ,TOUCHBIT>
	 <GOTO <GETP .SCENE-OBJ ,P?SCENE-ROOM>>
	 <V-$REFRESH T>> ;"so INIT-STATUS-LINE will split right, etc."

<ROUTINE RE-BEGIN ()
	 <COND (<EQUAL? ,HERE ,STARTING-ROOM>
		<TELL "You're already here." CR>
		<RTRUE>)
	       (<EQUAL? ,SCENE ,COMEDY>
		<COND (<RUNNING? ,I-MATCH>
                       <PERFORM ,V?OFF ,MATCH>
		       <RTRUE>)
		      (<OR <RUNNING? ,I-BOB>
			   <RUNNING? ,I-KNOCK>
			   <AND <RUNNING? ,I-WIFE>
				<NOT <ZERO? ,WIFE-N>>>>
		       <TELL
"You can't bow out now; this moment is too crucial to the artistic
integrity of the scene." CR>
		       <RTRUE>)>)
	       (<EQUAL? ,SCENE ,AISLE>
		<COND (<RUNNING? ,I-BRAT>
		       <DEQUEUE I-BRAT>
		       <SETG RESUME-BRAT T>
		       ;<RTRUE>)>
		<COND (<RUNNING? ,I-ANTS>
		       <DEQUEUE I-ANTS>
		       <SETG RESUME-ANTS T>
		       ;<RTRUE>)>
		<COND (<AND <HELD? ,MUSSELS>
			    <NOT <FSET? ,MUSSELS ,OLDBIT>>>
		       <REMOVE ,MUSSELS>)>)
	       (<EQUAL? ,SCENE ,JOAT>
		<COND (<RUNNING? ,I-FROST>
		       <TELL
"Such thoughts of escape from the cold evaporate into icy air." CR>
		       <RTRUE>)
		      (<EQUAL? <GETP ,PROTAGONIST ,P?ACTION> 
			       ,PROTAG-JACKHAMMER-F>
		       <RFALSE>)>
		<DO-JACK>)
	       (<AND <EQUAL? ,SCENE ,RESTAURANT>
		     <OR <RUNNING? ,I-PAN>
			 <RUNNING? ,I-DEVICES>
			 <RUNNING? ,I-PET-PEEVE>>>
		<TELL
"You can't leave at this crucial time!" CR>
		<RTRUE>)
	       (<EQUAL? ,SCENE ,HAZING>
		<COND (<RUNNING? ,I-CLIENT>
		       <TELL
"The stress involved from the situation prevents you from transporting." CR>
		       <RTRUE>)
		      (<OR <RUNNING? ,I-DEAN>
			   <QUEUED? ,I-DEAN>>
		       <SETG RESUME-DEAN T>)>
		<DE-LOUSE>)
	       (<AND <EQUAL? ,SCENE ,DUELING>
		     <RUNNING? ,I-CLOCK>>
		<SETG CLOCK-N 0>
		<DEQUEUE I-CLOCK>)>
	 <ROB ,PROTAGONIST ,HERE>
	 <PUTP ,SCENE ,P?SCENE-ROOM ,HERE>
	 <SETG SCENE <>>
	 <MOVE ,PROTAGONIST ,HERE> ;"so get off of vehicle first"
	 <SETG HERE ,STARTING-ROOM>
	 <V-$REFRESH> ;"and clearing all including 2nd status line"
	 <TELL 
"You are surrounded by a swirling, blinding cloud. You feel your limbs going
relaxed and your eyelids are buffeted with sand from the cloud." CR CR>
	 <SETG OLD-HERE <>>
	 <GOTO ,STARTING-ROOM>
	 <V-$REFRESH T> ;"bug was 2nd line of staus line didn't clear in"
	 <CRLF>         ;"beginning room after hint. cause: scrolled text"
	 <SHERIFF-ASKS> ;"didn't push it up under the first line of stat line"
	 <CRLF>         ;"added CRLF, hope enough text to push up now"
	 <RTRUE>>

<ROUTINE FINISHED? (SECTION)
	 <COND (<EQUAL? ,SCENE .SECTION>
		<TELL ,ARRIVED>
		<RTRUE>)
	       (<NOT <EQUAL? ,HERE ,STARTING-ROOM>>
		<TELL
"You must first go to the BEGINNING before playing another scenario." CR>
		<RTRUE>)
	       (<FSET? .SECTION ,WONBIT>
		<TELL 
"You have done all you possibly could have done there. We are grateful for
your skill in that place, and you needn't go back." CR>
		<RTRUE>)
	       (T ;"go to new section"
		<RFALSE>)>>

<ROUTINE UPDATE-SCORE ("AUX" POINTS)
	 <SET POINTS <+ <GETP ,SCENE ,P?SCENE-SCORE> 1>>
	 <PUTP ,SCENE ,P?SCENE-SCORE .POINTS>
	 <SETG UPDATE-SCORE? T>
	 ;<V-$REFRESH T> ;"should do this before printing prompt"
	 <COND (<AND <EQUAL? <GETP ,SCENE ,P?SCENE-SCORE>
			     <GETP ,SCENE ,P?MAX-SCORE>>
		     <NOT <EQUAL? ,SCENE ,EIGHT>>>
		<FSET ,SCENE ,WONBIT>
		<SETG P-CONT <>>
		<QUEUE I-END-SCENE 1>)>
	 <RTRUE>>

<ROUTINE I-END-SCENE ()
	 <ROB ,PROTAGONIST ,HERE>
	 <MOVE ,PROTAGONIST ,HERE> ;"so veh don't go with him in GOTO"
	 <SETG OLD-HERE <>>
	 <PUTP ,SCENE ,P?SCENE-ROOM ,HERE>
	 <SETG LOUSE-ON-HEAD <>>
	 <COND (<EQUAL? ,SCENE ,FARM>
		<FSET ,FARM ,RANKBIT>
		<TELL CR  "Congratulations for the completion of these
19 chores. You have transformed their abandoned husk of a farm into a horn of
plenty. The McCleary's, under your tutelage, have learned much about
how to manage their farm, coping with the tough realities of modern
farming. After this long period of want, the townspeople of Punster will
feast heartily upon the fruits of your labor. You shall be honored by
them with the rank of ">
		<HLIGHT ,H-BOLD>
		<TELL "Sodbuster">
		<HLIGHT ,H-NORMAL>
		<TELL ".">
		<WARN-PLAYER>)
	       (<EQUAL? ,SCENE ,COMEDY>
		<FSET ,COMEDY ,RANKBIT>
		<TELL CR "\"Cut! Cut!\" booms an off-stage, directoral
voice. \"It's a wrap.\" Drenched in the sweat of your comedic toil, you
bask in the adoration of the cheerful Punster audience. Having milked
this bit for the maximum number of cheap gags, namely 10, you have
achieved the status of ">
		<HLIGHT ,H-BOLD>
		<TELL "King of Comedy">
		<HLIGHT ,H-NORMAL>
		<TELL ".">
		<WARN-PLAYER>)
	       (<EQUAL? ,SCENE ,AISLE>
		<COND (<RUNNING? ,I-BRAT>
		       <DEQUEUE I-BRAT>
		       <SETG RESUME-BRAT T>)>
		<COND (<RUNNING? ,I-ANTS>
		       <DEQUEUE I-ANTS>
		       <SETG RESUME-ANTS T>)>
		<COND (<AND <HELD? ,MUSSELS>
			    <NOT <FSET? ,MUSSELS ,OLDBIT>>>
		       <REMOVE ,MUSSELS>)>
		<TELL CR "Bravo! Cheer! Kudos! With your feats of
homonymic skill, you have shown the way to restoring customer confidence
to the puzzled shoppers of Punster. Having broken the tape at the end
of your Bizarre shopping spree, you thusly achieve the esteemed rank of ">
		<HLIGHT ,H-BOLD>
		<TELL "Super Saver">
		<HLIGHT ,H-NORMAL>
		<TELL ".">
		<MORE-SCORE ,AISLE "in the Shopping Bizarre">)
	       (<EQUAL? ,SCENE ,DUELING>
		<COND (<RUNNING? ,I-CLOCK>
		       <SETG CLOCK-N 0>
		       <DEQUEUE I-CLOCK>)>
		<TELL CR
"Congratulations. Having rid the manor of its unwanted, if spirited,
visitors you thereby, in the eyes of the Citizens' Action Committee,
earn the title of ">
		<HLIGHT ,H-BOLD>
		<TELL "Honored Guest">
		<HLIGHT ,H-NORMAL>
		<TELL ".">
		<MORE-SCORE ,DUELING "visiting the Manor of Speaking">)
	       (<EQUAL? ,SCENE ,JOAT>
		<DO-JACK>
		<TELL CR
"Congratulations. You have been nimble and you have been quick. Punster will
from here on out enjoy better relations with its northern neighbor, Jackville.
The Citizen's Action Committee does hereby confer upon you the title of ">
		<HLIGHT ,H-BOLD>
		<TELL "Jackster">
		<HLIGHT ,H-NORMAL>
		<TELL ".">
		<MORE-SCORE ,JOAT "playing jacks">)
	       (<EQUAL? ,SCENE ,HAZING>
		<COND (<OR <RUNNING? ,I-DEAN>
		           <QUEUED? ,I-DEAN>>
		       <SETG RESUME-DEAN T>)>
		<DE-LOUSE>
		<TELL CR
"Congratulations are in order. Having braved mutable strangeness and
having made the heroic gesture of a rescue, you make possible the reuniting
in joy of a grateful Punster family. This feat earns you the rank of ">
		<HLIGHT ,H-BOLD>
		<TELL "Kinkering Cong">
		<HLIGHT ,H-NORMAL>
		<TELL ".">
		<MORE-SCORE ,HAZING "shaking a tower">)
	       (<EQUAL? ,SCENE ,RESTAURANT>
		<TELL CR
"Congratulations are in order. You're ranked as..." CR>
		<HLIGHT ,H-BOLD>
		<TELL "Satisfied Customer">
		<HLIGHT ,H-NORMAL>
		<TELL ".">
		<MORE-SCORE ,RESTAURANT "eating your words">)>
	 <SETG SCENE <>>
	 <TELL CR CR>
	 <GOTO ,STARTING-ROOM>
	 <SHERIFF-ASKS>
	 <CRLF>
	 <V-$REFRESH T>
	 <RTRUE>>

<ROUTINE DO-JACK ()
	 <COND (,JACK-IS
		<COND (<EQUAL? ,JACK-IS ,FAUCET>
		       ;<REMOVE ,HOT-TUB>
		       <REMOVE ,TUB-WATER>
		       <REMOVE ,MERMAID>)>
		<CHANGE-JACK>
		<REMOVE ,HOT-TUB>)>
	 <RTRUE>>

<ROUTINE DE-LOUSE ("AUX" X)
	 <SET X <LOC ,HOUSE>>
	 <COND (<AND .X
		     <NOT <IN? <LOC ,HOUSE> ,ROOMS>>>
		<SETG LOUSE-ON-HEAD <>>
		<FSET ,HOUSE ,OLDBIT>
		<MOVE ,HOUSE <META-LOC ,HOUSE>> ;"if in something"
		<FCLEAR ,HOUSE ,TAKEBIT>
		<FCLEAR ,HOUSE ,NDESCBIT>)>
	 <RTRUE>>

<GLOBAL RANK-WARNING <>>

<ROUTINE WARN-PLAYER ()
	 <COND (<NOT ,RANK-WARNING>
		<SETG RANK-WARNING T>
		<TELL CR CR
"It would be prudent to commit to memory this and all ranks you have
achieved.">)>
	 <RTRUE>>

<ROUTINE MORE-SCORE (SC STR "AUX" NUM)
	 <WARN-PLAYER>
	 <COND (<AND <SET NUM <- <GETP .SC ,P?MAX-SCORE>
				 <GETP .SC ,P?SCENE-SCORE>>>
		     <NOT <ZERO? .NUM>>>
		<TELL CR CR "(Truth is, there ">
		<COND (<EQUAL? .NUM 1>
		       <TELL "was one more thing">)
		      (T
		       <TELL "were " N .NUM " more things">)>
		<TELL 
		 " that could've been accomplished " .STR ".)">)>
	 <FSET .SC ,RANKBIT>
	 <RTRUE>>

<OBJECT PROTAGONIST
	(LOC STARTING-ROOM)
	(SYNONYM PROTAG)
	(DESC "it")
	(FLAGS NDESCBIT INVISIBLE ACTORBIT)
	(ACTION PROTAGONIST-F)>
;"amfv's PLAYER has no actorbit, but changed THIS-IT? prevents finding protag"

<ROUTINE PROTAGONIST-F ()
	 <RFALSE>>

<ROUTINE PROTAG-JACKHAMMER-F ()
         <INC JACKHAMMER-C> ;"2 3 4 "
	 <COND (<OR <AND <VERB? OFF>
		         <PRSO? ,ELECTRICAL-SWITCH>>
		    <EQUAL? ,JACKHAMMER-C 5>> ;"after 3rd str printed"
		<SETG JACKHAMMER-C 0>
		<PUTP ,PROTAGONIST ,P?ACTION ,PROTAGONIST-F>
		<CHANGE-JACK>
		<TELL 
"One hand slips off the handle and hits the switch. The jackhammer
coughs, wheezes and shudders to a halt. All the features of the " 
D ,JOAT " return." CR>)
	       (,WIDE
		<TELL <PICK-NEXT ,S-JACKHAMMER>>)
	       (T
		<TELL "You can't even hear yourself think." CR>)>>
		      
<OBJECT ME
	(LOC GLOBAL-OBJECTS)
	(SYNONYM I ME MYSELF SELF YOU YOURSELF)
	(DESC "yourself")
	(FLAGS ;ACTORBIT TOUCHBIT NARTICLEBIT)
	(ACTION ME-F)>

<ROUTINE ME-F () 
	 <COND (<EQUAL? ,ME ,WINNER> ;"YOU CANT VERB SOMETHING"
		<SETG CANT-FLAG <>>
		<TELL "You never know till you've tried." CR>)
	       (<AND <VERB? TELL>
		     <NOT ,CANT-FLAG>>
		<TELL
"Talking to yourself is a sign of impending mental collapse." CR>
		<STOP>)
	       (<VERB? ALARM>
		<TELL "You are already awake." CR>)
	       (<VERB? EXAMINE>
		<COND (<AND <NOT <FSET? ,MUSSELS ,OLDBIT>>
			    <IN? ,MUSSELS ,PROTAGONIST>
			    <EQUAL? ,SCENE ,AISLE>>
		       <TELL
"You're considerably more sinewy since your recent muscle graft">)
		      (T
		       <TELL "You're bright-eyed and bushy-tailed">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,ME>
		     <NOT <PRSO? ,LOBOTOMY>>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<AND <VERB? SHOW>
		     <PRSI? ,ME>>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (<VERB? MOVE>
		<V-WALK-AROUND>)
	       (<VERB? SEARCH>
		<V-INVENTORY>
		<RTRUE>)
	       ;(<VERB? EXAMINE>
		<COND (,GONE-APE
		       <TELL "You've gone ape!" CR>)
		      (T
		       <TELL "You're wearing">
		       <COND (<FSET? ,WHITE-SUIT ,WORNBIT>
			      <TELL AR ,WHITE-SUIT>)
			     (T
			      <TELL AR ,GARMENT>)>)>)
	       (<VERB? KILL MUNG>
		<JIGS-UP "Done.">)
	       (<VERB? FIND WHERE>
		<TELL "You're in" TR ,HERE>)>>

<OBJECT GLOBAL-ROOM
	(LOC GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM PLACE LOCATI AREA THERE)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK LOOK-INSIDE EXAMINE>
		<V-LOOK>)
	       (<VERB? ENTER WALK-TO>
		<V-WALK-AROUND>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<DO-WALK ,P?OUT>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)
	       (<AND <VERB? PUT>
		     <PRSI? ,GLOBAL-ROOM>>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?THROW>
		       <PERFORM ,V?THROW ,PRSO>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>)>>

<OBJECT SIGN
	(LOC LOCAL-GLOBALS)
	(DESC "sign")
	(SYNONYM SIGN)
	(ADJECTIVE LARGE)
	(FLAGS READBIT TRYTAKEBIT)
	(ACTION SIGN-F)>

<ROUTINE SIGN-F ("AUX" NUM)
	 <COND ;(<AND <EQUAL? ,HERE ,CANAL>
		     <NOT <EQUAL? .NUM 15>>>
		<CANT-SEE ,SIGN>)
	       (<VERB? READ EXAMINE>
		<COND (<EQUAL? ,HERE ,BRITISH-ROOM>
		       <TELL 
"Large block letters proclaim:|
|"
D ,PUTTING ,PERIOD>)
		      (<EQUAL? ,HERE ,NEAR-POND>
		       <COND (<VERB? EXAMINE>
			      <TELL
"The sign is heavily saddled with icicles. ">)>
		       <TELL 
"It reads:|
|
NO DANGER! THICK ICE|">)>)
	       (<AND <EQUAL? ,HERE ,NEAR-POND>
		     <VERB? TAKE>>
		<TELL "It's frozen solidly." CR>)>>

<OBJECT STAIRS
	(LOC LOCAL-GLOBALS)
	(DESC "stair")
	(SYNONYM STAIR STAIRS STAIRWAY STEP STAIRCASE)
	(ADJECTIVE STURDY RICKETY MARBLE)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<AND <FSET? ,ATTIC ,PHRASEBIT>
		     <EQUAL? ,HERE ,ID-ROOM>>
		<TELL "The stairs have disappeared." CR>)
	       (<AND <NOT <FSET? ,ATTIC ,PHRASEBIT>>
		     <EQUAL? ,HERE ,KREMLIN>>
		<CANT-SEE ,STAIRS>)
	       (<VERB? CLIMB-ON>
		<WASTES>)
	       (<VERB? CLIMB CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)
	       (<AND <VERB? THROW>
		     <PRSI? ,STAIRS>>
		<WASTES>)>>

;<OBJECT WINDOW
	(LOC LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW VIEWPORT GLASS)
	(ADJECTIVE RECTAN STAINED GLASS BARRED SMALL GRIMY)
	(ACTION WINDOW-F)>

;<ROUTINE WINDOW-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,OBSERVATION-ROOM>
		       <SETG SEEN-EXAMINATION-ROOM T>
		       <TELL ,YOU-SEE " a large room below. ">
		       <EXAMINATION-ROOM-DESC T>)
		      (<EQUAL? ,HERE ,BEDROOM>
		       <MOVE ,FORD ,HERE>
		       <COND (<FSET? ,HEADLIGHT ,TRYTAKEBIT>
			      <MOVE ,HEADLIGHT ,HERE>)>
		       <MOVE ,FORD ,HERE>
		       <TELL
"A car is parked on the street, twenty feet below. It's a Ford, a 1933 Ford
... and one of its " 'HEADLIGHT "s is ">
		       <COND (<AND <IN? ,HEADLIGHT ,HERE>
				   <FSET? ,HEADLIGHT ,TRYTAKEBIT>>
			      <TELL "loose">)
			     (T
			      <TELL "missing">)>
		       <TELL ,PERIOD>)
		      (<EQUAL? ,HERE ,HOLD>
		       <TELL ,YOU-SEE " Saturn and her ample rings.">
		       <COND (<NOT <EQUAL? ,SPACESHIP-SCENE-STATUS 1>>
			      <TELL
" Much closer, no more than a hundred feet away, is"
A ,PASSENGER-SHIP ". Judging by the steam blowing from
her ion engines, she's preparing to depart.">)>
		       <CRLF>)
		      (<EQUAL? ,HERE ,JOES-BAR>
		       <TELL
"It's raw and blowy outside. Little whirlpools of dust dance by." CR>)
		      (<EQUAL? ,HERE ,SOUTH-POLE>
		       <COND (<FSET? ,ORPHANAGE-FOYER ,TOUCHBIT>
			      <TELL "The window is fogged." CR>)
			     (T
		       	      <SETG COTTON-BALLS-SEEN T>
			      <MOVE ,COTTON-BALLS ,HERE> ;"so you can refer"
			      <TELL
,YOU-SEE " a " 'COTTON-BALLS " sitting in an entrance foyer." CR>)>)
		      (<EQUAL? ,HERE ,ORPHANAGE-FOYER>
		       <TELL ,YOU-SEE " an icy plain." CR>)
		      (<EQUAL? ,HERE ,MAIN-HALL-OF-PALACE>
		       <TELL "Colored light spills through the window." CR>)>)
	       (<VERB? OPEN>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <TELL ,ALREADY-IS>)
		      (T
		       <TELL "It's not that kind of window." CR>)>)
	       (<VERB? CLOSE>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <TELL "It seems stuck." CR>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (<AND <VERB? PUT-THROUGH PUT>
		     <PRSI? ,WINDOW>
		     <EQUAL? ,HERE ,BEDROOM>>
		<COND (<PRSO? ,HANDS>
		       <TELL ,HUH>)
		      (<IN? ,PROTAGONIST ,BED>
		       <CANT-REACH ,PRSI>)
		      (<AND <PRSO? ,SHEET>
			    <OR ,SHEET-HANGING
				,SHEET-TIED>>
		       <RFALSE> ;"SHEET-F handles it")
		      (T
		       <REMOVE ,PRSO>
		       <PRONOUN>
		       <TELL " land">
		       <COND (<NOT <FSET? ,PRSO ,PLURALBIT>>
			      <TELL "s">)>
		       <TELL
" on the street below. An urchin dashes up and runs off with" TR ,PRSO>)>)
	       (<AND <VERB? EMPTY-FROM>
		     <PRSI? ,WINDOW>
		     <EQUAL? ,HERE ,BEDROOM>>
		<PERFORM ,V?EMPTY ,PRSO ,WINDOW>
		<RTRUE>) 
	       (<VERB? ENTER EXIT DISEMBARK LEAP-OFF>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <COND (,SHEET-HANGING
			      <PERFORM ,V?CLIMB-DOWN ,SHEET>
			      <RTRUE>)
			     (T
		       	      <PLUMMET-TO-PAVEMENT>)>)
		      (<EQUAL? ,HERE ,SOUTH-POLE ,ORPHANAGE-FOYER>
		       <TELL "It's barred!" CR>)
		      (<EQUAL? ,HERE ,OBSERVATION-ROOM>
		       <DO-WALK ,P?WEST>)
		      (T
	               <DO-FIRST "open" ,WINDOW>)>)>>

;"status line stuff"

<CONSTANT S-TEXT 0>       ;"<SCREEN 0> puts cursor in text part of screen"
<CONSTANT S-WINDOW 1>     ;"<SCREEN 1> puts cursor in window part of screen"
<CONSTANT H-NORMAL 0>     ;"<HLIGHT 0> returns printing to normal (default)"
<CONSTANT H-INVERSE 1>    ;"<HLIGHT 1> sets printing mode to inverse video"
<CONSTANT H-BOLD 2>       ;"<HLIGHT 2> sets printing mode to bold, else normal"
<CONSTANT H-ITALIC 4>     ;"<HLIGHT 4> italicizes, else underline, else normal"
<CONSTANT D-SCREEN-ON 1>  ;"<DIROUT 1> turns on printing to the screen"
<CONSTANT D-SCREEN-OFF -1>;"<DIROUT -1> turns off printing to the screen"
<CONSTANT D-PRINTER-ON 2> ;"<DIROUT 2> turns on printing to the printer"
<CONSTANT D-PRINTER-OFF -2>;"<DIROUT -2> turns off printing to the printer"
<CONSTANT D-TABLE-ON 3>   ;"<DIROUT 3 .TABLE> turns on printing to that table"
<CONSTANT D-TABLE-OFF -3> ;"<DIROUT -3> turns off printing to that table"
;<CONSTANT D-RECORD-ON 4>  ;"<DIROUT 4> sends READs and INPUTs to record file"
;<CONSTANT D-RECORD-OFF -4>;"<DIROUT -4> stops sending READs and INPUTs to file"

;"gets called only at START of game unless otherwise"

<ROUTINE INIT-STATUS-LINE ("OPT" (DONT-CLEAR <>)) ;"clear screen"
	 <SETG OLD-HERE <>>
	 <SETG UPDATE-SCORE? T>
	 <BUFOUT <>>
	 <COND (<NOT .DONT-CLEAR>
		<CLEAR -1>)>
	 <COND (<EQUAL? ,HERE ,STARTING-ROOM>
		<SPLIT 1>)
	       (T
                <SPLIT 2>)>
	 <SCREEN ,S-WINDOW>
	 ;<BUFOUT <>> ;"moved to top of routine"
	 <HLIGHT ,H-INVERSE>
	 <CURSET 1 1>
	 <PRINT-SPACES ,WIDTH>
	 <COND (<NOT <EQUAL? ,HERE ,STARTING-ROOM>>
		<CURSET 2 1>
	        <PRINT-SPACES ,WIDTH>)>
	 
	 <CURSET 1 2>
	 <COND (,WIDE
		<COND (,DATELINE
		       <TELL "Dateline:">)
		      (T
		       <TELL "Location:">)>)>
	 <COND (<NOT <EQUAL? ,HERE ,STARTING-ROOM>>
		<CURSET 2 2>
	        <COND (<NOT ,WIDE>
		       <TELL "Go">)
	              (<EQUAL? ,SCENE ,AISLE>
		       <TELL "Other aisles">)
	              (T
		       <TELL "You can go">)>
	               <PRINTC %<ASCII !\:>>)>
	 
	 <HLIGHT ,H-NORMAL>
	 <SCREEN ,S-TEXT>
	 <BUFOUT T>
	 <RFALSE>>

<ROUTINE PRINT-SPACES (CNT)
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0>
			<RETURN>)
		       (T
			<PRINTC 32>)>>>

<GLOBAL SLINE <ITABLE NONE 82>>
<GLOBAL OLD-HERE <>> ;"is set to present HERE room."
<GLOBAL UPDATE-SCORE? <>>

<ROUTINE ITALICIZE (STR "OPTIONAL" (NO-CAPS? <>)
			"AUX" LEN (PTR 2) CHAR ;(SCRIPTING-ON <>))
	 ;<BUFOUT <>>
	 ;<BUFOUT T>
	 ;<COND (<BTST <GET 0 8> 1>
		<SET SCRIPTING-ON T>)>
	 ;<COND (.SCRIPTING-ON
		<DIROUT ,D-PRINTER-OFF>)>
	 <DIROUT ,D-SCREEN-OFF>
	 <DIROUT ,D-TABLE-ON ,SLINE>
	 <TELL .STR>
	 <DIROUT ,D-TABLE-OFF>
	 ;<COND (.SCRIPTING-ON
		<DIROUT ,D-PRINTER-ON>)>
	 ;<COND (<NOT <VERB? SCRIPT UNSCRIPT>>
		<DIROUT ,D-SCREEN-ON>)>
	 <DIROUT ,D-SCREEN-ON>
	 <SET LEN <+ <GET ,SLINE 0> 1>>
	 <COND (<EQUAL? .LEN 1>
		<RTRUE>)
	       (<OR <ZERO? <GETB 0 18>>  ; "ZIL?"
		    <BAND <GETB 0 1> 8>> ; "ITALICS BIT SET?"
		<HLIGHT ,H-ITALIC>
		<REPEAT ()
			<SET CHAR <GETB ,SLINE .PTR>>
			<COND (<EQUAL? .CHAR 32> ; "SPACE?"
			       <HLIGHT ,H-NORMAL>
			       <PRINTC 32>
			       <HLIGHT ,H-ITALIC>)
			      (T
			       <PRINTC .CHAR>)>
			<COND (<EQUAL? .PTR .LEN>
			       <RETURN>)
			      (T
			       <SET PTR <+ .PTR 1>>)>>
		<HLIGHT ,H-NORMAL>)
	       (.NO-CAPS?
		<TELL .STR>)
	       (T                       ; "NO ITALICS, CAPITALIZE"
		<REPEAT ()
			<SET CHAR <GETB ,SLINE .PTR>>
			<COND (<AND <G? .CHAR 96>
				    <L? .CHAR 123>>
			       <SET CHAR <- .CHAR 32>>)>
			<PRINTC .CHAR>
			<COND (<EQUAL? .PTR .LEN>
			       <RETURN>)
			      (T
			       <SET PTR <+ .PTR 1>>)>>)>>

<ROUTINE SEEING? (OBJ)
	 <COND (<AND <PRSO? .OBJ>
		     <EQUAL? ,PRSA 
		 ,V?EXAMINE ,V?LOOK ,V?LOOK-INSIDE ,V?READ ,V?FIND
		 ,V?SEARCH ,V?SHOW ,V?LOOK-UNDER ,V?LOOK-BEHIND 
		 ,V?LOOK-DOWN ,V?LOOK-UP ,V?READ-TO ,V?COUNT
		 ,V?POINT>>
	        <RTRUE>)
	       (T
	        <RFALSE>)>>

<ROUTINE TOUCHING? (THING)
	 <COND (<AND <PRSO? .THING>
		     <OR <EQUAL? ,PRSA ,V?TAKE ,V?TOUCH ,V?SHAKE>
			 <EQUAL? ,PRSA ,V?CLEAN ,V?KISS ;,V?SWIM>
			 <EQUAL? ,PRSA ,V?PUSH ,V?CLOSE ,V?LOOK-UNDER>
			 <EQUAL? ,PRSA ,V?MOVE ,V?OPEN ,V?KNOCK>
			 <EQUAL? ,PRSA ,V?SET ,V?SHAKE ,V?RAISE>
			 <EQUAL? ,PRSA ,V?UNLOCK ,V?LOCK ,V?CLIMB-UP>
			 <EQUAL? ,PRSA ,V?CLIMB ,V?CLIMB-DOWN ,V?CLIMB-ON>
			 <EQUAL? ,PRSA ,V?BOARD ,V?ENTER ,V?ON>
			 <EQUAL? ,PRSA ,V?OFF ,V?TASTE ,V?THROW>
			 <EQUAL? ,PRSA ,V?LOOK-INSIDE ,V?STAND-ON ,V?TIE>
			 <EQUAL? ,PRSA ,V?MUNG ,V?KICK ,V?KILL>
			 <EQUAL? ,PRSA ,V?KNOCK ,V?CUT ,V?TIE-TOGETHER>
			 <EQUAL? ,PRSA ,V?BITE ,V?PUSH ,V?LOOK-BEHIND>>>
		<RTRUE>)
	       (<AND <PRSI? .THING>
		     <VERB? GIVE PUT PUT-ON>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DONT-HANDLE (OBJ)
	 <COND (<OR <AND <EQUAL? .OBJ ,PRSO>
			 <PRSO-MOBY-VERB?>>
		    <AND <EQUAL? .OBJ ,PRSI>
			 <PRSI-MOBY-VERB?>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>
;"this routine is fucked. When prsi is passed, PRSO is often printed. Fucked"
<ROUTINE CANT-SEE ("OPTIONAL" (OBJ <>) (STRING <>))
	 <SETG P-WON <>>
	 <TELL ,YOU-CANT "see">
	 ;<COND (<EQUAL? .OBJ ,ODOR>
		<TELL "smell">)
	       (T
		<TELL "see">)>
	 <COND (<OR <NOT .OBJ>
		    <AND .OBJ
			 <NOT <NAME? .OBJ>>>>
		<TELL " any">)>
	 <COND (<NOT .OBJ>
		<TELL " " .STRING>)
	       (<EQUAL? .OBJ ,PRSI>
		<PRSI-PRINT>)
	       (T
		<PRSO-PRINT>)>
	 <TELL " here." CR>
	 <STOP>>

<ROUTINE NO-SUCH (OBJ ADJ1 NOUN1 ADJ2 NOUN2)
	 <COND (<OR <AND <NOUN-USED .OBJ .NOUN1>
			 <ADJ-USED .OBJ .ADJ1>>
		    <AND <NOUN-USED .OBJ .NOUN2>
			 <ADJ-USED .OBJ .ADJ2>>
		    <AND <EQUAL? .OBJ ,ROCKS>
			 <NOUN-USED .OBJ ,W?ROCK>
			 <ADJ-USED .OBJ ,W?RED>>>
		<TELL 
		 "There's no capacity for" T .OBJ " to transform into any">
		<COND (<EQUAL? .OBJ ,PRSI>
		       <PRSI-PRINT>)
		      (T
		       <PRSO-PRINT>)>
		<TELL ,PERIOD>)
	       (T
		<RFALSE>)>>

<ROUTINE PRSO-PRINT ("AUX" PTR)
	 <COND (<OR ,P-MERGED
		    <EQUAL? <GET <SET PTR <GET ,P-ITBL ,P-NC1>> 0> ,W?IT>>
		<TELL " " D ,PRSO>)
	       (T
		<BUFFER-PRINT .PTR <GET ,P-ITBL ,P-NC1L> <>>)>>

<ROUTINE PRSI-PRINT ("AUX" PTR)
	 <COND (<OR ,P-MERGED
		    <EQUAL? <GET <SET PTR <GET ,P-ITBL ,P-NC2>> 0> ,W?IT>>
		<TELL " " D ,PRSI>)
	       (T
		<BUFFER-PRINT .PTR <GET ,P-ITBL ,P-NC2L> <>>)>>

<ROUTINE CANT-VERB-A-PRSO (STRING)
	 <TELL ,YOU-CANT .STRING A ,PRSO "!" CR>>

;<ROUTINE NOW-TIED (OBJ)
	 <TELL "Okay," T ,PRSO " is now tied to" TR .OBJ>>

<ROUTINE TELL-HIT-HEAD ()
	 <TELL
"You bang your bean against" T ,PRSO " as you attempt this." CR>>

;"P-OFW is the FIRST! noun in a NOUN-OF-NOUN phrase"
;"PERFORM sets now-prsi global as it calls prsi first, then prso -- thus
when we get to the verb defaults, now-prsi is false."
<ROUTINE NOUN-USED (OBJ WORD1 "OPTIONAL" (WORD2 <>) (WORD3 <>) 
		           "AUX" O I OOF IOF)
	 <SET O <GET ,P-NAMW 0>>
	 <SET I <GET ,P-NAMW 1>>
	 <SET OOF <GET ,P-OFW 0>>
	 <SET IOF <GET ,P-OFW 1>>
	 <COND (<OR <AND <EQUAL? .OBJ ,PRSO>
			 <NOT ,NOW-PRSI>
			 <EQUAL? .WORD1 .O .OOF>>
		    <AND <EQUAL? .OBJ ,PRSI>
			 ,NOW-PRSI
			 <EQUAL? .WORD1 .I .IOF>>>
		<RTRUE>)
	       (<ZERO? .WORD2>
		<RFALSE>)
	       (<OR <AND <EQUAL? .OBJ ,PRSO>
			 <NOT ,NOW-PRSI>
			 <EQUAL? .WORD2 .O .OOF>>
		    <AND <EQUAL? .OBJ ,PRSI>
			 ,NOW-PRSI
			 <EQUAL? .WORD2 .I .IOF>>>
		<RTRUE>)
	       (<ZERO? .WORD3>
		<RFALSE>)
	       (<OR <AND <EQUAL? .OBJ ,PRSO>
			 <NOT ,NOW-PRSI>
			 <EQUAL? .WORD3 .O .OOF>>
		    <AND <EQUAL? .OBJ ,PRSI>
			 ,NOW-PRSI
			 <EQUAL? .WORD3 .I .IOF>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL TRANS-PRINTED <>> ;"set to false in start of parser"

;"rfalses if no transformation, and nothing printed"
<ROUTINE TRANS-PRINT (OBJECT "OPTIONAL" (OLD-WORD <>) (NO-CR <>)
		             "AUX" (OBJECT-IS-OLD <>))
	 <COND (<NOT <VISIBLE? .OBJECT>>
		<RFALSE>) ;"stops mobyverbs from printing trans & no obj here"
	       (<FSET? .OBJECT ,OLDBIT>
		<SET OBJECT-IS-OLD T>)>
	 <COND (.OLD-WORD
		<FSET .OBJECT ,OLDBIT>)
	       (T
		<FCLEAR .OBJECT ,OLDBIT>)>
	 <COND (<OR <AND .OBJECT-IS-OLD ;"object is now steak, and the word"
		         <NOT .OLD-WORD>> ;"used was 'stake'"
		    <AND <NOT .OBJECT-IS-OLD>
			 .OLD-WORD>>
		<COND (.OBJECT-IS-OLD
		       <TELL <GETP .OBJECT ,P?OLD-TO-NEW>>)
		      (<GETP .OBJECT ,P?NEW-TO-OLD>
		       <TELL <GETP .OBJECT ,P?NEW-TO-OLD>>)
		      ;(T "semied during hazing section"
		       <TELL <GETP .OBJECT ,P?OLD-TO-NEW>>)>
		<SETG TRANS-PRINTED T>
		<COND (<NOT <FSET? .OBJECT ,TRANSFORMED>>
		       <UPDATE-SCORE>)>
		<FSET .OBJECT ,TRANSFORMED>		
		<COND (.NO-CR
		       <RTRUE>)>
		<CRLF>
		<COND (<AND <NOT <VERB? NO-VERB SET HAIR>>
			    <NOT <PRSO? ,CLIENT>>> ;"v-hair just rtrues"
		       <CRLF>)>
		<RTRUE>)
	       (T
		<RFALSE>)>> 	 

<ROUTINE ADJ-USED (OBJ WORD1 "OPTIONAL" (WORD2 <>) (WORD3 <>)
		    	  "AUX" O I)
	 <SET O <GET ,P-ADJW 0>>
	 <SET I <GET ,P-ADJW 1>>
	 <COND (<OR <AND <EQUAL? .OBJ ,PRSO>
			 <EQUAL? .O .WORD1>>
		    <AND ,PRSI
			 <EQUAL? .OBJ ,PRSI>
			 <EQUAL? .I .WORD1>>>
		<RTRUE>)
	       (<ZERO? .WORD2>
		<RFALSE>)
	       (<OR <AND <EQUAL? .OBJ ,PRSO>
			 <EQUAL? .O .WORD2>>
		    <AND ,PRSI
			 <EQUAL? .OBJ ,PRSI>
			 <EQUAL? .I .WORD2>>>
		<RTRUE>)
	       (<ZERO? .WORD3>
		<RFALSE>)
	       (<OR <AND <EQUAL? .OBJ ,PRSO>
			 <EQUAL? .O .WORD3>>
		    <AND ,PRSI
			 <EQUAL? .OBJ ,PRSI>
			 <EQUAL? .I .WORD3>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<ROUTINE ADJ-USED (TEST-ADJ)
	 <COND (<EQUAL? .TEST-ADJ <GET ,P-ADJW 0> <GET ,P-ADJW 1>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OFF-VEHICLE? (OBJ) ;"tells to print GET OFF versus GET OUT OF"
	 <COND (<EQUAL? .OBJ ,ICICLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OPEN-CLOSED (OBJ)
	 <COND (<OR <AND <NOT <EQUAL? .OBJ ,SHINING-DOOR>>
			 <FSET? .OBJ ,OPENBIT>>
		    <AND <EQUAL? .OBJ ,SHINING-DOOR>
			 <FSET? ,SHINING-DOOR ,RMUNGBIT>>>
		<TELL "open">)
	       (T
		<TELL "closed">)>>

<ROUTINE WEE ()
	 <TELL "Wasn't that fun?" CR>>

;<ROUTINE IN-YOUR-PACKAGE (STRING)
	 <TELL "This is the " .STRING>
	 <IN-PACKAGE>>

;<ROUTINE IN-PACKAGE ()
	 <TELL " that came in your package.">>

<GLOBAL CANT-REACH-FLAG <>>

<ROUTINE CANT-REACH (OBJ)
	 <COND (<NOT ,CANT-REACH-FLAG>
		<SETG CANT-REACH-FLAG T>
		<TELL ,YOU-CANT "reach" T .OBJ>
		<COND (<NOT <IN? ,PROTAGONIST ,HERE>>
		       <TELL " from" T <LOC ,PROTAGONIST>>)>
		<TELL ,PERIOD>)>
	 <RTRUE>>

;<ROUTINE EAGERLY-ACCEPTS ()
	 <MOVE ,PRSO ,PRSI>
	 <TELL "Eagerly," T ,PRSI " accepts" T ,PRSO>>

;<ROUTINE NOT-ON-GROUND (VEHICLE)
	 <TELL "But" T .VEHICLE " isn't on the ground!" CR>>

;<ROUTINE PLAYER-CANT-SEE ()
	 <COND ;(<OR <FSET? ,EYES ,MUNGBIT>
		    <EQUAL? ,HAND-COVER ,EYES>>
		<OPEN-YOUR-EYES!>)
	       ;(<NOT ,LIT>
		<TELL ,TOO-DARK CR>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-FIRST (STRING "OPTIONAL" (OBJ <>))
	 <TELL ,YOULL-HAVE-TO .STRING>
	 <COND (.OBJ
		<TPRINT .OBJ>)>
	 <TELL " first." CR>>

<ROUTINE NOT-IN ()
	 <TELL "But" T-IS-ARE ,PRSO "not ">
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "being held by">)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<TELL "on">)
	       (T
		<TELL "in">)>
	 <TELL TR ,PRSI>>

;<ROUTINE NO-LID ()
	 <TELL "The " D ,PRSO " has no lid." CR>>

<ROUTINE PART-OF ()
	 <TELL 
"You can't --" T ,PRSO>
	 <COND (<FSET? ,PRSO ,PLURALBIT>
		<TELL " are">)
	       (T
	        <TELL " is">)>
	 <TELL " an integral part of" TR <LOC ,PRSO>>
	 <COND (<PRSO? ,CLOCK-KEY>
		<TELL "But the key can still be used." CR>)>
	 <RTRUE>>	 

<ROUTINE BE-MORE-SPECIFIC ()
	 <TELL "[" ,YOULL-HAVE-TO "be more specific.]" CR>>

<ROUTINE CHANGE-OBJECT (OLD NEW)
	 <COND (<PRSO? .OLD>
		<PERFORM ,PRSA .NEW ,PRSI>)
	       (T
		<PERFORM ,PRSA ,PRSO .OLD>)>
	 <RTRUE>>

<ROUTINE SORE (STRING)
	 <TELL "You begin to get a sore " .STRING ,PERIOD>>

;<ROUTINE CANT-USE-THAT-WAY (STRING)
	 <TELL "[" ,YOU-CANT "use " .STRING " that way.]" CR>>

<ROUTINE RECOGNIZE ()
	 <SETG P-WON <>>
	 <TELL "[That sentence isn't one I recognize.]" CR>>

<ROUTINE PREGNANT ()
	 <TELL
"[So pregnant with possibilities are the names of things in this scenario
it is impossible to use them in a series, though using \"all\" is allowed,
as in TAKE ALL.]" CR>>

<ROUTINE PRONOUN ()
	 <COND (<PRSO? ,ME>
		<TELL "You">)
	       (<FSET? ,PRSO ,PLURALBIT>
		<TELL "They">)
	       (<FSET? ,PRSO ,FEMALEBIT>
		<TELL "She">)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "He">)
	       (T
		<TELL "It">)>>

<ROUTINE DONT-F ()
	 <COND (<AND <VERB? CRY>
		     <PRSO? ,MILK>>
		<RFALSE>)
	       (<AND <VERB? BUY-IN>
		     <PRSO? ,PIG>
		     <PRSI? ,CAT-BAG>>
		<RFALSE>)
	       (<VERB? WAIT>
		<TELL "Time doesn't pass..." CR>)
	       (<VERB? TAKE>
		<TELL "Not taken." CR>)
	       (T
		<TELL "Not done." CR>)>>

<ROUTINE REFERRING ("OPTIONAL" (HIM-HER <>))
	 <TELL "It's not clear wh">
	 <COND (.HIM-HER
		<TELL "o">)
	       (T
		<TELL "at">)>
	 <TELL " you're referring to." CR>>

<ROUTINE NO-ONE-HERE (STRING)
	 <TELL "There's no one here to " .STRING ,PERIOD>>

;<ROUTINE SEE-MANUAL (STRING)
	 <TELL
"[You need quotes to " .STRING " See the instruction manual section
entitled \"Communicating With Infocom's Interactive Fiction.\"]" CR>>

;<ROUTINE UNIMPORTANT-THING-F ()
	 <TELL "That's not important; leave it alone." CR>>

;<GLOBAL TOO-DARK "It's too dark to see a thing.">

<GLOBAL YNH "You're not holding">

<GLOBAL THERES-NOTHING "There's nothing ">

<GLOBAL YOU-SEE "You can see">

<GLOBAL IT-SEEMS-THAT "It seems that">

;<GLOBAL YOU-CANT-SEE-ANY "You can't see any ">

<GLOBAL YOU-CANT "You can't ">

<GLOBAL YOULL-HAVE-TO "You'll have to ">

<GLOBAL LOOK-AROUND "Look around you.|">

<GLOBAL CANT-FROM-HERE "You can't do that from here.|">

<GLOBAL CANT-GO "You can't go that way.|">

<GLOBAL HOLDING-IT "You're holding it!|">

;<GLOBAL NOUN-MISSING "[There seems to be a noun missing in that sentence.]|">

<GLOBAL PERIOD ".|">

;<GLOBAL NOTHING-HAPPENS "Nothing happens.|">

<GLOBAL FAILED "Failed.|">

<GLOBAL OK "Okay.|">

<GLOBAL HUH "Huh?|">

<GLOBAL ALREADY-IS "It already is!|">

<GLOBAL NOTHING-NEW "This reveals nothing new.|">

;<GLOBAL NO-VERB "[There was no verb in that sentence!]|">

<GLOBAL NICE-HOLE "There's already an ice hole, and a nice hole it is!|">

<GLOBAL FLY "\"Hey Sammy, what is this fly doing in my soup?\"|">

<GLOBAL ARRIVED "You've already arrived.|">

<GLOBAL WEARING-IT "You're wearing it!|">

<GLOBAL IF-HAMMER "If you only had a hammer...|">

<GLOBAL ALREADY-HAVE "You already have.|">

<GLOBAL WEARING-THIN 
"This kind of thing is obviously wearing thin with the crowd.|">

<GLOBAL DONT-KNOW-WHERE "You don't know where it is from here.|">

<GLOBAL STANDS-STILL ", but stands still and silent as the mountain air.|">

<GLOBAL NO-SALE "That's not for sale.|">