  XDEF INITIALIZE_STRINGS
  XREF boot_up_disp, PIN, PINerrormsg, maindisp1, maindisp2,maindisp3, newPinReq
  
;**********************NICKS references******************
  XREF  cooling_header, heating_header, ventilation_header, error_header, cooling_header2, heating_header2, ventilation_header2

;*********************string initializations*********************
  
  INITIALIZE_STRINGS:  
           movb #'E',boot_up_disp
           movb #'N',boot_up_disp+1
           movb #'T',boot_up_disp+2
           movb #'E',boot_up_disp+3
           movb #'R',boot_up_disp+4
           movb #' ',boot_up_disp+5
           movb #'P',boot_up_disp+6
           movb #'I',boot_up_disp+7
           movb #'N',boot_up_disp+8
           movb #':',boot_up_disp+9
           movb #' ',boot_up_disp+10
           movb #' ',boot_up_disp+11
           movb #' ',boot_up_disp+12
           movb #' ',boot_up_disp+13
           movb #' ',boot_up_disp+14
           movb #' ',boot_up_disp+15
           movb #' ',boot_up_disp+16
           movb #' ',boot_up_disp+17
           movb #' ',boot_up_disp+18
           movb #' ',boot_up_disp+19
           movb #' ',boot_up_disp+20
           movb #' ',boot_up_disp+21
           movb #' ',boot_up_disp+22
           movb #' ',boot_up_disp+23
           movb #' ',boot_up_disp+24
           movb #' ',boot_up_disp+25
           movb #' ',boot_up_disp+26
           movb #' ',boot_up_disp+27
           movb #' ',boot_up_disp+28
           movb #' ',boot_up_disp+29
           movb #' ',boot_up_disp+30
           movb #' ',boot_up_disp+31
           movb #0,boot_up_disp+32

           
           ;initialize the PIN string 
           movb #'1',PIN
           movb #'2',PIN+1
           movb #'3',PIN+2
           movb #'4',PIN+3
           movb #0,PIN+4 
           
           ;pin error message 
           movb #'W', PINerrormsg
           movb #'R', PINerrormsg+1 
           movb #'O', PINerrormsg+2 
           movb #'N', PINerrormsg+3 
           movb #'G', PINerrormsg+4 
           movb #' ', PINerrormsg+5 
           movb #'P', PINerrormsg+6 
           movb #'I', PINerrormsg+7
           movb #'N', PINerrormsg+8
           movb #' ', PINerrormsg+9
           movb #0, PINerrormsg+10
           

           
           movb #'T',maindisp1
           movb #'e',maindisp1+1
           movb #'m',maindisp1+2
           movb #'p',maindisp1+3
           movb #':',maindisp1+4
           movb #' ',maindisp1+5
           movb #' ',maindisp1+6
           movb #'*',maindisp1+7
           movb #'F',maindisp1+8
           movb #' ',maindisp1+9
           movb #'H',maindisp1+10
           movb #':',maindisp1+11
           movb #' ',maindisp1+12
           movb #' ',maindisp1+13
           movb #' ',maindisp1+14
           movb #'%',maindisp1+15
           movb #'1',maindisp1+16
           movb #':',maindisp1+17
           movb #'C',maindisp1+18
           movb #'h',maindisp1+19
           movb #'a',maindisp1+20
           movb #'n',maindisp1+21
           movb #'g',maindisp1+22
           movb #'e',maindisp1+23
           movb #' ',maindisp1+24
           movb #'T',maindisp1+25
           movb #'e',maindisp1+26
           movb #'m',maindisp1+27
           movb #'p',maindisp1+28
           movb #' ',maindisp1+29
           movb #' ',maindisp1+30
           movb #' ',maindisp1+31
           movb #0,maindisp1+32    
           
           movb #'T',maindisp2
           movb #'e',maindisp2+1
           movb #'m',maindisp2+2
           movb #'p',maindisp2+3
           movb #':',maindisp2+4
           movb #' ',maindisp2+5
           movb #' ',maindisp2+6
           movb #'*',maindisp2+7
           movb #'F',maindisp2+8
           movb #' ',maindisp2+9
           movb #'H',maindisp2+10
           movb #':',maindisp2+11
           movb #' ',maindisp2+12
           movb #' ',maindisp2+13
           movb #' ',maindisp2+14
           movb #'%',maindisp2+15
           movb #'2',maindisp2+16
           movb #':',maindisp2+17
           movb #'C',maindisp2+18
           movb #'h',maindisp2+19
           movb #'a',maindisp2+20
           movb #'n',maindisp2+21
           movb #'g',maindisp2+22
           movb #'e',maindisp2+23
           movb #' ',maindisp2+24
           movb #'P',maindisp2+25
           movb #'I',maindisp2+26
           movb #'N',maindisp2+27
           movb #' ',maindisp2+28
           movb #' ',maindisp2+29
           movb #' ',maindisp2+30
           movb #' ',maindisp2+31
           movb #0,maindisp2+32    ;string terminator, acts like '\0'
           
           
           movb #'S',maindisp3
           movb #'W',maindisp3+1
           movb #'1',maindisp3+2
           movb #' ',maindisp3+3
           movb #' ',maindisp3+4
           movb #'S',maindisp3+5
           movb #'W',maindisp3+6
           movb #'2',maindisp3+7
           movb #' ',maindisp3+8
           movb #' ',maindisp3+9
           movb #'S',maindisp3+10
           movb #'W',maindisp3+11
           movb #'3',maindisp3+12
           movb #' ',maindisp3+13
           movb #' ',maindisp3+14
           movb #' ',maindisp3+15
           movb #'C',maindisp3+16
           movb #'O',maindisp3+17
           movb #'O',maindisp3+18
           movb #'L',maindisp3+19
           movb #' ',maindisp3+20
           movb #'H',maindisp3+21
           movb #'E',maindisp3+22
           movb #'A',maindisp3+23
           movb #'T',maindisp3+24
           movb #' ',maindisp3+25
           movb #'V',maindisp3+26
           movb #'E',maindisp3+27
           movb #'N',maindisp3+28
           movb #'T',maindisp3+29
           movb #' ',maindisp3+30
           movb #' ',maindisp3+31
           movb #0,maindisp3+32    ;string terminator, acts like '\0'
           
           
           
           
           movb #'N',newPinReq
           movb #'e',newPinReq+1
           movb #'w',newPinReq+2
           movb #' ',newPinReq+3
           movb #'P',newPinReq+4
           movb #'I',newPinReq+5
           movb #'N',newPinReq+6
           movb #':',newPinReq+7
           movb #' ',newPinReq+8
           movb #' ',newPinReq+9
           movb #' ',newPinReq+10
           movb #' ',newPinReq+11
           movb #' ',newPinReq+12
           movb #' ',newPinReq+13
           movb #' ',newPinReq+14
           movb #' ',newPinReq+15
           movb #' ',newPinReq+16
           movb #' ',newPinReq+17
           movb #' ',newPinReq+18
           movb #' ',newPinReq+19
           movb #' ',newPinReq+20
           movb #' ',newPinReq+21
           movb #' ',newPinReq+22
           movb #' ',newPinReq+23
           movb #' ',newPinReq+24
           movb #' ',newPinReq+25
           movb #' ',newPinReq+26
           movb #' ',newPinReq+27
           movb #' ',newPinReq+28
           movb #' ',newPinReq+29
           movb #' ',newPinReq+30
           movb #' ',newPinReq+31
           movb #0,newPinReq+32  
           
  ;*******************NICKS strings************************         
           

; Cooling headers
   movb #'C',cooling_header
   movb #'o',cooling_header+1
   movb #'o',cooling_header+2
   movb #'l',cooling_header+3
   movb #'i',cooling_header+4
   movb #'n',cooling_header+5
   movb #'g',cooling_header+6
   movb #' ',cooling_header+7
   movb #'M',cooling_header+8
   movb #'o',cooling_header+9
   movb #'d',cooling_header+10
   movb #'e',cooling_header+11
   movb #' ',cooling_header+12
   movb #' ',cooling_header+13
   movb #' ',cooling_header+14
   movb #' ',cooling_header+15
   movb #'P',cooling_header+16
   movb #':',cooling_header+17
   movb #' ',cooling_header+18
   movb #'T',cooling_header+19
   movb #'a',cooling_header+20
   movb #'r',cooling_header+21
   movb #'g',cooling_header+22
   movb #'e',cooling_header+23
   movb #'t',cooling_header+24
   movb #' ',cooling_header+25
   movb #'-',cooling_header+26
   movb #' ',cooling_header+27
   movb #' ',cooling_header+28
   movb #' ',cooling_header+29
   movb #' ',cooling_header+30
   movb #' ',cooling_header+31
   movb #0,cooling_header+32
   
   movb #'C',cooling_header2
   movb #'o',cooling_header2+1
   movb #'o',cooling_header2+2
   movb #'l',cooling_header2+3
   movb #'i',cooling_header2+4
   movb #'n',cooling_header2+5
   movb #'g',cooling_header2+6
   movb #' ',cooling_header2+7
   movb #'t',cooling_header2+8
   movb #'o',cooling_header2+9
   movb #' ',cooling_header2+10
   movb #' ',cooling_header2+11
   movb #' ',cooling_header2+12
   movb #' ',cooling_header2+13
   movb #' ',cooling_header2+14
   movb #' ',cooling_header2+15
   movb #' ',cooling_header2+16
   movb #' ',cooling_header2+17
   movb #' ',cooling_header2+18
   movb #' ',cooling_header2+19
   movb #' ',cooling_header2+20
   movb #' ',cooling_header2+21
   movb #' ',cooling_header2+22
   movb #' ',cooling_header2+23
   movb #' ',cooling_header2+24
   movb #' ',cooling_header2+25
   movb #' ',cooling_header2+26
   movb #' ',cooling_header2+27
   movb #' ',cooling_header2+28
   movb #' ',cooling_header2+29
   movb #' ',cooling_header2+30
   movb #' ',cooling_header2+31
   movb #0,cooling_header2+32
   
; Heating headers   
   movb #'H',heating_header
   movb #'e',heating_header+1
   movb #'a',heating_header+2
   movb #'t',heating_header+3
   movb #'i',heating_header+4
   movb #'n',heating_header+5
   movb #'g',heating_header+6
   movb #' ',heating_header+7
   movb #'M',heating_header+8
   movb #'o',heating_header+9
   movb #'d',heating_header+10
   movb #'e',heating_header+11
   movb #' ',heating_header+12
   movb #' ',heating_header+13
   movb #' ',heating_header+14
   movb #' ',heating_header+15
   movb #'P',heating_header+16
   movb #':',heating_header+17
   movb #' ',heating_header+18
   movb #'T',heating_header+19
   movb #'a',heating_header+20
   movb #'r',heating_header+21
   movb #'g',heating_header+22
   movb #'e',heating_header+23
   movb #'t',heating_header+24
   movb #' ',heating_header+25
   movb #'-',heating_header+26
   movb #' ',heating_header+27
   movb #' ',heating_header+28
   movb #' ',heating_header+29
   movb #' ',heating_header+30
   movb #' ',heating_header+31
   movb #0,heating_header+32
   
   movb #'H',heating_header2
   movb #'e',heating_header2+1
   movb #'a',heating_header2+2
   movb #'t',heating_header2+3
   movb #'i',heating_header2+4
   movb #'n',heating_header2+5
   movb #'g',heating_header2+6
   movb #' ',heating_header2+7
   movb #'t',heating_header2+8
   movb #'o',heating_header2+9
   movb #' ',heating_header2+10
   movb #' ',heating_header2+11
   movb #' ',heating_header2+12
   movb #' ',heating_header2+13
   movb #' ',heating_header2+14
   movb #' ',heating_header2+15
   movb #' ',heating_header2+16
   movb #' ',heating_header2+17
   movb #' ',heating_header2+18
   movb #' ',heating_header2+19
   movb #' ',heating_header2+20
   movb #' ',heating_header2+21
   movb #' ',heating_header2+22
   movb #' ',heating_header2+23
   movb #' ',heating_header2+24
   movb #' ',heating_header2+25
   movb #' ',heating_header2+26
   movb #' ',heating_header2+27
   movb #' ',heating_header2+28
   movb #' ',heating_header2+29
   movb #' ',heating_header2+30
   movb #' ',heating_header2+31
   movb #0,heating_header2+32
   
; Ventilation headers   
   movb #'V',ventilation_header
   movb #'e',ventilation_header+1
   movb #'n',ventilation_header+2
   movb #'t',ventilation_header+3
   movb #'i',ventilation_header+4
   movb #'l',ventilation_header+5
   movb #'a',ventilation_header+6
   movb #'t',ventilation_header+7
   movb #'i',ventilation_header+8
   movb #'o',ventilation_header+9
   movb #'n',ventilation_header+10
   movb #' ',ventilation_header+11
   movb #'m',ventilation_header+12
   movb #'o',ventilation_header+13
   movb #'d',ventilation_header+14
   movb #'e',ventilation_header+15
   movb #'S',ventilation_header+16
   movb #'W',ventilation_header+17
   movb #' ',ventilation_header+18
   movb #'7',ventilation_header+19
   movb #'-',ventilation_header+20
   movb #'8',ventilation_header+21
   movb #' ',ventilation_header+22
   movb #'f',ventilation_header+23
   movb #'o',ventilation_header+24
   movb #'r',ventilation_header+25
   movb #' ',ventilation_header+26
   movb #'s',ventilation_header+27
   movb #'p',ventilation_header+28
   movb #'e',ventilation_header+29
   movb #'e',ventilation_header+30
   movb #'d',ventilation_header+31
   movb #0,ventilation_header+32
   
   movb #' ',ventilation_header2
   movb #' ',ventilation_header2+1
   movb #'V',ventilation_header2+2
   movb #'e',ventilation_header2+3
   movb #'n',ventilation_header2+4
   movb #'t',ventilation_header2+5
   movb #'i',ventilation_header2+6
   movb #'l',ventilation_header2+7
   movb #'a',ventilation_header2+8
   movb #'t',ventilation_header2+9
   movb #'i',ventilation_header2+10
   movb #'n',ventilation_header2+11
   movb #'g',ventilation_header2+12
   movb #' ',ventilation_header2+13
   movb #' ',ventilation_header2+14
   movb #' ',ventilation_header2+15
   movb #' ',ventilation_header2+16
   movb #' ',ventilation_header2+17
   movb #' ',ventilation_header2+18
   movb #' ',ventilation_header2+19
   movb #' ',ventilation_header2+20
   movb #' ',ventilation_header2+21
   movb #' ',ventilation_header2+22
   movb #' ',ventilation_header2+23
   movb #' ',ventilation_header2+24
   movb #' ',ventilation_header2+25
   movb #' ',ventilation_header2+26
   movb #' ',ventilation_header2+27
   movb #' ',ventilation_header2+28
   movb #' ',ventilation_header2+29
   movb #' ',ventilation_header2+30
   movb #' ',ventilation_header2+31
   movb #0,ventilation_header2+32

; Error header   
   movb #'I',error_header
   movb #'n',error_header+1
   movb #'v',error_header+2
   movb #'a',error_header+3
   movb #'l',error_header+4
   movb #'i',error_header+5
   movb #'d',error_header+6
   movb #' ',error_header+7
   movb #'t',error_header+8
   movb #'e',error_header+9
   movb #'m',error_header+10
   movb #'p',error_header+11
   movb #' ',error_header+12
   movb #' ',error_header+13
   movb #' ',error_header+14
   movb #' ',error_header+15
   movb #'C',error_header+16
   movb #'l',error_header+17
   movb #'e',error_header+18
   movb #'a',error_header+19
   movb #'r',error_header+20
   movb #' ',error_header+21
   movb #'s',error_header+22
   movb #'w',error_header+23
   movb #'i',error_header+24
   movb #'t',error_header+25
   movb #'c',error_header+26
   movb #'h',error_header+27
   movb #'e',error_header+28
   movb #'s',error_header+29
   movb #' ',error_header+30
   movb #' ',error_header+31
   movb #0,error_header+32   
           
           

  rts      
      