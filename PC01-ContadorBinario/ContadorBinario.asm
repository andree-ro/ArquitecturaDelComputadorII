#include <xc.inc>
	 
psect resetVec, global, reloc = 2, class = CODE, delta =1 
resetVec:
    org	    0x00	;vector RESET
    goto    inicio	
    org	    0x20	;posicion 32 de memoria de porgrama 

psect inicio, global, reloc=2, class = CODE, delta = 1
inicio:
    contador set 0x60
    cont    set	0x61
    movlw   0xff	; w = 255
    movwf   contador	; contador = w
    movlw   0xff
    movwf   cont
    setf    ADCON1	; ADCON1 = 1111 1111
    clrf    TRISD	; puerto B completo, como salida
    clrf    PORTD
    clrf    LATD	; inicializa el contador del puerto B como 0
bascular:
    incf    LATD, f	; Aumenta el contador de 1 en 1
    // retardo de tiempo
retardo:
    decfsz  contador, 1
    goto    retardo
    movlw   0xff
    movwf   contador
    goto    retardo2
    
retardo2:
    decfsz  contador, 1
    goto    retardo2
    movlw   0xff
    movwf   contador
    decfsz  cont, 1
    goto    retardo
    movlw   0xff
    movwf   cont
    goto    bascular