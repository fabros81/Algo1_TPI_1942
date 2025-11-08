class AvionEnemigoJefeFinal extends AvionEnemigo {
  private int fase = 1;
  private float vidaMax = this.hp;
  private float hpActual = vidaMax;

  private float tiempoUltimoDisparo = 0;
  private float delayDisparo = 1500;
  private boolean invulnerable = true;
  private boolean modoFuria = false;

  private int vueltasOcho = 0;
  private int idasHorizontales = 0;



  public AvionEnemigoJefeFinal(float x, float y) {
    //super(x, y, 60, 1.2, 500, 1000);
    super(x, y, 60, 1.2, 200, 1000);
  }

  public void dibujar() {
    if (!isAlive) return;

    int ancho = 120;
    int alto = 80 ;
    // --- cuerpo del jefe ---
    imageMode(CENTER);
    image(boss, this.posicion.x, this.posicion.y, ancho, alto);

    // --- barra de vida ---
    float barraAncho = 150;
    float barraAltura = 12;
    float porcentaje = this.hp / vidaMax;
    float barraX = this.posicion.x;
    float barraY = this.posicion.y - (alto / 2) - 25;

    // fondo
    noStroke();
    fill(50);
    rect(barraX, barraY, barraAncho, barraAltura, 5);
    // vida
    if (porcentaje > 0.5) fill(0, 255, 0);
    else if (porcentaje > 0.25) fill(255, 200, 0);
    else fill(255, 0, 0);
    rect(barraX, barraY, barraAncho * porcentaje, barraAltura, 5);
    // borde
    noFill();
    stroke(255);
    rect(barraX, barraY, barraAncho, barraAltura, 5);
  }

  public void mover() {
    if (millis() - tiempoInicioNivel < tiempoActivacion) return;
    go();
  }

  public void go() {
    float alturaBase = 100;

    if (!modoFuria && this.hp <= vidaMax * 0.3) {
      modoFuria = true;
      this.velocidad = this.velocidad * 2;
    }

    switch(fase) {
      case 1: // ENTRADA LENTA
        this.posicion = recorrido.curvaJefeEntrada(this.getVel(), alturaBase);
        if (this.posicion.y >= alturaBase) {
          fase = 2;
          invulnerable = false;
        }
        break;

      case 2: // MOVIMIENTO EN 8
        this.posicion = recorrido.curvaJefeOcho(this.getVel(), alturaBase);
        if (recorrido.completoOcho()) {
          vueltasOcho++;
          if (vueltasOcho >= 3) { //ajustar este valor para más o menos repeticiones
            vueltasOcho = 0;
            fase = 3;
          }
        }
        break;

      case 3: // MOVIMIENTO Horizontal
        this.posicion = recorrido.curvaHorizontal(this.getVel(), alturaBase);
        if (recorrido.cicloHorizontal()) {
          idasHorizontales++;
          if (idasHorizontales >= 2) { //ajustar este valor para más o menos repeticiones
            idasHorizontales = 0;
            fase = 2; 
          }
        }
        break;
    }
  }

  public void disparar() {
    if (!isAlive || invulnerable) return;
    int tiempoActual = millis();
    float jugadorX = partida.getJugador().getX();
    float jugadorY = partida.getJugador().getY();

    if (tiempoActual - tiempoUltimoDisparo < delayDisparo) return;

    switch(fase) {
      case 2:
        if (modoFuria) {
          disparoDobleHaciaJugador(jugadorX,jugadorY);
          delayDisparo = 450;
        }
        else {
          disparoDobleHaciaJugador(jugadorX, jugadorY);
          delayDisparo = 750;
        }
        break;
      case 3:
        if (modoFuria) {
          disparoDobleHaciaJugador(jugadorX, jugadorY);
          delayDisparo = 550;
        }
        else{
          disparoQuintupleRecto();
          delayDisparo = 900;
        }
        break;
    }
    tiempoUltimoDisparo = tiempoActual;
  }

  private void disparoDobleHaciaJugador(float jugadorX, float jugadorY) {
    // Calcular dirección al jugador
    PVector dir = new PVector(jugadorX - this.posicion.x, jugadorY - this.posicion.y);

    // Evitar ángulos puramente verticales
    if (abs(dir.x) < 5) {
        dir.x = dir.x < 0 ? -5 : 5;
    }

    dir.normalize();
    dir.mult(3); // ajustar velocidad de las balas

    // Disparo doble con leve separación lateral
    for (int offset : new int[]{-15, 15}) {
        partida.crearBalasEnemigas(
            this.posicion.x + offset,
            this.posicion.y + 40,
            dir.x,  
            dir.y,
            5, 9, 1
        );
    }
}


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
  void restarVida(float i){
    if (invulnerable) return;
    this.hp -= i;
    }

  public boolean getModoFuria() {
    return this.modoFuria;
  }

}