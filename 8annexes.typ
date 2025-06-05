#import "report/report.typ": * // Import all report symbols
#show figure: set block(breakable: true)
#heading(numbering: none)[Annexes]

- Code C
- Extraits de datasheets ?

#fig[```c
  // FSEC
  #pragma config BWRP = OFF      // Boot Segment Write-Protect bit (Boot Segment may be written)
  #pragma config BSS = XINST_EN  // Boot Segment Program Flash Code Protection bit (Write Protect Disable, use program memory protection for code protection)
  #pragma config BSEN = OFF      // Boot Segment Enable bit (Boot Segment is disabled)
  #pragma config GWRP = OFF      // General Segment Write-Protect bit (General Segment may be written)
  #pragma config GSS = OFF       // General Segment Code Protection bit (General Segment Code Protection is disabled)
  #pragma config CWRP = OFF      // Configuration Segment Write-Protect bit (Configuration Segment may be written)
  #pragma config CSS = OFF       // Configuration Segment Code Protection bit (Configuration Segment Code Protection is disabled)
  #pragma config AIVTDIS = OFF   // Alternate Interrupt Vector Table Disable bit (Disable AIVT)

  // FBSLIM
  #pragma config SPUIDL = OFF // PRAM/Data EEPROM Power-Up/Power-Down Reg Configuration (Regs cleared by Power-Up/Power-Down Reset)

  // FOSCSEL
  #pragma config FNOSC = FRC // Oscillator Select (Fast RC Oscillator (FRC))
  #pragma config IESO = ON   // Internal External Switchover (Start up device with FRC, then automatically switch to user-selected oscillator source when ready)

  // FOSC
  #pragma config POSCMOD = NONE      // Primary Oscillator Select (Primary Oscillator Disabled)
  #pragma config OSCIOFNC = ON       // CLKO Output Enable Configuration (CLKO output disabled; pin functions as general purpose I/O)
  #pragma config SOSCSEL = OFF       // SOSC Power Configuration (SOSC is powered down)
  #pragma config ReleaseCNTL = ON    // Release from RESET Pin (Use RESET pin to release from SLEEP/IDLE mode)
  #pragma config WDTWIN = WDTWIN_EXT // Watchdog Window Select (Watchdog Timer assumes a fixed 25% window of 1:1,024 as default)
  #pragma config WDTCLK = LPRC       // WDT Clock Source Select (WDT uses LPRC)
  #pragma config WDTPS = PS32768     // WDT Prescaler (1:32768)
  #pragma config FWPSA = PR128       // WDT Postscaler (1:128)
  #pragma config FWDTEN = OFF        // Watchdog Timer Enable (WDT disabled in hardware; SWDTEN bit (RCON<4>) can be set by software)

  // FPOR
  #pragma config BOREN = ON   // Brown-out Reset Enable (Brown-out Reset Enabled)
  #pragma config RETVR = OFF  // RETVR Load (RETVR is not loaded)
  #pragma config LPBOREN = ON // Low Power BOR Enable (Low Power BOR Enabled)

  // FICD
  #pragma config ICS = PGD1   // ICD Communication Channel Select bits (Communicate on PGEC1 and PGED1)
  #pragma config JTAGEN = OFF // JTAG Enable bit (JTAG is disabled)

  // FDEVOPT1
  #pragma config ALTREF = OFF  // Alternate VREF Enable (VREF is not on a shared pin)
  #pragma config FUSBIDL = OFF // USBID Pin is an I/O pin (USBID pin function is controlled by the USB module (ULPCTL<1>))
  #pragma config DPTRBF = OFF  // D-Port & D- (PD) Pin Buffer (No D-Port Buffer)

  // FDS
  #pragma config DSWDTEN = OFF       // Deep Sleep Watchdog Timer Enable (DSWDT is disabled)
  #pragma config DSBOREN = ON        // Deep Sleep Brown-Out Reset Enable (DSBOR is enabled)
  #pragma config DSWDTPS = DSWDTPS_8 // Deep Sleep Watchdog Timer Postscale (1:8)
  #pragma config DSWDTOSC = LPRC     // DSWDT Clock Select (DSWDT uses LPRC)
  ```][Macros de configuration du PIC24]

#fig[```c
  #include <xc.h> // Importe la bibliothèque PIC24 constructeur

  void main() {
      ANSA = 0x0000;        // Numérique pour toutes les broches du port A
      TRISAbits.TRISA0 = 0; // Définit RA0 en sortie
      LATAbits.LATA0 = 1;   // Place RA0 à l’état haut
      while (1);            // Boucle infine, garde le MCU dans cet état
  }
  ```][Programme de test de la broche RA0]
