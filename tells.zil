"TELLS for
		            NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"macros"

<TELL-TOKENS (CRLF CR)   <CRLF>
	     ;[D ,SIDEKICK <DPRINT-SIDEKICK>]
	     D *	 <DPRINT .X>
	     A *	 <APRINT .X>
	     T ,PRSO 	 <TPRINT-PRSO>
	     T ,PRSI	 <TPRINT-PRSI>
	     T *	 <TPRINT .X>
	     AR *	 <ARPRINT .X>
	     TR *	 <TRPRINT .X>
	     N *	 <PRINTN .X>
	     C *         <PRINTC .X>
	     T-IS-ARE *  <IS-ARE-PRINT .X>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <CHTYPE <COND (<==? .X PRSA>
						    <PARSE
						     <STRING "V?"
							     <SPNAME .ATM>>>)
						   (ELSE .ATM)> GVAL>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O
				      (<FORM EQUAL? <CHTYPE .X GVAL> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (<EQUAL? .X FSET?> <FORM OR !.O>)
				       (ELSE <FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <FORM GVAL .ATM>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 8> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

;"PICK-NEXT expects an LTABLE of strings, with an initial element of 2."

<ROUTINE PICK-NEXT (TBL "AUX" CNT STR)
	 <SET CNT <GET .TBL 1>>
       	 <SET STR <GET .TBL .CNT>>       
	 <INC CNT>
	 <COND (<G? .CNT <GET .TBL 0>>
		<SET CNT 2>)>
	 <PUT .TBL 1 .CNT>
	 <RETURN .STR>>

<ROUTINE PICK-ONE (TBL "AUX" LENGTH CNT RND MSG RFROB)
	 <SET LENGTH <GET .TBL 0>>
	 <SET CNT <GET .TBL 1>>
	 <SET LENGTH <- .LENGTH 1>>
	 <SET TBL <REST .TBL 2>>
	 <SET RFROB <REST .TBL <* .CNT 2>>>
	 <SET RND <RANDOM <- .LENGTH .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .LENGTH> 
		<SET CNT 0>)>
	 <PUT .TBL 0 .CNT>
	 .MSG>

<ROUTINE DPRINT (OBJ)
	 <COND ;(<EQUAL? .OBJ ,SULTANS-WIFE>
		<TELL "Sultan">
		<COND (,MALE
		       <TELL "'s wife #">)
		      (T
		       <TELL "ess' husband #">)>
		<PRINTN ,CHOICE-NUMBER>)
	       ;(<FSET? .OBJ ,UNTEEDBIT>
		<TELL <GETP .OBJ ,P?NO-T-DESC>>)
	       (<GETP .OBJ ,P?OLDDESC>
		<COND (<FSET? .OBJ ,OLDBIT>
		       ;<HLIGHT ,H-INVERSE>
		       <TELL <GETP .OBJ ,P?OLDDESC>>
		       ;<HLIGHT ,H-NORMAL>)
		      (T
		       <TELL <GETP .OBJ ,P?NEWDESC>>)>)
	       (<AND <GETP .OBJ ,P?JACKDESC>
		     <EQUAL? .OBJ ,JACK-IS>>
		<TELL <GETP ,JACK-IS ,P?JACKDESC>>)
	       (<GETP .OBJ ,P?SDESC>
	        <TELL <GETP .OBJ ,P?SDESC>>)
	       (T
	        <PRINTD .OBJ>)>>

;<ROUTINE DPRINT-SIDEKICK ()
	 <DPRINT ,SIDEKICK>>

<ROUTINE APRINT (OBJ)
	 <COND (<OR <FSET? .OBJ ,NARTICLEBIT>
		    <FSET? .OBJ ,NOA>
		    <FSET? .OBJ ,PLURALBIT>> ;"added for j3"
		<TELL " ">)
	       (<FSET? .OBJ ,VOWELBIT>
		<TELL " an ">)
	       (T
		<TELL " a ">)>
	 <DPRINT .OBJ>>

<ROUTINE TPRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (T
		<TELL " the ">)>
	 <DPRINT .OBJ>>

<ROUTINE TPRINT-PRSO ()
	 <TPRINT ,PRSO>>

<ROUTINE TPRINT-PRSI ()
	 <TPRINT ,PRSI>>

<ROUTINE ARPRINT (OBJ)
	 <APRINT .OBJ>
	 <TELL ,PERIOD>>

<ROUTINE TRPRINT (OBJ)
	 <TPRINT .OBJ>
	 <TELL ,PERIOD>>

<ROUTINE IS-ARE-PRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (T
		<TELL " the ">)>
	 <DPRINT .OBJ>
	 <COND (<FSET? .OBJ ,PLURALBIT>
		<TELL " are ">)
	       (T
		<TELL " is ">)>>

;<DEFINE PSEUDO ("TUPLE" V)
	<MAPF ,PLTABLE
	      <FUNCTION (OBJ)
		   <COND (<N==? <LENGTH .OBJ> 3>
			  <ERROR BAD-THING .OBJ>)>
		   <MAPRET <COND (<NTH .OBJ 2>
				  <VOC <SPNAME <NTH .OBJ 2>> NOUN>)>
			   <COND (<NTH .OBJ 1>
				  <VOC <SPNAME <NTH .OBJ 1>> ADJECTIVE>)>
			   <3 .OBJ>>>
	      .V>>

;"MAIN-LOOP and associated routines"

<CONSTANT M-BEG 1>
<CONSTANT M-ENTER 2>
<CONSTANT M-LOOK 3>
<CONSTANT M-FLASH 4>
<CONSTANT M-OBJDESC 5>
<CONSTANT M-END 6>
;<CONSTANT M-SMELL 7>
<CONSTANT M-FATAL 8>
<CONSTANT M-OBJDESC? 9>

<ROOM WARNING
      (LOC ROOMS)
      (DESC "WARNING!")
      (SYNONYM ZZMGCK) ;"No, this synonym doesn't need to exist... sigh">

<ZSTART GO> ;"else, ZIL gets confused between verb-word GO and routine GO"

<GLOBAL WIDTH 0>

<GLOBAL WIDE <>>

<GLOBAL DATELINE T>

<ROUTINE GO ()
	 ;"put interrupts on clock chain"
	 ;"set up and go"
	 <SETG WIDTH <GETB 0 33>>
	 <COND (<G? ,WIDTH 76>
		<SETG WIDE T>)
	       (T
		<PUTP ,FROST-ROOM ,P?SDESC "Whiteness">)>
	 <PUTB ,P-LEXV 0 59>
	 <SETG WINNER ,PROTAGONIST>
	 <SETG HERE ,STARTING-ROOM>
	 <V-$REFRESH>
	 <TELL CR
"Untied Press International|
|
  PUNSTER (UPI) - Citizens of the little town of Punster have recently
been victimized by a series of strange happenings which have ground local
businesses to a halt and played havoc with everyday life.|
  The wide-spread plague seems to be focused on the area of language
itself. In some cases, what were once simple actions to perform now
require the use of old, time-worn phrases.|
  In other cases, objects and even citizens have been transformed
overnight into strange mutations of their previous selves.|
  A man-on-the-street interview conducted by this reporter proved
fruitless. Two local farmers asked for their opinions of the situation
said they couldn't make head or tail of it, and made no further
statement.|
  The mayor of Punster, whose administration has been widely viewed as
being paralyzed and corrupted by the plague, could not be reached for
comment.|
  Meanwhile, a Citizens' Action Committee was recently formed to probe for
ways to restore the town of Punster to its happily mundane condition.|
|
[Reporter's Note: This story was compiled with help from whoever it was|
who untied me so I could type out this story.]|">
	 <GET-KEY>
	 <V-$REFRESH ;T>
	 <V-VERSION>
	 <CRLF>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>

<ROUTINE GET-KEY ("AUX" X)
	 <TELL CR "[Press any key to begin.]" CR>
	 <SETG DATELINE <>>
	 <SET X <INPUT 1>>
	 <RTRUE>>

;<ROUTINE CLEAR-SCREEN ("AUX" (CNT 24))
	 <REPEAT ()
		 <CRLF>
		 <SET CNT <- .CNT 1>>
		 <COND (<0? .CNT>
			<RETURN>)>>>

<ROUTINE MAIN-LOOP ("AUX" TRASH)
	 <REPEAT ()
		 <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP ONUM)
  <SET CNT 0>
  <SET OBJ <>>
  <SET PTBL T>
  <COND (<SETG P-WON <PARSER>>
	 <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	 <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	 <COND (<AND ,P-IT-OBJECT
		     <ACCESSIBLE? ,P-IT-OBJECT>>
		<SET TMP <>>
		<REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
			<RETURN>)
		       (T
			<COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
			       ;<COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
			       <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
			       <SET TMP T>
			       <RETURN>)>)>>
		<COND (<NOT .TMP>
		       <SET CNT 0>
		       <REPEAT ()
			<COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
			       <RETURN>)
			      (T
			       <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
				      ;<COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
				      <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
				      <RETURN>)>)>>)>
		<SET CNT 0>)>
	 <SET ONUM <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
	 <SET NUM
	      <COND (<OR <ZERO? .OCNT>
			 <AND <ZERO? .ICNT>
			      <EQUAL? .ONUM 2>>>
		     0)
		    (<G? .OCNT 1>
		     <SET TBL ,P-PRSO>
		     <COND (<ZERO? .ICNT> <SET OBJ <>>)
			   (T <SET OBJ <GET ,P-PRSI 1>>)>
		     .OCNT)
		    (<G? .ICNT 1>
		     <SET PTBL <>>
		     <SET TBL ,P-PRSI>
		     <SET OBJ <GET ,P-PRSO 1>>
		     .ICNT)
		    (T 1)>>
	 <COND (<AND <NOT .OBJ>
		     <1? .ICNT>>
		<SET OBJ <GET ,P-PRSI 1>>)>
	 <COND (<EQUAL? ,PRSA ,V?WALK>
		<SET V <PERFORM-PRSA ,PRSO>>)
	       (<0? .NUM>
		<COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
		       <SET V <PERFORM-PRSA>>
		       <SETG PRSO <>>)
		      ;(<NOT ,LIT>
		       <TELL ,TOO-DARK CR>
		       <STOP>)
		      (<AND <EQUAL? .OBJ ,PAN-OF-KEYS>
			    <EQUAL? ,PRSA ,V?TAKE>
			    ;<G? .NUM 1>
			    <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0>
			     ,W?ALL
			     ,W?EVERYTHING>>
		       <SETG CLOCK-WAIT T>
		       <WASTES>
		       <STOP>)
		      (<VERB? NO-VERB>
		       <RECOGNIZE>
		       <SET V <>>
		       <STOP>)
		      (<VERB? TAKE-UNDER>
		       <TELL "You can't use \"all\" that way." CR>)
		      (T
		       <TELL "There isn't anything to ">
		       <SET TMP <GET ,P-ITBL ,P-VERBN>>
		       <COND (<VERB? TELL>
			      <TELL "talk to">)
			     ;(<VERB? NO-VERB>
			      <TELL "examine">)
			     (<OR ,P-OFLAG ,P-MERGED>
			      <PRINTB <GET .TMP 0>>)
			     (T
			      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
		       <TELL "!" CR>
		       <SET V <>>
		       <STOP>)>)
	       (T
		<SETG P-NOT-HERE 0>
		<SETG P-MULT <>>
		<COND (<G? .NUM 1>
		       <SETG P-MULT T>)>
		<SET TMP <>>
		<REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			<COND (<G? ,P-NOT-HERE 0>
			       <TELL "[The ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
				      <TELL "other ">)>
			       <TELL "object">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "s">)>
			       <TELL " that you mentioned ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "are">)
				     (T
				      <TELL "is">)>
			       <TELL "n't here.]" CR>)
			      (<NOT .TMP>
			       <REFERRING>)>
			<RETURN>)
		       (T
			<COND (.PTBL
			       <SET OBJ1 <GET ,P-PRSO .CNT>>)
			      (T
			       <SET OBJ1 <GET ,P-PRSI .CNT>>)>
			<SETG PRSO <COND (.PTBL
					  .OBJ1)
					 (T
					  .OBJ)>>
			<SETG PRSI <COND (.PTBL
					  .OBJ)
					 (T
					  .OBJ1)>>
			<COND (<AND <G? .NUM 1>
				    <EQUAL? ,SCENE ,HAZING ,AISLE>
				    <NOT <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0>
				    ,W?ALL
				    ,W?EVERYTHING>>>
			       <SETG CLOCK-WAIT T>
			       <PREGNANT>
			        ;<SET V <>>  
 			       <RETURN>)
			      (<OR <G? .NUM 1>
				   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0>
					,W?ALL
					,W?EVERYTHING>>
			       <COND (<DONT-ALL .OBJ1>
				      <AGAIN>)
				     (T
				      <COND (<EQUAL? .OBJ1 ,IT>
					     <TELL D ,P-IT-OBJECT>)
					    (<EQUAL? .OBJ1 ,HIM>
					     <TELL D ,P-HIM-OBJECT>)
					    (<EQUAL? .OBJ1 ,HER>
					     <TELL D ,P-HER-OBJECT>)
					    (T
					     <TELL D .OBJ1>)>
				      <TELL ": ">)>)>
			<SET TMP T>
			<SET V <PERFORM-PRSA ,PRSO ,PRSI>>
			<COND (<EQUAL? .V ,M-FATAL>
			       <RETURN>)>)>>)>
	 ;<COND (,IN-FRONT-FLAG
		   <SETG L-FRONT-FLAG T>)
		  (T
		   <SETG L-FRONT-FLAG <>>)>
	 <COND (<EQUAL? .V ,M-FATAL>
		<SETG P-CONT <>>)>
	 <COND (<AND <CLOCKER-VERB?>
		     <NOT <VERB? TELL>>
		     ,P-WON ;"fake YOU CANT SEE responses set P-WON to false">
		<SET V <APPLY <GETP ,HERE ,P?ACTION> ,M-END>>)>)
	(T
	 <SETG P-CONT <>>)>
  <COND (,P-WON
	 <COND (<AND <VERB? WAIT>
		      ,DONT-FLAG>
		T)
	       (<CLOCKER-VERB?>
	      ; <STATUS-LINE>
		<SET V <CLOCKER>>)>
	 <SETG P-NUMBER 0> ;"added for wordplay"
	 <STATUS-LINE>
	 ;<V-$REFRESH T> ;"Call v-$refresh only to change depth of stat line"
	 <SETG PRSA <>>
	 <SETG PRSO <>>
	 <SETG PRSI <>>)>>
		   		   
<ROUTINE DONT-ALL (OBJ1 "AUX" (L <LOC .OBJ1>))
	 ;"RFALSE if OBJ1 should be included in the ALL, otherwise RTRUE"
	 <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		<SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
		<RTRUE>)
	       (<AND <VERB? TAKE> ;"TAKE prso FROM prsi and prso isn't in prsi"
		     ,PRSI
		     <NOT <IN? ,PRSO ,PRSI>>>
		<RTRUE>)
	       (<NOT <ACCESSIBLE? .OBJ1>> ;"can't get at object"
		<RTRUE>)
	       (<EQUAL? ,P-GETFLAGS ,P-ALL> ;"cases for ALL"
		<COND (<AND ,PRSI
			    <PRSO? ,PRSI>>
		       <RTRUE>)
		      (<VERB? TAKE> 
		       ;"TAKE ALL and object not accessible or takeable"
		       <COND (<AND <NOT <FSET? .OBJ1 ,TAKEBIT>>
				   <NOT <FSET? .OBJ1 ,TRYTAKEBIT>>>
			      <RTRUE>)
			     (<AND <NOT <EQUAL? .L ,WINNER ,HERE ,PRSI>>
				   <NOT <EQUAL? .L <LOC ,WINNER>>>>
			      <COND (<AND <FSET? .L ,SURFACEBIT>
				     	  <NOT <FSET? .L ,TAKEBIT>>> ;"tray"
				     <RFALSE>)
				    (T
				     <RTRUE>)>)
			     (<AND <NOT ,PRSI>
				   <HELD? ,PRSO>> ;"already have it"
			      <RTRUE>)
			     (<EQUAL? .OBJ1 ,COMEUPPANCE ,UMBRAGE ,SHRIFT
				      ,CAPE>
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<AND <VERB? DROP PUT PUT-ON GIVE SGIVE>
			    ;"VERB ALL, object not held"
			    <NOT <IN? .OBJ1 ,WINNER>>>
		       <RTRUE>)
		      (<AND <VERB? PUT PUT-ON> ;"PUT ALL IN X,obj already in x"
			    <NOT <IN? ,PRSO ,WINNER>>
			    <HELD? ,PRSO ,PRSI>>
		       <RTRUE>)>)>>

;<GLOBAL FIRST-BUFFER <ITABLE BYTE 100>>

;<ROUTINE SAVE-INPUT (TBL "AUX" (OFFS 0) CNT TMP)
	 <SET CNT <+ <GETB ,P-LEXV <SET TMP <* 4 ,P-INPUT-WORDS>>>
		     <GETB ,P-LEXV <+ .TMP 1>>>>
	 <COND (<EQUAL? .CNT 0> ;"failed"
		<RFALSE>)>
	 <SET CNT <- .CNT 1>>
	 <REPEAT ()
		 <COND (<EQUAL? .OFFS .CNT>
			<PUTB .TBL .OFFS 0>
			<RETURN>)
		       (T
			<PUTB .TBL .OFFS <GETB ,P-INBUF <+ .OFFS 1>>>)>
		 <SET OFFS <+ .OFFS 1>>>
	 <RTRUE>>

;<ROUTINE RESTORE-INPUT (TBL "AUX" CHR)
	 <REPEAT ()
		 <COND (<EQUAL? <SET CHR <GETB .TBL 0>> 0>
			<RETURN>)
		       (T
			<PRINTC .CHR>
			<SET TBL <REST .TBL>>)>>>

;"i.e., a verb that RUNS the clock"
<ROUTINE CLOCKER-VERB? ()
	 <COND (<VERB? VERSION HINT SCORE ;$RECORD ;$UNRECORD ;$COMMAND 
		       ;$RANDOM SAVE RESTORE RESTART QUIT SCRIPT UNSCRIPT
		       BRIEF SUPER-BRIEF VERBOSE $VERIFY>
		<RFALSE>) ;"Note rfalse"
	       (T
		<RTRUE>)>>

<GLOBAL P-WON <>>

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>

<ROUTINE FAKE-ORPHAN ("OPTIONAL" (IT-WAS-USED <>) "AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <TELL "[Be specific: Wh">
	 <COND (.IT-WAS-USED
		<TELL "at object">)
	       (T
		<TELL "o">)>
	 <TELL " do">
	 <COND (,DONT-FLAG
		<TELL "n't">)>
	 <TELL " you want to ">
	 <COND (<EQUAL? .TMP 0>
		<TELL "tell">)
	       (<0? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <PREP-PRINT <GETB ,P-SYNTAX ,P-SPREP1>>
	 <TELL "?]" CR>>

<GLOBAL NOW-PRSI <>> 

<ROUTINE NOW-PRSI-KLUDGE ()
	 <SETG NOW-PRSI <>>
	 <RTRUE>>

<ROUTINE PERFORM-PRSA ("OPTIONAL" (O <>) (I <>))
	 <PERFORM ,PRSA .O .I>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI)
	;<COND (,DEBUG
	       <TELL "[Perform: ">
	       %<COND (<GASSIGNED? ZILCH>
		       '<TELL N .A>)
		      (T
		       '<PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>)>
	       <COND (.O
		      <TELL " / PRSO = ">
		      <COND (<NOT <EQUAL? .A ,V?WALK>>
			     <TELL D .O>)
			    (T
			     <TELL N .O>)>)>
	       <COND (.I <TELL " / PRSI = " D .I>)>
	       <TELL "]" CR>)>
	;<COND (,DEBUG
	       <COND (,P-PRSA-WORD
		      <TELL "P-PRSA-WORD is ">
		      <PRINTB ,P-PRSA-WORD>)
		     (T
		      <TELL "No P-PRSA-WORD">)>
	       <CRLF>
	       <COND (<NOT <ZERO? <GET ,P-NAMW 0>>>
		      <TELL "P-NAMW for PRSO is ">
		      <PRINTB <GET ,P-NAMW 0>>
		      <COND (<NOT <ZERO? <GET ,P-ADJW 0>>>
		             <TELL "   P-ADJW for PRSO is ">
			     <PRINTB <GET ,P-ADJW 0>>)>)
		     (T
		      <TELL "No P-NAMW for prso">)>
	       <CRLF>
	       <COND (<NOT <ZERO? <GET ,P-OFW 0>>>
		      <TELL "P-OFW for PRSO is ">
		      <PRINTB <GET ,P-OFW 0>>
		      <CRLF>)>
	       <COND (<AND ,PRSI
			   <NOT <ZERO? <GET ,P-NAMW 1>>>>
		      <TELL "P-NAMW for PRSI is ">
		      <PRINTB <GET ,P-NAMW 1>>
		      <COND (<NOT <ZERO? <GET ,P-ADJW 1>>>
		             <TELL "  P-ADJW for PRSI is ">
			     <PRINTB <GET ,P-ADJW 1>>)>
		      <CRLF>)
		     (,PRSI
		      <TELL "No P-NAMW for prsi">
		      <CRLF>)>
	       <COND (<NOT <ZERO? <GET ,P-OFW 1>>>
		      <TELL "P-OFW for PRSI is ">
		      <PRINTB <GET ,P-OFW 1>>
		      <CRLF>)>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<AND <EQUAL? ,IT .O .I>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<VISIBLE? ,P-IT-OBJECT>
		      <COND (<EQUAL? ,IT .O>
			     <SET O ,P-IT-OBJECT>)
			    (T
			     <SET I ,P-IT-OBJECT>)>)
		     (T
		      <COND (<AND <NOT .I>
				  <NOT <VERB? NO-VERB>>> ;"for j3"
			     <FAKE-ORPHAN T>)
			    (T
			     <REFERRING>)>
		      <RFATAL>)>)>
	<COND (<AND <EQUAL? ,HIM .O .I>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<VISIBLE? ,P-HIM-OBJECT>
		      <COND (<EQUAL? ,HIM .O>
			     <SET O ,P-HIM-OBJECT>)
			    (T
			     <SET I ,P-HIM-OBJECT>)>)
		     (T
		      <COND (<AND <NOT .I>
				  <NOT <VERB? NO-VERB>>> ;"for j3"
			     <FAKE-ORPHAN>)
			    (T
			     <REFERRING T>)>
		      <RFATAL>)>)>
	<COND (<AND <EQUAL? ,HER .O .I>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<VISIBLE? ,P-HER-OBJECT>
		      <COND (<EQUAL? ,HER .O>
			     <SET O ,P-HER-OBJECT>)
			    (T
			     <SET I ,P-HER-OBJECT>)>)
		     (T
		      <COND (<AND <NOT .I>
				  <NOT <VERB? NO-VERB>>> ;"for j3"
			     <FAKE-ORPHAN>)
			    (T
			     <REFERRING T>)>
		      <RFATAL>)>)>
	<SETG PRSO .O>
	<SETG PRSI .I>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <THIS-IS-IT ,PRSI>
	       <THIS-IS-IT ,PRSO>
	       <COND (<SET V <D-APPLY "Actor" <GETP ,WINNER ,P?ACTION>>>
		      T)
		     (<AND ,DONT-FLAG <SET V <DONT-F>>>
		      T)  ;"in s4 .V in place of T"
		     (<SET V <D-APPLY "M-Beg" <GETP <LOC ,PROTAGONIST> 
						    ,P?ACTION> ,M-BEG>>
		      T)
		     (<SET V <D-APPLY "Preaction" <GET ,PREACTIONS .A>>>
		      T)
		     (<AND .I <SETG NOW-PRSI T>
			      <SET V <D-APPLY "PRSI" <GETP .I ,P?ACTION>>>>
		      T)
		     ;(<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <LOC .O>
			   <GETP <LOC .O> ,P?CONTFCN>
			   <SET V <D-APPLY "Cont" <GETP <LOC .O> ,P?CONTFCN>>>>
		      T) 
		     (<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <NOW-PRSI-KLUDGE>
			   <SET V <D-APPLY "PRSO" <GETP .O ,P?ACTION>>>>
		      T)
		     (<SET V <D-APPLY <> <GET ,ACTIONS .A>>>
		      T)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       ;<COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL "  Default ->" CR>)
			    (T
			     <TELL "  " .STR " -> ">)>)>
	       <SET RES <COND (.FOO
			       <APPLY .FCN .FOO>)
			      (T
			       <APPLY .FCN>)>>
	       ;<COND (<AND ,DEBUG
			   .STR>
		      <COND (<EQUAL? .RES ,M-FATAL>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

;"CLOCKER and related routines"

<GLOBAL C-TABLE %<COND (<GASSIGNED? ZILCH>
			'<ITABLE NONE 30>)
		       (T
			'<ITABLE NONE 60>)>>

<GLOBAL CLOCK-WAIT <>>

<GLOBAL C-INTS 60>

<GLOBAL C-MAXINTS 60>

<GLOBAL CLOCK-HAND <>>

<CONSTANT C-TABLELEN 60>
<CONSTANT C-INTLEN 4>	;"length of an interrupt entry"
<CONSTANT C-RTN 0>	;"offset of routine name"
<CONSTANT C-TICK 1>	;"offset of count"

<ROUTINE DEQUEUE (RTN)
	 <COND (<SET RTN <QUEUED? .RTN>>
		<PUT .RTN ,C-RTN 0>)>>

<ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-TICK>>
			       <RFALSE>)
			      (T
			       <RETURN .C>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE RUNNING? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<OR <ZERO? <GET .C ,C-TICK>>
				   <G? <GET .C ,C-TICK> 1>>
			       <RFALSE>)
			      (T
			       <RTRUE>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE QUEUE (RTN TICK "AUX" C E (INT <>)) ;"automatically enables as well"
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<COND (.INT
			       <SET C .INT>)
			      (T
			       <COND (<L? ,C-INTS ,C-INTLEN>
				      <TELL "**Too many ints!**" CR>)>
			       <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			       <COND (<L? ,C-INTS ,C-MAXINTS>
				      <SETG C-MAXINTS ,C-INTS>)>
			       <SET INT <REST ,C-TABLE ,C-INTS>>)>
			<PUT .INT ,C-RTN .RTN>
			<RETURN>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<SET INT .C>
			<RETURN>)
		       (<ZERO? <GET .C ,C-RTN>>
			<SET INT .C>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <COND (<AND ,CLOCK-HAND
		     %<COND (<GASSIGNED? ZILCH>
			'<G? .INT ,CLOCK-HAND>)
		       (T
			'<L? <LENGTH .INT> <LENGTH ,CLOCK-HAND>>)>>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 .INT>

<ROUTINE CLOCKER ("AUX" E TICK RTN (FLG <>) (Q? <>) OWINNER)
	 <COND (,CLOCK-WAIT
		<SETG CLOCK-WAIT <>>
		<RFALSE>)>
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET OWINNER ,WINNER>
	 <SETG WINNER ,PROTAGONIST>
	 <REPEAT ()
		 <COND (<EQUAL? ,CLOCK-HAND .E>
			<SETG CLOCK-HAND .E>
			<SETG MOVES <+ ,MOVES 1>>
			<SETG WINNER .OWINNER>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET ,CLOCK-HAND ,C-RTN>>>
			<SET TICK <GET ,CLOCK-HAND ,C-TICK>>
			<COND (<L? .TICK -1>
			       <PUT ,CLOCK-HAND ,C-TICK <- <- .TICK> 3>>
			       <SET Q? ,CLOCK-HAND>)
			      (<NOT <ZERO? .TICK>>
			       <COND (<G? .TICK 0>
				      <SET TICK <- .TICK 1>>
				      <PUT ,CLOCK-HAND ,C-TICK .TICK>)>
			       <COND (<NOT <ZERO? .TICK>>
				      <SET Q? ,CLOCK-HAND>)>
			       <COND (<NOT <G? .TICK 0>>
				      <SET RTN
					   %<COND (<GASSIGNED? ZILCH>
						   '<GET ,CLOCK-HAND ,C-RTN>)
						  (ELSE
						   '<NTH ,CLOCK-HAND
							 <+ <* ,C-RTN 2>
							    1>>)>>
				      <COND (<ZERO? .TICK>
					     <PUT ,CLOCK-HAND ,C-RTN 0>)>
				      <COND (<APPLY .RTN>
					     <SET FLG T>)>
				      <COND (<AND <NOT .Q?>
						  <NOT
						   <ZERO?
						    <GET ,CLOCK-HAND
							 ,C-RTN>>>>
					     <SET Q? T>)>)>)>)>
		 <SETG CLOCK-HAND <REST ,CLOCK-HAND ,C-INTLEN>>
		 <COND (<NOT .Q?>
			<SETG C-INTS <+ ,C-INTS ,C-INTLEN>>)>>>

;"call v-$refresh to during game if want to clear junk"
<ROUTINE STATUS-LINE ("AUX" (PTR 0) CORE LEN TBL X)
	 
	 <BUFOUT <>>
	 <SCREEN ,S-WINDOW>
	 ;<BUFOUT <>>
	 <HLIGHT ,H-INVERSE>
	 
       ; "Print location if it's different."
	
	 <COND (<NOT <EQUAL? ,HERE ,OLD-HERE>>
		<SETG OLD-HERE ,HERE>
		;<SET X 12>
		<COND (,WIDE
		       <SET X 12>)
		      (T
		       <SET X 2>)>
		<CURSET 1 .X>
		<COND (,WIDE ;"print over spaces for location name"
		       <PRINT-SPACES 32>)  ;"Longest - ID, on the chair"
		      (T
		       <PRINT-SPACES 18>)> ;"longest - ID room 18"
		<CURSET 1 .X>
		<SAY-HERE ,WIDE>
		
	        <SET X 14>
		<COND (<NOT ,WIDE>
		       <SET X 6 ;5>)
		      (<EQUAL? ,SCENE ,AISLE>
		       <SET X 16>)
		      (<EQUAL? ,HERE ,STARTING-ROOM>
		       <HLIGHT ,H-NORMAL>
	 	       <SCREEN ,S-TEXT>	 
	 	       <BUFOUT T>
	 	       <RFALSE>)>
		<CURSET 2 .X>
		<PRINT-SPACES <+ <- ,WIDTH .X> 1>> ;"+ 1 by JO, for commodore"
		<CURSET 2 .X>
		<LIST-ALL-ROOMS>)>
	 
       ; "Print score if different."

	 <COND (,UPDATE-SCORE?
	        <SETG UPDATE-SCORE? <>>
		<DIROUT ,D-TABLE-ON ,SLINE> ; "Start printing to buffer"
		<PUT ,SLINE 0 0>
		<SAY-SCORE>
		<DIROUT ,D-TABLE-OFF>
		<SET LEN <GET ,SLINE 0>>
		<COND (.LEN
		       <CURSET 1 <- <- ,WIDTH .LEN> 4>> 
		       <TELL "   ">
		       <SAY-SCORE>)>)>
	 
	 <HLIGHT ,H-NORMAL>
	 <SCREEN ,S-TEXT>	 
	 <BUFOUT T>
	 <RFALSE>>

<ROUTINE SAY-HERE ("OPT" (SAY-VEH T) "AUX" X)
	 <COND (,DATELINE
		<TELL "Punster">)
	       (T
		<TELL D ,HERE>)>
	 <COND (<ZERO? .SAY-VEH>
		<RTRUE>)>
	 <SET X <LOC ,PROTAGONIST>>
	 <COND (<AND <NOT <EQUAL? .X ,HERE>>
		     <FSET? .X ,VEHBIT>>
		<TELL ", ">
		<COND (<FSET? .X ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n">
		<COND (<EQUAL? .X ,LOUIS-CHAIR ,YOUR-CHAIR ,REST-CHAIR>
		       <TELL " the chair">)
		      (<EQUAL? .X ,ICICLE>
		       <TELL " the bike">)
		      (<EQUAL? .X ,PAN>
		       <TELL " the pan">)
		      (<EQUAL? .X ,CART>
		       <TELL T ,CART>)
		      (<EQUAL? .X ,HOT-TUB>
		       <TELL " the tub">)>)>
	 <RTRUE>>

<ROUTINE SAY-SCORE ()
	 <COND (<EQUAL? ,HERE ,STARTING-ROOM>
		<RTRUE>)>
	 <COND (<NOT ,WIDE>
		<TELL "S">
		<TELL-SCORE ,SCENE T>
		<RTRUE>)>
	 <TELL-SCORE ,SCENE>
	 <RTRUE>>
	 	
<ROUTINE TELL-SCORE (SC "OPTIONAL" (STAT-LINE <>) "AUX" NUM SCORE)
	 <COND (<NOT <ZERO? .STAT-LINE>>
		T)
	       (<EQUAL? .SC ,FARM>
		<TELL "Farm s">)
	       (<EQUAL? .SC ,RESTAURANT>
		<TELL "Teapot s">)
	       (<EQUAL? .SC ,COMEDY>
		<TELL "Theatrical s">)
	       (<EQUAL? .SC ,AISLE>
		<TELL "Bizarre s">)
	       (<EQUAL? .SC ,HAZING>
		<TELL "Tower s">)
	       (<EQUAL? .SC ,JOAT>
		<TELL "Jack s">)
	       (<EQUAL? .SC ,DUELING>
		<TELL "Manor s">)
	       (<EQUAL? .SC ,EIGHT>
		<TELL "Mayor s">)>
	 <SET NUM <GETP .SC ,P?MAX-SCORE>>
	 <SET SCORE <GETP .SC ,P?SCENE-SCORE>>
	 <TELL "core: " N .SCORE>
	 <COND (,WIDE
		<TELL " out">)>
	 <TELL " of " N .NUM>
	 <RTRUE>>

<ROUTINE LIST-ALL-ROOMS ()
         <COND (<EQUAL? ,SCENE ,HAZING>
		<HAZING-ROOMS>)
	       (<EQUAL? ,SCENE ,FARM>
		<FARM-ROOMS>)
	       (<EQUAL? ,SCENE ,AISLE>
		<AISLE-ROOMS>)
	       (<EQUAL? ,SCENE ,JOAT>
		<JOAT-ROOMS>)
	       (<EQUAL? ,SCENE ,RESTAURANT>
		<RESTAURANT-ROOMS>)
	       (<EQUAL? ,SCENE ,COMEDY>
		<COMEDY-ROOMS>)
	       (<EQUAL? ,SCENE ,DUELING>
		<DUELING-ROOMS>)
	       (<EQUAL? ,SCENE ,EIGHT>
		<EIGHT-ROOMS>)
	       (T
		<TELL "Beginning">)> ;"actually, Bug"
	 <RTRUE>>

<ROUTINE COMEDY-ROOMS ()
	 <COND (<EQUAL? ,HERE ,FRONT-ROOM>
		<TELL "Kitchen">) 
	       (<EQUAL? ,HERE ,TV-KITCHEN>
		<TELL "Living Room">)>>	       

<ROUTINE HAZING-ROOMS ()
	 <COND (<EQUAL? ,HERE ,CLOUD-ROOM>
		<TELL "Down">)
	       (<EQUAL? ,HERE ,STALK-ROOM>
		<TELL "Up, Stock Room">)
	       (<EQUAL? ,HERE ,CLEARING>
		<COND (<FSET? ,SHORE ,TOUCHBIT>
		       <TELL "Shore, Old Factory, Stock Room">)
		      (T
		       <TELL "Nowhere directly">)>)
	       (<EQUAL? ,HERE ,SHORE>
		<COND (<FSET? ,FACTORY ,TOUCHBIT>
		       <TELL "Old Factory, Stock Room">
		       <TO-CLEARING?>)
		      (T
		       <TELL "Nowhere directly">)>
		<RTRUE>)
	       (<EQUAL? ,HERE ,FACTORY>
		<TELL "Shore, Stock Room">
		<TO-CLEARING?>
		<RTRUE>)
	       (<EQUAL? ,HERE ,STOCK-ROOM>
		<TELL "Shore, Factory">
		<TO-CLEARING?>
		<RTRUE>)>>
				       
<ROUTINE TO-CLEARING? ()
	 <COND (,ELF-TOLD
		<TELL ", Clearing">)>>

<ROUTINE FARM-ROOMS ()
	 <COND (<EQUAL? ,HERE ,MARKET>
		<TELL "Road">)
	       (<EQUAL? ,HERE ,LOFT>
		<TELL "Down">)
	       (T
		<COND (<NOT <EQUAL? ,ROAD ,HERE>>
		       <TELL D ,ROAD ", ">)>
		<COND (<NOT <EQUAL? ,BARN ,HERE>>
		       <TELL D ,BARN ", ">)>
		<COND (<NOT <EQUAL? ,BARNYARD ,HERE>>
		       <COND (,WIDE
			      <TELL D ,BARNYARD ", ">)
			     (T
			      <TELL "Yard, ">)>)>
		<COND (<NOT <EQUAL? ,STABLE ,HERE>>
		       <TELL D ,STABLE ", ">)>
		<COND (<NOT <EQUAL? ,FIELD ,HERE>>
		       <COND (,WIDE
			      <TELL D ,FIELD ", ">)
			     (T
			      <TELL "Crop, ">)>)>
		<COND (<NOT <EQUAL? ,MARKET ,HERE>>
		       <TELL D ,MARKET>)>
		<COND (<AND <EQUAL? ,HERE ,BARN>
			    ,WIDE>
		       <TELL ", and Up">)>)>
	 <RTRUE>>
		
<ROUTINE RESTAURANT-ROOMS ()
	 <COND (<EQUAL? ,HERE ,FLOOR-1>
		<TELL "Up, or In (to Kitchen)">)
	       (<EQUAL? ,HERE ,FLOOR-2>
		<TELL "Down">)
	       (<EQUAL? ,HERE ,KITCHEN>
		<TELL "Out">)>>

<ROUTINE JOAT-ROOMS ()
	 <COND (<EQUAL? ,HERE ,JACKVILLE ,FROST-ROOM>
		<TELL "Out">
		<COND (,WIDE 
		       <TELL " (into the forest)">)>
		<COND (<EQUAL? ,HERE ,FROST-ROOM>
		       <RTRUE>)>
		<TELL ", In">
		<COND (,WIDE
		       <TELL " (to the house)">)>)
	       (<EQUAL? ,HERE ,JACK-ROOM>
		<TELL "Out ">
		<COND (,WIDE
		       <TELL "(of the house)">)>)
	       (<EQUAL? ,HERE ,NEAR-POND>
		 ;"Out (to Jackville)" <TELL "In (onto the Pond)">)
	       (<EQUAL? ,HERE ,POND-ROOM>
		<TELL "Out (from the pond)">)>>

<ROUTINE AISLE-ROOMS ()
	 <COND (<NOT <EQUAL? ,DESSERT-ROOM ,HERE>>
		<COND (,WIDE
		       <TELL "Desserts, ">)
		      (T
		       <TELL "Dess, ">)>)>
	 <COND (<NOT <EQUAL? ,MANICOTTI-ROOM ,HERE>>
		<COND (,WIDE
		       <TELL "Manicotti, ">)
		      (T
		       <TELL "Man, ">)>)>
	 <COND (<NOT <EQUAL? ,BRITISH-ROOM ,HERE>>
		<COND (,WIDE
		       <TELL "British, ">)
		      (T
		       <TELL "Brit, ">)>)>
	 <COND (<NOT <EQUAL? ,ILL-ROOM ,HERE>>
		<TELL "Write, ">)>
	 <COND (<NOT <EQUAL? ,LET-ROOM ,HERE>>
		<TELL "Meets">
		<COND (<NOT <EQUAL? ,HERE ,MUSSEL-ROOM>>
		       <TELL ", ">)>)>
	 <COND (<NOT <EQUAL? ,MUSSEL-ROOM ,HERE>>
		<TELL "Misc">
		;"next clause for the last room in this routine"
		<COND (<OR <EQUAL? ,HERE ,CELLAR-ROOM>
			   <NOT <FSET? ,LOCKS-DOOR ,OPENBIT>>>
		       <RTRUE>)
		      (T
		       <TELL ", ">)>)>
	 <COND (<AND ,WIDE
		     <NOT <EQUAL? ,CELLAR-ROOM ,HERE>>
		     <FSET? ,LOCKS-DOOR ,OPENBIT>>
		<COND (<EQUAL? ,HERE ,MUSSEL-ROOM>
		       <TELL ", ">)>
		<TELL "Cellar">)
	       (<AND <NOT ,WIDE>
		     <EQUAL? ,HERE ,ILL-ROOM>
		     <FSET? ,LOCKS-DOOR ,OPENBIT>>
		<COND (<EQUAL? ,HERE ,MUSSEL-ROOM>
		       <TELL ", ">)>
		<TELL "In">)>
	 <RTRUE>>

<ROUTINE DUELING-ROOMS ()
	 <COND (<NOT <EQUAL? ,ID-ROOM ,HERE>>
		<COND (,WIDE
		       <TELL D ,ID-ROOM ", ">)
		      (T
		       <TELL "Interior, ">)>)>
	 <COND (<NOT <EQUAL? ,KREMLIN ,HERE>>
		<TELL D ,KREMLIN ", ">)>
	 <COND (<NOT <EQUAL? ,DOLDRUMS ,HERE>>
		<COND (,WIDE
		       <TELL D ,DOLDRUMS>)
		      (T
		       <TELL "Yawn">)>
		<COND (<EQUAL? ,HERE ,PHARMACY>
		       <RTRUE>) ;"stop"
		      (T
		       <TELL ", ">)>)>
	 <COND (<NOT <EQUAL? ,PHARMACY ,HERE>>
		<COND (<NOT ,WIDE>
		       <TELL "Rx">)
		      (T
		       <TELL D ,PHARMACY>)>)>
	 <COND (<NOT <EQUAL? ,HERE ,ATTIC>>
		<TELL ", Attic">)>
	 ;<COND (<AND <EQUAL? ,HERE ,ID-ROOM>
		     <NOT <FSET? ,ATTIC ,PHRASEBIT>>>
		<TELL ", Down">)>
	 ;<COND (<AND <EQUAL? ,KREMLIN ,HERE>
		     <FSET? ,ATTIC ,PHRASEBIT>>
		<TELL ", Up">)>
	 <RTRUE>>

<ROUTINE EIGHT-ROOMS ()
	 <COND (<EQUAL? ,HERE ,SQUARE>
		<TELL "In (to the Town House)">)
	       (<EQUAL? ,HERE ,LOBBY>
		<TELL "Up, Out">) ;"to the square"
	       (<EQUAL? ,HERE ,BATHROOM>
		<TELL "Down">)> ;"the stairs"
	 <RTRUE>>

<ROUTINE I-WIFE ()
	 <COND (<AND <EQUAL? ,HERE ,FRONT-ROOM>
		     <G? <GETP ,SCENE ,P?SCENE-SCORE> 3>		     
		     <NOT <IN? ,WIFE ,HERE>>
		     <FSET? ,WATER-BOTTLE ,PHRASEBIT> ;"points for it"
		     <FSET? ,BOB-SHOE ,RMUNGBIT>
		     <NOT <RUNNING? ,I-KNOCK>>
		     <NOT <RUNNING? ,I-BOB>>>
		<SETG KNOCK-JOKE ,W?GORILLA>
		<DEQUEUE I-WIFE>
		<I-KNOCK>)
	       (<IN? ,WIFE ,FRONT-ROOM>
		<INC WIFE-N>
		<COND (<AND <EQUAL? ,HERE ,FRONT-ROOM>
			    <EQUAL? ,WIFE-N 2>>
		       <TELL CR 
"She walks over to Bob and consoles him as he describes what a
meanee you have been." CR>)
		      (<AND <EQUAL? ,HERE ,FRONT-ROOM>
			    <EQUAL? ,WIFE-N 3>>
		       <TELL CR
"Bob continues telling" T ,WIFE " how rotten you were to him." CR>)
		      (<EQUAL? ,WIFE-N 4>
		       <DEQUEUE I-WIFE>
		       <REMOVE ,WIFE>
		       <FSET ,WIFE ,SEENBIT>
		       <REMOVE ,BOB>
		       <CRLF>
		       <SETG KNOCK-JOKE ,W?DWAYNE>
		       <COND (<EQUAL? ,HERE ,TV-KITCHEN>
			      <TELL
"You can hear your wife leaving and Bob locking himself in the bathroom.
You rush to the living room..." CR CR>
			      <GOTO ,FRONT-ROOM>)
			     (T
		              <TELL 
"She throws a tantrum and storms out, to her mother's (that's next week's
episode). Bob is falling apart emotionally as well, and goes and locks
himself in the bathroom." CR>)>
		       <TELL CR
"Bob stays in there several very tense minutes, without making a sound.
Just when you think it's about time to call a professional, Bob's silence
is suddenly broken by the words, \"Knock knock.\"" CR>
		       ;<QUEUE I-KNOCK -1>
		       <THIS-IS-IT ,GLOBAL-ROOM>
		       <SETG KNOCK-N 0>
		       <I-KNOCK>)>)>>