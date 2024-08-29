 XDEF delay     ; define the delay section
 XREF DelayCount ; referencing the delay counter
delay:
 ldy #4000        ;1ms
 sty DelayCount   ;store it into delay count
 delay1:
 dey	
 cpy	#0          ;is Y 0 yet?
 Bne	delay1	    ;if not keep decrementing
 rts		          ;when done go back to loop
