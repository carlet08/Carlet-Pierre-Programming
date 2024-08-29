 XDEF  getTargetTemp
  XREF  read_pot, digit1, digit2, digit3, partial_temp1, partial_temp2, 
;********************NICKS code*************************  
getTargetTemp:

           jsr read_pot  
           ldx  #100
           idiv
           xgdx
           cmpb #1
           beq  change_high
           addd #$30
           stab digit1
           xgdx
           ldx  #10
           idiv
           xgdx
           cmpb #3
           bhi  change_high
           cmpb #0
           beq  change_low
           bra  skip_change
change_high: ldab #3
             bra  skip_change
change_low:  ldab #1
skip_change:
           stab partial_temp1
           addd #$30
           stab digit2
           xgdx
           ldaa partial_temp1
           cmpa #3
           beq  no_higher
           cmpa #1
           beq  no_lower
           bra  end_target_temp
no_higher: ldab #0
           bra  end_target_temp
no_lower:  cmpb #6
           bhs  end_target_temp
           ldab #6
end_target_temp:
           stab partial_temp2
           addd #$30
           stab digit3
           rts
           
