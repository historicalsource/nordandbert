"HINTS for
			       WORDPLAY
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROUTINE V-HINT ("AUX" CURQ CURL CHR (MAXQ <GET ,HINT-TBL 0>) MAXL (Q <>))
         <INIT-HINT-SCREEN>
	 <CURSET 4 1>
	 <SET MAXL <PUT-UP-QUESTIONS 1>>
	 <SET CURQ 1>
	 <SET CURL 5>
	 <CURSET .CURL 2>
	 <PRINTI "->">
	 <REPEAT ()
		 <SET CHR <INPUT 1>>
		 <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
			<SET Q T>
			<RETURN>)
		       (<EQUAL? .CHR %<ASCII !\+>>
			<COND (<EQUAL? .CURQ .MAXQ> T)
			      (T
			       <CURSET .CURL 2>
			       <PRINTI "  ">
			       <SET CURL <+ .CURL 2>>
			       <SET CURQ <+ .CURQ 1>>
			       <CURSET .CURL 2>
			       <PRINTI "->">)>)
		       (<EQUAL? .CHR %<ASCII !\->>
			<COND (<EQUAL? .CURQ 1> T)
			      (T
			       <CURSET .CURL 2>
			       <PRINTI "  ">
			       <SET CURL <- .CURL 2>>
			       <SET CURQ <- .CURQ 1>>
			       <CURSET .CURL 2>
			       <PRINTI "->">)>)
		       (<EQUAL? .CHR 13 10>
			<DISPLAY-HINT .CURQ>
			<RETURN>)>>
	 <COND (<NOT .Q> <AGAIN>)>
	 <SPLIT 0>
	 <CLEAR -1>
	 <BUFOUT T>
	 <INIT-STATUS-LINE 2>
	 <STATUS-LINE>
	 <TELL "Back to the game.." CR>>

<ROUTINE DISPLAY-HINT (N "AUX" H MX (CNT ,HINT-HINTS) CHR (FLG T))
	 <SPLIT 0>
	 <CLEAR -1>
         <SPLIT 3>
	 <SCREEN ,S-WINDOW>
	 <CURSET 1 1>
	 <INVERSE-LINE>
	 <CENTER-LINE 1 "INVISICLUES" %<LENGTH "INVISICLUES">>
	 <CURSET 3 1>
	 <INVERSE-LINE>
	 <LEFT-LINE 3 " RETURN to see next hint">
	 <RIGHT-LINE 3 "Q to return to hint menu"
		     %<LENGTH "Q to return to hint menu">>
	 <HLIGHT ,H-BOLD>
	 <CENTER-LINE 2 <GET <SET H <GET ,HINT-TBL .N>> ,HINT-QUESTION>>
	 <HLIGHT ,H-NORMAL>
	 <SET MX <GET .H 0>>
	 <SCREEN ,S-TEXT>
	 <CRLF>
	 <REPEAT ()
		 <COND (<EQUAL? .CNT <GET .H ,HINT-SEEN>>
			<RETURN>)
		       (T
			<TELL <GET .H .CNT> CR CR>
			<SET CNT <+ .CNT 1>>)>>
	 <REPEAT ()
		 <COND (.FLG <TELL " Hint -> "> <SET FLG <>>)>
		 <SET CHR <INPUT 1>>
		 <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
			<PUT .H ,HINT-SEEN .CNT>
			<RETURN>)
		       (<EQUAL? .CHR 13 10>
			<COND (<G? .CNT .MX>
			       T)
			      (T
			       <SET FLG T>
			       <TELL <GET .H .CNT> CR CR>
			       <SET CNT <+ .CNT 1>>
			       <COND (<G? .CNT .MX>
				      <SET FLG <>>
				      <TELL
"[That's all folks!]" CR>)>)>)>>>

<ROUTINE PUT-UP-QUESTIONS (ST "AUX" MXQ MXL LN)
	 <SET MXQ <GET ,HINT-TBL 0>>
	 <SET MXL <GETB 0 32>>
	 <SET LN 6>
	 <REPEAT ()
		 <SET LN <+ .LN 2>>
		 <COND (<G? .ST .MXQ>
			<TELL CR "[Last question]" CR>
			<RETURN .MXQ>)
		       (<G? .LN .MXL>
			<TELL CR "[More questions follow]" CR>
			<RETURN <- .ST 1>>)
		       (T
			<CRLF>
			<TELL "    " <GET <GET ,HINT-TBL .ST> ,HINT-QUESTION>>
			<CRLF>)>
		 <SET ST <+ .ST 1>>>>

<ROUTINE INIT-HINT-SCREEN ("AUX" WID LEN)
	 <SET WID <GETB 0 33>>
	 <SPLIT 0>
	 <CLEAR -1>
	 <SPLIT <GETB 0 32>>
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 <CURSET 1 1>
	 <INVERSE-LINE>
	 <CURSET 2 1>
	 <INVERSE-LINE>
	 <CURSET 3 1>
	 <INVERSE-LINE>
	 <CENTER-LINE 1 "INVISICLUES" 11>
	 <LEFT-LINE 2 " + to move forward">
	 <RIGHT-LINE 2 "- to move backward" %<LENGTH "- to move backward">>
	 <LEFT-LINE 3 " RETURN to see the hint">
	 <RIGHT-LINE 3 "Q to return to game" %<LENGTH "Q to return to game">>>

<CONSTANT HINT-COUNT 0>
<CONSTANT HINT-QUESTION 1>
<CONSTANT HINT-SEEN 2>
<CONSTANT HINT-OFF 3>
<CONSTANT HINT-HINTS 4>

<DEFINE NEW-HINT (NAME Q "ARGS" HINTS)
	<SETG .NAME 1>
	<COND (<G? <LENGTH .Q> 39>
	       <ERROR QUESTION-TOO-LONG!-ERRORS NEW-HINT .Q>)>
	<LTABLE .Q
		4
		.NAME
		!.HINTS>>

<GLOBAL HINT-FLAG-TBL <TABLE 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>>
 
<GLOBAL HINT-TBL
   <LTABLE
      %<NEW-HINT H-HOUSE
		 "How can I stop myself from bleeding?"
		 "Have you tried using a tourniquet?">
      %<NEW-HINT H-PEARL
		 "How can I get warm?"
		 "Have you found any shelter?">
      %<NEW-HINT H-PAN-OF-KEYS
		 "How can I keep away from the dogs?"
		 "Is there any food you can use to distract them?"
		 "Have you seen the swamp."
		 "Go along the edge of the swamp, and you'll confuse them.">
      %<NEW-HINT H-GIRL-GONE
		 "How can I get warm?"
		 "Have you found any shelter?">
      %<NEW-HINT H-ROCKS
		 "How can I get warm?"
		 "Have you found any shelter?">
      %<NEW-HINT H-DEAN
		 "How can I get warm?"
		 "Have you found any shelter?">
      %<NEW-HINT H-LEOPARD
		 "How can I get warm?"
		 "Have you found any shelter?">
      %<NEW-HINT H-RAT
		 "How can I get warm?"
		 "Have you found any shelter?">
      %<NEW-HINT H-BONFIRE
		 "How can I get warm?"
		 "Have you found any shelter?">
      %<NEW-HINT H-ICICLE
		 "How can I get warm?"
		 "Have you found any shelter?">
      %<NEW-HINT H-ELF
		 "How can I get warm?"
		 "Have you found any shelter?">>>
		 
<ROUTINE CENTER-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	 <COND (<ZERO? .LEN>
		<DIROUT ,D-TABLE-ON ,DIROUT-TBL>
		<TELL .STR>
		<DIROUT ,D-TABLE-OFF>
		<SET LEN <GET ,DIROUT-TBL 0>>)>
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
		<DIROUT 3 ,DIROUT-TBL>
		<TELL .STR>
		<DIROUT -3>
		<SET LEN <GET ,DIROUT-TBL 0>>)>
	 <CURSET .LN <- <GETB 0 33> .LEN>>
	 <COND (.INV <HLIGHT ,H-INVERSE>)>
	 <TELL .STR>
	 <COND (.INV <HLIGHT ,H-NORMAL>)>>
	 
<GLOBAL DIROUT-TBL <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>>