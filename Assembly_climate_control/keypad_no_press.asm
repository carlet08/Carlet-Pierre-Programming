 XDEF NPKEYPAD
 XREF port_u, delay, scanRows, lutTab, DelayCount, pressNUM, saveVal, didPress
 XREF ALARMSTATE, alarmFlag, alarmIsOn
 

   checkALARM4: macro
   ldab alarmIsOn
   cmpb #0
   bne \@pos
   
   ldab alarmFlag 
   cmpb #0
   lbne ALARMSTATE
   
   \@pos: 
   endm
 
NPKEYPAD:
reset:
 ldx #scanRows

 loop:
 checkALARM4
 ldaa 1,x+        ; load value of the sequence
 cmpa #0
 beq NOPRESS      ;exit in case of state switch
 staa port_u      ;send it to the port
 jsr delay        ;4ms delay to debounce

 ldab port_u
 stab saveVal
 ldab port_u
 andb #$0F        ;mask off the higher bits
 cmpb #$F         ; check if no buttons pressed
 beq loop         ;go back through the sequence

 waitRelease:
 checkALARM4
 ldaa port_u      ;second read of the port
 anda #$0F        ; is there any press
 cmpa #$F
 bne waitRelease

 ldy saveVal
 dataLP:
 ldx #lutTab
 ldaa #0          ; index the a register as well

 dataLP1: ldab 0,x
 cmpb #0          ; is it the end of list
 beq NOPRESS      ;at end
 cmpb saveVal     ; is it my value
 beq found        ; matched
 inx              ; next byte of data table
 inca             ; also increment a
 bra dataLP1      ;parse some more

 found:
 staa pressNUM
 com didPress
 rts

 NOPRESS:
 bset saveVal, $FF
 clr didPress
 rts 