 XDEF IRQ_ISR
 XREF alarmFlag, alarmIsOn
 
 IRQ_ISR:
 ldaa alarmIsOn  ;check if alarm is already on 
 cmpa 0
 bne END_IRQ 
 
 com alarmFlag   ;flag first alarm notice
 
 END_IRQ:
 rti
 