  XDEF pushbutton
  XREF port_p, pushButtonFlag
;************NICKS CODE***********  
pushbutton:
  ldab port_p
  andb #%00100000
  cmpb #0
  beq pb_pressed
  movb #0, pushButtonFlag
  bra end_pb

pb_pressed: 
  movb #1, pushButtonFlag
  
end_pb: rts
