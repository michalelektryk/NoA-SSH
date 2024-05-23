#include "I2C_SLG46826.h"
#define GUZICZEK_PIN 26
I2C_SLG46826 slg(Wire);

#define SLG46826_I2C_SDA 32
#define SLG46826_I2C_SCL 33

void setup() {
  // Init Serial
  Serial.begin(115200);
  delay(500);
  pinMode(GUZICZEK_PIN, INPUT_PULLUP);
  // Init I2C
  Wire.begin(SLG46826_I2C_SDA, SLG46826_I2C_SCL);
}

void readSLG(int controlCode) {
  Serial.printf("===============================================================\n");
  Serial.printf("SLG46826 READ [Control Code = %d]\n", controlCode);
  Serial.printf("===============================================================\n");
  uint8_t data[256];
  memset(data, 0, sizeof(data));
  if (slg.readSlg(controlCode, data)) {
    for (int i = 0; i < 16; i++) {
      for (int j = 0; j < 16; j++) {
        Serial.printf("%02X", data[i * 16 + j]);
      }
      Serial.println();
    }
  } else {
    Serial.printf("SLG46826 not found.\n");
  }
}

void eraseSLG(int controlCode) {
  Serial.printf("===============================================================\n");
  Serial.printf("SLG46826 ERASE [Control Code = %d]\n", controlCode);
  Serial.printf("===============================================================\n");
  if (slg.eraseSlg(controlCode)) {
    Serial.printf("SLG46826 erased.\n");
    slg.resetSlg(controlCode);
    Serial.printf("Resetting SLG46826.\n");
  } else {
    Serial.printf("SLG46826 not found.\n");
  }
}

bool writeSLG(int controlCode, String hexString) {
  Serial.printf("===============================================================\n");
  Serial.printf("SLG46826 WRITE [Control Code = %d]\n", controlCode);
  Serial.printf("===============================================================\n");
  delay(10);
  //int pom=slg.scanSlg(controlCode);
  //Serial.printf("slg code %d\n", pom);
  if (slg.eraseSlg(controlCode)) {
    Serial.printf("SLG46826 erased.\n");
    slg.resetSlg(controlCode);
    Serial.printf("Resetting SLG46826.\n");

    uint8_t hexData[16][16];
    memset(hexData, 0, sizeof(hexData));
    uint16_t hexStrLen = hexString.length();

    uint16_t pos = 0;
    for (int i = 0; i < 16; i++) {
      // find :
      while (pos < hexStrLen && hexString[pos] != ':') {
        pos++;
      }

      // data check
      if (hexStrLen < (pos + 43)) {
        Serial.println("Error");
        while (1)
          ;
      }

      // data skip
      pos += 9;

      // hex to data
      for (int j = 0; j < 16; j++) {
        uint8_t byteData = 0;
        if ('A' <= hexString[pos]) {
          byteData += (hexString[pos] - 'A' + 10) * 16;
        } else {
          byteData += (hexString[pos] - '0') * 16;
        }
        pos++;
        if ('A' <= hexString[pos]) {
          byteData += hexString[pos] - 'A' + 10;
        } else {
          byteData += hexString[pos] - '0';
        }
        pos++;
        hexData[i][j] = byteData;
      }
    }

    // print
    for (int i = 0; i < 16; i++) {
      for (int j = 0; j < 16; j++) {
        Serial.printf("%02X", hexData[i][j]);
      }
      Serial.println();
    }

    slg.writeSlg(0, &hexData[0][0]);
    slg.resetSlg(0);
    Serial.printf("Resetting SLG46826.\n");
  } 
    else 
    {
      Serial.println("dupa nie wgralo sie");
      return 1;
      }
  Serial.println("wgralo sie");
  return 0;
}

void resetSLG(int controlCode) {
  Serial.printf("===============================================================\n");
  Serial.printf("SLG46826 RESET [Control Code = %d]\n", controlCode);
  Serial.printf("===============================================================\n");
  if (slg.resetSlg(controlCode)) {
    Serial.printf("Resetting SLG46826.\n");
  } else {
    Serial.printf("SLG46826 not found.\n");
  }
}

void gpioSLG(int controlCode) {
  Serial.printf("===============================================================\n");
  Serial.printf("SLG46826 GPIO [Control Code = %d]\n", controlCode);
  Serial.printf("===============================================================\n");
  for (int i = 0; i <= 14; i++) {
    Serial.printf("%d : IO%2d\n", slg.digitalRead(controlCode, i), i);
  }
}

int ctrlCode(){
  for (int i = 0; i < 16; i++) {
    int pom=slg.scanSlg(i);
    
    if (pom){
      Serial.printf("slg code %d, ale\n", i);
      return i;
    }
  }
 return -1;
}


void loop() {
    String kod_CLK_DIV =":100000009BB3FDDBB451DBF9038F033D4E86FD5BF3:100010008639685BFD1B20418FB3A5D1F64790D58B:100020004A50FB3B6D03000000E8000000000000A8:100030003E000000B0AACF7FFD2C00FCC00FFCC02A:100040000F00CE0F000000000000000000000000C4:1000500000000000000000000000000000000000A0:1000600000803000808000000000808000000000E0:10007000000300300000000000000000000000004D:10008000000000000014223C0C00002400000000CE:100090000620050000966A7FC8AC1F002102000000:1000A00000AA6A2000010000D00201001002040131:1000B00000AC020100AC02000100AC0201005502DC:1000C0000001000002000100000001010100000029:1000D0000000000000000000000000000000000020:1000E0000000000000000000000000000000000010:1000F000000000000000000000000000000000A55B:00000001FF";
    String kod_FILL_GEN =":10000000D2691492233DC9C23017B058408201AA68:1000100034A492804A0460408FE3481124458F1431:1000200001000000000000000000000000000000CF:10003000000000000000000000D40400000000D216:100040000F000050FD000000000000000000000054:1000500000000000000000000000000000000000A0:10006000008061006161616100008080300030309B:100070000030300000000000000000000000000020:1000800000000000001422300C00000000000000FE:100090000270000001010101ACAC0700AC000000DF:1000A0000003022000010000800201008002000124:1000B00000800201000002000100000201000002B5:1000C0000001000002000100000001010100000029:1000D0000000000000000000000000000000000020:1000E0000000000000000000000000000000000010:1000F000000000000000000000000000000000A55B:00000001FF";

    String kod_test1 =":100000009BB3FDDBB451DBF9038F033D4E86FD5BF3:1000100086396853FD1B20418FB3A5D1F64790D593:100020004850F33B0D00000000E800000000000015:100030003E000000B0AACF7FFD2C00FCC00FFCDF0B:100040000F00CE0F000000000000000000000000C4:1000500000000000000000000000000000000000A0:1000600000803000808000000000808000000000E0:10007000000300300000000000000000000000004D:100080000000F802381422340C00000000000000C8:100090000620050000966A7FC8AC1F002102000000:1000A00000AA6A2000010000D00201001002040131:1000B00000AC020100AC02000100AC020100000231:1000C0000001000002000100000001010100000029:1000D0000000000000000000000000000000000020:1000E0000000000000000000000000000000000010:1000F000000000000000000000000000000000A55B:00000001FF";
    String kod_test2 =":1000000000000000000000000000000000000000F0:10001000000000000000000000000000000000D010:10002000004003000000000000000000000000008D:100030003E000000B0AAC00FFC0000FCC00FFCC0D6:100040000F00C00F000000000000000000000000D2:1000500000000000000000000000000000000000A0:1000600000803000808000000000808000000000E0:10007000000300300000000000000000000000004D:1000800000000000001422340C00000000000000FA:100090000620050000966A7FC8AC1F002102000000:1000A00000AA6A2000010000D00201001002040131:1000B00000AC020100AC02000100AC020100000231:1000C0000001000002000100000001010100000029:1000D0000000000000000000000000000000000020:1000E0000000000000000000000000000000000010:1000F000000000000000000000000000000000A55B";

    int ctrl1=0, ctrl2=0;
    bool written1=0, written2=0;
    //, kod2;
    pinMode(25, OUTPUT);
    while (1) {
    ctrl1=ctrlCode();
    ctrl2=slg.scanSlg(1);
    Serial.printf("ctrl1 %d, ctrl2 %d, written%d\n", ctrl1, ctrl2,written1);
    digitalWrite(25, written1);
    if (written1){
      while (digitalRead(GUZICZEK_PIN)) delay(1);
      delay(5);
      while (!digitalRead(GUZICZEK_PIN)) delay(5);
      delay(5);
      written1=0;
    }
    else if (!written1 && ctrl1!=-1){
      if (!writeSLG(ctrl1, kod_CLK_DIV))
        written1=1;
    }
    delay(100);
  }
}
