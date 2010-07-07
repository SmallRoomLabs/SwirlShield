/*
  Ledotron
*/

#include <MsTimer2.h>

#define D1  2
#define D2  3  
#define D3  4
#define D4  5
#define D5  6
#define D6  7
#define D7  8
#define D8  9
#define D9  10

volatile boolean bits[60];
volatile byte hour=50;
volatile byte minute=55;
volatile byte second=0;


void setup() {
  int i;
  Serial.begin(9600);	
  for (i=0; i<60; i++) bits[i]=false;
}

void WalkLed() {
  static int c=0;
  static int mode=0;

  if (mode==0) {
    bits[c]=false;
    c++;
    if (c>59) {
        c=0;
        mode=1;
    }
    bits[c]=true;
    return;
  }

  if (mode==1) {
    c++;
    if (c>59) {
        c=0;
        mode=2;
    }
    bits[c]=true;
    return;
  }

  if (mode==2) {
    c++;
    if (c>59) {
        c=0;
        mode=0;
    }
    bits[c]=false;
    return;
  }

}







void UpdateLedsFast(byte col) {
  byte dport, bport;
  byte ddir, bdir;
  
  // Setup the working variables 
  dport=0xff; 
  ddir=0; 
  bport=0xff; 
  bdir=0;
  
  
  switch (col) {

    case 1:                // COL 1
      ddir |= 0x04; 
      if (bits[0]) { dport &= ~0x08; ddir |= 0x08; }
      if (bits[1]) { dport &= ~0x10; ddir |= 0x10; }
      if (bits[2]) { dport &= ~0x20; ddir |= 0x20; }
      if (bits[3]) { dport &= ~0x40; ddir |= 0x40; }
      if (bits[4]) { dport &= ~0x80; ddir |= 0x80; }
      if (bits[5]) { bport &= ~0x01; bdir |= 0x01; }
      if (bits[6]) { bport &= ~0x02; bdir |= 0x02; }
      break;

    case 2:                // COL 2
      ddir |= 0x08; 
      if (bits[7])  { dport &= ~0x04; ddir |= 0x04; }
      if (bits[8])  { dport &= ~0x10; ddir |= 0x10; }
      if (bits[9])  { dport &= ~0x20; ddir |= 0x20; }
      if (bits[10]) { dport &= ~0x40; ddir |= 0x40; }
      if (bits[11]) { dport &= ~0x80; ddir |= 0x80; }
      if (bits[12]) { bport &= ~0x01; bdir |= 0x01; }
      if (bits[13]) { bport &= ~0x02; bdir |= 0x02; }
      break;

    case 3:                 // COL 3
      ddir |= 0x10; 
      if (bits[14]) { dport &= ~0x04; ddir |= 0x04; }
      if (bits[15]) { dport &= ~0x08; ddir |= 0x08; }
      if (bits[16]) { dport &= ~0x20; ddir |= 0x20; }
      if (bits[17]) { dport &= ~0x40; ddir |= 0x40; }
      if (bits[18]) { dport &= ~0x80; ddir |= 0x80; }
      if (bits[19]) { bport &= ~0x01; bdir |= 0x01; }
      if (bits[20]) { bport &= ~0x02; bdir |= 0x02; }
      break;

      case 4:                // COL 4
        ddir |= 0x20; 
        if (bits[21]) { dport &= ~0x04; ddir |= 0x04; }
        if (bits[22]) { dport &= ~0x08; ddir |= 0x08; }
        if (bits[23]) { dport &= ~0x10; ddir |= 0x10; }
        if (bits[24]) { dport &= ~0x40; ddir |= 0x40; }
        if (bits[25]) { dport &= ~0x80; ddir |= 0x80; }
        if (bits[26]) { bport &= ~0x01; bdir |= 0x01; }
        if (bits[27]) { bport &= ~0x02; bdir |= 0x02; }
        break; 

    case 5:                // COL 5
      ddir |= 0x40; 
      if (bits[28]) { dport &= ~0x04; ddir |= 0x04; }
      if (bits[29]) { dport &= ~0x08; ddir |= 0x08; }
      if (bits[30]) { dport &= ~0x10; ddir |= 0x10; }
      if (bits[31]) { dport &= ~0x20; ddir |= 0x20; }
      if (bits[32]) { dport &= ~0x80; ddir |= 0x80; }
      if (bits[33]) { bport &= ~0x01; bdir |= 0x01; }
      break;

    case 6:                // COL 6
      ddir |= 0x80; 
      if (bits[34]) { dport &= ~0x04; ddir |= 0x04; }
      if (bits[35]) { dport &= ~0x08; ddir |= 0x08; }
      if (bits[36]) { dport &= ~0x10; ddir |= 0x10; }
      if (bits[37]) { dport &= ~0x20; ddir |= 0x20; }
      if (bits[38]) { dport &= ~0x40; ddir |= 0x40; }
      if (bits[39]) { bport &= ~0x01; bdir |= 0x01; }
      break;

    case 9:                // COL 9
      bdir |= 0x04; 
      if (bits[53]) { dport &= ~0x04; ddir |= 0x04; }
      if (bits[54]) { dport &= ~0x08; ddir |= 0x08; }
      if (bits[55]) { dport &= ~0x10; ddir |= 0x10; }
      if (bits[56]) { dport &= ~0x20; ddir |= 0x20; }
      if (bits[57]) { dport &= ~0x40; ddir |= 0x40; }
      if (bits[58]) { dport &= ~0x80; ddir |= 0x80; }
      if (bits[59]) { bport &= ~0x01; bdir |= 0x01; }
      break;

    case 7:                // COL 7
      bdir |= 0x01; 
      if (bits[40]) { dport &= ~0x04; ddir |= 0x04; }
      if (bits[41]) { dport &= ~0x08; ddir |= 0x08; }
      if (bits[42]) { dport &= ~0x10; ddir |= 0x10; }
      if (bits[43]) { dport &= ~0x20; ddir |= 0x20; }
      if (bits[44]) { dport &= ~0x40; ddir |= 0x40; }
      if (bits[45]) { dport &= ~0x80; ddir |= 0x80; }
      break;

    case 8:                // COL 8
      bdir |= 0x02; 
      if (bits[46]) { dport &= ~0x04; ddir |= 0x04; }
      if (bits[47]) { dport &= ~0x08; ddir |= 0x08; }
      if (bits[48]) { dport &= ~0x10; ddir |= 0x10; }
      if (bits[49]) { dport &= ~0x20; ddir |= 0x20; }
      if (bits[50]) { dport &= ~0x40; ddir |= 0x40; }
      if (bits[51]) { dport &= ~0x80; ddir |= 0x80; }
      if (bits[52]) { bport &= ~0x01; bdir |= 0x01; }
      break;

  }

  // Write the working variables to the ports, but
  // turn off the previous data first to reduce glithes
  PORTD = 0; 
  PORTB = 0; 
  DDRD = 0; 
  DDRB = 0; 
  PORTD = 0; 
  PORTB = 0; 
  dport &= ddir; 
  bport &= bdir; 
  DDRD |= ddir; 
  PORTD = dport; 
  DDRB |= bdir; 
  PORTB = bport; 
}




void Update() {
  static byte n=1;
  static word cnt=0;

  UpdateLedsFast(n);
  n++;
  if (n>9) n=1;

  cnt++;
  if (cnt>500) {
    cnt=0;
    second++;
    if (second>59) {
      second=0;
      minute++;
      if (minute>59) {
        minute=0;
        hour++;
        if (hour>59) {
            hour=0;
        }
      }
    }
  }
  
}



void loop() {
  int n=0;
  int ch;
  byte lastMinute=1;
  byte lastHour=1;
  char i;
  long j;
  long offset=0;
  
    MsTimer2::set(2, Update);
    MsTimer2::start();

  PORTD = 0; 
  PORTB = 0; 
  DDRD = 0xff; 
  DDRB = 0xff; 


  for (;;) {
    if (minute!=lastMinute) {
      bits[lastMinute]=false;
      lastMinute=minute;
    }
    if (hour!=lastHour) {
      bits[lastHour]=false;
      lastHour=hour;
    }

    bits[lastMinute]=true;
    bits[lastHour]=true;

    for (i=lastMinute, j=offset; i!=lastHour; i++, j++) {
      if (i>59) i=0;
      if (j%10==0) bits[i]=true;
      else if ((i!=lastMinute) && (i!=lastHour)) bits[i]=false;      
    }
  
    for (i=lastMinute, j=offset; i!=lastHour; i--, j++) {
      if (i<0) i=59;
      if (j%10==0) bits[i]=true;
      else if ((i!=lastMinute) && (i!=lastHour)) bits[i]=false;      
    }

    offset++;
    delay(50);
  }


}


