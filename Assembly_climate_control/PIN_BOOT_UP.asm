  XDEF bootUP, ALARMSTATE 
  XREF port_s_ddr, port_s ,boot_up_disp, PIN_in_loc , PIN, PIN_loc
  XREF display_string, NPKEYPAD, pressNUM, PINerrormsg, delay, flagOne, flagTwo 
  XREF alarmFlag, alarmIsOn, gettingPIN, didPress
  
  
  checkALARM2: macro
   ldaa alarmFlag 
   cmpa #0
   lbne ALARMSTATE
   endm
 
  bootUP:
  ;if alarm is already ON I need to do other things still
  ldaa alarmIsOn
  cmpa #0 
  bne skipOver
  
  checkALARM2
  
  skipOver: 
  
  ;clear stars for reboot
  movb #' ',boot_up_disp+10
  movb #' ',boot_up_disp+11
  movb #' ',boot_up_disp+12
  movb #' ',boot_up_disp+13
  movb #' ',boot_up_disp+14

  clr port_s    ; clear the LED
  
  ldx #boot_up_disp + 10 ; offset to the colon of "ENTER PIN:"
  stx PIN_in_loc         ; save it to mem

  ldy #PIN            ;initial PIN is 1234
  sty PIN_loc         ;save to mem
  
 ;*************************************getting the pin**************************** 
 
  com gettingPIN  ;flag to alarm routine I am getting pin currently
  
  getPIN:
  
  checkALARM2  ;still do alarm stuf
  
  returntoPIN:
  
  ldd #boot_up_disp
  jsr display_string
  
  jsr NPKEYPAD 
  ldaa didPress  ;was a button pressed in the routine
  cmpa #0
  beq getPIN     ; if not loop until a button is pressed
  
  
  ldaa pressNUM  ;ASCII conversion
  adda #$30 
 
  ldx PIN_in_loc
  staa 0,x 

  ldd #boot_up_disp  ;display the number first
  jsr display_string 
  
  ldab #30    ;delay the disp' switch from number to *
 delay30ms:
  decb 
  cmpb #0
  wai
  bne delay30ms
   
  ldx PIN_in_loc ; get saved location
  movb #'*' , x  ;star entry
  inx            ;inc location and save it 
  stx PIN_in_loc  
  
  ldd #boot_up_disp ;see the last number input 
  jsr display_string 
 
  ldy PIN_loc 
  ldaa pressNUM  ;get the number from KEYPAD 
  adda #$30      ;convert to ascii
  cmpa 1,y+      ;is it the PIN 
  bne  WRONGPIN  ;wrong
  
 
  sty PIN_loc
  ldab 0,y     ;check if we are at 4 inputs yet
  cmpb #0      ;delimiter ?   
  bne getPIN
 
  com gettingPIN ; we got the right pin so clear alarm 
  clr alarmFlag
  clr alarmIsOn  
 
  rts 
  
  WRONGPIN: ; pin is wrong
  com flagOne
  
  ;clear the stars 
  movb #' ',boot_up_disp+10
  movb #' ',boot_up_disp+11
  movb #' ',boot_up_disp+12
  movb #' ',boot_up_disp+13
  movb #' ',boot_up_disp+14

  
  ;display its wrong and delay for a while 
  ldd #PINerrormsg 
  jsr display_string 
  
  wait5seconds:  ;not actually 5 seconds -> but just delay
  wai
  ldaa flagTwo 
  cmpa #0 
  beq wait5seconds 
  
  com flagOne  ;reset our flags
  com flagTwo
  clr gettingPIN ;not getting pin 

  lbra bootUP ; go back to getting PIN 
  
;*****************************ALARM FUNCTION**********************************  
 ALARMSTATE: 
 ;check if the alarm is already known to be on
 ldaa alarmIsOn
 cmpa #0 
 bne ALARM_STILL 
 com alarmIsOn
  
 ALARM_STILL: ;continue flash LED's 
 
 ldab #80    ;delay LED ON
 delay20ms1:
  bset port_s, $FF
  decb
  cmpb #0
  wai
  bne delay20ms1
  
 ldab #80    ;delay LED OFF
 delay20ms2:
  bclr port_s, $FF
  decb
  cmpb #0
  wai
  bne delay20ms2
   
  ldaa gettingPIN  ;if I am currently in the process of PIN input
  cmpa #0 
  lbne returntoPIN ;go back to PIN loop

  jsr bootUP 
  
  