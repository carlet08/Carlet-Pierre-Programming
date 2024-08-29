  XREF smallSeconds, CRGFLG, flagOne, flagTwo 
  XDEF RTI_ISR
  XREF PUSHBUTTON
  XREF SendsChr, alarmIsOn  , PlayTone , toneFreq, soundArr, didPress
  XREF port_t_ddr
  
  ;*************NICKS XREF/XDEF**********************
  XREF  port_t, mode_FLAG, port_s, LED_blink_FLAG, blink_FLAG, motor_counter, t_on, motor_flag, motor_delay, ventilation_speed
  XREF soundLoc 

  RTI_ISR:
   
  
  ldaa alarmIsOn
  cmpa #0
  lbne sendSound
    
  backFromSound:
  
  ldaa didPress
  cmpa #0 
  lbne buttonTone
  
  buttonToneReturn:
  bclr port_t_ddr, $28
;*********************NICKS Section*********************************  

         brset port_t, $01, cooling
         brset port_t, $02, heating
         brset port_t, $04, ventilation
         movb #0, mode_FLAG
         bclr port_s, $07
         
         lbra continue_RTI
         
cooling: movb #1, mode_FLAG
         ldaa motor_flag
         cmpa #1
         beq motor
         bra continue_RTI
         
heating: movb #2, mode_FLAG
         bra motor
         
ventilation: movb #3, mode_FLAG
             brset port_t, $C0, very_fast
             brclr port_t, $C0, very_slow
             brset port_t, $80, fast
             brset port_t, $40, slow
very_fast:   movw #10000, ventilation_speed
             bra continue_RTI
very_slow:   movw #40000, ventilation_speed
             bra continue_RTI
fast:        movw #15000, ventilation_speed
             bra continue_RTI
slow:        movw #25000, ventilation_speed
             bra continue_RTI

motor:    ldaa  motor_flag
          cmpa  #1
          bne   clear_port_t  
          bset port_t_ddr, $08 ; this is needed to run your motor 
          ldx motor_delay
          dex
          stx motor_delay
          cpx #0
          bne  continue_RTI
          ldy #50    ; found that a delay is still needed and a small one is better
          sty motor_delay
          ldab  motor_counter
          incb
          stab  motor_counter
          cmpb  t_on
          bls   set_port_t
          cmpb  #15
          bls   clear_port_t
          ldaa  #0
          staa  motor_counter
          bra   continue_RTI

set_port_t:   bset  port_t, $08
              bra   continue_RTI
clear_port_t: bclr  port_t, $08


;*************************BOOT UP DELAY ERROR MSG************************
 
 continue_RTI:
 
  ldaa flagOne 
  cmpa #0
  beq END_RTI
    
  ldy smallSeconds
  iny 
  sty smallSeconds
  cpy #5000
  bne  END_RTI
  
  ldy $00
  sty smallSeconds
  com flagTwo
  
   

 
END_RTI:
  bset CRGFLG ,$80 ; Clear RTIF should BCLR 
  rti 
  
  
 ;******************SOUND SECTION******************* 
     
 sendSound: 
   movb #$28, port_t_ddr ; needed for sound
  ldaa toneFreq 
  cmpa #0
  bne toneLP
 
  resetSound:
  ldx #soundArr
  com toneFreq   
  
  toneLP:
  ldaa 1,x+
  cmpa 0 
  beq resetSound
  psha  
  ldd #0
  jsr SendsChr
  jsr PlayTone
  leas 1,sp 
  
  lbra backFromSound
    
  buttonTone:   
  movb #$28, port_t_ddr ;needed for sound       
  ldaa #10
  psha 
  ldd #0
  jsr SendsChr
  jsr PlayTone
  leas 1,sp
  
  lbra buttonToneReturn
  
  
  
  
