"NORTH for
		            NORD AND BERT
       (c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"scene is JOAT"

<ROOM JACKVILLE
      (LOC ROOMS)
      (DESC "Jackville")
      (LDESC 
"You have come upon a region far to the north of Punster, but still within
the realm of possibilities. A simple wood-plank house stands near.")
      (OUT PER FOREST-ENTER)
      (GLOBAL JACK-HOUSE)
      (IN TO JACK-ROOM)>

<ROUTINE FOREST-ENTER ()
	 <COND (<FSET? ,JACK-ROOM ,TOUCHBIT>
		<TELL 
"You walk along the trail a long way. With each uncertain
step you take, it grows darker. Clouds gather. With large puffy white cheeks,
they blow noisy cold across the sky, as will happen in this changeable
realm." CR CR>
		<QUEUE I-FROST -1>
		<RETURN ,FROST-ROOM>)
	       (T
		<TELL 
"You follow a twisty path under the canopy of the forest. After losing all
sense of direction, you end up back here." CR CR>
		<RETURN ,JACKVILLE>)>>	       

<OBJECT JACK-HOUSE
	(LOC LOCAL-GLOBALS)
	(DESC "house that Jack built")
	(SYNONYM HOUSE JACK BUILT)
	(ADJECTIVE JACK)
	(FLAGS NDESCBIT)
	(ACTION JACK-HOUSE-F)>

<ROUTINE JACK-HOUSE-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,JACK-ROOM>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,JACKVILLE>
		       <DO-WALK ,P?IN>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,JACK-ROOM>
		       <DO-WALK ,P?OUT>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,JACK-ROOM>>
		<V-LOOK>)>>

<ROOM JACK-ROOM
      (LOC ROOMS)
      (DESC "Inside House")
      (LDESC
"This drafty one-room cabin is so sparsely furnished as to be completely
unfurnished. It looks like it has not been lived in for years and years.")
      (GLOBAL JACK-HOUSE)
      (FLAGS INDOORSBIT) 
      (OUT TO JACKVILLE)
      (ACTION JACK-ROOM-F)>

<ROUTINE JACK-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,JOAT ,TOUCHBIT>>>
		<THIS-IS-IT ,JOAT>)>>
		  

<OBJECT JOAT
	(LOC JACK-ROOM)
	(DESC "Jack of all Traits")
	(PICK-IT "Play Jacks")
	(MAX-SCORE 11 ;10)
	(SCENE-SCORE 0)
	(SCENE-ROOM JACKVILLE)
	(SCENE-CUR 0)
	(FDESC 
"There is a strange contraption leaning against one of the wood-plank walls.")
	(SYNONYM CONTRAPTION JACK TRAITS TRADES TRAIT CLOTH THING JOAT)	
	(ADJECTIVE STRANGE SQUARE SQARISH LONG LONGISH THICK)
	(FLAGS TAKEBIT OPENBIT SEARCHBIT CONTBIT WEARBIT NO-D-CONT)
	(GENERIC GEN-JACK)
	(ACTION JOAT-F)>
 
<ROUTINE JOAT-F ()
	 <COND (<AND <IN? ,JOAT ,GLOBAL-OBJECTS>
		     <VISIBLE? ,JACK-IS>>
		<CHANGE-OBJECT ,JOAT ,JACK-IS> 
		<RTRUE>) 
	       (<AND <VERB? RUB TOUCH>
		     <IN? ,BALL-OF-FUR ,JOAT>>
		<CHANGE-OBJECT ,JOAT ,BALL-OF-FUR>
		<RTRUE>)
	       (<VERB? WEAR>
		<CHANGE-OBJECT ,JOAT ,SLEEVES>
		<RTRUE>)
	       (<VERB? OPEN>
		<CHANGE-OBJECT ,JOAT ,PIECE-OF-METAL>
		<RTRUE>)
	       (<VERB? ON SET CLOSE>
		<BE-MORE-SPECIFIC>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL  
"You can see right away it's versatile.|
|
It's sort of squarish, but sort of longish too">
		<COND (<IN? ,BALL-OF-FUR ,JOAT>
		       <TELL 
" and has a fluffy ball of cottony fur at one end">)>
		<TELL 
". Its surface is made of thick cloth, except for one edge
which is a long piece of metal that looks as if it can be pulled out.|
|
On three different sides of the strange contraption you
can see a hand crank, a water faucet, and an electrical switch. As if all that
wasn't enough, there is also a pair of sleeves sticking out of the thing." CR>)>>

<ROUTINE CHANGE-JACK ("OPTIONAL" (OBJ <>)) 
	 <COND (<NOT ,JACK-IS>
		<COND (<NOT <FSET? .OBJ ,PHRASEBIT>>
		       <FSET .OBJ ,PHRASEBIT>
		       <UPDATE-SCORE>)> ;"will get two points if using first 
					  time and for right thing"
		<FCLEAR .OBJ ,INTEGRALBIT>		
		<FSET .OBJ ,TAKEBIT>
		<SETG JACK-IS .OBJ>
		<MOVE .OBJ <LOC ,JOAT>>
		<MOVE ,JOAT ,LOCAL-GLOBALS>
		<RTRUE>)
	       (<NOT .OBJ>     ;"change back to joat"
		<COND (<EQUAL? ,JACK-IS ,FAUCET>
		       <MOVE ,JOAT <LOC ,HOT-TUB>>)
		      (T
		       <MOVE ,JOAT <LOC ,JACK-IS>>)>
		<FSET ,JACK-IS ,INTEGRALBIT>
		<FCLEAR ,JACK-IS ,TAKEBIT>
		<MOVE ,JACK-IS ,JOAT>
		<SETG JACK-IS <>>)
	       (T
		<RFALSE>)>>

<GLOBAL JACK-IS <>> ;"the object that joat is currently, or false"

<ROUTINE NO-JACK-HERE (OBJ "OPTIONAL" (N1 <>) (N2 <>) (N3 <>)
	 		   "AUX" STR)
	 <SET STR <GETP .OBJ ,P?JACKDESC>>
	 <COND (<DONT-HANDLE .OBJ>
		<RFALSE>)
	       (<AND <NOUN-USED .OBJ .N1 .N2 .N3>
		     <NOT ,JACK-IS>>
		<TELL 
"While the " D ,JOAT " has the potential to be a " .STR
", it is not yet one." CR>)
	       (<AND ,JACK-IS
		     <NOT <EQUAL? ,JACK-IS .OBJ>>>
		<CANT-SEE <> .STR>)
	       (T
		<RFALSE>)>>

<OBJECT BALL-OF-FUR
	(LOC JOAT)
	(DESC "ball of fur")
	(JACKDESC "jackrabbit")
	(SYNONYM BALL FUR BUNNY RABBIT JACKRABBIT TAIL)
	(ADJECTIVE COTTONY JACK BUNNY)
	(FLAGS ;NDESCBIT INTEGRALBIT)
	(ACTION BALL-OF-FUR-F)>

<ROUTINE BALL-OF-FUR-F ()
	 <COND (<VERB? TOUCH RUB MOVE TAKE>
		<COND ;(<EQUAL? ,JACK-IS ,BALL-OF-FUR>
		       <TELL "He likes it." CR>)
		      (;<CHANGE-JACK ,BALL-OF-FUR>
		       <NOT ,JACK-IS>
		       <REMOVE ,BALL-OF-FUR>
		       <UPDATE-SCORE>	       
		       <TELL  "The ball of fur twitches excitedly for a
moment. Suddenly the " D ,JOAT " seems to give birth as a full-grown
jackrabbit is ejected from the contraption. His metabolism, following
its winter of cooped-up discontent, seems to be racing away. But the
furry mammal itself remains at your feet, all atremble. He pauses to look
up at you. To the extent that his beady red eyes are able to emote, he
seems to express gratitude. Then, with a jackrabbit start, he is gone." CR>)>)
		       
;<"as the other features
of the " D ,JOAT " seem to become blurry and indistinct and fade away like
a mirage. You blink your eyes and shake your head, and as your vision clears,
you feel a jackrabbit squirming in your hands." CR>
	       (<NO-JACK-HERE ,BALL-OF-FUR ,W?BUNNY ,W?RABBIT
			                             ,W?JACKRABBIT>
		<RTRUE>)>>  

<OBJECT PIECE-OF-METAL
	(LOC JOAT)
	(DESC "long piece of metal")
	(SYNONYM PIECE METAL JACK JACKKNIFE KNIFE BLADE)
	(JACKDESC "jackknife")
	(ADJECTIVE LONG JACK)
	(FLAGS ;NDESCBIT INTEGRALBIT)
	(ACTION PIECE-OF-METAL-F)>
	       
<ROUTINE PIECE-OF-METAL-F ()
	 <COND (<VERB? OPEN REMOVE MOVE>
		<COND ;(<EQUAL? ,JACK-IS ,PIECE-OF-METAL>
		       <TELL "It is">)
		      (<CHANGE-JACK ,PIECE-OF-METAL>
		       <FSET ,PIECE-OF-METAL ,OPENBIT>
		       <TELL
"The long piece of metal, in reality the glistening, razor-sharp blade of a
jackknife, pivots out of its handle and with a \"snap!\" all the other
features of the " D ,JOAT " vanish." CR>)>)
	       (<AND <VERB? CLOSE>
		     <EQUAL? ,JACK-IS ,PIECE-OF-METAL>>
		<CHANGE-JACK>
		<TELL 
"Being careful that you don't lop off any fingers, you pivot the blade back
and it closes with a \"snap!\" All the other dimensions of the " D ,JOAT "
return." CR>) 
	       (<NO-JACK-HERE ,PIECE-OF-METAL ,W?JACKKNIFE
					      ,W?KNIFE>
		<RTRUE>)
	       (<AND <VERB? CUT>
		     <PRSI? ,PIECE-OF-METAL>>
		<COND (<PRSO? ,FISHING-LINE>
		       <REMOVE ,FISHING-LINE>
		       <UPDATE-SCORE>
		       <TELL
"Taking care not to fillet the fishy end of the mermaid, you slice away the "
D ,FISHING-LINE ", which blows away like a tumbleweed over the ">
		       <COND (<EQUAL? ,HERE ,POND-ROOM>
			      <TELL "surface of the frozen pond">)
			     (T
			      <TELL "snow">)>
		       <MERMAID-LEAVES>
		       <TELL ,PERIOD>
		       <RTRUE>)			        
		      (T
		       <TELL "Now you're a real cut up, aren't you">)>
		<TELL ,PERIOD>)>>

<OBJECT CRANK
	(LOC JOAT)
	(DESC "hand crank")
	(JACKDESC "jack-in-the-box")
	(SYNONYM CRANK BOX JACK-IN-THE-BOX CLOWN JESTER LID JACK)
	(ADJECTIVE HAND)
	(FLAGS ;NDESCBIT INTEGRALBIT)
	(GENERIC GEN-JACK)
	(ACTION CRANK-F)>

<ROUTINE CRANK-F ()
	 <COND (<VERB? SET>
		<COND (<CHANGE-JACK ,CRANK>
		       <FSET ,CRANK ,OPENBIT>
		       <TELL
"The " D ,JOAT " begins to play a simple plunkety tune, and as the music
becomes louder and louder the strange contraption starts looking a lot more like a box and a
lot less like anything else, and the music gets louder and louder until...|
|
\"Pop!\"|
|
The lid springs open and a jester rears its jolly head.|
|
\"Boing... Boing\"" CR>
		       <COND (<IN? ,FROST ,HERE>
			      <REMOVE ,FROST>
			      <UPDATE-SCORE> ;"also in change-jack rout."
			      <TELL CR
"The jester winks at the frozen old man, and you can almost hear the rushing
torrent of flood waters coming from deep within the heart of " D ,FROST
". Some human color suddenly rushes into his cheeks in a flush, reddening his
face and thawing the frown into much dripping and wetness, which can scarcely
be distinguished from tears of happiness.|
|
Under a sunny disposition, a more quick and nimble Jack frolics down the path,
making instant puddles out of his domain wherever he treads." CR>)
			     (<VISIBLE? ,MERMAID>
			      <TELL CR 
"The mermaid merely smiles weakly." CR>)>
		       <RTRUE>)
		      (<EQUAL? ,JACK-IS ,CRANK> ;"lid is open"
		       <TELL 
"As you rotate the crank, the box emits a plunkety, off-key tune." CR>)>) 
	       (<OR <AND <VERB? CLOSE>
		         <EQUAL? ,JACK-IS ,CRANK>>
		    <AND <VERB? PUT>
			 <PRSO? ,PRSI>
			 <EQUAL? ,JACK-IS ,CRANK>>>
		<CHANGE-JACK>
		<TELL 
"You can almost swear that the jester winks at you as his head is lowered
into the box and the lid is shut with a \"Click.\" All the other features of
the " D ,JOAT " come back." CR>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <EQUAL? ,JACK-IS ,CRANK>>
		<TELL 
"A grinning jester boings around through the open lid of the box." CR>)
	       (<NO-JACK-HERE ,CRANK ,W?JACK-IN-THE-BOX
			             ,W?JESTER ,W?BOX>
		<RTRUE>)
	       (<NO-JACK-HERE ,CRANK ,W?CLOWN ,W?LID>
		<RTRUE>)>> 

<OBJECT FAUCET
	(LOC JOAT)
	(DESC "water faucet")
	(JACKDESC "Jacuzzi")
	(SYNONYM FAUCET JACUZZI)
	(ADJECTIVE WATER)
	(FLAGS ;NDESCBIT INTEGRALBIT)
	(ACTION FAUCET-F)>

;"RMUNGBIT = SCORE FOR TURN ON WITH MERMAID"

<ROUTINE FAUCET-F ()
	 <COND (<VERB? SET ON OPEN>
		<COND (<EQUAL? ,HERE ,FROST-ROOM>
		       <TELL
"The pipes must be frozen, since nothing comes out of the faucet." CR>)
		      (<CHANGE-JACK ,FAUCET>
		       <REMOVE ,FAUCET>
		       <MOVE ,TUB-WATER ,HERE>
		       <MOVE ,HOT-TUB ,HERE> ;"tub has faucet syns."
		       <MOVE ,PROTAGONIST ,HOT-TUB>
		       <SETG OLD-HERE <>>
		       <TELL
"There is a deep gurgling sound, then scalding hot water begins gushing out
of the faucet, and you are surrounded by a thick cloud of steam. As the steam
begins to thin out, you find yourself leaning back in a hot tub with Jacuzzi,
and you can't remember when being in hot water ever felt so good">
		       <COND (<IN? ,MERMAID ,HERE>
			      <COND (<NOT <FSET? ,FAUCET ,RMUNGBIT>>
				     <FSET ,FAUCET ,RMUNGBIT>
				     <UPDATE-SCORE>)>
			      <MOVE ,MERMAID ,HOT-TUB>
			      <SETG MERMAID-WARM T>
			      <TELL ".||
The mermaid is also in the hot tub, smiling with her eyes closed as
she swims ">
			      <COND (<IN? ,FISHING-LINE ,MERMAID>
				     <TELL "with some difficulty">)
				    (T
				     <TELL "luxuriously">)>
			      <TELL " through the water">)>
		       <TELL ,PERIOD>)>)
	       (<VERB? OFF CLOSE>
		<TELL "It's not on." CR>)
	       (<NO-JACK-HERE ,FAUCET ,W?JACUZZI ;,W?TUB>
		<RTRUE>)>>

<GLOBAL MERMAID-WARM <>>

<OBJECT HOT-TUB
	(DESC "hot tub")
	(SYNONYM TUB PLUG JACUZZI FAUCET)
	(ADJECTIVE HOT WATER)	
	(FLAGS VEHBIT INBIT OPENBIT CONTBIT SEARCHBIT)
	(ACTION HOT-TUB-F)>
  
;"SEENBIT = got points for pulling plug"

;"you're in hot water"
<ROUTINE HOT-TUB-F ("OPT" (OARG <>))
	 <COND (.OARG
		<RFALSE>) ;"to stop m-begs from happening"
	       (<AND <VERB? MOVE REMOVE TAKE OPEN>
		     <NOUN-USED ,HOT-TUB ,W?PLUG>>
		<COND (<AND <NOT <FSET? ,HOT-TUB ,SEENBIT>>
			    <IN? ,MERMAID ,HOT-TUB>>
		       <UPDATE-SCORE>
		       <FSET ,HOT-TUB ,SEENBIT>)>
		<CHANGE-JACK>
		<REMOVE ,HOT-TUB>
		<REMOVE ,TUB-WATER>
		<MOVE ,PROTAGONIST ,HERE>
		<SETG OLD-HERE <>>
		<TELL 
"The water, slowly at first, begins to swirl toward the plug, creating a whirl
of water so loud that it's nightmarish. You close your eyes and cover your
ears and when you hear the last loud slurp you find yourself standing
again">
		<COND (<AND <IN? ,MERMAID ,HOT-TUB>
			    <NOT <IN? ,FISHING-LINE ,MERMAID>>>
		       <MERMAID-LEAVES>)
		      (<IN? ,MERMAID ,HOT-TUB>
		       <MOVE ,MERMAID ,HERE>
		       <TELL ,PERIOD>
		       <MERMAID-F ,M-OBJDESC>
		       <CRLF>
		       <RTRUE>)>
		<TELL ,PERIOD>)
	       (<VERB? OFF CLOSE SET ON>
		<TELL 
"The washerless faucet spins round, and some hot, steamy water gurgles
out." CR>)
	       ;(<VERB? OFF CLOSE>
		<TELL "You turn back the washerless faucet." CR>)
	       (<AND <VERB? DISEMBARK>
		     <IN? ,PROTAGONIST ,HOT-TUB>>
		<TELL 
"Your muscles and your mind have so relaxed from the immersion in the
steamy waters that you have not the power or the will to leave." CR>)
	       (<AND <VERB? LEAP ENTER SWIM WALK-AROUND>
		     <IN? ,PROTAGONIST ,HOT-TUB>
		     <NOT <FSET? ,HOT-TUB ,RMUNGBIT>>>
		<FSET ,HOT-TUB ,RMUNGBIT>
		<TELL
"In moving about the hot tub, your foot brushes against what feels to be a
plug at bottom of the steamy water." CR>)>>  

<OBJECT TUB-WATER
	;(LOC LOCAL-GLOBALS)
	(DESC "water")
	(SYNONYM WATER)	
	(ADJECTIVE HOT)
	(FLAGS NARTICLEBIT NDESCBIT)
	(ACTION WATER-F)>

<OBJECT ELECTRICAL-SWITCH
	(LOC JOAT)
	(DESC "electrical switch")
	(JACKDESC "jackhammer")
	(SYNONYM SWITCH JACKHAMMER HAMMER)
	(ADJECTIVE ELECTRICAL ELECTRIC JACK)
	(FLAGS ;NDESCBIT INTEGRALBIT LIGHTBIT)
	(ACTION ELECTRICAL-SWITCH-F)>

;"phrasebit = points gotten for turn it on"

<GLOBAL JACKHAMMER-C 0> ;"zero means it's off"

<ROUTINE ELECTRICAL-SWITCH-F ()
	 <COND (<NO-JACK-HERE ,ELECTRICAL-SWITCH 
			      ,W?JACKHAMMER ,W?HAMMER>
		<RTRUE>)
	       (<AND <VERB? THROW KILL ON SET MOVE PUSH>
		     <EQUAL? ,HERE ,POND-ROOM>
		     <FSET? ,ICE ,RMUNGBIT>>
		<TELL ,NICE-HOLE>
		<RTRUE>)
	       (<AND <VERB? THROW MUNG ON SET MOVE PUSH>
		     <CHANGE-JACK ,ELECTRICAL-SWITCH>>		
		<TELL
"\"Rata-tat-tat! Rata-rata-rata-rata Tat-tat-tat!\"">
		<COND (<EQUAL? ,HERE ,POND-ROOM>
		       <CHANGE-JACK> ;"back to joat"
		       <FSET ,MERMAID ,RMUNGBIT>
		       <MOVE ,MERMAID ,HERE>
		       <MOVE ,FISHING-LINE ,MERMAID>
		       <MOVE ,NECKLACE ,MERMAID>
		       <FSET ,ICE ,RMUNGBIT>
		       <TELL 
" Shiny shards of ice go flying out of the plume of exhaust created by the
jackhammer as you ride the roaring machine in a tight circle. Then the hammer
itself is pulverized back into the " D ,JOAT ".">
		       <TELL CR CR
"The engine exhaust lifts, revealing the sight of a blue-tinted mermaid lying
exhausted next to a hole in the ice.|
|
The mermaid wearily slaps her tail fin against the damp ice">)
		      (T
		       <INC JACKHAMMER-C> ;"to one"
		       <COND (<NOT <FSET? ,ELECTRICAL-SWITCH ,PHRASEBIT>>
			      <FSET ,ELECTRICAL-SWITCH ,PHRASEBIT>
			      <UPDATE-SCORE>)>
		       <PUTP ,PROTAGONIST ,P?ACTION ,PROTAG-JACKHAMMER-F>
		       <TELL  
" The " D ,JOAT " powerfully
roars to life as you hang on the wildly chugging " D ,ELECTRICAL-SWITCH " like a rodeo cowboy">)>
		<TELL ,PERIOD>)>>

<GLOBAL S-JACKHAMMER 
	<LTABLE 2 
"|
T   y   n      t      s   y       o   e   h   n   ?|
  r   i   g      o      a       s   m   t   i   g|"

"|
C   n   t      v   n      e   r      o   r   e   f      h   n   !|
  a   '      e   e      h   a      y   u   s   l      t   i   k   !|"

"|
J   s       t   r      o   f    t   i      j   c   h   m   e   !   !|
  u   t       u   n      f        h   s      a   k   a   m   r   !|">>

<OBJECT SLEEVES
	(LOC JOAT)
	(DESC "sleeves")
	(JACKDESC "jacket")
	(SYNONYM SLEEVES SLEEVE PAIR JACKET COAT)
	(FLAGS ;NDESCBIT PLURALBIT INTEGRALBIT WEARBIT)
	(ACTION SLEEVES-F)>

<ROUTINE SLEEVES-F ()
	 <COND (<AND <VERB? WEAR>
		     <NOT <FSET? ,SLEEVES ,WORNBIT>>
		     <CHANGE-JACK ,SLEEVES>>
		<MOVE ,SLEEVES ,PROTAGONIST>
		<FSET ,SLEEVES ,WORNBIT>
		<FCLEAR ,SLEEVES ,PLURALBIT>		
		<TELL
"As you slip on the jacket, you find that it fits you quite well. It feels
a lot more comfortable than it looks.">
		<COND (<EQUAL? ,HERE ,FROST-ROOM>
		       <SETG FROST-C 0>
		       ;<UPDATE-SCORE>
		       <TELL 
" It offers much shelter from the cold, which is now nipping at your nose.">)>
		<CRLF>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSO? ,HANDS>>
		<PERFORM ,V?WEAR ,SLEEVES>
		<RTRUE>)
	       (<AND <VERB? REMOVE TAKE-OFF>
		     <FSET? ,SLEEVES ,WORNBIT>>
		<CHANGE-JACK>
		<FSET ,SLEEVES ,PLURALBIT>
		<FCLEAR ,SLEEVES ,WORNBIT>
		<MOVE ,JOAT ,PROTAGONIST>
		<TELL 
"You slip off what feels to be a jacket. All features return to the " D ,JOAT
"." CR>) 
	       (<NO-JACK-HERE ,SLEEVES ,W?COAT ,W?JACKET>
		<RTRUE>)>>


;"encounter with Jack Frost stuff"

<ROOM FROST-ROOM
      (LOC ROOMS)
      (SDESC "All Whiteness and Cold")
      ;"piece of blank white paper"
      (LDESC "It looks like a picture of a wedding gown in a snow storm.")
      (OUT TO FROST-ROOM)
      (IN TO FROST-ROOM)
      (GLOBAL SNOW)
      (ACTION FROST-ROOM-F)>

<ROUTINE FROST-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? WEAR>
			    <PRSO? ,SLEEVES>>
		       <RFALSE>)
		      (<OR <PRSO? ,FROST>
			   <PRSI? ,FROST>>
		       <RFALSE>)
		      (<AND ,PRSO
			    <TOUCHING? ,PRSO>>
		       <TELL 
"Your fingers are so stiff with cold">
		       <COND (<AND <PRSO? ,PIECE-OF-METAL>
				   <VERB? CLOSE>
		     	      	   <EQUAL? ,JACK-IS ,PIECE-OF-METAL>>
			      <TELL ", but you try..." CR CR>
			      <RFALSE>)
			     (T
			      <TELL ", it's impossible." CR>)>
		       <RTRUE>)
		      (<AND ,PRSO
			    <SEEING? ,PRSO>
			    <VISIBLE? ,PRSO>>
		       <TELL 
"Because of the blizzard conditions, you can just barely see" TR ,PRSO>)
		      (T
		       <RFALSE>)>)>>

<ROUTINE GEN-JACK ()
	 <COND (<OR <NOT <VISIBLE? ,FROST>>
		    <FSET? ,FROST ,NDESCBIT>>
		,JOAT)
	       (<VERB? TELL ASK-ABOUT>
		,FROST)
	       (T
		<RFALSE>)>>

<GLOBAL FROST-C 0>

<ROUTINE I-FROST ()
	 <INC FROST-C>
	 <COND (<NOT <FSET? ,SLEEVES ,WORNBIT>> ;"assumes in frost-room"
		<COND (<EQUAL? ,FROST-C 1>
		       <TELL CR 
"The cold wind is breezing right through you">)
		      (<EQUAL? ,FROST-C 3>
		       <TELL CR "All feeling is leaving your body">)
		      (<EQUAL? ,FROST-C 4>
		       <TELL CR "You feel cold and near death">)
		      ;(<AND <EQUAL? ,FROST-C 4>
			    <VISIBLE? ,SLEEVES>>
		       <TELL CR 
"You look longingly at the sleeves of the " D ,JOAT>)
		      (<EQUAL? ,FROST-C 5>
		       <JIGS-UP "You perish of the cold.">)
		      (T
		       <RTRUE>)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,FROST-C 2>
		<TELL CR
"Despite the shelter of the jacket, you're still in the midst of a cold
snap. You begin to smell the vague illusory odor of \"chestnuts roasting on an
open fire.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,FROST-C 3>
		<TELL CR 
"There continues to be an annoying bitter cold frost nipping at your nose."
CR>)
	       (<EQUAL? ,FROST-C 4>
		<TELL CR 
"You can barely see your hand in front of your face, but you can't miss
the personification of frosty weather himself nipping at your nose." CR>)
	       (<EQUAL? ,FROST-C 5>
		<JIGS-UP 
"You can't see where you're going and wander into a wayward avalanche.">
		<RTRUE>)>>
	       
<ROOM NEAR-POND
      (LOC ROOMS)
      (DESC "Near pond")
      (LDESC 
"The mountain air is still and cold. You are
next to a frozen-over pond, ringed by dense forest.|
|
There is an old wooden sign leaning slightly over.")
      ;(OUT TO JACKVILLE)
      (IN PER POND-ROOM-ENTER)
      (GLOBAL SNOW SIGN ICE)
      (ACTION NEAR-POND-F)>
	
<ROUTINE NEAR-POND-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT <FSET? ,FROST ,RMUNGBIT>>>
		<FSET ,FROST ,RMUNGBIT>
		<TELL CR 
"The man refuses to communicate with you" ,STANDS-STILL>)>>

<ROUTINE POND-ROOM-ENTER ()
	 <COND (<IN? ,FROST ,HERE>
		<SEE-FROST>
		;<HEAR-FROST>
		<TELL 
"\"" <PICK-NEXT <GET ,S-FROST 0>> ",\" says the man "
<PICK-NEXT <GET ,S-FROST 1>>>
		<COND (<EQUAL? <GET <GET ,S-FROST 1> 1> 2> ;"at first ele"
		       <TELL 
". He holds out a gnarled stick, blocking your way onto the ice">)>
		<TELL ". \"" <PICK-NEXT <GET ,S-FROST 2>> "\"">
		<COND (<EQUAL? <GET <GET ,S-FROST 1> 1> 3>
		       <TELL 
" He raps his stick against the hard frozen pond.">)>
		<CRLF>
		<RFALSE>)
	       (T
		<TELL 
"You walk out onto the middle of the frozen pond." CR CR>
		<RETURN ,POND-ROOM>)>>

<OBJECT LAYER-OF-FROST
	(LOC POND-ROOM)
	(DESC "layer of frost")
	(SYNONYM LAYER FROST ;SNOW)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION LAYER-OF-FROST-F)>

<ROUTINE LAYER-OF-FROST-F ()
	 <COND (<VERB? MOVE KICK CLEAN>
		<COND (<FSET? ,LAYER-OF-FROST ,RMUNGBIT>
		       <TELL "It's been done." CR>)
		      (<FSET? ,ICE ,RMUNGBIT>
		       <TELL ,NICE-HOLE>)
		      (T
		       <FSET ,LAYER-OF-FROST ,RMUNGBIT>
		       ;<COND (<ZERO? <LOC ,MERMAID>>)>
		       <MOVE ,MERMAID ,HERE>
		       <TELL
"You knock a wide circle of frost away from the ice, allowing you to see an
astonishing sight below the ice: A woman's face with her large beautiful
eyes wide open and her long, blond hair drifting back and forth as she swims
side to side below the surface of the ice." CR>)>)>>

<OBJECT SNOW 
	(LOC LOCAL-GLOBALS)
	(DESC "snow")
	(SYNONYM SNOW BALL SNOWBALL)
	(ADJECTIVE SNOW)
	(FLAGS NOA TRYTAKEBIT NDESCBIT)
	(ACTION SNOW-F)>

<ROUTINE SNOW-F ()
	 <COND (<AND <VERB? PUT-ON>
		     <PRSI? ,SNOW>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<NOUN-USED ,SNOW ,W?BALL ,W?SNOWBALL>
		<COND (<VERB? MAKE>
		       <WASTES>
		       <RTRUE>)>
		<CANT-SEE <> "snowball">)>>

<OBJECT ICE
	(LOC LOCAL-GLOBALS)
	(DESC "ice")
	(SYNONYM ICE POND HOLE)
	(ADJECTIVE FROZEN ICE)
	(FLAGS NDESCBIT VOWELBIT NARTICLEBIT TRYTAKEBIT)
	(ACTION ICE-F)>

<ROUTINE ICE-F ()
	 <COND (<AND <NOUN-USED ,ICE ,W?HOLE>
		     <NOT <FSET? ,ICE ,RMUNGBIT>>>
		<CANT-SEE <> "hole">)
	       (<AND <NOUN-USED ,ICE ,W?HOLE>
		     <VERB? EXAMINE LOOK-INSIDE>>
		<TELL "The jagged hole in the ice reveals water." CR>)  
	       (<AND <EQUAL? ,HERE ,NEAR-POND>
		     <VERB? STAND-ON ENTER BOARD WALK-TO>>
		<DO-WALK ,P?IN>) 
	       (<AND <EQUAL? ,HERE ,NEAR-POND>
		     <TOUCHING? ,ICE>>
		<TELL "You can't reach the pond from here." CR>)
	       (<AND <VERB? REMOVE TAKE SHAKE MUNG>
		     <EQUAL? ,HERE ,NEAR-POND>>
		<TELL "The ice is too firmly attached." CR>)
	       (<AND <VERB? PUT-ON PUT>
		     <PRSI? ,ICE>>
		<COND (<FSET? ,ICE ,RMUNGBIT>
		       <WASTES>
		       <RTRUE>)>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? BOARD ENTER>
		<TELL 
"One tippy toe tells you it's too cold." CR>)
	       (<VERB? EXAMINE LOOK-UNDER LOOK-INSIDE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<VERB? MUNG>
		<COND (<AND <PRSI? ,ELECTRICAL-SWITCH>
		            <EQUAL? ,JACK-IS ,ELECTRICAL-SWITCH>>
		       <PERFORM ,V?ON ,ELECTRICAL-SWITCH>
		       <RTRUE>)>  
		<TELL "The ice is too thick">
		<COND (,PRSI
		       <TELL " to be penatrated by" T ,PRSI>)>
		<TELL ,PERIOD>)>>
	       
<OBJECT FROST
	(LOC FROST-ROOM)
	(DESC "Jack Frost")
	(SYNONYM FROST JACK MAN)
	(ADJECTIVE OLD JACK)
	(LDESC 
"An old man is next to the pond, standing bent like one of the age old trees of
the forest, with the frost of storms past still clinging in its whiteness
upon his dark overcoat. He holds in his hands a gnarled stick.")  
	(FLAGS ACTORBIT NARTICLEBIT NDESCBIT NO-D-CONT CONTBIT OPENBIT
	       SEARCHBIT)
	(GENERIC GEN-JACK)
	(ACTION FROST-F)>

<ROUTINE FROST-F ()
	 <COND (<RUNNING? ,I-FROST>
		<COND (<NOT <FSET? ,SLEEVES ,WORNBIT>>
		       <TELL "No such Jack has been suggested." CR>
		       <RTRUE>)>
		<UPDATE-SCORE>
		<FCLEAR ,FROST ,NDESCBIT>
		<MOVE ,FROST ,NEAR-POND>
		<TELL 
"Suddenly, all of the thick, nasty weather surrounding you begins
to swirl, then lift, slowly
at first, and then more rapidly up above your head, then up further to
expose the large and many trunks of dense evergreen forest, and then
up and past the high tops of the trees themselves and into the heavens." CR CR>
		<DEQUEUE I-FROST>
		<GOTO ,NEAR-POND>
		<RTRUE>)>
	 <COND (<EQUAL? ,FROST ,WINNER>
		<SEE-FROST>
		<COND ;(<AND <VERB? TELL-ABOUT>
			    ;<PRSO? ,ME>
			    <PRSI? ,ICE>>
		       <TELL "\"The ice is dangerous.\"" CR>)
		      (<AND <VERB? GIVE>
			    <PRSO? ,STICK>
			    <PRSI? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?TAKE ,STICK>
		       <SETG WINNER ,FROST>
		       <RTRUE>)
		      (T
		       <TELL 
"The man does not say anything in return" ,STANDS-STILL>)>)
	       (<VERB? EXAMINE>
		<TELL 
"He wears a permafrost frown upon his face, a face that betrays a lifetime
of never any joy, never any surprise, never any sunshine." CR>)
	       (<AND <VERB? ASK-FOR>
		     <PRSI? ,STICK>>
		<PERFORM ,V?TAKE ,STICK>
		<RTRUE>)
	       (<AND <VERB? GIVE SHOW>
		     <PRSO? ,JOAT>>
		<COND (<VERB? GIVE>
		       <TELL 
"He rejects your offer with an upraised palm. B">)
		      (T
		       <TELL "The frown remains frozen, b">)>
		<TELL
"ut he looks at the " D ,JOAT " with a tiny glimmer of curiosity in his
eye." CR>)>>
	       
<GLOBAL S-FROST
	<PTABLE
	 <LTABLE 2
		 "Whoa there"
		 "Watch yourself"
		 "Beware"
		 "Look out">
	 <LTABLE 2
	    "with a voice rough and uneven as if from exposure to the cold"
	    "gruffly"
	    "in a stern voice">
	 <LTABLE 2
	   "Don't you see this ice? You couldn't fall through it if you tried."
	   "Go find some really THIN ice to go tap-dancing on."
"The ice is too thick here. My job is to make things cold for you, not let
you have fun.">>>

<ROUTINE SEE-FROST ()
	 <COND (<NOT <FSET? ,FROST ,SEENBIT>>
	        <FSET ,FROST ,SEENBIT>
		<TELL
"The frost-covered man turns and faces toward you. Some flakes of snow float
down off his well-dusted coat." CR CR>)>>

;<ROUTINE HEAR-FROST ()
	 <COND (<NOT <FSET? ,FROST ,HEARDBIT>>
		<FSET ,FROST ,HEARDBIT>
		<TELL 
"Tiny flakes of snow drift from the frozen features of his face as the man
begins to speak." CR CR>)>>
		
<OBJECT STICK
	(LOC FROST)
	(DESC "gnarled stick")
	(SYNONYM STICK)
	(ADJECTIVE GNARLED)  
	(FLAGS TRYTAKEBIT)
	(ACTION STICK-F)>

<ROUTINE STICK-F ()
	 <COND (<VERB? TAKE>
		<TELL 
"Giving you nothing but a frozen stare, Jack Frost withdraws the gnarled stick
from you." CR>)>>

<ROOM POND-ROOM
      (LOC ROOMS)
      (DESC "On Frozen Pond")
      (OUT TO NEAR-POND)
      (IN TO POND-ROOM)
      (GLOBAL SNOW ICE WATER)
      (ACTION POND-ROOM-F)>

<ROUTINE POND-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"You're on a frozen pond covered by a thin layer of frost">
		<COND (<FSET? ,ICE ,RMUNGBIT>
		       <TELL ". There is a hole in the ice">)
		      (<FSET? ,LAYER-OF-FROST ,RMUNGBIT>
		       <TELL 
" except where a wide circle of the frost has been wiped away">)>
		<TELL ".">)>>

<OBJECT MERMAID
	(DESC "mermaid")
	(SYNONYM MERMAID FIN)
	(DESCFCN MERMAID-F)
	(ADJECTIVE TAIL)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT FEMALEBIT)
	(ACTION MERMAID-F)>

;"RMUNGBIT = removed her from under ice"

<ROUTINE MERMAID-F ("OPT" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<COND (<NOT <FSET? ,MERMAID ,RMUNGBIT>>
		       <TELL CR
"A mermaid swims desperately under the suface of the ice.">)
		      (T
		       <TELL CR 
"A mermaid is lying exhausted on the ice.">)>)
	       (<VERB? TELL>
		<COND (<NOT <FSET? ,MERMAID ,RMUNGBIT>>
		       <TELL 
"In slow motion she waves her head then hits the ice with her hand">)
		      (T
		       <TELL 
			"The mermaid gives you a slow smile">
		       <COND (<IN? ,MERMAID ,HOT-TUB>
			      <TELL
" while effortlessly and relaxingly treading water">)
			     (T
			      <TELL
			       " and tilts her head slightly to one side">)>)>
		<TELL ,PERIOD>
		<STOP>)
	       (<VERB? EXAMINE>
		<COND (<NOT <FSET? ,MERMAID ,RMUNGBIT>>
		       <TELL 
"The mermaid is floating upright and swimming, with some difficulty, to and
fro under the surface of the ice. Her long blond hair drifts back and forth
following the undulating motion of her body">
		       <COND (<NOT <FSET? ,MERMAID ,SEENBIT>>
			      <FSET ,MERMAID ,SEENBIT>
			      <TELL ".||
Tiny bubbles drift from her mouth in an aborted effort to speak">)>)
		      (T
		       <TELL 
"The mermaid is tall, curvaceous and attractive, even with her long blond hair
dripping wet">
		<COND (<IN? ,FISHING-LINE ,MERMAID>
		       <TELL
". There is a large tangle of fishing line wrapped around her sizable tail
fin">)>
		<COND (<IN? ,NECKLACE ,MERMAID>
		       <TELL ". She's wearing a shark-tooth necklace">)>)>
		<TELL ,PERIOD>)
	       (<AND <TOUCHING? ,MERMAID>
		     <NOT <FSET? ,MERMAID ,RMUNGBIT>>>
		<TELL 
"A couple inches of ice is in the way." CR>)
	       (<VERB? KISS>
		<COND (<NOT ,MERMAID-KISS>
		       <SETG MERMAID-KISS T>
		<TELL
"You drift near enough to feel the warmth of her breath, which carries
barely a hint of brine but is not unpleasant. ">)>
		<TELL "She turns gracefully away." CR>)>>

<GLOBAL MERMAID-KISS <>>

<ROUTINE MERMAID-LEAVES ()
	 <COND (,MERMAID-WARM
		<REMOVE ,MERMAID>
		<QUEUE I-END-SCENE 1>
		<TELL 
".||
The mermaid, having been warmed by the dip in the hot tub, and freed of
the entanglement of the fishing line, appears ready to brave the frigid
waters for a long swim to warmer regions. She hyperventilates for a few
moments and braces herself with a frenetic self-hug, stopping to give you
a smile with her thin lips.|
|
She bids farewell, and slips back into the frigid water, causing a
little plop of water as her tail fin disappears beneath the surface">)>>

<OBJECT FISHING-LINE
	;(LOC MERMAID)
	(DESC "tangle of fishing line")
	(SYNONYM TANGLE LINE)
	(ADJECTIVE FISHING)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION FISHING-LINE-F)>

<ROUTINE FISHING-LINE-F ()
	 <COND (<VERB? TAKE UNTIE>
		<TELL 
"It's far too enmeshed onto the scaly tail fin for you to untie." CR>)>>

<OBJECT NECKLACE
	;(LOC MERMAID)
	(DESC "shark-tooth necklace")
	(SYNONYM NECKLACE)
	(ADJECTIVE SHARK-TOOTH SHARK)
	(FLAGS TRYTAKEBIT)
	(ACTION NECKLACE-F)>

<ROUTINE NECKLACE-F ()
	 <COND (<AND <VERB? TAKE>
		     <IN? ,NECKLACE ,MERMAID>>
		<TELL
"The mermaid covers up her necklace and shrinks away from you." CR>)>>
		