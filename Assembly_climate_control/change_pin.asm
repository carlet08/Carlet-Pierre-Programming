 XDEF changePin 
 XREF newPinReq, PIN, NPKEYPAD, bootUP, display_string, PIN_in_loc, PIN_loc, pressNUM, flagOne
 XREF didPress
 changePin:
  movb #' ',newPinReq+8
  movb #' ',newPinReq+9
  movb #' ',newPinReq+10
  movb #' ',newPinReq+11
  movb #' ',newPinReq+12

 
 clr flagOne

 ldx #newPinReq+8
 stx PIN_in_loc
 
 ldy #PIN 
 sty PIN_loc
 
 getNewPin:
 ldd #newPinReq
 jsr display_string 
 
 jsr NPKEYPAD
 
 ldaa didPress 
 cmpa #0
 beq getNewPin
  
 ldaa pressNUM
  
 
 ldy PIN_loc
 adda #$30 
 staa 0,y 
  
 ldx PIN_in_loc ;display the number first 
 staa 0,x 
 ldd #newPinReq
 jsr display_string 
 
 ldab #30 ;delay the display
 delay30ms:
 decb 
 cmpb #0
 wai
 bne delay30ms
   
 ldx PIN_in_loc
 movb #'*', x
 
 inx 
 iny
 
 stx PIN_in_loc
 sty PIN_loc
 
 ldab 0,y     ;check if we are at 4 inputs yet
 cmpb #0      ;delimiter ? 
 bne getNewPin
 rts
  