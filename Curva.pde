class Curva {

  // Atributos principales
  private PVector posicion;
  private float parametroT; 
  private float velocidadT;

  // Control interno para curvas del jefe
  private float tEntrada = 0;
  private float tOcho = 0;
  private float tHorizontal = 0;
  private boolean cicloOcho = false;
  private boolean cicloHorizontal = false;

  // Constructor
  public Curva() {
    this.parametroT = 0;
  }

  // Dibujo y actualización: (no aplica en esta clase, solo define trayectorias)
  // --- Métodos de trayectorias básicas ---

  // Movimiento parabólico de izquierda a derecha
  PVector parabolaIzqDer(float ox, float oy, float velocidadT) {
    this.posicion = new PVector(ox, oy);
    this.velocidadT = velocidadT;
    parametroT += velocidadT;

    float x = parametroT * 600;
    float y = 600 * (1 - parametroT) * parametroT;

    return new PVector(x, y);
  }

  // Movimiento parabólico de derecha a izquierda
  PVector parabolaDerIzq(float ox, float oy, float velocidadT) {
    this.posicion = new PVector(ox, oy);
    this.velocidadT = velocidadT;
    parametroT += velocidadT;

    float x = 600 - (parametroT * 600);
    float y = 400 * (1 - parametroT) * parametroT;

    return new PVector(x, y);
  }

  // Parábola más suave con parámetro continuo (izquierda a derecha)
  PVector parabolaParametrica(float ox, float oy, float velocidadT) {
    parametroT += velocidadT / 300; 
    float x = 400 + parametroT * 200;
    float y = 1.0f / 240.0f * (x - 400) * (x - 400);
    return new PVector(x, y);
  }

  // Versión invertida (derecha a izquierda)
  PVector parabolaParametricaInv(float ox, float oy, float velocidadT) {
    parametroT += velocidadT / 300; 
    float x = 400 - parametroT * 200;
    float y = 1.0f / 240.0f * (x - 400) * (x - 400);
    return new PVector(x, y);
  }

  // Movimiento diagonal hacia abajo (izquierda a derecha)
  PVector diag(float ox, float oy, float velocidadT) {
    this.velocidadT = velocidadT;
    parametroT += velocidadT / 150;
    float x = ox + parametroT;
    float y = oy + parametroT * 0.7;
    return new PVector(x, y);
  }

  // Movimiento diagonal invertido (derecha a izquierda)
  PVector diagInv(float ox, float oy, float velocidadT) {
    this.velocidadT = velocidadT;
    parametroT += velocidadT / 300;
    float x = ox - parametroT;
    float y = oy + parametroT * 0.8;
    return new PVector(x, y);
  }

  // Movimiento recto hacia abajo
  PVector rectaHorizontal(float ox, float oy, float velocidadT) {
    this.velocidadT = velocidadT;
    parametroT += velocidadT / 100;
    float x = ox;
    float y = oy + parametroT;
    return new PVector(x, y);
  }

  // --- Curvas exclusivas del jefe final ---

  // Entrada descendente inicial
  PVector curvaJefeEntrada(float velocidadT, float alturaObjetivo) {
    tEntrada += velocidadT / 600.0;
    float y = constrain(tEntrada * 100, -100, alturaObjetivo);
    float x = width / 2;
    return new PVector(x, y);
  }

  // Movimiento en forma de "8"
  PVector curvaJefeOcho(float velocidadT, float alturaObjetivo) {
    tOcho += velocidadT / 200.0;
    float x = width / 2 + sin(tOcho) * 200;
    float y = alturaObjetivo + sin(tOcho * 2) * 100;
    cicloOcho = (tOcho >= TWO_PI);
    if (cicloOcho) tOcho -= TWO_PI;
    return new PVector(x, y);
  }

  // Indica si completó una figura en 8
  boolean completoOcho() { return cicloOcho; }

  // Movimiento lateral horizontal del jefe
  PVector curvaHorizontal(float velocidadT, float alturaObjetivo) {
    tHorizontal += velocidadT / 100.0;
    float amplitud = 320;
    float x = width / 2 + sin(tHorizontal) * amplitud;
    float y = alturaObjetivo;
    cicloHorizontal = (tHorizontal >= TWO_PI);
    if (cicloHorizontal) tHorizontal -= TWO_PI;
    return new PVector(x, y);
  }

  // Indica si completó un ciclo lateral completo
  boolean cicloHorizontal() { return cicloHorizontal; }
}
