#include <Servo.h>

#define servo2Pin 8
#define servo1Pin 9

Servo servo1;
Servo servo2;
int q1, q2;
float x[4] = {0.0,0.0,0.0,0.0}, y[4]= {0.0,0.0,0.0,0.0};
float x0[4] = {0.0,0.0,0.0,0.0}, y0[4]= {0.0,0.0,0.0,0.0};
float xf[4] = {0.0,0.0,0.0,0.0}, yf[4]= {0.0,0.0,0.0,0.0};
float bx, by, Fx, Fy;
const float l1 = 16.8, l2 = 12.0, r = 3.5, cx = 15.0, cy = 11.0;
const float epsilon = 0.3, d = 1, z = 1, P0 = 5, n = 5, alpha = 0.3;

void setup() 
{ 
// Iniciar programa
  Serial.begin(9600);
  servo1.attach(servo1Pin);
  servo2.attach(servo2Pin);
  Serial.println("");
  Serial.println("************************************************************");
  Serial.println("                           BIENVENIDO                       ");
  Serial.println("************************************************************");
// Pedir posicion inicial  
  do {
    pedirDatos();
  } while(obtenerPuntosYVerificar());
// Imprimir nuevos parametros
  Serial.print("q1 = ");
  Serial.print(q1);
  Serial.print("\tq2 = ");
  Serial.println(q2);
// Actualizar servos
  servo1.write(q1);
  servo2.write(map(q2,0,180,5,160)); // Ajuste por error del servo (calibrar)
  delay(15);
} 
 
void loop() 
{ 
  Serial.println("************************************************************");
  Serial.println("                     INGRESA UN DESTINO                     ");
// Pedir posicion destino y almacenar valores de inicio y fin
  for(int i = 0; i < 4; i++) { x0[i] = x[i]; y0[i] = y[i]; }
  do {
    pedirDatos();
  } while(obtenerPuntosYVerificar());
  for(int i = 0; i < 4; i++) { xf[i] = x[i]; yf[i] = y[i]; }
// Ciclo para llegar
  for(int i = 0; i < 4; i++) { x[i] = x0[i]; y[i] = y0[i]; }
  CI(x[3],y[3]);
  while(true) {
  // Imprimir nuevos parametros
    Serial.print("x = ");
    Serial.print(x[3]);
    Serial.print("\ty = ");
    Serial.print(y[3]);
    Serial.print("\tq1 = ");
    Serial.print(q1);
    Serial.print("\tq2 = ");
    Serial.println(q2);  
  // Actualizar servos  
    servo1.write(q1);
    servo2.write(map(q2,0,180,5,160)); // Ajuste por error del servo (calibrar)
    delay(15);
  // Comprobar salida
    if(sqrt((x[3]-xf[3])*(x[3]-xf[3])+(y[3]-yf[3])*(y[3]-yf[3])) < epsilon) { break; }
  // Nuevo estado
    actualizarPunto();
  }
// Asegurar estado final
  for(int i = 0; i < 4; i++) { x[i] = xf[i]; y[i] = yf[i]; }
  CI(x[3],y[3]);
  servo1.write(q1);
  servo2.write(map(q2,0,180,5,160)); // Ajuste por error del servo (calibrar)
  delay(15);
  Serial.println("Estado alcanzado");
} 

void pedirDatos() {
  Serial.print("Introduce la coordenada x: ");
  x[3] = keyboardInput();
  Serial.println(x[3]);
  Serial.print("Introduce la coordenada y: ");
  y[3] = keyboardInput();
  Serial.println(y[3]);
// Cinematica inversa
  CI(x[3],y[3]);
}


float keyboardInput() {
  boolean complete = false;
  int var;
  while (!complete) {
    while (Serial.available()) {
      var = Serial.parseFloat();
      char inChar = (char)Serial.read();
      if (inChar == '\n') {
        complete = true;
      }
    }
  }
  return var;
}

void CI(float posx, float posy) {
  float coseno = (posx*posx+posy*posy-l1*l1-l2*l2)/(2*l1*l2);
  float seno = -sqrt(1-coseno*coseno);
  q1 = round((atan2(posy,posx) - atan2(l2*seno,l1+l2*coseno))*180/PI);
  q2 = abs(round(atan2(seno,coseno)*180/PI));
  q1 = ajustar(q1,0,170);
  q2 = ajustar(q2,0,180);
}

int ajustar(int a, int inf, int sup){
  if(a<inf) {a = inf;}
  if(a>sup) {a = sup;}
  return a;
}

boolean obtenerPuntosYVerificar() {
  x[1] = l1*cos(q1*PI/180);
  x[0] = x[1]/2;
  x[2] = (x[3]+x[1])/2;
  y[1] = l1*sin(q1*PI/180);
  y[0] = y[1]/2;
  y[2] = (y[3]+y[1])/2;
  boolean a = false;
  for(int i = 0; i < 4; i++) {
    a = a || dentroDelCirculo(x[i],y[i]);
  }
  if (a) { Serial.println("Estos valores caen en el circulo."); }
  return a;
}

boolean dentroDelCirculo(float posx, float posy) {
  float dx = posx - cx;
  float dy = posy - cy;
  return (dx*dx + dy*dy)<(r*r);
}

void actualizarPunto() {
  calcularFuerza();
  x[3] = x[3] + alpha*Fx/sqrt(Fx*Fx + Fy*Fy);
  y[3] = y[3] + alpha*Fy/sqrt(Fx*Fx + Fy*Fy);
  obtenerPuntosYVerificar();
  CI(x[3],y[3]);
}

void calcularFuerza() {
  Fx = 0;
  Fy = 0;
  float Pf, Pq;
  for(int i = 0; i < 4; i++) {
  // Fuerza atractiva
    Pf = sqrt( (xf[i]-x[i])*(xf[i]-x[i]) + (yf[i]-y[i])*(yf[i]-y[i]) );
    if (Pf <= d) {
      Fx = Fx + z*(xf[i]-x[i]);
      Fy = Fy + z*(yf[i]-y[i]);
    } else {
      Fx = Fx + d*z*(xf[i]-x[i])/Pf;
      Fy = Fy + d*z*(yf[i]-y[i])/Pf;
    }
  // Fuerza repulsiva:
    puntoCercanoCirculo(x[i],y[i]);
    Pq = sqrt( (bx-x[i])*(bx-x[i]) + (by-y[i])*(by-y[i]) );
    if (Pq <= P0) {
      Fx = Fx + n*(1/Pq-1/P0)*(x[i]-bx)/(Pq*Pq*Pq);
      Fy = Fy + n*(1/Pq-1/P0)*(y[i]-by)/(Pq*Pq*Pq);
    }
  }
}

void puntoCercanoCirculo(float posx, float posy) {
  float dx = cx - posx;
  float dy = cy - posy;
  bx = cx - r*dx/sqrt(dx*dx+dy*dy);
  by = cy - r*dy/sqrt(dx*dx+dy*dy);
}

