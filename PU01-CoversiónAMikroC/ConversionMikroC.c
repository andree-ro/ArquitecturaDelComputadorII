#define bit0 P1_0
#define bit1 P1_1
#define bit2 P1_2
#define bit3 P1_3
#define bit4 P1_4
#define bit5 P1_5
#define bit6 P1_6
#define bit7 P1_7

long anterior = 0;
long intervalo = 100;

int noModulo = 0;         // Sera para determinar que modulo mostrar
int noParpadeos = 0;      // En el modulo2, determina cuantas veces parpadea el bit
int bit_Actual = 0;       // Va subiendo y determina que bit esta parpadeando, al terminar se mueve al siguiente
int auxiliarM3 = 0;       // Al llegar al tope del corrimiento de bit regresa
int auxiliarM34 = 0;      // Sirve para ver si ya se encencio la primera vez en el modulo 3, y para encender tambien en el modulo 4
int contador = 0;

// Se declaran todos los bits como salida a excepcion del bit 7
void configurar() {
  pinMode(bit0, OUTPUT);
  pinMode(bit1, OUTPUT);
  pinMode(bit2, OUTPUT);
  pinMode(bit3, OUTPUT);
  pinMode(bit4, OUTPUT);
  pinMode(bit5, OUTPUT);
  pinMode(bit6, OUTPUT);
  pinMode(bit7, INPUT);
}

// Al haber pulsacion en el bit 7 aumenta el contador del modulo que indica el ejercicio a ejecutar
void setup() {
  configurar();
  attachInterrupt(bit7, aumento, RISING);
}

void aumento() {
  reiniciarBits();
  if (noModulo < 5) {
    noModulo++ ;
  }
  else {
    noModulo = 1;
  }
  reiniciarBits();
}

void reiniciarBits() {
  digitalWrite(bit0, LOW);
  digitalWrite(bit1, LOW);
  digitalWrite(bit2, LOW);
  digitalWrite(bit2, LOW);
  digitalWrite(bit4, LOW);
  digitalWrite(bit5, LOW);
  digitalWrite(bit5, LOW);
}

void parpadearBit(int bit){
  digitalWrite(bit, HIGH);
  delay(100);
  digitalWrite(bit, LOW);
  delay(100);
}

void loop() {
  unsigned long actual = millis();
  if (actual - anterior > intervalo) {
    anterior = actual;
// -----------------------------------------------------------------
// PC01 - Basculaci�n de bit
    if (noModulo == 1) {
      P1OUT= contador;
      contador++ ;
      if(contador>127)
      {
        contador=0;
      }
    }
// -----------------------------------------------------------------
// PC02 - Corrimiento de izquierda - derecha 
    if(noModulo == 2){
      int bit[7] = {bit0, bit1, bit2, bit3, bit4, bit5, bit6};
      for (int i = 0; i < 7; i++) {
        for (int doble = 0; doble < 1; doble++) {
          parpadearBit(bit[i]);
        }
      }
      for (int i = 7; i > 0; i--) {
        for (int doble = 0; doble < 1; doble++) {
          parpadearBit(bit[i]);
        }
      }
      reiniciarBits();
    }
//---------------------------------------------------------------
// PC03 - Salto Par - impar
    if (noModulo == 3) {
      int bit[7] = {bit0, bit2, bit4, bit6, bit5, bit3, bit1};
      for (int i = 0; i < 7; i++) {
        for (int doble = 0; doble < 1; doble++) {
          parpadearBit(bit[i]);
        }
      }
      reiniciarBits();
    }
// -----------------------------------------------------------------
// PC04 - Vumetro
    if(noModulo == 4){
      continue;
    }
// -----------------------------------------------------------------
// PC05 - Desplazamiento Centro-Orilla Orilla-Centro
    if(noModulo == 5){
      continue;
    }
}