
_main:

;16F676 TIMER.c,1 :: 		void main()
;16F676 TIMER.c,3 :: 		TRISA=0;
	CLRF       TRISA+0
;16F676 TIMER.c,4 :: 		TRISC=0;
	CLRF       TRISC+0
;16F676 TIMER.c,5 :: 		ANSEL=0;
	CLRF       ANSEL+0
;16F676 TIMER.c,6 :: 		PORTA=255;
	MOVLW      255
	MOVWF      PORTA+0
;16F676 TIMER.c,7 :: 		PORTC=255;
	MOVLW      255
	MOVWF      PORTC+0
;16F676 TIMER.c,10 :: 		T1CON=0;
	CLRF       T1CON+0
;16F676 TIMER.c,11 :: 		T1CON.T1CKPS1 = 1;// bits 5-4  Prescaler Rate Select bits
	BSF        T1CON+0, 5
;16F676 TIMER.c,12 :: 		T1CON.T1CKPS0 = 1;
	BSF        T1CON+0, 4
;16F676 TIMER.c,13 :: 		T1CON.T1OSCEN = 1;// bit 3 Timer1 Oscillator Enable Control: bit 1=on
	BSF        T1CON+0, 3
;16F676 TIMER.c,15 :: 		T1CON.TMR1CS  = 0;// bit 1 Timer1 Clock Source Select bit: 0=Internal clock (FOSC/4) / 1 = External clock from pin T1CKI (on the rising edge)
	BCF        T1CON+0, 1
;16F676 TIMER.c,16 :: 		T1CON.TMR1ON  = 1;// bit 0 enables timer
	BSF        T1CON+0, 0
;16F676 TIMER.c,17 :: 		TMR1H = 0xB;     // preset for timer1 MSB register
	MOVLW      11
	MOVWF      TMR1H+0
;16F676 TIMER.c,18 :: 		TMR1L = 0xDC;    // preset for timer1 LSB register
	MOVLW      220
	MOVWF      TMR1L+0
;16F676 TIMER.c,20 :: 		PIE1.TMR1IE=1;
	BSF        PIE1+0, 0
;16F676 TIMER.c,21 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;16F676 TIMER.c,22 :: 		while(1);
L_main0:
	GOTO       L_main0
;16F676 TIMER.c,23 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;16F676 TIMER.c,25 :: 		void interrupt()
;16F676 TIMER.c,27 :: 		if (PIE1.TMR1IE==1)
	BTFSS      PIE1+0, 0
	GOTO       L_interrupt2
;16F676 TIMER.c,29 :: 		if (PIR1.TMR1IF==1)
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt3
;16F676 TIMER.c,31 :: 		PORTC=~PORTC;
	COMF       PORTC+0, 1
;16F676 TIMER.c,32 :: 		PIR1.TMR1IF=0;
	BCF        PIR1+0, 0
;16F676 TIMER.c,33 :: 		TMR1H = 0xB;     // preset for timer1 MSB register
	MOVLW      11
	MOVWF      TMR1H+0
;16F676 TIMER.c,34 :: 		TMR1L = 0xDC;     // preset for timer1 LSB register
	MOVLW      220
	MOVWF      TMR1L+0
;16F676 TIMER.c,35 :: 		}
L_interrupt3:
;16F676 TIMER.c,36 :: 		}
L_interrupt2:
;16F676 TIMER.c,37 :: 		}
L_end_interrupt:
L__interrupt6:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
