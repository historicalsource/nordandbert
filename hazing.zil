"HAZING for
		             NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"A thick, ocean-like spray blows in from the Rhine and sweeps along
the shoreline. As the cloud slowly lifts When the  "

<OBJECT HAZING
	(LOC LOCAL-GLOBALS)
	(DESC "place")
	(PICK-IT "Shake a Tower")
	(MAX-SCORE 26 ;24) ;"added point for 'show me to seat'"
	(SCENE-SCORE 0)
	(SCENE-ROOM CLEARING)
	(SCENE-CUR 0)
	(SYNONYM CLEARING SHORE FACTORY STOCK STALK BEANSTALK ROOM CLOUD JACK)
	(ADJECTIVE BEAN JEAN STOCK CLOUD OLD)
	(FLAGS NDESCBIT SCENEBIT)
	(GENERIC GEN-BEAN-STALK)
	(ACTION HAZING-F)>

;"JACK AND THE BEAN STALK parses as JACK, BEAN STALK as V-TELL JACK
which to V-TELL which sets winner to hazing and RTRUEs, thus to hazing
with it as winner. If not Handled, at end of routine if winner 'recognize'
called." 

<GLOBAL REAL-HAZING <>>

<ROUTINE HAZING-F ()
	 <COND (<NOUN-USED ,HAZING ,W?CLEARING>
		<SETG REAL-HAZING ,CLEARING>)
	       (<NOUN-USED ,HAZING ,W?SHORE>
		<SETG REAL-HAZING ,SHORE>)
	       (<NOUN-USED ,HAZING ,W?FACTORY>
		<SETG REAL-HAZING ,FACTORY>)
	       (<OR <NOUN-USED ,HAZING ,W?STOCK>
		    <ADJ-USED ,HAZING ,W?JEAN ,W?STOCK>>
		<COND (<EQUAL? ,HERE ,CLOUD-ROOM>
		       <TELL 
"The stalk only quivers slightly underfoot. Not being in full view of the
stalk, you can't seem to transform it." CR>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,STALK-ROOM>
			    <RUNNING? ,I-CLIENT>>
		       <TELL 
"The " D ,CLIENT " deflects your thoughts of the">
		       <COND (<PRSO? ,HAZING>
			      <PRSO-PRINT>)
			     (T
			      <PRSI-PRINT>)>
		       <TELL "." CR>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,STALK-ROOM>
		       <TELL
"A swift cloud of dust blows up from the trackless wastes into your face,
causing you to bring your fists to your eyes like binoculars. After much
rubbing, your vision, though blurry at first, returns to reveal familiar
surroundings..." CR CR>
		       <GOTO ,STOCK-ROOM>
		       <RTRUE>)>
		<SETG REAL-HAZING ,STOCK-ROOM>)
	       ;(<AND <EQUAL? ,WINNER ,HAZING>
		     <VERB? NO-VERB>
		     <OR <NOUN-USED ,HAZING ,W?STALK>
			 <ADJ-USED ,HAZING ,W?BEAN>>>
		<SETG WINNER ,PROTAGONIST>
		<PERFORM ,V?NO-VERB ,PRSO>
		<STOP>)
	       (<OR <NOUN-USED ,HAZING ,W?STALK ,W?BEANSTALK>
		    <ADJ-USED ,HAZING ,W?BEAN ,W?STALK>>
		<COND (<IN? ,CLIENT ,HERE>
		       <TELL
"The " D ,CLIENT " must've read your thoughts and he must not
have enjoyed what he read, since he angrily snaps a pair of jeans at you,
and your thoughts stray from" TR ,JEAN-STOCK>
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,STOCK-ROOM>
		       <COND (<NOT <FSET? ,STALK-ROOM ,TOUCHBIT>>
		              <UPDATE-SCORE>)>
		       <TELL
"The mile-high stack of jeans slowly leans heavily into your direction and
as it passes the point of no return in a chaos of color, fabric and rivets,
all the jeans come tumbling down upon your head,">
		       <COND (<OR <HELD? ,ICICLE>
				  <EQUAL? <LOC ,PROTAGONIST> ,ICICLE>>
			      <TELL " knocking the " D ,ICICLE " away and">
		       	      <MOVE ,ICICLE ,STOCK-ROOM>)>
		       <TELL " burying you completely in blackness.||
When you come to, it's in a new environment..." CR CR>
		       <MOVE ,PROTAGONIST ,HERE> ;"get off bike"
		       <GOTO ,STALK-ROOM>
		       <RTRUE>)>
		<SETG REAL-HAZING ,STALK-ROOM>)
	       (<OR <NOUN-USED ,HAZING ,W?CLOUD>
		    <ADJ-USED ,HAZING ,W?CLOUD>>
		<SETG REAL-HAZING ,CLOUD-ROOM>)
	       ;(T
	        <SETG REAL-HAZING ,DESSERT-ROOM>)>
	 <COND (<OR <NOT ,REAL-HAZING>
		    <VERB? NO-VERB TELL> ;"for 'jack and the bean stalk'"
		    <AND <DONT-HANDLE ,HAZING>
			 <NOT <VERB? WALK-TO>>>>
		<RFALSE>)
	       (<VERB? WALK-TO>
		<COND (<EQUAL? ,HERE ,REAL-HAZING>
		       <TELL ,ARRIVED>)
		      (<EQUAL? ,HERE ,CLOUD-ROOM>
		       <COND (<EQUAL? ,REAL-HAZING ,STALK-ROOM>
			      <DO-WALK ,P?DOWN>
			      <RTRUE>)>
		       <TELL "Can't get there from here." CR>)
		      (<EQUAL? ,REAL-HAZING ,CLOUD-ROOM>
		       <COND (<EQUAL? ,HERE ,STALK-ROOM>
			      <DO-WALK ,P?UP>
			      <RTRUE>)
			     (T
			      <TELL 
"All that's on a whole different plane of existence. The departure point
of that existence is the stock room." CR>)>)
		      (<EQUAL? ,HERE ,STALK-ROOM>
		       <COND (<EQUAL? ,REAL-HAZING ,CLOUD-ROOM>
			      <DO-WALK ,P?UP>)
			     (T
			      <TELL 
"It's on a different plane of existence." CR>
			      <RTRUE>)>)
		      (<AND <EQUAL? ,HERE ,CLEARING>
		            <NOT <FSET? ,REAL-HAZING ,TOUCHBIT>>>
		       <TELL "You don't know the way there." CR>)
		      (<AND <EQUAL? ,REAL-HAZING ,FACTORY>
			    <NOT <IN? ,PROTAGONIST ,ICICLE>>>
		       <COND (<NOT <IN? ,LINES ,SHORE>>
			      <TELL ,DONT-KNOW-WHERE>)
			     (<NOT <FSET? ,FACTORY ,TOUCHBIT>>
			      <TELL  "You follow in the precise
direction of the shepherd. It's trecherous going, since you're
travelling over dill and hail -- that is, pickles strewn along the
paths, and ice chunks hurling from the sky. You eventually come upon an
out-of-the-way spot along the now quite polluted river. It's a prime
location for such a flagrant violator of anti-pollution laws as the old
factory, between whose grimy gates you suspiciously enter." CR CR>
			      <GOTO ,FACTORY>)
			     (<EQUAL? ,HERE ,STOCK-ROOM>
			      <TELL "You walk into the factory." CR CR>
			      <GOTO ,FACTORY>)
			     (T
			      <TELL "You travel over hill and dale..." CR CR>
			      <GOTO ,FACTORY>)>)
		      (<AND <EQUAL? ,REAL-HAZING ,STOCK-ROOM>
			    <NOT <EQUAL? <LOC ,PROTAGONIST> ,ICICLE>>
			    <NOT <EQUAL? ,HERE ,CLEARING>>>
		       <COND (<NOT <FSET? ,FACTORY ,TOUCHBIT>>
			      <TELL ,DONT-KNOW-WHERE>
			      <RTRUE>)
			     (<EQUAL? ,HERE ,FACTORY>
			      T)
			     (<EQUAL? ,HERE ,SHORE>
			      <TELL 
"You follow the direction of the shepherd." CR CR>)
			     ;(<EQUAL? ,HERE ,CLEARING>
			      <TELL "You find your way back." CR>)>
		       <GOTO ,STOCK-ROOM>)
		      (<EQUAL? ,REAL-HAZING ,STALK-ROOM>
		       <CANT-GET-THERE>)
		      (<AND <EQUAL? ,REAL-HAZING ,CLEARING>
		            <NOT ,ELF-TOLD>>
		       <TELL "You don't know the way back." CR>)
		      (<AND <NOT <IN? ,PROTAGONIST ,ICICLE>>
			    <OR <EQUAL? ,REAL-HAZING ,CLEARING>
				<AND <EQUAL? ,REAL-HAZING ,SHORE ,FACTORY
					     ,STOCK-ROOM>
				     <EQUAL? ,HERE ,CLEARING>>>>
		       <TELL 
"You'd need transportation to get there." CR>)
		      (<IN? ,PROTAGONIST ,ICICLE>
		       <MOVE ,ICICLE ,REAL-HAZING>
		       <COND (<EQUAL? ,REAL-HAZING ,CLEARING>
			      <TELL 
"With all the enthusiasm of a child actor in a Steven Spielberg movie
with a percentage, you pedal away...">)
			     (T
			      <TELL 
"Pedaling madly away, you ride like the wind...">)>
		       <CRLF> <CRLF>
		       <GOTO ,REAL-HAZING>)
		      (T
		       <TELL "You go there." CR CR>
		       <GOTO ,REAL-HAZING>)>)
	       (<EQUAL? ,HAZING ,WINNER>
		<RECOGNIZE>
		<RTRUE>)
	       (<NOT <EQUAL? ,HERE ,REAL-HAZING>>
		<CANT-SEE <> "such place">)
	       ;(T
		<CHANGE-OBJECT ,HAZING ,GLOBAL-ROOM>
		<RTRUE>)>>

<ROUTINE GEN-BEAN-STALK ()
	 ,BEAN-STALK>

<ROOM CLEARING     ;"should be actual road you're on"
      (LOC ROOMS)
      (DESC "Clearing")
      (GLOBAL HAZING)
      (ACTION CLEARING-F)>

;"You come upon a clearing. A distraught father has lost his daughter.
He wanders along the road with his head down. The road not taken or such.
One of the eight roads. Is pessimistic of his
chances for finding her. 'they will go to great lengths to keep her from me.'"

<ROUTINE CLEARING-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"You're in a clearing of a deep, dark forest.">)>> 

<OBJECT SHINING-DOOR
	(LOC CLEARING)
	(OLDDESC "door")
	(NEWDESC "shore")
	(OLD-TO-NEW 
"The wind suddenly picks fiercly, and blows blinding sand the volume
of dunes into the area. When the wind dies down, you find your surroundings
have changed...")
	(DESCFCN SHINING-DOOR-F)
	(SYNONYM SHORE DOOR SAND)
	(FLAGS OLDBIT DOORBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT LOCKEDBIT)
	(ACTION SHINING-DOOR-F)>

;"RMUNGBIT = the door is open"

<ROUTINE SHINING-DOOR-F ("OPT" (OARG <>))
	 <COND (.OARG ;"this rtrues"
		<COND (<FSET? ,SHINING-DOOR ,OLDBIT>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
		       	      <RTRUE>)>
		       ;<COND (<AND <IN? ,HOUSE ,HERE>
				   <FSET? ,HOUSE ,OLDBIT>>
			      <TELL CR 
"The " D ,HOUSE " has but one lone door">)>  
		       <TELL CR
"There is one door here that is not connected to any building and which is ">
		       <COND (<FSET? ,SHINING-DOOR ,RMUNGBIT>
			      <TELL "open">)
			     (T
			      <TELL "closed">)>
		       <TELL ".">
		       <COND (<AND <IN? ,PEARL ,SHINING-DOOR>
				   <FSET? ,PEARL ,OLDBIT>>
			      <TELL 
" Yet there is something radiant imbedded in it: A " D ,PEARL " appears
to shine on the door.">)
			     (<AND <IN? ,PEARL ,SHINING-DOOR>
				   <NOT <FSET? ,PEARL ,OLDBIT>>>
			      <TELL 
" A radiantly " D ,PEARL ", kicking her feet in frustration,
continues to shine on the door.">)>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOUN-USED ,SHINING-DOOR ,W?SHORE>
		<CRLF>
		<COND (<IN? ,PEARL ,SHINING-DOOR>
		       <MOVE ,PEARL ,SHORE>)>
		<COND (<AND <NOT <FSET? ,PAN-OF-KEYS ,RMUNGBIT>>
			    <NOT <FSET? ,PEARL ,OLDBIT>>>
		       <FSET ,PAN-OF-KEYS ,RMUNGBIT>
		       <MOVE ,PAN-OF-KEYS ,PEARL>)>
		<COND (<IN? ,PROTAGONIST ,ICICLE>
		       <PERFORM ,V?WALK-TO ,HAZING>
		       <RTRUE>)>
		<GOTO ,SHORE>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "The door,">
		<COND (<IN? ,PEARL ,SHINING-DOOR>
		       <COND (<FSET? ,PEARL ,OLDBIT>
			      <TELL 
			       " into which a " D ,PEARL " is imbedded">)
			     (T
			      <TELL
" upon which a " D ,PEARL " is suspended and struggling">)>
		       <TELL ", is closed">)
		      (T
		       <COND (<FSET? ,SHINING-DOOR ,RMUNGBIT>
			      <TELL " is open">)
			     (T
			      <TELL " is closed">)>)>
		<TELL ,PERIOD>)
	       (<AND <VERB? PUT>
		     <PRSI? ,SHINING-DOOR>>
		<TELL "It will not attach." CR>)
	       (<AND <VERB? OPEN>
		     <NOT <FSET? ,PRSO ,LOCKEDBIT>>>
		<COND (<NOT <FSET? ,SHINING-DOOR ,RMUNGBIT>>
		       <FSET ,SHINING-DOOR ,RMUNGBIT>
		       <TELL "The " D ,SHINING-DOOR " swings open">)
		      (T
		       <TELL "It's already open">)>
		<TELL ,PERIOD>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,PRSO ,RMUNGBIT>
		       <FCLEAR ,PRSO ,RMUNGBIT>
		       <TELL "Okay," T ,PRSO " is now closed." CR>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (<AND <VERB? UNLOCK>
		     <PRSI? ,PAN-KEY>
		     <FSET? ,SHINING-DOOR ,LOCKEDBIT>>
		;<FCLEAR ,SHINING-DOOR ,LOCKEDBIT>
		<TELL "\"Click.\" As you unlock the door ">
		<COND (<AND <VISIBLE? ,PEARL>
			    <HELD? ,PEARL>>
		       <REMOVE ,PAN-KEY>
		       <TELL "the key is swallowed by the lock">)
		      (T
		       <TELL "it creaks open">)>
		<TELL 
". A tunnel of darkness opens up to you, and you cautiously walk inside. You
almost vanish into the darkness, it is so black.">
		<COND (<AND <VISIBLE? ,PEARL>
			    <HELD? ,PEARL>>
		       <UPDATE-SCORE>
		       <QUEUE I-END-SCENE 1>
		       <TELL CR CR
"But just now you can discern a fuzzy light beginning to shine from the pearl.
It brightens to illuminate your upper body, creating a halo of pure white light
around you. So astounding is the effect of the brightened pearl, that it
spills from">
		       <COND (<NOT <IN? ,PEARL ,PROTAGONIST>>
			      <TELL T <LOC ,PEARL>>)
			     (T
			      <TELL " your hand">)>
		       <REMOVE ,PEARL>
		       <TELL 
" and rolls vanishingly away from you, echoing grittily along the tunnel">)
		      (T
		       <TELL CR CR
"So bone-chillingly penetrating is the vacancy of the tunnel, that you retreat
out through the door, and lock it behind you">)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? UNLOCK>
		     <PRSI? ,PAN-KEY>>
		<SETG PRSI <>>
		<V-UNLOCK>)
	       (<VERB? LOCK>
		<COND (<FSET? ,SHINING-DOOR ,LOCKEDBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <FSET ,SHINING-DOOR ,LOCKEDBIT>
		       <TELL "The door is now locked." CR>)>)>>		

<OBJECT HOUSE
	(LOC CLEARING)
	(OLDDESC "lead house")
	(NEWDESC "head louse")
	(OLD-TO-NEW 
"The house disappears before your very eyes, a situation that leaves you
scratching your head in perplexity.")
	(DESCFCN HOUSE-F)
	(SYNONYM HOUSE LOUSE)
	(ADJECTIVE HEAD LEAD)
	(FLAGS OLDBIT TRYTAKEBIT)
	(ACTION HOUSE-F)>

;"rmungbit = any verb lousy idea told"

<GLOBAL LOUSE-ON-HEAD <>>

<ROUTINE HOUSE-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<AND <FSET? ,HOUSE ,OLDBIT>
			    <EQUAL? ,HERE ,CLEARING>>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
		       	      <RTRUE>)>
		       <TELL CR 
"The odd sight of a lead house stands here under the trees.">)
		      (T
		       <RFALSE>)>
		<RTRUE>)
	       (<NO-SUCH ,HOUSE ,W?HEAD ,W?HOUSE ,W?LEAD ,W?LOUSE>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,HOUSE ,W?HOUSE>
		         <ADJ-USED ,HOUSE ,W?LEAD>>
		     <NOT <FSET? ,HOUSE ,OLDBIT>>>
		<COND (<OR <AND <IN? ,HOUSE ,RAT>
				<FSET? ,RAT ,WORNBIT>>
			   ,LOUSE-ON-HEAD>
		       <TELL 
"You start to feel the worst migraine of your life coming on, which
forces you to think of things other than 20-ton houses, and the headache
fades." CR>
		       <RTRUE>)
		      (<HELD? ,HOUSE ,CLIENT>
		       <TELL "You">
		       <CLIENT-FALL>
		       <RTRUE>)
		      (<AND <VERB? GIVE THROW>
			    <EQUAL? ,HERE ,CLOUD-ROOM>
			    <PRSI? ,CLIENT>>
		       <RFALSE>) ;"v-give"
		      (<EQUAL? ,HERE ,CLOUD-ROOM>
		       <JIGS-UP 
"The lead house sinks through the cloud, with you after it.">)
		      (T
		       <MOVE ,HOUSE ,HERE>
		       <FCLEAR ,HOUSE ,NDESCBIT>
		       <FCLEAR, HOUSE ,TAKEBIT>
		       <FSET ,HOUSE ,OLDBIT>
		       <TELL 
"The louse sprouts wings and flies busily around in circles, spewing an endless
line of molten lead out of its abdomen which builds and builds, finally
cooling into the form of a lead house." CR>
		       <RTRUE>)>)
	       (<AND <NOUN-USED ,HOUSE ,W?LOUSE>
		     <TRANS-PRINT ,HOUSE>>
		<FSET ,HOUSE ,TAKEBIT>
		<COND (<FSET? ,RAT ,WORNBIT>
		       <TO-HAT>)
		      (T
		       <SETG LOUSE-ON-HEAD T>		
		       <MOVE ,HOUSE ,PROTAGONIST>)>)>
	 <COND (<FSET? ,HOUSE ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL 
"It's somewhat small as houses go, but it's one heavy property since it's
made entirely of thick lead, and has neither doors nor windows." CR>)>)
	       (<AND <VERB? TAKE>
		     ,LOUSE-ON-HEAD>
		<TELL 
"You pick around for the " D ,HOUSE " but can't seem to put the pinch
on it." CR>)
	       (<AND <VERB? DROP GIVE THROW PUT PUT-ON>
		     <PRSO? ,HOUSE>
		     ,LOUSE-ON-HEAD>
		<TELL ,YNH TR ,HOUSE>)
	       (<NOT <FSET? ,HOUSE ,RMUNGBIT>>
		<FSET? ,HOUSE ,RMUNGBIT>
		<TELL "That's a lousy idea." CR>)>>

<OBJECT PEARL
	(LOC SHINING-DOOR)
	(OLDDESC "gritty pearl")
	(NEWDESC "pretty girl")
	(DESCFCN PEARL-F)
	(OLD-TO-NEW 
"Tiny grains of sand fall from the pearl as it begins to pulse slowly with
radiant red light, whose brightness soon becomes blinding. When you're finally
able to move your arms away from your face, you can see a beautiful girl
before you.")
	(NEW-TO-OLD
"The girl withers down into a pearl.")
	(SYNONYM PEARL GIRL)
	(ADJECTIVE BEAUTIFUL GRITTY PRETTY)
	(FLAGS OLDBIT TRYTAKEBIT TAKEBIT N0-D-CONT)
	(GENERIC GEN-GIRL)
	(ACTION PEARL-F)>

<GLOBAL PEARL-TO-RIVER <>>

<ROUTINE PEARL-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<NOT <FSET? ,PEARL ,OLDBIT>>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
		              <RTRUE>)>
		       <COND (<AND <EQUAL? ,HERE ,SHORE>
				   <IN? ,PAN-OF-KEYS ,PEARL>>
			      <TELL CR
"A " D ,PEARL " is sitting on the beach, holding what appears to be a "
D ,PAN-OF-KEYS "." CR>)
			     (T
			      <TELL CR 
"A " D ,PEARL " is standing here looking bored." CR>)>)
		      (T
		       <RFALSE>)>)
	       (<NO-SUCH ,PEARL ,W?GRITTY ,W?GIRL ,W?PRETTY ,W?PEARL>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,PEARL ,W?PEARL>
			 <ADJ-USED ,PEARL ,W?GRITTY>>
		     <TRANS-PRINT ,PEARL T>>		    
	        <FCLEAR ,PEARL ,ACTORBIT>
		<FCLEAR ,PEARL ,FEMALEBIT>
		<FCLEAR ,PEARL ,TRYTAKEBIT>
		<FCLEAR ,PEARL ,OPENBIT>
		<FCLEAR ,PEARL ,SEARCHBIT>
		<FCLEAR ,PEARL ,CONTBIT>		
		<COND (<AND <EQUAL? ,HERE ,SHORE>
			    <NOT ,PEARL-TO-RIVER>>
		       <SETG PEARL-TO-RIVER T>
		       <REMOVE ,PEARL>
		       <SETG FOLLOW-FLAG 1>
		       <QUEUE I-FOLLOW 4> 
		       <TELL ;CR  "Upon a stiff off-shore wind, the pearl
is blown into the river. It skips lightly across the Rhine with sparkling
brilliance, and then sinks into the depths." CR>
		       <RTRUE>)>)
	       (<AND <OR <NOUN-USED ,PEARL ,W?GIRL>
			 <ADJ-USED ,PEARL ,W?PRETTY>>
		     <TRANS-PRINT ,PEARL>>
		<FSET ,PEARL ,ACTORBIT>
		<FSET ,PEARL ,FEMALEBIT>
		<FSET ,PEARL ,TRYTAKEBIT>
		<FSET ,PEARL ,CONTBIT>
		<FSET ,PEARL ,OPENBIT>
		<FSET ,PEARL ,SEARCHBIT>
		<COND (<IN? ,PEARL ,SHINING-DOOR>
		       <COND (<VERB? NO-VERB>
			      <CRLF>)>
		       <TELL ;CR 
"The girl is radiantly pretty, but as she continues to \"shine on the door,\"
she kicks her feet angrily in the air." CR>
		       ;<COND (<NOT <VERB? NO-VERB>>
			      <CRLF>)>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,SHORE>
			    <NOT <FSET? ,PAN-OF-KEYS ,RMUNGBIT>>>
		       <MOVE ,PEARL ,HERE>
		       <FSET ,PAN-OF-KEYS ,RMUNGBIT>
		       <MOVE ,PAN-OF-KEYS ,PEARL>
		       <PEARL-F ,M-OBJDESC>)
		      (T
		       <MOVE ,PEARL ,HERE>)>)>
	 <COND (<AND <VERB? FOLLOW>
		     <EQUAL? ,FOLLOW-FLAG 1>
		     <EQUAL? ,HERE ,SHORE>>
		<PERFORM ,V?ENTER ,RHINES>
		<RTRUE>)
	       (<FSET? ,PEARL ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL
"The pearl, though brilliantly white, is also quite gritty." CR>)
		      (<AND <VERB? TAKE>
			    <IN? ,PEARL ,SHINING-DOOR>>
		       <TELL 
"The " D ,PEARL " is embedded in the door." CR>)
		      (<AND <VERB? CLEAN>
			    <FSET? ,PEARL ,TRANSFORMED>>
		       <TELL 
"To remove its grittiness is to remove ">
		       <ITALICIZE "her">
		       <TELL " prettiness." CR>)>)
	       (<VERB? TELL>
		<TELL 
"The pretty girl, who appears too spaced out by the recent major changes in her
life, cannot respond." CR>
		<STOP>)
	       (<AND <VERB? TAKE>
		     <IN? ,PEARL ,SHINING-DOOR>>
		<TELL "She's stuck too firmly to the door." CR>)
	       (<VERB? TAKE>
		<TELL 
"Though the " D ,PEARL " appears thin to the point of being underfed,
carrying her around in her present state would be awkward indeed." CR>) 
	       (<AND <VERB? EXAMINE>
		     <IN? ,PEARL ,SHINING-DOOR>>
		<TELL 
"The " D ,PEARL " is hanging against the door and flailing her legs into
air. The operative words in this absurd predicament seem to be that she
appears to \"shine on the door.\"" CR>)>>

<ROUTINE GEN-GIRL ()
	 <COND (<EQUAL? ,SCENE ,AISLE>
		,BRAT)
	       (<EQUAL? ,SCENE ,COMEDY>
		,WIFE)
	       (<EQUAL? ,SCENE ,RESTAURANT>
		,WAITRESS)
	       (T
		,PEARL)>> 

<OBJECT PAN-OF-KEYS
	;(LOC SHINING-DOOR)
	(OLDDESC "pan of keys")
	(NEWDESC "can of peas")
	(OLD-TO-NEW
"The keys jingle together in the pan, as if simmering, and one key pops out
of the pan onto the ground. Then in a sudden \"poof\" the pan is
transformed into a can.")  
	(SYNONYM CAN PAN KEYS PEAS PEA KEY)
	(FLAGS OLDBIT TAKEBIT)
	(GENERIC GEN-KEY)
	(ACTION PAN-OF-KEYS-F)>

<ROUTINE PAN-OF-KEYS-F ()
	 <COND ;"bug: this wrongly handled 'turn p. of keys into can of peas" 
	      ;(<OR <AND <NOUN-USED ,PAN-OF-KEYS ,W?PAN>
			 <NOUN-USED ,PAN-OF-KEYS ,W?PEAS ,W?PEA>>
		    <AND <NOUN-USED ,PAN-OF-KEYS ,W?CAN>
			 <NOUN-USED ,PAN-OF-KEYS ,W?KEY ,W?KEYS>>>
	       <CANT-SEE ,PAN-OF-KEYS>
	       <RTRUE>)
	       (<AND <FSET? ,PAN-OF-KEYS ,TRANSFORMED>
		     <NOUN-USED ,PAN-OF-KEYS ,W?PAN ,W?KEYS ,W?KEY>>
		<TELL 
"The peas in the can simmer briefly and furiously but nothing else happens."
CR>
		<RTRUE>)
	       ;(<AND <NOUN-USED ,PAN-OF-KEYS ,W?PAN ,W?KEYS ,W?KEY>
		     <TRANS-PRINT ,PAN-OF-KEYS T>>		    
	        <FCLEAR ,PAN-OF-KEYS ,FOODBIT>)
	       (<AND <NOUN-USED ,PAN-OF-KEYS ,W?CAN ,W?PEA ,W?PEAS>
		     <TRANS-PRINT ,PAN-OF-KEYS>>
		<FSET ,PAN-OF-KEYS ,FOODBIT>
		<MOVE ,PAN-KEY ,HERE>
		<GO-GIRL>
		<RTRUE>)>
	 <COND (<AND <VERB? TAKE>
		     <IN? ,PAN-OF-KEYS ,PEARL>
		     <FSET? ,PAN-OF-KEYS ,OLDBIT>
		     ;<EQUAL? <ITAKE> T>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<TELL 
"She gives up" TR ,PAN-OF-KEYS>
		<CRLF>
		<GO-GIRL>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,PAN-OF-KEYS>>
		<TELL 
"An unseen force prevents" T ,PRSO " from going into" TR ,PRSI>)
	       ;"also special cased in main-loop for ALL"
	       (<OR <AND <VERB? TAKE>
			 <PRSO? ,PRSI>>
		    <VERB? EMPTY>>
		<WASTES>)
	       (<FSET? ,PAN-OF-KEYS ,OLDBIT>
		<COND (<VERB? EXAMINE LOOK-INSIDE>
		       <TELL
"This is a frying pan that happens to be devoid of anything edible, but
full of many keys." CR>)>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The lid is off the can, which is full of peas." CR>)
	       (<VERB? EAT>
		<TELL 
"Yech. The peas are small, pale, shriveled and unappetizing." CR>)>>

<OBJECT PAN-KEY
	;(LOC SHINING-DOOR)
	(DESC "shiny key")
	(SYNONYM KEY)
	(ADJECTIVE SHINY)
	(FLAGS TAKEBIT)
	(GENERIC GEN-KEY)
	;(ACTION PAN-KEY-F)>

<ROUTINE GEN-KEY ()
	 ,PAN-KEY>

<ROUTINE GO-GIRL ()
	 <COND (<AND <NOT ,PEARL-TO-RIVER>
		     <VISIBLE? ,PEARL>
		     <NOT <FSET? ,PEARL ,OLDBIT>>>
		<REMOVE ,PEARL>
		<MOVE ,PAN-OF-KEYS ,HERE>
		<SETG PEARL-TO-RIVER T>
		<FCLEAR ,PEARL ,ACTORBIT>
		<FCLEAR ,PEARL ,TRYTAKEBIT>
		<FSET ,PEARL ,TRANSFORMED>
		<FSET ,PEARL ,OLDBIT>
		<SETG FOLLOW-FLAG 1>
		<QUEUE I-FOLLOW 4>
		<TELL "The girl takes a">
		<COND (<FSET? ,PAN-OF-KEYS ,OLDBIT>
		       <TELL " side-glance at">)
		      (T
		       <TELL " whiff of">)>
		<TELL 
" the " D ,PAN-OF-KEYS " and scowls at it. \"Yukko.
Gag me with a spoonerism.\"|
|
From the looks of her very trim figure, the pretty girl is certainly in need of
a square meal. But, being deprived of any kind of dining experience on the shore, she
instead, by leaps and bounds, sprints toward the Rhine and dives headlong
into the river." CR>)>>

<ROOM SHORE
      (LOC ROOMS)
      (DESC "On the Shore")
      ;(FLAGS INDOORSBIT)
      (GLOBAL HAZING WATER)
      (ACTION SHORE-F)>

<ROUTINE SHORE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"This is the shore of a river, between two tributaries of the Rhine.">
		<COND (<FSET? ,ROCKS ,OLDBIT>
		       <TELL 
" A pile of " D ,ROCKS " jutting from the beach into the river blocks
your path along the shore.">)>
		<RTRUE>)>>

<OBJECT ROCKS
	(LOC SHORE)
	(OLDDESC "rocks")	
	(NEWDESC "red fox")
	(OLD-TO-NEW 
"With frightful expressions on the faces of the rocks, a loud rumbling
avalanche sends them tumbling and splashing into the Rhine. Through the thick
rock dust, you can make out a red fox trotting out of sight.")
	(SYNONYM ROCKS ROCK FOX PILE)
	(ADJECTIVE FED RED)
	(FLAGS NDESCBIT OLDBIT ACTORBIT PLURALBIT)
	(ACTION ROCKS-F)>

;"seen bit = rocks seen as faces"
;"rmungbit = now FED ROCKS"

<ROUTINE ROCKS-F () 
	 <COND (<NO-SUCH ,ROCKS ,W?RED ,W?ROCKS ,W?FED ,W?FOX>
		<RTRUE>)
	       (<AND <NOT <FSET? ,ROCKS ,RMUNGBIT>>
		     <ADJ-USED ,ROCKS ,W?FED>>
		<TELL "They haven't been fed." CR>
		<RTRUE>)
	       (<AND <OR <NOT <FSET? ,ROCKS ,SEENBIT>>
			 <NOT <FSET? ,ROCKS ,RMUNGBIT>>>
		     <OR <NOUN-USED ,ROCKS ,W?FOX>
			 <ADJ-USED ,ROCKS ,W?RED>>>
		<CANT-SEE <> "fox">
		<RTRUE>)
	       ;(<AND <OR <NOUN-USED ,ROCKS ,W?ROCKS>
			 <ADJ-USED ,ROCKS ,W?FED>>
		     <TRANS-PRINT ,ROCKS T>>
		T)
	       (<AND <OR <NOUN-USED ,ROCKS ,W?FOX>
			 <ADJ-USED ,ROCKS ,W?RED>>
		     <FSET? ,ROCKS ,OLDBIT>
		     <TRANS-PRINT ,ROCKS>>
		<REMOVE ,ROCKS>
		<FCLEAR ,ROCKS ,PLURALBIT>
		<MOVE ,LEOPARD ,HERE>
		<MOVE ,DEAN ,HERE>
		<MOVE ,EXPERIENCE ,HERE>
		<TELL CR
"With a new section of the shore open to view, you now observe the following
sight:" CR>
		<DEAN-F ,M-OBJDESC>
		<CRLF> ;"was semied"
		<RTRUE>)>
	 ;"assumed verbs for fed rocks"
	 <COND (<AND <TOUCHING? ,ROCKS>
		     <NOT <VERB? FEED GIVE>>
		     <NOT <FSET? ,ROCKS ,SEENBIT>>>
		<FSET ,ROCKS ,SEENBIT>
		<TELL 
"As you make contact with the faces of the rocks, each becomes animated
and exhibits a mean nasty expression: A look that says \"Feed me!\"
Needless to say, you jump back." CR>)
	       (<AND <FSET? ,ROCKS ,SEENBIT>
		     <VERB? CLIMB-OVER CLIMB-UP CLIMB CLIMB-ON BOARD ENTER
			    STAND-ON LEAP>>
		<TELL
"Knocking their heads together and snapping their granite jaws at your limbs,
the rocks faces make you back away." CR>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,ROCKS ,RMUNGBIT>
		       <TELL
"You can see from the jowly, satiated faces of the fed rocks that they
have eaten recently." CR>)
		      (T
		       <TELL
"Each face of the rocks has the same hungry, crazed expression that says
\"Feed me!\"" CR>)>)
	       (<VERB? TELL>
		<TELL
"The crude speech of the rocks is deep, clanking and guttural. It sounds
as if they have practiced their diction with humans in their mouths." CR>
		<STOP>)>>
		      
<GLOBAL SWUM-IN-RHINES <>>

<OBJECT RHINES
	(LOC SHORE)
	(DESC "Rhines")	
	(SYNONYM RIVER RHINE TRIBUTARY TRIBUTARIES DOOR SHORE)
	(ADJECTIVE RHINES RHINE)
	(FLAGS NDESCBIT PLURALBIT)
	(GENERIC GEN-SHORE)
	(ACTION RHINES-F)>

<ROUTINE RHINES-F ()
	 <COND (<AND <NOUN-USED ,RHINES ,W?DOOR>
		     <NOT <DONT-HANDLE ,RHINES>>>
		<TELL 
"Driven by a foul east wind, shifting sands blow this way and that, but
the shore cannot gather itself further. " CR>
		<RTRUE>)
	       (<VERB? EXAMINE>
	        <PERFORM ,V?LOOK>
		<RTRUE>)
	       (<VERB? BOARD SWIM ENTER>
		<COND (<NOT ,PEARL-TO-RIVER>
		       <TELL "You're really not up for a swim." CR>)
		      (<NOT ,SWUM-IN-RHINES>
		       <DO-FIRST "shake off your toes">)
		      (T
		       <TELL "You're waterlogged enough." CR>)>)>>

<ROUTINE GEN-SHORE ()
	 ,RHINES>
		      	       
<OBJECT LINES
	;(LOC SHORE)
	(DESC "lines of sand-script")	
	(LDESC "Lines of sand-script are scrawled on the shore.")
	(SYNONYM LINES LINE SAND-SCRIPT SCRIPT SANSKRIT MESSAGE)
	(FLAGS PLURALBIT)
	(ACTION LINES-F)>

<ROUTINE LINES-F ()
	 <COND (<VERB? READ-BETWEEN>
		<COND (<NOT <FSET? ,LINES ,PHRASEBIT>>
		       <FSET ,LINES ,PHRASEBIT>
		       <UPDATE-SCORE>)>
		<TELL 
"You gather the gist of the sand-script message to be: Follow your Shepherd."
CR>)
	       (<VERB? READ EXAMINE>
		<TELL 
"Since the two lines scrawled on the shore are written in the obscure
language of sand-script, you're not able to comprehend their meaning." CR>)>>

<OBJECT SAND
	(LOC SHORE)
	(DESC "sand")	
	(SYNONYM SAND BEACH SHORE)
	(FLAGS NOALL NDESCBIT TRYTAKEBIT NOA)
	(GENERIC GEN-SHORE)
	(ACTION SAND-F)>

<ROUTINE SAND-F ()
	 <COND (<AND <VERB? LOOK-INSIDE READ>
		     <IN? ,LINES ,HERE>>
		<PERFORM ,V?READ ,LINES>
		<RTRUE>)
	       (<VERB? TAKE LOOK-INSIDE SEARCH DIG LOOK-UNDER>
		<TELL 
"The sand spills between your fingers, but you uncover nothing." CR>)>>

<OBJECT RIDDLE-BOOK
	;(LOC FACTORY)
	(DESC "book of riddles")
	(FDESC 
"The shepherd has placed his black book on the floor of the factory.")
	(SYNONYM BOOK RIDDLE RIDDLES)
	(ADJECTIVE BLACK)
	(FLAGS TAKEBIT)
	(ACTION RIDDLE-BOOK-F)>

<ROUTINE RIDDLE-BOOK-F ()
	 <COND (<VERB? READ>
		<TELL 
"You riddle for a while and eventually grow tired of it." CR>)>> 

<OBJECT DEAN
	;(LOC SHORE)
	(OLDDESC "queer old dean")
	(NEWDESC "dear old queen")
	(OLD-TO-NEW 
"In the distance you hear the first few bars of the British National
Anthem as, before your very eyes, the dean is transformed into a reigning
monarch in full regalia.")
	(NEW-TO-OLD "Queen turns into dean.")  
	(DESCFCN DEAN-F)
	(SYNONYM DEAN QUEEN)
	(ADJECTIVE OLD QUEER DEAR)
	(FLAGS OLDBIT ACTORBIT)
	(ACTION DEAN-F)>

<ROUTINE DEAN-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<COND (<FSET? ,LEOPARD ,OLDBIT>
		       <TELL CR
"A " D ,DEAN " here seems to be the subject of a " D ,EXPERIENCE ". A
tall leopard, standing up on its hind legs, is shoving ">
		       <COND (<FSET? ,DEAN ,OLDBIT>
			      <TELL "him">)
			     (T
			      <TELL "her">)>
		       <TELL 
" up and down the shoreline, creating quite a scene and kicking up
sand all along the way. ">
		       <COND (<FSET? ,DEAN ,OLDBIT>
			      <TELL
"The dean, with his long grey locks flaming out like Einstein's,
is hopelessly mismatched by the leopard and ">)
			     (T
			      <TELL "The proud queen ">)>
		       <TELL 
"continuously gives up sandy ground to him.">)
		      (T
		       <TELL CR "A " D ,DEAN " stands on the shore.">)>
		;"it needs cr's at end of descfcn now with the rtrue here"
		<RTRUE>)
	       (<NO-SUCH ,DEAN ,W?QUEER ,W?QUEEN ,W?DEAR ,W?DEAN>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,DEAN ,W?DEAN>
			 <ADJ-USED ,DEAN ,W?QUEER>>
		     <TRANS-PRINT ,DEAN T>>		    
	        <FSET ,DEAN ,ACTORBIT>)
	       (<AND <OR <NOUN-USED ,DEAN ,W?QUEEN>
			 <ADJ-USED ,DEAN ,W?DEAR>>
		     <TRANS-PRINT ,DEAN>>
		<FSET ,DEAN ,ACTORBIT>
		<COND (<FSET? ,LEOPARD ,OLDBIT>
		       <TELL ;CR 
"Our shoving leopard stops to make a brief curtsy before the queen,
then continues pushing her up and down the shoreline." CR>)>)>
	 <COND (<FSET? ,DEAN ,OLDBIT>
		<COND (<VERB? TELL>
		       <TELL "He says nothing." CR>
		       <STOP>)>)
	       (<VERB? TELL>
		<TELL "The queen is mum." CR>
		<STOP>)>>

<GLOBAL RESUME-DEAN <>>

<ROUTINE I-DEAN ()
	 <QUEUE I-DEAN -1>
	 <COND (<NOT <FSET? ,DEAN ,OLDBIT>>
		<DEQUEUE I-DEAN>
		<COND (<VISIBLE? ,DEAN>
		       <TELL CR "The queen marches away down the beach." CR>)>
		<REMOVE ,DEAN>)
	       (T
		<RFALSE>)>>
	       		
<OBJECT EXPERIENCE
	;(LOC SHORE)
	(OLDDESC "rare hazing experience")
	(NEWDESC "hair raising experience")
	(OLD-TO-NEW
"Hair raising indeed. It really gives the follicles a workout to witness such
a sight.")
	(NEW-TO-OLD
"It's a rare hazing experience all right.")	     
	(SYNONYM EXPERIENCE RAISING HAIR) ;"syn hair added"
	(ADJECTIVE HAIR RAISING HAZING HAIR-RAISING RARE)
	(FLAGS OLDBIT NDESCBIT)
	(ACTION EXPERIENCE-F)>

<ROUTINE EXPERIENCE-F ()
	 <COND (<AND <ADJ-USED ,EXPERIENCE ,W?HAZING ,W?RARE>
		     <TRANS-PRINT ,EXPERIENCE T>>		    
	        <FSET ,EXPERIENCE ,OLDBIT>)
	       (<AND <OR <NOUN-USED ,EXPERIENCE ,W?RAISING>
			 <ADJ-USED ,EXPERIENCE ,W?HAIR ,W?HAZING>
			 <ADJ-USED ,EXPERIENCE ,W?HAIR-RAISING ,W?RAISING>>
		     <TRANS-PRINT ,EXPERIENCE>>
		<FCLEAR ,EXPERIENCE ,OLDBIT>)>
	 <RFALSE>>

<OBJECT LEOPARD
	;(LOC SHORE)
	(OLDDESC "our shoving leopard")
	(NEWDESC "our loving shepherd")
	(DESCFCN LEOPARD-F)
	(OLD-TO-NEW
"The leopard changes its appearance from beast into man and changes its
spots into a black suit with a white, wraparound collar. He takes out
a black book and intones solemnly in a guttural Germanic language for
a few moments.")  
	(SYNONYM LEOPARD SHEPHERD)
	(ADJECTIVE YOUR OUR SHOVING LOVING TALL)
	(FLAGS OLDBIT ACTORBIT NDESCBIT NARTICLEBIT)
	(ACTION LEOPARD-F)>

<ROUTINE LEOPARD-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR
"In a seedy corner of the factory, you can observe a scuffle going
on. As far as you can see, " D ,LEOPARD " is engaged in a tug-of-war with
a large, man-sized rodent which appears to be a rat. The shepherd is
struggling, with religious zeal, to pull ">
		<COND (<FSET? ,HABIT ,OLDBIT>
		       <TELL "some black-and-white cloth">)
		      (T
		       <TELL "a rabbit">)>
		<TELL " from the huge over-grown rat.">
		;<CRLF>
		<RTRUE>)
	       (<NO-SUCH ,LEOPARD ,W?SHOVING ,W?SHEPHERD ,W?LOVING ,W?LEOPARD>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,FACTORY>
		     <IN? ,LEOPARD ,HERE>
		     <OR <NOUN-USED ,LEOPARD ,W?LEOPARD>
			 <ADJ-USED ,LEOPARD ,W?SHOVING>>>		    
	        <TELL
"The man of cloth turns to you frantically, \"Loving leopard, shoving
shepherd, never mind me! Just try and pull this " D ,HABIT " out
of the rat.\"" CR>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,LEOPARD ,W?SHEPHERD>
			 <ADJ-USED ,LEOPARD ,W?LOVING>>
		     <TRANS-PRINT ,LEOPARD>>
		<FCLEAR ,LEOPARD ,NDESCBIT>
		<MOVE ,LINES ,HERE>
		<MOVE ,RAT ,FACTORY>
		<MOVE ,RIDDLE-BOOK ,FACTORY>
		<MOVE ,LEOPARD ,FACTORY>
		<QUEUE I-DEAN 2>
		<REMOVE ,EXPERIENCE>
		<TELL
"Closing his book with a hollow thud, the shepherd uses a stick
to scrawl a two-line message on the shore. And then, looking with grand vision
toward the tributaries of the Rhine River,
our loving shepherd turns tail, walks away from the shore,
and disappears in the distance as he leads between the Rhines." CR>)>
	 <COND (<AND <VERB? FOLLOW>
		     <IN? ,LEOPARD ,FACTORY>
		     <NOT <FSET? ,FACTORY ,TOUCHBIT>>>
		<PUT ,P-NAMW 0 ,W?FACTORY>
		<PERFORM ,V?WALK-TO ,HAZING>)>>

<OBJECT HABIT
	(LOC RAT)
	(OLDDESC "habit")
	(NEWDESC "rabbit")
	(OLD-TO-NEW 
"You can see the black-and-white cloth folding in upon itself and twisting
and wringing itself in a laundry-like fashion. With a final turning inside-out
and the emergence of floppy ears from the cloth, it blooms gradually
into the fluffy body of a rabbit.")
	(SYNONYM HABIT RABBIT CLOTH)
	(ADJECTIVE BLACK-AND-WHITE WHITE BLACK)
	(FLAGS OLDBIT TRYTAKEBIT)
	(ACTION HABIT-F)>

<ROUTINE HABIT-F ()
        <COND (<AND <NOUN-USED ,HABIT ,W?HABIT ,W?CLOTH>
		    <TRANS-PRINT ,HABIT T>>
	       T)
	      (<AND <NOUN-USED ,HABIT ,W?RABBIT>
		    <TRANS-PRINT ,HABIT>>
	       T)>
	<COND (<AND <VERB? TAKE>
		    <PRSO? ,HABIT>
		    <PRSI? ,RAT>
		    <IN? ,HABIT ,RAT>
		    <NOUN-USED ,HABIT ,W?RABBIT ,W?HABIT>
		    ;<NOUN-USED ,RAT ,W?HAT>
		    <OR <EQUAL? <GET ,P-NAMW 1> ,W?HAT>
			<EQUAL? <GET ,P-ADJW 1> ,W?MOHAIR>>>
	       <MOVE ,HABIT ,PROTAGONIST>
	       <TELL 
"Abracadabra, Alacazam! With nothing up your sleeve (with the exception
of your knobby elbow) you yank the ">
	       <COND (<FSET? ,HABIT ,OLDBIT>
		      <TELL D ,HABIT>)
		     (T
		      <TELL
"scruffy rabbit, which is pedaling its lucky feet in the air,">)>
	       <TELL " out of the hat." CR>)
	      (<VERB? TAKE>
	       <TELL "The rat yanks it back." CR>)
	      (<FSET? ,HABIT ,OLDBIT>
	       <COND (<VERB? EXAMINE>
		      <TELL 
"This habit is, unfortunately, the black and white cloth worn by members of
a religious order. It's being clenched tightly in the huge rat's teeth." CR>)>)
	      (<VERB? EXAMINE>
	       <TELL "The little flop-eared rabbit looks frightened." CR>)>>

<OBJECT RAT
	;(LOC FACTORY)
	(OLDDESC "rat")
	(NEWDESC "hat")
	(OLD-TO-NEW 
"The big rat twitches its bewhiskered snout, and yawns a gap-toothed
yawn, then incredibly shrinks down to the size, and now the shape, of a hat.")	
	(SYNONYM RAT HAT)
	(ADJECTIVE MOHAIR)
	(FLAGS OLDBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT NDESCBIT WEARBIT)
	(CAPACITY 13)
	(ACTION RAT-F)>

<ROUTINE RAT-F ()
	 <COND (<AND <NOUN-USED ,RAT ,W?RAT>
		     <NOT <FSET? ,RAT ,OLDBIT>>
		     <NOT <DONT-HANDLE ,RAT>>> 
		<TELL 
"The mohair of the hat ruffles a couple of times, but that's it." CR>
		<RTRUE>)
	       (<AND <NOUN-USED ,RAT ,W?HAT>
		     <TRANS-PRINT ,RAT>>
		<FSET ,RAT ,TAKEBIT>
		<FSET ,RAT ,WEARBIT>
		<FCLEAR ,RAT ,NO-D-CONT>
		<FCLEAR ,RAT ,NDESCBIT>)>
	 <COND (<FSET? ,RAT ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL 
"At the thick-haired shoulder, the rat stands tall as you">
		       <COND (<IN? ,HABIT ,RAT>
			      <TELL
". In it's buck teeth, which are the size of cheese wedges, hangs
a " D ,HABIT>)>
		       <TELL ,PERIOD>)
		      (<VERB? KILL>
		       <TELL
"The rat is so gross, thick-haired and menacing that ">
		       <COND (<AND ,PRSI
				  <PRSI? ,BLUSHING-CROW>>
			      <MOVE ,BLUSHING-CROW ,HERE>
			      <TELL 
"the " D ,BLUSHING-CROW " performs instead like a glancing blow." CR>)
			     (T
			      <TELL "violence is useless." CR>)>)>)
	       ;"hat"
	       (<VERB? EXAMINE>
		<TELL "The hat seems to be crafted out of fine mohair." CR>)
	       (<AND <VERB? WEAR>
		     <NOT <FSET? ,RAT ,WORNBIT>> ;"if any other than louse"
		     <OR <AND <FIRST? ,RAT>
			      <NOT <EQUAL? <FIRST? ,RAT> ,HOUSE>>>
			 <AND <FIRST? ,RAT>
			      <EQUAL? <FIRST? ,RAT> ,HOUSE>
			      <NEXT? ,HOUSE>>>>
		<DO-FIRST "empty" ,RAT>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,HEAD>>
		<PERFORM ,V?WEAR ,RAT>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,RAT>
		     <FSET? ,RAT ,WORNBIT>>
		<TELL ,WEARING-IT>)
	       (<AND <VERB? WEAR>
		     <NOT <FSET? ,RAT ,WORNBIT>>
		     ,LOUSE-ON-HEAD>
		<FSET ,RAT ,WORNBIT>
		<TELL
"You lower the hat over your head. ">
		<TO-HAT>
		<RTRUE>)>>

<ROUTINE TO-HAT ()
	 <SETG LOUSE-ON-HEAD <>>	 
	 <MOVE ,HOUSE ,RAT>
	 <TELL "Moments later, you feel the curious
little head louse migrate from your skull into the mohair fabric of the
hat." CR>>

<ROOM FACTORY
      (LOC ROOMS)
      (DESC "Old Factory")      
      (FLAGS INDOORSBIT)
      (GLOBAL HAZING)
      (ACTION FACTORY-F)>

<ROUTINE FACTORY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		;"Shut down no doubt for polluting violations.
Choice spot for a polluting factory in a out of the way inlet of the Rhine.
It's frigid and icy inside. Charred and smeared with charcol walls.
It's a dim and nasty-looking place, clothing factory and who knows what
else. A grimy, narrow passage leads back into a stock room."
		<TELL
"This is an old factory.
A passage leads into a back room.">)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND <NOT <FSET? ,RAT ,OLDBIT>>
			    <IN? ,LEOPARD ,HERE>>
		       <REMOVE ,LEOPARD>
		       <REMOVE ,HABIT>
		       <CRLF>
		       <COND (<FSET? ,HABIT ,OLDBIT>
			      <TELL
"The man of the cloth solemnly gathers the habit and leaves the factory">)
			     (T
			      <TELL 
"The shepherd turns into a leopard and, licking his chops, scampers
away with the rabbit tucked under one claw">)>
		       <TELL ,PERIOD>)
		      (<AND <IN? ,LEOPARD ,HERE>
			    <NOT <VERB? WALK-TO>>>
		       <TELL CR 
"The shepherd keeps struggling against all odds, with religious zeal,
attempting to extract the " D ,HABIT " from the large rat, which is fiercely
clenching it in his snout." CR>)>)>>

<OBJECT FOAM
	(LOC FACTORY)
	(DESC "foam burning")	
	(DESCFCN FOAM-F)
	(SYNONYM FOAM BURNS BURNING ROME FIRE BONFIRE)
	(ADJECTIVE FOAM BON)
	(FLAGS NARTICLEBIT)
	(ACTION FOAM-F)>

;"SEENBIT = told Rome quote"

<ROUTINE FOAM-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR 
"Someone has left a bonfire going, as a large pile of foam is burning in
the middle of the factory floor">
		<COND (<FSET? ,ICICLE ,TRYTAKEBIT>
		       <TELL 
". Above the foam burning, an icicle is hanging down from the ceiling">)>
		<TELL ,PERIOD>)
	       (<NOUN-USED ,FOAM ,W?ROME>
		;<NOT <FSET? ,FOAM ,SEENBIT>>
		;<FSET ,FOAM ,SEENBIT>
		<TELL 
"(Of course, neither Rome nor foam was built in a day.)" CR CR>
		<RFALSE>)>
	 <COND (<AND <VERB? RIDDLE>
		     <FSET? ,ICICLE ,TRYTAKEBIT>
		     <OR <NOT ,PRSI>
			 <PRSI? ,FOAM>>>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?FIDDLE>
		       <TELL 
"Fiddling just doesn't do the trick." CR>
		       <RTRUE>)>
		<UPDATE-SCORE>
		<FCLEAR ,ICICLE ,TRYTAKEBIT>
		<FCLEAR ,ICICLE ,NDESCBIT>
		<PUTP ,ICICLE ,P?OLDDESC "well-boiled icicle">
		<TELL
"As you while away the time in the grand manner of great decadent epochs
of the historical past, the icicle overhead suddenly takes as much heat as it
can stand, letting loose from the ceiling and dropping to the factory
floor with a surprising \"Thud.\"" CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,FOAM>>
		<PERFORM ,V?BURN ,PRSO>
		<RTRUE>)
	       (<VERB? ENTER BOARD STAND-ON CLIMB-ON>
		<TELL 
"That's the painful way to get a pair of hot pants." CR>) 
	       (<VERB? OFF>
		<TELL
"Your feeble attempts have the negligible effect of spitting on the
fire." CR>)>>

<OBJECT ICICLE
	(LOC FACTORY)
	(OLDDESC "icicle")	
	(NEWDESC "well-oiled bicycle")
	;(FDESC 
"Lying next to the fire is a well-boiled icicle, evidently having been
melted off the ceiling.")
	(OLD-TO-NEW 
"The icicle, though thoroughly boiled already, lets off a searing vertical
wall of steam. As the white vapor clears, a shiny, brand new bicycle is
revealed.")
	(DESCFCN ICICLE-F)
	(SYNONYM ICICLE BICYCLE BIKE ICE)
	(ADJECTIVE WELL BOILED OILED WELL-BOILED WELL-OILED)
	(FLAGS TRYTAKEBIT TAKEBIT NDESCBIT OLDBIT)
	(SIZE 7)
	(ACTION ICICLE-F)>

<ROUTINE ICICLE-F ("OPT" (OARG <>)) 
	 <COND (.OARG
		<RFALSE>)
	       ;(<EQUAL? .OARG ,M-OBJDESC ,M-OBJDESC?>
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR "A wooden cart">
		<COND (,HORSE-TO-CART
		       <TELL " with a horse hooked up to it">)>
		<TELL " sits in the dusty road here.">)
	       ;(<EQUAL? .OARG ,M-BEG>
		<COND (<OR <AND ,PRSO
				<IN? ,PRSO ,HERE>
				<NOT <EQUAL? ,PRSO ,ICICLE>>>
			   <AND ,PRSI
				<IN? ,PRSI ,HERE>
				<NOT <EQUAL? ,PRSI ,ICICLE>>>>
		       <MOVE ,PROTAGONIST ,HERE>
		       <SETG OLD-HERE <>>
		       <TELL "[getting off the bicycle first]" CR>)>
		<RFALSE>)
	       (<NO-SUCH ,ICICLE ,W?WELL-OILED ,W?ICICLE ,W?WELL-BOILED 
			 ,W?BICYCLE>
		<RTRUE>)
	       (<AND <FSET? ,ICICLE ,TRYTAKEBIT>
		     <OR <NOUN-USED ,ICICLE ,W?BICYCLE ,W?BIKE>
		         <ADJ-USED ,ICICLE ,W?WELL-OILED ,W?OILED>>>
		<CANT-SEE <> "bicycle">
		<RTRUE>)
	       (<AND <FSET? ,ICICLE ,TRYTAKEBIT>
		     <ADJ-USED ,ICICLE ,W?BOILED ,W?WELL-BOILED>>
		<TELL "It's not that hot." CR>
		<RTRUE>)
	       (<AND <NOT <FSET? ,ICICLE ,OLDBIT>>
		     <OR <NOUN-USED ,ICICLE ,W?ICICLE ,W?ICE>
			 <ADJ-USED ,ICICLE ,W?WELL-BOILED>>>
		<TELL 
"The bicycle lets off a little steam like a backfiring motorbike, but
doesn't change shape." CR>
		<RTRUE>
		;<TRANS-PRINT ,ICICLE T>
		T)
	       (<AND <OR <NOUN-USED ,ICICLE ,W?BICYCLE ,W?BIKE>
			 <ADJ-USED ,ICICLE ,W?WELL-OILED>>
		     <TRANS-PRINT ,ICICLE>>
		;<FSET ,ICICLE ,CONTBIT>
		;<FSET ,ICICLE ,OPENBIT>
		;<FSET ,ICICLE ,SEARCHBIT>
		<PUTP ,ICICLE ,P?SIZE 45>
		<FSET ,ICICLE ,VEHBIT>)>
	 <COND (<FSET? ,ICICLE ,OLDBIT>
		<COND (<AND <VERB? EXAMINE>
			    <FSET? ,ICICLE ,TRYTAKEBIT>>
		       <TELL 
"Suspended from the ceiling, the icicle makes a steady drip-dripping
onto the fire. But, strangely, it seems not to be shrinking." CR>)
		      (<AND <TOUCHING? ,ICICLE>
			    <FSET? ,ICICLE ,TRYTAKEBIT>>
		       <CANT-REACH ,ICICLE>)>)
	       (<VERB? BOARD>
		<SETG OLD-HERE <>>
		<MOVE ,PROTAGONIST ,ICICLE>
		<TELL 
"Decisively, you take the bike by the handlebars and swing the seat under
you." CR>)>>

<ROOM STOCK-ROOM
      (LOC ROOMS)
      (DESC "Jean Stock")      
      (FLAGS INDOORSBIT)
      (GLOBAL HAZING)
      (ACTION STOCK-ROOM-F)>

<ROUTINE STOCK-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You're">
		<COND (<IN? ,PROTAGONIST ,HERE>
		       <TELL " standing">)>
		<TELL " toward the rear of the factory, back in the jean stock.
Jeans of every conceivable size, color, shape, and texture are stacked up along
the walls, arranged into dozens of rows, piled high onto heaps. There is
a dizzying effect, as if your point of view were from inside a large-capacity
clothes dryer.">)>>

<OBJECT ELF
	(LOC STOCK-ROOM)
	(OLDDESC "sold elf")
	(NEWDESC "your old self")
	(OLD-TO-NEW 
"The elf sprouts up and goes through the whole Dorian Grey thing, looking
gradually more and more like you but a lot grayer.")
	(NEW-TO-OLD "Self to elf.")
	(DESCFCN ELF-F)
	(SYNONYM ELF SELF)
	(ADJECTIVE OLD SOLD YOUR MY)
	(FLAGS OLDBIT TRYTAKEBIT ACTORBIT)
	(ACTION ELF-F)>

;"rmungbit = entered first time to back room"

<GLOBAL ELF-TOLD <>> ;"about getting back to clearing"

<GLOBAL SELF-JOKE <>>

<ROUTINE ELF-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<COND (<AND <FSET? ,ELF ,OLDBIT>
			    <EQUAL? ,HERE ,STOCK-ROOM>
			    <NOT <FSET? ,ELF ,RMUNGBIT>>>
		       <FSET ,ELF ,RMUNGBIT>
		       <TELL CR
"You can see, looming in the distance, the dwarfish figure of a man who
appears to have been sold into slavery to weave fabric at this factory, even
in its dilapidated condition.|
|
As you approach, the " D ,ELF " awkwardly attempts to make a tall smock">)
		      (<FSET? ,ELF ,OLDBIT>
		       <TELL CR "A " D ,ELF " stands here">)
		      (T
		       <TELL CR "Your old self stands here">)>
		<TELL ,PERIOD>)
	       (<NO-SUCH ,ELF ,W?OLD ,W?ELF ,W?SOLD ,W?SELF>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,ELF ,W?ELF>
		         <ADJ-USED ,ELF ,W?SOLD>>
		     <TRANS-PRINT ,ELF T>>
		<FCLEAR ,ELF ,NARTICLEBIT>)
	       (<AND <OR <NOUN-USED ,ELF ,W?SELF>
			 <ADJ-USED ,ELF ,W?OLD>> 
		     <TRANS-PRINT ,ELF>>
		<FSET ,ELF ,NARTICLEBIT>)>
	 <COND (<AND <VERB? MAKE-WITH>
		     <PRSO? ,SMOCK>
		     <OR <EQUAL? <GET ,P-NAMW 0> ,W?TALK>
			 <EQUAL? <GET ,P-ADJW 0> ,W?SMALL>>>
		<COND (<NOT <FSET? ,SMOCK ,PHRASEBIT>>
		       <FSET ,SMOCK ,PHRASEBIT>
		       <UPDATE-SCORE>
		       <SETG OLD-HERE ,STARTING-ROOM>
		       ;"to update rooms on stat line"
		       <SETG ELF-TOLD T>
		       <COND (<FSET? ,ELF ,OLDBIT>
			      <TELL "You lean over and">)
			     (T
			      <TELL
"Your old self looks self-pityingly upon you and">)>
		       <TELL 
" onto whole cloth he stitches out precise directions for getting back to
the clearing, which you commit to memory." CR CR>
		       <TELL
"\"But you'll never make it on foot. You need some transportation.\"" CR>)
		      (T
		       <PERFORM ,V?TELL ,PRSI>
		       <RTRUE>)>)
	       (<FSET? ,ELF ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL "He's small." CR>)
		      (<VERB? TELL>
		       <TELL 
"The elf doesn't appear interested in the manner of your big talk. He
seems wary of unseen higher-ups, and quietly continues working." CR>
		       <STOP>)>)
	       (<VERB? EXAMINE>
		<TELL "It's you." CR>)
	       (<VERB? TELL>
		<COND (<NOT ,SELF-JOKE>
		       <SETG SELF-JOKE T>
		       <TELL
"He speaks slowly and deliberately, \"All I have to say: Don't end up
like this. You still have time to avoid such a fate. Listen: mutual
funds and long-term bonds.\"" CR>		       
		       <STOP>)
		      (T
		       <TELL "\"I have nothing to say.\"" CR>
		       <STOP>)>)>>

<OBJECT SMOCK
	(LOC GLOBAL-OBJECTS)
	(OLDDESC "tall smock")
	(NEWDESC "small talk")
	(OLD-TO-NEW "Bug.")
	(SYNONYM SMOCK TALK)
	(ADJECTIVE TALL SMALL)
	(FLAGS OLDBIT TRYTAKEBIT NDESCBIT)
	(ACTION SMOCK-F)>

;"PHRASEBIT = made small talk with elf"

<ROUTINE SMOCK-F ("AUX" ACTOR)
	 <COND (<NO-SUCH ,SMOCK ,W?TALL ,W?TALK ,W?SMALL ,W?SMOCK>
		<RTRUE>)
	       (<AND <NOUN-USED ,SMOCK ,W?SMOCK>
		     <NOT <DONT-HANDLE ,SMOCK>>
		     <NOT <EQUAL? ,HERE ,STOCK-ROOM>>>
		<CANT-SEE <> "smock">)
	       (<AND <OR <NOUN-USED ,SMOCK ,W?TALK>
			 <ADJ-USED ,SMOCK ,W?SMALL>>
		     <VERB? NO-VERB>>
		<SETG ORPHAN-FLAG ,SMOCK>
		<QUEUE I-ORPHAN 2>
		<TELL
"Whom do you want to make small talk with?" CR>)
	       (<VERB? MAKE>
		<COND (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT "with">>
		       <PERFORM ,V?MAKE-WITH ,SMOCK .ACTOR>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?TELL ,ME>
		       <RTRUE>)>)>>

<OBJECT CLIENT
	(LOC STOCK-ROOM)
	(OLDDESC "jean client")
	(NEWDESC "clean giant")
	(OLD-TO-NEW
"Much to his horror, the jean client begins to undergo a Hulkian
transformation -- with popping buttons, ripping seams, and bug-eyed
self-examination.|
|
Seemingly shamed by the revealing ordeal, the client, while he's still of a
human size,
demonstrates his dexterity and strength by clambering up the towering pile
of jeans until he can no longer be seen.")
	(DESCFCN CLIENT-F)
	(SYNONYM GIANT CLIENT CLEAN)
	(ADJECTIVE JEAN CLEAN MR)
	(FLAGS OLDBIT ACTORBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION CLIENT-F)>

;"RMUNGBIT = defeated totally"

<ROUTINE CLIENT-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<COND (<NOT <FSET? ,CLIENT ,OLDBIT>>
		       <TELL CR 
"A giant of exceptional cleanliness stands proudly tall here, hands
on his hips">)
		      (<EQUAL? ,HERE ,STOCK-ROOM>
		       <TELL CR 
"A " D ,CLIENT ", an intense-looking man wearing thick glasses, is impatiently
rummaging through the haberdashery">)
		      (T
		       <TELL CR
"The " D ,CLIENT ", having been smashed back into his currently thin man-sized
shape, stands here looking disheveled and shaken">)> 
		<TELL ,PERIOD>)
	       (<NO-SUCH ,CLIENT ,W?JEAN ,W?GIANT ,W?CLEAN ,W?CLIENT>
		<RTRUE>)
	       (<AND <NOT <DONT-HANDLE ,CLIENT>>
		     <FSET? ,CLIENT ,TRANSFORMED>
		     <NOT <FSET? ,CLIENT ,OLDBIT>>
		     <OR <NOUN-USED ,CLIENT ,W?CLIENT>
		         <ADJ-USED ,CLIENT ,W?JEAN>>>
		<TELL "No can do. Giant stays a giant." CR>
		<RTRUE>)
	       (<AND <NOT <DONT-HANDLE ,CLIENT>>
		     <FSET? ,CLIENT ,TRANSFORMED>
		     <FSET? ,CLIENT ,OLDBIT>
		     <OR <NOUN-USED ,CLIENT ,W?GIANT>
		         <ADJ-USED ,CLIENT ,W?CLEAN>>>
		<TELL "No can do. Client stays a client." CR>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,CLIENT ,W?GIANT>
			 <ADJ-USED ,CLIENT ,W?CLEAN>> 
		     <TRANS-PRINT ,CLIENT>>
		<FSET ,CLIENT ,NDESCBIT>
		<MOVE ,CLIENT ,CLOUD-ROOM>
		<RTRUE>)>
	 <COND (<FSET? ,CLIENT ,OLDBIT>
		<COND (<EQUAL? ,CLIENT ,WINNER>
		       <COND (<OR <AND <VERB? SHOW>
				       <PRSO? ,ME>
				       <PRSI? ,BEETS>
				       <EQUAL? <GET ,P-NAMW 1> ,W?SEAT>>
				  <AND <VERB? SHOW>
				       <PRSO? ,BEETS>
				       <EQUAL? <GET ,P-NAMW 0> ,W?SEAT>>>
			      <SETG WINNER ,PROTAGONIST>
			      <PUT ,P-NAMW 1 ,W?SEAT>
			      <PERFORM ,V?SHOW ,ME ,BEETS>
			      <SETG WINNER ,CLIENT>
			      <RTRUE>)
			     (<EQUAL? ,HERE ,STOCK-ROOM>
			      <TELL
"He's too busy rumaging through the clothes to notice you." CR>
			      <STOP>)
			     (T
			      <TELL "He ignores you." CR>
			      <STOP>)>)>)
	       (<VERB? EXAMINE>
		<TELL
"The " D ,CLIENT ", having been scrubbed from head to toe, is a towering
figure of a man." CR>)
	       (<VERB? TELL>
		<TELL 
"You hear his deep, echoing voice in return: \"Fe... fi... fo... fum...\"" CR>
		<STOP>)>>

<GLOBAL CLIENT-C 0>

<ROUTINE I-CLIENT ()
	 <INC CLIENT-C>
	 <COND (<EQUAL? ,HERE ,STALK-ROOM>
		<COND (<FSET? ,CLIENT ,OLDBIT>
		       <COND (<EQUAL? ,CLIENT-C 1>
			      <MOVE ,CLIENT-NEEDLE ,CLIENT>
			      <TELL CR 
"Impulsively, the client dashes nearer, whips a needle out of his pocket,
and begins to maliciously sew you to a sheet." CR>)
			     (<EQUAL? ,CLIENT-C 5>
			      <JIGS-UP "You're all sewn up.">)
			     (T
			      ;"he's needling you ..."
			      <TELL CR
"The client with his needle continues sewing you to another sheet." CR>)>)
		      (<EQUAL? ,CLIENT-C 1 2 3>
		       <TELL CR "The giant's nearly upon you." CR>)
	              (<EQUAL? ,CLIENT-C 4>
		       <JIGS-UP "You're crushed by the giant's great hand.">)>)
	       (<NOT <EQUAL? ,HERE ,CLOUD-ROOM>>
		<RFALSE>)
	       (<EQUAL? ,CLIENT-C 1>
		<FSET ,BEAN-STALK ,RMUNGBIT>
		<TELL CR 
"Laughing maliciously, the giant leans over and spills a large bucketful
of thick, creamy butter on the bean stalk." CR>)
	       (<EQUAL? ,CLIENT-C 2>
		<TELL CR 
"Glaring at you from high above are the giant's pair of sparkling eyes which
are deep-set into his shiny bald head." CR>)
	       (<EQUAL? ,CLIENT-C 3>
		<TELL CR
"The roar of a passing supersonic flight of fancy can be heard, and
the wake of its exhaust ruffles the cloud for a few moments." CR>) 
	       (<EQUAL? ,CLIENT-C 5>
		<TELL
"The big giant examines his fingernails, unfolds his massive arms
and puts his hands on his hips." CR>)
	       (<EQUAL? ,CLIENT-C 6>
		<TELL 
"The giant covers most of the ground between you with one cloudy step." CR>)
	       (<EQUAL? ,CLIENT-C 7>
		<JIGS-UP
"You get a sinking feeling as you're hammered through the floor of the cloud
like a wooden peg. The view of the divided farmland below is picture-book
and enobling. Your fodder enriches further the land.">)>>

<ROUTINE CLIENT-FALL ()
	 <UPDATE-SCORE>
	 <SETG CLIENT-C 0>
	 <DEQUEUE I-CLIENT>
	 <MOVE ,CLIENT ,STALK-ROOM>
	 <FSET ,CLIENT ,OLDBIT>
	 <FCLEAR ,CLIENT ,NDESCBIT>
	 <REMOVE ,HOUSE>
	 <TELL
" can see the giant's feet sinking deeply into the cloud floor, which soon
gives way to the weight of the giant holding a lead house at his chest.
You get a close-up, front-row view of the horrified expression across his
huge face as it passes down in front of you and through the cloud." CR>>

<OBJECT JEAN-STOCK
	(LOC STOCK-ROOM)
	(DESC "jean stock")
	(SYNONYM STOCK STACK PILE JEANS ;STALK)
	(ADJECTIVE JEAN ;BEAN)
	(FLAGS TRYTAKEBIT NDESCBIT)
	;(GENERIC GEN-STOCK)
	(ACTION JEAN-STOCK-F)>

<ROUTINE JEAN-STOCK-F ()
	 <COND ;(<OR <NOUN-USED ,JEAN-STOCK ,W?STALK>
		    <ADJ-USED ,JEAN-STOCK ,W?BEAN>>
		 
		<TELL
"The mile-high stack of jeans slowly leans heavily into your direction and
as it passes the point of no return in a chaos of color, fabric and rivets,
all the jeans come tumbling down upon your head, burying you completely in
blackness.|
|
When you come to, it's in a new environment..." CR CR>
		<GOTO ,STALK-ROOM>) 
	       (<VERB? EXAMINE>
		<TELL
"A dizzying kaleidoscope of jeans surrounds you, notable among them is one
stack that climbs as high as the eye can see, toward the murky upper reaches of
this ceilingless room of the factory." CR>)
	       (<AND <VERB? BOARD CLIMB CLIMB-ON CLIMB-UP>
		     <NOT <EQUAL? ,P-PRSA-WORD ,W?RIDE>>>
		<TELL 
"As you straddle the stack of jeans, and start to inch tentatively upward,
the tall tower sways ominously, and you are forced to grab a bell-bottom
to keep your balance. It's clear there's no safe way up." CR>)>>

<ROOM STALK-ROOM
      (LOC ROOMS)
      (DESC "Bean Stalk")      
      (UP PER STALK-EXIT)
      (NORTH PER NO-DIR)
      (SOUTH PER NO-DIR)
      (EAST PER NO-DIR)
      (WEST PER NO-DIR)
      (NE PER NO-DIR)
      (SE PER NO-DIR)
      (SW PER NO-DIR)
      (NW PER NO-DIR)
      (GLOBAL HAZING BEAN-STALK)
      (ACTION STALK-ROOM-F)>

<ROUTINE STALK-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"A page from the imagination of your childhood, an illustration of
a country scene, an open field amid rolling hills under blue sky punctuated by
cottony soft clouds, next to a simple story punctuated by exclamation
points.|
|
An overgrown bean stalk grows thick and tall up into the clouds.
Nowadays, sadly, it seems the stalk would have to be rationalized, explained
away somehow by experts, as an ominous instance of radioactive mutation,
or as a patented, genetically manufactured hybrid -- rather than
attributed to, as in the old days, simply, magic. Such a realization
stirs a nostalgic longing for the days of yore when imagination reigned
in all its grandeur and innocence.">) ;"There's a clucking finch here."
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <IN? ,BEETS ,HERE>
		     <RUNNING? ,I-CLIENT>>
		<COND (<VERB? WALK WALK-TO>
		       <TELL "You're being sewn to sheets!" CR>)
		      (<AND ,PRSO
			    <TOUCHING? ,PRSO>>
		       <TELL "You're bound to the sheets." CR>)>)>>

<ROUTINE NO-DIR ()
	 <V-WALK-AROUND>
	 <RFALSE>>

<ROUTINE STALK-EXIT ("AUX" OBJ)
	 <COND ;(<EQUAL? <LOC ,PROTAGONIST> ,ICICLE> ;"cant get bike here now"
		<DO-FIRST "off the bike">)
	       (<AND <FSET? ,BEAN-STALK ,RMUNGBIT>
		     <NOT ,SHEETS-TIED>>		     
		<TELL 
"The bean stalk, thoroughly coated with melted butter, is too slippery
to climb">
		<COND (<EQUAL? ,HERE ,CLOUD-ROOM>
		       <TELL 
" down. It would be like an express elevator to hades">)
		      (T
		       <TELL " up">)>
		<TELL ,PERIOD>
		<RFALSE>)
	       (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		     ;<NOT <FSET? ,BEAN-STALK ,RMUNGBIT>>
		<COND (,SHEETS-TIED
		       <MOVE ,BEETS ,STALK-ROOM>
		       <SETG SHEETS-TIED <>>
		       <QUEUE I-CLIENT -1>
		       <TELL
"You grip the line of sheets and begin your
hand-over-hand descent from the sky, feeling the sharp winds against your back.
As your biceps begin tightening to the point of pain, you are again close
to the land. And none too soon, for a few feet above the
ground the tension of the life line is broken, and you tumble down to
earth, buried under a waterfall of sheets that comes streaming down upon your
head. Restlessly you dig yourself out..." CR CR>
		       <RETURN ,STALK-ROOM>)
		      (T
		       <TELL "You climb down stalk." CR CR>
		       <RETURN ,STALK-ROOM>)>)		      
	       (<AND <SET OBJ <FIRST? ,PROTAGONIST>>
		     <OR <AND <HELD? ,RAT>
			      <NOT <FSET? ,RAT ,WORNBIT>>>
			 <AND <IN? ,HOUSE ,PROTAGONIST>
			      <NOT ,LOUSE-ON-HEAD>>
			 <G? <CCOUNT ,PROTAGONIST> 2>
			 <NOT <EQUAL? <FIRST? ,PROTAGONIST> ,RAT ,HOUSE>>
			 <AND <NEXT? .OBJ>
			      <NOT <EQUAL? <NEXT? .OBJ> ,RAT ,HOUSE>>>>>
		<TELL 
"You'd never make it up the stalk while holding anything in your hands." CR>
		<RFALSE>)
	       (T
		<TELL 
"You shinny up the bean stalk like a native. Soon your head's in the clouds, followed by your whole body..." CR CR>
		<RETURN ,CLOUD-ROOM>)>>

<OBJECT BEAN-STALK
	(LOC LOCAL-GLOBALS)
	(DESC "Bean Stalk")
	(SYNONYM ;STOCK ;STACK ;JEANS STALK)
	(ADJECTIVE ;JEAN BEAN)
	(FLAGS NDESCBIT)
	(GENERIC GEN-BEAN-STALK)
	(ACTION BEAN-STALK-F)>

;"rmungbit = greased up by giant"

<ROUTINE BEAN-STALK-F ()
	 <COND (<VERB? BOARD CLIMB CLIMB-ON CLIMB-UP>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<AND <VERB? NO-VERB>
		     <EQUAL? ,HERE ,CLOUD-ROOM>>
		<DO-WALK ,P?DOWN>)
	       (<VERB? WALK-TO>
		<PERFORM ,V?WALK-TO ,HAZING>
		<RTRUE>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,BEAN-STALK ,RMUNGBIT>>
		<TELL "It's coated with melting butter." CR>)>>

<OBJECT BLUSHING-CROW
	(LOC STALK-ROOM)
	(OLDDESC "blushing crow")
	(NEWDESC "crushing blow")
	(FDESC 
"Walking around in circles here with its feathers ruffled is a crow, which is typically black except for its blushing red face. The crow seems
embarrassed by the kind of strange behavior animals are capable of
exhibiting in the vicinity.")
	(OLD-TO-NEW 
"The crow squawks loudly, scratches at the dirt, and bounds into flight,
soaring higher and higher into the sky. Then, tucking in its wings, the
weird bird takes a sudden nose dive that ends smashingly in a cloud of dirt
on the field. Dust settles around the crushing blow.")
	(NEW-TO-OLD
"A crack appears upon the surface of the blow, and extends jaggedly down
with a loud cracking noise. Out hops the crow, shedding its membrane
with bristling feathers.")     
	(SYNONYM CROW BLOW)
	(ADJECTIVE CRUSHING BLUSHING)
	(FLAGS OLDBIT TRYTAKEBIT)
	(ACTION BLUSHING-CROW-F)>

<ROUTINE BLUSHING-CROW-F ()
	 <COND (<NO-SUCH ,BLUSHING-CROW ,W?BLUSHING ,W?BLOW ,W?CRUSHING 
			 ,W?CROW>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,BLUSHING-CROW ,W?CROW>
		         <ADJ-USED ,BLUSHING-CROW ,W?BLUSHING>>
		     <TRANS-PRINT ,BLUSHING-CROW T>>
		<MOVE ,BLUSHING-CROW ,HERE>)
	       (<AND <OR <NOUN-USED ,BLUSHING-CROW ,W?BLOW>
			 <ADJ-USED ,BLUSHING-CROW ,W?CRUSHING>> 
		     <TRANS-PRINT ,BLUSHING-CROW>>
		<FSET ,BLUSHING-CROW ,TAKEBIT>
		<FCLEAR ,BLUSHING-CROW ,TRYTAKEBIT>
		<FSET ,BLUSHING-CROW ,TOUCHBIT>)>
	 <COND (<FSET? ,BLUSHING-CROW ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL 
"The " D ,BLUSHING-CROW " is walking pigeon-toed around in circles." CR>)
		      (<VERB? TAKE>
		       <TELL
"Hopping away from your swipe, the " D ,BLUSHING-CROW " evades you, its
face turning a deeper shade of crimson." CR>)>)
	       (<VERB? EXAMINE>
		<TELL 
"The strange-looking object seems to really pack a wallop. ">
		<ITALICIZE "You">
		<TELL " certainly wouldn't want to be hit with it." CR>)
	       (<VERB? DROP>
		<MOVE ,BLUSHING-CROW ,HERE>
		<TELL 
"The " D ,BLUSHING-CROW " falls harmlessly to" TR ,GROUND>) 
	       (<AND <VERB? GIVE THROW>
		     <PRSO? ,BLUSHING-CROW>>
		<PERFORM ,V?KILL ,PRSI ,BLUSHING-CROW>
		<RTRUE>)
	       (<AND <VERB? KILL>
		     <PRSI? ,BLUSHING-CROW>>
		<COND (<PRSO? ,ME>
		       <JIGS-UP "Pow!">)
		      (<PRSO? ,CLIENT>
		       <UPDATE-SCORE>
		       <REMOVE ,CLIENT>
		       <FSET ,CLIENT ,RMUNGBIT>
		       <REMOVE ,BLUSHING-CROW>
		       <DEQUEUE I-CLIENT>
		       <ITALICIZE "Kaboom!">
		       <TELL 
" The ground quakes with the staggering of the giant. Appearing like a punch
drunk fighter, he weaves round and round, all the while shrinking in size,
finally to the lowly hunched figure of the client. Humiliated at his defeat,
the man makes a Chaplinesque exit, kicking dust as he walks crookedly away."
CR>)>)>> 

<OBJECT MARE
	(LOC STALK-ROOM)
	(OLDDESC "mare squeal")
	(NEWDESC "square meal")
	(FDESC 
"In the distance you can hear the strange and unmistakable sound
of a female horse attempting to imitate the sound of a pig.")
	(OLD-TO-NEW
"The squealing of the mare becomes so increasingly strained and high-pitched
that you are forced
to cover your ears, lowering your head in squint-eyed pain. The instant
the terrible noise shuts off, your eyes pop open and notice a rather
angular meal at your feet.")
	(SYNONYM MARE HORSE SQUEAL MEAL)
	(ADJECTIVE SQUARE MARE ANGULAR)
	(FLAGS OLDBIT)
	;(GENERIC GEN-STOCK)
	(ACTION MARE-F)>

<ROUTINE MARE-F ()
	 <COND (<NO-SUCH ,MARE ,W?MARE ,W?MEAL ,W?SQUARE ,W?SQUEAL>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,MARE ,W?MARE ,W?SQUEAL>
		         <ADJ-USED ,MARE ,W?MARE>>
		     <NOT <FSET? ,MARE ,OLDBIT>>
		     <NOT <DONT-HANDLE ,MARE>>>
		<TELL 
"The square meal lets out a horsey kind of \"oink\" sound, but nothing else
happens." CR>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,MARE ,W?MEAL>
			 <ADJ-USED ,MARE ,W?SQUARE>> 
		     <TRANS-PRINT ,MARE>>
		<FSET ,MARE ,TOUCHBIT>
		<FSET ,MARE ,TAKEBIT>
		<FSET ,MARE ,FOODBIT>)>
	 <COND (<FSET? ,MARE ,OLDBIT>
		<COND (<OR <TOUCHING? ,MARE>
			   <SEEING? ,MARE>>
		       <TELL "You can't actually ">
		       <ITALICIZE "see">
		       <TELL 
" it, though you can certainly hear the mare squeal." CR>)
		      (<VERB? LISTEN>
		       <TELL 
"There's a mare squeal, hear.|
|
It's the distinct and curious noise
produced by a female horse imitating a pig -- you shudder to realize
you actually remember hearing this noise from reruns of Hee-Haw." CR>)>)
	       (<VERB? EAT>
		<TELL 
"You stop and realize there are other people in this world who need it
more than you do." CR>)
	       (<VERB? EXAMINE>
		<TELL 
"The meal is perfectly square, and looks scrumptous." CR>)>>

<ROOM CLOUD-ROOM
      (LOC ROOMS)
      (DESC "On Cloud 673")      
      (DOWN PER STALK-EXIT)
      (GLOBAL HAZING BEAN-STALK)
      (ACTION CLOUD-ROOM-F)>

<ROUTINE CLOUD-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <IN? ,CLIENT ,HERE>>
		<QUEUE I-CLIENT -1>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"You're on cloud 673. It's not exactly cloud nine but it's rather cushy,
and certainly roomy enough to be the home of a giant, which it just so happens
to be.">
		<COND (<IN? ,CLIENT ,HERE>
		       <TELL "||
Before you stands a giant of exceptional cleanliness, hands on his hips,
wearing an immaculately tailored and dazzlingly white tee shirt. So
statuesque is the figure of the giant that the floor of the
cloud on which he stands sags noticeably under his weight.">)
		      (<AND ,SHEETS-TIED
			    <IN? ,BEETS ,HERE>>
		       <TELL "||
A line of sheets hangs down from the cloud.">)>
		<RTRUE>)>>

<OBJECT BEETS
	(LOC CLOUD-ROOM)
	(OLDDESC "shed beets")
	(NEWDESC "bed sheets")
	(OLD-TO-NEW 
"The entire cloud becomes turbulently billowy, its vapors undulating
around and enveloping the shed. As the cloud recedes back to form, a pile
of sheets is revealed lying in place of the beets.")
	(FDESC 
"Off to one side of the cloud, a great many beets are piled up inside a shed,
evidently having been harvested from the green acres below in order
to satisfy the cravings of one gigantic appetite.") 
	(SYNONYM SHED BEETS SHEETS BEET SHEET SEAT)
	(ADJECTIVE SHED BED SHOWING ANOTHER)
	(FLAGS OLDBIT TRYTAKEBIT PLURALBIT)
	(ACTION BEETS-F)>

<GLOBAL SHEETS-TIED <>>

<ROUTINE BEETS-F ("AUX" WORD)
	 <COND (<NO-SUCH ,BEETS ,W?BED ,W?BEETS ,W?SHED ,W?SHEETS>
		<RTRUE>)
	       (<AND <NOT <FSET? ,BEETS ,OLDBIT>>
		     <OR <NOUN-USED ,BEETS ,W?BEET ,W?BEETS ,W?SHED>
		         <ADJ-USED ,BEETS ,W?SHED>>>
		<TELL "They won't go back to beets." CR>
		<RTRUE>)
	       (<AND <NOT <FSET? ,BEETS ,OLDBIT>>
		     <ADJ-USED ,BEETS ,W?BED>
		     <NOT <NOUN-USED ,BEETS ,W?SHEET ,W?SHEETS>>>
		<CANT-SEE <> "bed">
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,BEETS ,W?SHEETS ,W?SHEET>
			 <ADJ-USED ,BEETS ,W?BED>> 
		     <TRANS-PRINT ,BEETS>>
		<COND (<IN? ,CLIENT ,HERE>
		       <TELL ;CR 
"\"Deny me my daily bread, will you, scoundrel!\" decries Mr. Clean in
a stern voice." CR>)>
		<FSET ,BEETS ,TOUCHBIT>)
	       (<OR <NOUN-USED ,BEETS ,W?SEAT>
		    <ADJ-USED ,BEETS ,W?SHOWING>>
		<COND (<AND <RUNNING? ,I-CLIENT>
			    <EQUAL? ,HERE ,STALK-ROOM>
		            <VERB? SHOW NO-VERB>
			    <PRSO? ,ME ,CLIENT ,BEETS>>
		       <REMOVE ,BEETS>
		       <UPDATE-SCORE>
		       <REMOVE ,CLIENT-NEEDLE>
		       <SETG CLIENT-C 0>
		       <FCLEAR ,CLIENT ,OLDBIT>
		       <TELL
"Bumped by the train of your thoughts, the client pokes himself sharply with
his needle. To the accompaniment of ripping stitches and popping buttons, the
client's ire, along with his stature, is raised to the great height of a giant.
Between thumb and forefinger, he smashes the intervening chair into splinters,
which drift away above the rural landscape. Almost in slow-motion the giant
starts after you." CR>
		       <RTRUE>)
		      (<NOT <DONT-HANDLE ,BEETS>>
		       <TELL "No seat materializes." CR>
		       <RTRUE>)>)>
	 <COND (<AND <VERB? TAKE>
		     <NOT <IN? ,CLIENT ,HERE>>>
		<COND (<NOUN-USED ,BEETS ,W?BEET ,W?SHEET>
		       <SET WORD <GET ,P-NAMW 0>>
		       <TELL "Inexplicably, the ">
		       <PRINTB .WORD>
		       <TELL " won't separate from the pile." CR>)
		      (T
		       <TELL "Many too many " D ,BEETS "." CR>)>)
	       (<FSET? ,BEETS ,OLDBIT>
		<COND (<AND <VERB? TAKE>
		            <IN? ,CLIENT ,HERE>>
		       <TELL 
"\"Hands off! Shed beets for humungous appetite. Mine! Ho, ho, ho!\" bellows
the " D ,CLIENT "." CR>)>)
	       (<AND <TOUCHING? ,BEETS>
		     <NOT <FSET? ,BEETS ,OLDBIT>>
		     <EQUAL? ,HERE ,CLOUD-ROOM>
		     <IN? ,CLIENT ,HERE>>
		<TELL 
"\"Unhand my bedding,\" cautions the " D ,CLIENT "." CR>)
	       (<VERB? TOUCH EXAMINE>
		<TELL 
"The many bed sheets are soft and fluffy as the cloud, yet seem to be
made of sturdy fabric." CR>)
	       (<AND ,SHEETS-TIED
		     <OR <VERB? TIE-TOGETHER>
			 <AND <VERB? TIE>
			      <PRSO? ,PRSI>>>>
		<TELL "They already are." CR>)
	       (<AND <VERB? UNTIE>
		     ,SHEETS-TIED>
		<TELL "You can knot, since they're too tightly tied." CR>)
	       (<AND <EQUAL? ,HERE ,CLOUD-ROOM>
		     <OR <AND <VERB? TIE TIE-TOGETHER>
			      <NOT ,PRSI>>
			 <AND <VERB? TIE>
			      <PRSI? ,BEETS ,BEAN-STALK>>>>
		<SETG SHEETS-TIED T>
		<TELL 
"One by one, you tie together the bed sheets, testing each knot with a
firm tug accompanied by a tight-lipped grunt. Now off the edge of the
cloud gets thrown the line of sheets, which is strung out and down, looking
like a long kite tail swaying gently in the breeze.|
|
The last sheet you tie firmly to the cloud itself." CR>)
	       (<VERB? TIE>
		<WASTES>)
	       (<AND <VERB? CLIMB-DOWN CLIMB>
		     <EQUAL? ,HERE ,CLOUD-ROOM>
		     ,SHEETS-TIED>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>>

<OBJECT CLIENT-NEEDLE
	(DESC "needle")
	(SYNONYM NEEDLE)
	(FLAGS TRYTAKEBIT)
	(GENERIC GEN-NEEDLE)
	(ACTION CLIENT-NEEDLE-F)>

<ROUTINE CLIENT-NEEDLE-F ()
	 <COND (<VERB? TAKE>
		<TELL "You receive a sharp poke on the your backhand." CR>)>>

<ROUTINE GEN-NEEDLE ()
	 ,NEEDLE>