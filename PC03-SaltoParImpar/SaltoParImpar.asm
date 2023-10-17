
_configurar:

;PruebaImparPar.c,4 :: 		void configurar()
;PruebaImparPar.c,6 :: 		T0CON = 0X05;
	MOVLW       5
	MOVWF       T0CON+0 
;PruebaImparPar.c,7 :: 		TMR0L = 0XF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;PruebaImparPar.c,8 :: 		TMR0H = 0XC2;
	MOVLW       194
	MOVWF       TMR0H+0 
;PruebaImparPar.c,9 :: 		ADCON1 = 0XFF;
	MOVLW       255
	MOVWF       ADCON1+0 
;PruebaImparPar.c,10 :: 		TRISA = 2;
	MOVLW       2
	MOVWF       TRISA+0 
;PruebaImparPar.c,11 :: 		TRISB = 0;
	CLRF        TRISB+0 
;PruebaImparPar.c,12 :: 		PORTB = 0;
	CLRF        PORTB+0 
;PruebaImparPar.c,13 :: 		INTCON = 0XC0;
	MOVLW       192
	MOVWF       INTCON+0 
;PruebaImparPar.c,14 :: 		INTCON2 = 0X04;
	MOVLW       4
	MOVWF       INTCON2+0 
;PruebaImparPar.c,15 :: 		T0IE_bit = 1;
	BSF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;PruebaImparPar.c,16 :: 		TMR0ON_bit = 1;
	BSF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;PruebaImparPar.c,17 :: 		}
L_end_configurar:
	RETURN      0
; end of _configurar

_interrupt:

;PruebaImparPar.c,19 :: 		void interrupt()
;PruebaImparPar.c,21 :: 		TMR0ON_bit = 0;
	BCF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;PruebaImparPar.c,22 :: 		T0IE_bit = 0;
	BCF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;PruebaImparPar.c,23 :: 		T0IF_bit = 0;
	BCF         T0IF_bit+0, BitPos(T0IF_bit+0) 
;PruebaImparPar.c,24 :: 		TMR0L = 0XF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;PruebaImparPar.c,25 :: 		TMR0H = 0XC2;
	MOVLW       194
	MOVWF       TMR0H+0 
;PruebaImparPar.c,26 :: 		if (activa ==1)
	MOVLW       0
	XORWF       _activa+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt15
	MOVLW       1
	XORWF       _activa+0, 0 
L__interrupt15:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;PruebaImparPar.c,28 :: 		if (PORTB == 0)
	MOVF        PORTB+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;PruebaImparPar.c,30 :: 		signo = 0;
	CLRF        _signo+0 
	CLRF        _signo+1 
;PruebaImparPar.c,31 :: 		}
	GOTO        L_interrupt2
L_interrupt1:
;PruebaImparPar.c,32 :: 		else if (PORTB == 255)
	MOVF        PORTB+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;PruebaImparPar.c,34 :: 		signo = 1;
	MOVLW       1
	MOVWF       _signo+0 
	MOVLW       0
	MOVWF       _signo+1 
;PruebaImparPar.c,35 :: 		}
L_interrupt3:
L_interrupt2:
;PruebaImparPar.c,36 :: 		if (signo == 0)
	MOVLW       0
	XORWF       _signo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt16
	MOVLW       0
	XORWF       _signo+0, 0 
L__interrupt16:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
;PruebaImparPar.c,38 :: 		PORTB = 2 * PORTB + 1;
	MOVF        PORTB+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       PORTB+0 
;PruebaImparPar.c,39 :: 		}
	GOTO        L_interrupt5
L_interrupt4:
;PruebaImparPar.c,40 :: 		else if (signo == 1)
	MOVLW       0
	XORWF       _signo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt17
	MOVLW       1
	XORWF       _signo+0, 0 
L__interrupt17:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;PruebaImparPar.c,42 :: 		PORTB = (PORTB - 1)/2;
	DECF        PORTB+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	BTFSS       R1, 7 
	GOTO        L__interrupt18
	BTFSS       STATUS+0, 0 
	GOTO        L__interrupt18
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__interrupt18:
	MOVF        R0, 0 
	MOVWF       PORTB+0 
;PruebaImparPar.c,43 :: 		}
L_interrupt6:
L_interrupt5:
;PruebaImparPar.c,44 :: 		}
L_interrupt0:
;PruebaImparPar.c,45 :: 		T0IE_bit = 1;
	BSF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;PruebaImparPar.c,46 :: 		T0CON = 0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;PruebaImparPar.c,47 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;PruebaImparPar.c,49 :: 		void main() {
;PruebaImparPar.c,50 :: 		configurar();
	CALL        _configurar+0, 0
;PruebaImparPar.c,51 :: 		while(1)
L_main7:
;PruebaImparPar.c,53 :: 		if (RA1_bit == 1)
	BTFSS       RA1_bit+0, BitPos(RA1_bit+0) 
	GOTO        L_main9
;PruebaImparPar.c,55 :: 		if (activa == 0)
	MOVLW       0
	XORWF       _activa+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main20
	MOVLW       0
	XORWF       _activa+0, 0 
L__main20:
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
;PruebaImparPar.c,57 :: 		activa = 1;
	MOVLW       1
	MOVWF       _activa+0 
	MOVLW       0
	MOVWF       _activa+1 
;PruebaImparPar.c,59 :: 		}
	GOTO        L_main11
L_main10:
;PruebaImparPar.c,62 :: 		activa = 0;
	CLRF        _activa+0 
	CLRF        _activa+1 
;PruebaImparPar.c,63 :: 		}
L_main11:
;PruebaImparPar.c,64 :: 		}
L_main9:
;PruebaImparPar.c,65 :: 		}
	GOTO        L_main7
;PruebaImparPar.c,66 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
