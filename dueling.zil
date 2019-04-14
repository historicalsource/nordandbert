"DUELING for
		             NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROOM BEFORE-MANOR 
      (LOC ROOMS)
      (DESC "Before the Manor")
      ;(FLAGS INDOORSBIT)
      (GLOBAL MANOR DUELING)
      (ACTION BEFORE-MANOR-F)>

<ROUTINE BEFORE-MANOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"You're standing in front of a large but oddly shaped manor house. From
the outside, it looks as if its individual rooms have been haphazardly
constructed and are out of proportion with each other. This has a slight
disorienting effect.">)>>

<GLOBAL REAL-DUELING <>>

<OBJECT DUELING
	(LOC LOCAL-GLOBALS)
	(DESC "room")
	(PICK-IT "Visit the Manor of Speaking")
	(MAX-SCORE 7)
	(SCENE-SCORE 0)
	(SCENE-ROOM BEFORE-MANOR)
	(SCENE-CUR 0)
	(SYNONYM ;ROOM DECORATED DECORATION DOLDRUMS DOLDRUM KREMLIN
		 PHARMACY ATTIC RX INTERIOR YAWN)
	(ADJECTIVE INTERIOR)
	(FLAGS NDESCBIT SCENEBIT)
	(GLOBAL MANOR)
	(ACTION DUELING-F)>

<ROUTINE DUELING-F ("AUX" ROOM)
	 <COND (<OR <ADJ-USED ,DUELING ,W?INTERIOR>
		   <NOUN-USED ,DUELING ,W?DECORATED ,W?DECORATION ,W?INTERIOR>>
		<SETG REAL-DUELING ,ID-ROOM>)
	       (<NOUN-USED ,DUELING ,W?DOLDRUM ,W?DOLDRUMS ,W?YAWN>
		<SETG REAL-DUELING ,DOLDRUMS>)
	       (<NOUN-USED ,DUELING ,W?KREMLIN>
		<SETG REAL-DUELING ,KREMLIN>)
	       (<NOUN-USED ,DUELING ,W?PHARMACY ,W?RX>
		<SETG REAL-DUELING ,PHARMACY>)
	       (<NOUN-USED ,DUELING ,W?ATTIC>
		<SETG REAL-DUELING ,ATTIC>)
	       ;(T
	        <SETG REAL-DUELING ,ID-ROOM>)>
	 <COND (<OR <NOT ,REAL-DUELING>
		    <VERB? NO-VERB>
		    <AND <DONT-HANDLE ,DUELING>
			 <NOT <VERB? WALK-TO>>>>
		<RFALSE>)
	       (<VERB? WALK-TO>
		<COND (<EQUAL? ,HERE ,REAL-DUELING>
		       <TELL ,ARRIVED>)
		      (<EQUAL? ,REAL-DUELING ,ATTIC>
		       <COND (<FSET? ,ATTIC ,PHRASEBIT>
			      <SET ROOM ,KREMLIN>)
			     (T
			      <SET ROOM ,ID-ROOM>)>
		       <COND (<AND <EQUAL? ,HERE ,ID-ROOM>
				   <NOT <FSET? ,ATTIC ,PHRASEBIT>>>
			      <DO-WALK ,P?DOWN>)
			     (<AND <EQUAL? ,HERE ,KREMLIN>
				   <FSET? ,ATTIC ,PHRASEBIT>>
			      <DO-WALK ,P?UP>)
			     (T
			      <TELL 
"You walk to the " D .ROOM ", and from there walk ">
			      <COND (<EQUAL? .ROOM ,ID-ROOM>
				     <TELL "down">)
				    (T
				     <TELL "up">)>
			      <TELL " the stairs..." CR CR>
			      <GOTO ,ATTIC>)>)
		      (<EQUAL? ,HERE ,ATTIC>
		       <COND (<FSET? ,ATTIC ,PHRASEBIT>
			      <SET ROOM ,KREMLIN>)
			     (T
			      <SET ROOM ,ID-ROOM>)>
		       <COND (<AND <EQUAL? ,REAL-DUELING ,ID-ROOM>
				   <NOT <FSET? ,ATTIC ,PHRASEBIT>>>
			      <DO-WALK ,P?UP>)
			     (<AND <EQUAL? ,REAL-DUELING ,KREMLIN>
				   <FSET? ,ATTIC ,PHRASEBIT>>
			      <DO-WALK ,P?DOWN>)
			     (T
			      <TELL "You walk ">
			      <COND (<EQUAL? .ROOM ,ID-ROOM>
				     <TELL "up">)
				    (T
				     <TELL "down">)>
			      <TELL 
" the stairs to the " D .ROOM " and continue walking... " CR CR>
			      <GOTO ,REAL-DUELING>)>)
		      (T
		       <TELL "You go there..." CR CR>
		       <GOTO ,REAL-DUELING>)>)
	       (<NOT <EQUAL? ,HERE ,REAL-DUELING>>
		<CANT-SEE <> "such room">)
	       ;(T
		<CHANGE-OBJECT ,DUELING ,GLOBAL-ROOM>
		<RTRUE>)>>

<OBJECT MANOR
	(LOC LOCAL-GLOBALS)
	(DESC "manor")
	(SYNONYM HOUSE MANOR SPEAKING)
	(FLAGS NDESCBIT)
	(ACTION MANOR-F)>

<ROUTINE MANOR-F ()
	 <COND (<VERB? EXAMINE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<VERB? ENTER WALK-TO>
		<COND (<EQUAL? ,HERE ,BEFORE-MANOR>
		       <V-WALK-AROUND>
		       <RTRUE>)
		      (T
		       <TELL ,LOOK-AROUND>)>)>>

<ROOM ID-ROOM 
      (LOC ROOMS)
      (DESC "Interior Decorated")
      (FLAGS INDOORSBIT)
      (DOWN PER ATTIC-ENTER)
      (GLOBAL MANOR DUELING STAIRS)
      (ACTION ID-ROOM-F)>

;"rmungbit = have tried to leave room and stopped for Player to describe obj"

;<GLOBAL GETTING-INPUT <>>

<ROUTINE ID-ROOM-F (RARG)
	 <COND ;(<AND <EQUAL? .RARG ,M-BEG>
		     ,GETTING-INPUT>
		<COND (<L? <GETB ,P-LEXV ,P-LEXWORDS> 5>
		       <TELL 
"Come on, not so tight-lipped! You can be more floral in your prose than
that." CR>)
		      (T
		       <SETG GETTING-INPUT <>>
		       <SAVE-INPUT ,FIRST-BUFFER>)>)
	       ;(<AND <EQUAL? .RARG ,M-BEG>
		     <NOT <FSET? ,ID-ROOM ,RMUNGBIT>>
		     <VERB? WALK WALK-TO>>
		<FSET ,ID-ROOM ,RMUNGBIT>
		<SETG GETTING-INPUT T>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL 
"So, you're just going to walk away from my lovingly crafted description
of your opulent surroundings, just like ">
		<ITALICIZE "that">
		<TELL ", huh? Well! Do you think ">
		<ITALICIZE "you">
		<TELL " can do better?" CR>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? THROW THROW-TO KICK KILL MUNG KNOCK-OFF>>
		<TELL
"Shame shame shame on you, you ruffian! I tremble at the thought of having
you crash one of my dinner parties. I just won't allow that type of
behaviour!" CR>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <HELD? ,OLD-BOTTLE>
		     <VISIBLE? ,OLD-BOTTLE>
		     <NOT <FSET? ,OLD-BOTTLE ,SEENBIT>>>
		<FSET ,OLD-BOTTLE ,SEENBIT>
		<TELL 
"Oh, my goodness, that's a rare antique bottle you're holding. Very
impressive indeed." CR CR>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,ID-ROOM ,TOUCHBIT>>>
		<TELL
"The carpet! The carpet! Don't drag your feet on the carpet! It's a
priceless hand-loomed Persian!|
|
Whew! Okay, you're now standing on the bone-white Louis-XV-inspired tile.||">)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This room, with its modern sensibility yet also palpable feeling for
the ancien regime, is unique in its elegant reflection of a confident,
personal sense of style. The lines are lean and classic, the color is
rich and distinctive.">
		<COND (<AND <IN? ,LOUIS-CHAIR ,HERE>
			    <FSET? ,LOUIS-CHAIR ,DESC-IN-ROOMBIT>>
		       <TELL CR CR
"The Louis XIV chair is plump, tufted, aristocratic -- it's styled with equal
splashes of rococo and baroque. The piece definitely has charisma">
		<COND (<OR <NOT <FIRST? ,LOUIS-CHAIR>>
			   <AND <IN? ,PROTAGONIST ,LOUIS-CHAIR>
				<NOT <NEXT? ,PROTAGONIST>>>>
		       <TELL ".">)
		      (T
		       <TELL ". Sitting on the chair:">
		       <D-CONTENTS ,LOUIS-CHAIR 2>)>)>
		<TELL "||
Against the far wall is an heroically proportioned, Mediterranean-crafted,
intricately inlaid, Pre-Raphaelite limestone mantelpiece, circa 1838.">
		<COND (<IN? ,LACE ,MANTEL>
		       <REMOVE ,LACE>
		       <TELL CR CR
"Adorning the mantel is a resplendently virgin-ivory hand-embroidered,
filet-patterned lace tablecloth, circle 924 on your Reader Service Card">
		       <COND (;<G? <CCOUNT ,MANTEL> 1>
		              <FIRST? ,MANTEL>
			      <TELL ". Also on the mantel:">
			      <D-CONTENTS ,MANTEL 2>
			      <RTRUE>)
			     (T
			      <TELL ".">)>
		       <MOVE ,LACE ,MANTEL>)
		      (<FIRST? ,MANTEL>
		       <TELL " Resting on the mantel:">
		       <D-CONTENTS ,MANTEL 2>)>
		<COND (<NOT <FSET? ,ATTIC ,PHRASEBIT>>
		       <TELL CR CR 
"A marble staircase of grand proportions leads down.">)>
		<RTRUE>)>>

<OBJECT LOUIS-CHAIR
	(LOC ID-ROOM)
	(DESC "plump, tufted, aristocratic Louis XIV chair")
	(SYNONYM CHAIR)
	(ADJECTIVE PLUMP TUFTED ARISTICRATIC LOUIS XIV)
	(FLAGS TAKEBIT TRYTAKEBIT DESC-IN-ROOMBIT SURFACEBIT VEHBIT CONTBIT
	       OPENBIT SEARCHBIT)
	(CAPACITY 30)
	(SIZE 90)
	(ACTION LOUIS-CHAIR-F)>

;"phrasebit = score for boarding it"

<ROUTINE LOUIS-CHAIR-F ("OPT" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK WALK-TO>>
		<NOT-GOING-ANYWHERE>)
	       (.RARG
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <FSET? ,LOUIS-CHAIR ,TRYTAKEBIT>
		     <EQUAL? ,ORPHAN-FLAG ,LOUIS-CHAIR>>
		<PERFORM ,V?NO-VERB ,LOUIS-CHAIR>
		<CRLF>
		<PERFORM ,V?TAKE ,LOUIS-CHAIR>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <FSET? ,LOUIS-CHAIR ,TRYTAKEBIT>>
		<TELL
"This is not a rummage sale. No! I could never think of parting
with such a priceless antique." CR>)
	       (<VERB? STAND-ON>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<AND <VERB? BOARD>
		     <EQUAL? ,HERE ,KREMLIN>
		     <NOT <FSET? ,LOUIS-CHAIR ,PHRASEBIT>>>
		<FSET ,LOUIS-CHAIR ,PHRASEBIT>
		<UPDATE-SCORE>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,HERE ,ID-ROOM>
		     ;<EQUAL? <ITAKE> T>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<FCLEAR ,LOUIS-CHAIR ,DESC-IN-ROOMBIT>
		<TELL 
"Go ahead, but I can't bear to look. [With the proper reverence, you make
a courtly bow in front of the priceless antique as you pick it up.]" CR>)>> 

<OBJECT PILLOW
	(LOC LOUIS-CHAIR)
	(DESC "multihued textured pillow")
	(SYNONYM PILLOW)
	(ADJECTIVE MULTI-HUED TEXTURED)
	(FLAGS TAKEBIT)
	(ACTION PILLOW-F)>

<ROUTINE PILLOW-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The pillow, complementary to the Louis XIV, is multihued and textured,
displaying free-form squiggles, curlicues and brash brushstrokes with a
primitive look to them." CR>)>>

<OBJECT MANTEL ;"just like rest-table"
	(LOC ID-ROOM)
	(DESC "heroically proportioned mantel")
	(SYNONYM MANTEL MANTELPIECE)
	(ADJECTIVE HEROICALLY PROPORTIONED)
	(FLAGS DESC-IN-ROOMBIT NO-D-CONT SURFACEBIT CONTBIT OPENBIT SEARCHBIT
	       VOWELBIT)
	(CAPACITY 25)
	;(ACTION MANTEL-F)>

;"even with no-d-cont should print contents when v-examine.
  no-d-cont only for look in a room"

;<ROUTINE MANTEL-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <FSET? ,ID-ROOM ,RMUNGBIT>>
		<RESTORE-INPUT ,FIRST-BUFFER>
		<RTRUE>)>>

<OBJECT LACE
	(LOC MANTEL)
	(DESC "lace tablecloth")
	(SYNONYM TABLECLOTH)
	(ADJECTIVE VIRGIN-IVORY IVORY HAND-EMBROIDERED LACE)
	(FLAGS TAKEBIT)
	;(ACTION LACE-F)>

;<ROUTINE LACE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "ok" CR>)>>

<ROOM DOLDRUMS 
      (LOC ROOMS)
      (DESC "Doldrums")
      (FLAGS INDOORSBIT)
      (GLOBAL MANOR DUELING)
      (ACTION DOLDRUMS-F)>

<ROUTINE DOLDRUMS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<FSET? ,DOLDRUMS ,TOUCHBIT>
		       <QUEUE I-DOLDRUMS 1>)
		      (T
		       <QUEUE I-DOLDRUMS 2>)>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Go ahead, come on in and bore me.|
|
Walking into here is like driving across Nebraska. The place
is neither bright nor dim, neither cool nor warm, neither this way nor
that way. Even the air is unmoved by the experience of you entering the
doldrums.|
|
In the center of the room is a vast wasteland, which gradually blends into
a wide patch of long pale-green grass that spills over into yawning chasms.
Above the cliff hangs a shapeless cloud through which a line of sheep are
jumping, one after the next, in slow motion.|  
|
All of the objects here have the aspect of salt-water taffy left out in
the sun too long.">
		<COND (<NOT <FSET? ,CLOCK ,TOUCHBIT>>
		       <TELL
" Cobwebs enshroud a clock that has long since clocked out.">)>
		<TELL "||
One wall appears to have been recently painted pea green. The weak smell
of paint lingers in the air.">)>>

<ROUTINE I-DOLDRUMS ()
	 <QUEUE I-DOLDRUMS -1>
	 <COND (<NOT <EQUAL? ,HERE ,DOLDRUMS>>
		<DEQUEUE I-DOLDRUMS>
		<RFALSE>)
	       (<FSET? ,GRASS ,SEENBIT>
		<FCLEAR ,GRASS ,SEENBIT>
		<TELL CR "The grass here continues to grow">)
	       (T
		<FSET ,GRASS ,SEENBIT>
		<TELL CR "The paint on the wall continues to dry">)>
	 <TELL ,PERIOD>>

<OBJECT WASTELAND
	(LOC DOLDRUMS)
	(DESC "vast wasteland")
	(SYNONYM WASTELAND TV TELEVISION CHANNEL STATION)
	(ADJECTIVE TV TELEVISION VAST)
	(FLAGS DESC-IN-ROOMBIT LIGHTBIT ONBIT)
	(ACTION WASTELAND-F)>

<ROUTINE WASTELAND-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The television set, which has been left droning on here, is now showing
a marathon of laundry detergent comercials." CR>)
	       (<VERB? OFF SET>
		<TELL "It has no controls of any kind." CR>)>>    
		
<OBJECT CLOUD
	(LOC DOLDRUMS)
	(DESC "cloud")
	(SYNONYM CLOUD)
	(ADJECTIVE SHAPELESS)
	(FLAGS NDESCBIT)
	;(ACTION CLOUD-F)>

;<ROUTINE CLOUD-F ()
	 <COND ()>>

<OBJECT GRASS
	(LOC DOLDRUMS)
	(DESC "grass")
	(SYNONYM GRASS)
	(ADJECTIVE PALE-GREEN GREEN LONG)
	(FLAGS DESC-IN-ROOMBIT NOA)
	;(ACTION WASTELAND-F)>

;"SEENBIT = in i-doldrums grass or paint"

<OBJECT CHASMS
	(LOC DOLDRUMS)
	(DESC "yawning chasms")
	(SYNONYM CHASMS CHASM CLIFF CLIFFS)
	(ADJECTIVE YAWNING)
	(FLAGS DESC-IN-ROOMBIT NOA PLURALBIT ;NARTICLEBIT)
	(ACTION CHASMS-F)>

<ROUTINE CHASMS-F ()
	 <COND (<VERB? BOARD LEAP LEAP-OFF ENTER>
		<TELL 
"Okay, here you are falling down off the cliffs and with all the
exhilaration you're showing you might as well be falling asleep. Your life
flashes before your eyes and that's a bigger yawn than the chasms. The abyss
is actually a continuum that loops back around whence you fell, and here
you are standing upright again." CR>)
	       (<AND <VERB? PUT THROW>
		     <PRSI? ,CHASMS>>
		<MOVE ,PRSO ,HERE>
		<TELL 
"As you throw in" T ,PRSO ", it is swallowed by the darkness of the abyss,
only to reappear a second later at your feet." CR>)>>

<OBJECT PAINT
	(LOC DOLDRUMS)
	(DESC "paint")
	(SYNONYM PAINT)
	;(ADJECTIVE YAWNING)
	(FLAGS NDESCBIT NARTICLEBIT)
	;(ACTION PAINT-F)>

<OBJECT CLOCK
	(LOC DOLDRUMS)
	(DESC "clock")
	(SYNONYM CLOCK TIMEPIECE WATCH TIME)
	;(ADJECTIVE WINDING)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT OPENBIT DESC-IN-ROOMBIT)
	(ACTION CLOCK-F)>

;"rmungbit = told in i-clock"
;"phrasebit = points for winding"

<ROUTINE CLOCK-F ()
	 <COND (<AND <VERB? TAKE>
		     ;<EQUAL? <ITAKE> T>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<FCLEAR ,CLOCK ,DESC-IN-ROOMBIT>
		<TELL "Taken." CR>)
	       ;(<AND <VERB? PUT>
		     <PRSO? ,SAFE>>)
	       (<VERB? SET>
		<COND (<NOT <FSET? ,CLOCK ,PHRASEBIT>>
		       <FSET ,CLOCK ,PHRASEBIT>
		       <UPDATE-SCORE>)>
		<SETG CLOCK-N 0>
		<QUEUE I-CLOCK -1>
		<TELL "You wind the clock until the winding key stops." CR>)
	       (<AND <VERB? LISTEN>
		     <RUNNING? ,I-CLOCK>
		     <EQUAL? <META-LOC ,CLOCK> ,HERE>>
		<RTRUE>)
	       (<VERB? READ EXAMINE>
		<TELL
"The clock is faceless and without hands, but has a winding key
in its back." CR>)
	       (<VERB? OPEN>
		<TELL "You can't." CR>)
	       (<VERB? CLOSE>
		<TELL ,ALREADY-IS>)>>

<GLOBAL CLOCK-N 0>

<ROUTINE I-CLOCK ()
	 <SETG CLOCK-N <+ ,CLOCK-N 1>>
	 <COND (<G? ,CLOCK-N 10>
		<COND (<EQUAL? <META-LOC ,CLOCK> ,HERE>
		       <TELL CR 
"The clock gives off its last \"tick\" and stops." CR>)>
		<DEQUEUE I-CLOCK>)
	       (<EQUAL? <META-LOC ,CLOCK> ,HERE>
		<TELL CR "The clock ">
		<COND (<OR <PROB 50>
			   <NOT <FSET? ,CLOCK ,RMUNGBIT>>>
		       <TELL 
"continues sounding out a steady \"Tick... tick... tick.\"">)
		      (T
		       <TELL "keeps ticking off the time.">)>
		<COND (<NOT <FSET? ,CLOCK ,RMUNGBIT>>
		       <FSET ,CLOCK ,RMUNGBIT>
		       <TELL
" If you couldn't see it was the clock making the noise, it would
sound rather ominous.">)>
		<CRLF>)>
	 <RTRUE>>
		      
<OBJECT CLOCK-KEY
	(LOC CLOCK)
	(DESC "winding key")
	(SYNONYM KEY)
	(ADJECTIVE WINDING CLOCK)
	(FLAGS INTEGRALBIT)
	(ACTION CLOCK-KEY-F)>

<ROUTINE CLOCK-KEY-F ()
	 <COND (<AND <VERB? MOVE SET OPEN>
		     <NOT ,PRSI>>
		<PERFORM ,V?SET ,CLOCK>
		<RTRUE>)>>

<ROOM KREMLIN 
      (LOC ROOMS)
      (DESC "Kremlin")
      (FLAGS INDOORSBIT)
      (UP PER ATTIC-ENTER)
      (GLOBAL MANOR DUELING STAIRS)
      (ACTION KREMLIN-F)>

<GLOBAL KREMLIN-ENTER <>>

<ROUTINE KREMLIN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<AND <RUNNING? ,I-CLOCK>
			    <NOT <FSET? ,MARX ,TOUCHBIT>>
			    <HELD? ,CLOCK>>
		       <SETG KREMLIN-ENTER T>
		       <HLIGHT ,H-BOLD>
		       <TELL D ,KREMLIN>
		       <HLIGHT ,H-NORMAL>
		       <CRLF> <CRLF>
		       <TELL
"\"Tick... tick.\" I hear bomb ticking! Counter-Revolutionary spy! Hold
on to our sable hats.">
		       <COND (<VISIBLE? ,CLOCK>
			      <TELL 
" Oh, we can see is only inferior Capitalist clock">)
			     (T
			      <UPDATE-SCORE>
			      <FSET ,MARX ,TOUCHBIT>
			      <MOVE ,SAFE ,HERE>
			      <TELL 
" My sturdy walls tremble with xenophobia of Western hegemony into Mother
Country. Poor Marx is jolted and falls indignantly to
the floor, revealing some kind of safe on the red wall where he had hung">)>
		       <TELL ,PERIOD ;CR>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<COND (<NOT ,KREMLIN-ENTER>
		       <TELL 
"\"Fellow traveller, welcome.\"" CR CR>)>
		<TELL
"This room is painted entirely in bold, revolutionary red -- walls, floor,
and ceiling -- surrounding you symbolically with the inescapability of
the coming of the revolution.">
		<COND (<FSET? ,MARX ,TOUCHBIT>
		       <TELL CR CR
"There's a safe built into the wall where the picture once hung.">)>
		<COND (<FSET? ,ATTIC ,PHRASEBIT>
		       <TELL CR CR
"A staircase leads up from here.">)>
		<RTRUE>)>>

<OBJECT MARX	
	(LOC KREMLIN)
	(DESC "portrait of Karl Marx")
	(FDESC 
"Presiding over the room, hanging from a high red wall, the portrait of the
Grandfather of the Revolution, Karl Marx, looks down with furrowed brow upon
your capitalist hide.")
	(SYNONYM FATHER MARX KARL PORTRAIT PICTURE)
	(ADJECTIVE KARL)
	(FLAGS TRYTAKEBIT)
	(ACTION MARX-F)>

;"touchbit is set as he falls to floor"

<ROUTINE MARX-F ()
	 <COND (<AND <TOUCHING? ,MARX>
		     <NOT <FSET? ,MARX ,TOUCHBIT>>
		     <NOT <IN? ,PROTAGONIST ,LOUIS-CHAIR>>>
		<CANT-REACH ,MARX>)
	       (<AND <VERB? MOVE REMOVE TAKE LOOK-BEHIND>
		     <NOT <FSET? ,MARX ,TOUCHBIT>>>
		<TELL 
"The portrait seems to adhere more closely to the wall. These proud red
walls shall never render up the hero of the revolution
to a carpetbagging, imperialistic capitalist seeking booty." CR>)
	       (<AND <VERB? TAKE>
		     <FSET? ,MARX ,TOUCHBIT>>
		<TELL 
"The hero has suffered indignity enough. Never he to be taken away as
capitalist booty!" CR>)>>

<OBJECT SAFE	
	;(LOC KREMLIN)
	(DESC "safe")
	(LDESC 
"A safe has been revealed high on the wall where the portrait of the
Father of our Revolution has once proundly hung.")
	(SYNONYM SAFE LOCK)
	(ADJECTIVE UNIVERSIAL)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT LOCKEDBIT)
	(ACTION SAFE-F)>

;"phrasebit = points for unlocking"

<ROUTINE SAFE-F ()
	 <COND (<AND <TOUCHING? ,SAFE>
		     <NOT <IN? ,PROTAGONIST ,LOUIS-CHAIR>>>
		<CANT-REACH ,SAFE>)
	       (<AND <VERB? EXAMINE>
		     <NOT <FSET? ,SAFE ,OPENBIT>>>
		<TELL 
"In keeping with the spirit of international brotherhood and with the
lofty theme of the Lennon's song \"Imagine,\" the safe is kept closed
only by a very simple universal lock, which can be opened by any kind
of key." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,SAFE>
		     <NOUN-USED ,SAFE ,W?LOCK>>
		<COND (<PRSO? ,CLOCK ,CLOCK-KEY>
		       <PERFORM ,V?UNLOCK ,SAFE ,CLOCK-KEY>
		       <RTRUE>)
		      (T
		       <TELL "The lock's too small." CR>)>)
	       (<AND <VERB? UNLOCK OPEN>
		     <PRSI? ,CLOCK ,CLOCK-KEY>
		     <FSET? ,SAFE ,LOCKEDBIT>>
		<COND (<NOT <FSET? ,SAFE ,PHRASEBIT>>
		       <FSET ,SAFE ,PHRASEBIT>
		       <UPDATE-SCORE>)>
		<FCLEAR ,SAFE ,LOCKEDBIT>
		<TELL
"By inserting the clock key into the safe and turning, the safe is unlocked."
CR>)
	       (<AND <VERB? UNLOCK OPEN>
		     <PRSI? ,CLOCK ,CLOCK-KEY>>
		<SETG PRSI <>>
		<V-UNLOCK>)
	       (<VERB? LOCK>
		<COND (<FSET? ,SAFE ,LOCKEDBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <FSET ,SAFE ,LOCKEDBIT>
		       <TELL "The safe ">
		       <COND (<FSET? ,SAFE ,OPENBIT>
			      <TELL "closes shut and ">)>
		       <FCLEAR ,SAFE ,OPENBIT>
		       <TELL "is now locked." CR>)>)>>

<OBJECT REVOLUTION	
	(LOC SAFE)
	(DESC "revolution")
	(SYNONYM REVOLUTION)
	(FLAGS TAKEBIT)
	(ACTION REVOLUTION-F)>

<ROUTINE REVOLUTION-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"It reads, \"When you really need to turn around a situation, go ahead
and revolve it.\"" CR>)>>

<ROOM PHARMACY 
      (LOC ROOMS)
      (DESC "Pharmacy")
      (FLAGS INDOORSBIT)
      (GLOBAL MANOR DUELING)
      (ACTION PHARMACY-F)>

<ROUTINE PHARMACY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"Aaah... Choo! Oh, of course, in you come tracking your germs.|
|
Sniff... sniff.|
|
You're standing upon a rubberized non-slip bathroom mat. Handrails,
installed here as an extra precaution, run along the walls.||">
		<COND (<FSET? ,CABINET ,OPENBIT>
		       <TELL
"The open medicine cabinet is cram packed full of a variety of medicines.">)
		      (T
		       <TELL
"You look a little peaked to yourself, reflected in the mirror of
the medicine cabinet.">)>)>>

<OBJECT BOX	
	(LOC PHARMACY)
	(DESC "cardboard box")
	(FDESC 
"A cardboard box, about one-foot square and empty of its value pack of
medicines, sits on the floor.")
	(SYNONYM BOX)
	(ADJECTIVE CARDBOARD)
	(FLAGS TAKEBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 10)
	;(ACTION BOX-F)>

<OBJECT CABINET	
	(LOC PHARMACY)
	(DESC "medicine cabinet")
	(SYNONYM CHEST CABINET)
	(ADJECTIVE MEDICINE)
	(FLAGS CONTBIT SEARCHBIT NDESCBIT)
	(CAPACITY 10)
	(ACTION CABINET-F)>

<ROUTINE CABINET-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,CABINET ,OPENBIT>>>
		<FSET ,CABINET ,OPENBIT>
		<TELL
"The cabinet creaks on its hinges, some would say from overuse.|
|
The cabinet is crowded to pharmaceutical proportions with a panoply of pills,
lozenges and elixirs -- hey, you can't be too careful, with what's going
around these days -- including some remedies for afflictions that, yes,
haven't even afflicted anyone yet. But it's better to be safe than sorry." CR>)
	       (<AND <VERB? SEARCH LOOK-INSIDE>
		     <FSET? ,CABINET ,OPENBIT>>
		<PERFORM ,V?EXAMINE ,MEDICINES>
		<RTRUE>)>>

<OBJECT MEDICINES	
	(LOC CABINET)
	(DESC "variety of medicines")
	(SYNONYM VARIETY MEDICINES MEDICINE ELIXIR ELIXIRS PILL PILLS LOSENGES
		 CURE CURES REMEDY REMEDIES NOSTRUM)
	(ADJECTIVE RHEUMATOID)
	(FLAGS DESC-IN-ROOMBIT TRYTAKEBIT) ;"desc-in-roombit so no redundancy"	
	(ACTION MEDICINES-F)>

<ROUTINE MEDICINES-F ()
	 <COND (<VERB? TAKE>
		<TELL 
"Oh, no, no, I couldn't survive without my medicines." CR>)
	       (<VERB? EXAMINE READ>
		<TELL
"I collect varieties of medicines like some people collect wines.
You never know what'll ail you, and usually it's everything at once.
There are cures for catastrophic illness, remedies for ringworms, pills
for palpitations, and elixirs for everything else.">
		<COND (<IN? ,OLD-BOTTLE ,CABINET>
		       <TELL CR CR
"Then there's one old, empty bottle that should've been thrown
out centuries ago.">)>
		<CRLF>)
	       (<VERB? OPEN>
		<TELL 
"The \"childproof\" caps are enough to make it impossible." CR>)>>

<OBJECT OLD-BOTTLE	
	(LOC CABINET)
	(DESC "old bottle")
	(SYNONYM BOTTLE)
	(ADJECTIVE OLD RARE GLASS ANTIQUE)
	(FLAGS TAKEBIT VOWELBIT)
	(ACTION OLD-BOTTLE-F)>

;"HEARDBIT = input was PUT BOTTLE ON MANTEL for V-YES question"

<ROUTINE OLD-BOTTLE-F ()
	 <COND (<AND <VERB? TAKE>
		     <NOT <FSET? ,OLD-BOTTLE ,TOUCHBIT>>
		     ;<EQUAL? <ITAKE> T>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<TELL
"You can go ahead and have that old thing anyway. It was here before I
moved in." CR>)
	       (<AND <VERB? TAKE>
		     <IN? ,OLD-BOTTLE ,MANTEL>>
		<TELL 
"Hands off, Indian giver! That antique bottle is mine now." CR>)
	       (<AND <VERB? SHOW>
		     <PRSI? ,GLOBAL-ROOM ,DUELING>
		     <EQUAL? ,HERE ,ID-ROOM>>
		<TELL 
"Mmmm... Very handsome. Yes! I'd simply love to have it." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL 
"It's a small and delicately sculpted glass bottle, looking to be hundreds
of years old. The bottle is empty and has no lid." CR>)
	       (<VERB? THROW MUNG KILL KICK>
		<REMOVE ,OLD-BOTTLE>
		<TELL "The fragile bottle is smashed into smithereens." CR>) 
	       (<AND <EQUAL? ,HERE ,ID-ROOM>
		     <OR <VERB? DROP>
			 <AND <VERB? PUT PUT-ON>
			      <EQUAL? ,PRSO ,OLD-BOTTLE>
			      ;<NOT <EQUAL? ,PRSI? ,MANTEL>>>>>
		<COND (<AND <VERB? PUT-ON>
			    <PRSI? ,MANTEL>>
		       <FSET ,OLD-BOTTLE ,HEARDBIT>
		       ;<MOVE ,OLD-BOTTLE ,MANTEL>)>
		<SETG AWAITING-REPLY 1>
		<QUEUE I-REPLY 2>
		<TELL 
"Umm... Do you really think it makes the right statement there?" CR>)>>

<OBJECT MAT	
	(LOC PHARMACY)
	(DESC "rubber mat")
	(SYNONYM MAT)
	(ADJECTIVE RUBBER RUBBERIZED NO-SLIP)
	(FLAGS TRYTAKEBIT DESC-IN-ROOMBIT)
	(ACTION MAT-F)>

<ROUTINE MAT-F ()
	 <COND (<VERB? TAKE>
		<TELL 
"Oh, oh, my back! The old discs are slipping again, and the strain is
taking its toll. I'm going to have to
rifle the cabinet again in search of that old rheumatoid nostrum. Forget
the mat. It'd be as dangerous as a ski slope to walk in here without
it on the floor." CR>)
	       (<VERB? SIT CLIMB-ON>
		<WASTES>)>>

<ROOM ATTIC 
      (LOC ROOMS)
      (DESC "Attic")
      (UP PER ATTIC-EXIT)
      (DOWN PER ATTIC-EXIT)
      (FLAGS INDOORSBIT)
      (GLOBAL MANOR DUELING STAIRS)
      (ACTION ATTIC-F)>

;"ATTIC phrasebit = turned around to right-side-up"

<ROUTINE ATTIC-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The attic is where the oxymoron is rumored to have been locked up
recently for years and years. There doesn't seem to be even a shred of
hard evidence, though, for such a secret rumor.">
		<COND (<FSET? ,ATTIC ,PHRASEBIT>
		       <TELL
" But the attic, once upside-down, has been set right by your turning
it around.">)
		      (T
		       <TELL 
" A funny thing though -- the place is upside-down: You're standing on
the ceiling with the floor above as the roof over your head.">)>
		<TELL CR CR "A sturdy, rickety stairway leads ">
		<COND (<FSET? ,ATTIC ,PHRASEBIT>
		       <TELL "down">)
		      (T
		       <TELL "up">)>
		<TELL " from here.">)>>
		  
<ROUTINE ATTIC-EXIT ()
	 <COND (<OR <AND <EQUAL? ,P-WALK-DIR ,P?DOWN>
			 <NOT <FSET? ,ATTIC ,PHRASEBIT>>>
		    <AND <EQUAL? ,P-WALK-DIR ,P?UP>
			 <FSET? ,ATTIC ,PHRASEBIT>>>
		<TELL "But the stairs lead ">
		<COND (<FSET? ,ATTIC ,PHRASEBIT>
		       <TELL "down">)
		      (T
		       <TELL "up">)>
		<TELL ,PERIOD>
		<RFALSE>)
	       (<EQUAL? ,P-WALK-DIR ,P?UP>
		<RETURN ,ID-ROOM>)
	       (T
		<RETURN ,KREMLIN>)>>

<ROUTINE ATTIC-ENTER ()
	 <COND (<AND <EQUAL? ,HERE ,ID-ROOM>
		     <FSET? ,ATTIC ,PHRASEBIT>>
		<TELL "The " D ,STAIRS "s have seemed to vanish." CR>
		<RFALSE>)
	       (<AND <EQUAL? ,HERE ,KREMLIN>
		     <NOT <FSET? ,ATTIC ,PHRASEBIT>>>
		<CANT-SEE <> "stairs">
		<RFALSE>)>
	 <TELL "You walk ">
	 <COND (<EQUAL? ,HERE ,ID-ROOM>
		<TELL "down">)
	       (T
		<TELL "up">)>
	 <TELL " the staircase." CR CR>
	 <RETURN ,ATTIC>>
		