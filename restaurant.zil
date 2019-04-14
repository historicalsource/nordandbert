"RESTAURANT for
		             NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"ENTER FROM OUTSIDE WITH VEIW OF TEAPOT-LOOKING REST."

<OBJECT RESTAURANT ;"name of scene"
	(LOC LOCAL-GLOBALS)
	(DESC "restaurant")
	(PICK-IT "Eat your Words")
	(MAX-SCORE 31)
	(SCENE-SCORE 0)
	(SCENE-ROOM FLOOR-1)
	(SCENE-CUR 0)
	(SYNONYM RESTAURANT KITCHEN ;FLOOR TEMPEST TEAPOT POT)	      
		 ;"create a t. in a teapot"
	;(ADJECTIVE ;FIRST ;SECOND TEA)
	(FLAGS NDESCBIT SCENEBIT)
	(ACTION RESTAURANT-F)>

<ROUTINE RESTAURANT-F ()
	 <COND (<AND <VERB? NO-VERB WALK-TO ENTER>
		     <NOUN-USED ,RESTAURANT ,W?KITCHEN>
		     <GLOBAL-IN? ,RESTAURANT ,HERE>>
		<COND (<EQUAL? ,HERE ,FLOOR-1>
		       <DO-WALK ,P?IN>)
		      (<EQUAL? ,HERE ,KITCHEN>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <CANT-GET-THERE>)>)
	       (<AND <VERB? SET>
		     <EQUAL? <GET ,P-NAMW 0> ,W?TEMPEST>
		     <EQUAL? <GET ,P-NAMW 1> ,W?TEAPOT>>
		<TELL "Indeed, that's the whole idea." CR>)
	       ;(<VERB? EXAMINE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       ;(T
		<CHANGE-OBJECT ,RESTAURANT ,GLOBAL-ROOM>
		<RTRUE>)>>

<ROOM FLOOR-1 
      (LOC ROOMS)
      (DESC "First floor")
      (UP TO FLOOR-2)
      (IN PER FLOOR-1-EXIT)
      ;(OUT PER FLOOR-1-EXIT)
      (GLOBAL RESTAURANT STAIRS)
      (FLAGS INDOORSBIT)
      (ACTION FLOOR-1-F)>

<ROUTINE FLOOR-1-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"You are on the first floor of The Teapot Cafe, ">
		<COND (<IN? ,PROTAGONIST ,REST-CHAIR>
		       <TELL "sitting at">)
		      (T
		       <TELL "standing next to">)>
		<TELL
" " D ,REST-TABLE " under the shadowy umbrage of the second floor balcony, which can be reached by a stairway">
		<COND (<NOT <FSET? ,COMEUPPANCE ,TOUCHBIT>>
		       <TELL " that is marked with a blue neon sign">)>
		<TELL ".">
		<COND (<IN? ,SHRIFT ,REST-TABLE>
		       <TELL CR CR
"Your table is only partially covered by a skimpy little tablecloth">
		       <COND (<G? <CCOUNT ,REST-TABLE> 1>
			      <TELL " upon which rests">
			      <D-CONTENTS ,REST-TABLE 2>
			      <RTRUE>)
			     (T
			      <TELL ".">)>)
		      (<FIRST? ,REST-TABLE>
		       <TELL CR CR "Your table contains">
		       <D-CONTENTS ,REST-TABLE 2>
		       <RTRUE>)>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,FLOOR-1 ,TOUCHBIT>>>
		<TELL
"First, you arrive in front of a large, two-story Teapot with wisps of smoke
drifting out of its spout. As you walk inside you're nearly broadsided by a
waitress who's all in a rush, which seems odd since you see no one else in the
restaurant. Nevertheless, the waitress does not smile and say hello, does
not introduce herself as Jenny, does not even acknowledge your existence
with a tip of her headband.||">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT <IN? ,WAITRESS ,HERE>>>
		<WAITRESS-COMES>)>>
 
<OBJECT REST-TABLE
	(LOC FLOOR-1)
	(DESC "your table")
	(LDESC "Your table stands alone in the middle of the room.")
	;"ldesc must stay for not printed of d-contents"
	(SYNONYM TABLE TABLES)
	(ADJECTIVE MY YOUR)
	(FLAGS CONTBIT SURFACEBIT OPENBIT SEARCHBIT NARTICLEBIT
	       DESC-IN-ROOMBIT)
	(CAPACITY 60)
	(ACTION REST-TABLE-F)>

;"rmungbit tell it jiggles on its pedistal"

<ROUTINE REST-TABLE-F ()
	 <COND (<AND <VERB? TURN-OBJECT-ON>
		     <PRSI? ,WAITRESS>>
		<OFFENCE>)
	       (<AND <VERB? EXAMINE>
		     <NOT <FSET? ,REST-TABLE ,PHRASEBIT>>>
		<TELL "You notice a slight swivel to it. ">
		<RFALSE>)
	       (<VERB? SET MOVE PUSH>
		<SETG ORPHAN-FLAG ,REST-TABLE>
		<QUEUE I-ORPHAN 2>
		<TELL
"Whom do you want to turn the tables on?" CR>)>>      

<OBJECT REST-CHAIR
        (LOC FLOOR-1)
	(DESC "your chair")
	(SYNONYM CHAIR)
	(ADJECTIVE MY YOUR)
	(FLAGS NDESCBIT NARTICLEBIT VEHBIT CONTBIT SURFACEBIT OPENBIT
	       SEARCHBIT)
	(ACTION REST-CHAIR-F)>

<ROUTINE REST-CHAIR-F ("OPT" (RARG <>))
	 <COND (.RARG
		<RFALSE>)>>

<OBJECT SHRIFT
	(LOC REST-TABLE)
	(DESC "short shrift")
	(SYNONYM TABLECLOTH SHRIFT CLOTH)
	(ADJECTIVE SKIMPY SHORT)
	(FLAGS TAKEBIT ;NDESCBIT)
	(ACTION SHRIFT-F)>

<ROUTINE SHRIFT-F ()
	 <COND (<VERB? EXAMINE>
		;<FSET ,SHRIFT ,SEENBIT>
		<TELL 
"From the looks of it, you've been given the " D ,SHRIFT ", this shrunken
little tablecloth that's hardly big enough to cover a table." CR>)
	       (<AND <VERB? TAKE>
		     <IN? ,SHRIFT ,REST-TABLE>
		     <G? <CCOUNT ,REST-TABLE> 1>
		     ;<EQUAL? <ITAKE> T> ;"moves obj to protag"
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<TELL 
"With the flair for the dramatic that has so marked your progress through
this strange universe, you yank the " D ,SHRIFT " away without at
all disturbing">
		<D-CONTENTS ,REST-TABLE ;2>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,REST-TABLE>
		     <FIRST? ,REST-TABLE>>
		<MOVE ,SHRIFT ,REST-TABLE>
		<TELL 
"You clear the table, lay down the " D ,SHRIFT ", and reset the table."
CR>)>> 

<OBJECT SALT-SHAKER
	(LOC LOCAL-GLOBALS)
	(DESC "salt shaker")
	(SYNONYM SHAKER SALT)
	(ADJECTIVE SALT)
	(FLAGS TAKEBIT)
	(GENERIC GEN-SALT)
	(ACTION SALT-SHAKER-F)>

<ROUTINE SALT-SHAKER-F ()
	 <COND (<NOUN-USED ,SALT-SHAKER ,W?GRAIN>;"phrase was 'grain of salt'"
		<CANT-SEE <> "grain of salt">
		<RTRUE>)
	       (<VERB? SHAKE>
		<COND (<IN? ,GRAIN-OF-SALT ,LOCAL-GLOBALS>
		       <MOVE ,GRAIN-OF-SALT ,HERE>
		       <TELL 
"Just one grain of salt spills out of the shaker onto the floor." CR>)
		      (T
		       <TELL "Nothing comes out." CR>)>)
	       (<AND <VERB? PUT>
		     <PRSO? ,GRAIN-OF-SALT>>
		<TELL 
"It's like threading a needle, and you keep missing." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL 
"It's not designed to be opened. You should've seen how hard it was to put
all the grains of salt into those little holes." CR>)>>

<OBJECT GRAIN-OF-SALT
	(LOC LOCAL-GLOBALS) ;"must be, above"
	(DESC "grain of salt")
	(SYNONYM GRAIN SALT)
	(ADJECTIVE SALT GRAIN)
	(FLAGS TAKEBIT)
	(GENERIC GEN-SALT)
	;(ACTION GRAIN-OF-SALT-F)>

<ROUTINE GEN-SALT ()
	 ,GRAIN-OF-SALT>

<OBJECT FORTUNE
	;(LOC LOCAL-GLOBALS)
	(DESC "fortune cookie")
	(SYNONYM COOKIE FOOD)
	(ADJECTIVE FORTUNE)
	(FLAGS TAKEBIT FOODBIT)
	(ACTION FORTUNE-F)>

<ROUTINE FORTUNE-F ()
	 <COND (<VERB? OPEN MUNG EAT>
		<MOVE ,ADVICE ,PROTAGONIST>
		<REMOVE ,FORTUNE>
		<TELL "Crumbs from the cookie drift away upon a pungent
smelling wind from the kitchen. That's the way the cookie crumbles. However,
you are left with a piece of advice." CR>)>>

<OBJECT ADVICE
	(DESC "advice")
	(SYNONYM SLIP PAPER ADVICE FORTUNE PIECE)
	(ADJECTIVE TINY)
	(FLAGS TAKEBIT NARTICLEBIT)
	(ACTION ADVICE-F)>

<ROUTINE ADVICE-F ()
	 <COND (<AND <VERB? TAKE-WITH>
		     <PRSI? ,GRAIN-OF-SALT>>
		<COND (<IN? ,WAITRESS ,HERE>
		       <OFFENCE>)
		      (T
		       <TELL 
"Too bad the waitress isn't around to see this insult." CR>)>)
	       (<VERB? READ>
		<TELL 
"The tiny slip of paper reads: \"Patience is the best remedy for every
trouble.\" You're not sure how to take it." CR>)>>
		
<OBJECT CROW
	(SDESC "crow")
	(SYNONYM CROW GRITTY NITTY-GRITTY BIRD FOOD)
	(ADJECTIVE NITTY CHARRED DARK-FEATHERED)
	(FLAGS TAKEBIT NARTICLEBIT FOODBIT)
	(ACTION CROW-F)>

;"rmungbit = eaten once"

<ROUTINE CROW-F ()
	 <COND (<VERB? EAT>
		<COND (<NOT <FSET? ,CROW ,RMUNGBIT>>
		       <FSET ,CROW ,RMUNGBIT>
		       <PUTP ,CROW ,P?SDESC "nitty-gritty crow">
		       <TELL 
"You take a squeamish bite of it and chew slowly, finding the consistency
to be ">
		       <ITALICIZE "nitty-gritty">)
		      (T
		       <TELL
"You find" T ,CROW " to be inedible">)>
		<TELL ,PERIOD>)
	       (<VERB? DISEMBARK> ;"Get down obj"
		     ;<NOUN-USED ,CROW ,W?NITTY-GRITTY>
		<OFFENCE>)>>

<OBJECT ROAST
	(DESC "rump roast")
	(SYNONYM ROAST ROAST CHEEKS CHEEK HALF FOOD)
	(ADJECTIVE RUMP OTHER YOUR MY CHARRED)
	(FLAGS ;NDESCBIT TAKEBIT FOODBIT)
	(ACTION ROAST-F)>

<ROUTINE ROAST-F ()
	 <COND (<VERB? EXAMINE>
		<TELL 
"It's primarily in two parts, one half charred, the other cheek merely
well-done." CR>)
	       (<AND <VERB? SET>
		     <ADJ-USED ,ROAST ,W?OTHER>
		     <NOUN-USED ,ROAST ,W?CHEEK>>
		<COND (<NOT <FSET? ,ROAST ,PHRASEBIT>>
		       <FSET ,ROAST ,PHRASEBIT>
		       <UPDATE-SCORE>)>
		<TELL
"You mull over the food in front of you, with many thoughts. As you
turn the other cheek, however noble your intention, ">
		<COND (<IN? ,WAITRESS ,HERE>
		       <TELL "the waitress still ignores you">)
		      (T
		       <TELL "no good comes of it">)>
		<TELL ,PERIOD>)
	       (<VERB? SET>
		<TELL "The phrasing doesn't seem quite right." CR>)>>

<OBJECT HUMBLE-PIE
	(DESC "humble pie")
	(SYNONYM PIE FOOD)
	(ADJECTIVE HUMBLE)
	(FLAGS TAKEBIT NARTICLEBIT FOODBIT)
	(ACTION HUMBLE-PIE-F)>

<ROUTINE HUMBLE-PIE-F ()
	<COND (<VERB? EAT>
	       <UPDATE-SCORE>
	       <REMOVE ,HUMBLE-PIE>
	       <TELL 
"As gingerly as possible, nibbling around the edges and taking smallish guilty
bites out of the pie, and chewing slowly and thoughtfully with wide eyes to
prolong the expression of your humility, you gradually consume the pie until
it is all gone." CR>)>> 

<OBJECT PRIDE
	(DESC "collective of lions' meat")
	(SYNONYM LIONS COLLECTIVE PRIDE MEAT FOOD)
	(ADJECTIVE COOKED LION LION\'S LIONS\' YOUR MY)
	(FLAGS TAKEBIT FOODBIT)
	(ACTION PRIDE-F)>

<ROUTINE PRIDE-F ()
	 <COND (<VERB? EAT>
		<COND (<NOT <NOUN-USED ,PRIDE ,W?PRIDE>>
		       <TELL 
"The phrasing seems off, since the meat defends itself from such an
approach">)
		      (<EQUAL? ,P-PRSA-WORD ,W?SWALLOW>
		       <UPDATE-SCORE>
		       <REMOVE ,PRIDE>
		       <TELL  
"It's hard to swallow, but with determination and several long, Adam's
apple-jacking gulps, you manage to do it">)
		      (T
		       <TELL "You have an awful lot to chew on here">)>
		<TELL ,PERIOD>)>> 

<OBJECT HATCHET
	(LOC LOCAL-GLOBALS)
	(DESC "hatchet")
	(SYNONYM AX AXE HATCHET BLADE)
	(FLAGS TAKEBIT)
	(ACTION HATCHET-F)>

;"rmungbit = have sharpened it"

<ROUTINE HATCHET-F ()
	 <COND (<AND <VERB? GRIND>
		     <EQUAL? ,HERE ,KITCHEN>>
		<COND (<FSET? ,HATCHET ,PHRASEBIT>
		       <TELL ,ALREADY-HAVE>)
		      (T
		       <FSET ,HATCHET ,PHRASEBIT>
		       <UPDATE-SCORE>
		       <TELL 
"After all you've been through, you believe you have a legitimate axe
to grind, and you do so, with relish. The blade of the axe twinkles with
razor sharpness." CR>)>)
	       (<AND <VERB? GIVE>
		     ;<NOUN-USED ,HATCHET ,W?AX>
		     <PRSI? ,COOK ,WAITRESS>>
		<TELL 
"You can't give the " D ,PRSI " the ax, since, you're not ">
		<COND (<EQUAL? ,PRSI ,COOK>
		       <TELL "his">)
		      (T
		       <TELL "her">)>
		<TELL " boss." CR>)>>

<OBJECT NAPKIN
	(DESC "white cloth napkin")
	(SYNONYM NAPKIN CLOTH FLAG)
	(ADJECTIVE WHITE CLOTH)
	(FLAGS TAKEBIT ;NARTICLEBIT)
	(ACTION NAPKIN-F)>

<ROUTINE NAPKIN-F ()
	 <COND (<VERB? WAVE>
		<COND (<NOT <FSET? ,NAPKIN ,PHRASEBIT>>
		       <FSET ,NAPKIN ,PHRASEBIT>
		       <UPDATE-SCORE>)>
		<TELL
"With your shoulders scrunched together so as not to presume to take
up much room in the Teapot Cafe, and with a sheepish look on your face,
you wave the little white napkin, looking side to side to see if it's
having any effect at all." CR>)>>

;"total of 16 acts of offense"
<ROUTINE OFFENCE ("OPTIONAL" (OBJ <>))
	 <COND (<ZERO? .OBJ>
		<SET OBJ ,PRSO>)>
	 <COND (<OR <AND <FSET? .OBJ ,PHRASEBIT>
			 <NOT <ADJ-USED ,EYES ,W?EVIL>>>
		    <AND <ADJ-USED ,EYES ,W?EVIL>
			 <FSET? ,EYES ,RMUNGBIT>>>
		<TELL ,ALREADY-HAVE>
		<RTRUE>)
	       (T
		<UPDATE-SCORE>
		<COND (<ADJ-USED ,EYES ,W?EVIL>
		       <FSET ,EYES ,RMUNGBIT>)
		      (<ADJ-USED ,EYES ,W?JAUNDICED>
		       <FSET ,EYES ,PHRASEBIT>)
		      (T
		       <FSET .OBJ ,PHRASEBIT>)>
		<COND (<PRSO? ,CROW> ;"ie nitty-gritty"
		       <TELL
"You do your best... but the attempt falls on the waitress's deaf ears">)
		      (<PRSO? ,REST-TABLE>
		       <SETG OLD-HERE <>>
		       <MOVE ,PROTAGONIST ,REST-CHAIR>
		       <TELL 
"The waitress steps quickly toward you, pressing her thighs against the
table's opposite edge and staring coldly into your eyes.|
|
Her eyelashes are spidery with thick mascara, and the volume of white
powder below each brow could open a ski season. Her cheeks are brazen
with a raw swath of rouge, and the heavy lip blush is indeed embarrassing.|
|
You muster a grimace of your own, and you both follow the table around as
it makes one complete revolution and notches to a stop. You plop down on
the chair, sweat draining from your temples">)
		      (<PRSO? ,ADVICE>
		       <TELL 
"You read the advice in a loud voice with much sarcasm, taking it so
lightly that the slip of paper almosts drifts up into the air. The
waitress seems snubbed that you don't seem to be taking the advice to
heart">)
		      (<PRSO? ,UMBRAGE>
		       <TELL 
"You do so, and the Teapot cafe seems a little less dim, which unfortunately
can't be said of its employees, not excluding the waitress">)
		      (<PRSO? ,SHRIFT>
		       <REMOVE ,SHRIFT>
		       <TELL 
"That's one way to turn the tables on the waitress. She accepts the short
shrift gruffly and begins polishing glasses with it">)
		      (<PRSO? ,WOOL>
		       <TELL 
"The headband slips lower upon the waitress's forehead, narrowing her vision
to table-level and below">)
		      (<PRSO? ,DANDER>
		       <TELL 
"The waitress shrugs her shoulders in contempt of your pestering, and sure
enough her dander is raised">)
		      (<PRSO? ,CHIP>
		       <TELL 
"\"Come on, knock it off!\" the waitress says defiantly, and the chip goes
flying off into the air">)
		      (<PRSO? ,COMEUPPANCE>
		       <REMOVE ,COMEUPPANCE>
		       <TELL
"The fuzzily glowing neon goes well with her dime-store face. Her eyes
pick up the glow, and she storms away">)
		      (<AND <PRSO? ,WAITRESS> ;"rake over coals"
		            <VERB? RAKE-OVER>>
		       <TELL 
"Not a bad idea, since the " D ,WAITRESS " looked so much in need of a rake
over. Of course, this only ends up in fanning the flames, and scorched by
your harshness, she stalks off">)
		      (<PRSO? ,CEILING>
		       <TELL 
"The full brunt of your impact is taken by your head and shoulders, and the
entire teapot rattles loudly as you raise the roof">)
		      (<PRSO? ,RIOT-ACT>
		       <TELL 
"\"How sweet,\" thinks the waitress. \"I haven't been read to since I was a
child, before going to sleep.\" But when she suddenly realizes it's bedtime
for Bonzo, her face reddens">)
		      (<PRSO? ,DESSERTS>
		       <REMOVE ,DESSERTS>
		       <TELL 
"At first, the waitress perks up, no doubt expecting a large tip. But when
she gets the meanness of your offering, her face sours">)
		      (<AND <PRSI? ,EYES> ;"perform v-examine in pre-give"
			    <ADJ-USED ,EYES ,W?EVIL>>
		       <TELL
"You give her the evil eye, which is not as painful as you might have expected,
and in fact brings you a good deal of satisfaction. As for the waitress, she
seems ruffled, but continues about her business">)
		      (<AND <PRSI? ,EYES> ;"l at x with j. eye"
		            <ADJ-USED ,EYES ,W?JAUNDICED>>
		       <TELL
"Under your nasty gaze, the waitress seems momentarily self-conscious,
then hurriedly continues on with her work">)
		      (<PRSO? ,SPLEEN>
		       <TELL 
"On a gut feeling, you let it all hang out, which brings you a
general feeling of well-being. It seems to have struck a nerve in the
waitress too, since she takes a rare glance in your direction">)
		      (<PRSI? ,GROUND> ;"call x onto carpet"
		       <TELL
"Bristling at your presumption of authority, the waitress stops in front of
you for one brief moment. Then before you can open your mouth, she turns
and leaves">)>
		<TELL ". ">
		<OFFENCE-REACTION>)>>

<GLOBAL OFFENCES 0>

<ROUTINE OFFENCE-REACTION ()
	 ;<SET OFFENCES <GETP ,SCENE ,P?SCENE-SCORE>>
	 <SETG OFFENCES <+ ,OFFENCES 1>>
	 <COND (<EQUAL? ,OFFENCES 1>
		<TELL 
"She ducks out for a few seconds and returns to hurriedly ">
		<GIVE-IT ,HATCHET "set your table with" "give you">
		<TELL 
" something strange and crude for an eating instrument, a hatchet">)
	       (<EQUAL? ,OFFENCES 2>
		<TELL
"Becoming agitated at your behavior, she disappears for a few moments, and comes back to serve you some ">
		<GIVE-IT ,HUMBLE-PIE "pie by setting it on the table" "pie">
		<TELL "." CR CR "The waitress "
		        <PICK-NEXT <GET ,S-WAITRESS 0>>
			<PICK-NEXT <GET ,S-WAITRESS 1>>>)
	       (<EQUAL? ,OFFENCES 4>
		<TELL
"She charges back into the kitchen, and ">
		<GIVE-IT ,PRIDE "brings to your table" "dishes out to you">
		<TELL
" some strange meat that she briefly describes as being
\"collective of lions.\" Strange indeed">)
	       (<EQUAL? ,OFFENCES 6>
		<TELL "She leaves, comes back and ">
		<GIVE-IT ,FORTUNE 
"flings a fortune cookie down on your table" "closes your hand
gently around a fortune cookie">
		<GIVE-IT ,SALT-SHAKER " along with a salt shaker"
			         " along with a salt shaker">
		<TELL "." CR CR "The waitress "
		        <PICK-NEXT <GET ,S-WAITRESS 0>>
			<PICK-NEXT <GET ,S-WAITRESS 1>>>)
	       (<EQUAL? ,OFFENCES 7>
		<TELL 
"She flies the coop for a minute and comes back with a charred,
dark-feathered bird which she ">
		<GIVE-IT ,CROW "drops onto your table" "puts in your arms">)
	       (<EQUAL? ,OFFENCES 8>
		<TELL 
"She makes a brief exit, and a briefer entrance to drop a white cloth napkin ">
		<GIVE-IT ,NAPKIN "onto your table" "into your arms">)
	       (<EQUAL? ,OFFENCES 9>
		<TELL "She exits, then comes back and slips a rump roast ">
		<GIVE-IT ,ROAST "onto your table" "to you">
		<TELL "." CR CR "The waitress "
		        <PICK-NEXT <GET ,S-WAITRESS 0>>
			<PICK-NEXT <GET ,S-WAITRESS 1>>>)
	       (<EQUAL? ,OFFENCES 10> ;"no need for answer"
		<TELL 
"She pretends not to be bothered, but you observe that she's reaching her
boiling point, being driven into a tizzy as she walks in circles. Her dander
is jumping up from her shoulders as she storms away, and the distant sound
of a teapot whistling can be heard">)
	       (<EQUAL? ,OFFENCES 12>
		<TELL
"\"Well, if you've really reached the boiling point,\" shouts the waitress,
\"why don't you take it up with the cook!\"" CR>
		<RTRUE>)
	       (T
		<TELL CR "The waitress "
		        <PICK-NEXT <GET ,S-WAITRESS 0>>
			<PICK-NEXT <GET ,S-WAITRESS 1>>>
		<TELL ,PERIOD>
		<RTRUE>)>
	 <TELL ,PERIOD>
	 <RTRUE>>

<GLOBAL S-WAITRESS
	<PTABLE
	 <LTABLE 2
	 	 "continues on, "
		 "steps away from you, "
		 "resumes her duties, which seem to include "
		 "stomps away in a huff and begins ">
	 <LTABLE 2
		 "calculating her tips for the day"
		 "performing a quick set of high-impact aerobics"
		 "clearing plates with her bristly hair"
		 "taking a standing coffee break"
		 "munching on some pilfered salad makings"
		 "fingering her neck nervously">>>

<ROUTINE GIVE-IT (OBJ STR1 STR2)
	 <COND (<EQUAL? ,HERE ,FLOOR-1>
		<MOVE .OBJ ,REST-TABLE>
		<TELL .STR1>)
	       (T
		<MOVE .OBJ ,PROTAGONIST>
		<TELL .STR2>)>
	 <RTRUE>>	 

<OBJECT UMBRAGE
	(LOC FLOOR-1)
	(DESC "umbrage")
	(SYNONYM UMBRAGE)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION UMBRAGE-F)>

<ROUTINE UMBRAGE-F ()
	 <COND (<AND <VERB? TAKE TAKE-WITH>
		     <PRSO? ,UMBRAGE>>
		<COND (<OR <NOT ,PRSI>
			   <PRSI? ,WAITRESS>>
		       <OFFENCE>)
		      (T
		       <WASTES>)>)>>

<OBJECT COMEUPPANCE
	(LOC FLOOR-1)
	(DESC "Comeuppance")
	(SYNONYM SIGN COMEUPPANCE)
	(ADJECTIVE COMEUPPANCE BLUE NEON HER)
	(FLAGS NDESCBIT NARTICLEBIT ;READBIT TAKEBIT TRYTAKEBIT)
	(ACTION COMEUPPANCE-F)>

<ROUTINE COMEUPPANCE-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,COMEUPPANCE ,TRYTAKEBIT>>
		<TELL 
"The waitress, though busy scurrying around and up and down, would be able to observe such a flagrant violation upon the premises." CR>)
	       (<AND <VERB? TAKE>
		     <NOT <FSET? ,COMEUPPANCE ,TOUCHBIT>>
		     ;<EQUAL? <ITAKE> T>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<FCLEAR ,COMEUPPANCE ,TRYTAKEBIT>
		<TELL 
"Having pulled the wool over the waitress's eyes, you snatch the neon sign,
which glows warm in your hands." CR>)
	       (<VERB? EXAMINE READ>
		<COND (<NOT <FSET? ,PRSO ,TOUCHBIT>>
		       <TELL "Next to the stairway, ">)
		      (T
		       <TELL "The ">)>
		<TELL "glowing blue neon letters read \"">
		<HLIGHT ,H-BOLD>
		<TELL "Comeuppance">
		<HLIGHT ,H-NORMAL>
		<TELL ".\"" CR>)>>

<OBJECT WAITRESS
	(LOC FLOOR-1)
	(DESC "waitress")
	(LDESC "A waitress here is trying to look busy.")
	(SYNONYM WAITRESS GIRL JEN JENNY)
	(FLAGS ACTORBIT FEMALEBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT)
	(GENERIC GEN-GIRL)
	(ACTION WAITRESS-F)>

<ROUTINE WAITRESS-F ()
	 <COND (<VERB? TELL>
		<TELL 
"She issues you a loud, head-shaking raspberry, which is as much service
as you've gotten from her yet." CR>
		<STOP>)
	       (<AND <VERB? MUNG KILL>
		     <NOT ,PRSI>
		     <HELD? ,HATCHET>>
		<TELL "[with the hatchet]" CR CR>
		<PERFORM ,V?KILL ,WAITRESS ,HATCHET>
		<RTRUE>)
	       (<AND <VERB? MUNG KILL>
		     <PRSI? ,HATCHET>>
		<TELL 
"The waitress firmly grips your forearm in defense of her mohawk. \"Come
on now, enough of this hair-splitting, I'll get to you, just as soon as I can.\"" CR>)
	       (<VERB? EXAMINE>
		<TELL
"She is a hatchet-faced young woman, with a spiked purple mohawk and a
pink woolen headband">
		<COND (<FSET? ,WOOL ,PHRASEBIT>
		       <TELL ", which's been pulled over her eyes">)
		      (T
		       <TELL " worn low on her forehead">)>
		<TELL ". ">
		<COND (<IN? ,CHIP ,WAITRESS>
		       <TELL
"A stray wood chip, apparently having been picked up from the kitchen,
sits upon">)
		       (T
			<TELL "You've knocked the chip off">)>
		<TELL " her shoulder">
		<COND (<FSET? ,DANDER ,PHRASEBIT>
		       <TELL
". You've done your darndest to raise her dander">)
		      (T
		       <TELL
", which is otherwise sprinkled amply with dandruff, or dander">)>
		<TELL ,PERIOD>
		<COND (<NOT <FSET? ,WOOL ,PHRASEBIT>>
		       <TELL CR 
"She eyes you suspiciously for a moment, as if you've done wrong." CR>)>
		<RTRUE>)
	       (<VERB? GIVE>
		<COND (<PRSO? ,SHRIFT ,COMEUPPANCE ,DESSERTS>
		       <OFFENCE>)
		      (<PRSO? ,BRANCH>
		       <UPDATE-SCORE>
		       <REMOVE ,BRANCH>
		       <TELL 
"She accepts the peace offering, leaves, then comes back." CR>)
		      (;<PRSI? ,HATCHET>
		       <PRSO? ,HATCHET>
		       <RFALSE>)
		      (<AND <PRSO? ,CROW>
		            <EQUAL? <GET ,P-NAMW 0> ,W?BIRD>>
		       <TELL 
"She missed it, and you withdraw the finger like a smoking gun." CR>)>)
	       (<AND <VERB? PASS>
		     <EQUAL? ,HERE ,FLOOR-1>
		     <L? ,OFFENCES 11>>
		<DO-WALK ,P?IN>
		<RTRUE>)>>

<OBJECT WOOL
	(LOC WAITRESS)
	(DESC "wool")
	(SYNONYM HEADBAND WOOL)
	(ADJECTIVE WAITRESS WOOL WOOLEN PINK HER)
	(FLAGS TRYTAKEBIT)
	(ACTION WOOL-F)>

<ROUTINE WOOL-F ()
	 <COND (<OR <AND <VERB? PULL-OVER>
		         <PRSI? ,EYES>>
		    <AND <VERB? MOVE>
			 <EQUAL? ,P-PRSA-WORD ,W?PULL>>>
		<COND (<ADJ-USED ,EYES ,W?MY>
		       <TELL "It can't stretch that far." CR>
		       <RTRUE>)>
		<FCLEAR ,COMEUPPANCE ,TRYTAKEBIT>
		<OFFENCE>)>>

<OBJECT DANDER
	(LOC WAITRESS)
	(DESC "dander")
	(SYNONYM DANDRUFF DANDER)
	(ADJECTIVE WAITRESS HER) ;"no apostrophe"
	(FLAGS TRYTAKEBIT)
	(ACTION DANDER-F)>

<ROUTINE DANDER-F ()
	 <COND (<VERB? STAND RAISE> ;"get up obj"
		<OFFENCE>)>>

<OBJECT CHIP
	(LOC WAITRESS)
	(DESC "chip")
	(SYNONYM WOODCHIP WOOD-CHIP CHIP)
	(ADJECTIVE WOOD)
	(FLAGS TRYTAKEBIT)
	(ACTION CHIP-F)>

<ROUTINE CHIP-F ()
	 <COND (<AND <VERB? KNOCK-OFF MUNG>
		     <OR <NOT ,PRSI>
			 <PRSI? ,SHOULDER ,WAITRESS>>>
		<REMOVE ,CHIP>
		<OFFENCE>)
	       (<VERB? TAKE>
		<WASTES>)>>

<ROOM FLOOR-2 
      (LOC ROOMS)
      (DESC "Second floor")
      (DOWN TO FLOOR-1)
      (FLAGS INDOORSBIT)
      (GLOBAL RESTAURANT STAIRS)
      (ACTION FLOOR-2-F)>

<ROUTINE FLOOR-2-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"This is the second floor of The Teapot Cafe. You're standing below a
low-slung ceiling, upon a carpet, next to an official-looking sign on the wall.
Across from you, built into a stone wall, lies a large open-air hearth which is filled with smoldering coals.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT <IN? ,WAITRESS ,HERE>>>
		<WAITRESS-COMES>)>>

<ROUTINE WAITRESS-COMES ()
	 <MOVE ,WAITRESS ,HERE>
	 <CRLF>
	 <TELL "The waitress ">
	 <COND (<PROB 40>
		<TELL "stalks">)
	       (<PROB 30>
		<TELL "stomps">)
	       (T
		<TELL "trails">)>
	 <TELL " after you." CR>
	 <RTRUE>>

<OBJECT RIOT-ACT
	(LOC FLOOR-2)
	(DESC "riot act")
	(SYNONYM ACT SIGN)
	(ADJECTIVE RIOT OFFICIAL-)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION RIOT-ACT-F)>

<ROUTINE RIOT-ACT-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL 
"\"It is unlawful for this room to be occupied by more than 350 angry
persons." CR>
		<TELL
"              -- Section 204D, paragraph 7-6, The Riot Act\"|">)
	       (<AND <VERB? READ-TO>
		     <PRSI? ,WAITRESS>>
		<OFFENCE>)		
	       (<VERB? TAKE>
		<TELL "It's firmly attached." CR>)>>

<OBJECT RAKE
	(LOC FLOOR-2)
	(DESC "rake")
	(FDESC "Leaning against the stone wall is a rake.")
	(SYNONYM RAKE)
	(FLAGS TAKEBIT)
	;(ACTION RAKE-F)>

<OBJECT COALS
	(LOC FLOOR-2)
	(DESC "coals")
	(SYNONYM COALS COAL FIRE HEARTH)
	(ADJECTIVE OPEN-AIR LARGE HOT)
	(FLAGS PLURALBIT NDESCBIT)
	(ACTION COALS-F)>

<ROUTINE COALS-F ()
	 <COND (<AND <VERB? RAKE-OVER>
		     <PRSO? ,WAITRESS>> ;"else v-rake-over"
		<OFFENCE>)
	       (<VERB? ENTER BOARD WALK-TO STAND-ON>
		<TELL "It's too hot to trot." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL "The coals in the hearth glow red and white hot." CR>
		<RTRUE>)>>
	       

<OBJECT OLIVE-TREE
	(LOC FLOOR-2)
	(DESC "olive tree")
	(LDESC "A decorative olive tree stands in the shadowy corner.")
	(SYNONYM TREE BRANCH BRANCHES OLIVE)
	(ADJECTIVE OLIVE)
	(FLAGS NO-D-CONT CONTBIT OPENBIT SEARCHBIT VOWELBIT)
	(GENERIC GEN-OLIVE)
	(ACTION OLIVE-TREE-F)>

<ROUTINE OLIVE-TREE-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <IN? ,BRANCH ,OLIVE-TREE>>
		<TELL "There's one branch loose." CR>)
	       (<AND <VERB? CUT>
		     <PRSI? ,HATCHET>>
		<COND (<IN? ,BRANCH ,OLIVE-TREE>
		       <PERFORM ,V?TAKE ,BRANCH>
		       <RTRUE>)
		      (T
		       <TELL 
"Thump! The leaves shake and shimmer in the fire light, but the tree
is undamaged." CR>)>)
	       (<NOUN-USED ,OLIVE-TREE ,W?OLIVE>
		<TELL "No olives have yet been produced." CR>)>>
		     
<OBJECT BRANCH
	(LOC OLIVE-TREE)
	(DESC "olive branch")
	(SYNONYM BRANCH)
	(ADJECTIVE OLIVE)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT VOWELBIT)
	(GENERIC GEN-OLIVE)
	(ACTION BRANCH-F)>

<ROUTINE BRANCH-F ()
	 <COND (<AND <VERB? TAKE MUNG PICK CUT>
		     <IN? ,BRANCH ,OLIVE-TREE>
		     <PRSO? ,BRANCH>
		     ;<EQUAL? <ITAKE <>> T>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<TELL
"\"Snap!\" The branch comes off in your hands." CR>)>>
		
<ROUTINE GEN-OLIVE ()
	 ,BRANCH>

<OBJECT DESSERTS
	(LOC FLOOR-2)
	(DESC "just desserts")
	(FDESC 
"Some food has been left here, no doubt by some impatient patrons of the
cafe.")
	(SYNONYM DESSERTS DESSERT FOOD)
	(ADJECTIVE JUST HER)
	(FLAGS TAKEBIT PLURALBIT NARTICLEBIT FOODBIT)
	;(GENERIC GEN-DESSERTS)
	(ACTION DESSERTS-F)>

<ROUTINE DESSERTS-F ()
	 <COND (<OR <VERB? EXAMINE>
		    <AND <VERB? SMELL>
			 <NOT <FSET? ,DESSERTS ,SEENBIT>>>>
		<FSET ,DESSERTS ,SEENBIT>
		<TELL "They're " D ,DESSERTS "." CR>)
	       (<VERB? EAT>
		<TELL 
"Since they're " D ,DESSERTS ", they don't look all that appetizing." CR>)
	       (<AND <VERB? TAKE>
		     ;<EQUAL? <ITAKE> T>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<TELL "You get your " D ,DESSERTS ,PERIOD>)>>

<OBJECT CAPE
	(LOC FLOOR-1)
	(DESC "red velvet curtain")
	(FDESC 
"A red velvet curtain appears to mark the entrance to the kitchen.")
	(SYNONYM CURTAIN CAPE)
	(ADJECTIVE RED VELVET)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION CAPE-F)>

<ROUTINE CAPE-F ()
	 <COND (<AND <TOUCHING? ,CAPE>
		     <FSET? ,CAPE ,TRYTAKEBIT>>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<OR <AND <VERB? WAVE>
		         <PRSI? ,COOK>
		         ;,IN-FRONT-FLAG>
		    <AND <VERB? WAVE>
			 <NOT ,PRSI>
		         <IN? ,COOK ,HERE>>>
		<COND (<IN? ,BAD-BLOOD ,HERE>
		       <TELL-BAD-BLOOD T> 
		       <RTRUE>)>
		<OFFENCE-COOK>)
	       (<OR <AND <VERB? WAVE>
		         <PRSI? ,WAITRESS>
		         ;,IN-FRONT-FLAG>
		    <AND <VERB? WAVE>
		         <IN? ,WAITRESS ,HERE>>>
		<TELL "Ole! The waitress pretends not to notice." CR>)>> 

;"kitchen stuff"

<ROUTINE FLOOR-1-EXIT ("AUX" SC)
	 <SET SC <GETP ,SCENE ,P?SCENE-SCORE>>
	 <COND (<G? .SC 11 ;10>
		<COND (<NOT <FSET? ,KITCHEN ,TOUCHBIT>>
		       <FCLEAR ,CAPE ,TRYTAKEBIT>
		       <FCLEAR ,CAPE ,NDESCBIT>
		       <MOVE ,CAPE ,PROTAGONIST>
		       <FSET ,CAPE ,TOUCHBIT>
		       <TELL 
"You're drawn toward the kitchen amid the fast-paced, dramatic sounds
of a big-band era orchestra -- matador music. As you make your
entrance, the red velvet curtain, now appearing like a cape, comes off
into your hands." CR CR>)>
		<RETURN ,KITCHEN>)
	       (T
		<TELL 
"As you head toward the kitchen, the waitress heads you off at the pass. ">
		<COND (<G? .SC 8>
		       <TELL 
"But you're certainly wearing down her defenses.">)
		      (<G? .SC 6>
		       <TELL "But you're gradually getting to her.">)
		      (<G? .SC 4>
		       <TELL "But you're on the right track.">)
		      (<G? .SC 2>
		       <TELL 
"You don't have nearly enough gall to storm into the kitchen, but you're
getting there.">)
		      (<NOT <ZERO? .SC>>
		       <TELL 
"You're not hot enough yet to take the kitchen by storm.">)
		      (T
		       <TELL 
"You haven't even mixed it up with the waitress. So there's no need to take
it up with the cook yet.">)>
		<CRLF>
		<RFALSE>)>>
	       
<ROOM KITCHEN 
      (LOC ROOMS)
      (DESC "Kitchen")
      (OUT PER KITCHEN-EXIT)
      (GLOBAL RESTAURANT)
      (FLAGS INDOORSBIT)
      (ACTION KITCHEN-F)>

<ROUTINE KITCHEN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The dominating feature of the kitchen is the cook, who is dwarfish in
dimension but gigantic in size." CR CR>
		<COND (<IN? ,BAD-BLOOD ,HERE>
		       <TELL
"You can immediately see there's a lot of bad blood between you and him.||">)>
		<TELL
"But he's getting all worked up over the meal he's preparing and doesn't
take notice of you. He is utterly beside himself, which takes up most of
the floor space of the kitchen. The ruffled fur is flying,
plumes of sifted flour are exploding, the briny sweat is raining through the steamy air, as the cook wreaks havoc while whipping something together.|
|
The kitchen is equipped with, among other crude devices, a grindstone.">)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <RUNNING? ,I-DEVICES>
		     ,PRSO
		     <IN? ,PRSO ,HERE>
		     <TOUCHING? ,PRSO>
		     <NOT <PRSO? ,COOK>>>
		<TELL "You're cornered, and can't reach" TR ,PRSO>)>>

<ROUTINE KITCHEN-EXIT ()
	 <COND (<RUNNING? ,I-PAN>
		<TELL "You have to get of the pan first.">)
	       (<RUNNING? ,I-DEVICES>
		<TELL "The cook has you cornered!">
		<RFALSE>)
	       (T
		<RETURN ,FLOOR-1>)>
	 <TELL ,PERIOD>
	 <RFALSE>>

<OBJECT COOK
	(LOC KITCHEN)
	(DESC "cook")
	(LDESC "The hulking, ill-mannered cook stands here.")
	(SYNONYM COOK)
	(FLAGS ACTORBIT DESC-IN-ROOMBIT CONTBIT OPENBIT SEARCHBIT NO-D-CONT)
	(ACTION COOK-F)>

;"phrasebit = turn cook into a laughing stock"

<ROUTINE COOK-F ()
	 <COND (<AND <IN? ,BAD-BLOOD ,KITCHEN>
		     <OR <VERB? TELL>
		         <TOUCHING? ,COOK>>>
		<TELL-BAD-BLOOD>) 
	       (<VERB? TELL>
		<TELL "The big guy is speechless." CR>)
	       (<VERB? EXAMINE>
		<COND (<RUNNING? ,I-DEVICES>
		       <TELL "He's approaching you with" TR ,DEVICES>)
		      (T
		       <TELL
"The cook appears to be a big man with a short fuse. His hulking figure
is covered with prickly five-and-ten o'clock shadows of hair stubble.
Blubbery hammocks of basting bicep hang
from each upper arm">
		       <COND (<NOT <FSET? ,DEVICES ,PHRASEBIT>>
			      <TELL 
", and swing heavily through the air, following the cook's mammoth
frenzy of food preparation">)>
		       <TELL ,PERIOD>)>
		<COND (<IN? ,CAN ,COOK>
		       <RFALSE>)>
		<RTRUE>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,HATCHET>>
		<RFALSE>)>>

<OBJECT BAD-BLOOD
	(LOC KITCHEN)
	(DESC "bad blood")
	(SYNONYM BLOOD)
	(ADJECTIVE BAD)
	(FLAGS DESC-IN-ROOMBIT NARTICLEBIT)
	(ACTION BAD-BLOOD-F)>

<ROUTINE BAD-BLOOD-F ()
	 <COND (<AND <VERB? CLEAN>
		     <OR <VISIBLE? ,CAPE>
			 <PRSI? ,CAPE ,NAPKIN>>>
		<UPDATE-SCORE>
		<REMOVE ,BAD-BLOOD>
		<QUEUE I-PET-PEEVE 2>
		<MOVE ,RECIPE-CARD ,COOK>
		<MOVE ,CONCOCTION ,HERE>
		<TELL 
"Down on your hands and knees, you remove the bad blood">
		<COND (<NOT <PRSI? ,NAPKIN>>
		       <TELL 
" by using the cape, which turns a deeper shade of red">)>
		<TELL ".|
|
You shuffle toward him for a closer view, and for a moment you're standing
toe to toe, but you don't see eye to eye. His nose is out of joint, which
explains why he's cutting it off to spite his face. (He flings it into his
concoction.) You can hear the volcanic roar of bitter bile in his throat,
which is making him hot under the collar, and causing smoke to pour out of
his ears.|
|
The cook glares for moment at his recipe card, and apparently you're not on
it, because he turns back in front of a large bowl and resumes madly throwing
ingredients together." CR>)
	       (<VERB? ENTER LEAP PASS>
		<TELL-BAD-BLOOD>)
	       (<VERB? CLEAN>
		<TELL "You'd need the cape." CR>)>> 
		
<ROUTINE TELL-BAD-BLOOD ("OPT" (MORE <>))
	 <COND (.MORE
		<TELL "Not a bad idea, but t">)
	       (T
		<TELL "T">)>
	 <TELL 
"here's too much " D ,BAD-BLOOD " between you and the cook." CR>>

<OBJECT RECIPE-CARD
	;(LOC COOK)
	(DESC "recipe card")
	(SYNONYM CARD)
	(ADJECTIVE RECIPE)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION RECIPE-CARD-F)>

<ROUTINE RECIPE-CARD-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"Though the card is splattered with food, you can see the name of the
concoction is \"Brew-hah-hah.\"" CR>)
	       (<VERB? TAKE>
		<TELL "He rips it away from you." CR>)
	       (<VERB? CLEAN>
		<WASTES>)>>

<ROUTINE I-PET-PEEVE ()
	 <QUEUE I-PET-PEEVE -1>
	 <COND (<EQUAL? ,HERE ,KITCHEN>
		<DEQUEUE I-PET-PEEVE>
		<MOVE ,GOAT ,HERE>
		<MOVE ,GOOSE ,HERE>
		<MOVE ,CAN ,COOK>
		<TELL CR
"Just now, two of the cook's pet peeves wander up to him, and add to the
confusion by begging loudly for scraps -- the goat bleating, and the
goose honking.|
|
The cook comes across a labeled can, picks it up, and continues scouring the
kitchen for the right ingredients." CR>)>>  

<OBJECT CAN
	;(LOC COOK)
	(DESC "laughing stock")
	(SYNONYM LAUGHINGS CAN STOCK LABEL FOOD)
	(ADJECTIVE LAUGHING)
	(FLAGS NDESCBIT TRYTAKEBIT FOODBIT)
	(ACTION CAN-F)>

<ROUTINE CAN-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL "The label reads \"Laughing stock.\"" CR>)
	       (<VERB? TAKE>
		<PERFORM ,V?TAKE ,RECIPE-CARD>
		<RTRUE>)
	       (<AND <VERB? SET>
		     <PRSO? ,COOK>>
		<OFFENCE-COOK>)>>

<OBJECT GOAT
	(DESC "cook's goat")
	(SYNONYM GOAT PEEVE PEEVES)
	(ADJECTIVE PET COOK\'S COOKS HIS)
	(FLAGS TRYTAKEBIT)
	(GENERIC GEN-PEEVES)
	(ACTION GOAT-F)>

<ROUTINE GOAT-F ()
	 <COND (<VERB? TAKE>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?GET>
		       <OFFENCE-COOK>)
		      (T
		       <TELL
"Fighting your \"take\" over, the goat slips away like a greased pig." CR>)>)>>
		 
<OBJECT GOOSE
	(DESC "cook's goose")
	(SYNONYM GOOSE PEEVE PEEVES)
	(ADJECTIVE PET COOKS COOK\'S HIS)
	(FLAGS TRYTAKEBIT)
	(GENERIC GEN-PEEVES)
	(ACTION GOOSE-F)>

<ROUTINE GOOSE-F ()
	 <COND (<VERB? COOK>
		<OFFENCE-COOK>)>>

<ROUTINE GEN-PEEVES ()
	 <COND (<PROB 50>
		,GOOSE)
	       (T
		,GOAT)>>

;"4 times offences to cook, score goes up"
<ROUTINE OFFENCE-COOK ()
	 <COND (<FSET? ,PRSO ,PHRASEBIT>
		<TELL ,ALREADY-HAVE>)
	       (T
		<FSET ,PRSO ,PHRASEBIT>
		<UPDATE-SCORE>
		<COND (<PRSO? ,GOOSE>
		       <REMOVE ,GOOSE>
		       <TELL 
"A burst of grease and flames spit up from the stunned bird, and the cook
himself emotionally melts as his goose is cooked. (So it's safer to cook
the goose than to goose the cook.)" CR>)
		      (<PRSO? ,GOAT>
		       <REMOVE ,GOAT>
		       <TELL
"The cook's goat, its hooves clanking awkwardly on the kitchen floor, is
nevertheless gotten. The cook, being steamed up, breaks your grip
on the goat, which bleats a hasty retreat." CR>)
		      (<PRSO? ,CAPE>
		       <TELL 
"Bravo! Ole! Bravo! You wave the cape, and now you've got the cook
seeing red." CR>)
		      (<PRSO? ,COOK>
		       <TELL 
"You get a lot of canned laughter coming from rows of cans, and the cook seems
to take offense." CR>)>
	       <COND (<AND <FSET? ,GOOSE ,PHRASEBIT>
			   <FSET? ,GOAT ,PHRASEBIT>
			   <FSET? ,CAPE ,PHRASEBIT>
			   <FSET? ,COOK ,PHRASEBIT>>
		      <QUEUE I-PAN -1>
		      <MOVE ,PAN ,HERE>
		      <MOVE ,PROTAGONIST ,PAN>
		      <FSET ,PAN ,TOUCHBIT>
		      <MOVE ,FIRE ,HERE>
		      <ROB ,PROTAGONIST ,HERE>
		      <TELL CR 
"Now you've really gotten him steamed up. He snatches you around the
waist, laughs heartily into your face with marinated breath, and
plops you down into the center of a large, family-size frying pan.|">)>)>
	 <RTRUE>>

<OBJECT PAN
	(DESC "frying pan")
	(SYNONYM SKILLET PAN)
	(ADJECTIVE FRYING)
	(FLAGS TRYTAKEBIT VEHBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION PAN-F)>

<ROUTINE PAN-F ("OPTIONAL" (RARG <>))
	 <COND (<AND <VERB? DISEMBARK>
		     <IN? ,PROTAGONIST ,PAN>>
		<TELL 
"Your words don't ring true against the Teflon of the pan." CR>)
	       ;(<AND <VERB? BOARD>
		     <NOT <IN? ,PROTAGONIST ,PAN>>
		     <FSET? ,PAN ,TOUCHBIT>>)
	       (<AND <VERB? LEAP-OFF>
		     <PRSI? ,FIRE>>
		<COND (<FSET? ,PAN ,PHRASEBIT>
		       <TELL ,ALREADY-HAVE>
		       <RTRUE>)>
		<MOVE ,PROTAGONIST ,HERE>
		<SETG OLD-HERE <>>
		<UPDATE-SCORE>
		<REMOVE ,PAN>
		<REMOVE ,FIRE>
		<FSET ,PAN ,PHRASEBIT>
		<DEQUEUE I-PAN>
		<TELL 
"You avoid the fate of being merely a flash in the pan by leaping from
the skillet, heedless of the heat outside it. As harmlessly as
one's hand passing quickly over a lighted candle, your entire body falls
through the large licking blue flame.
Landing on the jet, you put out the fire, and fall to the floor. The cook
angrily flings the pan into oblivion." CR CR>
		<COND (<FSET? ,DEVICES ,PHRASEBIT>
		       <MOVE ,OX ,HERE>
		       <TELL 
"And in your haste to move away from the cook, you run into an ox!">)
		      (T
		       <QUEUE I-DEVICES -1>
		       <TELL
"The cook backs you up into a corner, and begins sharpening his own devices,
bent on destroying you.">)>
		<CRLF>)>>

<GLOBAL PAN-N 0>

<ROUTINE I-PAN ()
	 <SETG PAN-N <+ ,PAN-N 1>>
	 <COND (<EQUAL? ,PAN-N 1>
		<TELL CR 
"The cook begins gathering his own devices, as flames lick up around the rim
of the frying pan">)
	       (<EQUAL? ,PAN-N 2>
		<TELL CR "Your feet are beginning to feel the heat">)
	       (<EQUAL? ,PAN-N 3>
		<TELL CR "Flames intensify up around the frying pan">)
	       (<EQUAL? ,PAN-N 4>
		<TELL CR 
"It's so hot that you're now break-dancing on the pan">)
	       (<EQUAL? ,PAN-N 5>
		<TELL "Soon your own goose will be cooked">)
	       (<EQUAL? ,PAN-N 6>
		<JIGS-UP 
"Your charred remains stick to the pan, despite its Teflon surface.">)>
	 <TELL ,PERIOD>>

<OBJECT MESS
	(LOC KITCHEN)
	(DESC "god-awful mess")
	(SYNONYM FUR FLOUR)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION MESS-F)>

<ROUTINE MESS-F ()
	 <COND (<VERB? CLEAN>
		<TELL "Not even Hercules could or would." CR>)
	       (<VERB? TAKE>
		<WASTES>)>>

<OBJECT CONCOCTION
	;(IN KITCHEN)
	(DESC "concoction")
	(SYNONYM MEAL CONCOCTION BREW-HAA-HAA BOWL POT INGREDIENTS FOOD)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION CONCOCTION-F)>

<ROUTINE CONCOCTION-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL 
"The slimy admixture of entrails, small winged insects and the occasional
fleshy ear, churns thickly within the pot..." CR>)
	       (<OR <VERB? TAKE>
		    <AND <VERB? PUT>
		         <PRSI? ,CONCOCTION>>>
		<TELL "The cook gingerly slaps the back of your hand." CR>)>>

<OBJECT FIRE
	(DESC "fire")
	(SYNONYM FIRE FLAME FLAMES)
	(FLAGS NDESCBIT)
	(ACTION FIRE-F)>
	        
<ROUTINE FIRE-F ()
	 <COND (<VERB? BOARD ENTER CLIMB-ON LEAP>
		<PERFORM ,V?LEAP-OFF ,PAN ,FIRE>
		<RTRUE>)>>

<OBJECT DEVICES
	(LOC KITCHEN)
	(DESC "his own devices")
	(SYNONYM DEVICES)
	(ADJECTIVE OWN HIS)
	(FLAGS TRYTAKEBIT NDESCBIT NARTICLEBIT)
	(GENERIC GEN-DEVICE) 
	(ACTION DEVICES-F)>

<ROUTINE DEVICES-F ()
	 <COND (<AND <VERB? LEAVE-TO>
		     <PRSO? ,COOK>>
		<COND (<FSET? ,DEVICES ,PHRASEBIT>
		       <TELL ,ALREADY-HAVE>)
		      (<AND <NOT <IN? ,PROTAGONIST ,PAN>>
			    <NOT <RUNNING? ,I-DEVICES>>>
		       <TELL 
"Good idea, but he isn't too involved with " D ,DEVICES " at the moment." CR>) 
		      (T
		       <FSET ,DEVICES ,PHRASEBIT>
		       <UPDATE-SCORE>
		       <TELL 
"A wise move, it would seem, since the cook is not adept in the application
of technology to the preparation of food. Truth will tell, he's already done
away with a cousin in a Cuisinart, lost a friend in a blender, and microwaved
a surfer." CR CR>
		       <COND (<FSET? ,PAN ,PHRASEBIT>
			      <MOVE ,OX ,HERE>
			      <DEQUEUE I-DEVICES>
			      <TELL 
"He appears to hurt himself by " D ,DEVICES ", and you get out of the corner
only to run into a big ox that happens to be wandering through the kitchen!">)
			     (T
			      <TELL
"This gives you more time to figure a way out of the pan.">)>
		       <CRLF>)>)>>

<ROUTINE GEN-DEVICE ()
	 <COND (<AND <EQUAL? <GET ,P-NAMW 0> ,W?STONE>
		     <VISIBLE? ,STONE>>
		,STONE)
	       (T
		,GRINDSTONE)>>

<GLOBAL DEVICES-N 0>

<ROUTINE I-DEVICES ()
	 <SETG DEVICES-N <+ ,DEVICES-N 1>>
	 <COND (<EQUAL? ,DEVICES-N 2>
		<TELL CR "He's about ready to get you">)
	       (<EQUAL? ,DEVICES-N 3>
		<TELL CR 
"His own devices appearing to be in working order, the cook bellows
a rotten laugh">)
	       (<EQUAL? ,DEVICES-N 3>
		<TELL CR "You're about to be gotten by his own devices">)
	       (<EQUAL? ,DEVICES-N 4>
		<TELL CR "You're dead meat any instant now">)
	       (<EQUAL? ,DEVICES-N 5>
		<CRLF>
		<CRLF>
		<JIGS-UP "The cook makes mince meat out of you.">)
	       (T
		<RFALSE>)>
	 <TELL ,PERIOD>>

<OBJECT OX
	(DESC "ox")
	(SYNONYM OX)
	(ADJECTIVE HIS COOK\'S COOKS)
	(FLAGS TRYTAKEBIT VOWELBIT)
	(ACTION OX-F)>

<ROUTINE OX-F ()
	 <COND (<VERB? KILL>
		<COND (<OR <PRSI? ,HATCHET>
			   <AND <HELD? ,HATCHET>
				<NOT ,PRSI>>>
		       <COND (<NOT <FSET? ,HATCHET ,PHRASEBIT>>
		              <TELL 
"Your axe is too dullsville." CR>
		              <RTRUE>)
			     (<NOT <EQUAL? ,P-PRSA-WORD ,W?GORE>>
			      <TELL 
"No, the hatchet slips in your hand. Well, this whole controversy seems to
pivot on the matter of whose ox is..." CR> 
			      <RTRUE>)
			     (T
			      <REMOVE ,OX>
			      <UPDATE-SCORE>
			      <QUEUE I-END-SCENE 1>
			      <TELL 
"Okay, you bury the hatchet in the animal and his ox is gored, leaving
quite a mess, but also a bone of contention. Immediately, both you and
the cook see an end to it, and each of you take a slimy end of the bone of
contention. With your eyes closed, you make a wish, as does the
burly cook.|
|
\"Snap!\" The bone breaks jaggedly, and the cook is left with the short
end of the stick.|
|
He drops to the floor, mopping up the entrails of the ox and apologizing
profusely and promising never again to wield another kitchen utensil as
long as he lives." CR>)>)
		      (<NOT ,PRSI>
		       <TELL "You don't have a weapon." CR>)>)>>