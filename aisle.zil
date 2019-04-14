"AISLE for
		            NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<OBJECT AISLE
	(LOC LOCAL-GLOBALS)
	(DESC "aisle")
	(PICK-IT "Go to the Shopping Bizarre")
	(MAX-SCORE 22) ;"WAS 22? , HAD BEEN 21"
	(SCENE-SCORE 0)
	(SCENE-ROOM DESSERT-ROOM)
	(SCENE-CUR 0)
	(SYNONYM AISLE WRITE MEET MEETS MANICOTTI ISLE MISC MUSSELANEOUS 
		 MAN CELLAR BRITISH BRIT DESERT DESSERT DESSERTS DESS)
	(ADJECTIVE I\'LL DESSERT DESERT DESSERTS BRIT BRITISH MISC
		   ;MAN DESS MUSSELANEOUS)
	(FLAGS NDESCBIT SCENEBIT VOWELBIT)
	(ACTION AISLE-F)>

<GLOBAL REAL-AISLE <>>

<ROUTINE AISLE-F ()
	 <COND (<OR <ADJ-USED ,AISLE ,W?DESSERT ,W?DESERT ,W?DESSERTS>
		    <NOUN-USED ,AISLE ,W?DESSERT ,W?DESERT ,W?DESSERTS>
		    <NOUN-USED ,AISLE ,W?DESS>
		    <ADJ-USED ,AISLE ,W?DESS>>
		<SETG REAL-AISLE ,DESSERT-ROOM>)
	       (<NOUN-USED ,AISLE ,W?MANICOTTI ,W?MAN>
		<SETG REAL-AISLE ,MANICOTTI-ROOM>)
	       (<NOUN-USED ,AISLE ,W?MEET ,W?MEETS>
		    ;<ADJ-USED ,AISLE ,W?LET ,W?US>
		<SETG REAL-AISLE ,LET-ROOM>)
	       (<OR <ADJ-USED ,AISLE ,W?BRITISH ,W?BRIT>
		    <NOUN-USED ,AISLE ,W?BRITISH ,W?BRIT>>
		<SETG REAL-AISLE ,BRITISH-ROOM>)
	       (<OR <ADJ-USED ,AISLE ,W?MUSSELANEOUS ,W?MISC>
		    <NOUN-USED ,AISLE ,W?MUSSELANEOUS ,W?MISC>>
		<SETG REAL-AISLE ,MUSSEL-ROOM>)
	       (<OR <NOUN-USED ,AISLE ,W?WRITE>
		    <ADJ-USED ,AISLE ,W?I\'LL>>
		<SETG REAL-AISLE ,ILL-ROOM>)
	       (<NOUN-USED ,AISLE ,W?CELLAR>
		<SETG REAL-AISLE ,CELLAR-ROOM>)
	       ;(T
	        <SETG REAL-AISLE ,DESSERT-ROOM>)>
	 <COND (<OR <NOT ,REAL-AISLE>
		    <VERB? NO-VERB>
		    <AND <DONT-HANDLE ,AISLE>
			 <NOT <VERB? WALK-TO>>>>
		<RFALSE>)
	       (<VERB? WALK-TO>
		<COND (<EQUAL? ,HERE ,REAL-AISLE>
		       <TELL ,ARRIVED>)
		      (<EQUAL? ,REAL-AISLE ,CELLAR-ROOM>
		       <COND (<NOT <EQUAL? ,HERE ,ILL-ROOM>>
			      <TELL "You dash over to \"I'll Write...\" ">)>
		       <SETG OLD-HERE <>>
		       <SETG HERE ,ILL-ROOM>
		       <MOVE ,PROTAGONIST ,ILL-ROOM>
		       ;<DO-WALK ,P?IN>
		       <ILL-ROOM-EXIT>
		       ;<V-$REFRESH T>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,CELLAR-ROOM>
		       <TELL "You climb up the stairs, going to..." CR CR>
		       <GOTO ,REAL-AISLE>)
		      (T
		       <COND (<PROB 30>
			      <TELL 
"You dash around the corner, sliding on the high-sheen surface of the
well-waxed supermarket floor">)
			     (<PROB 30>
			      <TELL "You waltz over there">)
			     (T
			      <TELL "You zip around the corner">)>
		       <TELL "..." CR CR>
		       <GOTO ,REAL-AISLE>)>)
	       (<NOT <EQUAL? ,HERE ,REAL-AISLE>>
		<CANT-SEE "such place">)
	       ;(T
		<CHANGE-OBJECT ,AISLE ,GLOBAL-ROOM>
		<RTRUE>)>>
		
<ROOM DESSERT-ROOM
      (LOC ROOMS)
      (DESC "Dessert Aisle")
      (OUT TO MANICOTTI-ROOM)
      (GLOBAL AISLE)
      (FLAGS INDOORSBIT)
      (ACTION DESSERT-ROOM-F)>

<ROUTINE DESSERT-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"You are all alone in a dessert aisle. The hum of a long
freezer that runs the length of the aisle is monotonous and the air blows
chilly upon your skin.">)>>
		
<OBJECT MOOSE
	(LOC DESSERT-ROOM)
	(OLDDESC "chocolate moose")
	(NEWDESC "chocolate mousse")
	(OLD-TO-NEW 
"There's a sudden, belching \"poof\" of smoke, and the odor of burnt
chocolate.")
	(NEW-TO-OLD
"\"Poof!\" The moose is suddenly enveloped in a thick plume of chocolaty
smoke.") 
	(DESCFCN MOOSE-F)
	(SYNONYM MOOSE MOUSSE)
	(ADJECTIVE CHOCOLATE)
	(FLAGS ;NOA OLDBIT)
	(ACTION MOOSE-F)>

<ROUTINE MOOSE-F ("OPTIONAL" (OARG <>) "AUX" (NOT-FIRST-TRANS T))
	 <COND (.OARG
		<COND (<FSET? ,MOOSE ,OLDBIT>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
		       	      <RTRUE>)>
		       <TELL CR
"An imposing, broad-shouldered adult moose, dark chocolate from hoof
to antler, stands here chewing its thick brown cud">
		       <COND (<EQUAL? ,HERE ,DESSERT-ROOM>
			      <TELL
" and blocking part of this narrow aisle">)>
		       <TELL ".">
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<AND <NOUN-USED ,MOOSE ,W?MOOSE>
		     <TRANS-PRINT ,MOOSE T T>> ;"Means no CR in trans-print"
		<COND (<NOT <IN? ,MOOSE ,HERE>>
		       <MOVE ,MOOSE ,HERE>
		       <TELL 
" The large mammal lands awkwardly on the floor.">)>
		<COND (<NOT <VERB? NO-VERB>> ;"was semied"
		       <CRLF>)>
		<CRLF>		
		<FCLEAR ,MOOSE ,TAKEBIT>
		<FCLEAR ,MOOSE ,NOA>)
	       (<NOUN-USED ,MOOSE ,W?MOUSSE>		
		<COND (<AND <NOT <FSET? ,MOOSE ,TRANSFORMED>>
		            <TRANS-PRINT ,MOOSE>>
		       
		       <COND (<PRSO? ,MOOSE>
			      <PERFORM-PRSA ,MOOSE ,PRSI>)
			     (T
			      <PERFORM-PRSA ,PRSO ,MOOSE>)>
		       <MOVE ,PI ,FREEZER>
		       <TELL CR 
"With the down-sizing of the big lug, you can see there are numbers
inside " D ,FREEZER ", rather than goodies." CR>
		       <RTRUE>)
		      (<NOT <VISIBLE? ,MOOSE>>
		       <RFALSE>)
		      (<TRANS-PRINT ,MOOSE> ;"now with own periods"
		       ;<TELL ,PERIOD>)>
		<FSET ,MOOSE ,TAKEBIT>
		<FSET ,MOOSE ,NOA>)>
	 <COND (<FSET? ,MOOSE ,OLDBIT>
		<COND (<VERB? TELL>
		       <TELL "He bellows out a sweet-smelling \"mooooo.\"" CR>
		       <STOP>)
		      (<VERB? EXAMINE>
		       <TELL
"Your teeth ache just looking at this massive bulk of ruminating mammalian
chocolate." CR>)
		      (<VERB? BOARD>
		       <TELL 
"You slide off the slippery chocolatey broad back of the sturdy moose,
standing up to discover yourself filthy with chocolate." CR>)
		      (<AND <VERB? KILL>
		     	    <PRSI? ,BEAR-CLAUSE>>
		       <TELL "You scare him away..." CR>)
		      (<VERB? EAT>
		       <TELL
"You would end up with the hugest stomachache you've ever had!" CR>)>)
	       ;"mousse"
	       (<VERB? EAT>
		<TELL "Don't eat profits." CR>
		;<TELL 
"The " D ,MOOSE ", fluffed up to a delicate, supreme deliciosity, is
eye-closingly pucker wonderful, and now all gone." CR>)>> 	

<OBJECT PI
	;(LOC DESSERT-ROOM)
	(OLDDESC "22/7")
	(NEWDESC "pie")
	(OLD-TO-NEW 
"The thing undergoes a deafening amount of number crunching.")
	(NEW-TO-OLD "Pie to pi.")
	(SYNONYM PI PIE FRACTION ;NUMBER ;NUMBERS)
	(FLAGS NARTICLEBIT OLDBIT TAKEBIT)
	(ACTION PI-F)>

<ROUTINE PI-F ()
	 <COND (<AND <OR <NOUN-USED ,PI ,W?PI ,W?NUMBER ,W?NUMBERS> ;"intum-f"
			 <NOUN-USED ,PI ,W?FRACTION>>
		     <NOT ,TRANS-PRINTED>
		     <TRANS-PRINT ,PI T>>		    
	        <FSET ,PI ,NARTICLEBIT>)
	       (<AND <NOUN-USED ,PI ,W?PIE>
		     <TRANS-PRINT ,PI>>
		<FCLEAR ,PI ,NARTICLEBIT>)>
	 <COND (<FSET? ,PI ,OLDBIT>
		<COND (<VERB? EAT>
		       <TELL 
"After some amount of number crunching, you decide it's inedible." CR>)
		      (<VERB? EXAMINE READ>
		       <TELL 
"You can see the number 22 frozen over the number 7." CR>)>)
	       ;"pie"
	       (<VERB? EAT>
		<TELL "Don't eat profits." CR>)>>

<OBJECT FREEZER
	(LOC DESSERT-ROOM)
	(DESC "your grocer's freezer")
	(SYNONYM FREEZER)
	(ADJECTIVE MY YOUR GROCER\'S)
	(FLAGS NARTICLEBIT SEARCHBIT OPENBIT CONTBIT NDESCBIT)
	(CAPACITY 300)
	(ACTION FREEZER-F)>

<ROUTINE FREEZER-F ()
	 <COND (<VERB? BOARD>
		<TELL
"Going cold turkey is admirable, but there is no monkey on your back." CR>)>>

;<ROUTINE SHELF-DESC (SHELF)
	 <COND (<FIRST? .SHELF>
		<COND (<EQUAL? .SHELF ,FREEZER>
		       <TELL " Sitting in " D ,FREEZER " is">)
		      (T
		       <TELL " Shelves here contain">)>
		<D-CONTENTS .SHELF>
		;<TELL ,PERIOD>)
	       (T
		<RFALSE>)>>

<ROOM MANICOTTI-ROOM
      (LOC ROOMS)
      (DESC "Aisle of Manicotti")
      (OUT TO LET-ROOM)
      (GLOBAL AISLE)
      (FLAGS INDOORSBIT)
      (ACTION MANICOTTI-ROOM-F)>

<ROUTINE MANICOTTI-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"As its name indicates, this is the aisle where grains and cereals are
stocked.">
		;<SHELF-DESC ,MANICOTTI-SHELF>
		;<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,MURDERER ,HERE>
		     <NOT ,ROOM-DESC-PRINTED>
		     <NOT <AND <VERB? SHOW>
			       <PRSI? ,MURDERER>>>>
		<TELL CR "The pallid gentleman continues his rampage by "
		        <PICK-NEXT <GET ,S-MURDERER 0>> " a package of "
			<PICK-NEXT <GET ,S-MURDERER 1>>>
		<TELL ,PERIOD>)>>
			 
<GLOBAL S-MURDERER
	<PTABLE
	 <LTABLE 2
	 	 "tearing his fangs into"
		 "murdering, in cold red dye #2,"
		 "devilishly ripping into"
		 "tucking into">
	 <LTABLE 2
		 "tortellini"
		 "Froot Loops"
		 "pasta primavera"
		 "sugar-frosted flakes"
		 "linguini"
		 "Count Chocula"
		 "rice crispies"
		 "spaghetti"
		 ;"toasted oats">>>

<OBJECT MANICOTTI-SHELF
	(LOC MANICOTTI-ROOM)
	(SYNONYM SHELF SHELVES)
	(DESC "shelves")
	(FLAGS SURFACEBIT SEARCHBIT OPENBIT CONTBIT NDESCBIT PLURALBIT)
	(CAPACITY 300)
	;(ACTION SHELF-F)>

<OBJECT CEREALS
	(LOC MANICOTTI-SHELF)
	(DESC "infinite variety of cereals")
	(SYNONYM GRAINS CEREAL CEREALS VARIETY)
	(ADJECTIVE INFINITE)
	(FLAGS TRYTAKEBIT VOWELBIT)
	(ACTION CEREALS-F)>

<ROUTINE CEREALS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL 
"It's dizzying to look at all the different brands. The shelf reaches a
vanishing point at either end of the long aisle." CR>)
	       (<VERB? TAKE>
		<TELL "It deserves a longer shelf life." CR>)>>

<OBJECT MURDERER
	(LOC MANICOTTI-ROOM)
	(DESC "cereal murderer")
	(DESCFCN MURDERER-F)
	(SYNONYM MURDERER KILLER VAMPIRE VAMP MAN GENTLEMAN)
	(ADJECTIVE CEREAL SERIAL)
	(FLAGS ACTORBIT)
	(ACTION MURDERER-F)>

<GLOBAL MINCE-EATEN <>>

<ROUTINE MURDERER-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR
"About halfway down the aisle there is a sinister and pallid-looking gentleman
in a dark tuxedo">
		 <COND (<NOT <FSET? ,MURDERER ,RMUNGBIT>>
		        <FSET ,MURDERER ,RMUNGBIT>
		        <TELL
". He appears to be systematically destroying boxes of cereal, taking
deep bites into them with his long fangs">)>
		 <TELL ,PERIOD>)
	       (<NOT <VISIBLE? ,MURDERER>>
		<RFALSE>)
	       (<AND <ADJ-USED ,MURDERER ,W?SERIAL>
		     <NOT ,TRANS-PRINTED>>
		<SETG TRANS-PRINTED T>
		<TELL 
"(True, he is both a cereal and a SERIAL murderer, but just knowing his
modus operandi doesn't defeat him.)" CR>
		<COND (<NOT <VERB? NO-VERB>>
		       <CRLF>)
		      (<VERB? SET>
		       <RTRUE>)>)>
	 <COND (<VERB? GIVE> ;"handled in v-give"
		<RFALSE>)
	       (<AND <TOUCHING? ,MURDERER>
		     <NOT ,MINCE-EATEN>>
		<TELL 
"The " D ,MURDERER " faces you open-mouthed, and his bad breath caused by
all his recent activity drives you back down the aisle." CR>)	       
	       (<OR <AND <VERB? PUT>
			 <EQUAL? <GET ,P-NAMW 0> ,W?STAKE>
			 <PRSO? ,STEAK>>
		    <AND <VERB? KILL>
			 <EQUAL? <GET ,P-NAMW 1> ,W?STAKE>
			 <PRSI? ,STEAK>>>
		<FCLEAR ,STAKE ,OLDBIT>
		<REMOVE ,STEAK>
		<REMOVE ,MURDERER>
		<UPDATE-SCORE>
		<TELL
"With a powerful thrust, you drive the " D ,STEAK " deep into the heart of
the now horrified " D ,MURDERER ". He collapses to the floor, blood trickling
out of the sides of his mouth. Then he vanishes with a puff of pale blue
smoke." CR>)
	       (<OR <VERB? TELL TELL-ABOUT>
		    <AND <VERB? SHOW>
		         <PRSI? ,MURDERER>>>
		<TELL 
"He's too busy " <PICK-NEXT <GET ,S-MURDERER 0>> " a package of "
<PICK-NEXT <GET ,S-MURDERER 1>> " to notice." CR>
		<STOP>)>>

<ROOM MUSSEL-ROOM
      (LOC ROOMS)
      (DESC "Musselaneous")
      (OUT TO ILL-ROOM)
      (GLOBAL AISLE)
      (FLAGS INDOORSBIT)
      (ACTION MUSSEL-ROOM-F)>

<ROUTINE MUSSEL-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This aisle is filled with various and sundry items.">
		;<SHELF-DESC ,MUSSEL-SHELF>
		;<RTRUE>)>>

<OBJECT MUSSEL-SHELF
	(LOC MUSSEL-ROOM)
	(DESC "shelves")
	(SYNONYM SHELF SHELVES)
	(FLAGS SURFACEBIT SEARCHBIT OPENBIT CONTBIT NDESCBIT)
	(CAPACITY 300)
	;(ACTION SHELF-F)>

<OBJECT MUSSELS
	(LOC MUSSEL-SHELF)
	(OLDDESC "mussels")
	(NEWDESC "muscles")
	(OLD-TO-NEW
"You feel yourself undergo a Hulkian physical transformation, with material
ripping and buttons popping and the whole bit.")
	(NEW-TO-OLD 
"You grow faint and very weak for a few moments and nearly pass out, then fade
back in with the realization that your clothes fit you more loosely now.
A clump of mussels falls to the floor.")
	(SYNONYM MUSSELS MUSSEL MUSCLE MUSCLES CLUMP)
	(ADJECTIVE MY YOUR)
	(FLAGS OLDBIT TAKEBIT ;NARTICLEBIT PLURALBIT)
	(ACTION MUSSELS-F)>

<ROUTINE MUSSELS-F ()
	 <COND (<AND <NOUN-USED ,MUSSELS ,W?MUSSELS ,W?MUSSEL ,W?CLUMP>
		     <TRANS-PRINT ,MUSSELS T>>
		<MOVE ,MUSSELS ,HERE>)
	       (<AND <NOUN-USED ,MUSSELS ,W?MUSCLE ,W?MUSCLES>
		     <TRANS-PRINT ,MUSSELS>>
		<MOVE ,MUSSELS ,PROTAGONIST>)>
	 <COND (<FSET? ,MUSSELS ,OLDBIT>
		<COND (<VERB? EAT MUNG OPEN>
		       <TELL 
"The shells are too hard to open." CR>)
		      (<VERB? SMELL>
		       <TELL "Like mussels gone bad." CR>)
		      (<VERB? EXAMINE>
		       <TELL 
"The mussels, oozing with glop, look and smell like they've long
passed their expiration date. They may have been once used as bait-and-switch,
but now they're a blight on the store." CR>)>)
	       ;"muscles"
	       (<VERB? EAT>
		<TELL "Auto-canibalism is not the answer." CR>)>>

<OBJECT SAIL
	(LOC MUSSEL-SHELF)
	(OLDDESC "sail")
	(NEWDESC "sale")
	(OLD-TO-NEW
"You hear the distant ring-ring of cash registers.")
	(NEW-TO-OLD
"A brief but strong wind whips through")   
	(SYNONYM SAIL SALE)
	(FLAGS OLDBIT TAKEBIT SURFACEBIT SEARCHBIT OPENBIT CONTBIT)
	(CAPACITY 20)
	(ACTION SAIL-F)>

<ROUTINE SAIL-F ()
	 <COND (<AND <NOUN-USED ,SAIL ,W?SAIL>
		     <TRANS-PRINT ,SAIL T T>>
		<COND (<NOT <EQUAL? ,HERE ,CELLAR-ROOM>> ;"ie, in an aisle?"
		       <TELL " your aisle">)
		      (T
		       <TELL " the air">)>
		<TELL ,PERIOD ;CR>)
	       (<NOUN-USED ,SAIL ,W?SALE>
		<TRANS-PRINT ,SAIL>)>
	 <COND (<FSET? ,SAIL ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL
"This is a large, rainbow-colored sail, all folded up and wrapped in plastic. ">
		       <RFALSE>)
		      (<VERB? OPEN REMOVE>
		       <TELL "The plastic's too tough." CR>)>)>>

;<OBJECT CHEWS
	(LOC MUSSEL-SHELF)
	(OLDDESC "chews")
	(NEWDESC "choose")
	(SYNONYM CHEWS CHOOSE TOBACCO)
	(ADJECTIVE CHEWING)
	(FLAGS OLDBIT)
	(ACTION CHEWS-F)>

;<ROUTINE CHEWS-F ()
	 <COND (<OR <NOUN-USED ,CHEWS ,W?CHEWS ,W?TOBACCO>
		    <ADJ-USED ,CHEWS ,W?CHEWING>>
		<FSET ,CHEWS ,OLDBIT>
		<FCLEAR ,CHEWS ,NARTICLEBIT>
		<FSET ,CHEWS ,PLURALBIT>)
	       (<NOUN-USED ,CHEWS ,W?CHOOSE>
		<FCLEAR ,CHEWS ,OLDBIT>
		<FSET ,CHEWS ,NARTICLEBIT>
		<FCLEAR ,CHEWS ,PLURALBIT>)>> 

<OBJECT TACKS 
	(LOC MUSSEL-SHELF)
	(OLDDESC "tacks")
	(NEWDESC "tax")
	(OLD-TO-NEW
"You hear the distant ring-ring of cash registers.")
	(NEW-TO-OLD
"Thumb tacks suddenly begin raining down to the floor.")
	(SYNONYM TACK TACKS TAX ;BOX)
	(FLAGS TAKEBIT OLDBIT PLURALBIT)
	(ACTION TACKS-F)> 

<ROUTINE TACKS-F ()
	 <COND (<AND <NOUN-USED ,TACKS ,W?TACKS ,W?TACK>
		     <TRANS-PRINT ,TACKS T>>
		<FSET ,TACKS ,PLURALBIT>)
	       (<AND <NOUN-USED ,TACKS ,W?TAX>
		     <TRANS-PRINT ,TACKS>>
		<FCLEAR ,TACKS ,PLURALBIT>)>
	 <RFALSE>>

<ROOM BRITISH-ROOM
      (LOC ROOMS)
      (DESC "British Aisle")
      (OUT TO MUSSEL-ROOM)
      (GLOBAL SIGN AISLE)
      (FLAGS INDOORSBIT)
      (ACTION BRITISH-ROOM-F)>

<ROUTINE BRITISH-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The floor here is richly painted in the bold colours of Brittania.">)>> 

<OBJECT BRITISH-SHELF
	(LOC BRITISH-ROOM)
	(DESC "shelf")
	(SYNONYM SHELF SHELVES)
	(FLAGS SURFACEBIT SEARCHBIT OPENBIT CONTBIT NDESCBIT)
	(CAPACITY 300)
	(ACTION BRITISH-SHELF-F)>

<ROUTINE BRITISH-SHELF-F ()
	 <COND (<VERB? LOOK-INSIDE EXAMINE>
		<COND (<FSET? ,PUTTING ,OLDBIT>
		       <TELL 
"An avalanche of boxes slopes down from the shelf">)
		      (T
		       <TELL
"A neat row of pudding fills the shelf">)>
		<TELL ,PERIOD>)>> 

<OBJECT PUTTING
	(LOC BRITISH-ROOM)
	(OLDDESC "Putting Section")
	(NEWDESC "Pudding Section")
	(OLD-TO-NEW
"The boxes begin swirling into a dark, menacing whirlwind, causing you
to cover yourself up defensively. In an instant there is again calm, with
order having been restored to the aisle.")
	(NEW-TO-OLD
"There is a deep rumbling noise which travels along the aisle, shaking the
boxes down from the shelves into a disorderly heap.")   
	(DESCFCN PUTTING-F)
	(SYNONYM PUTTING PUDDING SECTION)
	(ADJECTIVE PUTTING PUDDING)
	(FLAGS OLDBIT TRYTAKEBIT ;NDESCBIT)
	(ACTION PUTTING-F)>
	
<ROUTINE PUTTING-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR "Under a large sign, ">
		<COND (<FSET? ,PUTTING ,OLDBIT>
		       <TELL
"a box boy is frantically filling and overfilling
the shelves with boxes, which are spilling over into the aisle and blocking
the way">)
		      (T
		       <TELL
"a wide variety of puddings are neatly stacked upon the shelves">)>
		<TELL ,PERIOD>)
	       (<AND <OR <NOUN-USED ,PUTTING ,W?PUTTING>
		         <ADJ-USED ,PUTTING ,W?PUTTING>>
		     <TRANS-PRINT ,PUTTING T>>
		<MOVE ,BOX-BOY ,HERE>
		<MOVE ,BOXES ,HERE> ;"from british-shelf" )
	       (<OR <NOUN-USED ,PUTTING ,W?PUDDING>
		    <ADJ-USED ,PUTTING ,W?PUDDING>>		     
		<COND (<NOT <VISIBLE? ,PUTTING>>
		       <RFALSE>)
		      (<NOT <FSET? ,PUTTING ,TRANSFORMED>>
		       <TRANS-PRINT ,PUTTING>
		       <MOVE ,ANTS ,HERE>
		       <TELL 
"Having tidied up the place, you can now see a trail of ants crawling along
the aisle floor." CR>)
		      (T
		       <TRANS-PRINT ,PUTTING>)>
		<FCLEAR ,PUTTING ,OLDBIT>
		<MOVE ,BOXES ,BRITISH-SHELF>
		<REMOVE ,BOX-BOY>)>
	 <COND (<FSET? ,PUTTING ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL 
"An avalanche of boxes tumble down as the box boy keeps putting new ones on
the shelves." CR>)
		      (<VERB? TAKE>
		       <TELL "The boxes are too bulky." CR>)>)
	       (<VERB? TAKE>
		<COND (,TRANS-PRINTED
		       <RTRUE>)>
		<TELL "They're best left on the shelf." CR>)>>
	       
<OBJECT BOXES
	(LOC BRITISH-ROOM)
	(DESC "cardboard boxes")
	(SYNONYM BOX BOXES)
	(ADJECTIVE CARDBOARD UNMARKED)
	(FLAGS TRYTAKEBIT NDESCBIT PLURALBIT)
	(ACTION BOXES-F)>

<ROUTINE BOXES-F ()
	 <COND (<AND <VERB? MOVE TAKE>
		     <IN? ,BOX-BOY ,HERE>>
		<TELL 
"The " D ,BOX-BOY " grabs the box from you and now is putting it back on the
overcrowded shelf." CR>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,BOXES>>
		<WASTES>)
	       (<VERB? TAKE>
		<COND (<FSET? ,PUTTING ,OLDBIT>
		       <TELL "You don't really need 'em." CR>)
		      (T
		       <PERFORM ,V?TAKE ,PUTTING>
		       <RTRUE>)>)
	       (<VERB? OPEN>
		<TELL "They're all too tightly bound up." CR>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,PUTTING ,OLDBIT>
		       <TELL "They are all unmarked " D ,BOXES "." CR>)
		      (T
		       <PERFORM ,V?EXAMINE ,PUTTING>
		       <RTRUE>)>)>>

<OBJECT BOX-BOY
	(LOC BRITISH-ROOM)
	(DESC "box boy")
	(SYNONYM BOY)
	(ADJECTIVE BOX)
	(FLAGS ACTORBIT NDESCBIT)
	(ACTION BOX-BOY-F)>

<ROUTINE BOX-BOY-F ()
	 <COND (<VERB? TELL>
		<TELL "The blockhead will not answer." CR>
		<STOP>)
	       (<VERB? EXAMINE>
		<TELL 
"The entire body of the boy is made out of various sized boxes." CR>)>>

<ROOM LET-ROOM
      (LOC ROOMS)
      (DESC "Meets")
      (OUT TO BRITISH-ROOM)
      (GLOBAL AISLE)
      (FLAGS INDOORSBIT)
      (ACTION LET-ROOM-F)>

<ROUTINE LET-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,LET-ROOM ,TOUCHBIT>>>
		<QUEUE I-BRAT -1>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"This is where people tend to run into each other....">
		;<SHELF-DESC ,LET-SHELF>
		;<RTRUE>)>>

<OBJECT STEAK
	(LOC LET-SHELF)
	(OLDDESC "steak")
	(NEWDESC "stake")
	(OLD-TO-NEW
"Under your gaze, the meat starts sizzling and smoking wildly, licking flames
into the air till nothing is left to it but a charred and pointed stick.")
	(NEW-TO-OLD "Shazam! Meet the meat.")
	(SYNONYM STEAK STAKE MEAT STICK)
	(FLAGS OLDBIT TAKEBIT)
	(ACTION STEAK-F)>

<ROUTINE STEAK-F ()
	 <COND (<NOUN-USED ,STEAK ,W?STEAK ,W?MEAT>
		<TRANS-PRINT ,STEAK T>)
	       (<NOUN-USED ,STEAK ,W?STAKE ,W?STICK>
		<TRANS-PRINT ,STEAK>)>
	 <COND (<FSET? ,STEAK ,OLDBIT>
		<COND (<VERB? EAT>
		       <TELL "The meat is too tough." CR>)>)
	       ;"stake"
	       (<VERB? EAT>
		<TELL "Stakes and stones are inedible." CR>)
	       (<AND <VERB? PUT>
		     <FSET? ,PRSI ,ACTORBIT>
		     <PRSO? ,STEAK>>
		<PERFORM ,V?KILL ,PRSI ,PRSO>
		<RTRUE>)>>

<OBJECT MINCE
	(LOC LET-SHELF)
	(OLDDESC "mince")
	(NEWDESC "mints")
	(OLD-TO-NEW
"You catch a whiff of fresh little candies as the mince goes to pieces
and becomes white before your eyes.")
	(NEW-TO-OLD
"You hear the tortured \"moo\" of a cow in the distance.")
	(SYNONYM MINCE MEAT MINT MINTS CANDY CANDIES)
	(ADJECTIVE MINCE FRESH LITTLE)
	(FLAGS OLDBIT TAKEBIT)
	(ACTION MINCE-F)>

<ROUTINE MINCE-F ()
	 <COND (<AND <NOUN-USED ,MINCE ,W?MINCE ,W?MEAT>
		     <TRANS-PRINT ,MINCE T>
		     ;<ADJ-USED ,MINCE ,W?MEAT>>
		<FCLEAR ,MINCE ,PLURALBIT>
		<FSET ,MINCE ,NARTICLEBIT>)
	       (<AND <OR <NOUN-USED ,MINCE ,W?MINTS ,W?MINT ,W?CANDIES>
			 <NOUN-USED ,MINCE ,W?CANDY>
			 <ADJ-USED ,MINCE ,W?LITTLE>>
		     <TRANS-PRINT ,MINCE>>
		<FSET ,MINCE ,PLURALBIT>
		<FCLEAR ,MINCE ,NARTICLEBIT>)>
	 <COND (<FSET? ,MINCE ,OLDBIT>
		<COND (<VERB? EAT>
		       <TELL "The mince is too tough." CR>)>)
	       ;"mints"
	       (<VERB? EAT>
		<TELL "Your breath isn't that bad to need them." CR>)>>

<OBJECT BRAT
	;(LOC LOCAL-GLOBALS)
	(OLDDESC "worst brat")
	(NEWDESC "bratwurst")
	(DESCFCN BRAT-F)
	(SYNONYM BRAT WORST WURST BRATWURST GIRL SAUSAGE NIECE)
	(ADJECTIVE BRAT WORST LITTLE THEIR)
	(FLAGS ACTORBIT FEMALEBIT TRYTAKEBIT TAKEBIT CONTBIT OPENBIT 
	       SEARCHBIT OLDBIT)
	(GENERIC GEN-GIRL)
	(ACTION BRAT-F)>

<ROUTINE BRAT-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<FSET? ,BRAT ,OLDBIT>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
		       	      <RTRUE>)>
		       <TELL CR
"The girl is busy here throwing a tantrum."> 
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT <VISIBLE? ,BRAT>>
		<RFALSE>)
	       (<OR <NOUN-USED ,BRAT ,W?BRAT ,W?WORST ,W?GIRL>
		    <ADJ-USED ,BRAT ,W?WORST ,W?LITTLE>>
		<COND (<NOT <FSET? ,BRAT ,OLDBIT>>
		       <FSET ,BRAT ,OLDBIT>
		       <SETG TRANS-PRINTED T>
		       <TELL
"The sausage suddenly sprouts legs, and is transformed into the form of
a small girl (thereby shattering the myth about sugar and spice and
everything nice). ">
		       <COND (<HELD? ,BRAT>
			      <TELL
"She fiercely struggles from your grip and">)
			     ;(<NOT <IN? ,BRAT ,HERE>>
			      <TELL "She climbs o">
			      <COND (<FSET? <LOC ,BRAT> ,SURFACEBIT>
		       		     <TELL "ff">)
		      		    (T
		       		     <TELL "ut of">)>
			      <TELL T <LOC ,BRAT>>)
			     (T
			      <TELL "She">)>
		       <TELL " sprints away">
		       <COND (<NOT <EQUAL? ,HERE ,CELLAR-ROOM>>
			      <TELL " down the aisle">)>
		       <COND (<AND <IN? ,ANTS ,HERE>
				   <NOT <FSET? ,ANTS ,OLDBIT>>>
			      <UPDATE-SCORE>
			      <TELL
" into the waiting hands of her aunts. They thank you, then leave." CR>
			      <REMOVE ,ANTS>
			      <REMOVE ,BRAT>
			      <DEQUEUE I-BRAT>
			      <DEQUEUE I-ANTS>
			      <RTRUE>)
			     (T
			      <TELL " and out of sight">)>
		       <TELL ,PERIOD>		       
		       <REMOVE ,BRAT>
		       <SETG BRAT-C 5>		       
		       <QUEUE I-BRAT -1>
		       <RTRUE>)>
		<FCLEAR ,BRAT ,NARTICLEBIT>
		<FSET ,BRAT ,ACTORBIT>
		<FSET ,BRAT ,FEMALEBIT>
		<FCLEAR ,RIBBON ,INVISIBLE>
		<FSET ,BRAT ,TRYTAKEBIT>
		<FSET ,BRAT ,CONTBIT>)
	       (<NOUN-USED ,BRAT ,W?BRATWURST ,W?WURST ,W?SAUSAGE>
		<COND (<FSET? ,BRAT ,OLDBIT>
		       <SETG TRANS-PRINTED T>
		       <COND (<NOT <FSET? ,BRAT ,TRANSFORMED>>
			      <UPDATE-SCORE>)>
		       <FSET ,BRAT ,TRANSFORMED>
		       <TELL "The little girl">
		       <COND (<NOT <G? ,BRAT-C 5>>     
		       	      <TELL " begins running away in horror. She">)>
		       <TELL 
" tumbles head over heels to the floor in a blur, and then you observe a
sausage come rolling to a stop." CR>
		       <COND (<NOT <VERB? NO-VERB>>
			      <CRLF>)>)>
		<DEQUEUE I-BRAT>
		<FCLEAR ,BRAT ,CONTBIT>
		<FCLEAR ,BRAT ,TRYTAKEBIT>
		<FCLEAR ,BRAT ,OLDBIT>
		<FCLEAR ,BRAT ,ACTORBIT>
		<FCLEAR ,BRAT ,FEMALEBIT>
		<FSET ,BRAT ,NARTICLEBIT>
		<FSET ,RIBBON ,INVISIBLE>)>
	 <COND (<FSET? ,BRAT ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL 
"You notice the little girl is wearing a " D ,RIBBON " with something written on it." CR>)
		      (<VERB? TELL>
		       <TELL 
"She tilts her head up toward, you and issues a loud, mean-spirited raspberry." CR>
		       <STOP>)
		      (<VERB? TAKE>
		       <TELL 
"Dashing between your legs and screaming bloody murder, the girl whirls you
'round in a violent twist." CR>)>)
	       ;"bratwurst"
	       (<VERB? EAT>
		<TELL "Very spicy." CR>)>>

<GLOBAL BRAT-C 0>

<GLOBAL RESUME-BRAT <>>

<ROUTINE I-BRAT ()
	 ;<COND (<EQUAL? ,HERE ,BRITISH-ROOM>
		<RFALSE>)>
	 <INC BRAT-C>
	 <COND (<EQUAL? ,BRAT-C 1>
		<MOVE ,BRAT ,HERE>
		<TELL CR 
"You notice a blur of colorful lace and flowing blond hair come rolling
off one of the shelves. A little girl stands at your feet." CR>)
	       (<AND <L? ,BRAT-C 5> ;"2 3 4"
		     <IN? ,BRAT ,HERE>>
		<TELL CR <PICK-NEXT <GET ,S-BRAT 0>> " little girl "
		         <PICK-NEXT <GET ,S-BRAT 1>> ,PERIOD>)
	       (<AND <EQUAL? ,BRAT-C 5>
		     <IN? ,BRAT ,HERE>>
		<REMOVE ,BRAT>
		<TELL CR 
"With a final karate chop to your leg, the little girl spirits off down the
aisle and out of sight." CR>)
	       (<AND <EQUAL? ,BRAT-C 9 16 21 27>
		     <NOT <IN? ,BRAT ,HERE>>
		     <NOT <EQUAL? ,HERE ,CELLAR-ROOM>>>
		<MOVE ,BRAT ,HERE>
		<TELL CR
"The screaming meemie of a girl comes out of nowhere, running down the aisle toward you." CR>
		<COND (<AND <NOT <FSET? ,RIBBON ,RMUNGBIT>>
			    <NOT <FSET? ,BRAT ,TRANSFORMED>>>
		       <PERFORM ,V?EXAMINE ,BRAT>
		       <PERFORM ,V?EXAMINE ,RIBBON>)>
		<RTRUE>)
	       (<AND <G? ,BRAT-C 5> 
		     <IN? ,BRAT ,HERE>>
		<REMOVE ,BRAT>
		<TELL CR 
"The girl, screaming at the top of her lungs, runs by you and out of
sight again." CR>)
	       (<G? ,BRAT-C 28>
		<SETG BRAT-C 5>)>
	 <RTRUE>>  

<GLOBAL S-BRAT
	<PTABLE
	 <LTABLE 2
	 	 "Tattooing your knee caps with her little fists, the"
		 "Practicing field goals upon your shins, the" 
		 "The">
	 <LTABLE 2
		 "starts throwing a tantrum"
		 "continues testing your threshold of pain"
		 "keeps on boxing your calves">>>

<OBJECT RIBBON
	(LOC BRAT)
	(DESC "blue ribbon")
	(SYNONYM RIBBON)
	(ADJECTIVE BLUE)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION RIBBON-F)>

<ROUTINE RIBBON-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,BRAT ,OLDBIT>>
		<TELL "The " D ,BRAT " gives you a kick to the shins." CR>)
	       (<VERB? EXAMINE READ>
		<FSET ,RIBBON ,RMUNGBIT>
		<TELL
"It reads: \"Worst Brat.\"" CR>)>>

<OBJECT ANTS
	;(LOC LOCAL-GLOBALS)
	(OLDDESC "colony of ants")
	(NEWDESC "aunts")
	(OLD-TO-NEW
"Instantly, the little creatures become big creatures.")
	(NEW-TO-OLD
"The ladies seem to vanish in their tracks.")    
	(DESCFCN ANTS-F)
	(SYNONYM ANT ANTS COLONY AUNT AUNTS LINE LADIES WOMEN LADY)
	(FLAGS TRYTAKEBIT OLDBIT)
	(ACTION ANTS-F)>

<ROUTINE ANTS-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<NOT <FSET? ,ANTS ,OLDBIT>>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL CR 
"A number of aunts in gaudy hats are here milling about."> 
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<AND <NOUN-USED ,ANTS ,W?ANT ,W?ANTS ,W?COLONY>
		     <TRANS-PRINT ,ANTS T>>
		<DEQUEUE I-ANTS>		
		<FCLEAR ,ANTS ,ACTORBIT>
		<FSET ,ANTS ,PLURALBIT>)
	       (<AND <NOUN-USED ,ANTS ,W?AUNT ,W?AUNTS ,W?LADIES>
		     <TRANS-PRINT ,ANTS>>
         	<COND (<G? ,ANTS-C 5>
		       <SETG ANTS-C 5>)> ;"will leave on this turn"
		<QUEUE I-ANTS -1>
		<FSET ,ANTS ,ACTORBIT>
		<FSET ,ANTS ,PLURALBIT>)>
	 <COND (<FSET? ,ANTS ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL
"They're crawling in a line down the aisle." CR>)
		      (<VERB? TAKE>
		       <TELL "They're untakeable." CR>)>)
	       ;"aunts"
	       (<VERB? EXAMINE>
		<TELL 
"They are milling about, talking in high falsetto voices with British
accents about the latest sales, and inquiring of each other where their
little niece Emily is." CR>)
	       (<VERB? TELL>
		<TELL "They are too busy gossiping among themselves." CR>
		<STOP>)>>

<GLOBAL ANTS-C 0>

<GLOBAL RESUME-ANTS <>>

<ROUTINE I-ANTS ()
	 <COND (;<EQUAL? ,HERE ,BRITISH-ROOM>
		    <AND <IN? ,BRAT ,HERE>
		         <FSET? ,BRAT ,OLDBIT>>
		<RFALSE>)>
	 <INC ANTS-C>
	 <COND (<EQUAL? ,ANTS-C 1>
		<MOVE ,ANTS ,HERE>
		<TELL CR 
"The aunts start milling." CR>)
	       (<AND <L? ,ANTS-C 5> ;"2 3 4"
		     <IN? ,ANTS ,HERE>>
		<TELL CR 
"The milling aunts are gawking and talking among themselves." CR>)
	       (<AND <G? ,ANTS-C 4> ;"5 thru 27"
		     <IN? ,ANTS ,HERE>>
		<REMOVE ,ANTS>
		<TELL CR 
"Finding nothing of interest here, the aunts walk in a line around the corner
of the aisle and out of sight." CR>)
	       (<AND <EQUAL? ,ANTS-C 9 15 21 26>
		     <NOT <IN? ,ANTS ,HERE>>
		     <NOT <EQUAL? ,HERE ,CELLAR-ROOM>>>
		<MOVE ,ANTS ,HERE>
		<TELL CR
"The motley line of aunts comes strolling into your aisle." CR>)
	       (<G? ,ANTS-C 28>
		<SETG ANTS-C 5>)>
	 <RTRUE>>

<OBJECT LET-SHELF
	(LOC LET-ROOM)
	(DESC "shelf")
	(SYNONYM SHELF SHELVES)
	(FLAGS SURFACEBIT SEARCHBIT OPENBIT CONTBIT NDESCBIT)
	(CAPACITY 300)
	;(ACTION SHELF-F)>

<ROOM ILL-ROOM
      (LOC ROOMS)
      (DESC "I'll Write")
      (OUT TO DESSERT-ROOM)
      (IN PER ILL-ROOM-EXIT)
      (DOWN PER ILL-ROOM-EXIT)
      (GLOBAL LOCKS-DOOR AISLE)
      (FLAGS INDOORSBIT)
      (ACTION ILL-ROOM-F)>

<ROUTINE ILL-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the stationery section">
		<COND (<NOT <FSET? ,LOCKS-DOOR ,INVISIBLE>>
		       <TELL 
". At one end of the aisle is a door">)>
		<TELL ".">)>>

;"called from aisle-f too"
<ROUTINE ILL-ROOM-EXIT ()
	 <COND (<NOT <FSET? ,QUARTZ ,RMUNGBIT>>
		<CANT-SEE <> "door">
		<RFALSE>)
	       (<NOT <FSET? ,LOCKS-DOOR ,OPENBIT>>
		<DO-FIRST "open" ,LOCKS-DOOR>
		<RFALSE>)
	       (T
		<TELL "You walk down the rickety stairs." CR CR>
		<GOTO ,CELLAR-ROOM>
		<RFALSE>)>>

<OBJECT ILL-SHELF
	(LOC ILL-ROOM)
	(DESC "shelf")
	(SYNONYM SHELF SHELVES)
	(FLAGS SURFACEBIT SEARCHBIT OPENBIT CONTBIT NDESCBIT)
	(CAPACITY 300)
	;(ACTION SHELF-F)>

<OBJECT FLOUR
	(LOC ILL-ROOM)
	(OLDDESC "flour")
	(NEWDESC "flower")
	(FDESC 
"Powdery white flour has been spilled onto the floor alongside the shelves.")
	(OLD-TO-NEW
"The white powder drifts away like the shifting sands of the desert -- in its
place, a flower.")
	(DESCFCN FLOUR-F)
	(SYNONYM FLOUR FLOWER FLOWERS POWDER DUNE)
	(ADJECTIVE WHITE)
	(FLAGS TAKEBIT OLDBIT ;CONTBIT ;OPENBIT SEARCHBIT)
	(CAPACITY 1)
	(ACTION FLOUR-F)>

<ROUTINE FLOUR-F ("OPTIONAL" (OARG <>))
	 <COND (<NOT <VISIBLE? ,FLOUR>>
		<RFALSE>)
	       (<OR <NOUN-USED ,FLOUR ,W?FLOUR ,W?POWDER ,W?DUNE>
		    <ADJ-USED ,FLOUR ,W?WHITE>>
		;<FSET ,FLOUR ,OLDBIT>
		<FCLEAR ,FLOUR ,CONTBIT>
		<FSET ,FLOUR ,NOA>
		<FCLEAR ,FLOUR ,OPENBIT>
		<COND (<IN? ,SCENT ,FLOUR>
		       <FSET ,SCENT ,INVISIBLE>)>
		<COND (<HELD? ,FLOUR>
		       <SETG TRANS-PRINTED T>
		       <MOVE ,FLOUR ,HERE>
		       <TELL 
"The white powder spills between your fingers onto the " D ,GROUND ,PERIOD>
		       <FSET ,FLOUR ,OLDBIT>
		       <COND (<VERB? GIVE DROP THROW PUT THROW-TO>
			      <RTRUE>)>)
		      (<NOT <FSET? ,FLOUR ,OLDBIT>>
		       <SETG TRANS-PRINTED T>
		       <TELL 
"The delicate flower \"disintigrates\" into a dune of white powder." CR>)>
		 <FSET ,FLOUR ,OLDBIT>)
	       (<AND <NOUN-USED ,FLOUR ,W?FLOWER ,W?FLOWERS>
		     <TRANS-PRINT ,FLOUR>>
		<FCLEAR ,FLOUR ,OLDBIT>
		<FCLEAR ,FLOUR ,NOA>
		<FSET ,FLOUR ,TOUCHBIT>
		<FSET ,FLOUR ,OPENBIT>
		<FSET ,FLOUR ,CONTBIT>
		<COND (<IN? ,SCENT ,LOCAL-GLOBALS>
		       <MOVE ,SCENT ,FLOUR>)
		      (<IN? ,SCENT ,FLOUR>
		       <FCLEAR ,SCENT ,INVISIBLE>)>)>
	 <COND (<FSET? ,FLOUR ,OLDBIT>
		<COND ;(<VERB? OPEN>
		       <TELL 
"The tamper-proof packaging is too good." CR>)
		      (<VERB? SMELL TAKE>		       
		       <SETG ORPHAN-FLAG ,FLOUR>
		       <QUEUE I-ORPHAN 2>
		       <TELL 
"You lean down to the fine white powder. \"Ahhh... aahhh... aahhhh...\"" CR>
		       <RFATAL>)>)
	        ;"flower"
	        ;"only cent can be put in flower, size 1"
	       (<VERB? SMELL>
		<COND (<IN? ,SCENT ,FLOUR>
		       <PERFORM ,V?LOOK-INSIDE ,FLOUR>
		       <RTRUE>)
		      (T
		       <TELL 
"The " D ,FLOUR ", once fragrant, now has no scent." CR>)>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<IN? ,SCENT ,FLOUR>
		       <TELL "The " D ,FLOUR " contains">
		       <COND (<NOT <D-NOTHING>>
		       	      <TELL ,PERIOD>)>
		       <RTRUE>)
		      (T
		       <FCLEAR ,FLOUR ,CONTBIT>
		       <V-EXAMINE>
		       <FSET ,FLOUR ,CONTBIT>
		       <RTRUE>)>)>>

<OBJECT SCENT
	(LOC LOCAL-GLOBALS)
	(OLDDESC "wonderful scent")
	(NEWDESC "cent")
	(OLD-TO-NEW "You can hear it -- the penny drops.")
	(NEW-TO-OLD "From richer to poorer -- but better smelling...")
	(SYNONYM SCENT CENT PENNY CENTS)
	(ADJECTIVE WONDERFUL)
	(FLAGS OLDBIT TRYTAKEBIT TAKEBIT)
	(SIZE 1)
	(ACTION SCENT-F)>

<ROUTINE SCENT-F ()
	 <COND (<AND <OR <NOUN-USED ,SCENT ,W?SCENT>
		         <ADJ-USED ,SCENT ,W?WONDERFUL>>
		     <TRANS-PRINT ,SCENT T>>
		<FSET ,SCENT ,TRYTAKEBIT>)
	       (<AND <NOUN-USED ,SCENT ,W?CENT ,W?PENNY>
		     <TRANS-PRINT ,SCENT>>
		<FCLEAR ,SCENT ,TRYTAKEBIT>)>
	 <COND (<FSET? ,SCENT ,OLDBIT>
	        <COND (<AND <PRSO? ,SCENT>
			    <VERB? TAKE PUT GIVE THROW DROP PUT-THROUGH>>
		       <TELL 
"The " D ,SCENT " is to have, and not to hold." CR>
		       <RTRUE>)>)>
	       ;"cent"
	       ;(<VERB?  >)>

<OBJECT BEAR-CLAUSE
	(LOC ILL-SHELF)
	(OLDDESC "bear clause")
	(NEWDESC "bear claws")
	(OLD-TO-NEW
"The paper dries up and blows away, replaced by -- bear claws!")
	(NEW-TO-OLD
"The hairy fist clenches itself so tightly that it becomes two-dimensional 
-- paper.") 	 
	(SYNONYM CLAUSE CLAWS CLAW PAIR PIECE PAPER)
	(ADJECTIVE BEAR BRITTLE YELLOWING YELLOW)
	(FLAGS TAKEBIT ;PLURALBIT OLDBIT)
	(ACTION BEAR-CLAUSE-F)>

<ROUTINE BEAR-CLAUSE-F ()
	 <COND (<AND <NOUN-USED ,BEAR-CLAUSE ,W?PAIR ,W?CLAW ,W?CLAWS>
		     <TRANS-PRINT ,BEAR-CLAUSE>>
		<FSET ,BEAR-CLAUSE ,PLURALBIT>)
	       (<AND <OR <ADJ-USED ,BEAR-CLAUSE ,W?BRITTLE ,W?YELLOWING
				       	        ,W?YELLOW>
		         <NOUN-USED ,BEAR-CLAUSE ,W?CLAUSE>>
		     <TRANS-PRINT ,BEAR-CLAUSE T>>
		<FCLEAR ,BEAR-CLAUSE ,PLURALBIT>)>
	 <COND (<FSET? ,BEAR-CLAUSE ,OLDBIT>
		<COND (<VERB? READ EXAMINE>
		       <TELL 
"Written on a brittle, yellowing piece of paper are the words:|
|
\"A well regulated Militia, being necessary to the security of a free State,
the right of the people to keep and arm Bears, shall not be infringed.\"" CR>)>)
	        ;"claws"
	       (<VERB? EXAMINE>
		<TELL "These are bear claws, the food." CR>
		;<TELL
"These are a pair of actual, menacing " D ,BEAR-CLAUSE ,PERIOD>)
	       (<VERB? EAT>
		<TELL "The knuckle sandwich is not palatable." CR>)>>
		
<OBJECT STATIONARY
	(LOC ILL-SHELF)
	(OLDDESC "large block of stationary")
	(NEWDESC "reams of stationery")
	(OLD-TO-NEW
"The floor of the aisle rumbles and the shelf bounces a few inches off
its foundation, as the \"stationary\" takes on the markings of many reams of
stationery bundled together.")
	(NEW-TO-OLD
"The reams of paper give off smoke as they mutate into something
large and quite stationary.") 
	(SYNONYM STATIONARY STATIONERY PAPER REAMS REAM BLOCK)
	(ADJECTIVE LARGE)
	(FLAGS OLDBIT TRYTAKEBIT ;PLURALBIT)
	(ACTION STATIONARY-F)>

<ROUTINE STATIONARY-F ()
	 <COND (<AND <NOUN-USED ,STATIONARY ,W?STATIONARY ,W?BLOCK>
		     <TRANS-PRINT ,STATIONARY T>>
		<FCLEAR ,STATIONARY ,PLURALBIT>)
	       (<AND <NOUN-USED ,STATIONARY ,W?STATIONERY ,W?REAMS ,W?REAM>
		     <TRANS-PRINT ,STATIONARY>>
	        <FSET ,STATIONARY ,PLURALBIT>)>
	 <COND (<FSET? ,STATIONARY ,OLDBIT>
		<COND (<VERB? TAKE MOVE>
		       <TELL 
			"Being stationary, it can't be moved">
		       <COND (<AND <HELD? ,MUSSELS>
				   <NOT <FSET? ,MUSSELS ,OLDBIT>>>
			      <TELL ", even by your " D ,MUSSELS>)>
		       <TELL ,PERIOD>)>)
	       (<VERB? TAKE MOVE>
		<TELL 
"The bundled stationery is too heavy to be moved, and doesn't need to
be." CR>)>>

<OBJECT QUARTZ
	(LOC ILL-ROOM)
	(OLDDESC "solid wall of quartz")
	(NEWDESC "quarts")
	(OLD-TO-NEW 
"The surface of the wall crumbles away, revealing a tall and wide stack of
quarts.")
	(NEW-TO-OLD
"The quarts seem to petrify into rock.")	 	
	(SYNONYM QUARTZ SOLID WALL STACK QUARTS QUART PILE RUBBLE)
	(ADJECTIVE WIDE TALL SOLID)
	(DESCFCN QUARTZ-F)
	(FLAGS OLDBIT TRYTAKEBIT)
	(ACTION QUARTZ-F)>

<ROUTINE QUARTZ-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL CR "The far end of the aisle ">
		<COND (<FSET? ,QUARTZ ,RMUNGBIT>
		       <TELL "is strewn with ">
		       <COND (<FSET? ,QUARTZ ,OLDBIT>
			      <TELL "rubble">)
			     (T
			      <TELL "quarts">)>)
		      (T
		       <TELL
"appears to be blocked off by a ">
		       <COND (<NOT <FSET? ,QUARTZ ,OLDBIT>>
			      <TELL "tall stack of ">)>
		       <TELL D ,QUARTZ>)>
		<TELL ".">
	        <RTRUE>)
	       (<AND <NOUN-USED ,QUARTZ ,W?RUBBLE>
		     <NOT <FSET? ,QUARTZ ,RMUNGBIT>>>
		<CANT-SEE <> "rubble">
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,QUARTZ ,W?QUARTZ>
		         <ADJ-USED ,QUARTZ ,W?SOLID>>
		     <TRANS-PRINT ,QUARTZ T>>
		<FCLEAR ,QUARTZ ,PLURALBIT>)
	       (<AND <FSET? ,QUARTZ ,OLDBIT>
		     <FSET? ,QUARTZ ,RMUNGBIT>
		     <NOUN-USED ,QUARTZ ,W?QUART ,W?QUARTS ,W?STACK>>
		<TELL "The rubble remains unmoved." CR>
		<RTRUE>)
	       (<AND <NOUN-USED ,QUARTZ ,W?QUART ,W?QUARTS ,W?STACK>
		     <TRANS-PRINT ,QUARTZ>>
		<COND (<FSET? ,QUARTZ ,RMUNGBIT>
		       <FCLEAR ,LOCKS-DOOR ,INVISIBLE>)>
		<FSET ,QUARTZ ,PLURALBIT>)>
	 <COND (<NOT <FSET? ,QUARTZ ,OLDBIT>>
		<COND (<VERB? MOVE PUSH TAKE REMOVE KILL>
		       <COND (<FSET? ,QUARTZ ,RMUNGBIT>
			      <TELL 
"The barrier has already been removed">)
			     (T
			      <FSET ,QUARTZ ,RMUNGBIT>
			      <FCLEAR ,LOCKS-DOOR ,INVISIBLE>
			      <FCLEAR ,LOCKS ,INVISIBLE>
			      <PUTP ,QUARTZ ,P?OLDDESC "quartz">
			      <FCLEAR ,JAMB ,INVISIBLE>
			      <TELL
"The stack of " D ,QUARTZ " weaves sideways like a drunk and then comes
tumbling down in a short, rumbling avalanche. A door behind the quarts is
revealed">)>
		       <TELL ,PERIOD>)
		      (<VERB? EXAMINE READ>
		       <TELL 
"These generic containers are each labeled with the word \"quart.\"">
		       <COND (<NOT <FSET? ,QUARTZ ,RMUNGBIT>>
			      <TELL
" The stack is covering the entire wall.">)>
		       <CRLF>)
		      (<VERB? OPEN DRINK LOOK-INSIDE>
		       <TELL 
"The liquid inside seems not pasteurized, but petrified." CR>)>)
	       ;"quartz the rock"
	       (<VERB? EXAMINE>
		<TELL "The " D ,QUARTZ>
		<COND (<FSET? ,QUARTZ ,RMUNGBIT>
		       <TELL ", now in rubble,">)>
	        <TELL
" is colored in lavenders, blues and pearly whites." CR>)
	       (<VERB? TOUCH RUB KILL PUSH REMOVE>
		<TELL "It's hard as a rock." CR>)>>

<OBJECT LOCKS-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "door")
	(SYNONYM DOOR)
	(FLAGS DOORBIT INVISIBLE NDESCBIT ;LOCKEDBIT)
	(ACTION LOCKS-DOOR-F)>

<ROUTINE LOCKS-DOOR-F ()
	 <COND (<AND <VERB? UNLOCK>
		     <NOT <EQUAL? ,P-PRSA-WORD ,W?UNLOX>>
		     <NOT <FSET? ,LOCKS ,RMUNGBIT>>
		     <FSET? ,LOCKS ,OLDBIT>>
		<TELL "There's no key to this problem of locks." CR>)
	       (<AND <VERB? LOCK>
		     <NOT <FSET? ,LOCKS ,RMUNGBIT>>
		     <FSET? ,LOCKS ,OLDBIT>>
		<TELL "It's already locked." CR>) 
	       (<VERB? OPEN>
		<COND (<NOT <FSET? ,LOCKS ,RMUNGBIT>>
		       <COND (<FSET? ,LOCKS ,OLDBIT>
			      <TELL 
"It's easy to see why the door won't open: ">
			      <PERFORM ,V?EXAMINE ,LOCKS-DOOR>
			      <RTRUE>)
			     (T
			      <TELL "The " D ,LOCKS-DOOR " is loxed." CR>)>)
		      (<FSET? ,JAMB ,OLDBIT>
		       <TELL  "Although you tug your hardest, you can
see the door jamb is too tight against the door." CR>)
		      (T
		       <SETG OLD-HERE <>>
		       <RFALSE>)>)
	       (<VERB? EXAMINE>
		<COND (<NOT <FSET? ,LOCKS ,RMUNGBIT>> ;"not removed"
		       <TELL "It's lined with ">
		       <COND (<FSET? ,LOCKS ,OLDBIT>
			      <TELL "many different kinds of locks">)
			     (T
			      <TELL "lox">)>
		       <TELL ,PERIOD>)
		      (<FSET? ,JAMB ,OLDBIT>
		       <PERFORM ,V?EXAMINE ,JAMB>
		       <RTRUE>)>)
	       (<VERB? ENTER WALK-TO>
		<DO-WALK ,P?IN>
		<RTRUE>)>>
		      
<OBJECT LOCKS
	(LOC ILL-ROOM)
	(OLDDESC "locks")
	(NEWDESC "lox")
	(OLD-TO-NEW
"Smoke issues from each of the locks, as they turn into smoked salmon.")
	(NEW-TO-OLD
"Your vision wavers, and the salmon appears changed.")
	(SYNONYM LOCK LOCKS LOX SALMON)
	(ADJECTIVE SMOKED)
	(FLAGS OLDBIT INVISIBLE PLURALBIT NDESCBIT TAKEBIT TRYTAKEBIT)
	(ACTION LOCKS-F)>

;"rmungbit = lox (locks) is off door, can't reattach"

<ROUTINE LOCKS-F ()
	 <COND (<AND <NOUN-USED ,LOCKS ,W?LOCKS ,W?LOCK>
		     <TRANS-PRINT ,LOCKS T>>
		<FSET ,LOCKS ,PLURALBIT>
		<FCLEAR ,LOCKS ,NOA>)
	       (<AND <OR <NOUN-USED ,LOCKS ,W?LOX ,W?SALMON>
		         <ADJ-USED ,LOCKS ,W?SMOKED>>
		     <TRANS-PRINT ,LOCKS>>
		<FCLEAR ,LOCKS ,TRYTAKEBIT>
		<FCLEAR ,LOCKS ,PLURALBIT>
		<FSET ,LOCKS ,NOA>)>
	 <COND ;"both"
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,LOCKS-DOOR>>
		<TELL "The " D ,LOCKS " won't reattach." CR>)
	       ;"locks"
	       (<FSET? ,LOCKS ,OLDBIT>
		<COND (<VERB? PICK UNLOCK>
		       <TELL "There's no key to these locks." CR>)
		      (<VERB? TAKE>
		       <TELL "They're strongly attached to the door." CR>)>)
	        ;"lox"
	       (<VERB? EAT>
		<REMOVE ,LOCKS>
		<TELL "You ">
		<COND (<NOT <FSET? ,LOCKS ,RMUNGBIT>>
		       <FSET ,LOCKS ,RMUNGBIT>
		       <TELL "\"unlox\" the door as you ">)>
		<TELL 
"fill your belly with the warmth of smoked salmon." CR>)
	       (<AND <VERB? TAKE REMOVE TAKE-OFF MOVE>
		     <NOT <FSET? ,LOCKS ,RMUNGBIT>>
		     ;<EQUAL? <ITAKE> T>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<FSET ,LOCKS ,RMUNGBIT>
		<TELL 
"You \"unlox\" the door by gathering the smoked salmon." CR>)>>

<OBJECT JAMB
	(LOC ILL-ROOM)
	(OLDDESC "jamb")
	(NEWDESC "pool of hot, fresh strawberry jam")
	(OLD-TO-NEW
"The outline of the door smokes, and hot fresh jam oozes out from the outline
of the door onto the floor.")
	;(NEW-TO-OLD
"As if in a film running backward, the jam oozes back up and into the door
frame.")
	(SYNONYM JAM JAMB POOL)
	(ADJECTIVE DOOR HOT FRESH STRAWBERRY)
	(FLAGS OLDBIT INVISIBLE NDESCBIT TRYTAKEBIT)
	(ACTION JAMB-F)>

<ROUTINE JAMB-F ()
	 <COND (<AND <NOUN-USED ,JAMB ,W?JAMB>		
	             <NOT <FSET? ,JAMB ,OLDBIT>>>
		<TELL 
"The strawberry jam bubbles a bit, but that's all." CR>
		<RTRUE>)
	       (<AND <OR <NOUN-USED ,JAMB ,W?JAM ,W?POOL>
		         <ADJ-USED ,W?HOT ,W?FRESH ,W?STRAWBERRY>>
		     <TRANS-PRINT ,JAMB>>
		<FCLEAR ,JAMB ,NDESCBIT>
		;<FSET ,JAMB ,TRYTAKEBIT>)>
	 <COND (<FSET? ,JAMB ,OLDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL "The door jamb is tight against the door." CR>)>)
	       ;"jam"
	       (<VERB? EAT>
		<TELL "The sample is nice and tasty." CR>)
	       (<VERB? TAKE>
		     ;<EQUAL? <ITAKE> T>
		<TELL 
		 "The hot jam oozes between your fingers." CR>)>>
	       
<ROOM CELLAR-ROOM
      (LOC ROOMS)
      (DESC "Cellar")
      (GLOBAL AISLE LOCKS-DOOR)
      (FLAGS INDOORSBIT)
      (OUT TO ILL-ROOM IF LOCKS-DOOR IS OPEN)
      (IN TO ILL-ROOM IF LOCKS-DOOR IS OPEN)
      (UP TO ILL-ROOM IF LOCKS-DOOR IS OPEN)
      (ACTION CELLAR-ROOM-F)>

<ROUTINE CELLAR-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"This is the empty cellar of the market.">)
	       ;(<EQUAL? .RARG ,M-ENTER>
		<TELL "You descend some rickety stairs." CR CR>)>>

<OBJECT CELLAR
	(LOC CELLAR-ROOM)
	(OLDDESC "cellar")
	(NEWDESC "seller")
	(LDESC "A seller stands here.")
	(OLD-TO-NEW
"The room starts spinning madly around, the four walls begin to close
in on you. When it finally slows enough for you to open your eyes, you see a woman wearing a store uniform.") 
	(NEW-TO-OLD
"The clerk's body becomes cubist, expands, and engulfs you.")
	(SYNONYM CELLAR SELLER WOMAN LADY)
	;(ADJECTIVE DARK)
	(FLAGS OLDBIT NDESCBIT FEMALEBIT)
	(ACTION CELLAR-F)>

<ROUTINE CELLAR-F ()
	 <COND (<AND <NOUN-USED ,CELLAR ,W?CELLAR>
		     <TRANS-PRINT ,CELLAR T>>
		<FSET ,CELLAR ,NDESCBIT>
		<FCLEAR ,CELLAR ,ACTORBIT>
		<RTRUE>)
	       (<AND <NOUN-USED ,CELLAR ,W?SELLER>
		     <TRANS-PRINT ,CELLAR <> T>> ;"No CR's after trans"
		<CRLF>
		<FSET ,CELLAR ,ACTORBIT>
		<FCLEAR ,CELLAR ,NDESCBIT>
		<RTRUE>)>
	 <COND (<FSET? ,CELLAR ,OLDBIT>	        
		<COND (<VERB? EXAMINE>
		       <V-LOOK>)>)
	       ;"seller"
	       (<VERB? TELL>
		<TELL 
"\"Don't bother me unless you want to buy something.\"" CR>
		<STOP>)>>