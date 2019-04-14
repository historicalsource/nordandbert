"INVIS for
			       NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."
 
<FILE-FLAGS CLEAN-STACK?>

<GLOBAL HINT-TBL FARM-HINTS> ;"table of hints for each scene"

<GLOBAL HINT-WARNING <>>

<GLOBAL HINTS-OFF <>>

<ROUTINE V-HINT ("AUX" CHR MAXQ (Q <>))
         <COND (<EQUAL? ,HERE ,STARTING-ROOM>
		<TELL 
"You must be in one of the scenarios to ask for hints." CR>
		<RTRUE>)
	       (,HINTS-OFF
		<PERFORM ,V?HINTS-NO ,ROOMS>
		<RTRUE>)
	       (<NOT ,HINT-WARNING>
		<SETG HINT-WARNING T>
		<TELL "[Warning: It is recognized that the temptation
for help may at times be so exceedingly strong that you might fetch
hints prematurely. Therefore, you may at any time during the story type
HINTS OFF, and this will disallow the seeking out of help for the
present session of the story. If you still want a hint now, indicate
HINT.]" CR>
		<RTRUE>)>
	 <BUFOUT <>>
	 <SET MAXQ <GET ,HINT-TBL 0>>
	 <INIT-HINT-SCREEN>
	 <CURSET 5 1>
	 <SETG CUR-POS 0> ;"otherwise put-up-q's starts where cursor last was"
	 <PUT-UP-QUESTIONS 1> ;"1 blank space is printed before hint subject"
	 ;<SETG CUR-POS 0>
	 ;<SETG QUEST-NUM 1>
	 <SETG CUR-POS <GETP ,SCENE ,P?SCENE-CUR>>
	 <SETG QUEST-NUM <+ ,CUR-POS 1>> ;"quest-num always plus 1"
	 ;<CURSET 5 2>
	 <NEW-CURSOR>
	 ;<PRINTI ">">
	 <REPEAT ()
		 <SET CHR <INPUT 1>>
		 <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
			<SET Q T>
			<RETURN>)
		       (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n>>
			<COND (<EQUAL? ,QUEST-NUM .MAXQ>
			       T)
			      (T
			       <ERASE-CURSOR>
			       <SETG CUR-POS <+ ,CUR-POS 1>>
			       <SETG QUEST-NUM <+ ,QUEST-NUM 1>>
			       <NEW-CURSOR>)>)
		       (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p>>
			<COND (<EQUAL? ,QUEST-NUM 1> T)
			      (T
			       <ERASE-CURSOR>
			       <SETG CUR-POS <- ,CUR-POS 1>>
			       <SETG QUEST-NUM <- ,QUEST-NUM 1>>
			       <NEW-CURSOR>)>)
		       (<EQUAL? .CHR 13 10>
			<PUTP ,SCENE ,P?SCENE-CUR ,CUR-POS>
			<DISPLAY-HINT ,QUEST-NUM> ;"starts as 1"
			<RETURN>)>>
	 <COND (<NOT .Q> <AGAIN>)> ;"AGAIN does whole routine?"
	 ;<SETG CUR-POS 0>
	 ;<SETG QUEST-NUM 1>
	 <PUTP ,SCENE ,P?SCENE-CUR ,CUR-POS>
	 <SPLIT 0>
	 <CLEAR -1>
	 <BUFOUT T>
	 <V-$REFRESH>
	 <TELL CR "Back to the story..." CR>>

;"zeroth (first) element is 5"
<GLOBAL LINE-TABLE
	<PTABLE 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
	       5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21>>
;"zeroth (first) element is 4"
<GLOBAL COLUMN-TABLE
	<PTABLE 4 4 4 4 4  4  4  4  4  4  4  4  4  4  4  4  4
	       24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24>>
;"four and nineteen are where the text of questions start"

<GLOBAL CUR-POS 0> ;"determines where to place the highlight cursor
		     Can go up to 34, that is 17 slots in each row"

<GLOBAL QUEST-NUM 1> ;"shows in HINT-TBL ltable which QUESTION it's on"

<ROUTINE ERASE-CURSOR ()
	 <CURSET <GET ,LINE-TABLE ,CUR-POS>
		 <- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	 <TELL " "> ;"erase previous highlight cursor">

;"go back 2 spaces from question text, print curser and flash is between
the curser and text"
<ROUTINE NEW-CURSOR ()
	 <CURSET <GET ,LINE-TABLE ,CUR-POS>
		 <- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	 <TELL ">"> ;"print the new cursor">

<ROUTINE INVERSE-LINE ("AUX" (CENTER-HALF <>)) 
	 <HLIGHT ,H-INVERSE>
	 <PRINT-SPACES <GETB 0 33>>
	 <HLIGHT ,H-NORMAL>>

<ROUTINE DISPLAY-HINT (N "AUX" H MX (CNT 2 ;,HINT-HINTS) CHR (FLG T))
         <SPLIT 0>
	 <CLEAR -1>
         <SPLIT 3>
	 <SCREEN ,S-WINDOW>
	 <CURSET 1 1>
	 <INVERSE-LINE>
	 <CENTER-LINE 1 "INVISICLUES" %<LENGTH "INVISICLUES">>
	 <CURSET 3 1>
	 <INVERSE-LINE>
	 <COND (,WIDE
		<TELL " ">)>
	 <LEFT-LINE 3 "RETURN = see new hint">
	 <RIGHT-LINE 3 "Q = see hint menu"
		     %<LENGTH "Q = see hint menu">>
	 <HLIGHT ,H-BOLD>
	 <SET H <GET ,HINT-TBL .N>>
	 <CENTER-LINE 2 <GET .H 1 ;,HINT-QUESTION>>
	 <HLIGHT ,H-NORMAL>
	 <SET MX <GET .H 0>>
       ; <CURSET 5 2> ;"instead of CRLF"
	 <SCREEN ,S-TEXT>
	 <CRLF>
	 <REPEAT ()
		 <COND (.FLG <TELL " -> "> <SET FLG <>>)>
		 <SET CHR <INPUT 1>>
		 <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
			;<PUT .H ,HINT-SEEN .CNT>
			;<SETG CUR-POS <GET ,SCENE ,P?SCENE-CUR>>
			<RETURN>)
		       (<EQUAL? .CHR 13 10>
			<COND (<G? .CNT .MX>
			       T)
			      (T
			       <SET FLG T> ;".cnt starts as 2"
			       <TELL <GET .H .CNT>>
			       <CRLF> <CRLF>
			       <SET CNT <+ .CNT 1>>
			       ;<CURSET <+ <* .CNT 2> 1> 2>
			       ;"3rd = line 7, 4th = line 9, ect"
			       <COND (<G? .CNT .MX>
				      <SET FLG <>>
				      <TELL "[That's all folks!]" CR>
				      ;<CURSET <* .CNT 2> 1>)>)>)>>>

<ROUTINE PUT-UP-QUESTIONS (ST "AUX" MXQ MXL)
	 <SET MXQ <GET ,HINT-TBL 0>>
	 <SET MXL <- <GETB 0 32> 1>>
	 <REPEAT ()
		 <COND (<G? .ST .MXQ>
			;<TELL CR "[Last question]" CR>
			<RETURN>)
		       (T                        ;"zeroth"
			<CURSET <GET ,LINE-TABLE ,CUR-POS>
				<- <GET ,COLUMN-TABLE ,CUR-POS> 1>>) 
		       ;(<G? .LN .MXL>
			<TELL CR "[More questions follow]" CR>
			<RETURN <- .ST 1>>)>
		 <TELL " " <GET <GET ,HINT-TBL .ST> 1 ;,HINT-QUEST>>
		 <SETG CUR-POS <+ ,CUR-POS 1>>
		 <SETG QUEST-NUM <+ ,QUEST-NUM 1>>
		 ;<CRLF> ;"above curset will do the trick?"
		 <SET ST <+ .ST 1>>>>

;"Invisiclues Stuff"

;"longest hint topic can be 17 chars"
<GLOBAL HAZING-HINTS
	<PLTABLE
	 <PLTABLE "The Lead House"
		 "This'll be a real head scratcher."
		 "Type, HEAD LOUSE.">
	 <PLTABLE "The Gritty Pearl"
		 "A gritty pearl is like a melody."
		 "PRETTY GIRL">
	 <PLTABLE "The Door Girl"
	         "\"Shine on the door.\""
		 "DINE ON THE SHORE">
	 <PLTABLE "A Pan of Keys"
		 "It's not jolly, round or green."
		 "CAN OF PEAS">
	 <PLTABLE "Gone Swimmin'"
		 "\"Shake off your toes.\""
		 "Consider the letters, not sounds."
		 "TAKE OFF YOUR SHOES">
	 <PLTABLE "Child Goose Waist"
		 "First, EXAMINE THE GOOSE."
		 "It's a LITTLE goose, a child."
		 "GO ON A WILD GOOSE CHASE..."
		 "Because that's..."
		 "... exactly what you're doing now."
		 "[There's no goose in here.]">
	 <PLTABLE "On the Rocks"
		 "Look at the rocks."
		 "Give the peas to the rocks."
		 "Now they're fed rocks."
		 "RED FOX">
	 <PLTABLE "Queer Old Dean"
		 "Her Majesty would solve this."
		 "DEAR OLD QUEEN">
	 <PLTABLE "The Leopard"
		 "Changes his spots, gets religion."
		 "LOVING SHEPHERD">
	 <PLTABLE "An Experience"
		  "E.g., when Buckwheat's scared."
		  "HAIR-RAISING EXPERIENCE">
	 <PLTABLE "Message in Sand"
		 "Shepherd leads between the Rhines."
		 "READ BETWEEN THE LINES">
	 <PLTABLE "The Dishes"
		 "You'll notice they're not clean."
		 "Try to be more \"dashing.\""
		 "Should you, DASH THE WISHES?"
		 "No! There's none around!"
		 "[This space left blank.]">	 
	 <PLTABLE "Rat and Habit"
		 "Magic? Nothing up my sleeve!"
		 "PULL THE RABBIT OUT OF THE HAT">
	 <PLTABLE "Bonfire Riddle"
		 "Do something while foam burns."
		 "The riddle book is useful here." 
		 "Try phrasing \"riddle\" as a verb."
		 "RIDDLE WHILE FOAM BURNS">
	 <PLTABLE "The Icicle"
		 "It must fall first (Bonfire hint)."
		 "It's now a well-boiled icicle."
		 "WELL-OILED BICYCLE">
	 <PLTABLE "Elf and Smock"
		 "The elf is making \"tall smock.\""
		 "Why not return the favor?"
		 "MAKE SMALL TALK WITH THE ELF"
		 "There's a lot of you in the elf."
		 "OLD SELF">
	 <PLTABLE "The Jeans"
		 "Jack never climbed a jean stalk."
		 "BEAN STALK">
	 <PLTABLE "The Client"
		 "His growth potential is big."
		 "CLEAN GIANT">
	 <PLTABLE "Squealing Mare"
		 "A mare squeal is low in nutrition."
		 "SQUARE MEAL"
		 "You've met the face of hunger."
		 "GIVE THE SQUARE MEAL TO THE GIRL">
	 <PLTABLE "The Crow"
		 "A blushing crow never hurt anyone."
		 "CRUSHING BLOW">
	 <PLTABLE "On Cloud 673"
		 "Think of the top of your head."
		 "First, wear the hat on the way up."
		 "TAKE OFF THE HAT. GIVE IT TO GIANT"
		 "Now make a heavy of the giant."
		 "Type LEAD HOUSE">
	 <PLTABLE "Descend a Cloud"
		 "The beets problem is a sleeper."
		 "BED SHEETS"
		 "You can tie and still be a winner."
		 "TIE THE SHEETS TOGETHER"
		 "CLIMB DOWN THE SHEETS">
	 <PLTABLE "Sewn to Bits"
		 "He \"sews you to another sheet.\""
		 "SHOW MYSELF TO ANOTHER SEAT">
	 <PLTABLE "Giant Defeat"
		 "It'd be a crushing defeat, too."
		 "TAKE THE BLOW. HIT GIANT WITH IT">
	 <PLTABLE "Return the pearl"
		 "First, have the GRITTY PEARL..."
		 "Also, MAKE SMALL TALK WITH ELF"
		 "Now, RIDE BIKE TO CLEARING"
		 "UNLOCK DOOR WITH THE SHINY KEY">>>
		 
<GLOBAL AISLE-HINTS
	<PLTABLE
	 <PLTABLE "Gorilla Warfare"
		 "What do primates like to eat?"
		 "OFFER BANANA SPLIT TO APE"
		 "What ape?! What banana split?!">
	 <PLTABLE "The Moose"
		 "You must whip it, chill it out."
		 "Type, MOUSSE.">
	 <PLTABLE "22 over 7"
		 "A famous fraction, a real ratio."
		 "It's called pi. So type, PIE.">
	 <PLTABLE "Cereal Murderer"
		 "How do you kill a vampire?"
		 "In the Meets Aisle is a steak."
		 "Also something for bad breath."
		 "GIVE THE MINTS TO THE VAMPIRE"
		 "KILL THE VAMPIRE WITH STAKE">
	 <PLTABLE "Little Girl"
		 "Read the ribbon she's wearing."
		 "Type, BRATWURST.">
	 <PLTABLE "Principals"
		 "Why would THEY be playing hooky."
		 "Because they lack principles?"
		 "No! This STORY lacks principals."
		 "[This space left blank.]">
	 <PLTABLE "The British Aisle"
		 "Have you read the sign?"
		 "Brits love this sweet & creamy."
		 "PUDDING SECTION">
	 <PLTABLE "The Ants"
		 "They could be your relatives."
		 "AUNTS">
	 <PLTABLE "Returning Emily"
		 "Bratwurst is on no shopping list."
		 "GIVE WORST BRAT TO AUNTS">
	 <PLTABLE "The Flour"
		 "A rose is a rose..."
		 "FLOWER">
	 <PLTABLE "A Scent"
		 "It's afforded by the flower."
		 "CENT">
	 <PLTABLE "Bear Clause"
		 "Should you give the bear a hand?"
		 "BEAR CLAWS">
	 <PLTABLE "Stationary"
		 "Get it write."
		 "Spell it STATIONERY.">
	 <PLTABLE "Wall of Quartz"
		 "Not so tough, just a half pint."
		 "KNOCK DOWN THE QUARTS">
	 <PLTABLE "Locks"
		 "The key to this one is a bit fishy."
		 "LOX"
		 "Now, REMOVE THE LOX.">
	 <PLTABLE "Door Jamb"
		 "Don't be reduced to jelly."
		 "JAM">
	 <PLTABLE "Tacks"
		 "The govt. really sticks it to you."
		 "TAX">
	 <PLTABLE "The Sail"
		 "This really cheapens everything."
		 "SALE">
	 <PLTABLE "Mussels"
	         "You may need to build a better body."
		 "MUSCLES">
	 <PLTABLE "Buy an Item"
		 "First, in the Cellar type SELLER."
		 "Also, have a cent and tax."
		 "PUT THE (ITEM) ON SALE"
		 "BUY THE (ITEM)">>>

<GLOBAL FARM-HINTS
	<PLTABLE
	 <PLTABLE "An Old Dog"
		 "The old boy's got a lot to learn."
		 "TEACH THE OLD DOG NEW TRICKS">
	 <PLTABLE "Sow's Ear"
		 "Hey, make something, 'ear me?"
		 "First, FIND A NEEDLE IN A HAYSTACK."
		 "TURN SOW'S EAR INTO A SILK PURSE">
	 <PLTABLE "Mt. Molehill"
		 "You have the power of creation."
		 "MAKE A MOUNTAIN OUT OF A MOLEHILL">
	 <PLTABLE "The Birds"
		 "TAKE THE STONE FROM THE DOG"
		 "KILL TWO BIRDS WITH ONE STONE">
	 <PLTABLE "The Wrong Tree"
		 "Tried climbing it?"
		 "What variety of spruce is it?"
		 "You're barking up the wrong tree!"
		 "[This space left blank.]">
	 <PLTABLE "Swords"
		 "If you only had a hammer..."
		 "HAMMER THE SWORDS INTO PLOWSHARES">
	 <PLTABLE "Horse + Cart"
		 "EXAMINE THE HORSE"
		 "LOOK THE GIFT HORSE IN THE MOUTH"
		 "LEAD THE HORSE TO WATER"
		 "MAKE HIM DRINK"
		 "PUT THE CART BEFORE THE HORSE"
		 "RIDE CART TO MARKET">
	 <PLTABLE "Applecart"
		 "Don't... No, DO get upset."
		 "UPSET THE APPLECART">
	 <PLTABLE "Peppers"
		 "Do as Peter Piper would."
		 "PICK A PECK OF PICKLED PEPPERS">
	 <PLTABLE "Pig 4 Sale"
		 "First, get the penny from purse."
		 "An old word for bag is poke."
		 "BUY A PIG IN A POKE. TAKE BAG"		 
		 "Go to the barn holding the bag."
		 "Now, LET THE CAT OUT OF THE BAG">
	 <PLTABLE "Donkey"
		 "First find the tail and needle."
		 "PIN THE TAIL ON THE DONKEY">
	 <PLTABLE "The Milk"
		 "The old dog will first spill it."
		 "DON'T CRY OVER SPILLED MILK">
	 <PLTABLE "Mousy Grain"
		 "(See \"Pig 4 Sale.\")">
	 <PLTABLE "Grindstone"
		 "It's skin off your nose."
		 "PUT MY NOSE TO THE GRINDSTONE">
	 <PLTABLE "Side of Barn"
		 "Just how accurate are you?"
		 "HIT THE BROAD SIDE OF THE BARN">
	 <PLTABLE "Oats"
		 "Perhaps you should get wild."
		 "SOW MY WILD OATS">>>

;"longest 35 chr"
;"29 hints for 29 points. Some hint questions give two points"
<GLOBAL RESTAURANT-HINTS
	<PLTABLE
	 <PLTABLE "Eyes Have It"
		 "LOOK AT WAITRESS WITH JAUNDICED EYE"
		 "GIVE THE WAITRESS AN EVIL EYE"> ;"2"
	 <PLTABLE "Micky Spleen"
		 "You need to air out some anger."
		 "VENT MY SPLEEN UPON THE WAITRESS"> ;"3"
	 <PLTABLE "Tablecloth"
		 "LOOK AT TABLECLOTH"
		 "GIVE THE WAITRESS SHORT SHRIFT"> ;"4"
	 <PLTABLE "Your Table"
		 "You may notice it swivels."
		 "TURN THE TABLES ON THE WAITRESS">
	 <PLTABLE "The Shadows"
		 "Shadows are also known as umbrage."
		 "TAKE UMBRAGE WITH THE WAITRESS"> ;"5"
	 <PLTABLE "Lions' Share"
		 "What's a group of lions called?"
		 "SWALLOW MY PRIDE"> ;"6"
	 <PLTABLE "Pie"
		 "Eat it, just eat it..."> ;"7"
	 <PLTABLE "Crow"
		 "Eat crow, and it's nitty-gritty."
		 "GET DOWN TO THE NITTY-GRITTY"> ;"28"	 
	 <PLTABLE "A Turkey"
		 "TALK TURKEY"
		 "GO COLD TURKEY"
		 "GOBBLE GOBBLE"
		 "There's no turkey, turkey!">
	 <PLTABLE "Rump Roast"
		 "Consider an act of humility."
		 "TURN THE OTHER CHEEK"> ;"8"
	 <PLTABLE "Headband"
		 "Examine it. Made of wool, eh?"
		 "PULL THE WOOL OVER HER EYES"> ;"9"
	 <PLTABLE "Dander"
		 "This point should surely be raised."
		 "GET HER DANDER UP"> ;"10"
	 <PLTABLE "Woodchip"
		 "Okay, now just knock it off."
		 "KNOCK THE CHIP OFF HER SHOULDER"> ;"11"
	 <PLTABLE "A Fortune"
		 "BREAK THE COOKIE"
		 "Now how should you take the advice?"
		 "First, SHAKE SALT SHAKER."
		 "TAKE ADVICE WITH A GRAIN OF SALT"> ;"12"
	 <PLTABLE "Neon Sign"
		 "First solve the headband problem..."
		 "... In order to take the sign."
		 "GIVE THE WAITRESS HER COMEUPPANCE"> ;"13"
	 <PLTABLE "Riot Act"
		 "READ WAITRESS THE RIOT ACT"> ;"14"
	 <PLTABLE "Desserts"
		 "You could make them the waitress's."
		 "GIVE WAITRESS HER JUST DESSERTS"> ;"15"
	 <PLTABLE "Olive Tree"
		 "BREAK OFF A BRANCH"
		 "OFFER AN OLIVE BRANCH TO WAITRESS"> ;"16"
	 <PLTABLE "The Coals"
		 "The waitress could use a rake-over."
		 "RAKE WAITRESS OVER THE COALS"> ;"17"
	 <PLTABLE "Napkin"
		 "Time to make your peace?"
		 "WAVE THE WHITE FLAG"> ;"27"
	 <PLTABLE "Ceiling"
		 "There's no ceiling on your anger."
		 "HIT THE CEILING"> ;"18"
	 <PLTABLE "The Carpet"
		 "Consider it the waitress's calling."
		 "CALL THE WAITRESS ONTO THE CARPET"> ;"19"
	 <PLTABLE "Blood Caper"
		 "The blood requires some absorbing."
		 "WIPE UP THE BLOOD WITH THE CAPE"
		 "Now, WAVE THE RED CAPE."> ;"21 and 29"
	 <PLTABLE "Pet Peeves"
		  "They are both the cook's very own."
		  "GET THE COOK'S GOAT. COOK HIS GOOSE"> ;"22"
	 <PLTABLE "Can Can"
		 "First, read the label."
		 "MAKE A LAUGHING STOCK OUT OF COOK"> ;"23"
	 <PLTABLE "Frying Pan"
		 "Try going from bad to worse?"
		 "JUMP FROM FRYING PAN INTO THE FIRE"> ;"24"
	 <PLTABLE "Own Devices"
		 "Might be hoisted on his own petard?"
		 "LEAVE THE COOK TO HIS OWN DEVICES"> ;"25"
	 <PLTABLE "Ox-idental"
		 "All depends on whose ox is gored."
		 "First, SHARPEN THE AX."
		 "Now, GORE THE OX.">>> ;"26 and 31"

<GLOBAL JOAT-HINTS
	<PLTABLE
	 <PLTABLE "Traits"
		 "What is a Jack of all Traits?"
		 "It depends on how you use it."
		 "Don't let it out of your sight!">
	 <PLTABLE "Flipjacks"
		 "First, HEAT THE GRIDDLE"
		 "Now, MIX THE BATTER"
		 "Flipjacks?! You've flipped!">
	 <PLTABLE "Cottony Fur"
		 "Is it a pet peeve of yours?"
		 "PULL THE TAIL">
	 <PLTABLE "Coldness"
		 "Examine the jack of all traits."
		 "WEAR THE SLEEVES">
	 <PLTABLE "Nose Nipping"
		 "He embodies coldness itself."
		 "JACK FROST">
	 <PLTABLE "The Old Man"
		 "Can his misery be lightened?"
		 "TURN THE CRANK">
	 <PLTABLE "On Frozen Pond"
		 "How can you best break the ice?"
		 "TURN ON SWITCH">
	 <PLTABLE "The Mermaid"
		 "She's freezing to death!"
		 "TURN FAUCET"
		 "After she's warmed, PULL THE PLUG."
		 "EXAMINE MERMAID"
		 "Now, PULL OUT THE BLADE then..."
		 "... CUT FISHING LINE">>>

<GLOBAL DUELING-HINTS
	<PLTABLE
	 <PLTABLE "Old Bottle"
		 "Find it in the medicine cabinet."
		 "It's antique, nice for interiors."
		 "PUT THE OLD BOTTLE ON THE MANTEL"
		 "Then type, YES"
	         "When the Interior asks what you..."
		 "...want in return for the bottle..."
		 "...type, LOUIS XIV CHAIR.">
	 <PLTABLE "Kremlin"
		 "This communist fears insurgency."
		 "First, find the clock and the box."
		 "Wind the clock. Put it in the box."
		 "CLOSE BOX. GO TO KREMLIN">
	 <PLTABLE "The Safe"
		 "You don't have a leg to stand on."
		 "Try a chair (see Old Bottle hint)."
		 "Any kind of key will fit the lock."
		 "UNLOCK THE SAFE WITH THE CLOCK KEY.">
	 <PLTABLE "The Chain Mail"
		 "It's not really your size?"
		 "Perhaps it's really a chain letter."
		 "P.S.: What chain?! What letter!?"
		 "[This space left blank.]">
	 <PLTABLE "Revolution"
		 "You say you have a rev-o-lu-tion."
		 "Something needs to be set right."
		 "In the Attic, REVOLVE THE ATTIC.">>>

<GLOBAL EIGHT-HINTS
	<PLTABLE
	 <PLTABLE "The Horn"
		 "Notice the fraction of laws."
		 "There are 9/10ths of the law."
		 "POSSESSION IS NINE TENTHS OF LAW"
		 "Or, TAKE POSSESSION OF THE HORN."
		 "The mayor respects boasting."
		 "When he's here, TOOT YOUR OWN HORN.">
	 <PLTABLE "Laurel Bush"
		 "You might, BEAT AROUND THE BUSH."
		 "TAKE A LAUREL BRANCH, and only..."
		 "After the mayor has signed..."
		 "You can, REST ON MY LAURELS.">
	 <PLTABLE "Piece of Cake"
		 "Life's a bowl of cherries when..."
		 "You read through all the hints.">
	 <PLTABLE "A Blessing"
		 "It must first be concealed."
		 "Retrieve the disguise from inside." 
		 "PUT BLESSING IN DISGUISE"
		 "Now you can take it into the house."
		 "BLESS THE MAYOR">
	 <PLTABLE "Six Pack"
		 "You must take it UNDERhandedly."
		 "The document contains pretenses."
		 "TAKE THE BEER UNDER FALSE PRETENSES">
	 <PLTABLE "The Duck"
		 "It's a politician whose time is up."
		 "Refer to it as a LAME DUCK.">
	 <PLTABLE "A Jar"
		 "When is a jar not a jar?"
		 "Refer to it as A DOOR.">
	 <PLTABLE "The Comb"
		 "Its fine teeth won't miss a thing."
		 "SEARCH CLOSET WITH FINE-TOOTH COMB">
	 <PLTABLE "Skeleton"
		 "Rid the mayor of it for good."
		 "GIVE THE SKELETON THE DEEP SIX">
	 <PLTABLE "Dirty Linen"
		 "Such corruption needs airing out."
		 "WASH THE DIRTY LINEN IN PUBLIC">
	 <PLTABLE "Bathing Mayor"
		 "Dubbed \"Baby,\" he's in bathwater."
		 "THROW OUT BABY WITH THE BATHWATER">
	 <PLTABLE "Mother Decree"
		 "After you've won his respect..."
		 "GIVE THE DECREE TO THE MAYOR">>>

;"10 possible points, 3 for knock jokes plus 7 more hints."
<GLOBAL COMEDY-HINTS
	<PLTABLE
	 <PLTABLE "Knock Knock"
		 "Just answer, WHO'S THERE."
		 "If the response is \"Wilfred\"..."
		 "Just answer, WILFRED WHO.">
	 <PLTABLE "Front Bottle"
		 "Rather a bottle in front of me..."
		 "... than a frontal lobotomy."
		 "With the knife, GIVE BOB A LOBOTOMY.">
	 <PLTABLE "Water Bottle"
		 "BLOW UP THE BOTTLE"
		 "When Bob leaves the room..."
		 "PUT BOTTLE UNDER THE SEAT CUSHION">
	 <PLTABLE "Your Kazoo"
		 "It's a real humdinger."
		 "Play \"Stairway to Heaven\" on it."
		 "No such kazoo is to be found.">
	 <PLTABLE "Cord Gloves"
		 "The answer is shockingly simple."
		 "WEAR GLOVES THEN PICK UP THE WIRE"
		 "SHAKE HANDS WITH BOB">
	 <PLTABLE "The Fly"
		 "What's it doing in Bob's soup?"
		 "THE BACKSTROKE">
	 <PLTABLE "Lamp Shade"
		 "Are you just after cheap laughs?"
		 "Of course! WEAR THE LAMP SHADE.">
	 <PLTABLE "Match Stick"
		 "LOOK AT BOB. Give you a hot idea?"
		 "LIGHT THE MATCH"
		 "PUT THE MATCH IN BOB'S SHOE">
	 <PLTABLE "The Sponge"
		 "There's more than one sponge here."
		 "Refer to Bob as a sponge.">>>

<ROUTINE INIT-HINT-SCREEN ("AUX" WID LEN)
	 <SET WID <GETB 0 33>>
	 <SPLIT 0>
	 <CLEAR -1>
	 ;<SPLIT <GETB 0 32>>
	 <SPLIT <- <GETB 0 32> 1>>
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 <CURSET 1 1>
	 <INVERSE-LINE>
	 <CURSET 2 1>
	 <INVERSE-LINE>
	 <CURSET 3 1>
	 <INVERSE-LINE>
	 <CENTER-LINE 1 "INVISICLUES" 11>
	 <LEFT-LINE 2 " N = next">
	 <RIGHT-LINE 2 "P = previous" %<LENGTH "P = previous">>
	 <LEFT-LINE 3 " RETURN = See hint">
	 <RIGHT-LINE 3 "Q = Resume story" %<LENGTH "Q = Resume story">>>

;<CONSTANT HINT-COUNT 0>
;<CONSTANT HINT-QUESTION 1>
;<CONSTANT HINT-SEEN 2>
;<CONSTANT HINT-OFF 3>
;<CONSTANT HINT-HINTS 4>

;<DEFINE NEW-HINT (NAME Q "ARGS" HINTS)
	<SETG .NAME 1>
	<COND (<G? <LENGTH .Q> 39>
	       <ERROR QUESTION-TOO-LONG!-ERRORS NEW-HINT .Q>)>
	<LTABLE .Q
		4
		.NAME
		!.HINTS>>

;<GLOBAL HINT-FLAG-TBL <TABLE 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>>

<ROUTINE CENTER-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	 <COND (<ZERO? .LEN>
		<DIROUT ,D-TABLE-ON ;,DIROUT-TBL ,SLINE>
		<TELL .STR>
		<DIROUT ,D-TABLE-OFF>
		<SET LEN <GET ;,DIROUT-TBL ,SLINE 0>>)>
	 <CURSET .LN </ <- <GETB 0 33> .LEN> 2>>
	 <COND (.INV <HLIGHT ,H-INVERSE>)>
	 <TELL .STR>
	 <COND (.INV <HLIGHT ,H-NORMAL>)>>

<ROUTINE LEFT-LINE (LN STR "OPTIONAL" (INV T))
	 <CURSET .LN 1>
	 <COND (.INV <HLIGHT ,H-INVERSE>)>
	 <TELL .STR>
	 <COND (.INV <HLIGHT ,H-NORMAL>)>>

<ROUTINE RIGHT-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	 <COND (<ZERO? .LEN>
		<DIROUT 3 ;,DIROUT-TBL ,SLINE>
		<TELL .STR>
		<DIROUT -3>
		<SET LEN <GET ;,DIROUT-TBL ,SLINE 0>>)>
	 <CURSET .LN <- <GETB 0 33> .LEN>>
	 <COND (.INV <HLIGHT ,H-INVERSE>)>
	 <TELL .STR>
	 <COND (.INV <HLIGHT ,H-NORMAL>)>>
	 
;<GLOBAL DIROUT-TBL <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>>