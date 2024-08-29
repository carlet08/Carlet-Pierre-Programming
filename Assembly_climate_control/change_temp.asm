  XDEF changeTemp
  XREF maindisp1, maindisp2, tempFlag 
  
  XREF current_temp,right_num_disp, left_num_disp, current_temp_f
  
  XREF convertedFlag
  
  XREF hum_hun_p, hum_ten_p, hum_one_p, celcius_hum, fahren_hum
  
  
   temp_to_ASCII: macro
  ldd \1      ;number we are dividing
  ldab #00
  ldx #10    ;load x w/ 10 to divide
  idiv 
  addd #$30  ;d has the remainder ex. 72/10 -> D has 2
  stab left_num_disp  ;right portion of number
  xgdx                 ;put the quotient in D
  adda #$30            ;convert to ASCII 
  staa  right_num_disp
  
  ;move the numbers into the displays
  movb right_num_disp,maindisp1+5
  movb left_num_disp, maindisp1+6
  
  
  movb right_num_disp,maindisp2+5
  movb left_num_disp, maindisp2+6  
   
   endm
   
   humidity_to_ASCII: macro
   ldd \1
   ldx #100 ;load x with 100 to divide
   idiv ; remainder in D
   xgdx ; exchange x with d so D has the quotient
   addd #$30 ; add ASCII conversion
   stab hum_hun_p ; store the lower nibble "1 byte"
   
   xgdx ;D has remainder again
   ldx #10
   idiv ; remainder in D
   xgdx ; D has the quotient
   addd #$30 ; add ASCII conversion
   stab hum_ten_p ; store the lower nibble "1 byte"
   
   xgdx ;D has remainder again
   addd #$30
   stab hum_one_p
  
   movb hum_hun_p, maindisp1+12 ;store hundreds place to string
   movb hum_ten_p, maindisp1+13 ; store tenths place to string
   movb hum_one_p, maindisp1+14 ;store ones place to strin
  
   movb hum_hun_p, maindisp2+12 
   movb hum_ten_p, maindisp2+13 
   movb hum_one_p, maindisp2+14 
   
   endm
   
  
  ;********************CHANGE TEMP ROUTINE******************************
  
  changeTemp:
  ldaa tempFlag
  cmpa #0 
  lbeq toCelcius
 
 ;*******************FAHRENHEIT**************************** 
  toFahren: 
    
  ldaa current_temp
  ldab #9 ; loading register b with numerator
  ldx #5 ; setting up denominator
  mul ;multiply a*b
  idiv ; divide D by X
  tfr x,d ;move quotient to D
  addd #32
  com convertedFlag
  stab current_temp_f
  
  
  temp_to_ASCII current_temp_f ;convert to ascii
  
  movb #'F', maindisp1+8 
  movb #'F', maindisp2+8 
  
  com tempFlag
  lbra endTempJsr
 
 
 ;*****************CELCIUS********************************** 
  toCelcius:
  
  ldaa convertedFlag
  cmpa #0 
  beq skipCelciusConvert

  com convertedFlag
   
  skipCelciusConvert: 
  
  ;****************HUMIDITY******************  
  celcius_humidity: 
  ldaa current_temp
  ldab #50
  ldx #7
  mul 
  idiv 
  tfr x,d
  subd #114
  std celcius_hum
 
  
  humidity_to_ASCII celcius_hum  
  temp_to_ASCII current_temp   ;convert to acii
  
  movb #'C', maindisp1+8 
  movb #'C', maindisp2+8
  
  com tempFlag 

  endTempJsr:
  rts
  
  
  

  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  