  INCLUDE 'derivative.inc'
  XDEF Entry, _Startup
  XREF __SEG_END_SSTACK ,delay     

  ; LCD References
  XREF  init_LCD

  ; Potentiometer References
  XREF  display_string, pot_value, read_pot

  ; HEXPAD references
  XREF NPKEYPAD
  XDEF port_u, scanRows, lutTab, DelayCount, pressNUM, saveVal
    
  ;bootUP.asm 
  XREF bootUP 
  XDEF port_s_ddr, port_s ,boot_up_disp, PIN_in_loc , PIN, PIN_loc , PINerrormsg
  
  ;string intialize
  XREF INITIALIZE_STRINGS
  XDEF boot_up_disp, PIN, PINerrormsg, maindisp1, maindisp2,maindisp3, newPinReq
  
  ;boot up function
  XDEF smallSeconds, CRGFLG, flagOne, flagTwo, tempFlag, port_p 
  XREF changeTemp, changePin
  
  ;alarm function
  XDEF alarmFlag, alarmIsOn, gettingPIN, didPress
  XREF ALARMSTATE 
   XDEF port_t, port_t_ddr, toneFreq, soundArr 
 
  ;system function  
   XDEF MAIN , MAIN_2        
   XREF SYSTEM_ON
   XDEF dispChangeFreq, target_temp
   
    ; temp stuff -> humidity and conversion
   XDEF right_num_disp, left_num_disp, current_temp, convertedFlag 
   XDEF hum_hun_p, hum_ten_p, hum_one_p, celcius_hum, fahren_hum

  
 ; ***************NICKS xdef / xref****************
 
 
   XDEF  cooling_header, heating_header, pressed_value, upper_nibble, cooling_header2, heating_header2, current_temp_f 
   XDEF digit1, digit2, digit3, partial_temp1, partial_temp2, mode_FLAG, ventilation_header, ventilation_header2
   XDEF LED_blink_FLAG, error_header, blink_FLAG
   XREF  pushbutton, getTargetTemp
   XDEF pushButtonFlag, t_on, motor_counter, motor_flag, motor_delay, ventilation_speed, stepper_array  
   
  
; ***************variables************
variables: SECTION
;display variables
boot_up_disp:	ds.b 33
PINerrormsg: ds.b 11

maindisp1:	ds.b 33
maindisp2: ds.b 33
maindisp3: ds.b 33
newPinReq: ds.b 33

;pin 
PIN: ds.b 5 

flagOne: ds.b 1
flagTwo: ds.b 1
tempFlag: ds.b 1


PIN_in_loc: ds.w 1 ;y and x pointer saving 
PIN_loc: ds.w 1

;hexpad variables
DelayCount: ds.w  1      ;delay variable
saveVal: ds.b 1 
pressNUM: ds.b 1
 smallSeconds: ds.w 1 ;RTI counter
 dispChangeFreq: ds.w 1

; alarm function variables
alarmFlag: ds.b 1
alarmIsOn: ds.b 1
gettingPIN: ds.b 1      ;flag to know I am getting PIN
didPress: ds.b 1        ;was there a button pressed in NPKEYPAD
pushButtonFlag: ds.b 1  ;was the PB pressed 
toneFreq: ds.b 1        ;to toggle between two tones in alarm 

; temp vars -> humidity / conversion
right_num_disp: ds.b 1 
left_num_disp: ds.b 1  
convertedFlag: ds.b 1
hum_hun_p: ds.b 1 
hum_ten_p: ds.b 1 
hum_one_p: ds.b 1 
celcius_hum: ds.w 1 
fahren_hum: ds.w 1



;*****************NICKS vars**************

  cooling_header: ds.b 33
  heating_header: ds.b 33
  cooling_header2: ds.b 33
  heating_header2: ds.b 33
  ventilation_header: ds.b 33
  ventilation_header2: ds.b 33
  error_header: ds.b 33
  digit1: ds.b  1
  digit2: ds.b  1
  digit3: ds.b  1
  partial_temp1: ds.b 1
  partial_temp2: ds.b 1
  upper_nibble: ds.b  1
  pressed_value: ds.b 1
  target_temp: ds.b 1
  current_temp: ds.b 1
  current_temp_f: ds.b 1
  mode_FLAG: ds.b 1
  LED_blink_FLAG: ds.b 1
  blink_FLAG: ds.b 1
  t_on: ds.b 1
  motor_counter: ds.b 1
  motor_flag: ds.b 1
  motor_delay: ds.w 1
  ventilation_speed: ds.w 1


;***********************constants**********************
constants: SECTION
port_u: equ $268          ;hex pad 
port_u_ddr: equ $26a 
port_u_psr: equ $26d      ;pull up(0) or down (1) 
port_u_per: equ $26c      ; pull enable (1) or disable (0)

scanRows: dc.b $70, $B0, $D0, $E0, $0 ; to scan keypad rows
lutTab: dc.b $eb, $77, $7b, $7d, $b7, $bb, $bd, $d7, $db
         dc.b  $dd, $e7, $ed, $7e, $be, $de, $ee, $0
          
port_s: equ $248    ;led port
port_s_ddr: equ $24a 

port_p: equ $258    ;PB / stepper motor 
port_p_ddr: equ $25a
                         
port_t: equ $240        ;speaker and switches
port_t_ddr: equ $242

 soundArr: dc.b $4,18,$0  ;tones to send out
 lightSequence:  dc.b  $81, $42, $24, $18, $24, $42, $0  ;open LED sequence
 stepper_array: dc.b $0A, $12, $14, $0C, 0

MyCode:     SECTION
Entry:
_Startup:
;******************Initialize some stuff************************
          
          lds       #__SEG_END_SSTACK 
         
          bset port_u_ddr,$F0        ;bit 1-3 inputs(0) , 4-7 outputs (1)
          bset port_u_psr,$F0        ;pins 1-3 pull up
          bset port_u_per, $0F       ;enable pull up on pins 1-3  
          bset port_s_ddr,$FF ;set all of the bits of led to output 
          bset port_p_ddr, $1e ; stepper motor initialization
           
          movb #$80, CRGINT ; RTI     
          movb #$C0 , INTCR   ;IRQ 
          movb #$10, RTICTL        ; .000128 ms interval
          
          ldy $0000
          sty smallSeconds
          
          movb #3, toneFreq   
          movb #0, motor_counter  ;set motor counter to 0
          clr  blink_FLAG
          ldaa #0
          staa t_on
          ldaa #0
          staa motor_flag
          movw #1000, motor_delay
                          
          jsr INITIALIZE_STRINGS     
          jsr  init_LCD 
    

;***********************MAIN CODE**********************************
          cli
          

   MAIN:    ; clear all my flags
   clr tempFlag
   clr flagOne
   clr flagTwo
   clr alarmFlag 
   clr alarmIsOn
   clr gettingPIN
   clr pushButtonFlag  
   clr mode_FLAG
   clr convertedFlag
      
   MAIN_2: ;here is the entry  
   movb #18, current_temp   ; Initialize random current temp
   jsr changeTemp ;load a temp before displays show
   jsr bootUP    ;getting PIN
   lbra lightLP  ;light UP sequence
   
   returnFromLight: 
   bclr port_s, $FF ;reset LED to empty first
   bset port_s, $80 ; system on LED 
   
   
   sysLoop: ;entire main menu and system
   jsr SYSTEM_ON
   bra sysLoop
      

;*******************SUPPORTING FUNCTION*************************   

   lightLP: 
    sendSeq1: ldx #lightSequence   ; set the pointe to first sequence
    seqSend: 
    ldaa 1,x+   ; load in the value of sequence
    cmpa #0 ; testing if I see the NULL
    lbeq    returnFromLight ; if so I loop back into the start
    staa port_s ; send seq value to the LED           
    ldy #500    ;delay the clearing 
    delay20ms2:
    dey
    cpy #0
    wai
    bne delay20ms2
    bra seqSend 
   
