EXTRN CARCOLOR1:BYTE
EXTRN CARCOLOR2:BYTE
EXTRN P1NAME:BYTE
EXTRN P2NAME:BYTE
EXTRN INLEVEL2:BYTE 
EXTRN GAMESPEED:WORD 
EXTRN CLEARRECIEVE:FAR 

PUBLIC MAIN2,P1WINS,LOADING
;------------------------------------------------------------------------------------
;------------------------------------MACROS USED-------------------------------------
;------------------------------------------------------------------------------------

LOADMAP MACRO 

	CALL DRAWPAVEMENT 
	CALL WHITELANES 

ENDM LOADMAP

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

LOADOUTLINE MACRO 
    
	CALL DRAWBARRIER  
	CALL DRAWMUD1  
	CALL DRAWMUD2
	CALL DRAWMUD3
	CALL DRAWMUD4
	CALL FIRSTTREECOL 
	CALL SECONDTREECOL
	CALL THIRDTREECOL
	CALL FOURTHTREECOL
	       
ENDM LOADOUTLINE 

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

PLAYERNAMES MACRO

;---> Checking on long names
;-> Player1    
	MOV CX,0
	LEA SI,P1NAME
	LEA DI,P1DISPNAME

MOVENAME:
	CMP CX,7
	JE LONGNAMECASE

	MOV AL,[SI]
	MOV [DI],AL

	INC CX
	INC SI 
	INC DI

	CMP [SI],BYTE PTR '$'
	JNE MOVENAME

	JMP ENDMOVENAME
	LONGNAMECASE:
	MOV [DI],BYTE PTR '.'
	MOV [DI+1],BYTE PTR '.'

ENDMOVENAME:
;-> Player2
	MOV CX,0
	LEA SI,P2NAME
	LEA DI,P2DISPNAME

MOVENAME1:
	CMP CX,7
	JE LONGNAMECASE1

	MOV AL,[SI]
	MOV [DI],AL

	INC CX
	INC SI 
	INC DI

	CMP [SI],BYTE PTR '$'
	JNE MOVENAME1

	JMP ENDMOVENAME1
LONGNAMECASE1:
	MOV [DI],BYTE PTR '.'
	MOV [DI+1],BYTE PTR '.'

ENDMOVENAME1:

;MOVE CURSOR
	MOV AH,2
	MOV DL,1 ; X POSITION
	MOV DH,19 ; Y POSITION
	INT 10H

	;PRINT FIRST PLAYER NAME
	MOV AH,9
	MOV DX,OFFSET P1DISPNAME
	INT 21H  


	;MOVE CURSPOR
	MOV AH,2
	MOV DL,21 ; X POSITION
	MOV DH,19 ; Y POSITION
	INT 10H

	;PRINT SECOND PLAYER NAME
	MOV AH,9
	MOV DX,OFFSET P2DISPNAME
	INT 21H

	XOR SI,SI
	XOR DI,DI ;CLEARING
  
ENDM PLAYERNAMES

;-----------------------------------------------------------------------------
		.MODEL SMALL
;-----------------------------------------------------------------------------	
		.STACK 64
;-----------------------------------------------------------------------------
		.DATA
;;LOADING SCREEN
INCDISTDESCRIPTION DB '-> Moves your car 1 step forward','$'
DECDISTDESCRIPTION DB '-> Moves the enemy 1 step backwards','$'
ROCKETICONDESCRIPTION DB '-> Throws a rocket on the enemy','$'
LOADINGMSG DB 'LOADING..','$'


;;RANDGENERATOR
RANDMAX DW  100  
   
;;SPIDER
SPIDERCENTER DW 190,140
RADIUS  DW 9 
TOPPOINT DW ? 
HEADRADIUS DW 5 
HEADFLAG DB 0
COLOR DB  ?    
;; START OF CAR VARIABLES    
CARCENTER DW 190,100 
CARLENGTH DW 20
CARWIDTH DW 10
CARSTARTX DW ? 
CARSTARTXPERM DW ? 
CARSTARTYPERM DW ?
WINDOWSTARTY DW ?
CARCOLOR DB 11
;; END OF CAR VARIABLES 
;;CAR1DATA 
CARCENTER1 DW 27,90      
;---------------------
;;CAR2DATA 
CARCENTER2 DW 190,90  
;------------------ 
;;SPIDER1DATA
SPIDERCENTER1 DW 27,140 
;---------------------
;;SPIDER2DATA
SPIDERCENTER2 DW 190,140
;----------------------   
;; START OF MAP VARIABLES
PAVEMENTY DW 0   ;initial value of y
PAVEMENTCOLOR DB 0EH 
MAPSIZE DB 150   
;

;; END OF MAP VARIABLES 

;;NAME VRIABLES
P1DISPNAME DB  10 DUP('$')
P2DISPNAME DB  10 DUP('$')

;;HEART VARIABLES
NumOfHeartsP1 DB 4 
NumOfHeartsP2 DB 4


;; START OF OBJECT FLAGS
;;------------------------
;;------------------------
ICONMAPLIMIT    DB  135

   
DECDISTFLAG1    DB  0   
DECDISTINITIAL1 DW  17,10


INCDISTFLAG1    DB  0
INCDISTINITIAL1 DW  17,10
   
ROCKETFLAG1     DB  0
ROCKETINITIAL1  DW  17,10


DECDISTFLAG2    DB  0
DECDISTINITIAL2 DW  180,10

INCDISTFLAG2    DB  0
INCDISTINITIAL2 DW  180,10
   
ROCKETFLAG2     DB  0
ROCKETINITIAL2  DW  180,10 
;--------------------------

GFLAG    DB  0   
GINITIAL DW  17,11
TYPEFLAG DB  0

ICONPOINT1 DW ?,?
ICONATWHICHP DB 0

;----------------------------
;ROCKET FLAGS
RFLAG    DB  0   
RINITIAL DW  17,11 

ROCKPOINT1 DW ?,?

HARMGENERAL DB 0 ;TO GET IF A PLAYER TOUCHED THE ROCKET OR NOT
ROCKETISAT  DB 0 ;TO GET THE LOCATION OF WHICH THE HARM WILL BE DONE


HARMPLAYER1 DB 0 ;FLAGS TO DETERMINE WHO THE ROCKET WILL HIT
HARMPLAYER2 DB 0 
;-------------------------
;; END OF OBJECT FLAGS
;;------------------------
;;------------------------ 

;GAME CONDITION VARIABLES
ISTHEGAMEOVER DB 0 
P1WINS        DB 0 
VALUE  DB 1

;-----------------------
;CHAT FLAGS
INPUTFLAG           DB      ? ;0 ENTER - 1 BACKSPACCE - 2 CHAR - 3 ESC

TEMPMSG             DB      1500 DUP('$')   
STRING_X            DB      00H
STRING_Y            DB      15H
TEMPMSG2            DB      1500 DUP('$')   ;TO EDIT SIZE
STRING_X2           DB      15H
STRING_Y2           DB      15H
LASTLINE            DB      0
LASTLINE2           DB      0
NOSEND              DB      1 
EXITCHAT            DB      0   
ENTERCHAT           DB      0   

;------------------------
;ICONS GENERATION   
ARRINDEX  DB 0

RANDLANES DB 8,4,8,2,1,2,1,2,8,5
          DB 1,1,4,8,7,7,5,5,8,3
          DB 7,7,1,1,6,2,7,8,1,3
          DB 7,7,4,4,7,4,6,5,6,2
          DB 5,8,6,7,1,7,2,2,5,8
          DB 1,7,3,7,2,3,2,4,5,3
          DB 4,5,5,7,7,7,8,5,7,3
          DB 1,2,3,1,8,2,1,3,7,6
          DB 4,7,2,4,1,5,2,3,7,2
          DB 6,3,8,4,7,4,5,8,3,1
               
RANDICONS DB 13,18,15,14,25,25,20,6,2,13
          DB 10,5,27,28,25,9,26,20,7,2
          DB 21,25,12,23,11,10,15,5,16,23
          DB 12,3,20,9,2,0,3,28,8,10
          DB 20,3,29,12,17,22,14,3,20,26
          DB 20,21,6,20,20,25,22,11,9,6
          DB 21,17,1,3,1,21,13,6,21,3
          DB 18,18,23,11,0,22,20,23,1,12
          DB 21,11,20,15,20,25,24,14,24,4
          DB 19,11,26,8,3,26,21,11,14,23

;-----------------------------------------------------------------------------
		.CODE
MAIN2 PROC FAR


EXTRN PLAYERFLAG:BYTE

MOV AX,@DATA
MOV DS,AX
 
 
 
 
MOV SI,0  
  CALL PORTINIT

 ;video mode
 MOV AH,0
 MOV AL,13h
 INT 10H  
 
 ;SET BACK GROUND TO GREY
 MOV AX,0600H
 MOV BH,8
 MOV CX,0
 MOV DX,184FH
 INT 10H 
 
 
 ;LOAD THE OUTLINE
    LOADOUTLINE 
 
 ;PRINT PLAYER NAMES
   PLAYERNAMES
 
 ;LOAD HEALTHBAR
   CALL HEALTHBAR
 
 ;THE ACTUAL GAME 
    CALL LOADCAR1SPIDER1DATA  
    CALL DRAWCAR
    CALL DRAWSPIDER 
    CALL LOADCAR2SPIDER2DATA
    CALL DRAWCAR
    CALL DRAWSPIDER  
  
 ;WAITINGFOR PLAYER2
  
 MOV VALUE,1
 CALL SEND
 MOV VALUE,0 
 
 CALL WAITFORPLAYER2
 MOV NOSEND,1 

;RAND ICONS GENERATION

 GAME:   
    
   LOADMAP
   MOV SI,0
   ;FOR MOVING THE ROAD
   PUSH AX
   inc PAVEMENTY
   MOV AX,PAVEMENTY
   DIV MAPSIZE  ;; AL=QUO,AH=REM
   MOV AL,AH
   MOV AH,0
   MOV PAVEMENTY,AX 
   POP AX 
 
 
 ;-------------------------------------------
 ;CHECKING IF THE GAME IS OVER
    
 
   CMP [SI]+ISTHEGAMEOVER,1
   JZ HALFGAMEOVER


 ;-------------------------------------------

 
  
 ;MOV BX,AX 
 
 ;-----> Drawing objects
  
 ;;--> Player1  
  
 ;;;-->(1) getting object
 
 
 ;;;-->(2) getting X
 
 PUSH AX
 PUSH BX
 PUSH CX
 PUSH DX
 PUSH DI
 PUSH SI    
      
     ; CALL RANDICON 
      CMP ARRINDEX,99
      JNZ DONTRESETINDEX
      MOV ARRINDEX,0
      DONTRESETINDEX:
      MOV AX,0    
      MOV AL,ARRINDEX
      MOV DI,AX
      MOV   AL, RANDLANES+[DI] 
      
      CMP AL,4
      JG PLAYER2LANE
       
      MOV ICONATWHICHP,0              ;PLAYER1
      
      CMP AL,1
      JNZ TRYLANE2
      
      MOV GINITIAL, 17
      
      CMP PLAYERFLAG,2
      JNZ HALFCHECKICONARR
      
      MOV GINITIAL,180
      
      JMP HALFCHECKICONARR
                        
 JMP SKIPHALFJUMP
  ;-------------------------------------------
 ;HALFJMPS
    HALFGAMEOVER: JMP GAMEOVER
 ;-------------------------------------------
 SKIPHALFJUMP:                        
      TRYLANE2:
      
      CMP AL,2
      JNZ TRYLANE3
      
      MOV GINITIAL, 51
      
      CMP PLAYERFLAG,2                  ;IF PLAYER 2 INTERFACE, FIX THE ICONS POSITION ON THE CORRECT SIDE OF THE SCREEN
      JNZ HALFCHECKICONARR
      
      MOV GINITIAL,214
      JMP HALFCHECKICONARR
      
      TRYLANE3: 
      
      CMP AL,3
      JNZ ITSLANE4
      
      MOV GINITIAL, 85
      
      CMP PLAYERFLAG,2
      JNZ HALFCHECKICONARR
      
      MOV GINITIAL,248
      
      JMP CHECKICONARR
      
      ITSLANE4: 
     
      MOV GINITIAL, 119 
      
      CMP PLAYERFLAG,2
      JNZ CHECKICONARR
      
      MOV GINITIAL,282
      JMP CHECKICONARR

;--------------------------------------------------------------------      
      PLAYER2LANE: 
      MOV ICONATWHICHP,1              ;PLAYER2
      
 JMP SKIPHALFJUMP2
  ;-------------------------------------------
 ;HALFJMPS
    HALFCHECKICONARR: JMP CHECKICONARR
 ;-------------------------------------------
 SKIPHALFJUMP2: 
       
      CMP AL,5
      JNZ TRYLANE5 
      
      MOV GINITIAL, 180   
      
      CMP PLAYERFLAG,2                
      JNZ CHECKICONARR
      
      MOV GINITIAL,17
      JMP CHECKICONARR
      
      TRYLANE5:
      
      CMP AL,6
      JNZ TRYLANE6
      
      MOV GINITIAL, 214
      CMP PLAYERFLAG,2                
      JNZ CHECKICONARR
      
      MOV GINITIAL,51
      JMP CHECKICONARR
      
      TRYLANE6: 
      
      CMP AL,7
      JNZ ITSLANE8
      
      MOV GINITIAL, 248
      
      CMP PLAYERFLAG,2                 
      JNZ CHECKICONARR
      
      MOV GINITIAL,85
      JMP CHECKICONARR
      
      ITSLANE8: 
     
      MOV GINITIAL, 282 
      CMP PLAYERFLAG,2                  
      JNZ CHECKICONARR
      
      MOV GINITIAL,119
      
      
      CHECKICONARR:
      
      CMP GFLAG,1
      JZ DONTDRAWICON1
 
      MOV GINITIAL+2 ,11   ;RESETTING POSITION (Y)
      
      MOV AL, RANDICONS+[DI] 
      MOV TYPEFLAG,AL           ;PUT THE ICON TYPE IN THE TYPE FLAG 
      MOV  GFLAG,1
      
      
      DONTDRAWICON1:
      CALL DRAW_ICON
    ;  CMP ARRINDEX,80
;      JNZ  DONTRESTARTRANDLOOP
;      MOV ARRINDEX,0
;      DONTRESTARTRANDLOOP: 
      
     ; MOV  GFLAG,1  
     ; CALL DRAW_ICON 
      
 POP SI
 POP DI
 POP DX
 POP CX
 POP BX
 POP AX           
 ;;--> Player2  
  
 ;;;-->(1) getting object
 
 
 ;;;-->(2) getting X
   ;INF LOOP CHAT
   
   CMP ENTERCHAT,1
   JNZ NOCHAT
    
    CALL CHATSCREEN
   
   
   NOCHAT:
   MOV ENTERCHAT,0
   
   
 
 ;CHECKING BUFFER
   MOV AH,1
   MOV AL,1
   INT 16H 
   CMP AH,1  
   JZ NOCHANGPOS1
   CALL CHANGPOS 
   CALL SENDDATA
   NOCHANGPOS1: 
   MOV VALUE,1
   CALL RECDATA 
   MOV NOSEND,1
   MOV AH,VALUE
   CMP AH,1
   JZ NOCHANGPOS 
   CMP AH,0E0H
   JZ CHNG
   CMP AH,0E1H
   JNZ NOCHANGPOS
   
   CHNG:
   CALL CHANGPOS
NOCHANGPOS:
   CMP AH,2
   JNZ NOTENTERMAIN
   MOV ENTERCHAT,1
   NOTENTERMAIN:
   
  ;----------------  
  MOV CX,GAMESPEED   ;delay main
LOOPCX1:
  PUSH CX 
  MOV CX,55555
LOOPCX:     
  LOOP LOOPCX 
  POP CX
  LOOP LOOPCX1 
  
  JMP GAME 
 
  GAMEOVER:
  MOV SI,0  
  MOV [SI]+ISTHEGAMEOVER,0 ;RESET GAMEOVER FLAG 
  MOV [SI]+ CARCENTER1, 27
  MOV [SI]+CARCENTER1+2,90    
  MOV [SI]+CARCENTER2, 190
  MOV [SI]+CARCENTER2+2,90
  MOV [SI]+ SPIDERCENTER1, 27
  MOV [SI]+SPIDERCENTER1+2,140 
  MOV [SI]+ SPIDERCENTER2 ,190
  MOV [SI]+SPIDERCENTER2+2,140
  MOV [SI]+ NumOfHeartsP1 , 4 
  MOV [SI]+NumOfHeartsP2 , 4 
  MOV ARRINDEX,0
  
  
      
  RET
 
  
MAIN2 ENDP 
 
;------------------------------------------------------------------------------------   
;------------------------------USED PROCEDURES---------------------------------------      
;------------------------------------------------------------------------------------ 
LOADING PROC  
;SHOWING DESCRIPTION OF ICON FUNCTIONALITIES BEFORE GAME STARTS

;CLEAR SCREEN
		MOV AH,0
		MOV AL,13H
		INT 10H
;------------------------->DRAWING ICONS<--------------------------------
;FIRST ICON
		;DRAW ICON
		MOV CX,10
		MOV DX,42
		MOV BX,20
		CALL DRAW_INC_DISTANCE_ICON

		;DISPLAY ICON DESCRIPTION
		PUSH DX

		MOV AH,2    ;SET CURSOR 
		MOV DL,5
		MOV DH,5
		INT 10H

		MOV AH,9   ;PRINT DESCRIPTION
		MOV DX,OFFSET INCDISTDESCRIPTION
		INT 21H

		POP DX

;SECOND ICON
		;DRAW ICON
		ADD DX,32
		CALL DRAW_DEC_DISTANCE_ICON

		;DISPLAY ICON DESCRIPTION
		PUSH DX

		MOV AH,2    ;SET CURSOR 
		MOV DL,5
		MOV DH,9
		INT 10H

		MOV AH,9   ;PRINT DESCRIPTION
		MOV DX,OFFSET DECDISTDESCRIPTION
		INT 21H

		POP DX

;THIRD ICON
		ADD DX,32
		CALL DRAW_ROCKET_ICON

		;DISPLAY ICON DESCRIPTION
		PUSH DX

		MOV AH,2    ;SET CURSOR 
		MOV DL,5
		MOV DH,13
		INT 10H

		MOV AH,9   ;PRINT DESCRIPTION
		MOV DX,OFFSET ROCKETICONDESCRIPTION
		INT 21H

		POP DX

;------------------------->LOADING BAR<--------------------------------
		PUSH DX

		MOV AH,2    ;SET CURSOR 
		MOV DL,15
		MOV DH,17
		INT 10H

		MOV AH,9   ;PRINT LOADING MESSAGE
		MOV DX,OFFSET LOADINGMSG
		INT 21H

		POP DX

;DRAWING THE EMPTY BAR
		ADD DX,50
		MOV CX,100
		MOV BX,104
		MOV AL,15 ;WHITE COLOR
		MOV DI,10
		CALL DRAW_RECT
		
;FILLING THE BAR
		ADD CX,2  ;SETTING COORDINATES FOR DRAWING INNER RECTANGLE
		SUB DX,8
		MOV BX,20
FILLBAR:
		PUSH CX
		PUSH DX

		MOV     CX, 0FH  ;1 SEC DELAY
		MOV     DX, 4240H
		MOV     AH, 86H
		INT     15H

		POP DX
		POP CX
		
		MOV DI,6
		MOV AL,34H
		PUSH BX
		CALL DRAW_RECT
		POP BX
		
		ADD BX,20
		SUB DX,6
		CMP BX,101  ;STOP WHEN THE MAX LENGTH OF THE BAR IS REACHED
		JC FILLBAR
		
		RET 
LOADING ENDP

;------------------------------------------------------------------------------------         
;------------------------------------------------------------------------------------ 
CHANGPOS PROC     
		  MOV SI,0
		  MOV BL,0 ;FLAG FOR CAR 2   
		  ;------------------
		   CMP AL,13   ;ENTER PRESSED
		   JNZ NOTENTER11
		   MOV ENTERCHAT,1
		   MOV VALUE,2
		   ;CALL SENDDATA
		   RET
		  ;------------------ 
		  NOTENTER11:
		  PUSH AX 

		  CMP AH,0E0H ;SERIAL--------------------------------------------------------
		  JAE LOADCAR2DAT 
		  MOV BL,1 ;FLAG FOR CAR 1
		  PUSH BX
		  CALL LOADCAR1SPIDER1DATA
			  POP BX
		  JMP ENDCHOOSINGCAR
		  
LOADCAR2DAT: 
		  PUSH BX
		  CALL LOADCAR2SPIDER2DATA    
		  POP BX
ENDCHOOSINGCAR: 
		  ;CLEAR MOVING CAR
		  PUSH BX
		  CALL CLEARCAR
		  CALL CLEARSPIDER 
		  POP BX
		  POP AX   
		  
		  ;BOUNDARIES
		  CMP [SI]+CARCENTER,129     ;IF NO LEFT MOV RIGHT ONLY
		  JZ SUBBACK                 ;IF NO RIGHT MOV LEFT ONLY
		  CMP [SI]+CARCENTER,292
		  JZ SUBBACK1 
		  
		  CMP [SI]+CARCENTER,27
		  JZ ADDOP 
		  
		  CMP [SI]+CARCENTER,190
		  JZ ADDOP1
		  ;--------------------
		  CMP BL,1
		  JNZ CAR2
		  
		  CMP AH,77
		  JNZ SUBBACK  
ADDOP: 
		  CMP AH,75
		  JZ ENDOP
		  CMP AH,77
		  JNZ ENDOP

		  ADD [SI]+CARCENTER,34    ;MOV CAR 1 RIGHT
		  ADD [SI]+SPIDERCENTER,34 
		  MOV VALUE,0E0H  ;SERIAL------------------------------------------------------
		  JMP ENDOP
SUBBACK:
		  CMP AH,77
		  JZ ENDOP
		  CMP AH,75
		  JNZ ENDOP
		  SUB [SI]+CARCENTER,34    ;MOV CAR 1 LEFT
		  SUB [SI]+SPIDERCENTER,34 
		  MOV VALUE,0E1H   ;SERIAL--------------------------------------------------
		  JMP ENDOP
		  
CAR2:
		  CMP AH,0E0H         ;D ;SERIAL------------------------------------------
          JNZ SUBBACK1  
ADDOP1: 
          CMP AH,0E1H      ;A  ;SERIAL------------------------------------------------
          JZ ENDMOV
          CMP AH,0E0H    ;D    ;SERIAL-----------------------------------------------
          JNZ ENDMOV

          ADD [SI]+CARCENTER,34
          ADD [SI]+SPIDERCENTER,34 
          MOV VALUE,1         ;SERIAL---------------------------------------------
          JMP ENDMOV
SUBBACK1:
          CMP AH,0E0H  ;D      ;SERIAL-------------------------------------------
          JZ ENDMOV
          CMP AH,0E1H   ;A
          JNZ ENDMOV
          SUB [SI]+CARCENTER,34
          SUB [SI]+SPIDERCENTER,34 
          MOV VALUE,1          ;SERIAL-----------------------------------------------
          JMP ENDMOV
ENDOP:  
 
          MOV AH,0
          INT 16H 
 ENDMOV:                     ;-----------------------
          CMP BL,0
          JZ SAVECAR2DATALABEL
          CALL SAVECAR1DATA
          JMP ENDSAVING
  
SAVECAR2DATALABEL:
          CALL SAVECAR2DATA
ENDSAVING:
          CALL DRAWSPIDER 
          CALL DRAWCAR    
		  
          RET 
CHANGPOS ENDP
;------------------------------------------------------------------------------------
PORTINIT PROC
    mov dx,3fbh 			; Line Control Register
    mov al,10000000b		;Set Divisor Latch Access Bit
    out dx,al				;Out it
    mov dx,3f8h			
    mov al,0ch			
    out dx,al
    mov dx,3f9h
    mov al,00h
    out dx,al
    mov dx,3fbh
    mov al,00011011b
    out dx,al

    
    RET
   PORTINIT ENDP 
;----------8------------------------------------------------------------------------
SENDDATA PROC
    mov dx , 3FDH		; Line Status Register
  	In al , dx 			;Read Line Status
  		AND al , 00100000b
  		JZ AGAIN
       mov dx , 3F8H		; Transmit data register
  		mov  al,VALUE
  		out dx , al 

    
     AGAIN:
    RET 
    SENDDATA ENDP  
RECDATA PROC
    mov dx , 3FDH		; Line Status Register
		in al , dx 
  		AND al , 1
  		JZ CHK
  		mov dx , 03F8H
  		in al , dx 
  		mov VALUE , al
        MOV NOSEND,0 
       CHK:
    RET
    RECDATA ENDP  
;-----------------------------------------------
;------------------------------------------------------------------------------------         
;------------------------------------------------------------------------------------ 
  
DRAWTREE PROC      
;;PUT DX=BEGY,BX=BEGX,SI=ENDX , DI=BEGX+5
;BEFORE CALLING DO THE FOLLOWING LINES
;MOV DX,BEGY 
;MOV BX,BEGX
;MOV SI,ENDX
;MOV DI,BEGX+5  
    
		 MOV CX,4
		 
		 MOV AL,02H
		 MOV AH,0CH 
		 
		 LEVEL:
		 PUSH CX 
		 
		 MOV CX,BX
		 INT 10H 
		  
		 MOV CX,SI 
		 INT 10H 
		 
		 MOV CX,DI  
		 INT 10H

		  
		 INC BX
		 DEC SI
		 INC DX
		 POP CX 
		LOOP LEVEL  


RET
    
DRAWTREE ENDP   

;------------------------------------------------------------------------------------         
;------------------------------------------------------------------------------------

DRAWBARRIER PROC 

;DRAW SCORE AND NAME BAR    
        MOV CX,0 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,320  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)     

;MIDDLE BARRIER
MOV CX,156 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,69H ;SET COLOR
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,165  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y) 
;LOWER LINE        
MOV CX,0 ; SET INITIAL X  Xo   
        MOV DX,164 ; SET INITIAL Y  Yo
        MOV AL,69H ;SET COLOR
        MOV BX,320  ;SET BX TO MAXWIDTH
        MOV DI,2  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)  
         
        
;SIDE LEFT LINE        
MOV CX,0 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,69H ;SET COLOR
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,14  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y) 
        
               
;SIDE RIGHT LINE        
MOV CX,314 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,69H ;SET COLOR
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,14  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)                

  RET
DRAWBARRIER ENDP

;------------------------------------------------------------------------------------         
;------------------------------------------------------------------------------------

;------------------------------>MUD DRAWING<-----------------------------------------
DRAWMUD1 PROC

		MOV CX,0 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,0BAH ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,150  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

       RET
DRAWMUD1 ENDP 
;------------------------------------------------------------------------------------

DRAWMUD2 PROC

		MOV CX,149 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,0BAH ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,150  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        RET

DRAWMUD2 ENDP 
;------------------------------------------------------------------------------------         

DRAWMUD3 PROC

		MOV CX,163 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,0BAH ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,150  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        RET
DRAWMUD3 ENDP
;------------------------------------------------------------------------------------         

DRAWMUD4 PROC

		MOV CX,313 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,0BAH ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,150  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        RET

DRAWMUD4 ENDP

;------------------------------------------------------------------------------------         
;------------------------------------------------------------------------------------

;-------------------------->DRAW COLUMNS OF TREES<-----------------------------------   

FIRSTTREECOL PROC

		MOV CX,30 
		MOV BX,0
		 
		 DRAWFIRSTAGAIN: 

		 PUSH CX  
		 PUSH BX

		;PUT DX=BEGY,BX=BEGX,SI=ENDX , DI=BEGX+5 
		;BEFORE CALLING DO THE FOLLOWING LINES
		MOV DX,BX 
		MOV BX,0
		MOV SI,6
		MOV DI,3
		   
		 CALL DRAWTREE  

		 ;BEGX,ENDX,BEGY 
		 ;0,   8,   BX 

		 POP BX
		 ADD BX,5
		 
		 POP CX
 
		 LOOP DRAWFIRSTAGAIN 
		 
 RET 
 
FIRSTTREECOL ENDP
;------------------------------------------------------------------------------------  
 
SECONDTREECOL PROC

		MOV CX,30 
		MOV BX,0
		 
		 DRAWSECONDAGAIN: 
		 PUSH CX
		 PUSH BX
		 
			  ;;  PUT DX=BEGY,BX=BEGX,SI=ENDX , DI=BEGX+5 
			;BEFORE CALLING DO THE FOLLOWING LINES
			MOV DX,BX 
			MOV BX,149
			MOV SI,155 
			MOV DI,152
		 
		 
		 CALL DRAWTREE 

		 
		 
		 ;BEGX,ENDX,BEGY 
		 ;147, 155,   BX 
		 
		 POP BX
		 
		 ADD BX,5 
		 
		 POP CX
		 
		 
		 LOOP DRAWSECONDAGAIN  
		 
		RET
 
SECONDTREECOL ENDP 
;------------------------------------------------------------------------------------  
 
THIRDTREECOL PROC

		MOV CX,30 
		MOV BX,0
		 
		 DRAWTHIRDAGAIN: 

		 PUSH CX  
		 PUSH BX

			 ;;  PUT DX=BEGY,BX=BEGX,SI=ENDX , DI=BEGX+5
			;BEFORE CALLING DO THE FOLLOWING LINES
			MOV DX,BX 
			MOV BX,163
			MOV SI,169
			MOV DI,166
		 
		 CALL DRAWTREE  

		 ;BEGX,ENDX,BEGY 
		 ;0,   8,   BX 

		 POP BX
		 ADD BX,5
		 
		 POP CX

		 LOOP DRAWTHIRDAGAIN 
		 
		 RET 

THIRDTREECOL ENDP  
;------------------------------------------------------------------------------------  
 
FOURTHTREECOL PROC

		MOV CX,30 
		MOV BX,0
		 
		 DRAWFOURTHAGAIN: 

		 PUSH CX  
		 PUSH BX

			 ;;  PUT DX=BEGY,BX=BEGX,SI=ENDX , DI=BEGX+5 
			;BEFORE CALLING DO THE FOLLOWING LINES
			MOV DX,BX 
			MOV BX,313
			MOV SI,319
			MOV DI,316

		 CALL DRAWTREE  

		 ;BEGX,ENDX,BEGY 
		 ;0,   8,   BX 

		 POP BX
		 ADD BX,5
		 
		 POP CX

		 LOOP DRAWFOURTHAGAIN 
		 
		 RET 

FOURTHTREECOL ENDP

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------  

DRAW_RECT  PROC
    ; Draw any Recangle given intial (x,y) , Length , Width , Color
    ; IN : CX: intial X , DX: Initial Y , AL:COLOR , BX:WIDTH , DI:HIGHT
    ; OUT : None 

        MOV AH,0CH
        ADD BX,CX
        ADD DI,DX
        
OUTLOOP:
       
        PUSH CX

INLOOP:

        INT 10H ;DRAW
        
        INC CX 

        CMP CX,BX ;MAX WIDTH
        
        JNZ INLOOP 

        INC DX
        
        CMP DX,DI ;MAX HIGHT

        POP CX
        
        JNZ OUTLOOP 

    RET
           
DRAW_RECT  ENDP 
 
;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------

DRAWPAVEMENT PROC 

		MOV CX,10 
        MOV SI,PAVEMENTY ; SET INITIAL Y  Yo  

    DRAWPAVEMENT1:
    PUSH CX 
    
        CMP PAVEMENTCOLOR,0EH
        JNZ KHLEENYASFR1
        MOV PAVEMENTCOLOR,00H 
        JMP KHALASKDA1
        KHLEENYASFR1:
        MOV PAVEMENTCOLOR,0EH 
        KHALASKDA1:
        
        ;FIRSTPAVEMENT
        ;CX  7
        MOV CX,7 ; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,15  ;SET DI TO MAXHIGHT
        CALL RECTINLOOP ;(X,Y) 
        
        ;SECONDPAVEMENT
        ;CX  143
        MOV CX,143 ; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,15  ;SET DI TO MAXHIGHT
        CALL RECTINLOOP ;(X,Y)  
        
        ;THIRDPAVEMENT
        ;CX  170
        MOV CX,170 ; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,15  ;SET DI TO MAXHIGHT
        CALL RECTINLOOP ;(X,Y) 
        
        ;FOURTHPAVEMENT
        ;CX  307
        MOV CX,307 ; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,15  ;SET DI TO MAXHIGHT
        CALL RECTINLOOP ;(X,Y)

        ADD SI,15
        
       POP CX
        
    LOOP DRAWPAVEMENT1    
    
     RET    
    
DRAWPAVEMENT ENDP 

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------

WHITELANES PROC 
    
       MOV CX,6 
       MOV SI,PAVEMENTY ; SET INITIAL Y  Yo  
    
    DRAWLANE1:
    PUSH CX
    
        CMP PAVEMENTCOLOR,0FH
        JNZ KHLEENYABYAD1
        MOV PAVEMENTCOLOR,08H 
        JMP SEBNY1
        KHLEENYABYAD1:
        MOV PAVEMENTCOLOR,0FH 
        SEBNY1:
        
        ;;FOR ROAD 1
        
        ;;FIRST LINE OF ROAD 1
        ; CX = STARTX= 41
        MOV CX,41; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,25  ;SET DI TO MAXHIGHT
        
        CALL RECTINLOOP ;(X,Y) 
        
        ;;SECOND LINE OF ROAD 1
        ; CX = STARTX= 75
        MOV CX,75; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,25  ;SET DI TO MAXHIGHT
        
        CALL RECTINLOOP ;(X,Y) 
        
        ;;THIRD LINE OF ROAD 1
        ; CX = STARTX= 109
        MOV CX,109; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,25  ;SET DI TO MAXHIGHT
        
        CALL RECTINLOOP ;(X,Y)
        
        
        
         ;;FOR ROAD 2
        
        ;;FIRST LINE OF ROAD 2
        ; CX = STARTX= 204
        MOV CX,204; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,25  ;SET DI TO MAXHIGHT
        
        CALL RECTINLOOP ;(X,Y)  
        
        ;;SECOND LINE OF ROAD 2
        ; CX = STARTX= 238
        MOV CX,238; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,25  ;SET DI TO MAXHIGHT
        
        CALL RECTINLOOP ;(X,Y)  
        
        ;;THIRD LINE OF ROAD 2
        ; CX = STARTX= 272
        MOV CX,272; SET INITIAL X  Xo
        MOV DX,SI ; SET INITIAL Y  Yo  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,25  ;SET DI TO MAXHIGHT
        
        CALL RECTINLOOP ;(X,Y)
        
        ADD SI,25
        
       POP CX
        
    LOOP DRAWLANE1    

     RET    
    
WHITELANES ENDP 
 
;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------                 

DRAWLINE proc
		BACK: INT 10H
		INC CX
		CMP CX,BX
		JNZ BACK
      
    RET
DRAWLINE ENDP 
;------------------------------------------------------------------------------------
                
DRAWLINE2 proc
		BACK1: INT 10H
		INC DX
		CMP DX,BX
		JNZ BACK1
      
    RET
DRAWLINE2 ENDP  

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------
  
DRAWCAR PROC  
		XOR AX,AX
		XOR BX,BX
		XOR CX,CX
		XOR DX,DX 
		MOV SI,0
		
	   ;CALC FIRST POINT   
	   MOV AX,[SI]+CARWIDTH
	   MOV Bl,2
	   DIV Bl 
	   MOV BX,AX
	   MOV AX,[SI]+CARCENTER ;CENTER X  
	   SUB AX,BX
	   MOV CX,AX   ;FIRST UPPER LEFT X
		
	   MOV [SI]+CARSTARTXPERM,CX
	   
	   MOV Bl,2
	   MOV AX,[SI]+CARLENGTH
	   DIV Bl
	   MOV BX,AX
	   MOV AX,[SI]+CARCENTER+2 ;CENTER Y
	   SUB AX,BX
	   MOV DX,AX ;FIRST UPPER LEFT Y 
	   MOV BX,[SI]+CARWIDTH
	   ADD BX,CX  ;CAR LIMIT (LAST POINT ON X) 
	   
	   MOV [SI]+CARSTARTYPERM,DX 
	   MOV [SI]+WINDOWSTARTY,DX
	   ADD [SI]+WINDOWSTARTY,10  
	   
		   
			 
	   ;SETTING COLOR
	   MOV AL,CARCOLOR
	   MOV AH,0CH
		 
	   MOV [SI]+CARSTARTX,CX   
	   ;FRONT PART
	   MOV CX,4
LOOP1:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX      
	   CALL DRAWLINE
	   DEC [SI]+CARSTARTX   
	   INC DX
	   INC BX
	   POP CX 
	   LOOP LOOP1
		  
	   ;CAR BODY   
	   MOV CX,[SI]+CARLENGTH
	   
LOOP2:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX      
	   CALL DRAWLINE  
	   INC DX
	   POP CX
	   LOOP LOOP2
	   
	   ;BACK PART 
	   MOV CX,3
LOOP3:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX      
	   CALL DRAWLINE
	   INC [SI]+CARSTARTX  
	   INC DX
	   DEC BX
	   POP CX
	   LOOP LOOP3  
	   SUB [SI]+CARSTARTX,3  
		 
	   ;-----------WINDOWS---------  
	   MOV AX,[SI]+CARLENGTH
	   MOV CX,4
	   DIV CL
	   MOV DI,AX
	   MOV AX,[SI]+CARLENGTH
	   SUB AX,DI 
	   MOV BX,DX
	   SUB DX,AX ;DX=FIRST Y OF WINDOWS
		
	   MOV AH,0CH
	   MOV AL,[SI]+CARCOLOR
	   ADD [SI]+CARSTARTX,2
	   SUB BX,3 
	   ;SIDE MIRRORS
	   MOV CX,2
LOOP11:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX  
	   MOV DX,[SI]+WINDOWSTARTY
	   DEC [SI]+CARSTARTX
	   SUB CX,3
	   INT 10H
	   ADD CX,[SI]+CARWIDTH  
	   ADD CX,10
   	   INT 10H
	   POP CX
	   LOOP LOOP11 
		
	   
	  
	   MOV AH,0CH
	   MOV AL,0
	   ;SIDE WINDOWS
	   ADD [SI]+CARSTARTX,2
	   MOV CX,3
	   MOV DI,0
LOOP4:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX
	   MOV DX,[SI]+WINDOWSTARTY
	   INC [SI]+ WINDOWSTARTY 
	   
	   CALL DRAWLINE2
	   MOV DX,[SI]+WINDOWSTARTY
	   
	   ADD CX,[SI]+CARWIDTH 
	   ADD CX,3
	   SUB CX,DI
	   INC DI
	   INC DI
	   CALL DRAWLINE2 
	   INC [SI]+CARSTARTX 
	   DEC BX
	   POP CX
	   LOOP LOOP4 
		   
	 
	   
	   ;------FRONT WINDOW-----
	   MOV BX,[SI]+CARSTARTX 
	   ADD [SI]+CARSTARTX,1   
	   ADD BX,[SI]+CARWIDTH
	   SUB BX,3 
	   MOV CX,3
	   SUB [SI]+WINDOWSTARTY,2 ;-----
LOOP6:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX
	   MOV DX,WINDOWSTARTY
	   DEC [SI]+WINDOWSTARTY 
	   DEC [SI]+CARSTARTX
	   INC BX
	   CALL DRAWLINE
	   POP CX
	   LOOP LOOP6
	   ;-------------------------- 
		
	   
	   MOV CX,2
	   INC BX
LOOP7:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX
	   MOV DX,WINDOWSTARTY
		 
	   CALL DRAWLINE
	   POP CX
	   LOOP LOOP7
	   
	   
	   ;-------------------------- 
	  
	   
	   SUB [SI]+WINDOWSTARTY,8
	   MOV DX,[SI]+WINDOWSTARTY
	   INC [SI]+CARSTARTX  
	   INC DX
	   ;-----FRONT LIGHT------
	   MOV CX,3
	   MOV AL,14
	   MOV AH,0CH
LOOP9:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX
	   SUB CX,2
	   DEC [SI]+CARSTARTX   
	   INT 10H  
	   INC DX
	   POP CX    
	   LOOP LOOP9  
		
		
	   MOV CX,[SI]+CARSTARTX
	   ADD CX,[SI]+CARWIDTH  
	   ADD CX,6
	   MOV [SI]+CARSTARTX,CX
	   MOV CX,3 
		 
LOOP10:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX   
	   DEC [SI]+CARSTARTX  
	   DEC DX
	   INT 10H  
	   POP CX    
	   LOOP LOOP10 
	   ;------------------------------ 
	   MOV AL,4
	   ;-----BACK LIGHT--------------- 
		
	   ADD [SI]+CARSTARTX,5
	   MOV CX,[SI]+CARLENGTH
	   ADD DX,CX 
	   ADD DX,3
	   MOV CX,3
LOOP12:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX
	   SUB CX,2
	   DEC [SI]+CARSTARTX   
	   INT 10H  
	   INC DX
	   POP CX
	   LOOP LOOP12 
	  
	   
	   MOV CX,[SI]+CARWIDTH
	   SUB [SI]+CARSTARTX,CX 
	   SUB [SI]+CARSTARTX,2
	   DEC DX
	   MOV CX,3
LOOP13:
	   PUSH CX
	   MOV CX,[SI]+CARSTARTX
	   SUB CX,2
	   DEC [SI]+CARSTARTX   
	   INT 10H  
	   DEC DX   
	   POP CX
	   LOOP LOOP13
	   ;-----------------------------
	   ;---DIVIDING SIDE WINDOWS-----
	   SUB DX,6
	   MOV CX,[SI]+CARSTARTX
	   MOV BX,CX
	   ADD BX,[SI]+CARWIDTH 
	   ADD BX,5
	   MOV AL,[SI]+CARCOLOR
	   CALL DRAWLINE
   
       RET
DRAWCAR ENDP 
   
;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------   
   
RECTINLOOP  PROC
    ; Draw any Recangle given intial (x,y) , Length , Width , Color
    ; IN : CX: intial X , DX: Initial Y , AL:COLOR , BX:WIDTH , DI:HIGHT
    ; OUT : None 
           
        ADD BX,CX
        ADD DI,DX 
        
        MOV AX,DI
        DIV MAPSIZE     ;AL=QUATIENT AH=REMAINDER
        MOV AL,AH
        MOV AH,0
        MOV DI,AX 
        
        
        MOV AX,DX
        DIV MAPSIZE     ;AL=QUATIENT AH=REMAINDER
        MOV AL,AH
        MOV AH,0
        MOV DX,AX  
        
OUTLOOP1:
       
        PUSH CX
 
INLOOP1:  

        MOV AL,PAVEMENTCOLOR
        MOV AH,0CH
        INT 10H ;DRAW
        
        INC CX 

        CMP CX,BX ;MAX WIDTH
        
        JNZ INLOOP1 

        INC DX
        
        MOV AX,DX
        DIV MAPSIZE     ;AL=QUATIENT AH=REMAINDER
        MOV AL,AH
        MOV AH,0
        MOV DX,AX  

        CMP DX,DI ;MAX HIGHT

        POP CX
        
        JNZ OUTLOOP1 

    RET
          
RECTINLOOP  ENDP 

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------
;---------------------------->SPIDER DRAWING PROC<-----------------------------------
 
;CALC SQUARE ROOT
SQROOT PROC
      ;IN BX
      ;OUT DX
  
 
	    MOV CX,0  
	    L1:MOV AX,CX
	    MUL CX  
        CMP AX,BX
	    JAE L2  
	    INC CX   
	    JNZ L1
	    L2: MOV DX, CX  

  
    
    RET
SQROOT ENDP 
;------------------------------------------------------------------------------------

;DRAW HALF AND FULL CIRCLE   
DRAWSPIDERBODY PROC near  
		XOR AX,AX    ;CLEAR REG.S
		XOR BX,BX
		XOR DX,DX
		XOR CX,CX
		MOV SI,0
		
		;X=(+OR -)ROOT(R^2+(Y-YO)^2)+XO
		 MOV CX,[SI]+RADIUS  
		 INC CX
		 MOV AX,[SI]+SPIDERCENTER+2 ;YO
		 ADD AX,[SI]+RADIUS    ;Y
		 MOV DI,AX ;DI=Y
		 SUB AX,[SI]+RADIUS
		 SUB AX,[SI]+RADIUS
		 MOV [SI]+TOPPOINT,AX   
		 
SPIDERLOOP:
		 PUSH CX
		 MOV AX,[SI]+RADIUS
		 MUL AX
		 MOV CX,AX ;CX=R^2
		 MOV AX,DI
		 SUB AX,[SI]+SPIDERCENTER+2
		 MUL AX
		 SUB CX,AX
		 MOV BX,CX  
		 
		 CALL SQROOT    ;DX=ROOT(R^2-(Y-YO)^2) 
		 
		 MOV AX,[SI]+SPIDERCENTER 
		 MOV BX,[SI]+SPIDERCENTER
		 SUB BX,DX  
		 ADD AX,DX
		 MOV CX,AX ;PIXEL POS X
		 MOV DX,DI 
		 INC CX
		 MOV AL,[SI]+COLOR
		 MOV AH,0CH 
		 XCHG CX,BX 
			
		 CMP [SI]+HEADFLAG,1 ;CHECK IF IT IS HALF OR FULL CIRCLE
		 JZ HEAD 
		 
		 PUSH CX
		 CALL DRAWLINE  
		 POP CX
		  
HEAD:
		 MOV DX,[SI]+TOPPOINT
		 INC [SI]+TOPPOINT
		 PUSH CX 
		  
		 CALL DRAWLINE 
		  
		 POP CX
		 DEC DI
		 POP CX   
		 
		 LOOP SPIDERLOOP
		 
         RET
DRAWSPIDERBODY ENDP  
;------------------------------------------------------------------------------------

;DRAW FULL SPIDER
DRAWSPIDER PROC 
    MOV [SI]+ HEADFLAG,0
    PUSH [SI]+SPIDERCENTER 
    PUSH [SI]+SPIDERCENTER+2
    PUSH [SI]+RADIUS
    MOV [SI]+COLOR,0
    CALL DRAWSPIDERBODY  ;DRAWING BODY WITH THE CENTER 
    MOV CX,4
    MOV DX,[SI]+SPIDERCENTER+2  
LEGS:
    PUSH CX
    MOV CX,[SI]+SPIDERCENTER
     
    MOV BX,CX
    ADD BX,[SI]+RADIUS
    ADD BX,5
    SUB DX,5  
    SUB CX,[SI]+RADIUS
    SUB CX,5
     
    CALL DRAWLINE
    ADD DX,8
      
       
    POP CX
    LOOP LEGS
     
      
    MOV AX,[SI]+HEADRADIUS
    MOV BX,AX    
    MOV DX,BX
    MOV CX,0002H
    DIV CL
    MOV CX,AX   
    MOV AX,[SI]+RADIUS  
    MOV [SI]+RADIUS,BX
    SUB [SI]+SPIDERCENTER+2,AX
    ADD [SI]+SPIDERCENTER+2,1
    MOV [SI]+HEADFLAG,1   
     
    CALL DRAWSPIDERBODY ;SHIFTTING THE CENTER UPWARD TO DRAW
                         ;HALF CIRCLE FOR THE HEAD 
                         
    SUB [SI]+SPIDERCENTER,3
    SUB [SI]+SPIDERCENTER+2,4
    MOV [SI]+RADIUS,5
    SUB [SI]+RADIUS,4
    MOV [SI]+COLOR,4
    CALL DRAWSPIDERBODY;DRAWING LEFT EYE 
     
    ADD [SI]+SPIDERCENTER,6
    CALL DRAWSPIDERBODY ;DRAWING RIGHT EYE    
     
    POP [SI]+RADIUS
    POP [SI]+SPIDERCENTER+2  ;RESETTING THE CENTER
    POP [SI]+SPIDERCENTER 
     
    RET 
DRAWSPIDER ENDP  

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------
;-------------------------------->CLEARING PROC<-------------------------------------

CLEARSPIDER PROC

		 MOV CX,[SI]+SPIDERCENTER   ;DRAW GRAYRECTANGLE ON SPIDER
		 SUB CX,[SI]+RADIUS  
		 SUB CX,5
		 MOV DX,[SI]+SPIDERCENTER+2
		 SUB DX,[SI]+RADIUS 
		 SUB DX,5
		 MOV AL,8
		 MOV BX,[SI]+RADIUS
		 ADD BX,[SI]+RADIUS
		 ADD BX,10
		 MOV DI,[SI]+RADIUS
		 ADD DI,[SI]+RADIUS 
		 ADD DI,6
		 CALL DRAW_RECT   
    
    RET        
CLEARSPIDER ENDP 
;------------------------------------------------------------------------------------

CLEARCAR PROC
     
	 MOV AX,[SI]+CARWIDTH  ;DRAW GRAYRECTANGLE ON CAR
	 MOV CL,2
	 DIV CL
	 MOV CX,[SI]+CARCENTER
	 SUB CX,AX  
	 SUB CX,6

	 MOV AX,[SI]+CARLENGTH
	 MOV DL,2
	 DIV DL
	 MOV DX,[SI]+CARCENTER+2
	 SUB DX,AX
	 MOV AL,8
	 MOV BX,[SI]+CARWIDTH 
	 ADD BX,12
	 MOV DI,[SI]+CARLENGTH  
	 ADD DI,10
	 CALL DRAW_RECT   
ENDCLR: 
    RET        
	
CLEARCAR ENDP

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------
;-------------------------------LOADING&SAVING PROCEDURES----------------------------  

LOADCAR1SPIDER1DATA PROC

		MOV SI,0
		MOV AX, [SI]+CARCENTER1   ;MOV CAR 1 DATA TO THE GENERAL VARIABLES
		MOV [SI]+CARCENTER,AX
		MOV AX,[SI]+CARCENTER1+2
		MOV [SI]+CARCENTER+2,AX
		MOV AL,[SI]+CARCOLOR1
		MOV [SI]+CARCOLOR,AL
		MOV AX,[SI]+SPIDERCENTER1
		MOV [SI]+SPIDERCENTER,AX
		MOV AX,[SI]+SPIDERCENTER1+2
		MOV [SI]+SPIDERCENTER+2,AX
		RET
		
LOADCAR1SPIDER1DATA ENDP
;------------------------------------------------------------------------------------  
  
LOADCAR2SPIDER2DATA PROC

		MOV SI,0
		MOV AX, [SI]+CARCENTER2  ;MOV CAR 2 DATA TO THE GENERAL VARIABLES
		MOV [SI]+CARCENTER,AX
		MOV AX,[SI]+CARCENTER2+2
		MOV [SI]+CARCENTER+2,AX
		MOV AL,[SI]+CARCOLOR2
		MOV [SI]+CARCOLOR,AL 
		MOV AX,[SI]+SPIDERCENTER2
		MOV [SI]+SPIDERCENTER,AX
		MOV AX,[SI]+SPIDERCENTER2+2
		MOV [SI]+SPIDERCENTER+2,AX
		RET
		
LOADCAR2SPIDER2DATA ENDP
;------------------------------------------------------------------------------------  

SAVECAR1DATA PROC

		MOV SI,0
		MOV AX,[SI]+CARCENTER   ;MOV CAR 1 GENERAL VARIABLES DATA TO THE DATA
		MOV [SI]+CARCENTER1,AX
		MOV AX,[SI]+CARCENTER+2
		MOV [SI]+CARCENTER1+2,AX
		MOV AL,[SI]+CARCOLOR
		MOV [SI]+CARCOLOR1,AL    
		MOV AX,[SI]+SPIDERCENTER
		MOV [SI]+SPIDERCENTER1,AX
        RET
		
SAVECAR1DATA ENDP    
;------------------------------------------------------------------------------------  

SAVECAR2DATA PROC

		MOV SI,0
		MOV AX,[SI]+CARCENTER  ;MOV CAR 2 GENERAL VARIABLES DATA TO THE DATA
		MOV [SI]+CARCENTER2,AX
		MOV AX,[SI]+CARCENTER+2
		MOV [SI]+CARCENTER2+2,AX
		MOV AL,[SI]+CARCOLOR
		MOV [SI]+CARCOLOR2,AL    
		MOV AX,[SI]+SPIDERCENTER
		MOV [SI]+SPIDERCENTER2,AX     
        RET
SAVECAR2DATA ENDP

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------
;---------------------------------DRAWING ICONS PROC---------------------------------  

DRAW_DIAMOND PROC
;TAKES VALUES -> CX:MIN X CENTER, DX:Y CENTER, BX:HEIGHT, AL:COLOR
		MOV DI,2  ;HEIGHT=2

	;UPPER HALF
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH DI

	REDRAW_UP:	
		PUSH BX
		PUSH CX
		PUSH DX
		PUSH DI
		
		CALL DRAW_RECT ;(X,Y)
	
		POP DI
		POP DX
		POP CX
		POP BX		
		
		INC CX
		DEC DX
		SUB BX,2
		CMP BX,2
		JNC REDRAW_UP
	POP DI
	POP DX
	POP CX
	POP BX	

	;LOWER HALF
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH DI

	REDRAW_DOWN:	
		PUSH BX
		PUSH CX
		PUSH DX
		PUSH DI
		
		CALL DRAW_RECT ;(X,Y)
		
		POP DI
		POP DX
		POP CX
		POP BX		
		
		INC CX
		INC DX
		SUB BX,2
		CMP BX,2
		JNC REDRAW_DOWN
	POP DI
	POP DX
	POP CX
	POP BX	
	RET
DRAW_DIAMOND ENDP
;------------------------------------------------------------------------------------  

DRAW_DEC_DISTANCE_ICON PROC
;TAKES VALUES -> CX:MIN X VALUE IN DIAMOND ICON, DX: MID Y VALUE IN DIAMOND ICON
;BX:DIAMOND ICON WIDTH
;DRAW DIAMOND
		MOV AL,27H ;STANDARD INC_DIST ICON COLOR: RED
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		DEC CX  ;DRAW A LARGER DIAMOND TO CREATE AN OUTLINE FOR THE SMALLER ONE
		ADD BX,2
		MOV AL,15 ;WHITE COLOR FOR THE DIAMOND OUTLINE
		CALL DRAW_DIAMOND
	POP DX
	POP CX
	POP BX
	POP AX

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		CALL DRAW_DIAMOND ;DRAW THE SMALLER DIAMOND
	POP DX
	POP CX
	POP BX
	POP AX

;DRAW THE ICON CONTENT
	;DRAW THE UPPER TRIANGLE
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		ADD CX,6 ;SET DIMENSIONS
		SUB BX,12
		SUB DX,3 ;MOVE UP TO START DRAWING FROM BASE
		MOV AL,15 ;WHITE COLOR
		MOV DI,1 ;HEIGHT OF 1 RECTANGLE UNIT USED TO CREATE TIANGLE

		DRAW_UPPER_REV_TRI:	
			PUSH BX
			PUSH CX
			PUSH DX
			PUSH DI
			
		CALL DRAW_RECT ;(X,Y)
		
			POP DI
			POP DX
			POP CX
			POP BX		
			
			INC CX
			INC DX ;MOVE DOWN
			SUB BX,2
			CMP BX,2
			JNC DRAW_UPPER_REV_TRI
	POP DX
	POP CX
	POP BX
	POP AX

		;DRAW THE LOWER TRIANGLE
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		ADD CX,6 ;SET DIMENSIONS
		SUB BX,12 
		ADD DX,2 ;MOVE 2 STEPS DOWN TO MAKE A SPACE BETWEEN THE 2 TRIANGLES
		MOV AL,15 ;WHITE COLOR
		MOV DI,1 ;HEIGHT OF 1 RECTANGLE UNIT USED TO CREATE TIANGLE

		DRAW_LOWER_REV_TRI:	
			PUSH BX
			PUSH CX
			PUSH DX
			PUSH DI
			
		CALL DRAW_RECT ;(X,Y)
		
			POP DI
			POP DX
			POP CX
			POP BX		
			
			INC CX
			INC DX ;MOVE DOWN
			SUB BX,2
			CMP BX,2
			JNC DRAW_LOWER_REV_TRI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
DRAW_DEC_DISTANCE_ICON ENDP
;------------------------------------------------------------------------------------  

DRAW_INC_DISTANCE_ICON PROC
;TAKES VALUES -> CX:MIN X VALUE IN DIAMOND ICON, DX: MID Y VALUE IN DIAMOND ICON
;BX:DIAMOND ICON WIDTH
;DRAW DIAMOND
	MOV AL,2FH ;STANDARD INC_DIST ICON COLOR: GREEN
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		DEC CX  ;DRAW A LARGER DIAMOND TO CREATE AN OUTLINE FOR THE SMALLER ONE
		ADD BX,2
		MOV AL,15 ;WHITE COLOR FOR THE DIAMOND OUTLINE
		CALL DRAW_DIAMOND
	POP DX
	POP CX
	POP BX
	POP AX

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		CALL DRAW_DIAMOND ;DRAW THE SMALLER DIAMOND
	POP DX
	POP CX
	POP BX
	POP AX

	;DRAW THE ICON CONTENT
		;DRAW THE UPPER TRIANGLE
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		ADD CX,6 ;SET DIMENSIONS
		SUB BX,12
		SUB DX,1
		MOV AL,15 ;WHITE COLOR
		MOV DI,1 ;HEIGHT OF 1 RECTANGLE UNIT USED TO CREATE TIANGLE

		DRAW_UPPER_TRI:	
			PUSH BX
			PUSH CX
			PUSH DX
			PUSH DI
			
		CALL DRAW_RECT ;(X,Y)
		
			POP DI
			POP DX
			POP CX
			POP BX		
			
			INC CX
			DEC DX
			SUB BX,2
			CMP BX,2
			JNC DRAW_UPPER_TRI
	POP DX
	POP CX
	POP BX
	POP AX

		;DRAW THE LOWER TRIANGLE
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
		ADD CX,6 ;SET DIMENSIONS
		SUB BX,12 
		ADD DX,4 ;MOVE DOWN
		MOV AL,15 ;WHITE COLOR
		MOV DI,1 ;HEIGHT OF 1 RECTANGLE UNIT USED TO CREATE TIANGLE

		DRAW_LOWER_TRI:	
			PUSH BX
			PUSH CX
			PUSH DX
			PUSH DI
			
		CALL DRAW_RECT ;(X,Y)
		
			POP DI
			POP DX
			POP CX
			POP BX		
			
			INC CX
			DEC DX
			SUB BX,2
			CMP BX,2
			JNC DRAW_LOWER_TRI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
DRAW_INC_DISTANCE_ICON ENDP
;------------------------------------------------------------------------------------

DRAW_ROCKET_ICON PROC
;TAKES VALUES -> CX:MIN X VALUE IN DIAMOND, DX: MID Y VALUE IN DIAMOND
;BX:DIAMOND HEIGHT, AL:DIAMOND ICON COLOR
		MOV AL,14 ;YELLOW COLOR FOR ICON
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		DEC CX  ;DRAW A LARGER DIAMOND TO CREATE AN OUTLINE FOR THE SMALLER ONE
		ADD BX,2
		MOV AL,15
		CALL DRAW_DIAMOND
		POP DX
		POP CX
		POP BX
		POP AX

		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		CALL DRAW_DIAMOND ;DRAW THE SMALLER DIAMOND
		POP DX
		POP CX
		POP BX
		POP AX

		ADD CX,6 ;CENTER THE ROCKET IN THE DIAMOND BY ADJUSTING X,Y VALUES
		SUB DX,3 
		CALL DRAW_ROCKET_IN_ICON

RET
DRAW_ROCKET_ICON ENDP
;------------------------------------------------------------------------------------  

DRAW_ROCKET_IN_ICON PROC

	;DRAWING THE BODY
		PUSH CX
		PUSH DX
		
		MOV BX,8 ;SET A STANDARD ROCKET WIDTH=8
		MOV DI,10 ;SET THE HEIGHT=10
		MOV AL,0 ;BLACK COLOR
	CALL DRAW_RECT
		
		POP DX
		POP CX
	;HEAD
		PUSH CX
		PUSH DX
		ADD CX,1
		ADD DX,10 ;STARTING Y+HEIGHT
		MOV BX,6 ;SMALLER WIDTH
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,0 ;BLACK COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX
		PUSH DX
		ADD CX,2
		ADD DX,11 ;STARTING Y+HEIGHT+1
		MOV BX,4 ;SMALLER WIDTH
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,0 ;BLACK COLOR
	CALL DRAW_RECT
		POP DX
		POP CX

	;FIRE 
	;FIRST LEVEL
		PUSH CX 
		PUSH DX
		SUB DX,2
		MOV BX,8 ;SET WIDTH=8
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,28H ;RED COLOR
	CALL DRAW_RECT
		POP DX
		POP CX	
		
		PUSH CX 
		PUSH DX
		ADD CX,1
		SUB DX,2
		MOV BX,6 ;SET WIDTH=6
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,2BH ;ORANGE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX	
	;SECOND LEVEL
		PUSH CX 
		PUSH DX
		ADD CX,1
		SUB DX,3
		MOV BX,6 ;SET WIDTH=6
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,28H ;RED COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX 
		PUSH DX
		ADD CX,2
		SUB DX,3
		MOV BX,4 ;SET WIDTH=4
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,2BH ;ORANGE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
	;THIRD LEVEL
		PUSH CX
		PUSH DX
		ADD CX,3
		SUB DX,4
		MOV BX,2 ;SET WIDTH=2
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,28H ;RED COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
	;YELLOW DETAIL
		PUSH CX
		PUSH DX
		ADD CX,3   ;MIDDLE LINE
		SUB DX,3
		MOV BX,1 
		MOV DI,3 
		MOV AL,2CH ;YELLOW COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
			
		
	;WINGS
		
		PUSH CX ;FIRST WING
		PUSH DX
		ADD DX,1 ;MOVE TO LOWER ROW
		SUB CX,4 ;START 4 STEPS TO THE LEFT OF THE BODY
		MOV BX,16 ;TO DRAW BOTH WINGS 4+8+4
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,0 ;BLACK COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX ;SECOND WING
		PUSH DX
		ADD DX,2 ;MOVE TO LOWER ROW
		SUB CX,2 ;START 2 STEPS TO THE LEFT OF THE BODY
		MOV BX,12 ;TO DRAW BOTH WINGS 2+8+2
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,0 ;BLACK COLOR
	CALL DRAW_RECT
		POP DX
		POP CX	
		
		PUSH CX ;THIRD WING
		PUSH DX
		ADD DX,3 ;MOVE TO LOWER ROW
		SUB CX,1 ;START 1 STEPS TO THE LEFT OF THE BODY
		MOV BX,10 ;TO DRAW BOTH WINGS 1+8+1
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,0 ;BLACK COLOR
	CALL DRAW_RECT
		POP DX
		POP CX	
		
	;TAIL
		PUSH CX
		PUSH DX
		ADD CX,1
		SUB DX,1 ;MOVE TO HIGHER ROW
		MOV BX,6 ;SMALLER WIDTH
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,0 ;BLACK COLOR
	CALL DRAW_RECT
		POP DX
		POP CX

	;INNER COLOR DETAILS	
		PUSH CX
		PUSH DX
		ADD CX,1
		MOV BX,6
		MOV DI,8 
		MOV AL,36H ;DARK BLUE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX
		PUSH DX
		ADD CX,3   ;MIDDLE LINE
		MOV BX,1
		MOV DI,8
		MOV AL,35H ;LIGHT BLUE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX
		PUSH DX
		ADD CX,1
		ADD DX,9
		MOV BX,6
		MOV DI,1
		MOV AL,28H ;RED COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
RET
DRAW_ROCKET_IN_ICON ENDP
;------------------------------------------------------------------------------------ 

DRAW_THUNDER_ICON PROC
;TAKES VALUES -> CX:MIN X VALUE IN DIAMOND ICON, DX: MID Y VALUE IN DIAMOND ICON
;BX:DIAMOND ICON WIDTH
;DRAW DIAMOND
		MOV AL,24H ;STANDARD INC_SPEED ICON COLOR: PINK
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
			DEC CX  ;DRAW A LARGER DIAMOND TO CREATE AN OUTLINE FOR THE SMALLER ONE
			ADD BX,2
			MOV AL,15 ;WHITE COLOR FOR THE DIAMOND OUTLINE
			CALL DRAW_DIAMOND
		POP DX
		POP CX
		POP BX
		POP AX

		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
			CALL DRAW_DIAMOND ;DRAW THE SMALLER DIAMOND
		POP DX
		POP CX
		POP BX
		POP AX

		;DRAW THE BLACK OUTLINE
		PUSH AX
		PUSH CX
		PUSH DX
		SUB DX,4 ;MOV UP
		ADD CX,8 ;TO THE RIGHT
		MOV AL,0 ;BLACK COLOR
		MOV BX,6 ;SMALLER WIDTH TO CREATE A SHADE ON THE LEFT SIDE ONLY
		CALL DRAW_THUNDER_IN
		POP DX
		POP CX
		POP AX

		;DRAW THE YELLOW THUNDER
		SUB DX,4 ;MOV UP
		ADD CX,9 ;TO THE RIGHT
		MOV AL,2CH ;YELLOW COLOR
		MOV BX,5
		CALL DRAW_THUNDER_IN

RET
DRAW_THUNDER_ICON ENDP
;------------------------------------------------------------------------------------ 

DRAW_THUNDER_IN PROC
;TAKES VALUES -> CX: STARTING X VALUE, DX: STARTING Y VALUE, AL, COLOR; BX: WIDTH

		MOV SI,6 ;DRAW 6 LINES
	DRAW_UPPER_THUNDER:
		MOV DI,1 ;AND HEIGHT=1
		
		PUSH BX
		PUSH CX
		PUSH DX
		CALL DRAW_RECT
		POP DX
		POP CX
		POP BX

		DEC CX
		INC DX
		DEC SI
		JNZ DRAW_UPPER_THUNDER
		
		PUSH BX
		PUSH CX
		PUSH DX
		ADD CX,6
		DEC DX
		MOV DI,1
		MOV BX,3
		CALL DRAW_RECT
		POP DX
		POP CX
		POP BX
		
		ADD CX,7 ;SHIFT RIGHT TO DRAW LOWER PART
		DEC DX ;MOVE DOWN
		MOV SI,5 ;DRAW 5 LINES
	DRAW_LOWER_THUNDER:
		MOV DI,1
		
		PUSH CX
		PUSH DX
		PUSH BX
		CALL DRAW_RECT
		POP BX
		POP DX
		POP CX

		DEC CX
		INC DX
		DEC SI
		JNZ DRAW_LOWER_THUNDER

    RET
DRAW_THUNDER_IN ENDP 

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------
;-------------------------------->OBJECTS' MOTION<-----------------------------------

RANDGEN     PROC
;TO GENERATE A RANDOM NUMBER
;IN : NONE
;OUT: DL: RANDOM NUMBER FROM 0 TO CX-1  
		MOV AH,00H
		INT 1AH    ;CX:DX NOW HOLD NUMBER OF CLOCK
	  
		MOV AX,DX
		XOR DX,DX
		MOV CX,RANDMAX
		DIV CX     ;HERE DX CONTAINS THE REMAINDER

		RET
RANDGEN     ENDP
;------------------------------------------------------------------------------------ 

DRAW_ICON       PROC
 ;FUNCTION RESPON. FOR DRAWING ICON AND MOVING IT DOWN    
		CALL MOVEROCKETACROSSSCREEN
		   
		CMP [SI]+GFLAG,0
	    JNZ CLEARPRIV
	    RET  
			 
			 
CLEARPRIV: 
		 ;Clearing 
		 MOV CX,[SI]+GINITIAL ; SET INITIAL X  Xo   
		 MOV DX,[SI]+GINITIAL+2 ; SET INITIAL Y  Yo
		 SUB DX,11
		 MOV AL,08H ;SET COLOR
		 MOV BX,24  ;SET BX TO MAXWIDTH
		 MOV DI,25  ;SET DI TO MAXHIGHT
		 SUB CX,2
		 CALL DRAW_RECT ;(X,Y)
		 
		 CALL LOADCAR1SPIDER1DATA 
		 CALL DRAWCAR 
		 CALL DRAWSPIDER 
		 
		 CALL LOADCAR2SPIDER2DATA 
		 CALL DRAWCAR 
		 CALL DRAWSPIDER
		 
		  MOV BL,0
		 CMP GFLAG,BL
		 JNZ CONT
		 RET 
CONT:
		 MOV CX,[SI]+GINITIAL
		 MOV DX,[SI]+GINITIAL+2
		 MOV BX,20               
		 
		 MOV [SI]+ICONPOINT1,CX
		 MOV [SI]+ICONPOINT1+2,DX
		 
		  
		 CMP [SI]+TYPEFLAG,6        ;INC ->> FROM 0 TO 6
		 JLE CALLINC
		 CMP [SI]+TYPEFLAG,10        ;DEC->>FROM 7 TO 10
		 JLE CALLDEC 
		 CMP [SI]+TYPEFLAG,15        ;DEC->>FROM 11 TO 15
		 JLE CALLOBSTACLE
		 CMP [SI]+TYPEFLAG,19        ;ROCKET->>FROM 16 TO 19
		 JLE CALLROCKET
		 
		 
		 ;CALLING ICONS DRAWING             
CALLINC: 
		 CALL DRAW_INC_DISTANCE_ICON
		 JMP AFTERTYPE
CALLDEC:
		 CALL DRAW_DEC_DISTANCE_ICON  
		 JMP AFTERTYPE 
		 
CALLOBSTACLE: 
         CMP INLEVEL2,1
         JNZ AFTERTYPE
         CALL DRAW_OBSTACLE
         JMP AFTERTYPE
          		 
CALLROCKET:
		 CMP RFLAG,1
		 JZ  AFTERTYPE
		 CALL DRAW_ROCKET_ICON
		
AFTERTYPE: 
		 MOV BX,24
		 ADD [SI]+ICONPOINT1+2,BX
	   
		 PUSH AX
		 MOV CX,[SI]+ICONPOINT1
		 MOV DX,[SI]+ICONPOINT1+2
		 MOV BH,0
		 MOV AH,0DH
		 INT 10H       ;CHECK PIXEL COLOR
		 MOV BL,AL
		 POP AX
		 CMP BL,8
		 JZ HALFDUMMYDRAW      ;;IF IT DOESN'T JUMP MEANS THE CAR TOOK THE ITEM  
		 
		 ;FIRST CHECK WHICH PLAYER TOOK THE ITEM 
		 
		 CMP ICONATWHICHP,0 ;PLAYER 1 TOOK IT
		 JZ  P1TOOKIT
		 
		 CMP ICONATWHICHP,1 ;PLAYER 2 TOOK IT
		 JZ  HALFP2TOOKIT
		    
P1TOOKIT:    ;PLAYER 1 TOOK IT 
		  
		  ;;CHECKING WHICH ITEM WAS TAKEN
		  
		 CMP [SI]+TYPEFLAG,6   ;INCREMENT DISTANCE
		 JLE INCREMENTEDP1
		 
		 CMP [SI]+TYPEFLAG,10  ;DECREMENT DISTANCE
		 JLE  DECREMENTEDP1 
		 
		 CMP [SI]+TYPEFLAG,15  ; PUT OBSTACLE 
		 JLE  PUTOBSTACLEP1 
		 
		 CMP [SI]+TYPEFLAG,19   ;SHOT ROCKET
		 JLE ROCKETEDP1
		 
		 
INCREMENTEDP1: 
         cmp playerflag,1
         JNZ REVERSE4 
		 CALL STEPFORWARDP1
		 JMP HALFTHATSIT
		 REVERSE4:
		 CALL STEPFORWARDP2
		 JMP HALFTHATSIT
		 		 
DECREMENTEDP1:
         cmp playerflag,1
         JNZ REVERSE5 
		 CALL STEPBACKWARDP2  
		 JMP HALFTHATSIT
		 REVERSE5:
		 CALL STEPBACKWARDP1  
		 JMP HALFTHATSIT
		  
JMP SKIPHALFJUMP4
  ;-------------------------------------------
 ;HALFJMPS
    HALFDUMMYDRAW: JMP DUMMYDRAW
    HALFP2TOOKIT: JMP P2TOOKIT
 ;-------------------------------------------
 SKIPHALFJUMP4: 
 		 
PUTOBSTACLEP1: 
         cmp playerflag,1
         JNZ REVERSE6 
         CMP INLEVEL2,1
         JNZ HALFTHATSIT
         CALL STEPBACKWARDP1  
		 JMP HALFTHATSIT
		 REVERSE6:
		 CMP INLEVEL2,1
         JNZ HALFTHATSIT
         CALL STEPBACKWARDP2  
		 JMP HALFTHATSIT		 		 
ROCKETEDP1: 
		 CMP RFLAG,1
		 JZ  HALFTHATSIT 
		 
		 cmp playerflag,1
         JNZ REVERSE7 
		 CALL THROWROCKETONPLAYER2
		 JMP HALFTHATSIT
		 REVERSE7:
		 CALL THROWROCKETONPLAYER1
		 JMP HALFTHATSIT	 
		 
P2TOOKIT:   ;PLAYER 2 TOOK IT
		  
		 ;;CHECKING WHICH ITEM WAS TAKEN
		  
		 CMP [SI]+TYPEFLAG,6  ;INCREMNT DISTANCE
		 JLE INCREMENTEDP2
		 
		 CMP [SI]+TYPEFLAG,10  ;DECREMENT DISTANCE
		 JLE  DECREMENTEDP2 
		 
		 CMP [SI]+TYPEFLAG,15  ;PUT OBSTACLE
		 JLE  PUTOBSTACLEP2
		  
		 
		 CMP [SI]+TYPEFLAG,19   ;SHOT ROCKET
		 JLE ROCKETEDP2 
		 
;THIS PART IS PUT BECAUSE THE JUMP TO DRAW WAS OUT OF RANGE
JMP SKIPDUMMYDRAW
DUMMYDRAW: 
JMP DRAW
SKIPDUMMYDRAW:		 
		 
		 
INCREMENTEDP2: 
         cmp playerflag,1
         JNZ REVERSE
		 CALL STEPFORWARDP2
		 JMP THATSIT
		 
		 REVERSE:
		 CALL STEPFORWARDP1
		 JMP THATSIT
DECREMENTEDP2:
		 cmp playerflag,1
         JNZ REVERSE1
		 CALL  STEPBACKWARDP1
		 JMP THATSIT
		 
		 REVERSE1:
		 CALL STEPBACKWARDP2
		 JMP THATSIT  

 JMP SKIPHALFJUMP3
  ;-------------------------------------------
 ;HALFJMPS
    HALFTHATSIT: JMP THATSIT
 ;-------------------------------------------
 SKIPHALFJUMP3: 
		 
PUTOBSTACLEP2: 

         cmp playerflag,1
         JNZ REVERSE2
         CMP INLEVEL2,1
         JNZ THATSIT
         CALL STEPBACKWARDP2 
		 JMP THATSIT 
		 
		  REVERSE2:
		 CMP INLEVEL2,1
         JNZ THATSIT
         CALL STEPBACKWARDP1 
		 JMP THATSIT
		
         		 		 
ROCKETEDP2: 


          
		 CMP RFLAG,1
		 JZ  THATSIT 
		  cmp playerflag,1
         JNZ REVERSE3
		 
		 CALL THROWROCKETONPLAYER1
		 JMP THATSIT 
		 
		  REVERSE3:
		  
		 CALL THROWROCKETONPLAYER2
		 JMP THATSIT
		 		 
		 ;DO THAT ANYWAY REGARDLESS WHICH PLAYER TOOK THE ICON, OR WHICH ICON WAS IT
THATSIT: 
		MOV [SI]+GFLAG,0
		INC ARRINDEX 
		JMP CLEARPRIV
		
DRAW:
	   ;INCDIST MOTION
	   PUSH AX
	   INC [SI]+GINITIAL+2 
	 
	   MOV AX,[SI]+GINITIAL+2
	   DIV ICONMAPLIMIT  ;; AL=QUO,AH=REM
	   MOV AL,AH
	   MOV AH,0
	   MOV [SI]+GINITIAL+2,AX
						 
						  
						  
	   MOV AL,1                 ;IF NOT 1 DON'T RESET
	   CMP [SI]+GFLAG,AL
	   JNZ  INCDISTDONTRESET1
		  
	   MOV AX,[SI]+GINITIAL+2 ;CHECK FOR ROTATION
	   CMP AX,125
	   JNZ INCDISTDONTRESET1

	 
	   MOV AL,0
	   MOV GFLAG,AL
	   INC ARRINDEX
		   
STOPMOVING:   
	   ;Clearing 
	   MOV CX,[SI]+GINITIAL ; SET INITIAL X  Xo   
	   MOV DX,[SI]+GINITIAL+2 ; SET INITIAL Y  Yo
	   SUB DX,15
	   MOV AL,08H ;SET COLOR
	   MOV BX,24  ;SET BX TO MAXWIDTH
	   MOV DI,27  ;SET DI TO MAXHIGHT
	   SUB CX,2
	   CALL DRAW_RECT ;(X,Y)
INCDISTDONTRESET1:   
	  
	   CALL DRAWCAR 
	   CALL DRAWSPIDER
	   POP AX     
	 
	 ;------------------------------
	 

 RET               
 
DRAW_ICON       ENDP    
;------------------------------------------------------------------------------------  
   
;GENERATE RANDOM TYPE,POSITION,FLAG
RANDICON PROC
		MOV [SI]+RANDMAX,256 
		CMP [SI]+GFLAG,1  ;IF THERE IS ICON ON THE MAP RETURN
		JZ RETRAND 
		
		MOV DL,0  
		CALL RANDGEN ;IF DL<10 OR DL>170 OR 50<DL<60 SET DRAWING FLAG TO 1
		CMP DL,10
		JLE SETFLAG
		CMP DL,170
		JAE SETFLAG
		CMP DL,50
		JNA RETRAND
		CMP DL,60
		JNL RETRAND
		JMP SETFLAG
		
		MOV [SI]+GFLAG,0     ;ELSE DON'T DRAW
		JMP RETRAND 
		
SETFLAG:        
		MOV [SI]+GINITIAL+2 ,11   ;RESETTING POSITION (Y)
		MOV [SI]+GFLAG,1 
		
		MOV [SI]+RANDMAX,20       ;RANDOM TYPE
		CALL RANDGEN
		MOV [SI]+TYPEFLAG,DL  ;5 INC
							  ;10 DEC
							   ;15 ROCKET  
							   
		;RANDOM PLAYER AND X POSITION                     
		CALL RANDOMPOS
		
RETRAND:                   
		
    RET
RANDICON ENDP
;------------------------------------------------------------------------------------  

RANDOMPOS PROC
		MOV [SI]+RANDMAX,2   
		CALL RANDGEN     ;PLAYER1-->0
		CMP DL,0
		JZ PLAYER1 
		CMP DL,1         ;PLAYER2-->1
		JZ PLAYER2
		
PLAYER1:
		MOV ICONATWHICHP,0 
		MOV [SI]+RANDMAX,20     ;20 possible values
		CALL RANDGEN
		CMP DL,3                ;7-> first position for player1
		JLE FIRSTPOS1
		CMP DL,8                ;3-> second position for player1
		JLE SECONDPOS1
		CMP DL,13               ;18-> third position for player1
		JLE THIRDPOS1
		CMP DL,19               ;12-> fourth position for player1
		JLE FOURTHPOS1
		
FIRSTPOS1:
		MOV [SI]+GINITIAL,17
	    JMP RETRAND
SECONDPOS1:
		MOV [SI]+GINITIAL,51
		JMP RETRAND
THIRDPOS1:
		MOV [SI]+GINITIAL,85 
	    JMP RETRAND
FOURTHPOS1:
		MOV [SI]+GINITIAL,119 
		JMP RETRANDPOS 
		
PLAYER2:
		MOV ICONATWHICHP,1 
		MOV [SI]+RANDMAX,20  
		CALL RANDGEN
		CMP DL,3              ;11-> first position for player1
		JLE FIRSTPOS2
		CMP DL,8              ;17-> second position for player1
		JLE SECONDPOS2
		CMP DL,13              ;12-> third position for player1
		JLE THIRDPOS2
		CMP DL,19              ;9-> fourth position for player1
		JLE FOURTHPOS2      
		
FIRSTPOS2:
		MOV [SI]+GINITIAL,180
		JMP RETRAND
SECONDPOS2:
		MOV [SI]+GINITIAL,214
		JMP RETRAND
THIRDPOS2:
		MOV [SI]+GINITIAL,248
		JMP RETRAND
FOURTHPOS2:
		MOV [SI]+GINITIAL,282
		
		RETRANDPOS:                     
        RET
RANDOMPOS ENDP  
;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------
;---------------------------------->HEALTH BAR RELATED PROC<-------------------------

DRAW_HEART_IN PROC
;TAKES THE VALUES CX: X1 OF THE CENTER, DX:Y1 CENTER VALUE, AL: HEART COLOR, BX: MAX WIDTH
MOV DI,2 ;CONSTRUCTING HEARTOUT OF RECTANGLES OF HEIGHT=1

PUSH BX
PUSH CX
PUSH DX
PUSH DI
;DRAWING THE LOWER PART OF THE HEART
REDRAW:		
		PUSH BX
		PUSH CX
		PUSH DX
		PUSH DI

	CALL DRAW_RECT ;(X,Y)
	
		POP DI
		POP DX
		POP CX
		POP BX	
		
		INC CX ;CREATING AN UPSIDE DOWN PYRAMID
		INC DX
		SUB BX,2
		CMP BX,2
		JNC REDRAW
		
		MOV AH,0CH ;LAST PIXEL AT THE BOTTOM
		INT 10H
		
POP DI
POP DX
POP CX
POP BX	
	
;FOR THE UPPER PART OF THE HEART, DRAW 2 SETS OF RECTANGLES THAT DECREASE 
;IN WIDTH WHEN MOVING UP

;LEFTSIDE
PUSH BX
PUSH CX
PUSH DX
PUSH DI

		DEC DX ; MOVE TO THE UPPER ROW
		SUB BX,6  ;STOP DRAWING AT THE MIDDLE OF THE HEART
REDRAW_lFT:	
		PUSH BX
		PUSH CX
		PUSH DX
		PUSH DI
		
	CALL DRAW_RECT ;(X,Y)
	
		POP DI
		POP DX
		POP CX
		POP BX		
		
		INC CX
		DEC DX
		SUB BX,2
		CMP BX,2
		JNC REDRAW_LFT
POP DI
POP DX
POP CX
POP BX	

;RIGHTSIDE
PUSH BX
PUSH CX
PUSH DX
PUSH DI
		
		ADD CX,6 ;MOVE TO THE RIGHT SIDE
		DEC DX ; MOVE TO THE UPPER ROW
		SUB BX,6  ;STOP DRAWING AT THE MIDDLE OF THE HEART
REDRAW_RGT:	
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH DI
		CALL DRAW_RECT ;(X,Y)
	POP DI
	POP DX
	POP CX
	POP BX		
		INC CX
		DEC DX
		SUB BX,2
		CMP BX,2
		JNC REDRAW_RGT
POP DI
POP DX
POP CX
POP BX	

;ADDING A WHITE SHINE DETAIL
PUSH BX
PUSH CX
PUSH DX
		DEC DX   
		ADD CX,1
		MOV BX,2
		MOV AL,2CH
		MOV DI,1
		CALL DRAW_RECT
POP DX
POP CX
POP BX
		;INC DX
		ADD CX,1
		MOV BX,1
		MOV AL,2CH
		MOV DI,1
		CALL DRAW_RECT
RET
DRAW_HEART_IN ENDP
;------------------------------------------------------------------------------------

DRAW_HEART PROC
;TAKES THE VALUES CX: X1 OF THE CENTER, DX:Y1 CENTER VALUE, AL: HEART COLOR
		PUSH AX
		PUSH CX
		PUSH DX

		;CREATE A WHITE OUTLINE
		DEC CX 
		MOV BX,13 ;SET MAX WIDTH FOR OUTER HEART
		MOV AL,15 ;WHITE COLOR FOR OUTLINE
		CALL DRAW_HEART_IN

		POP DX
		POP CX
		POP AX

		;DRAW THE ACTUAL HEART
		MOV AL,27H ;SET HEART COLOR
		MOV BX,11 ;SET MAX WIDTH
		CALL DRAW_HEART_IN

		RET
DRAW_HEART ENDP
;------------------------------------------------------------------------------------  

HEALTHBAR PROC

		MOV BX,85
		MOV CX,4
		 
		HEARTAGAIN:
		PUSH CX   
		MOV CX,BX ;SET X1 CENTER VALUE
		MOV DX,156 ;SET Y1 CENTER VALUE
		MOV AL,27H ;SET HEART COLOR
		CALL DRAW_HEART

		ADD BX,160
		MOV CX,BX
		CALL DRAW_HEART 
		SUB BX,160

		ADD BX,13
		POP CX              
		LOOP HEARTAGAIN
		
		MOV CX,0 ; SET INITIAL X  Xo   
        MOV DX,166 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,320  ;SET BX TO MAXWIDTH
        MOV DI,34  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  
		
		MOV CX,156 ; SET INITIAL X  Xo   
        MOV DX,166 ; SET INITIAL Y  Yo
        MOV AL,69H ;SET COLOR
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,34  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
        
        MOV CX,149 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,0FH ;SET COLOR
        MOV BX,21  ;SET BX TO MAXWIDTH
        MOV DI,34  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
        MOV CX,150 ; SET INITIAL X  Xo   
        MOV DX,1 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,19  ;SET BX TO MAXWIDTH
        MOV DI,32  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,13H     ;CURSOR X
        MOV DH,01H     ;CURSOR Y
        INT 10H
        
        ;PRINTING
        MOV AH,9
        MOV BH,0
        MOV AL,BYTE PTR 'L'
        MOV CX,1
        MOV BL,0FH
        INT 10H
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,14H     ;CURSOR X
        MOV DH,01H     ;CURSOR Y
        INT 10H
        
        ;PRINTING
        MOV AH,9
        MOV BH,0
        MOV AL,BYTE PTR 'V'
        MOV CX,1
        MOV BL,0FH
        INT 10H
        
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,13H     ;CURSOR X
        MOV DH,02H     ;CURSOR Y
        INT 10H
        
        ;PRINTING
        MOV AH,9
        MOV BH,0
        MOV AL,INLEVEL2 
        ADD AL,49
        MOV CX,1
        MOV BL,0FH
        INT 10H
        
        ;INLEVEL2   

RET    
HEALTHBAR ENDP
;------------------------------------------------------------------------------------

EraseHeartp1 proc
;switch case on the number of hearts
;may be 1, 2, 3 or 4

		Cmp NumOfHeartsP1, 1
		Jz RemoveHeart1P1
		Cmp NumOfHeartsP1, 2
		Jz RemoveHeart2P1
		Cmp NumOfHeartsP1, 3
		Jz RemoveHeart3P1
		Cmp NumOfHeartsP1, 4
		Jz RemoveHeart4P1 


RemoveHeart1P1:
;FOR ERASING FIRST HEART P1
 MOV CX,84 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y) 
       
       MOV [SI]+ISTHEGAMEOVER,1
       MOV P1WINS,0  
  Jmp DoNoMoreP1

RemoveHeart2P1:
;FOR ERASING SECOND HEART P1
 MOV CX,101 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
Jmp DoNoMoreP1

RemoveHeart3P1:
;FOR ERASING THIRD HEART P1
 MOV CX,118 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
Jmp DoNoMoreP1

RemoveHeart4P1:
;FOR ERASING FOURTH HEART P1
 MOV CX,135 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y) 
Jmp DoNoMoreP1


DoNoMoreP1:
DEC NumOfHeartsP1

RET
EraseHeartp1 endp
;------------------------------------------------------------------------------------  

EraseHeartp2 proc
;switch case on the number of hearts
;may be 1, 2, 3 or 4

		Cmp NumOfHeartsP2, 1
		Jz RemoveHeart1P2
		Cmp NumOfHeartsP2, 2
		Jz RemoveHeart2P2
		Cmp NumOfHeartsP2, 3
		Jz RemoveHeart3P2
		Cmp NumOfHeartsP2, 4
		Jz RemoveHeart4P2 


RemoveHeart1P2:
;FOR ERASING FIRST HEART P2
 MOV CX,246 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y) 
        
  MOV [SI]+ISTHEGAMEOVER,1
  MOV P1WINS,1       
        
 Jmp DoNoMoreP2

RemoveHeart2P2:
;FOR ERASING SECOND HEART P2
 MOV CX,263 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y) 
Jmp DoNoMoreP2

RemoveHeart3P2:
;FOR ERASING THIRD HEART P2
 MOV CX,280 ; SET INITIAL X  Xo   
        MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y) 
Jmp DoNoMoreP2

RemoveHeart4P2:
;FOR ERASING FOURTH HEART P2
 MOV CX,297 ; SET INITIAL X  Xo   
       MOV DX,151 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
Jmp DoNoMoreP2


DoNoMoreP2:
DEC NumOfHeartsP2

RET
EraseHeartp2 endp

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------
;-------------------------->STEPPING FORWARD\BACKWARD<-------------------------------  

STEPFORWARDP1 PROC
 
		 MOV SI,0
		 CALL LOADCAR1SPIDER1DATA 

		 ;CHECK IF IT'S ALREADY MOST FORWARDED Y=90
		 CMP [SI]+CARCENTER+2,90
		 JZ USLESSFORWARDP1
		 CALL CLEARCAR
		 ;REDRAW THE NEW POSITION
		 CALL LOADCAR1SPIDER1DATA
		 SUB [SI]+CARCENTER+2,5
		 CALL DRAWCAR
		 CALL SAVECAR1DATA 

		 USLESSFORWARDP1: 
			RET    
STEPFORWARDP1 ENDP 
;------------------------------------------------------------------------------------

STEPFORWARDP2 PROC
    
		 MOV SI,0
		 CALL LOADCAR2SPIDER2DATA 

		 ;CHECK IF IT'S ALREADY MOST FORWARDED Y=90
		 CMP [SI]+CARCENTER+2,90
		 JZ USLESSFORWARDP2
		 ;CLEAR THE OLD CAR
		 CALL CLEARCAR 
		 ;REDRAW THE NEW POSITION
		 CALL LOADCAR2SPIDER2DATA
		 SUB [SI]+CARCENTER+2,5
		 CALL DRAWCAR
		 CALL SAVECAR2DATA 

		 USLESSFORWARDP2: 

		 RET    
STEPFORWARDP2 ENDP
;------------------------------------------------------------------------------------  

STEPBACKWARDP1 PROC

		 MOV SI,0
		 CALL LOADCAR1SPIDER1DATA 
		 CALL CLEARCAR
		 
		 ;REDRAW AFTER BEING BACKWARDED 
		 CALL LOADCAR1SPIDER1DATA
		 ADD [SI]+CARCENTER+2,5
		 CALL DRAWCAR
		 CALL SAVECAR1DATA 
		 
		 ;CHECK IF IT'S CAUGHT BY THE SPIDER Y=110
		 CMP [SI]+CARCENTER+2,110
		 JNZ STILLALIVEP1 
		 MOV [SI]+ISTHEGAMEOVER,1
		 MOV P1WINS,0 
		 STILLALIVEP1: 
		 RET    
STEPBACKWARDP1 ENDP
;------------------------------------------------------------------------------------  

STEPBACKWARDP2 PROC
    
		 MOV SI,0 
			;CLEAR CAR FIRST
		 CALL LOADCAR2SPIDER2DATA 
		 CALL CLEARCAR 
			;REDRAW AFTER BEING BACKWARDED
		 CALL LOADCAR2SPIDER2DATA
		 ADD [SI]+CARCENTER+2,5
		 CALL DRAWCAR
		 CALL SAVECAR2DATA 
		 
		 ;CHECK IF IT'S CAUGHT BY THE SPIDER Y=110
		 CMP [SI]+CARCENTER+2,110
		 JNZ STILLALIVEP2 
		 MOV [SI]+ISTHEGAMEOVER,1
		 MOV P1WINS,1 
		 STILLALIVEP2: 
		 RET    
STEPBACKWARDP2 ENDP

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------
;------------------------------>ROCKET RELATED PROC<---------------------------------

DRAW_ROCKET PROC

	;DRAWING THE BODY
		PUSH CX
		PUSH DX
		
		MOV BX,10 ;SET A STANDARD ROCKET WIDTH=14
		MOV DI,16 ;SET THE HEIGHT=20
		MOV AL,15 ;WHITE COLOR
	CALL DRAW_RECT
		
		POP DX
		POP CX
	;HEAD
		PUSH CX
		PUSH DX
		ADD CX,2
		ADD DX,16 ;STARTING Y+HEIGHT
		MOV BX,6 ;SMALLER WIDTH
		MOV DI,2 ;SET THE HEIGHT=2
		MOV AL,15 ;WHITE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX
		PUSH DX
		ADD CX,4
		ADD DX,18 ;STARTING Y+HEIGHT+2
		MOV BX,2 ;SMALLER WIDTH
		MOV DI,2 ;SET THE HEIGHT=2
		MOV AL,15 ;WHITE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX

	;FIRE 
	;FIRST LEVEL
		PUSH CX 
		PUSH DX
		SUB DX,6
		MOV BX,10 ;SET WIDTH=10
		MOV DI,4 ;SET THE HEIGHT=4
		MOV AL,28H ;RED COLOR
	CALL DRAW_RECT
		POP DX
		POP CX	
		
		PUSH CX 
		PUSH DX
		ADD CX,2
		SUB DX,6
		MOV BX,6 ;SET WIDTH=6
		MOV DI,4 ;SET THE HEIGHT=4
		MOV AL,2BH ;ORANGE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX	
	;SECOND LEVEL
		PUSH CX 
		PUSH DX
		ADD CX,2
		SUB DX,8
		MOV BX,6 ;SET WIDTH=6
		MOV DI,2 ;SET THE HEIGHT=2
		MOV AL,28H ;RED COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX 
		PUSH DX
		ADD CX,4
		SUB DX,8
		MOV BX,2 ;SET WIDTH=2
		MOV DI,2 ;SET THE HEIGHT=2
		MOV AL,2BH ;ORANGE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
	;THIRD LEVEL
		PUSH CX
		PUSH DX
		ADD CX,4
		SUB DX,10
		MOV BX,2 ;SET WIDTH=2
		MOV DI,2 ;SET THE HEIGHT=2
		MOV AL,28H ;RED COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
	;YELLOW DETAIL
		PUSH CX
		PUSH DX
		ADD CX,4   ;MIDDLE LINE
		SUB DX,10
		MOV BX,2 
		MOV DI,8 
		MOV AL,2CH ;YELLOW COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
			
		
	;WINGS
		
		PUSH CX ;FIRST WING
		PUSH DX
		ADD DX,1 ;MOVE TO LOWER ROW
		SUB CX,6 ;START 6 STEPS TO THE LEFT OF THE BODY
		MOV BX,22 ;TO DRAW BOTH WINGS 6+10+6
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,15 ;WHITE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX ;SECOND WING
		PUSH DX
		ADD DX,2 ;MOVE TO LOWER ROW
		SUB CX,4 ;START 4 STEPS TO THE LEFT OF THE BODY
		MOV BX,18 ;TO DRAW BOTH WINGS 4+10+4
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,15 ;WHITE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX	
		
		PUSH CX ;THIRD WING
		PUSH DX
		ADD DX,3 ;MOVE TO LOWER ROW
		SUB CX,2 ;START 2 STEPS TO THE LEFT OF THE BODY
		MOV BX,14 ;TO DRAW BOTH WINGS 2+10+2
		MOV DI,1 ;SET THE HEIGHT=1
		MOV AL,15 ;WHITE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX	
		
	;TAIL
		PUSH CX
		PUSH DX
		ADD CX,2
		SUB DX,2 ;MOVE TO HIGHER ROW
		MOV BX,6 ;SMALLER WIDTH
		MOV DI,2 ;SET THE HEIGHT=2
		MOV AL,15 ;WHITE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX

	;INNER COLOR DETAILS	
		PUSH CX
		PUSH DX
		ADD CX,2
		MOV BX,6
		MOV DI,12 
		MOV AL,36H ;DARK BLUE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX
		PUSH DX
		ADD CX,4   ;MIDDLE LINE
		MOV BX,2 
		MOV DI,12 
		MOV AL,35H ;LIGHT BLUE COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		
		PUSH CX
		PUSH DX
		ADD CX,2
		ADD DX,14
		MOV BX,6
		MOV DI,2 
		MOV AL,28H ;RED COLOR
	CALL DRAW_RECT
		POP DX
		POP CX
		RET
DRAW_ROCKET ENDP
;------------------------------------------------------------------------------------

THROWROCKETONPLAYER1 PROC
;IF PLAYER2 TAKES A ROCKET ICON, THROW A ROCKET ON PLAYER1
;1: DRAW ROCKET IN THE LANE OF PLAYER1 CAR AND MOVE IT DOWN THE SCREEN
;2: IF IT HITS PLAYER1, MOVE IT ONE STEP BACKWARD + DEC HEARTS

	
		MOV SI,0
		CALL LOADCAR1SPIDER1DATA
		MOV AX,CARCENTER1
		
		SUB AX,5   ;INITIAL X VALUE OF ROCKET ACCORDING TO TARGET CAR POSITION
		MOV [SI]+RINITIAL, AX
		MOV AL,1
		MOV [SI]+RFLAG,AL 
		MOV [SI]+2+RINITIAL,11
		
		MOV AL,0
		

		MOV  ROCKETISAT+[SI],1
		CALL MOVEROCKETACROSSSCREEN
		
		RET
THROWROCKETONPLAYER1 ENDP
;------------------------------------------------------------------------------------

THROWROCKETONPLAYER2 PROC
;IF PLAYER2 TAKES A ROCKET ICON, THROW A ROCKET ON PLAYER1
;1: DRAW ROCKET IN THE LANE OF PLAYER1 CAR AND MOVE IT DOWN THE SCREEN
;2: IF IT HITS PLAYER1, MOVE IT ONE STEP BACKWARD + DEC HEARTS

		MOV SI,0
		CALL LOADCAR1SPIDER1DATA
		MOV AX,CARCENTER2
		
		SUB AX,5   ;INITIAL X VALUE OF ROCKET ACCORDING TO TARGET CAR POSITION
		MOV [SI]+RINITIAL, AX
		MOV AL,1
		MOV [SI]+RFLAG,AL
		MOV [SI]+2+RINITIAL,11
		
		MOV AL,0
		

		MOV  ROCKETISAT+[SI],2

		CALL MOVEROCKETACROSSSCREEN

		RET
THROWROCKETONPLAYER2 ENDP
;------------------------------------------------------------------------------------

MOVEROCKETACROSSSCREEN PROC
;FUNCTION RESPON. FOR DRAWING ICON AND MOVING IT DOWN
 ;IN: AX: INITAL X 
     
		 CMP [SI]+RFLAG,0
		 JNZ CLEARPRIV_ROCK
		 RET
		   
		CLEARPRIV_ROCK: 
		
		 ;Clearing 
		 MOV CX,[SI]+RINITIAL ; SET INITIAL X  Xo   
		 MOV DX,[SI]+RINITIAL+2 ; SET INITIAL Y  Yo
		 SUB DX,15
		 MOV AL,08H ;SET COLOR
		 MOV BX,24  ;SET BX TO MAXWIDTH
		 MOV DI,35  ;SET DI TO MAXHIGHT
		 SUB CX,7
		 CALL DRAW_RECT ;(X,Y) 
		 CALL DRAWCAR 
		 CALL DRAWSPIDER
		  MOV BL,0
		 CMP RFLAG,BL
		 JNZ CONT_ROCK
		 RET
		 CONT_ROCK:
		 MOV CX,[SI]+RINITIAL
		 MOV DX,[SI]+RINITIAL+2
		 MOV BX,20               
		  
		 ADD [SI]+RINITIAL+2,2 
		  
		 MOV [SI]+ROCKPOINT1,CX
		 MOV [SI]+ROCKPOINT1+2,DX
		 
		 ;CALLING ICONS DRAWING             
		 CALL DRAW_ROCKET
		 
		 AFTERTYPE_ROCK: 
		 MOV BX,24
		 ADD [SI]+ROCKPOINT1+2,BX
	   
		 PUSH AX
		 MOV CX,[SI]+ROCKPOINT1
		 MOV DX,[SI]+ROCKPOINT1+2
		 MOV BH,0
		 MOV AH,0DH
		 INT 10H  
		 MOV BL,AL
		 POP AX
		 CMP BL,8
		 JZ DRAW_ROCK 


		 MOV AX,[SI]+RINITIAL+2 ;CHECK FOR ROTATION
		 CMP AX,110
		 JGE  HARMDONE  
		 
		 MOV HARMGENERAL+[SI],1 ;PLAYER TOUCHED THE ROCKET
		 
			
		 CMP  ROCKETISAT+[SI],1
		 JNZ   HARM2
		 CALL ERASEHEARTP1
		 CALL STEPBACKWARDP1
		 JMP HARMDONE
		 HARM2:
		 CMP  ROCKETISAT+[SI],2
		 JNZ   HARMDONE   
		 CALL ERASEHEARTP2
		 CALL STEPBACKWARDP2
		 HARMDONE:
		 MOV [SI]+RFLAG,0 
		 MOV HARMGENERAL+[SI],0
		 MOV HARMPLAYER1+[SI],0
		 MOV HARMPLAYER2+[SI],0
		 MOV ROCKETISAT+[SI],0
		 
		 JMP CLEARPRIV_ROCK
	
		 DRAW_ROCK:

		 RET             
MOVEROCKETACROSSSCREEN ENDP 

DRAW_OBSTACLE PROC
;TAKES THE STARTING X,Y VALUES FOR OBSTACLE (CX:X, DX:Y)

;DRAW CENTER LINE
PUSH CX
PUSH DX

MOV BX,20 ;OBSTACLE WIDTH
MOV DI,3 ;OBSTACLE HEIGHT
MOV AL,06H ;BROWN COLOR
PUSH BX
PUSH CX
PUSH DX
CALL DRAW_RECT 
POP DX
POP CX
POP BX

;ADD DETAIL TO CENTER LINE (DARKER LINE IN THE MIDDLE)
INC DX
MOV DI,1 ;DRAW IN THE CENTER OF THE PREVIOUS RECTANGLE
MOV AL,6FH ;DARK BROWN COLOR
PUSH BX
PUSH CX
PUSH DX
CALL DRAW_RECT 
POP DX
POP CX
POP BX

POP DX
POP CX

;DRAW RECTANGLES IN THE FENCE
ADD CX,4
SUB DX,1 ;RECTANGLE IS THICKER THAT THE CENTER LINE
MOV BX,4 ;WIDTH=4
MOV DI,5 ;HEIGHT=1+3+1
MOV AL,06H ;BROWN COLOR

PUSH BX
PUSH CX
PUSH DX
PUSH DI
CALL DRAW_RECT 
POP DI
POP DX
POP CX
POP BX

ADD CX,8 ;TO DRAW THE SECOND RECTANGLE
CALL DRAW_RECT 
RET
DRAW_OBSTACLE ENDP

;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------ 

CHATSCREEN    PROC
           
        ;CLEARING
        MOV AX,0
        MOV BX,0
        MOV CX,0
        MOV DX,0
        MOV SI,0
        MOV DI,0
       

        
CHATLOOP:        
        MOV AL,0
        MOV AH,01h
        INT 16H        ;TAKE INPUT 
        
        CMP AL,27      ;CHECKS ON INPUT
        JZ  TOSEND
        CMP AH,1
        JZ  TORECIEVE
 
TOSEND:        
        CALL CHECKINPUT ; 0-> ENTER , 1->BACKSPACE , 2->NORMAL MSG , 3->ESC
        
        CMP  INPUTFLAG,2
        JZ   TONORMAL 
        
        CMP  INPUTFLAG,1
        JZ   TOBACKSPACE 
        
        CMP  INPUTFLAG,3
        JZ   TOESC   
        
        CMP  INPUTFLAG,0
        JZ   TOENTER
TONORMAL:
        CALL NORMALMSG 
        JMP  TORECIEVE 
TOBACKSPACE:
        CALL PRESSBACKSPACE
        JMP  TORECIEVE
        
TOESC:  
        CALL PRESSESC
        JMP  TORECIEVE        

TOENTER:
        CALL PRESSENTER
        JMP  TORECIEVE
        
TORECIEVE:  
        CMP EXITCHAT,1   ;IF PRESSED ESC
        JZ  RECIVE_ESC
        
        
        CALL RECIEVE
        MOV  AL,VALUE
        
        CALL CHECKINPUT
        
        CMP  INPUTFLAG,2
        JZ   RECIEVE_N  
        
        CMP  INPUTFLAG,1
        JZ   RECIEVE_B 
        
        CMP  INPUTFLAG,3
        JZ   RECIVE_ESC  
        
        CMP  INPUTFLAG,0
        JZ   RECIVE_E
        
RECIEVE_N:        
        CALL RECIEVENORMAL
        JMP CHATLOOP 
RECIEVE_B:
        CALL RECIEVEBACKSPACE        
        JMP CHATLOOP
RECIVE_E:
        CALL RECIEVEENTER
        JMP CHATLOOP
RECIVE_ESC:
        MOV EXITCHAT,0  
                

                   
        RET
CHATSCREEN    ENDP
;----------------------------------------------------------------
PRESSESC      PROC
                        
        MOV AH,0 ;CLEAR BUFFER
        INT 16H 
        
        MOV EXITCHAT,1
        MOV VALUE,AL
        CALL SEND
        
        RET        
PRESSESC      ENDP 

;----------------------------------------------------------------
PRESSENTER    PROC
        MOV AH,0 ;CLEAR BUFFER
        INT 16H 
        
        CMP STRING_X,0     ;IF NO CHARS
        JNZ  DOENTER  
        RET
DOENTER:  
        MOV VALUE,AL
        CALL SEND
            
     
        MOV STRING_X,0 
        
        INC SI ; END OF LINE
SCROL:        
        CMP STRING_Y,17H
        JNZ NOTMAXLINE2
        RESETY1:
        MOV AH,6
        MOV AL,1
        MOV BH,0
        MOV CH,15H
        MOV CL,00H
        MOV DH,17H
        MOV DL,12H
        INT 10H
        MOV STRING_X,0
        MOV LASTLINE,1 
        JMP NEXTCHAR2
        NOTMAXLINE2:
        INC STRING_Y
NEXTCHAR2:        
        INC SI        
                   
                       
                       
        RET        
PRESSENTER    ENDP 
;----------------------------------------------------------------
RECIEVEENTER    PROC
        
        CMP NOSEND,0
        JNZ NORECIEVE2


SCROL2:
        MOV STRING_X2,15H

        INC SI   ;END OF LINE
        
        CMP STRING_Y2,17H
        JNZ NOTMAXLINE4
        
        ;MOV STRING_Y2,0AH
        MOV AH,6
        MOV AL,1
        MOV BH,0
        MOV CH,15H
        MOV CL,15H
        MOV DH,17H
        MOV DL,28H
        INT 10H
        MOV STRING_X2,15H
        MOV LASTLINE2,1 
        JMP NORECIEVE2
        NOTMAXLINE4:
        INC STRING_Y2
        
NORECIEVE2:
        MOV NOSEND,1    
        RET        
RECIEVEENTER    ENDP
;----------------------------------------------------------------
PRESSBACKSPACE     PROC
                
        MOV AH,0 ;CLEAR BUFFER
        INT 16H 
        
        CMP STRING_X,0
        JNZ DOBACKSPACE
         
        CMP STRING_Y,15H
        JZ  DONTPREVLINE
        DEC STRING_Y
        MOV STRING_X,18 
        JMP ERASE 
DONTPREVLINE:        
        
        RET        

DOBACKSPACE:        
        MOV VALUE,AL
              
        DEC STRING_X
ERASE:         
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,STRING_X    ;WHERE TO WRITE AT
        MOV DH,STRING_Y     ;CURSOR Y
        INT 10H
        
        MOV AH,2
        MOV DL,20H
        INT 21H    ;CLEARCHAR
        
        CALL SEND
        
                 
        RET        
PRESSBACKSPACE     ENDP 
;----------------------------------------------------------------
RECIEVEBACKSPACE     PROC
        
        CMP NOSEND,0
        JNZ NORECIEVE1 


        CMP STRING_X2,15H
        JNZ DOBACKSPACE3 
        
        CMP STRING_Y2,0DH
        JZ  DONTPREVLINE2
        DEC STRING_Y2
        MOV STRING_X2,39 
        JMP ERASE2
DONTPREVLINE2:
        
        RET
DOBACKSPACE3:        
        DEC STRING_X2
ERASE2:
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,STRING_X2    ;WHERE TO WRITE AT
        MOV DH,STRING_Y2     ;CURSOR Y
        INT 10H
        
        MOV AH,2
        MOV DL,20H
        INT 21H    ;CLEARCHAR

NORECIEVE1:
        MOV NOSEND,1
        RET        
RECIEVEBACKSPACE     ENDP
;----------------------------------------------------------------
NORMALMSG     PROC
        CMP AH,1
        JNZ  DONORMALMSG       
        RET 
DONORMALMSG:        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,STRING_X    ;WHERE TO WRITE AT
        MOV DH,STRING_Y     ;CURSOR Y
        INT 10H

 
                
        MOV TEMPMSG+[SI],AL ;STORE 
        MOV VALUE,AL      
        MOV AH,2
        MOV DL,AL
        INT 21H    ;DISPLAY
        
        MOV AH,0 ;CLEAR BUFFER
        INT 16H
        ;SEND
        
        
        INC STRING_X
        CMP STRING_X,13H ; NEXT LINE
        JNZ NEXTCHAR
        
        MOV STRING_X,0

        
        
        CMP STRING_Y,17H
        JNZ NOTMAXLINE
        RESETY:
        MOV AH,6
        MOV AL,1
        MOV BH,0
        MOV CH,15H
        MOV CL,00H
        MOV DH,17H
        MOV DL,12H
        INT 10H
        MOV STRING_X,0
        MOV LASTLINE,1 
        JMP NEXTCHAR
        NOTMAXLINE:
        INC STRING_Y
NEXTCHAR:
        INC CX
        INC SI        
                
              

        ;MOV VALUE,AL
        CALL SEND
        

             
                
        RET
NORMALMSG     ENDP
;------------------------------------------------------------------------------------
RECIEVENORMAL   PROC
    
        CMP NOSEND,0
        JNZ NORECIEVE
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,STRING_X2    ;WHERE TO WRITE AT
        MOV DH,STRING_Y2    ;CURSOR Y
        INT 10H        
        
        MOV TEMPMSG2+[SI],AL ;STORE       
        MOV AH,2
        MOV DL,AL
        INT 21H    ;DISPLAY
        
        
        INC STRING_X2
        CMP STRING_X2,40 ; NEXT LINE
        JNZ NORECIEVE
        
        MOV STRING_X2,15H
        
        
        CMP STRING_Y2,17H
        JNZ NOTMAXLINE3
        
        ;MOV STRING_Y2,0AH
        MOV AH,6
        MOV AL,1
        MOV BH,0
        MOV CH,15H
        MOV CL,15H
        MOV DH,17H
        MOV DL,28H
        INT 10H
        MOV STRING_X2,15H
        MOV LASTLINE2,1
        JMP NORECIEVE
        NOTMAXLINE3:
        INC STRING_Y2         
;-----------------------------------------                
NORECIEVE:
        MOV NOSEND,1              
        
        
        RET
RECIEVENORMAL   ENDP    
;------------------------------------------------------------------------------------

CHECKINPUT PROC
    
        ;CHECKING ON INPUT
        
        CMP AL,13
        JNZ  NOTENTER ;PRESSED ENTER 
        MOV INPUTFLAG,0  
        RET
NOTENTER:         
        CMP AL,8
        JNZ  NOTBACKSPACE  ;PRESSED BACKSPACE
        MOV INPUTFLAG,1
        RET 
NOTBACKSPACE:        
        CMP AL,27
        JNZ NOTESC  
        MOV INPUTFLAG,3
        RET
NOTESC:        

        MOV INPUTFLAG,2
    RET
CHECKINPUT ENDP 

INTIALIZEPORT    PROC
    
        mov dx,3fbh 			; Line Control Register
mov al,10000000b		;Set Divisor Latch Access Bit
out dx,al				;Out it

      ;Set LSB byte of the Baud Rate Divisor Latch register.
mov dx,3f8h			
mov al,0ch			
out dx,al

;Set MSB byte of the Baud Rate Divisor Latch register.
mov dx,3f9h
mov al,00h
out dx,al

mov dx,3fbh
mov al,00011011b
out dx,al
    
    
    RET
    
INTIALIZEPORT    ENDP

SEND    PROC
;Check that Transmitter Holding Register is Empty
		mov dx , 3FDH		; Line Status Register
  	In al , dx 			;Read Line Status
  		AND al , 00100000b
  		JZ AGAIN9

;If empty put the VALUE in Transmit data register
  		mov dx , 3F8H		; Transmit data register
  		mov  al,VALUE
  		out dx , al 
AGAIN9:      


    RET    
SEND    ENDP

RECIEVE  PROC
;Check that Data Ready
		mov dx , 3FDH		; Line Status Register
		in al , dx 
  		AND al , 1
  		JZ CHK9

 ;If Ready read the VALUE in Receive data register
  		mov dx , 03F8H
  		in al , dx 
  		mov VALUE , al
  		
  		MOV NOSEND,0    
  		
     CHK9:
     
    RET
RECIEVE  ENDP 

WAITFORPLAYER2  PROC 
    MOV VALUE,0    
WAITFORPLAYER2LOOP: 
        CALL RECIEVE
                
        CMP NOSEND,0
        JNZ WAITFORPLAYER2LOOP
        MOV NOSEND,1 
        
        RET  
WAITFORPLAYER2  ENDP

  END main2  
 
  
 