   XDEF SYSTEM_ON
   XREF NPKEYPAD, pressNUM, MAIN, MAIN_2, mode_FLAG, motor_flag
   XREF dispChangeFreq, maindisp1, maindisp2, maindisp3, display_string, changeTemp, changePin, t_on, port_s, port_p
   XREF digit1 , digit2, digit3, cooling_header, target_temp, partial_temp1, partial_temp2, LED_blink_FLAG, pushbutton, ventilation_speed, stepper_array
   XREF alarmFlag, getTargetTemp, current_temp, ventilation_header, pushButtonFlag , error_header, heating_header, cooling_header2, heating_header2, ventilation_header2
   
       
   
MY_MACRO: SECTION

  checkPress: macro  ;check which option was pressed
   jsr NPKEYPAD 
   ldaa pressNUM
   cmpa #1
   
   lbeq  changeTempJSR
   cmpa #2 
   lbeq changePinJSR
   endm
     
   checkAlarm: macro   ;checks if alarm is set
   ldaa alarmFlag 
   cmpa #0
   beq \@pos_h
   
   LBNE MAIN_2
   
   \@pos_h:
   endm
   
;***********NICKS macro (CARLET MADE) ******
   
   checkMode: macro
   ldaa mode_FLAG
   cmpa #1
   lbeq  cooling_mode
   cmpa #2
   lbeq  heating_mode
   cmpa #3
   lbeq  ventilation_mode 
   endm

;***************************SYSTEM MENU**********************************************
   SYSTEM_ON: 
   clr pressNUM 
   ldy #10        ;toggling between two strings
   sty dispChangeFreq
   
       
   SYSTEM_ON1:
   checkMode
   checkAlarm 
   checkPress  ;check if 1 or 2 is pressed
   wai
   ldd #maindisp1  ;display 1 -> change temp
   jsr display_string
   
   ldy dispChangeFreq
   dey
   sty dispChangeFreq
   cpy #0 
   bne SYSTEM_ON1
   
   ldy #10
   sty dispChangeFreq
   
   SYSTEM_ON2: ;display -> change PIN 
   checkMode
   checkAlarm
   checkPress  ;checl if 1 or 2 i pressed
   wai
   ldd #maindisp2    ; display 2 -> change pin option
   jsr display_string
   
   ldy dispChangeFreq
   dey
   cpy #0
   sty dispChangeFreq   ;save value
   bne SYSTEM_ON2 
   
   ldy #10
   sty dispChangeFreq
   
   SYSTEM_ON3:    ;display mode options
   checkMode
   checkAlarm
   checkPress
   wai
   ldd #maindisp3
   jsr display_string
   
   ldy dispChangeFreq
   dey
   cpy #0
   sty dispChangeFreq
   bne SYSTEM_ON3
     
   lbra SYSTEM_ON       ;loop through menu display

;*******************SUPPORTING FUNCTIONS*************************   
  
   changeTempJSR:      ;toggle the temp from celcius/fahrenheit
   jsr changeTemp
   lbra SYSTEM_ON
   
   changePinJSR:       ;change it and reboot
   jsr changePin 
   jsr MAIN   ;check this
   
   
;************************NICKS CODE MODES*************************
   
cooling_mode:
get_temp1:  
            jsr  getTargetTemp      ; Read potentiometer value
            ldd  current_temp       ; Load and store current temp
            staa current_temp
            
            movb digit2,cooling_header+28     ; Put temp into cooling header
            movb digit3,cooling_header+29
             
            ldd  #cooling_header      ; Display cooling header
            jsr  display_string
            
            ldaa mode_FLAG      ; Ensure good to stay in cooling mode
            cmpa #0
            lbeq SYSTEM_ON      ; If mode_FLAG is 0, return to SYSTEM_ON
            
            jsr  pushbutton        ; Check pushbutton to begin cooling process
            ldaa pushButtonFlag
            cmpa #1
            bne  get_temp1         ; If not pressed, continue to display target temps
            
            ; Push button was pressed
            ldaa digit2          ; Convert 10's place to decimal
            suba #$30
            ldab #10
            mul
            ldaa digit3          ; Convert 1's place to decimal
            suba #$30
            aba                  ; Add 10's and 1's place
            staa target_temp     ; Store to target temp
            cmpa current_temp    ; Compare to current temp
            lbhs  error_message  ; If higher, show error (this is cooling mode)
            
            ldaa current_temp    ; Load current
            ldab target_temp     ; Load target
            sba                  ; Subtract target from current
            staa t_on            ; Use result as t_on for DC motor
            
            movb digit2, cooling_header2+11     ; Display target cooling temp
            movb digit3, cooling_header2+12
            ldd  #cooling_header2
            jsr  display_string
            
            movb #$01, LED_blink_FLAG     ; Start blinking
            movb #$01, motor_flag         ; Start motor
wait_to_cool:   ldx #1000
delay_light_on: bset port_s, $02       ; Light on
                dex
                cpx #0
                wai
                bne delay_light_on
                ldx #1000
delay_light_off: bclr port_s, $02      ; Light off
                 dex
                 cpx #0
                 wai
                 bne delay_light_off
                 
                 ; Check pushbutton to end cooling
                 jsr pushbutton
                 ldaa pushButtonFlag
                 cmpa #1
                 bne wait_to_cool    ; If not pressed, continue cooling
                 
               ldaa target_temp
               staa current_temp             ; Store target as new current_temp
               movb #0, LED_blink_FLAG       ; Turn off blinking
               movb #0, motor_flag           ; Turn off motor
               lbra SYSTEM_ON                ; Return to SYSTEM_ON
               
    
heating_mode:
get_temp2:
            jsr getTargetTemp     ; Read temp from potentiometer
            ldd current_temp      ; Load and store the value
            staa current_temp
            
            movb digit2, heating_header+28    ; Display value on the LCD
            movb digit3, heating_header+29
            
            ldd #heating_header       ; Display heating header with the potentiometer value
            jsr display_string
            
            ldaa mode_FLAG      ; Ensure correct mode
            cmpa #0
            lbeq  SYSTEM_ON     ; If mode_FLAG is 0, return to SYSTEM_ON
            
            jsr  pushbutton       ; Check for pushbutton press to start heating
            ldaa pushButtonFlag
            cmpa #1
            bne  get_temp2        ; If not pressed, continue to display target temperature choice
            
            ; Push button was pressed
            ldaa digit2     ; Convert 10's place back to decimal
            suba #$30
            ldab #10
            mul
            ldaa digit3     ; Convert 1's place back to decimal
            suba #$30
            aba             ; Add the 10's place and the 1's place to get the temp
            staa target_temp      ; Store value to target_temp
            cmpa current_temp     ; Compare target to current
            lbls  error_message   ; If target is lower, show an error (this is heating mode)
            
            ldaa target_temp      ; Load target
            ldab current_temp     ; Load current
            sba                   ; Subtract current from target
            staa t_on             ; Use result as t_on for DC motor
            
            movb digit2, heating_header2+11        ; Display target temp on heating header
            movb digit3, heating_header2+12
            ldd  #heating_header2
            jsr  display_string
            
            movb #$01, motor_flag      ; Start the motor
wait_to_heat:   ldx #1000
delay_light_on2: bset port_s, $01      ; Light on
                dex
                cpx #0
                wai
                bne delay_light_on2
                ldx #1000
delay_light_off2: bclr port_s, $01     ; Light off
                 dex
                 cpx #0
                 wai
                 bne delay_light_off2
                 
                 ; Check pushbutton to end heating
                 jsr pushbutton
                 ldaa pushButtonFlag
                 cmpa #1
                 bne wait_to_heat     ; If not pressed, continue heating process
                 
               ldaa target_temp
               staa current_temp      ; Store target as new current temp
               movb #0, LED_blink_FLAG    ; Turn off blinking
               movb #0, motor_flag        ; Turn off motor
               lbra SYSTEM_ON             ; Return to SYSTEM_ON
                       
      
ventilation_mode:
            ldd #ventilation_header       ; Display ventilation header
            jsr display_string
            
            ldaa mode_FLAG                ; Check that we are in the correct mode
            cmpa #0
            lbeq SYSTEM_ON
            
            jsr  pushbutton               ; Check pushbutton press to start ventilating
            ldaa pushButtonFlag
            cmpa #1
            bne  ventilation_mode
            
            ldd #ventilation_header2      ; Display ventilating header
            jsr display_string
            
restart_array:  ldy #stepper_array        ; Load array for stepper motor
wait_to_ventilate:
                  
                ldaa 1,Y+
                cmpa #0
                beq restart_array
                staa port_p                  ; Send value to stepper motor
                ldx ventilation_speed        ; Get ventilation_speed based on switches from the RTI
                bset port_s, $04             ; Light on
speed_control:  dex
                cpx #0
                bne speed_control
                bclr port_s, $04             ; Light off
                ldx ventilation_speed
speed_control2: dex
                cpx #0
                bne speed_control2
                
                 ; Check pushbutton to end ventilation
                 jsr pushbutton
                 ldaa pushButtonFlag
                 cmpa #1
                 bne wait_to_ventilate      ; If not pressed, continue ventilating
                 lbra SYSTEM_ON             ; Once complete, return to SYSTEM_ON
            
            
error_message: ldd #error_header            ; Display error header
               jsr display_string
               ldaa mode_FLAG               ; Once mode_FLAG is reset (in RTI), return to SYSTEM_ON
               cmpa #0
               bne  error_message
               lbra SYSTEM_ON

               lbra SYSTEM_ON

               
   
