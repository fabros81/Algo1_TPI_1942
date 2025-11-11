class AvionEnemigoJefeFinal extends AvionEnemigo {

  // Atributos principales
  private int fase = 1;                // Determina la fase de comportamiento actual
  private float vidaMax = this.hp;     
  private float hpActual = vidaMax;    
  private boolean invulnerable = true; // Evita recibir daño al aparecer
  private boolean modoFuria = false;   

  // Disparo
  private float tiempoUltimoDisparo = 0;
  private float delayDisparo = 1500;   // Intervalo entre disparos (ms)

  // Control de movimiento por fases
  private int vueltasOcho = 0;         // Cuenta las veces que completó el patrón en 8
  private int idasHorizontales = 0;    // Cuenta los ciclos de movimiento horizontal

  // Constructor: configura tamaño, velocidad, vida y puntos
  public AvionEnemigoJefeFinal(float x, float y) {
    super(x, y, 60, 1.2, 500, 6000);
  }

  // Dibuja el jefe final y su barra de vida
  public void dibujar() {
    if (!isAlive) return;

    int ancho = 120;
    int alto = 80;
    imageMode(CENTER);
    image(boss, this.posicion.x, this.posicion.y, ancho, alto);

    // Barra de vida sobre el jefe
    float barraAncho = 150;
    float barraAltura = 12;
    float porcentaje = this.hp / vidaMax;
    float barraX = this.posicion.x;
    float barraY = this.posicion.y - (alto / 2) - 25;

    // Fondo gris
    noStroke();
    fill(50);
    rect(barraX, barraY, barraAncho, barraAltura, 5);

    // Color de vida según porcentaje
    if (porcentaje > 0.5) fill(0, 255, 0);
    else if (porcentaje > 0.25) fill(255, 200, 0);
    else fill(255, 0, 0);
    rect(barraX, barraY, barraAncho * porcentaje, barraAltura, 5);

    // Borde blanco
    noFill();
    stroke(255);
    rect(barraX, barraY, barraAncho, barraAltura, 5);
  }

  // Mueve el jefe solo cuando su tiempo de activación lo permite
  public void mover() {
    if (millis() - tiempoInicioNivel < tiempoActivacion) return;
    go();
  }

  // Controla las diferentes fases de movimiento del jefe
  public void go() {
    float alturaBase = 100;

    // Activa modo furia cuando tiene menos del 30% de vida
    if (!modoFuria && this.hp <= vidaMax * 0.3) {
      modoFuria = true;
      this.velocidad *= 2;
    }

    switch (fase) {
      case 1: // Entrada inicial descendente
        this.posicion = recorrido.curvaJefeEntrada(this.getVel(), alturaBase);
        if (this.posicion.y >= alturaBase) {
          fase = 2;
          invulnerable = false; // Ahora puede recibir daño
        }
        break;

      case 2: // Movimiento en forma de “8”
        this.posicion = recorrido.curvaJefeOcho(this.getVel(), alturaBase);
        if (recorrido.completoOcho()) {
          vueltasOcho++;
          if (vueltasOcho >= 3) { // Pasa a la siguiente fase tras 3 repeticiones
            vueltasOcho = 0;
            fase = 3;
          }
        }
        break;

      case 3: // Movimiento horizontal de lado a lado
        this.posicion = recorrido.curvaHorizontal(this.getVel(), alturaBase);
        if (recorrido.cicloHorizontal()) {
          idasHorizontales++;
          if (idasHorizontales >= 2) { // Regresa al patrón en 8
            idasHorizontales = 0;
            fase = 2;
          }
        }
        break;
    }
  }

  // Lógica de disparo adaptada a la fase y al modo furia
  public void disparar() {
    if (!isAlive || invulnerable) return;

    int tiempoActual = millis();
    float jugadorX = partida.getJugador().getX();
    float jugadorY = partida.getJugador().getY();

    if (tiempoActual - tiempoUltimoDisparo < delayDisparo) return;

    switch (fase) {
      case 2:
        // Disparos más rápidos en modo furia
        disparoDobleHaciaJugador(jugadorX, jugadorY);
        delayDisparo = modoFuria ? 450 : 750;
        break;

      case 3:
        // Alterna entre disparo dirigido y el normal hacia abajo
        if (modoFuria) {
          disparoDobleHaciaJugador(jugadorX, jugadorY);
          delayDisparo = 550;
        } else {
          disparoQuintupleRecto();
          delayDisparo = 900;
        }
        break;
    }

    tiempoUltimoDisparo = tiempoActual;
  }

  // Dispara dos proyectiles hacia el jugador
  private void disparoDobleHaciaJugador(float jugadorX, float jugadorY) {
    PVector dir = new PVector(jugadorX - this.posicion.x, jugadorY - this.posicion.y);

    // Evita que el vector sea puramente vertical
    if (abs(dir.x) < 5) dir.x = dir.x < 0 ? -5 : 5;

    dir.normalize();
    dir.mult(3); // Velocidad de las balas

    // Crea dos disparos 
    for (int offset : new int[]{-15, 15}) {
      partida.crearBalasEnemigas(
        this.posicion.x + offset,
        this.posicion.y + 40,
        dir.x,  
        dir.y,
        5, 9, 33.4
      );
    }
  }

  // Dispara cinco balas rectas hacia abajo 
  private void disparoQuintupleRecto() {
    for (int offset : new int[]{-40, -20, 0, 20, 40}) {
      partida.crearBalasEnemigas(
        this.posicion.x + offset,
        this.posicion.y + 50,
        0, 1,
        10, 9, 33.4
      );
    }
  }

  // Evita recibir daño si está en modo invulnerable
  void restarVida(float i) {
    if (invulnerable) return;
    this.hp -= i;
  }
}
