_configurar:

;PruebaTurno.c,4 :: 		void configurar()
;PruebaTurno.c,6 :: 		T0CON = 0X05;
	MOVLW       5
	MOVWF       T0CON+0 
;PruebaTurno.c,7 :: 		TMR0L = 0XF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;PruebaTurno.c,8 :: 		TMR0H = 0XC2;
	MOVLW       194
	MOVWF       TMR0H+0 
;PruebaTurno.c,9 :: 		ADCON1 = 0XFF;
	MOVLW       255
	MOVWF       ADCON1+0 
;PruebaTurno.c,10 :: 		TRISA = 2;
	MOVLW       2
	MOVWF       TRISA+0 
;PruebaTurno.c,11 :: 		TRISB = 0;
	CLRF        TRISB+0 
;PruebaTurno.c,12 :: 		PORTB = 0;
	CLRF        PORTB+0 
;PruebaTurno.c,13 :: 		INTCON = 0XC0;
	MOVLW       192
	MOVWF       INTCON+0 
;PruebaTurno.c,14 :: 		INTCON2 = 0X04;
	MOVLW       4
	MOVWF       INTCON2+0 
;PruebaTurno.c,15 :: 		T0IE_bit = 1;
	BSF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;PruebaTurno.c,16 :: 		TMR0ON_bit = 1;
	BSF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;PruebaTurno.c,17 :: 		}
L_end_configurar:
	RETURN      0
; end of _configurar

_interrupt:

;PruebaTurno.c,19 :: 		void interrupt()
;PruebaTurno.c,21 :: 		TMR0ON_bit = 0;
	BCF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;PruebaTurno.c,22 :: 		T0IE_bit = 0;
	BCF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;PruebaTurno.c,23 :: 		T0IF_bit = 0;
	BCF         T0IF_bit+0, BitPos(T0IF_bit+0) 
;PruebaTurno.c,24 :: 		TMR0L = 0XF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;PruebaTurno.c,25 :: 		TMR0H = 0XC2;
	MOVLW       194
	MOVWF       TMR0H+0 
;PruebaTurno.c,26 :: 		if (activa ==1)
	MOVLW       0
	XORWF       _activa+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt15
	MOVLW       1
	XORWF       _activa+0, 0 
L__interrupt15:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;PruebaTurno.c,28 :: 		if (PORTB == 128)
	MOVF        PORTB+0, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;PruebaTurno.c,30 :: 		signo = 1;
	MOVLW       1
	MOVWF       _signo+0 
	MOVLW       0
	MOVWF       _signo+1 
;PruebaTurno.c,31 :: 		}
L_interrupt1:
;PruebaTurno.c,32 :: 		if (PORTB == 0)
	MOVF        PORTB+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;PruebaTurno.c,34 :: 		PORTB = 1;
	MOVLW       1
	MOVWF       PORTB+0 
;PruebaTurno.c,35 :: 		signo = 0;
	CLRF        _signo+0 
	CLRF        _signo+1 
;PruebaTurno.c,36 :: 		}
	GOTO        L_interrupt3
L_interrupt2:
;PruebaTurno.c,37 :: 		else if (signo == 0)
	MOVLW       0
	XORWF       _signo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt16
	MOVLW       0
	XORWF       _signo+0, 0 
L__interrupt16:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
;PruebaTurno.c,39 :: 		PORTB = 2 * PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       PORTB+0 
;PruebaTurno.c,40 :: 		}
	GOTO        L_interrupt5
L_interrupt4:
;PruebaTurno.c,41 :: 		else if (signo == 1)
	MOVLW       0
	XORWF       _signo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt17
	MOVLW       1
	XORWF       _signo+0, 0 
L__interrupt17:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;PruebaTurno.c,43 :: 		PORTB = PORTB/2;
	MOVF        PORTB+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       PORTB+0 
;PruebaTurno.c,44 :: 		}
L_interrupt6:
L_interrupt5:
L_interrupt3:
;PruebaTurno.c,45 :: 		}
L_interrupt0:
;PruebaTurno.c,46 :: 		T0IE_bit = 1;
	BSF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;PruebaTurno.c,47 :: 		T0CON = 0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;PruebaTurno.c,48 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;PruebaTurno.c,50 :: 		void main() {
;PruebaTurno.c,51 :: 		configurar();
	CALL        _configurar+0, 0
;PruebaTurno.c,52 :: 		while(1)
L_main7:
;PruebaTurno.c,54 :: 		if (RA1_bit == 1)
	BTFSS       RA1_bit+0, BitPos(RA1_bit+0) 
	GOTO        L_main9
;PruebaTurno.c,56 :: 		if (activa == 0)
	MOVLW       0
	XORWF       _activa+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main19
	MOVLW       0
	XORWF       _activa+0, 0 
L__main19:
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
;PruebaTurno.c,58 :: 		activa = 1;
	MOVLW       1
	MOVWF       _activa+0 
	MOVLW       0
	MOVWF       _activa+1 
;PruebaTurno.c,60 :: 		}
	GOTO        L_main11
L_main10:
;PruebaTurno.c,63 :: 		activa = 0;
	CLRF        _activa+0 
	CLRF        _activa+1 
;PruebaTurno.c,64 :: 		}
L_main11:
;PruebaTurno.c,65 :: 		}
L_main9:
;PruebaTurno.c,66 :: 		}
	GOTO        L_main7
;PruebaTurno.c,67 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
