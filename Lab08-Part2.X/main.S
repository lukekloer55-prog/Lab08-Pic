// Luke Kloer
// RCET 3373
// Lab 5 Interrupt Service Routines
// git url is : https://github.com/lukekloer55-prog/Lab05-Pic

; CONFIG1
CONFIG  FOSC = XT             ; Oscillator Selection bits (XT oscillator: Crystal/resonator on RA6/OSC2/CLKOUT and RA7/OSC1/CLKIN)
CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
CONFIG  MCLRE = ON            ; RE3/MCLR pin function select bit (RE3/MCLR pin function is MCLR)
CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
CONFIG  BOREN = OFF           ; Brown Out Reset Selection bits (BOR disabled)
CONFIG  IESO = OFF            ; Internal External Switchover bit (Internal/External Switchover mode is disabled)
CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
CONFIG  LVP = OFF             ; Low Voltage Programming Enable bit (RB3 pin has digital I/O, HV on MCLR must be used for programming)

; CONFIG2
CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)

; Config statements should precede project file includes.
#include <xc.inc>
    
    W_temp EQU 0x70
    Status_temp EQU 0x71
    PCLATH_temp EQU 0x72
    
    
; Reset Vector at 0000h. Execution starts here after reset.
 PSECT resetVect,class=CODE,delta=2
 ResetVector:
    GOTO Setup
    
; --- Interrupt Vector --- at addess 0004h so add -pisrVect=04h to assembler options
PSECT isrVect,class=CODE,delta=2
ISRVector:
    ;GOTO ISRHandler
    

    
; Main Code section starts at 0008h. User code goes here.
PSECT code,class=CODE,delta=2

; Add device setup here
Setup:
    BANKSEL TXSTA
    BSF TXSTA,2	    ;Enable High Baud Rate
    
    BANKSEL SPBRG
    MOVLW 25
    MOVWF SPBRG	    ;Set BaudRate to 9600
    
    BANKSEL RCSTA 
    BSF RCSTA,7	    ;Enable SerialPort
    
    BANKSEL TXSTA
    BSF TXSTA,5	    ;Enable the transmit
   
    GOTO Main
    
Main: 
    BANKSEL PIR1
    BTFSC PIR1, 4
    GOTO TRANSMIT
    GOTO Main

TRANSMIT: 
    
    BANKSEL TXREG
    MOVLW 0x24
    MOVWF TXREG
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    GOTO Main
    
    
    
    
    

    

   