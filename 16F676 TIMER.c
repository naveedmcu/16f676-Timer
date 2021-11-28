void main() 
{
   TRISA=0;
   TRISC=0;
   ANSEL=0;
   PORTA=255;
   PORTC=255;
// Timer1 Registers:
// Prescaler=1:8; TMR1 Preset=3036; Freq=2.00Hz; Period=500.00 ms
  T1CON=0;
  T1CON.T1CKPS1 = 1;// bits 5-4  Prescaler Rate Select bits
  T1CON.T1CKPS0 = 1;
  T1CON.T1OSCEN = 1;// bit 3 Timer1 Oscillator Enable Control: bit 1=on
//  T1CON.T1SYNC  = 1;// bit 2 Timer1 External Clock Input Synchronization Control bit: 1=Do not synchronize external clock input
  T1CON.TMR1CS  = 0;// bit 1 Timer1 Clock Source Select bit: 0=Internal clock (FOSC/4) / 1 = External clock from pin T1CKI (on the rising edge)
  T1CON.TMR1ON  = 1;// bit 0 enables timer
  TMR1H = 0xB;     // preset for timer1 MSB register
  TMR1L = 0xDC;    // preset for timer1 LSB register
  
  PIE1.TMR1IE=1;
  INTCON.GIE=1;
  while(1);
}

void interrupt()
{
 if (PIE1.TMR1IE==1)
 {
  if (PIR1.TMR1IF==1)
  {
   PORTC=~PORTC;
   PIR1.TMR1IF=0;
   TMR1H = 0xB;     // preset for timer1 MSB register
   TMR1L = 0xDC;     // preset for timer1 LSB register
  }
 }
}