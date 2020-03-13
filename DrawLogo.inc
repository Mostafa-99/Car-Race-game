DRAWLOGO MACRO
    
        ;------------------------------------------------------------------------------------
        ;--------------------------------To Draw Border--------------------------------------       
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------

        ;Border
        MOV CX,20 ; SET INITIAL X     
        MOV DX,42 ; SET INITIAL Y 
        MOV AL,48H ;SET COLOR
        MOV BX,280  ;SET BX TO MAXWIDTH
        MOV DI,3  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y)
        
        MOV CX,20 ; SET INITIAL X     
        MOV DX,42 ; SET INITIAL Y 
        MOV BX,4  ;SET BX TO MAXWIDTH
        MOV DI,4  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT  ;(X,Y)            
                    
        MOV CX,297 ; SET INITIAL X     
        MOV DX,42 ; SET INITIAL Y 
        MOV BX,4  ;SET BX TO MAXWIDTH
        MOV DI,4  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT  ;(X,Y) 
        
        MOV CX,17 ; SET INITIAL X     
        MOV DX,46 ; SET INITIAL Y 
        MOV BX,3  ;SET BX TO MAXWIDTH
        MOV DI,110 ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y)
        
        MOV CX,301 ; SET INITIAL X     
        MOV DX,46 ; SET INITIAL Y 
        MOV BX,3  ;SET BX TO MAXWIDTH
        MOV DI,110 ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y) 
        
        MOV CX,17 ; SET INITIAL X     
        MOV DX,156 ; SET INITIAL Y 
        MOV BX,4  ;SET BX TO MAXWIDTH
        MOV DI,4  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT  ;(X,Y)
        
        MOV CX,300 ; SET INITIAL X     
        MOV DX,156 ; SET INITIAL Y 
        MOV BX,4  ;SET BX TO MAXWIDTH
        MOV DI,4  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT  ;(X,Y)            

        MOV CX,20 ; SET INITIAL X     
        MOV DX,157 ; SET INITIAL Y 
        MOV BX,280  ;SET BX TO MAXWIDTH
        MOV DI,3 ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y)                              
          
        ;------------------------------------------------------------------------------------
        ;--------------------------------To Draw SPIDER--------------------------------------       
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------
        ;To Draw S
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow        
        
        ;Shadow
        MOV CX,29 ; SET INITIAL X   Xo-1  
        MOV DX,22 ; SET INITIAL Y   Yo+2
        MOV AL,01H ;SET COLOR
        MOV BX,42  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y)
        

        MOV CX,29 ; SET INITIAL X     
        MOV DX,22 ; SET INITIAL Y
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,20  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y)                                                                                  
        
        MOV CX,29 ; SET INITIAL X     
        MOV DX,40 ; SET INITIAL Y
        MOV BX,42  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y+18)
        
        MOV CX,64 ; SET INITIAL X     
        MOV DX,40 ; SET INITIAL Y
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,25  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X+35,Y+18)
        
        MOV CX,29 ; SET INITIAL X     
        MOV DX,63 ; SET INITIAL Y
        MOV BX,42  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y+41) 
          
        ;Stroke
        MOV CX,29 ; SET INITIAL X   Xo-1  
        MOV DX,19 ; SET INITIAL Y   Yo-1
        MOV AL,0FH ;SET COLOR
        MOV BX,42  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y)
        

        MOV CX,29 ; SET INITIAL X     
        MOV DX,19 ; SET INITIAL Y
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,20  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y)                                                                                  
        
        MOV CX,29 ; SET INITIAL X     
        MOV DX,37 ; SET INITIAL Y
        MOV BX,42  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y+18)
        
        MOV CX,64 ; SET INITIAL X     
        MOV DX,37 ; SET INITIAL Y
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,25  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X+35,Y+18)
        
        MOV CX,29 ; SET INITIAL X     
        MOV DX,60 ; SET INITIAL Y
        MOV BX,42  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT  ;(X,Y+41) 
        
        ;Letter
        MOV CX,30 ; SET INITIAL X   Xo  
        MOV DX,20 ; SET INITIAL Y   Yo
        MOV AL,36H ;SET COLOR
        MOV BX,40  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        

        MOV CX,30 ; SET INITIAL X     
        MOV DX,20 ; SET INITIAL Y
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,18  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)                                                                                  
        
        MOV CX,30 ; SET INITIAL X     
        MOV DX,38 ; SET INITIAL Y
        MOV BX,40  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+18)
        
        MOV CX,65 ; SET INITIAL X     
        MOV DX,38 ; SET INITIAL Y
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,23  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+35,Y+18)
        
        MOV CX,30 ; SET INITIAL X     
        MOV DX,61 ; SET INITIAL Y
        MOV BX,40  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+41)                                                                                   
                                                                                                           
                                                                                             
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------

        ; To Draw Capital P 
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,76 ; SET INITIAL X  Xo   
        MOV DX,22 ; SET INITIAL Y  Yo
        MOV AL,01H ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,76 ; SET INITIAL X     
        MOV DX,22 ; SET INITIAL Y   
        MOV BX,42  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,116 ; SET INITIAL X     
        MOV DX,22 ; SET INITIAL Y
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,24  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y)        

        MOV CX,76 ; SET INITIAL X     
        MOV DX,44 ; SET INITIAL Y
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+22)          
         
        ;Stroke
        MOV CX,76 ; SET INITIAL X  Xo   
        MOV DX,19 ; SET INITIAL Y  Yo
        MOV AL,0FH ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,76 ; SET INITIAL X     
        MOV DX,19 ; SET INITIAL Y   
        MOV BX,42  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,116 ; SET INITIAL X     
        MOV DX,19 ; SET INITIAL Y
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,24  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y)        

        MOV CX,76 ; SET INITIAL X     
        MOV DX,41 ; SET INITIAL Y
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+22)     
        
        ;Letter
        MOV CX,77 ; SET INITIAL X  Xo   
        MOV DX,20 ; SET INITIAL Y  Yo
        MOV AL,36H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,46  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,77 ; SET INITIAL X     
        MOV DX,20 ; SET INITIAL Y   
        MOV BX,40  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,117 ; SET INITIAL X     
        MOV DX,20 ; SET INITIAL Y
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,22  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y)        

        MOV CX,77 ; SET INITIAL X     
        MOV DX,42 ; SET INITIAL Y
        MOV BX,45  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+22)                
        
               
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------
        
        ; To Draw Capital i 
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,127 ; SET INITIAL X  Xo-1   
        MOV DX,22 ; SET INITIAL Y  Yo+2
        MOV AL,01H ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        ;Stroke
        MOV CX,127 ; SET INITIAL X  Xo-1   
        MOV DX,19 ; SET INITIAL Y  Yo-1
        MOV AL,0FH ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        ;Letter
        MOV CX,128 ; SET INITIAL X  Xo   
        MOV DX,20 ; SET INITIAL Y  Yo
        MOV AL,36H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,46  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
        

        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------
        
        ; To Draw D 
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,139 ; SET INITIAL X  Xo   
        MOV DX,22 ; SET INITIAL Y  Yo
        MOV AL,01H ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,139 ; SET INITIAL X     
        MOV DX,22 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,179 ; SET INITIAL X  
        MOV DX,27 ; SET INITIAL Y  
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,38  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y+5)
        
        MOV CX,139 ; SET INITIAL X     
        MOV DX,63 ; SET INITIAL Y   
        MOV BX,42  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+41)
        
        
        ;Stroke
        MOV CX,139 ; SET INITIAL X  Xo   
        MOV DX,19 ; SET INITIAL Y  Yo
        MOV AL,0FH ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,139 ; SET INITIAL X     
        MOV DX,19 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,179 ; SET INITIAL X  
        MOV DX,24 ; SET INITIAL Y  
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,43  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y+5)
        
        MOV CX,139 ; SET INITIAL X     
        MOV DX,60 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+41)
         

        
        ;Letter
        MOV CX,140 ; SET INITIAL X  Xo   
        MOV DX,20 ; SET INITIAL Y  Yo
        MOV AL,36H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,46  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,140 ; SET INITIAL X     
        MOV DX,20 ; SET INITIAL Y   
        MOV BX,45  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,180 ; SET INITIAL X  
        MOV DX,25 ; SET INITIAL Y  
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,41  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y+5)
        
        MOV CX,140 ; SET INITIAL X     
        MOV DX,61 ; SET INITIAL Y   
        MOV BX,45  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+41)
        
        ;Down right angle         

        
         
        MOV CX,185 ; SET INITIAL X     
        MOV DX,62 ; SET INITIAL Y
        MOV AL,0FH ;SET COLOR  
        MOV BX,1  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT ;(X+45,Y+41)
        
            
                 
        MOV CX,188 ; SET INITIAL X     
        MOV DX,60 ; SET INITIAL Y
        MOV AL,00H ;SET COLOR  
        MOV BX,8  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT ;(X+45,Y+41)
        
        MOV CX,185 ; SET INITIAL X     
        MOV DX,63 ; SET INITIAL Y
        MOV AL,01H ;SET COLOR  
        MOV BX,2  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT ;(X+45,Y+41)            
   
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------ 

        ; To Draw E 
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,191 ; SET INITIAL X  Xo   
        MOV DX,22 ; SET INITIAL Y  Yo
        MOV AL,01H ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,191 ; SET INITIAL X     
        MOV DX,22 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,191 ; SET INITIAL X     
        MOV DX,42 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22)
        
        MOV CX,191 ; SET INITIAL X     
        MOV DX,63 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22) 
         
        ;Stroke
        MOV CX,191 ; SET INITIAL X  Xo   
        MOV DX,19 ; SET INITIAL Y  Yo
        MOV AL,0FH ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,191 ; SET INITIAL X     
        MOV DX,19 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,191 ; SET INITIAL X     
        MOV DX,39 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22)
        
        MOV CX,191 ; SET INITIAL X     
        MOV DX,60 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22)       
        
        ;Letter
        MOV CX,192 ; SET INITIAL X  Xo   
        MOV DX,20 ; SET INITIAL Y  Yo
        MOV AL,36H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,46  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,192 ; SET INITIAL X     
        MOV DX,20 ; SET INITIAL Y   
        MOV BX,45  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,192 ; SET INITIAL X     
        MOV DX,40 ; SET INITIAL Y   
        MOV BX,45  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22)
        
        MOV CX,192 ; SET INITIAL X     
        MOV DX,61 ; SET INITIAL Y   
        MOV BX,45  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22)              
        

        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------  
          

        ; To Draw Capital R 
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,244 ; SET INITIAL X  Xo   
        MOV DX,22 ; SET INITIAL Y  Yo
        MOV AL,01H ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,244 ; SET INITIAL X     
        MOV DX,22 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,284 ; SET INITIAL X     
        MOV DX,22 ; SET INITIAL Y
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,24  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y)        

        MOV CX,244 ; SET INITIAL X     
        MOV DX,43 ; SET INITIAL Y
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+22)                
        
        MOV CX,259 ; SET INITIAL X     
        MOV DX,43 ; SET INITIAL Y
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,27  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT ;(X+17,Y+22) 
        
        
        ;Stroke
        MOV CX,244 ; SET INITIAL X  Xo   
        MOV DX,19 ; SET INITIAL Y  Yo
        MOV AL,0FH ;SET COLOR
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,48  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,244 ; SET INITIAL X     
        MOV DX,19 ; SET INITIAL Y   
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,284 ; SET INITIAL X     
        MOV DX,19 ; SET INITIAL Y
        MOV BX,7  ;SET BX TO MAXWIDTH
        MOV DI,24  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y)        

        MOV CX,244 ; SET INITIAL X     
        MOV DX,41 ; SET INITIAL Y
        MOV BX,47  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+22)                
        
        MOV CX,260 ; SET INITIAL X     
        MOV DX,41 ; SET INITIAL Y
        MOV BX,8  ;SET BX TO MAXWIDTH
        MOV DI,26  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT ;(X+17,Y+22)  
        
        
        ;Letter
        MOV CX,245 ; SET INITIAL X  Xo   
        MOV DX,20 ; SET INITIAL Y  Yo
        MOV AL,36H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,46  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,245 ; SET INITIAL X     
        MOV DX,20 ; SET INITIAL Y   
        MOV BX,45  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,285 ; SET INITIAL X     
        MOV DX,20 ; SET INITIAL Y
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,22  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y)        

        MOV CX,245 ; SET INITIAL X     
        MOV DX,42 ; SET INITIAL Y
        MOV BX,45  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+22)                
        
        MOV CX,262 ; SET INITIAL X     
        MOV DX,42 ; SET INITIAL Y
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,24  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT ;(X+17,Y+22)        
    
        
        

        ;------------------------------------------------------------------------------------
        ;--------------------------------To Draw INVADERS------------------------------------       
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------

        ; To Draw Capital i 
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,77 ; SET INITIAL X  Xo-1   
        MOV DX,91 ; SET INITIAL Y  Yo+1
        MOV AL,41H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,37  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        ;Stroke
        MOV CX,77 ; SET INITIAL X  Xo-1   
        MOV DX,89 ; SET INITIAL Y  Yo-1
        MOV AL,59H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,37  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        ;Letter
        MOV CX,78 ; SET INITIAL X  Xo   
        MOV DX,90 ; SET INITIAL Y  Yo
        MOV AL,59H ;SET COLOR
        MOV BX,3  ;SET BX TO MAXWIDTH
        MOV DI,35  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------
        

        ; To Draw N
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow 
        
    
        
        
        ;Shadow

        MOV CX,87 ; SET INITIAL X  Xo   
        MOV DX,91 ; SET INITIAL Y  Yo
        MOV AL,41H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,37  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT   ;(x,y)
        
        MOV CX,86 ; SET INITIAL X     
        MOV DX,92 ; SET INITIAL Y  
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,18  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT   ;(x,y)

        MOV CX,103 ; SET INITIAL X     
        MOV DX,91 ; SET INITIAL Y  
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,37  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT   ;(x+34,y)   
                
        ;Stroke 
        MOV CX,87 ; SET INITIAL X  Xo   
        MOV DX,89 ; SET INITIAL Y  Yo
        MOV AL,59H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,37  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT   ;(x,y)
        
        MOV CX,86 ; SET INITIAL X     
        MOV DX,89 ; SET INITIAL Y  
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,18  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT   ;(x,y)

        MOV CX,103 ; SET INITIAL X     
        MOV DX,89 ; SET INITIAL Y  
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,37  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT   ;(x+34,y)       
              
        
   
        ;Letter
        MOV CX,88 ; SET INITIAL X  Xo   
        MOV DX,90 ; SET INITIAL Y  Yo
        MOV AL,59H ;SET COLOR
        MOV BX,3  ;SET BX TO MAXWIDTH
        MOV DI,35  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT   ;(x,y)
        
        MOV CX,88 ; SET INITIAL X     
        MOV DX,90 ; SET INITIAL Y  
        MOV BX,4  ;SET BX TO MAXWIDTH
        MOV DI,16  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT   ;(x,y)

        MOV CX,104 ; SET INITIAL X     
        MOV DX,90 ; SET INITIAL Y  
        MOV BX,3  ;SET BX TO MAXWIDTH
        MOV DI,35  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT   ;(x+34,y)  
        
        
        
        ;Clear line 
        MOV CX,86 ; SET INITIAL X  Xo   
        MOV DX,89 ; SET INITIAL Y  Yo
        MOV AL,00H ;SET COLOR
        MOV BX,1  ;SET BX TO MAXWIDTH
        MOV DI,37  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT   ;(x,y)        
        
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------

        ; To Draw Capital V
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,114 ; SET INITIAL X  Xo   
        MOV DX,93 ; SET INITIAL Y  Yo
        MOV AL,41H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,30  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 

        MOV CX,114 ; SET INITIAL X     
        MOV DX,123 ; SET INITIAL Y  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT   
        
        MOV CX,124 ; SET INITIAL X     
        MOV DX,123 ; SET INITIAL Y  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT   

        MOV CX,125 ; SET INITIAL X  Xo   
        MOV DX,93 ; SET INITIAL Y  Yo
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,30  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        ;Stroke

        ;Letter
        MOV CX,114 ; SET INITIAL X  Xo   
        MOV DX,89 ; SET INITIAL Y  Yo
        MOV AL,59H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,31  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 

        MOV CX,114 ; SET INITIAL X     
        MOV DX,120 ; SET INITIAL Y  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,6  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT   
        
        MOV CX,124 ; SET INITIAL X     
        MOV DX,120 ; SET INITIAL Y  
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,6  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT   

        MOV CX,125 ; SET INITIAL X  Xo   
        MOV DX,89 ; SET INITIAL Y  Yo
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,31  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------
         
        ; To Draw A
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,136 ; SET INITIAL X  Xo   
        MOV DX,97 ; SET INITIAL Y  Yo
        MOV AL,41H ;SET COLOR
        MOV BX,5 ;SET BX TO MAXWIDTH
        MOV DI,30  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
        MOV CX,141 ; SET INITIAL X     
        MOV DX,91 ; SET INITIAL Y  
        MOV BX,6 ;SET BX TO MAXWIDTH
        MOV DI,6  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT 
        
        MOV CX,141 ; SET INITIAL X     
        MOV DX,91 ; SET INITIAL Y  
        MOV BX,6 ;SET BX TO MAXWIDTH
        MOV DI,6  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT
        
        MOV CX,147 ; SET INITIAL X  Xo   
        MOV DX,97 ; SET INITIAL Y  Yo
        MOV BX,5 ;SET BX TO MAXWIDTH
        MOV DI,30  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        MOV CX,141 ; SET INITIAL X  Xo   
        MOV DX,112 ; SET INITIAL Y  Yo
        MOV BX,6   ;SET BX TO MAXWIDTH
        MOV DI,3   ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        ;Stroke
 
        ;Letter
        MOV CX,136 ; SET INITIAL X  Xo   
        MOV DX,95 ; SET INITIAL Y  Yo
        MOV AL,59H ;SET COLOR
        MOV BX,5 ;SET BX TO MAXWIDTH
        MOV DI,30  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT
        
        MOV CX,141 ; SET INITIAL X     
        MOV DX,89 ; SET INITIAL Y  
        MOV BX,6 ;SET BX TO MAXWIDTH
        MOV DI,6  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT 
        
        MOV CX,141 ; SET INITIAL X     
        MOV DX,89 ; SET INITIAL Y  
        MOV BX,6 ;SET BX TO MAXWIDTH
        MOV DI,6  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT
        
        MOV CX,147 ; SET INITIAL X  Xo   
        MOV DX,95 ; SET INITIAL Y  Yo
        MOV BX,5 ;SET BX TO MAXWIDTH
        MOV DI,30  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT 
        
        MOV CX,141 ; SET INITIAL X  Xo   
        MOV DX,110 ; SET INITIAL Y  Yo
        MOV BX,6   ;SET BX TO MAXWIDTH
        MOV DI,3   ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT   
                  
        
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------
                
        
        ; To Draw D 
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,158 ; SET INITIAL X  Xo   
        MOV DX,91 ; SET INITIAL Y  Yo
        MOV AL,41H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,36  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,158 ; SET INITIAL X     
        MOV DX,91 ; SET INITIAL Y   
        MOV BX,22  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,175 ; SET INITIAL X  
        MOV DX,91 ; SET INITIAL Y  
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,36  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+20,Y+5)
        
        MOV CX,158 ; SET INITIAL X     
        MOV DX,122 ; SET INITIAL Y   
        MOV BX,22  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+41)
        
        
        ;Stroke

        
        ;Letter
        MOV CX,158 ; SET INITIAL X  Xo   
        MOV DX,89 ; SET INITIAL Y  Yo
        MOV AL,59H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,36  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,158 ; SET INITIAL X     
        MOV DX,89 ; SET INITIAL Y   
        MOV BX,22  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,175 ; SET INITIAL X  
        MOV DX,89 ; SET INITIAL Y  
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,36  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+20,Y+5)
        
        MOV CX,158 ; SET INITIAL X     
        MOV DX,120 ; SET INITIAL Y   
        MOV BX,22  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+41)
        
        ;Down right angle         
                 
        MOV CX,182 ; SET INITIAL X     
        MOV DX,120 ; SET INITIAL Y
        MOV AL,00H ;SET COLOR  
        MOV BX,8  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT ;(X+45,Y+41)
        
        MOV CX,179 ; SET INITIAL X     
        MOV DX,123 ; SET INITIAL Y
        MOV AL,41H ;SET COLOR  
        MOV BX,1  ;SET BX TO MAXWIDTH
        MOV DI,4  ;SET DI TO MAXHIGHT
        
        CALL DRAW_R_RECT ;(X+45,Y+41)            
   
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------
                

        ; To Draw E 
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,186 ; SET INITIAL X  Xo   
        MOV DX,91 ; SET INITIAL Y  Yo
        MOV AL,41H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,36  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,186 ; SET INITIAL X     
        MOV DX,91 ; SET INITIAL Y   
        MOV BX,20  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,186 ; SET INITIAL X     
        MOV DX,106 ; SET INITIAL Y   
        MOV BX,20  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22)
        
        MOV CX,186 ; SET INITIAL X     
        MOV DX,122 ; SET INITIAL Y   
        MOV BX,20  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22)                             
                         

        ;Stroke

        ;Letter
        MOV CX,186 ; SET INITIAL X  Xo   
        MOV DX,89 ; SET INITIAL Y  Yo
        MOV AL,59H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,36  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,186 ; SET INITIAL X     
        MOV DX,89 ; SET INITIAL Y   
        MOV BX,20  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,186 ; SET INITIAL X     
        MOV DX,104 ; SET INITIAL Y   
        MOV BX,20  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22)
        
        MOV CX,186 ; SET INITIAL X     
        MOV DX,120 ; SET INITIAL Y   
        MOV BX,20  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT        
 
        CALL DRAW_RECT ;(X,Y+22)                             

        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------

        ; To Draw Capital R 
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow
        ;Shadow
        MOV CX,212 ; SET INITIAL X  Xo   
        MOV DX,91 ; SET INITIAL Y  Yo
        MOV AL,41H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,36  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,212 ; SET INITIAL X     
        MOV DX,91 ; SET INITIAL Y   
        MOV BX,22  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,229 ; SET INITIAL X     
        MOV DX,91 ; SET INITIAL Y
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,17  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y)        

        MOV CX,212 ; SET INITIAL X     
        MOV DX,108 ; SET INITIAL Y
        MOV BX,22  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+22)                
        
        MOV CX,216 ; SET INITIAL X     
        MOV DX,113 ; SET INITIAL Y
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,14  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT ;(X+17,Y+22)  
        
        
        ;Stroke 
        
        
        ;Letter
        MOV CX,212 ; SET INITIAL X  Xo   
        MOV DX,89 ; SET INITIAL Y  Yo
        MOV AL,59H ;SET COLOR
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,36  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)

        MOV CX,212 ; SET INITIAL X     
        MOV DX,89 ; SET INITIAL Y   
        MOV BX,22  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        
        MOV CX,229 ; SET INITIAL X     
        MOV DX,89 ; SET INITIAL Y
        MOV BX,5  ;SET BX TO MAXWIDTH
        MOV DI,17  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+40,Y)        

        MOV CX,212 ; SET INITIAL X     
        MOV DX,106 ; SET INITIAL Y
        MOV BX,22  ;SET BX TO MAXWIDTH
        MOV DI,5  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+22)                
        
        MOV CX,216 ; SET INITIAL X     
        MOV DX,111 ; SET INITIAL Y
        MOV BX,6  ;SET BX TO MAXWIDTH
        MOV DI,14  ;SET DI TO MAXHIGHT
        
        CALL DRAW_L_RECT ;(X+17,Y+22)        
        
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------
        
        ;To Draw S
        ; Set intial (x,y) in letter -> (x-1,y-1) in stroke -> (x-1,y+2) in shadow        
        
        ;Shadow
        MOV CX,239 ; SET INITIAL X   Xo  
        MOV DX,111 ; SET INITIAL Y   Yo
        MOV AL,41H ;SET COLOR
        MOV BX,10  ;SET BX TO MAXWIDTH
        MOV DI,2  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        

        MOV CX,239 ; SET INITIAL X     
        MOV DX,111 ; SET INITIAL Y
        MOV BX,2  ;SET BX TO MAXWIDTH
        MOV DI,6  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)                                                                                  
        
        MOV CX,239 ; SET INITIAL X     
        MOV DX,117 ; SET INITIAL Y
        MOV BX,10  ;SET BX TO MAXWIDTH
        MOV DI,2  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+18)
        
        MOV CX,247 ; SET INITIAL X     
        MOV DX,117 ; SET INITIAL Y
        MOV BX,2  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+35,Y+18)
        
        MOV CX,239 ; SET INITIAL X     
        MOV DX,124 ; SET INITIAL Y
        MOV BX,10  ;SET BX TO MAXWIDTH
        MOV DI,2  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+41)  
          
        ;Stroke

        
        ;Letter
        MOV CX,239 ; SET INITIAL X   Xo  
        MOV DX,110 ; SET INITIAL Y   Yo
        MOV AL,59H ;SET COLOR
        MOV BX,10  ;SET BX TO MAXWIDTH
        MOV DI,2  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)
        

        MOV CX,239 ; SET INITIAL X     
        MOV DX,110 ; SET INITIAL Y
        MOV BX,2  ;SET BX TO MAXWIDTH
        MOV DI,6  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y)                                                                                  
        
        MOV CX,239 ; SET INITIAL X     
        MOV DX,116 ; SET INITIAL Y
        MOV BX,10  ;SET BX TO MAXWIDTH
        MOV DI,2  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+18)
        
        MOV CX,247 ; SET INITIAL X     
        MOV DX,116 ; SET INITIAL Y
        MOV BX,2  ;SET BX TO MAXWIDTH
        MOV DI,7  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X+35,Y+18)
        
        MOV CX,239 ; SET INITIAL X     
        MOV DX,123 ; SET INITIAL Y
        MOV BX,10  ;SET BX TO MAXWIDTH
        MOV DI,2  ;SET DI TO MAXHIGHT
        
        CALL DRAW_RECT ;(X,Y+41)                                                                                   
                                                                                                           
                                                                                             
        ;------------------------------------------------------------------------------------
        ;--------------------------------To Draw PRESS ANY KEY-------------------------------      
        ;------------------------------------------------------------------------------------
        ;------------------------------------------------------------------------------------ 
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,09H     ;CURSOR X
        MOV DH,12H     ;CURSOR Y
        INT 10H
        
        ;PRINTING STRING
        MOV AH,9
        MOV DX,OFFSET PRESSANYKEYMSG
        INT 21H 
        
        ;MOVING CURSOR
        MOV AH,2
        MOV DL,0H     ;CURSOR X
        MOV DH,0H     ;CURSOR Y
        INT 10H
        
        ;------------------------------------------------------------------------------------
      
        ;------------------------------------------------------------------------------------
        
        
        
ENDM         