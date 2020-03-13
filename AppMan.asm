EXTRN main2:FAR 
EXTRN P1WINS:BYTE
EXTRN LOADING:FAR

PUBLIC CARCOLOR1, CARCOLOR2, P1NAME, P2NAME,INLEVEL2,GAMESPEED,CLEARRECIEVE,PLAYERFLAG,RANDLANES,RANDICONS
        .MODEL SMALL
;-----------------------------------------------------------------------------
        .STACK 64
;-----------------------------------------------------------------------------
        .DATA
 PRESSANYKEYMSG     DB      '    PRESS ANY KEY','$'  
 ENTERYOURNAMEMSG   DB      'ENTER YOUR NAME(MAX 15 CHAR.):','$'
 PRESSENTERMSG      DB      'PRESS ENTER TO CONTINUE','$'
 INVALIDCHARMSG1    DB      'ERROR!,YOU ETNERED AN INVALID','$' 
 INVALIDCHARMSG2    DB      'FIRST CHARACTER. PLEASE RE-ENTER','$'
 NEWGAMEMSG         DB      'NEW GAME','$'
 CHATMSG            DB      'CHAT','$'
 EXITMSG            DB      'EXIT','$' 
 DASHMSG            DB      '--------------------------------------------------------------------------------','$'
 COLORSMSG          DB      'COLORS','$'
 DISPLAYMSG         DB      'DISPLAY','$'
 PICKCOLORMSG       DB      'PICK ANY COLOR','$' 
 GAMEOVERMESSAGE    DB      'GAME OVER','$'
 REMATCHMESSAGE     DB      'Press enter for a rematch','$'
 WINNERMESSAGE      DB      ' IS THE SURVIVOR','$'
 INVADEDMESSAGE     DB      'INVADED','$' 
 WAITINGMSG         DB      'WAITING FOR THE OTHER PLAYER..                                 ','$'    
 WAITINGMSG2        DB      'WAITING FOR THE OTHER PLAYER..','$'
 CHATREQUESTMSG     DB      ' sent a chat invitavtion!, go to chat                          ','$'
 GAMEREQUESTMSG     DB      ' sent a game invitavtion!, go to game                          ','$' 
 WAITINGLEVELMSG    DB      'WAITING FOR SELECTING LEVELS                                   ','$'
 
 ALERT_X            DB      0
 ALERT_Y            DB      24  

 MAXMSGSIZE         DW      ?
 TEMPMSG            DB      1500 DUP('$')
 STRING_X           DB      0
 STRING_Y           DB      1 
 
 FISRTCHARFLAG      DB      1
 
EXITNAME            DB      0     
EXITNAME2           DB      0
INVALIDNAMEFLAG     DB      0
STOPINPUT           DB      0  
 
TEMPMSG2            DB      1500 DUP('$')   ;TO EDIT SIZE
STRING_X2           DB      00H
STRING_Y2           DB      0DH
LASTLINE            DB      0
LASTLINE2           DB      0     
LASTLINE3           DB      0
VALUE               DB      0
NOSEND              DB      1   
NOREC               DB      1
 
 P1NAME             DB      16 DUP('$')
 P2NAME             DB      16 DUP('$')
   
STRINGNAME_X            DB      07H
STRINGNAME_Y            DB      0DH 

INPUTFLAG           DB      ? ;0 ENTER - 1 BACKSPACCE - 2 CHAR
CHATDASHMSG         DB      '----------------------------------------','$' ;TO ADD    
CHATFLAG            DB      0
EXITCHAT            DB      0 

 
 CARCENTER          DW      263,106 
 CARLENGTH          DW      20
 CARWIDTH           DW      10
 CARSTARTX          DW      ? 
 CARSTARTXPERM      DW      ? 
 CARSTARTYPERM      DW      ?
 WINDOWSTARTY       DW      ?
 CARCOLOR           DB      0FH
 
 ;;SPIDER
 SPIDERCENTER 		DW 		20,20
 RADIUS  			DW		9 
 TOPPOINT 			DW 		? 
 HEADRADIUS		 	DW 		5 
 HEADFLAG 			DB 		0
 COLOR 				DB  	?
 
 CARCOLOR1          DB      ?
 CARCOLOR2          DB      ?
 
 TEMP               DW      ?
 
 PLAYERFLAG         DB      2 
 GAMEFLAG           DB      0  
 
 ;;GAME LEVEL
 
 INLEVEL2           DB      1 
 GAMESPEED          DW      2
 LEVELCHOICE        DB      0 
 LEVEL1MSG         DB      'LEVEL 1','$'
 LEVEL2MSG          DB      'LEVEL 2','$' 
 
 
 RANDLANES          DB      99 DUP(1)  
 RANDICONS          DB      99 DUP(1) 
 RANDMAX             DW     9 
;-----------------------------------------------------------------------------
   
        .CODE
    
;---------------------------------------   
INCLUDE DrawLogo.inc       
;---------------------------------------       
      

    
MAIN    PROC FAR
    
        MOV AX,@DATA
        MOV DS,AX        

        CALL INTIALIZEPORT
        
        MOV AH,0
        MOV AL,13H
        INT 10H ;CHANGE TO VIDEO MODE
   
        ;------------------------------------------------------------------------------------
        ;--------------------------------GAME START------------------------------------------       
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------        
     
    
        DRAWLOGO  ; Drawing Game Intro
        
        
        
        MOV AH,0
        INT 16H   ; Wait for user click
        
        

        ;----------> TO DRAW NAME SCREEN  
        CALL NAMESCREEN 
        MOV NOSEND,1
              
        ;---------> END OF DRAWING NAME SCREEN 

        ;------------------------------------------------------------------------------------
        ;--------------------------------GAME MENU-------------------------------------------       
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------          
START:  
	    XOR AX,AX
	    XOR BX,BX
	    XOR CX,CX
	    XOR DX,DX 
	    MOV SI,0
        CALL CLEARRECIEVE
        MOV NOSEND,1
        MOV ALERT_X,0
        MOV ALERT_Y,24 
        MOV CHATFLAG,0
        MOV GAMEFLAG,0                
        MOV BL,0    ;ARROW POSITION  
        MOV VALUE,0
        MOV AH,0
        MOV AL,12H
        INT 10H ;Clear Screen
        
MAINMENULOOP:

        CALL DRAW_MAINMENU_SCREEN  
      
RECIEVELOOP:        
        CALL RECIEVE
        MOV  AL,VALUE
NONRECIEVELOOP:
        MOV ALERT_X,0       
        CMP VALUE,0  ;NO INVITATIONS
        JZ HALFNOINVITE 


        CMP VALUE,1 
        JNZ NOTNEWGAME   
        
        CALL CLEARRECIEVE
        MOV NOSEND,1   
        
        LEA SI,P2NAME
        CALL PRINTALERT
        MOV CX,0 
        MOV SI,0
CALCLENNAME1:
        INC CX
        INC SI
        CMP P2NAME+[SI],BYTE PTR '$'
        JNZ CALCLENNAME1
        ADD CX,2
        MOV ALERT_X,CL
        ;DEC ALERT_Y        
        
        LEA SI,GAMEREQUESTMSG
        CALL PRINTALERT
        MOV VALUE,0 
        MOV GAMEFLAG,1 

        JMP HALFNOINVITE         
        ;---------------------------------------  
        HALFNRECIEVELOOP: JMP RECIEVELOOP
        HALFMAINMENULOOP: JMP MAINMENULOOP
        HALFNOINVITE:     JMP NOINVITE
        ;Half jumps
        ;---------------------------------------         
        
NOTNEWGAME:        
        CMP VALUE,2  ;CHAT INVITATIONS
        JNZ NOTCHAT
        
        CALL CLEARRECIEVE
        MOV NOSEND,1
        
                                      
        LEA SI,P2NAME
        CALL PRINTALERT
        MOV CX,0 
        MOV SI,0
CALCLENNAME:
        INC CX
        INC SI
        CMP P2NAME+[SI],BYTE PTR '$'
        JNZ CALCLENNAME
        ADD CX,2
        MOV ALERT_X,CL
        ;DEC ALERT_Y        
        
        LEA SI,CHATREQUESTMSG
        CALL PRINTALERT
        MOV VALUE,0 
        MOV CHATFLAG,1
        JMP NOINVITE 


NOTCHAT:
        JMP EXITMODE
        
NOINVITE:        
        
        MOV AH,1 ;WAIT FOR CLICK
        INT 16H
        
        CMP AH,1
        JZ  HALFNRECIEVELOOP
        
        
        PUSH AX
        MOV AH,0 ;CLEAR BUFFER
        INT 16H 
        POP  AX
        
        CMP AL,13 ;PRESSED ENTER
        JZ  ENDMAINMENULOOP
        
        CMP AH,72 ;PRESSED UP
        JNZ NOUPPRESSED
        
        CMP BL,0
        JZ  ROTATEDOWNARROW
            
        DEC BL ;ARROW UP
        JMP MAINMENULOOP    
            
        ROTATEDOWNARROW:
        ADD BL,2 ;ROTATE
        JMP MAINMENULOOP        
        ;---------------------------------------
        HALFSTART: JMP START  
        HALFNONRECIEVELOOP: JMP NONRECIEVELOOP
        ;Half jumps
        ;---------------------------------------         
NOUPPRESSED:
        CMP AH,80 ;PRESSED DOWN
        JNZ HALFMAINMENULOOP ;NOT UP OR DOWN OR ENTER
        
        CMP BL,2
        JZ  ROTATEUPARROW
        
        INC BL ;ARROW DOWN
        JMP HALFMAINMENULOOP
        
        ROTATEUPARROW:
        SUB BL,2  ;ROTATE
        JMP HALFMAINMENULOOP
        
ENDMAINMENULOOP:
        CMP BL,0   
        JZ  GAMEMODE
        
        CMP BL,1
        JZ  HALF2CHATMODE
        
        CMP BL,2
        JZ  HALF2EXITMODE 
        
        
        ;------------------------------------------------------------------------------------
        ;--------------------------------GAME MODE-------------------------------------------       
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------           
GAMEMODE:
        CALL CLEARRECIEVE
        MOV NOSEND,1
        MOV PLAYERFLAG,2 
        PUSH AX  
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI        
                
         
         MOV VALUE,1
         CALL SEND
         MOV VALUE,0  
        
         CMP GAMEFLAG,0
         JNZ  STARTGAME
         LEA  SI,WAITINGMSG 
         CALL PRINTALERT 
         CALL WAITFORPLAYER2         
         CMP VALUE,1
         JNZ HALFNONRECIEVELOOP 
         MOV PLAYERFLAG,1
         STARTGAME: 
         JMP DONTHALFJMP
         ;--------------------------------------- 
          HALF2EXITMODE: JMP HALFEXITMODE 
          HALF2CHATMODE: JMP HALFCHATMODE
        ;Half jumps
         ;---------------------------------------              
         DONTHALFJMP:
        ;------------> Drawing Select cars screens
  
        ;Player 1 
        
        CMP  PLAYERFLAG,2
        JZ   RECIEVELEVEL                    
        CALL SELECT_LEVEL_LOOP
        
        CALL CLEARRECIEVE
        MOV NOSEND,1
        
        MOV  AL,LEVELCHOICE
        MOV  VALUE,AL
        CALL SEND 
                
        ;CMP PLAYERFLAG,2
        ;JZ  DELAYEDWAIT 
        
        MOV  NOSEND,1
        JMP  SKIPLEVEL
RECIEVELEVEL: 
        
        LEA SI,WAITINGLEVELMSG
        CALL PRINTALERT

        CALL WAITFORPLAYER2 
        MOV  AL,VALUE
        MOV  LEVELCHOICE,AL
        
        CALL SELECT_LEVEL_LOOP                        
        SKIPLEVEL:        
  
        
        CALL SELECTCAR
        MOV AL,CARCOLOR
        MOV CARCOLOR1,AL
        
        MOV VALUE,AL
        CALL SEND    
        
        XOR AX,AX
        XOR BX,BX
        XOR CX,CX
        XOR DX,DX 
        MOV SI,0  

        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,00H     ;CURSOR X
        MOV DH,13H     ;CURSOR Y
        INT 10H
        
        ;PRINTING Enter your name
        MOV AH,9
        MOV DX,OFFSET WAITINGMSG
        INT 21H
        
        ;CMP PLAYERFLAG,2
        ;JZ  DELAYEDWAIT
        CALL WAITFORPLAYER2
        ;MOV NOSEND,1 
        JMP COLORSDONE 
         ;--------------------------------------- 
        HALF2NONRECIEVELOOP: JMP HALFNONRECIEVELOOP        
        HALFCHATMODE: JMP CHATMODE
        HALFEXITMODE: JMP EXITMODE   
        ;Half jumps
         ;---------------------------------------
;DELAYEDWAIT:
        ;CALL DELAYFORPLAYER2 
        
COLORSDONE:               
        MOV AL,VALUE
        MOV CARCOLOR2,AL
         
         
                 
        ;------------> End of selecting cars screen
		CALL LOADING ;SHOW LOADING SCREEN
        
        
        CALL main2 ;Game Start  
        
        ;EXISTING MAIN2 MEANS ONE OF THE PLAYES HAS LOST
        ;PRINT THE GAMEOVER SCREEN 
        CALL GAMEOVERSCREEN
        MOV GAMEFLAG,0  
        

        POP  SI
        POP DX
        POP CX
        POP BX
        POP AX        
         
        CALL CLEARRECIEVE
        MOV NOSEND,1  
        MOV BL,0  
        JMP HALFSTART
      
        
        ;------------------------------------------------------------------------------------
        ;--------------------------------CHAT MODE-------------------------------------------       
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------ 
CHATMODE: 

         CALL CLEARRECIEVE
         MOV NOSEND,1 
         MOV VALUE,2
         CALL SEND    
         MOV VALUE,0 
         
         CMP CHATFLAG,0
         JNZ  STARTCHAT
         LEA  SI,WAITINGMSG 
         CALL PRINTALERT 
         CALL WAITFORPLAYER2
         
         CMP VALUE,2
         JNZ HALF2NONRECIEVELOOP 
         
         STARTCHAT: 
         MOV STRING_X2,0FFH 
         PUSH AX  
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        PUSH DI 
        CALL CHATSCREEN
        POP  DI
        POP  SI
        POP DX
        POP CX
        POP BX
        POP AX          
         
        MOV VALUE,0
        MOV PLAYERFLAG,2
        MOV CHATFLAG,0
        MOV GAMEFLAG,0  
         
        CALL CLEARRECIEVE
        MOV NOSEND,1         
         
        JMP HALFSTART
        ;------------------------------------------------------------------------------------
        ;--------------------------------EXIT MODE-------------------------------------------       
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------                 
EXITMODE:
             
        MOV VALUE,3
        CALL SEND
        MOV VALUE,0        
       ;---------------------------------------
        
        MOV AX,4C00H ;EXTINING
		INT 21H
		
		
MAIN    ENDP

;------------------------------------------------------------------------------------   
;------------------------------USED PROCEDURES---------------------------------------      
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

DRAW_R_RECT   PROC
    ; Draw any Recangle given intial (x,y) , Length , Width , Color
    ; IN : CX: intial X , DX: Initial Y , AL:COLOR , BX:WIDTH , DI:HIGHT
    ; OUT : None     

        MOV AH,0CH
        ADD BX,CX
        ADD DI,DX
        
OUTLOOP1:
  
        PUSH CX

INLOOP1:

        INT 10H ;DRAW
        
        INC CX 

        CMP CX,BX ;MAX WIDTH
        
        JNZ INLOOP1 
        
        INC DX
                
        POP CX
        
        DEC CX
        DEC BX

        CMP DX,DI ;MAX HIGHT
        JNZ OUTLOOP1        
        
    RET
DRAW_R_RECT   ENDP

;------------------------------------------------------------------------------------         
;------------------------------------------------------------------------------------

DRAW_L_RECT   PROC
    ; Draw any Recangle given intial (x,y) , Length , Width , Color
    ; IN : CX: intial X , DX: Initial Y , AL:COLOR , BX:WIDTH , DI:HIGHT
    ; OUT : None     

        MOV AH,0CH
        ADD BX,CX
        ADD DI,DX
        
OUTLOOP2:

        PUSH CX

INLOOP2:

        INT 10H ;DRAW
        
        INC CX 

        CMP CX,BX ;MAX WIDTH
        
        JNZ INLOOP2 

        INC DX
     
        POP CX
        
        INC CX
        INC BX

        CMP DX,DI ;MAX HIGHT
        JNZ OUTLOOP2     

    RET
DRAW_L_RECT   ENDP

     
 
;------------------------------------------------------------------------------------  
;------------------------------------------------------------------------------------       

DRAW_MAINMENU_SCREEN   PROC
    ;Printing the main menu of the game
    ;IN: BL:Selected button
    ;OUT:   None
        
        ;CLEARING-------------------------
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,22H     ;CURSOR X
        MOV DH,0AH     ;CURSOR Y
        INT 10H
        ;PRINTING ARROW
        MOV AH,2
        MOV DL,20H
        INT 21H    
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,24H     ;CURSOR X
        MOV DH,0DH     ;CURSOR Y
        INT 10H
        ;PRINTING ARROW
        MOV AH,2
        MOV DL,20H
        INT 21H
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,24H     ;CURSOR X
        MOV DH,10H     ;CURSOR Y
        INT 10H
        ;PRINTING ARROW
        MOV AH,2
        MOV DL,20H
        INT 21H
        ;----------------------------------
        ;NOTIFICATIONS SECTION
        
        MOV AH,2
        MOV DL,00H     ;CURSOR X
        MOV DH,17H     ;CURSOR Y
        INT 10H
        ;PRINTING ----
        MOV AH,9
        MOV DX,OFFSET DASHMSG
        INT 21H
        
              
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,23H     ;CURSOR X
        MOV DH,0AH     ;CURSOR Y
        INT 10H
        ;PRINTING NEW GAME
        MOV AH,9
        MOV DX,OFFSET NEWGAMEMSG
        INT 21H
         
                               
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,25H     ;CURSOR X
        MOV DH,0DH     ;CURSOR Y
        INT 10H
        ;PRINTING CHAT
        MOV AH,9
        MOV DX,OFFSET CHATMSG
        INT 21H
         
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,25H     ;CURSOR X
        MOV DH,10H     ;CURSOR Y
        INT 10H
        ;PRINTING CHAT
        MOV AH,9
        MOV DX,OFFSET EXITMSG
        INT 21H
        
               
       
        ;DRAWING ARROW
STRATGAME:
        CMP BL,00H
        JNZ STARTCHATTING
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,22H     ;CURSOR X
        MOV DH,0AH     ;CURSOR Y
        INT 10H
        ;PRINTING ARROW
        MOV AH,2
        MOV DL,10H
        INT 21H
        
        RET
        
STARTCHATTING:
        CMP BL,01H
        JNZ EXITTHEGAME
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,24H     ;CURSOR X
        MOV DH,0DH     ;CURSOR Y
        INT 10H
        ;PRINTING ARROW
        MOV AH,2
        MOV DL,10H
        INT 21H
        
        RET
EXITTHEGAME:        
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,24H     ;CURSOR X
        MOV DH,10H     ;CURSOR Y
        INT 10H
        ;PRINTING ARROW
        MOV AH,2
        MOV DL,10H
        INT 21H   
        
        RET
                                                                                          
DRAW_MAINMENU_SCREEN   ENDP                                                                                    
;------------------------------------------------------------------------------------        
;------------------------------------------------------------------------------------ 

DRAW_SELECTCAR_SCREEN  PROC
    ;Drawing a car at certain location
    ;IN: DH: SELECTED COLUMN DL: SELECTED ROW 
    ;OUT: None
        
        MOV TEMP,DX
        
        XOR AX,AX
        XOR BX,BX
        XOR CX,CX
        XOR DX,DX 
        MOV SI,0        
        
            
        MOV AH,0
        MOV AL,13H
        INT 10H ;Clear Screen 
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,0DH     ;CURSOR X
        MOV DH,02H     ;CURSOR Y
        INT 10H
        ;PRINTING COLORS
        MOV AH,9
        MOV DX,OFFSET PICKCOLORMSG
        INT 21H
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,01H     ;CURSOR X
        MOV DH,09H     ;CURSOR Y
        INT 10H
        ;PRINTING COLORS
        MOV AH,9
        MOV DX,OFFSET COLORSMSG
        INT 21H
         
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,1CH     ;CURSOR X
        MOV DH,06H     ;CURSOR Y
        INT 10H
        ;PRINTING COLORS
        MOV AH,9
        MOV DX,OFFSET DISPLAYMSG
        INT 21H         
        
        ;----------------------------> Available colors (X,Y) --> (X,Y+22)  OR  (x+30,Y) 
        
        ;BACKGROUNG STROKE
        MOV CX,10 ; SET INITIAL X  Xo   
        MOV DX,80 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,190  ;SET BX TO MAXWIDTH
        MOV DI,49  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
                                  

        ;BACKGROUND
        MOV CX,12 ; SET INITIAL X  Xo   
        MOV DX,82 ; SET INITIAL Y  Yo
        MOV AL,08H ;SET COLOR
        MOV BX,188  ;SET BX TO MAXWIDTH
        MOV DI,47  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        

        ;------> Selecting
        
        MOV DX,TEMP
        
        MOV CX,24   ;A COUNTER TO GET THE LOCATION OF SELECTED COLOR IN CX(X)&BX(Y)
        MOV BX,85
        
        CMP DL,00H
        JNZ COLORROW1
        
        CMP DH,00H
        JNZ R0C1
        
        ;BLACK
        MOV AL,11H ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R0C1:        
        ADD CX,30
        CMP DH,01H
        JNZ R0C2
        
        ;BLUE
        MOV AL,01H ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R0C2:
        ADD CX,30
        CMP DH,02H
        JNZ R0C3
        
        ;GREEN
        MOV AL,02H ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R0C3:
        ADD CX,30
        CMP DH,03H
        JNZ R0C4
        
        ;CYAN
        MOV AL,03H ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R0C4:
        ADD CX,30
        CMP DH,04H
        JNZ R0C5
        
        ;MAGNETA
        MOV AL,05H ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R0C5:   
        ADD CX,30
        ;BROWN
        MOV AL,06H ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT

COLORROW1:
        ADD BX,22 ;SECOND ROW

        CMP DH,00H
        JNZ R1C1
        
        ;WHITE
        MOV AL,0FH ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R1C1:        
        ADD CX,30
        CMP DH,01H
        JNZ R1C2
        
        ;LIGHTBLUE
        MOV AL,09H ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R1C2:
        ADD CX,30
        CMP DH,02H
        JNZ R1C3
        
        ;LIGHTGREEN
        MOV AL,0AH ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R1C3:
        ADD CX,30
        CMP DH,03H
        JNZ R1C4
        
        ;LIGHTCYAN
        MOV AL,0BH ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R1C4:
        ADD CX,30
        CMP DH,04H
        JNZ R1C5
        
        ;LIGHTMAGNETA
        MOV AL,0DH ;SET COLOR
        MOV CARCOLOR,AL
        JMP ENDSELECT
R1C5:    
        ADD CX,30
        ;YELLOW
        MOV AL,0EH ;SET COLOR
        MOV CARCOLOR,AL


ENDSELECT:

                 
        ;Stroke
        MOV AL,42H
        MOV DX,BX  ;SET Y
        MOV BX,15  ;SET BX TO MAXWIDTH
        MOV DI,15  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        ;------> COLORS
        
        ;BLACK
        MOV CX,25 ; SET INITIAL X  Xo   
        MOV DX,86 ; SET INITIAL Y  Yo
        MOV AL,11H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT


        ;BLUE
        MOV CX,55 ; SET INITIAL X  Xo   
        MOV DX,86 ; SET INITIAL Y  Yo
        MOV AL,01H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
        ;GREEN
        MOV CX,85 ; SET INITIAL X  Xo   
        MOV DX,86 ; SET INITIAL Y  Yo
        MOV AL,02H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT


        ;CYAN
        MOV CX,115 ; SET INITIAL X  Xo   
        MOV DX,86 ; SET INITIAL Y  Yo
        MOV AL,03H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT


        ;MAGNETA
        MOV CX,145 ; SET INITIAL X  Xo   
        MOV DX,86 ; SET INITIAL Y  Yo
        MOV AL,05H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT



        ;BROWN
        MOV CX,175 ; SET INITIAL X  Xo   
        MOV DX,86 ; SET INITIAL Y  Yo
        MOV AL,06H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        

        ;-------------------
        
        ;WHITE
        MOV CX,25 ; SET INITIAL X  Xo   
        MOV DX,108 ; SET INITIAL Y  Yo
        MOV AL,0FH ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT


        ;LIGHT BLUE
        MOV CX,55 ; SET INITIAL X  Xo   
        MOV DX,108 ; SET INITIAL Y  Yo
        MOV AL,09H ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT

        ;LIGHT GREEN
        MOV CX,85 ; SET INITIAL X  Xo   
        MOV DX,108 ; SET INITIAL Y  Yo
        MOV AL,0AH ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT


        ;LIGHT CYAN
        MOV CX,115 ; SET INITIAL X  Xo   
        MOV DX,108 ; SET INITIAL Y  Yo
        MOV AL,0BH ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT


        ;LIGHT MAGNETA
        MOV CX,145 ; SET INITIAL X  Xo   
        MOV DX,108 ; SET INITIAL Y  Yo
        MOV AL,0DH ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT



        ;YELLOW
        MOV CX,175 ; SET INITIAL X  Xo   
        MOV DX,108 ; SET INITIAL Y  Yo
        MOV AL,0EH ;SET COLOR
        MOV BX,13  ;SET BX TO MAXWIDTH
        MOV DI,13  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
		

        ;------> DISPLAYING CAR
        

        ;BACKGROUNG STROKE
        MOV CX,223 ; SET INITIAL X  Xo   
        MOV DX,58 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,77 ;SET BX TO MAXWIDTH
        MOV DI,92  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT

        ;BACKGROUNG 
        MOV CX,225 ; SET INITIAL X  Xo   
        MOV DX,60 ; SET INITIAL Y  Yo
        MOV AL,08H ;SET COLOR
        MOV BX,75 ;SET BX TO MAXWIDTH
        MOV DI,90  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
                   
        ;BACKGROUNG 
        MOV CX,258 ; SET INITIAL X  Xo   
        MOV DX,60 ; SET INITIAL Y  Yo
        MOV AL,0FH ;SET COLOR
        MOV BX,10 ;SET BX TO MAXWIDTH
        MOV DI,30  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
                
        MOV CX,258 ; SET INITIAL X  Xo   
        MOV DX,95 ; SET INITIAL Y  Yo
        MOV AL,0FH ;SET COLOR
        MOV BX,10 ;SET BX TO MAXWIDTH
        MOV DI,30  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
        MOV CX,258 ; SET INITIAL X  Xo   
        MOV DX,130 ; SET INITIAL Y  Yo
        MOV AL,0FH ;SET COLOR
        MOV BX,10 ;SET BX TO MAXWIDTH
        MOV DI,20  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        
        CALL DRAWCAR               

        
        MOV DX,TEMP
                
        RET 
        
DRAW_SELECTCAR_SCREEN  ENDP
;------------------------------------------------------------------------------------         
;------------------------------------------------------------------------------------

SELECTCAR   PROC
    
        MOV DX,0001H ;DEFAULT COLOR SELECTIONS
SELECTCARLOOP:              

        CALL DRAW_SELECTCAR_SCREEN
        
        MOV AH,0 ;WAIT FOR CLICK
        INT 16H
        
        CMP AL,13 ;PRESSED ENTER
        JZ  ENDSELECTCARLOOP1
        
        CMP AH,72 ;PRESSED UP
        JNZ NOTUPKEY
        
        CMP DL,0
        JZ  ROTATEDOWNARROW1
            
        DEC DL ;ARROW UP
        JMP SELECTCARLOOP    
            
        ROTATEDOWNARROW1:
        INC DL ;ROTATE
        JMP SELECTCARLOOP        
         
NOTUPKEY:
        CMP AH,80 ;PRESSED DOWN
        JNZ NOTDOWNKEY ;NOT UP OR DOW 
        
        CMP DL,1
        JZ  ROTATEUPARROW1
        
        INC DL ;ARROW DOWN
        JMP SELECTCARLOOP
        
        ROTATEUPARROW1:
        DEC DL  ;ROTATE
        JMP SELECTCARLOOP
        
NOTDOWNKEY:        
        CMP AH,77 ;PRESSED RIGHT
        JNZ NOTRIGHTKEY ;NOT UP OR DOWN OR RIGHT 
        
        CMP DH,5
        JZ  ROTATERIGHTARROW1
        
        INC DH ;ARROW RIGHT
        JMP SELECTCARLOOP
        
        ROTATERIGHTARROW1:
        MOV DH,0  ;ROTATE
        JMP SELECTCARLOOP

NOTRIGHTKEY:
        CMP AH,75 ;PRESSED RIGHT
        JNZ SELECTCARLOOP ;NOT UP OR DOWN OR RIGHT OR LEFT OR ENTER 
        
        CMP DH,0
        JZ  ROTATELEFTARROW1
        
        DEC DH ;ARROW LEFT
        JMP SELECTCARLOOP
        
        ROTATELEFTARROW1:
        MOV DH,5  ;ROTATE
        JMP SELECTCARLOOP 
ENDSELECTCARLOOP1:                      
       RET         
SELECTCAR   ENDP
     

DRAWLINE PROC
    
		BACK: INT 10H
		INC CX
		CMP CX,BX
		JNZ BACK
      
    RET
DRAWLINE ENDP 
	
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------   
            
DRAWLINE2 PROC
    
		BACK1: INT 10H
		INC DX
		CMP DX,BX
		JNZ BACK1
      
    RET
DRAWLINE2 ENDP  

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

SQROOT PROC    
;CALC SQUARE ROOT
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
;------------------------------------------------------------------------------------

DRAWSPIDERBODY PROC near       ;------>DRAW HALF AND FULL CIRCLE   
	
	XOR AX,AX    ;CLEAR REG.S
	XOR BX,BX
	XOR CX,CX
	XOR DX,DX
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
	  ; INC [SI]+CARSTARTX
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

GAMEOVERSCREEN PROC 

    ;VIDEO MODE
        MOV AH,0
        MOV AL,13h
        INT 10H 
        
    ;STYLYING
        MOV CX,0 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,14H ;SET COLOR
        MOV BX,70  ;SET BX TO MAXWIDTH
        MOV DI,200  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
    ;STYLYING
        MOV CX,0 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,14H ;SET COLOR
        MOV BX,320  ;SET BX TO MAXWIDTH
        MOV DI,50  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
    ;ADDING INNER SHADOW
        MOV CX,70 ; SET INITIAL X  Xo   
        MOV DX,50 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,150  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
    ;ADDING INNER SHADOW
        MOV CX,70 ; SET INITIAL X  Xo   
        MOV DX,50 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,250  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT           
 
    
    ;MOVING CURSOR 
        MOV CX,0
        MOV AL,0
        MOV BX,0
        MOV AH,2
        MOV DL,0FH     ;CURSOR X
        MOV DH,0CH     ;CURSOR Y
        INT 10H
        
    ;PRINTING GAMEOVER
        MOV AH,9
        MOV DX,OFFSET GAMEOVERMESSAGE 
        INT 21H 
        
        
    ;UNDERLINING
        MOV CX,110 ; SET INITIAL X  Xo   
        MOV DX,113 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,90  ;SET BX TO MAXWIDTH
        MOV DI,3  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  
        
   ;OVERLINING
        MOV CX,110 ; SET INITIAL X  Xo   
        MOV DX,83 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,90  ;SET BX TO MAXWIDTH
        MOV DI,3  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
   ;SIDELINING LEFT
        MOV CX,110 ; SET INITIAL X  Xo   
        MOV DX,83 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,3  ;SET BX TO MAXWIDTH
        MOV DI,33  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  
        
   ;SIDELINING RIGHT
        MOV CX,200 ; SET INITIAL X  Xo   
        MOV DX,83 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,3  ;SET BX TO MAXWIDTH
        MOV DI,33  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT             
        
        
      
     
     MOV SI,0
     MOV [SI]+SPIDERCENTER,20 
     MOV [SI]+SPIDERCENTER+2,20
     
     CALL DRAWSPIDER
     
     MOV [SI]+SPIDERCENTER,40 
     MOV [SI]+SPIDERCENTER+2,40
     
     CALL DRAWSPIDER  
     
     MOV [SI]+SPIDERCENTER,20 
     MOV [SI]+SPIDERCENTER+2,60
     
     CALL DRAWSPIDER
     
     
     ;INVADED BACKGROUND
        MOV CX,25 ; SET INITIAL X  Xo   
        MOV DX,80 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,50  ;SET BX TO MAXWIDTH
        MOV DI,120  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  
        
     ;ADDING HORIZONTAL SHADOW
        MOV CX,25 ; SET INITIAL X  Xo   
        MOV DX,80 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,50  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
     ;ADDING VERTICAL SHADOW
        MOV CX,25 ; SET INITIAL X  Xo   
        MOV DX,80 ; SET INITIAL Y  Yo
        MOV AL,13H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,120  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        
     ;ADDING TWO LINES
        
        MOV CX,285 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,69H ;SET COLOR
        MOV BX,4  ;SET BX TO MAXWIDTH
        MOV DI,50  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
        
        MOV CX,293 ; SET INITIAL X  Xo   
        MOV DX,0 ; SET INITIAL Y  Yo
        MOV AL,70H ;SET COLOR
        MOV BX,4  ;SET BX TO MAXWIDTH
        MOV DI,50  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        
     ;MOVING CURSOR
        MOV CX,0
        MOV AL,0
        MOV BX,0
        MOV AH,2
        MOV DL,09H     ;CURSOR X
        MOV DH,12H     ;CURSOR Y
        INT 10H  
         
    ;ANNOUNCING THE WINNER 
    
    CMP P1WINS,1
    JNZ PLAYER2WINS
        MOV AH,9
        MOV DX,OFFSET P1NAME 
        INT 21H 
        
        MOV AH,9
        MOV DX,OFFSET WINNERMESSAGE 
        INT 21H  
        
        
          MOV SI,0
          MOV BL,CARCOLOR1
     MOV CARCOLOR,BL
     MOV [SI]+CARCENTER,263
     MOV [SI]+CARCENTER+2,106
     CALL DRAWCAR 
        
    JMP PLAYER1WINS
            
    PLAYER2WINS:
    
        MOV AH,9
        MOV DX,OFFSET P2NAME 
        INT 21H 
        
        MOV AH,9
        MOV DX,OFFSET WINNERMESSAGE 
        INT 21H  
        
          MOV SI,0
         MOV BL,CARCOLOR2
     MOV CARCOLOR,BL
     MOV [SI]+CARCENTER,263
     MOV [SI]+CARCENTER+2,106
     CALL DRAWCAR 
    
    PLAYER1WINS:
    
            
    ;UNDERLINING THE WINNER
        MOV CX,70 ; SET INITIAL X  Xo   
        MOV DX,160 ; SET INITIAL Y  Yo
        MOV AL,69H ;SET COLOR
        MOV BX,250  ;SET BX TO MAXWIDTH
        MOV DI,3  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
    ;MOVING CURSOR
        MOV CX,0
        MOV AL,0
        MOV BX,0
        MOV AH,2
        MOV DL,09H     ;CURSOR X
        MOV DH,16H     ;CURSOR Y
        INT 10H
             
        
    ;PRINTING REMATCH 
    
        MOV AH,9
        MOV DX,OFFSET REMATCHMESSAGE 
        INT 21H 
        
            
    
     
     ;MOVING CURSOR
        MOV CX,0
        MOV AL,0
        MOV BX,0
        MOV AH,2
        MOV DL,05H     ;CURSOR X
        MOV DH,0CH     ;CURSOR Y
        INT 10H 
        
        
     MOV CX,7
     MOV DI, OFFSET INVADEDMESSAGE 
     
     PRINTINVADED:   
     
     PUSH CX
     
     ;PRINT A RED CHARACTER  
		MOV AH,9
		MOV BH,0
		MOV AL,[DI]
		MOV CX,1
		MOV BL,70H
		INT 10H

		 MOV AH,2
		 ADD DH,2 
		 INT 10H 
		 
		 INC DI
		 
		 POP CX
		 LOOP PRINTINVADED 
     
       
       
     GOVERAGAIN:
        
        ;CHECK IF ENTER IS PRESSED
        MOV AH,00h
        INT 16H
                
        ;CHECKING THE PRESSED KEY
        CMP AL,13
        JNZ GOVERAGAIN
        
        
        ;-----------------------------
        MOV NOSEND,1
        CALL CLEARRECIEVE
        MOV NOSEND,1
        MOV VALUE,1
        CALL SEND  
        
        XOR AX,AX
	    XOR BX,BX
	    XOR CX,CX
	    XOR DX,DX 
	    MOV SI,0
	    
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,07H     ;CURSOR X
        MOV DH,16H     ;CURSOR Y
        INT 10H
        ;PRINTING Enter your name
        MOV AH,9
        MOV DX,OFFSET WAITINGMSG2
        INT 21H
        
        ;CMP PLAYERFLAG,2
        ;JZ  DELAYEDWAIT
        CALL WAITFORPLAYER2  

RET    
GAMEOVERSCREEN ENDP     
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
CHATSCREEN    PROC
        
        
        MOV AH,0
        MOV AL,13H
        INT 10H ;Clear Screen
        

        ;CLEARING
        MOV AX,0
        MOV BX,0
        MOV CX,0
        MOV DX,0
        MOV SI,0
        MOV DI,0
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,00H     ;CURSOR X
        MOV DH,0BH     ;CURSOR Y
        INT 10H        
         
        MOV AH,9       ;SPLITING CHAT SCREEN
        MOV DX,OFFSET CHATDASHMSG
        INT 21H
         
        ;DRAWING NAMES
        MOV AH,2
        MOV DL,00H     ;CURSOR X
        MOV DH,00H     ;CURSOR Y
        INT 10H        
         
        MOV AH,9       ;SPLITING CHAT SCREEN
        MOV DX,OFFSET P1NAME
        INT 21H
        
        MOV AH,2
        MOV DL,00H     ;CURSOR X
        MOV DH,0CH     ;CURSOR Y
        INT 10H        
         
        MOV AH,9       ;SPLITING CHAT SCREEN
        MOV DX,OFFSET P2NAME
        INT 21H         

        
        MOV CX,0
        MOV SI,0           
           
        CALL CLEARRECIEVE 
        MOV STRING_X,0
        MOV STRING_Y,01H
        MOV STRING_X2,0
        MOV STRING_Y2,0DH
                   
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
        MOV LASTLINE,0
        MOV LASTLINE2,0        

                   
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
        CMP STRING_Y,0AH
        JNZ NOTMAXLINE2
        RESETY1:
        MOV AH,6
        MOV AL,1
        MOV BH,0
        MOV CH,1
        MOV CL,0
        MOV DH,10
        MOV DL,40
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
        MOV STRING_X2,0

        INC SI   ;END OF LINE
        
        CMP STRING_Y2,22
        JNZ NOTMAXLINE4
        
        ;MOV STRING_Y2,0AH
        MOV AH,6
        MOV AL,1
        MOV BH,0
        MOV CH,0DH
        MOV CL,0
        MOV DH,22
        MOV DL,40
        INT 10H
        MOV STRING_X2,0
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
        
        CMP STRING_Y,1
        JZ  DONTPREVLINE
        DEC STRING_Y
        MOV STRING_X,39 
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
        
        CMP STRING_X2,0
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
        CMP STRING_X,40 ; NEXT LINE
        JNZ NEXTCHAR
        
        MOV STRING_X,0

        
        
        CMP STRING_Y,0AH
        JNZ NOTMAXLINE
        RESETY: 
        MOV AH,6
        MOV AL,1
        MOV BH,0
        MOV CH,1
        MOV CL,0
        MOV DH,10
        MOV DL,40
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
        
        
        
        MOV STRING_X2,0

        
        
        CMP STRING_Y2,22
        JNZ NOTMAXLINE3
        
        ;MOV STRING_Y2,0AH
        MOV AH,6
        MOV AL,1
        MOV BH,0
        MOV CH,0DH
        MOV CL,0
        MOV DH,22
        MOV DL,40
        INT 10H
        MOV STRING_X2,0
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
        ;CMP AH,0
        ;JNZ  TAKECHAR1
        
        ;CMP AH,58
        ;JNG  NOTFN1
        
        ;CMP AH,70
        ;JL  TAKECHAR1     ;IS FN
        
        ;CMP AL,48
        ;JG  NOTFN1         ; IS NUMBER
                          
        ;CMP AH,70
        ;JGE TAKECHAR1      ;IS NOT NUM 
        
        MOV INPUTFLAG,2
    RET
CHECKINPUT ENDP 
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
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
  		JZ AGAIN

;If empty put the VALUE in Transmit data register
  		mov dx , 3F8H		; Transmit data register
  		mov  al,VALUE
  		out dx , al  
  		
  		MOV NOREC,0
AGAIN:      


    RET    
SEND    ENDP

RECIEVE  PROC
;Check that Data Ready
		mov dx , 3FDH		; Line Status Register
		in al , dx 
  		AND al , 1
  		JZ CHK

 ;If Ready read the VALUE in Receive data register
  		mov dx , 03F8H
  		in al , dx 
  		mov VALUE , al
  		
  		MOV NOSEND,0    
  		
     CHK:
     
    RET
RECIEVE  ENDP
;---------------------------------------------------------------
WAITFORPLAYER2  PROC 
    MOV VALUE,0    
WAITFORPLAYER2LOOP: 
        CALL RECIEVE
                
        CMP NOSEND,0
        JNZ WAITFORPLAYER2LOOP
        MOV NOSEND,1 
        
        RET  
WAITFORPLAYER2  ENDP
;---------------------------------------------------------------
DELAYFORPLAYER2  PROC 
    MOV VALUE,0    
    MOV CX,0
DELAYFORPLAYER2LOOP: 
        CALL RECIEVE
                
        CMP NOSEND,0
        JNZ DELAYFORPLAYER2LOOP
        INC CX
        CMP CX,2 
        MOV NOSEND,1
        JL  DELAYFORPLAYER2LOOP ; DELAY
        MOV NOSEND,1 
        
        RET 
DELAYFORPLAYER2  ENDP    
;---------------------------------------------------------------
PRINTALERT      PROC 
    ;IN: SI: Offset of MESSAGE
    ;OUT: NONE
    
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,ALERT_X     ;CURSOR X
        MOV DH,ALERT_Y ;CURSOR Y
        INT 10H
        
        ;PRINTING Enter your name
        MOV AH,9
        MOV DX,SI
        INT 21H 
        
        CMP LASTLINE3,1
        JZ  SCROL3
        INC ALERT_Y
        SCROL3:
        CMP ALERT_Y,29
        JNZ NOFIRSTSCROL
        MOV AH,6
        MOV AL,1
        MOV BH,0
        MOV CH,24
        MOV CL,0
        MOV DH,29
        MOV DL,80
        INT 10H
        MOV LASTLINE3,1        
NOFIRSTSCROL:                       
        RET
PRINTALERT      ENDP 

;---------------------------------------------------------------
NAMESCREEN    PROC
           

        MOV AH,0
        MOV AL,13H
        INT 10H ;Clear Screen
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,07H     ;CURSOR X
        MOV DH,09H     ;CURSOR Y
        INT 10H
        
        ;PRINTING Enter your name
        MOV AH,9
        MOV DX,OFFSET ENTERYOURNAMEMSG
        INT 21H 
                               
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,07H     ;CURSOR X
        MOV DH,0FH     ;CURSOR Y
        INT 10H
        
        ;PRINTING Press enter to continue
        MOV AH,9
        MOV DX,OFFSET PRESSENTERMSG
        INT 21H

        
        ;CLEARING
        MOV AX,0
        MOV BX,0
        MOV CX,0
        MOV DX,0
        MOV SI,0
        MOV DI,0
        JMP NAMELOOP2
        
INVALIDCHAR:     
        
        JL  NOINVALID
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,07H     ;CURSOR X
        MOV DH,011H     ;CURSOR Y
        INT 10H
        
        ;PRINTING ERROR
        MOV AH,9
        MOV DX,OFFSET INVALIDCHARMSG1
        INT 21H         

        ;MOVING CURSOR
        MOV AH,2
        MOV DL,07H     ;CURSOR X
        MOV DH,012H     ;CURSOR Y
        INT 10H
        
        ;PRINTING ERROR2
        MOV AH,9
        MOV DX,OFFSET INVALIDCHARMSG2
        INT 21H                          
NOINVALID:           
        MOV INVALIDNAMEFLAG,0
NAMELOOP2: 
  
        CMP INVALIDNAMEFLAG,1
        JZ  INVALIDCHAR
     
        
        
        CMP EXITNAME,1   ;IF PRESSED ENTER
        JZ  HALFIWAITFORP2
                
        MOV AL,0
        MOV AH,01h
        INT 16H        ;TAKE INPUT 
        CMP AH,1
        JZ  TORECIEVE2
 
TOSEND2:        
        CALL CHECKINPUTNAME ; 0-> ENTER , 1->BACKSPACE , 2->NORMAL MSG , 3->ESC
        
        CMP  INPUTFLAG,2
        JZ   TONORMAL2 
        
        CMP  INPUTFLAG,1
        JZ   TOBACKSPACE2 
        
        CMP  INPUTFLAG,0
        JZ   TOENTER2
TONORMAL2:  
        CMP STOPINPUT,1  ;REACHED 15 CHARS
        JZ  SKIPNORMALMSG2
        CALL NORMALMSGNAME
        JMP  TOJMPTORECIEVE2
SKIPNORMALMSG2:
        MOV AH,0 ;CLEAR BUFFER
        INT 16H
TOJMPTORECIEVE2: 
        JMP  TORECIEVE2 
TOBACKSPACE2:
        CALL PRESSBACKSPACENAME
        JMP  TORECIEVE2
        
TOENTER2:
        CALL PRESSENTERNAME
        JMP  TORECIEVE2
;---------------------------------------
HALFIWAITFORP2: JMP WAITFORP2
;Half jumps
;---------------------------------------         
TORECIEVE2:  
        CMP EXITNAME2,1
        JZ  NAMELOOP2
        
        CALL RECIEVE

        CMP  NOSEND,1
        JZ   NAMELOOP2
        MOV  AL,VALUE
        
        CALL CHECKINPUTNAME
        
        CMP  INPUTFLAG,2
        JZ   RECIEVE_N2  
        
        CMP  INPUTFLAG,1
        JZ   RECIEVE_B2 
        
        CMP  INPUTFLAG,0
        JZ   RECIVE_E2
        
RECIEVE_N2:        
        CALL RECIEVENORMALNAME
        JMP NAMELOOP2 
RECIEVE_B2:
        CALL RECIEVEBACKSPACENAME        
        JMP NAMELOOP2
RECIVE_E2:
        CALL RECIEVEENTERNAME
        JMP NAMELOOP2

WAITFORP2:
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,07H     ;CURSOR X
        MOV DH,16H     ;CURSOR Y
        INT 10H
        
        ;PRINTING Enter your name
        MOV AH,9
        MOV DX,OFFSET WAITINGMSG
        INT 21H 
        
        MOV AL,EXITNAME
        AND AL,EXITNAME2
        JZ  TORECIEVE2
        
                   
        RET
NAMESCREEN    ENDP
 

;----------------------------------------------------------------
PRESSENTERNAME    PROC
        MOV AH,0 ;CLEAR BUFFER
        INT 16H 
        
        CMP STRINGNAME_X,07H     ;IF NO CHARS
        JNZ DOENTER2
        MOV INVALIDNAMEFLAG,1  
        RET
DOENTER2:  
        MOV VALUE,AL
        CALL SEND
              
        MOV EXITNAME,1  
              
                                         
                       
        RET        
PRESSENTERNAME    ENDP 
;----------------------------------------------------------------
RECIEVEENTERNAME    PROC
        
        CMP NOSEND,0
        JNZ NORECIEVE5
        
        MOV EXITNAME2,1
        CMP STRINGNAME_X,07H
        JNZ NORECIEVE5
        
        MOV FISRTCHARFLAG,1
NORECIEVE5:
        MOV NOSEND,1    
        RET        
RECIEVEENTERNAME    ENDP
;----------------------------------------------------------------
PRESSBACKSPACENAME     PROC
                
        MOV AH,0 ;CLEAR BUFFER
        INT 16H 
        
        CMP STRINGNAME_X,07H
        JNZ DOBACKSPACE2 
        
        
        RET
DOBACKSPACE2:
        MOV STOPINPUT,0        
        MOV VALUE,AL
        
       
              
        DEC STRINGNAME_X
        DEC SI 
        MOV [SI]+P1NAME,BYTE PTR '$'     
        CMP SI,0
        JNZ NOTBACKTOFIRST 
        MOV FISRTCHARFLAG,1
NOTBACKTOFIRST:
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,STRINGNAME_X    ;WHERE TO WRITE AT
        MOV DH,STRINGNAME_Y     ;CURSOR Y
        INT 10H
        
        MOV AH,2
        MOV DL,20H
        INT 21H    ;CLEARCHAR
        
        CALL SEND
        
                 
        RET        
PRESSBACKSPACENAME     ENDP 
;----------------------------------------------------------------
RECIEVEBACKSPACENAME     PROC
        
        CMP NOSEND,0
        JNZ NORECIEVE4 
        
        

        DEC STRING_X2
        DEC DI
        MOV [DI]+P2NAME,BYTE PTR '$'

NORECIEVE4:
        MOV NOSEND,1
        RET        
RECIEVEBACKSPACENAME     ENDP
;----------------------------------------------------------------
NORMALMSGNAME     PROC
        CMP AH,1
        JNZ  DONORMALMSG2       
        RET 
DONORMALMSG2:
        CMP INVALIDNAMEFLAG,1
        JZ  SKIPSENDMSG2
                
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,STRINGNAME_X    ;WHERE TO WRITE AT
        MOV DH,STRINGNAME_Y     ;CURSOR Y
        INT 10H

 
                
        MOV P1NAME+[SI],AL ;STORE 
        MOV VALUE,AL      
        MOV AH,2
        MOV DL,AL
        INT 21H    ;DISPLAY
        
        MOV AH,0 ;CLEAR BUFFER
        INT 16H
        ;SEND
        
        INC SI
        INC STRINGNAME_X
        CMP STRINGNAME_X,22 ; NEXT LINE
        JNZ SENDNORMALMSG2
        
        MOV STOPINPUT,1       
              
SENDNORMALMSG2:
        ;MOV VALUE,AL
        CALL SEND
        
SKIPSENDMSG2:
             
                
        RET
NORMALMSGNAME     ENDP
;------------------------------------------------------------------------------------
RECIEVENORMALNAME   PROC
    
        CMP NOSEND,0
        JNZ NORECIEVE3
  
        
        MOV P2NAME+[DI],AL ;STORE       
        ;MOV AH,2
        ;MOV DL,AL
        ;INT 21H    ;DISPLAY
        
        INC DI
        INC STRING_X2
        CMP STRING_X2,40 ; NEXT LINE
        JNZ NORECIEVE3
        

        
        
                
;-----------------------------------------                
NORECIEVE3:
        MOV NOSEND,1              
        
        
        RET
RECIEVENORMALNAME   ENDP    
;------------------------------------------------------------------------------------

CHECKINPUTNAME PROC
    
        ;CHECKING ON INPUT
        
        CMP AL,13
        JNZ NOTENTER2 ;PRESSED ENTER 
        MOV INPUTFLAG,0  
        RET
NOTENTER2:         
        CMP AL,8
        JNZ  NOTBACKSPACE2  ;PRESSED BACKSPACE
        MOV INPUTFLAG,1
        RET 
NOTBACKSPACE2:        
        CMP AL,27
        JNZ NOTESC2  
        MOV INPUTFLAG,3
        RET
NOTESC2:  

        CMP FISRTCHARFLAG,1
        JNZ NOTFIRST
        
        
        CMP AL,41H
        JL  INVALIDCHECK
        
        CMP AL,7AH
        JG  INVALIDCHECK

               
        CMP AL,5AH
        JG  CHECKLOWERCASE 
        MOV FISRTCHARFLAG,0
        JMP NOTFIRST
        CHECKLOWERCASE:
        
        CMP AL,61H
        JL  INVALIDCHECK
        MOV FISRTCHARFLAG,0      
        ;CMP AH,0
        ;JNZ  TAKECHAR1
        
        ;CMP AH,58
        ;JNG  NOTFN1
        
        ;CMP AH,70
        ;JL  TAKECHAR1     ;IS FN
        
        ;CMP AL,48
        ;JG  NOTFN1         ; IS NUMBER
                          
        ;CMP AH,70
        ;JGE TAKECHAR1      ;IS NOT NUM 
NOTFIRST:        
        MOV INPUTFLAG,2 
        

    RET
    
INVALIDCHECK:
    MOV INVALIDNAMEFLAG,1
    RET    
CHECKINPUTNAME ENDP  

;---------------------------------------------------------
MUSTSEND     PROC
    
MUSTSENDLOOP:
    
    CALL SEND
    
    CMP NOREC,1
    JNZ ISSEND
    CALL RECIEVE
    JMP  MUSTSENDLOOP    
    ISSEND:
    MOV NOREC,1
    RET

MUSTSEND     ENDP 
;----------------------------------------------------------
CLEARRECIEVE    PROC
    
    MOV CX,1000
CLEARRECIEVELOOP: 
    LOOP CLEARRECIEVELOOP    
    MOV NOSEND,1    
    RET
CLEARRECIEVE    ENDP  
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------ 



DRAW_SELECT_LEVEL   PROC
    ;Printing the SELECT LEVEL MENUE of the game
    ;IN: LEVELCHOICE:Selected button
    ;OUT:   None
        
    
        MOV AH,0
        MOV AL,12H
        INT 10H ;Clear Screen
        

        
        ;NOTIFICATIONS SECTION
        
        MOV BX,0
        MOV AH,2
        MOV DL,00H     ;CURSOR X
        MOV DH,17H     ;CURSOR Y
        INT 10H
        ;PRINTING ----
        MOV AH,9
        MOV DX,OFFSET DASHMSG
        INT 21H
        
              
        
        ;MOVING CURSOR
        MOV BX,0
        MOV AH,2
        MOV DL,23H     ;CURSOR X
        MOV DH,0AH     ;CURSOR Y
        INT 10H
        ;PRINTING NEW GAME
        MOV AH,9
        MOV DX,OFFSET LEVEL1MSG
        INT 21H
         
                               
        ;MOVING CURSOR
        MOV BX,0
        MOV AH,2
        MOV DL,23H     ;CURSOR X
        MOV DH,0DH     ;CURSOR Y
        INT 10H
        ;PRINTING CHAT
        MOV AH,9
        MOV DX,OFFSET LEVEL2MSG
        INT 21H
        
               
       
        ;DRAWING ARROW
LEVEL1:
        CMP LEVELCHOICE,00H
        JNZ LEVEL2
        
        ;MOVING CURSOR 
        MOV BX,0
        MOV AH,2
        MOV DL,22H     ;CURSOR X
        MOV DH,0AH     ;CURSOR Y
        INT 10H
        ;PRINTING ARROW
        MOV AH,2
        MOV DL,10H
        INT 21H
        
        RET
        
LEVEL2:
        
        ;MOVING CURSOR
        MOV BX,0
        MOV AH,2
        MOV DL,22H     ;CURSOR X
        MOV DH,0DH     ;CURSOR Y
        INT 10H
        ;PRINTING ARROW
        MOV AH,2
        MOV DL,10H
        INT 21H
        
        RET

                                                                                          
DRAW_SELECT_LEVEL   ENDP
;---------------------------------------------------------------
SELECT_LEVEL_LOOP PROC

        CMP PLAYERFLAG,2
        JZ  ENDSELECTLEVELLOOP
               
        MOV LEVELCHOICE,0    ;ARROW POSITION
SLECTLEVELLOOP:


        CALL DRAW_SELECT_LEVEL
        
        MOV AH,0 ;WAIT FOR CLICK
        INT 16H
        
        CMP AL,13 ;PRESSED ENTER
        JZ  ENDSELECTLEVELLOOP
        
        CMP AH,72 ;PRESSED UP
        JNZ NOTPRESSEDUPSELECT 
        
        CMP LEVELCHOICE,0
        JZ MAKEIT1
        MOV LEVELCHOICE,0
        JMP MAKEIT0
        MAKEIT1:
        MOV LEVELCHOICE,1
        MAKEIT0:

        NOTPRESSEDUPSELECT:
        
        CMP AH,80 ;PRESSED DOWN
        JNZ SLECTLEVELLOOP ;NOT UP OR DOWN OR ENTER
        
        CMP LEVELCHOICE,0
        JZ MAKEIT1a
        MOV LEVELCHOICE,0
        JMP MAKEIT0a
        MAKEIT1a:
        MOV LEVELCHOICE,1
        MAKEIT0a:
 
         
        
        JMP SLECTLEVELLOOP 
         
        
ENDSELECTLEVELLOOP: 


CMP LEVELCHOICE,0
JZ YOUAREINLEVEL1 
;ADJUSTMENT FOR LEVEL2

 MOV INLEVEL2,  1 
 MOV GAMESPEED, 4


JMP YOUAREINLEVEL2
YOUAREINLEVEL1: 
;ADJUSTMENT FOR LEVEL1 

 MOV INLEVEL2,  0 
 MOV GAMESPEED, 6


YOUAREINLEVEL2:

    
RET    
SELECT_LEVEL_LOOP ENDP 

;---------------------------------------------------------------
RANDLANE       PROC
        MOV SI,0
        MOV NOSEND,1
        MOV RANDMAX,9
RANDARRAYLOOP:  

        
        CMP PLAYERFLAG,2
        JZ NORANDSEND 
        
        CALL RANDGEN
        INC DL
        MOV [SI]+RANDLANES,DL
        INC SI  
        MOV VALUE,DL
        CALL SEND
        
        CALL WAITFORPLAYER2
        MOV  NOSEND,1
        JMP  NEXTRANDITERATION
        
        
        NORANDSEND:
        CALL RECIEVE
        CMP  NOSEND,1
        JZ   NEXTRANDITERATION
        MOV  DL,VALUE   
        MOV  [SI]+RANDLANES,DL
        INC  SI
        MOV  NOSEND,1
        
        CALL SEND        
NEXTRANDITERATION:
        
                
        CMP SI,99

        JNZ RANDARRAYLOOP        
        
        
        
        
        RET
RANDLANE       ENDP 
;---------------------------------------------------------------
RANDOMICON       PROC
        MOV SI,0
        MOV NOSEND,1
        MOV RANDMAX,20
RANDARRAYLOOP1:  

        
        CMP PLAYERFLAG,2
        JZ NORANDSEND1 
        
        CALL RANDGEN
        MOV [SI]+RANDICONS,DL
        INC SI  
        MOV VALUE,DL
        CALL SEND
        
        CALL WAITFORPLAYER2
        MOV  NOSEND,1
        JMP  NEXTRANDITERATION1
        
        
        NORANDSEND1:
        CALL RECIEVE
        CMP  NOSEND,1
        JZ   NEXTRANDITERATION1
        MOV  DL,VALUE   
        MOV  [SI]+RANDICONS,DL
        INC  SI
        MOV  NOSEND,1
        
        CALL SEND        
NEXTRANDITERATION1:
        
       
                
        CMP SI,99

        JNZ RANDARRAYLOOP1        
        
        
        
        
        RET
RANDOMICON       ENDP
;----------------------------------------------------------
;---------------------------------------------------------------
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
;----------------------------------------------------------------
END     MAIN