"COMEDY for
		             NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<OBJECT COMEDY
	(LOC LOCAL-GLOBALS)
	(DESC "room")
	(PICK-IT "Act the Part")
	(MAX-SCORE 10)
	(SCENE-SCORE 0)
	(SCENE-ROOM FRONT-ROOM)
	(SCENE-CUR 0)
	(SYNONYM ROOM KITCHEN BATHROOM RESTROOM STAGE)
	(ADJECTIVE LIVING ROOM)
	(FLAGS NDESCBIT SCENEBIT)
	(ACTION COMEDY-F)>

<GLOBAL REAL-COMEDY <>>

<ROUTINE COMEDY-F ()
	 <COND (<ADJ-USED ,COMEDY ,W?LIVING>
		<SETG REAL-COMEDY ,FRONT-ROOM>)
	       (<NOUN-USED ,COMEDY ,W?KITCHEN>
		<SETG REAL-COMEDY ,TV-KITCHEN>)
	       (<NOUN-USED ,COMEDY ,W?BATHROOM ,W?RESTROOM>
		<SETG REAL-COMEDY ,W?BATHROOM>)>
	 <COND (<OR <NOT ,REAL-COMEDY>
		    <VERB? NO-VERB>
		    <AND <DONT-HANDLE ,COMEDY>
			 <NOT <VERB? WALK-TO>>>>
		<RFALSE>)
	       (<VERB? BOARD ENTER WALK-TO>
		<COND (<EQUAL? ,HERE ,REAL-COMEDY>
		       <TELL ,ARRIVED>)
		      (<EQUAL? ,REAL-COMEDY ,W?BATHROOM>
		       <TELL
"You hear someone behind the flimsy door whisper, \"Another move like that
and his career's in the toilet too,\" which stops you in your tracks." CR>) 
		      (T
		       <COND (<HELD? ,CORD>
			      <MOVE ,CORD ,HERE>
			      <TELL "[dropping the cord first]" CR CR>)>
		       <TELL "You walk across the stage." CR CR>
		       <GOTO ,REAL-COMEDY>)>)
	       ;(<VERB? EXIT WALK-TO>
		<COND (<NOUN-USED ,COMEDY ,W?LEFT>
		       <DO-WALK ,P?WEST>)
		      (<NOUN-USED ,COMEDY ,W?RIGHT>
		       <DO-WALK ,P?EAST>)>)
	       ;(<ADJ-USED ,COMEDY ,W?STAGE>
		<COND (<PRSO? ,COMEDY>
		       <SETG PRSO ,GLOBAL-ROOM>)
		      (T
		       <SETG PRSI ,GLOBAL-ROOM>)>
		<RFALSE>)
	       (<NOT <EQUAL? ,HERE ,REAL-COMEDY>>
		<CANT-SEE <> "such room">)
	       ;(T
		<CHANGE-OBJECT ,COMEDY ,GLOBAL-ROOM>
		<RTRUE>)>>

<OBJECT AUDIENCE
	(LOC LOCAL-GLOBALS)
	(DESC "audience")
	(SYNONYM CROWD AUDIENCE)
	;(ADJECTIVE LIVING STAGE)
	(FLAGS NDESCBIT ACTORBIT)
	(ACTION AUDIENCE-F)>

<ROUTINE AUDIENCE-F ()
	 <COND (<VERB? ENTER BOARD WALK-TO>
		<TELL "Nobody's seeking your autograph down there." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The blaring lights prevent you from getting even a glimpse of"
TR ,AUDIENCE>)
	       (<TOUCHING? ,AUDIENCE>
		<CANT-REACH ,AUDIENCE>)
	       (<VERB? TELL>
		<TELL
"A torrent of catcalling and heckling directs your mind back to the
stage." CR>
		<STOP>)>>
	       
<ROOM TV-KITCHEN 
      (LOC ROOMS)
      (DESC "Kitchen")
      (OUT PER TV-KITCHEN-EXIT)
      ;(WEST PER TV-KITCHEN-EXIT)
      (FLAGS INDOORSBIT)
      (GLOBAL COMEDY AUDIENCE)
      (ACTION TV-KITCHEN-F)>

<ROUTINE TV-KITCHEN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"The kitchen suffers from the neglect so often decried by the 1950's sitcom
husband in the presence of his 1950's sitcom wife.">)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <RUNNING? ,I-BOB>>
		<DEQUEUE I-BOB> ;"player passed up chance to put whoopie"
		<MOVE ,BOB ,YOUR-CHAIR>
		<TELL ;CR "Bob passes you going out." CR CR>)>>

<ROUTINE TV-KITCHEN-EXIT ()
	 <PUT ,P-ADJW 0 ,W?LIVING>
	 <PUT ,P-NAMW 0 ,W?ROOM>
	 <PERFORM ,V?WALK-TO ,COMEDY>
	 <RFALSE>>

<OBJECT COAT
	(DESC "coat")
      	(SYNONYM COAT)
     	(ADJECTIVE PIN-STRIPPED)
	(FLAGS CONTBIT SEARCHBIT TAKEBIT TRYTAKEBIT OPENBIT WEARBIT)
    	(SIZE 10)
	(CAPACITY 5)
	;(ACTION COAT-F)>

<OBJECT MATCH
	(LOC COAT)
	(SDESC "match stick")
      	(SYNONYM STICK MATCH)
     	(ADJECTIVE MATCH STICK LIGHTED)
	(FLAGS TAKEBIT LIGHTBIT)
	(ACTION MATCH-F)>

<ROUTINE MATCH-F ()
	 <COND (<AND <VERB? ON>
		     <NOT <FSET? ,MATCH ,ONBIT>>>
		<QUEUE I-MATCH -1>
		<PUTP ,MATCH ,P?SDESC "lighted match">
		<FSET ,MATCH ,ONBIT>
		<TELL 
"You scratch the match behind your left ear and it flares up." CR>)
	       (<AND <VERB? OFF>
		     <FSET? ,MATCH ,ONBIT>>
		<REMOVE ,MATCH>
		<DEQUEUE I-MATCH>
		<TELL "The match disintegrates and blows away." CR>)
	       (<AND <VERB? DROP PUT PUT-ON PUT-UNDER THROW>
		     <FSET? ,MATCH ,ONBIT>>
		<PERFORM ,V?BURN ,GROUND ,MATCH> ;"yells fire"
		<RTRUE>)>>

<GLOBAL MATCH-N 0>

<ROUTINE I-MATCH ()
	 <SETG MATCH-N <+ ,MATCH-N 1>>
	 <COND (<EQUAL? ,MATCH-N 4>
		<REMOVE ,MATCH>
		<DEQUEUE I-MATCH>
		<TELL CR "The match burns out, the ashes blow away">)
	       (T
		<TELL CR "The match continues burning down">)>
	 <TELL ,PERIOD>> 

<OBJECT FRIDGE
	(LOC TV-KITCHEN)
	(DESC "refrigerator")
	(SYNONYM REFRIGERATOR FRIDGE FRIG)
	;(ADJECTIVE BLUE)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT)
	;(ACTION FRIDGE-F)>

;<ROUTINE FRIDGE-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,CORD ,RMUNGBIT>>>
		<FSET ,CORD ,RMUNGBIT>
		)>>

<OBJECT LAMP
	(LOC FRONT-ROOM)
	(DESC "lamp")
	(DESCFCN LAMP-F)
	(SYNONYM LAMP LIGHT)
	(ADJECTIVE BRASS)
	(FLAGS CONTBIT OPENBIT SEARCHBIT SURFACEBIT NO-D-CONT DESC-IN-ROOMBIT
               TRYTAKEBIT LIGHTBIT ONBIT)
        (ACTION LAMP-F)>

<ROUTINE LAMP-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR "A brass lamp">
		<COND (<IN? ,LAMP-SHADE ,LAMP>
		       <TELL " with an ostentatious " D ,LAMP-SHADE>)>
		<TELL " stands out among the olive drab decor.">)
	       (<OR <AND <VERB? OFF>
		         <FSET? ,LAMP ,ONBIT>>
		    <AND <VERB? ON>
			 <FSET? ,CORD ,RMUNGBIT>>>
		<TELL 
"You hear a stage whisper, \"Another move like that and the light's going
to be out on his career.\"" CR>) ;"trying to hard to steal the scene"
	       (<AND <VERB? PUT PUT-ON>
		     <NOT <PRSO? ,LAMP-SHADE>>>
		<IMPOSSIBLES>)
	       (<VERB? UNPLUG>
		<PERFORM ,V?UNPLUG ,CORD>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "The lamp, currently ">
		<COND (<FSET? ,LAMP ,ONBIT>
		       <TELL "on">)
		      (T
		       <TELL "off">)>
		<TELL ", is ">
		<COND (<IN? ,LAMP-SHADE ,LAMP>
		       <TELL "adorned by a">)
		      (T
		       <TELL "devoid of its">)>
		<TELL " gaudy lamp shade." CR>)>>

<OBJECT LAMP-SHADE
	(LOC LAMP)
	(DESC "lamp shade")
	(SYNONYM SHADE TASSELS TASSEL)
	(ADJECTIVE LAMP OSTENTATIOUS GUADY PURPLE GOLD)
	(FLAGS NDESCBIT LIGHTBIT TAKEBIT WEARBIT)
	(ACTION LAMP-SHADE-F)>

;"RMUNGBIT worn it once"

<ROUTINE LAMP-SHADE-F ()
	 <COND (<AND <VERB? WEAR>
		     <NOT <FSET? ,LAMP-SHADE ,WORNBIT>>>
		<COND (<FSET? ,LAMP-SHADE ,RMUNGBIT>
		       <TELL ,WEARING-THIN>)
		      (T
		       <FSET ,LAMP-SHADE ,RMUNGBIT>
		       ;<FSET ,LAMP-SHADE ,WORNBIT>
		       <MOVE ,LAMP-SHADE ,PROTAGONIST>
		       <UPDATE-SCORE>
		       <TELL
"You lower the gaudy " D ,LAMP-SHADE " over your deadpan face, pretending
to be part of the furniture">
		       <COND (<IN? ,BOB ,YOUR-CHAIR>
			      <TELL 
", which is how " D ,BOB " has treated you">)>
		       <TELL 
". As the laughs die down, you remove the shade." CR>)>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,HEAD>>
		<PERFORM ,V?WEAR ,LAMP-SHADE>
		<RTRUE>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,BOB ,WIFE>>
		<COND (<FSET? ,LAMP-SHADE ,RMUNGBIT>
		       <PERFORM ,V?WEAR ,LAMP-SHADE>)
		      (T
		       <TELL "It's not " D ,PRSI "'s size." CR>)>
		<RTRUE>) 
	       (<AND <VERB? TAKE>
		     ;<EQUAL? <ITAKE> T>
		<NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<TELL 
"Taken.|
|
In your nervous hand, the " D ,LAMP-SHADE "'s gold tassels shake,
perceptible only to " D ,ME ", slightly back and forth." CR>)	       
	       (<VERB? EXAMINE>
		<TELL  "The lamp shade is a very gaudy shade of purple
and has a ring of gold tassels around its base." CR>)>>

<OBJECT CORD
	(LOC FRONT-ROOM)
	(DESC "electrical cord")
	(LDESC 
"An electrical cord is plugged into the wall, the other end having been
torn from the lamp.")
	(SYNONYM CORD WIRE PLUG)
	(ADJECTIVE ELECTRICAL LIVE)
	(FLAGS NDESCBIT TAKEBIT VOWELBIT)
	(ACTION CORD-F)>

;"rmungbit = can now refer to it"

<ROUTINE CORD-F ()
	 <COND (<AND <NOT <FSET? ,CORD ,RMUNGBIT>>
		     <OR <VERB? FIND>
			 <NOT <DONT-HANDLE ,CORD>>>>
		<TELL "As per the script, you don't notice any cord here." CR>)
	       (<VERB? REMOVE UNPLUG MOVE>
		    ;<AND <VERB? TAKE>
		         <NOT <FSET? ,CORD ,RMUNGBIT>>>
		<TELL 
"You hear a stage whisper that stops you: \"He might as well be pulling
the plug on his career.\"" CR>)
	       (<AND <VERB? PLUG>
		     <PRSI? ,WALL>>
		<TELL ,ALREADY-IS>)
	       (<VERB? TAKE>
		<TELL
"The audience sucks in its collective breath">
		<COND (<FSET? ,GLOVES ,WORNBIT>
		       <MOVE ,CORD ,PROTAGONIST>
		       <FCLEAR ,CORD ,NDESCBIT>
		       <TELL 
", and you gingerly pick up the live wire, with its end resting in the
palm of the glove">)
		      (T
		       <TELL 
" at your bare-handedness, which gives you pause">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,CORD ,RMUNGBIT>>
		<TELL 
"The cord is warm with flowing electricity, its end glowing pale red." CR>)>>

<OBJECT GLOVES
	(LOC TV-KITCHEN)
	(DESC "yellow rubber gloves")
	(SYNONYM GLOVES GLOVE)
	(ADJECTIVE RUBBER YELLOW)
	(FLAGS TAKEBIT WEARBIT PLURALBIT)
	(ACTION GLOVES-F)>

;"RMUNGBIT = have zapped Bob"

<ROUTINE GLOVES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL 
"They look \"heavy-duty and rugged enough for the darn dirtiest of
kitchen jobs.\" In fact, that's the advertising slogan used by this show's
sponsor, who manufactures the gloves. There's nothing wrong with a little
plug." CR>)
	       (<AND <VERB? TAKE-OFF>
		     <HELD? ,CORD>>
		<TELL 
"\"Not while you're holding the hot wire,\" an off-stage whisper
tells you." CR>)>>

<OBJECT SPONGE
	(LOC TV-KITCHEN)
	(DESC "blue sponge")
	(SYNONYM SPONGE)
	(ADJECTIVE BLUE)
	(FLAGS TAKEBIT)
	(GENERIC GEN-SPONGE)
	(ACTION SPONGE-F)>

<ROUTINE SPONGE-F ()
	 <COND (<VERB? PUSH>
		<TELL "It mashes, then springs back." CR>)>>

<ROUTINE GEN-SPONGE ()
	 <COND (<FSET? ,SPONGE ,RMUNGBIT>
		,SPONGE)
	       (T
		<RFALSE>)>>

<OBJECT KNIFE
	(LOC TV-KITCHEN)
	(DESC "scalpel-like knife")
	(SYNONYM KNIFE SCALPEL)
	(ADJECTIVE SCALPEL-LIKE)
	(FLAGS TAKEBIT)
	;(ACTION KNIFE-F)>

<OBJECT WATER-BOTTLE
	(LOC TV-KITCHEN)
	(DESC "hot-water bottle")
	(FDESC 
"There's a bottle in front of you. Your mind echos the phrase, \"a bottle
in front of me,\" which gives you ideas...")
	(SYNONYM BOTTLE CUSHION)
	(ADJECTIVE HOT-WATER HOT WATER WHOOPIE)
	(FLAGS TAKEBIT RMUNGBIT)
	(GENERIC GEN-CUSHION)
	(ACTION WATER-BOTTLE-F)>
	
;"rmungbit = bottle is FULL OF AIR"
;"phrasebit = points for him sitting on it"

<ROUTINE WATER-BOTTLE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,WATER-BOTTLE ,RMUNGBIT>
		       <TELL 
"The " D ,WATER-BOTTLE " is devoid of water but full of air">)
		      (T
		       <TELL 
"The " D ,WATER-BOTTLE " is empty and deflated">)>
		<TELL ,PERIOD>)
	       (<VERB? CLIMB-ON SIT PUSH>
		<COND (<FSET? ,WATER-BOTTLE ,RMUNGBIT>
		       <FCLEAR ,WATER-BOTTLE ,RMUNGBIT>
		       <TELL 
"\"Ppffff... thh... pffffff.\" The gag produces only a few random chuckles
out of the audience." CR>)
		      (T
		       <WASTES>)>) 
	       (<AND <VERB? TAKE>
		     <FSET? ,WATER-BOTTLE ,RMUNGBIT>
		     ;<EQUAL? <ITAKE> T>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<FCLEAR ,WATER-BOTTLE ,RMUNGBIT>     
		<TELL
"The " D ,WATER-BOTTLE ", which is devoid of water but puffed up with air,
is squeezed and emits a rude Bronx cheer." CR>;"remniscent of whoopie cushion")
	       (<VERB? INFLATE>
		<COND (<FSET? ,WATER-BOTTLE ,RMUNGBIT>
		       <TELL "It's already inflated">)
		      (T
		       <FSET ,WATER-BOTTLE ,RMUNGBIT>
		       <TELL 
"You huff and puff until the " D ,WATER-BOTTLE " is full of hot air. Some
members of the studio audience let out some anticipatory giggles">
		       <COND (<AND <VISIBLE? ,BOB>
				   <EQUAL? ,HERE ,FRONT-ROOM>
				   <ZERO? ,BOB-N>>
			      <QUEUE I-BOB -1>)>)>
		<TELL ,PERIOD>)
	       (<VERB? DEFLATE>
		<COND (<FSET? ,WATER-BOTTLE ,RMUNGBIT>
		       <MOVE ,WATER-BOTTLE ,HERE>
		       <PERFORM ,V?TAKE ,WATER-BOTTLE>
		       <RTRUE>)
		      (T
		       <TELL ,ALREADY-IS>)>)>>
	         
<ROUTINE GEN-CUSHION ()
	 ;<COND (<AND <VERB? PUT-UNDER PUT INFLATE>
		     <NOT ,NOW-PRSI>>
		,WATER-BOTTLE)
	       (T
		,YOUR-CHAIR)>
	 ,YOUR-CHAIR>

<OBJECT LOBOTOMY
	(LOC GLOBAL-OBJECTS)
	(DESC "frontal lobotomy")
	(SYNONYM LOBOTOMY)
	(ADJECTIVE FRONTAL)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION LOBOTOMY-F)>

<ROUTINE LOBOTOMY-F ()
	 <COND (<VERB? TAKE>
		<PERFORM ,V?GIVE ,LOBOTOMY ,ME>
		<RTRUE>)
	       (<VERB? NO-VERB>
		<CANT-SEE ,LOBOTOMY>)
	       (<VERB? GIVE>
		<COND (<NOT <HELD? ,KNIFE>>
		       <TELL "You've no scalpel." CR>)
		      (<PRSI? ,ME ,BOB ,WIFE>
		       <TELL
"You run the surgical-like instrument through the air an inch above ">
		       <COND (<PRSI? ,ME>
			      <TELL "your">)
			     (<PRSI? ,WIFE>
			      <TELL "the lady's">)
			     (T
			      <TELL D ,PRSI "'s">)>
		       <TELL " scalp. ">
		       <COND (<EQUAL? ,SCENE ,COMEDY>
			      <COND (<NOT <FSET? ,LOBOTOMY ,RMUNGBIT>>
			             <FSET ,LOBOTOMY ,RMUNGBIT>
			             <UPDATE-SCORE>
				     <TELL 
"The crowd loves it. You've really got them eating out of your hand">)
				    (T
				     <TELL ,WEARING-THIN>
				     <RTRUE>)>)
			     (T
			      <RTRUE>)>
			      <TELL ,PERIOD>)>)>> 

<OBJECT BOB
	;(LOC FRONT-ROOM)
	(DESC "your brother-in-law Bob")
	(SYNONYM BOB SPONGE DWAYNE)
	(ADJECTIVE ;BOB MR BROTHER-IN-LAW BOB\'S BOBS) 
					 ;"bob's must exist for bob's shoe"
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT NDESCBIT
	       NARTICLEBIT)
	(GENERIC GEN-SPONGE)
	(ACTION BOB-F)>
  
<GLOBAL KILLING-BOB <>>

<ROUTINE BOB-F ()
	 <COND (<VERB? SGIVE>
		<RFALSE>)
	       (<NOUN-USED ,BOB ,W?SPONGE>
		<COND (<EQUAL? ,WINNER ,BOB>
		      <STOP>)>
		<COND (<FSET? ,SPONGE ,RMUNGBIT>
		       <TELL "This joke is getting old." CR>)
		      (T
		       <FSET ,SPONGE ,RMUNGBIT>
		       <UPDATE-SCORE>
		       <TELL 
"The crowd erupts with laughter as you seem to equate " D ,BOB " with
a sponge." CR>)>
		<COND (<VERB? TELL> ;"sponge, hello"
		       <STOP>)>
		<RTRUE>)>
	 <COND (<VERB? TELL>
		<TELL "He doesn't seem to want to be bothered." CR>
		<STOP>)
	       (<AND <VERB? KILL MUNG CUT>
		     <PRSO? ,BOB>>
		<COND (<NOT ,KILLING-BOB>
		       <SETG KILLING-BOB T>
		       <TELL
"As you hunch your shoulders in exasperation at " D ,BOB ", the audience
starts to howl, but is quieted by your sudden deadpan expression when
you imagine the mess involved, the funeral arrangements and the prison
sentence." CR>)
		      (T
		       <TELL
"Your object is to kill the audience, not poor Bob." CR>)>)     
	       (<AND <VERB? EXAMINE>
		     <IN? ,BOB ,YOUR-CHAIR>>
	        <TELL
"Bob is lounging in your favorite chair with his feet in the air, staring
at the boob tube. He's nattily dressed from head to toe">
		<COND (<FSET? ,FOOT ,RMUNGBIT>
		       <TELL " except for one charred shoe">)
		      (T
		       <TELL 
", that is, except for the toe of one shoe, which has a small hole in it">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? TOUCH>
		     <PRSI? ,CORD>>
		<PERFORM ,V?SHAKE-WITH ,HANDS ,BOB>
		<RTRUE>)
	       (<AND <VERB? SHAKE-WITH>
		     <PRSO? ,HANDS>>
		<COND (<EQUAL? ,KNOCK-N 3> ;"from not-here-obj-f clock no move"
		       <COND (<EQUAL? <GET ,P-ADJW 0> ,W?BOB\'S ,W?BOBS
				           ,W?BROTHER-IN-LAW>
			      <I-KNOCK>)
			     (T
			      ;<UPDATE-SCORE> ;"no points now"
			      <RTRUE>)>)
		      (<AND <HELD? ,CORD>
			    <FSET? ,GLOVES ,WORNBIT>>
		       <COND (<FSET? ,GLOVES ,RMUNGBIT>
			      <TELL "He's not falling for that again." CR>)
			     (T
			      <FSET ,GLOVES ,RMUNGBIT>
			      <UPDATE-SCORE>
		              <TELL
"Bob reflexively extends his hand...|
|
\"Za za za za za za Zap!\" Electrified by the experience, with his hair
sticking straight out and a frightful expression stamped on his face, " D ,BOB " is
powered willy-nilly into the air, with an involuntarily tight grip on the
cord. You're holding the other end with your " D ,GLOVES ", smiling calmly,
as if you had a fly on the end of a string. The crowd loves it.|
|
With a yank on the cord, Bob lands in a heap back onto your chair, a little
shaken but no worse for the scare." CR>)>)
		      (T
		       <TELL 
"\"You're hip to that trick,\" a stage whisper says." CR>)>)
	       (<VERB? FOLLOW>
		<COND (<EQUAL? ,FOLLOW-FLAG 2>
		       <PUT ,P-NAMW 0 ,W?KITCHEN>
		       <PERFORM ,V?WALK-TO ,COMEDY>
		       <RTRUE>)
		      (<EQUAL? ,FOLLOW-FLAG 3>
		       <PUT ,P-NAMW 0 ,W?ROOM>
		       <PUT ,P-ADJW 0 ,W?LIVING>
		       <PERFORM ,V?WALK-TO ,COMEDY>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)>>

<OBJECT BOB-SHOE
	(LOC BOB)
	(SYNONYM FOOT FEET SHOE SHOES HOLE TIP)
	(ADJECTIVE CHARRED BOBS ;BOB BOB\'S BROTHER-IN-LAW)
	(DESC "Bob's shoe")
	(FLAGS NDESCBIT NARTICLEBIT TRYTAKEBIT)
	(ACTION BOB-SHOE-F)>

;"rmungbit = hot foot given to bob"

<ROUTINE BOB-SHOE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "There's a small ">
		<COND (<FSET? ,BOB-SHOE ,RMUNGBIT>
		       <TELL "charred ">)>
		<TELL "hole at the tip of " D ,BOB-SHOE ,PERIOD>)
	       (<VERB? TAKE REMOVE TAKE-OFF>
		<TELL 
"Bob's knee-jerk response is to give you a pointed rejection, which impacts
your chin." CR>)
	       (<AND <VERB? PUT>
		     <PRSO? ,MATCH>>
		<COND (<FSET? ,MATCH ,ONBIT>
		       <UPDATE-SCORE>
		       <FSET ,BOB-SHOE ,RMUNGBIT>
		       <DEQUEUE I-MATCH>
		       <REMOVE ,MATCH>
		       <TELL 
"As you slide the match neatly into the shoe hole, waves of knowing
snickers ripple through the audience. With his eyes still glued to the
television, " D ,BOB "
tilts his head to one side, and sniffs the air twice. \"I smell something
burning, Sammy. You better go into the kitchen and check it
Ow-wow-wow-wow-wow-wow-wow-wowwy!\"|
|
In a blur, the hot-footed Bob leaps from the chair and performs
a Hiawathan rain dance to the insistent, rhythmic beat of Indian drums.|
|
The crowd loves it.|
|
There is the final sound effect of a thunder clap in the distance, and Bob
hunkers paranoically back down in your chair, staring again at the TV." CR>)
		      (T
		       <TELL
"With the match not lit, it wouldn't be a very hot hot foot." CR>)>)
	       (<AND <VERB? PUT>
		     <NOUN-USED ,BOB-SHOE ,W?HOLE>>
		<TELL "The hole's too small." CR>)>>

<ROOM FRONT-ROOM 
      (LOC ROOMS)
      (DESC "Your Living Room")
      (OUT PER FRONT-ROOM-EXIT)
      ;(EAST PER FRONT-ROOM-EXIT)
      (FLAGS INDOORSBIT)
      (GLOBAL COMEDY AUDIENCE)
      (ACTION FRONT-ROOM-F)>

<GLOBAL YOUR-CHAIR-KLUDGE <>>

<ROUTINE FRONT-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Glaring bright lights bake down upon the stage.|
|
The living room of your apartment is furnished in the drab period style of the
1950's situation comedy. Luckily, there's not much furniture on the set for you
to bump into. However, one brass lamp">
		<COND (<IN? ,LAMP-SHADE ,LAMP>
		       <TELL
" with a rather ostentatious lamp shade">)>
		<TELL 
" stands here. A flimsy, union-constructed front door leads out of
the apartment, another door leads to the bathroom. Both are closed. Your
kitchen is at the other side of the stage.">)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <EQUAL? ,ORPHAN-FLAG ,SHOULDER>
		     <VISIBLE? ,BOB>
		     <NOT <FSET? ,SHOULDER ,SEENBIT>>
		     <NOT <VERB? CRAWL>>
		     <OR <NOT <VERB? NO-VERB>>
			 <PRSO? ,COMEDY>>>
		<FSET ,SHOULDER ,SEENBIT>
		<QUEUE I-BOB 2>
		<QUEUE I-ORPHAN 2>
		<TELL "Bob interrupts you. " ,FLY>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <RUNNING? ,I-KNOCK>
		     <VERB? WALK WALK-TO BOARD ENTER>>
		<COND (<EQUAL? ,KNOCK-N 1 2>
		       <TELL 
"The urgency of the unseen voice stops you in your tracks." CR>)
		      (<EQUAL? ,KNOCK-N 3>
		       <TELL "Your brother-in-law trips you up." CR>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND <ZERO? ,BOB-N>
			    <FSET? ,WATER-BOTTLE ,RMUNGBIT>
			    <HELD? ,WATER-BOTTLE>>
		       <QUEUE I-BOB -1>)>
		<COND (,YOUR-CHAIR-KLUDGE
		       <SETG YOUR-CHAIR-KLUDGE <>>
		       <FCLEAR ,YOUR-CHAIR ,NDESCBIT>)>
		<RTRUE>)		      
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <FSET? ,TV-KITCHEN ,TOUCHBIT>
		     <NOT <FSET? ,CORD ,RMUNGBIT>>>
		;<MOVE ,WATER-BOTTLE ,TV-KITCHEN>
		<FSET ,CORD ,RMUNGBIT>
		<FCLEAR ,LAMP ,ONBIT>
		<FCLEAR ,CORD ,NDESCBIT>
		<FSET ,YOUR-CHAIR ,NDESCBIT>
		<SETG YOUR-CHAIR-KLUDGE T>
		<TELL 
"Well, it seems that Bob has already taken the liberty of moving
the lamp away from his TV viewing area and over near the kitchen entrance,
where you now have the misfortune of tripping over the cord from the lamp.|
|
You take a pratfall, landing heavily on the floor to the beat of a bass drum,
and then a rim shot. The crowd loves it.|
|
Meanwhile, the live wire, ripped from the lamp but still plugged into
the wall, snakes around the floor, spitting sparks out of the end that
was torn from the lamp.|
|
Bob, who is kicking back on your favorite chair, is too engrossed with
the TV to notice any of this." CR CR>)>>

<ROUTINE FRONT-ROOM-EXIT ()
	 <PUT ,P-NAMW 0 ,W?KITCHEN>
	 <PERFORM ,V?WALK-TO ,COMEDY>
	 <RFALSE>>	 

<OBJECT FRONT-DOOR 
	(LOC FRONT-ROOM)
	(DESC "front door")
	(SYNONYM DOOR)
	(ADJECTIVE FRONT)
	(FLAGS NDESCBIT DOORBIT)
	(ACTION FRONT-DOOR-F)>

<ROUTINE FRONT-DOOR-F ()
	 <COND (<VERB? OPEN>
		<TELL 
"You strain to open it, but the door seems to be held shut from the other
side by a strong pair of stage hands." CR>)>> 

<OBJECT BATHROOM-DOOR 
	(LOC FRONT-ROOM)
	(DESC "bathroom door")
	(SYNONYM DOOR)
	(ADJECTIVE BATHROOM)
	(FLAGS NDESCBIT DOORBIT LOCKEDBIT)
	(ACTION BATHROOM-DOOR-F)>

<ROUTINE BATHROOM-DOOR-F ()
	 <COND (<VERB? OPEN>
		<TELL "It seems locked shut." CR>)>>

<GLOBAL BOB-N 0>

;"have whoopie inflated, i-bob starts with fly question,
 then leaves to stock up"
<ROUTINE I-BOB () 
	 <INC BOB-N>
	 <QUEUE I-BOB -1>
	 <COND (<EQUAL? ,BOB-N 1>
		<SETG ORPHAN-FLAG ,SHOULDER>
		<QUEUE I-ORPHAN 2>
		<TELL CR "Bob says, " ,FLY>)
	       (<EQUAL? ,BOB-N 2>
		<MOVE ,BOB ,TV-KITCHEN>
		;<MOVE ,REMOTE ,HERE>
	        <TELL CR 
"Bob gets up and marches toward the kitchen, evidently to stock up
on more goodies." CR>)>>

<OBJECT WIFE
	;(LOC FRONT-ROOM)
	(SDESC "lady")
	(SYNONYM LADY WIFE GORILLA GIRL)
	(ADJECTIVE YOUR MY)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT NDESCBIT FEMALEBIT)
	(GENERIC GEN-GIRL)
	(ACTION WIFE-F)>

;"RMUNGBIT = in wife-f verb tell"
;"SEENBIT = don't requeue i-wife when re-entering scene"

<ROUTINE WIFE-F ()
	 <COND (<AND <NOUN-USED ,WIFE ,W?LADY>
		     <VISIBLE? ,WIFE>>
		<PUTP ,WIFE ,P?SDESC "your wife">
		<FSET ,WIFE ,NARTICLEBIT>
		<COND (<EQUAL? ,WINNER ,WIFE> ;"ask wife about x, for ex."
		       <STOP>)>
		<TELL "That's no lady, that is your wife." CR>
		<COND (<VERB? TELL> ;"wife, hello"
		       <STOP>)>
		<RTRUE>)>
	 <COND (<VERB? EXAMINE>
		<TELL 
"From the looks of it, her answer to your ">
		<ITALICIZE "first" T>
		<TELL 
" question at the door was pretty accurate." CR>)  
	       (<VERB? TELL>
		<COND (<NOT <FSET? ,WIFE ,RMUNGBIT>>
		       <FSET ,WIFE ,RMUNGBIT>
		       <TELL
"Your wife starts haltingly to speak then shuts her trap in anger. In
the vernacular, her breath will take your beauty away">)
		      (T
		       <TELL "You're not on speaking terms">)>
		<TELL ,PERIOD>
		<STOP>)>>

<GLOBAL WIFE-N 0>

<GLOBAL KNOCK-N 0>

<GLOBAL KNOCK-JOKE <>> ;"set to W?BOB, W?DWAYNE or W?GORILLA"

<ROUTINE I-KNOCK ()
	 <QUEUE I-KNOCK -1>
	 <COND (<EQUAL? ,KNOCK-N 0>
		<INC KNOCK-N>
		<COND (<EQUAL? ,KNOCK-JOKE ,W?DWAYNE> ;"knock-n now 1"
		       <RTRUE>)                       ;"for v-who"
		      (T
		       <THIS-IS-IT ,GLOBAL-ROOM>
		       <TELL CR "You hear a ">
		       <COND (<EQUAL? ,KNOCK-JOKE ,W?GORILLA>
			      <TELL "wo">)>
		       <TELL 
"man's voice from the other side of your front door. \"Knock knock.\"" CR>)>)
	       (<AND <EQUAL? ,KNOCK-N 1>
		     <OR <NOT <VERB? WHO>>
			 <NOT <PRSO? ,GLOBAL-ROOM>>>>
		<TELL CR 
"\"Come on! Knock knock!\" booms the voice behind the door.|
|
An off-stage voice whispers to you insistently, \"Timing, timing.\"" CR>)
	       (<EQUAL? ,KNOCK-N 3>
		<INC KNOCK-N>
		;<UPDATE-SCORE> ;"points in bob-f"
		;<FSET ,BOB ,NDESCBIT>
		<MOVE ,BOB ,TV-KITCHEN>
		<TELL CR 
"Bob enthusiastically grabs your hand in greeting.|
|
\"Bzzzzzzzzzzzzz!\"|
|
It feels like you are shaking hands with a Hoover Dam generator, as
the mega-voltages of power surging into the palm
of " D ,HANDS " cause your entire body to writhe.|
|
Bob doubles himself over with knee-slapping, gasping laughter. \"I guess
I got you that time, eh?\" he says, flashing you the joy buzzer in his
palm, and then skates into the kitchen." CR>
		<SETG FOLLOW-FLAG 2>
		<QUEUE I-FOLLOW 2>)
	       (<EQUAL? ,KNOCK-N 4>
		<INC KNOCK-N>
		<MOVE ,BOB ,FRONT-ROOM>
		<FSET ,BOB ,NDESCBIT>
		<COND (<EQUAL? ,HERE ,TV-KITCHEN>
		       <TELL CR
"Your brother-in-law Bob swings open the refrigerator door, loads himself
down, shuts the fridge door with his knee, and with his movable feast
shuffles back into the living room." CR>
		       <SETG FOLLOW-FLAG 3>
		       <QUEUE I-FOLLOW 2>)
		      (<EQUAL? ,HERE ,FRONT-ROOM>
		       <I-KNOCK>)>)
	       (<EQUAL? ,KNOCK-N 5>
		<SETG KNOCK-N 0>
		<DEQUEUE I-KNOCK>
		<MOVE ,BOB ,YOUR-CHAIR>
		<FCLEAR ,BOB ,NDESCBIT>
		;<FCLEAR ,YOUR-CHAIR ,NDESCBIT> ;"set in this move m-enter"
		<MOVE ,REMOTE ,BOB>
		<FSET ,TV ,ONBIT>
		<COND (<AND <EQUAL? ,HERE ,FRONT-ROOM>
			    <NOT <VERB? WALK WALK-TO EXIT>>>
		       <TELL CR
"In a hurry " D ,BOB " waltzes in here from the kitchen. He hops
onto " D ,YOUR-CHAIR ", puts his feet up, whips out a remote
device from under the seat cushion, and flicks on your TV set, absorbing
himself in the watching of it." CR>)>)>>

<OBJECT TV
	(LOC FRONT-ROOM)
	(DESC "television set")
	(SYNONYM SET CHANNEL STATION TV TELEVISION)
	(ADJECTIVE TELEVISION TV)
	(FLAGS LIGHTBIT NDESCBIT)
	(ACTION TV-F)>

;"rmungbit = toggle on off"

<ROUTINE TV-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <FSET? ,TV ,ONBIT>>
		<TELL "It's a hazy bluish picture of ">
		<COND (<FSET? ,TV ,RMUNGBIT>
		       <FCLEAR ,TV ,RMUNGBIT>
		       <TELL "cowboys chasing Indians">)
		      (T
		       <FSET ,TV ,RMUNGBIT>
		       <TELL "Indians chasing cowboys">)>
		<TELL ,PERIOD>)
	       (<VERB? UNPLUG>
		<PERFORM ,V?UNPLUG ,CORD>
		<RTRUE>)
	       (<VERB? OFF SET>
		<TELL 
"The knob seems to be missing, and you can thank the prop department for
that. But they were just doing their job as an off-stage whisper confirms,
\"You can't ">
		<COND (<VERB? SET>
		       <TELL "change the channel">)
		      (T
		       <TELL "turn it off">)>
		<TELL ".\"" CR>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,TV>>
		<TELL 
"You couldn't get" T ,PRSO " on television even if you were its agent." CR>)>>

<OBJECT REMOTE
	(DESC "remote control device")
	(SYNONYM DEVICE)
	(ADJECTIVE REMOTE CONTROL)
	(FLAGS TAKEBIT)
	(ACTION REMOTE-F)>

;"rmungbit = told of crossed signals"

<ROUTINE REMOTE-F ()
	 <COND (<AND <NOT <FSET? ,REMOTE ,RMUNGBIT>>
		     <VISIBLE? ,REMOTE>>
		<FSET ,REMOTE ,RMUNGBIT>
		<TELL
"\"Remote control television in the 1950's?\" you wonder. Some TV signals
must have gotten crossed, because there it is." CR CR>)>
	 <COND (<AND <VERB? TAKE>
		     <IN? ,REMOTE ,BOB>>
		<TELL 
"Looking childish and stubborn, Bob pulls it back close to himself." CR>)>>

<OBJECT YOUR-CHAIR
	(LOC FRONT-ROOM)
	(DESC "YOUR comfy chair")
	(DESCFCN YOUR-CHAIR-F)
	(SYNONYM CHAIR CUSHION SEAT)
	(ADJECTIVE THICK SEAT CUSHION YOUR MY COMFY FAVORITE)
	(FLAGS VEHBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT
               NARTICLEBIT)
	(GENERIC GEN-CUSHION)
	(ACTION YOUR-CHAIR-F)>

<ROUTINE YOUR-CHAIR-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-BEG>
		       <RFALSE>)
		      (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<CRLF>
		<COND (<IN? ,BOB ,YOUR-CHAIR>
		       <TELL "Your brother-in-law Bob is kicking back on
your favorite chair, feeding his face and staring at the television">
		       <COND (<NOT <FSET? ,FOOT ,RMUNGBIT>>
			      <TELL 
". With his feet jutting out into the air, you notice a small hole at the
tip of one of his much-travelled shoes">)>
		       <TELL ".">)
		      (T
		       <TELL 
"Your favorite chair sits here facing the television.">)>)
	       (.OARG
		<RFALSE>)
	       (<VERB? EXAMINE>
		<COND (<IN? ,BOB ,YOUR-CHAIR>
		       <TELL "It's being occupied by" TR ,BOB>)
		      (T
		       <TELL 
"It's nice and fluffy and comfortable-looking, with a thick cushion
seat." CR>)>)
	       (<AND <VERB? BOARD PUT-UNDER LOOK-UNDER>
	             <IN? ,BOB ,YOUR-CHAIR>>
		<TELL 
"Bob, his arms folded and his legs pedaling in the air, backs you away
from ">
		<ITALICIZE "your">
		<TELL " chair." CR>)
	       (<VERB? BOARD>
		<TELL
"You settle serenely into your chair of heavenly comfort. But before the
relaxing effect is able to take hold of you like magic fingers, you are
snapped to attention by the heckling of directoral off-stage whispers.
As if under a spell, you rise to your feet." CR>)  
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,YOUR-CHAIR>>
		<COND (<PRSO? ,WATER-BOTTLE>
		       <TELL "It would be visible there">)
		      (T
		       <TELL "The crowd boos, so you back away instead">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? LOOK-UNDER>
		     <ZERO? <LOC ,REMOTE>>>
		<TELL
"Offstage a voice whispers you away from the chair." CR>)
	       (<VERB? PUT-UNDER>
		<COND (<IN? ,PROTAGONIST ,YOUR-CHAIR>
		       <TELL "You're on it!" CR>)
		      (<AND <PRSO? ,WATER-BOTTLE>
			    <FSET? ,WATER-BOTTLE ,RMUNGBIT>>
		       <COND (<RUNNING? ,I-KNOCK>
			      <TELL "Stage whispers warn you off." CR>
			      <RTRUE>)>
		       <UPDATE-SCORE>
		       <FCLEAR ,WATER-BOTTLE ,RMUNGBIT>
		       <FSET ,WATER-BOTTLE ,PHRASEBIT>
		       <MOVE ,BOB ,YOUR-CHAIR>
		       <MOVE ,WATER-BOTTLE ,HERE>
		       <DEQUEUE I-BOB>
		       <TELL  "You slip the whoopee cushion into
position. The audience begins tittering.||In walks the unsuspecting Bob,
who is loaded down with goodies. He plops onto " D ,YOUR-CHAIR ".||
\"Bbbthpppffffthppp!\" The crowd howls as poor Bob nearly loses his
lunch in shock." CR>)
		      (T
		       <TELL 
"The crowd boos, stopping your hand. \"Booo... boooo.\"" CR>)>)>>
		       