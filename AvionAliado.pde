class AvionAliado extends Avion
{
  // Atributos principales
  private GameManager gm;
  private float puntaje = 0.0;
  private int vidas = 3;

  // Disparo delay
  private int tiempoUltimoDisparo = 0;  // Último disparo realizado
  private int delayDisparo = 300;       // Tiempo mínimo entre disparos (ms)

  // Power-ups estado
  private PowUp powUp;
  private boolean multidisparoActivo = false;
  private boolean instakillActivo = false;
  private boolean escudoActivo = false;
  private int tiempoMultidisparo;
  private int tiempoInstakill;
  private int duracionPowUp = 5000;

  // Invulnerabilidad temporal
  private boolean invulnerable = false;
  private int tiempoInvulnerableInicio = 0;
  private int duracionInvulnerable = 2000;

  // Constructor
  public AvionAliado(GameManager gm, float x, float y) {
    super(x, y, 40, 5, 100);
    this.gm = gm;
  }

  // ───────────────────────────────────────────────────────────────
  // Dibujo y actualización visual
  // ───────────────────────────────────────────────────────────────
  public void dibujar() {
    if (!isAlive) return;
    if (invulnerable && (millis() / 100) % 2 == 0) return; // efecto parpadeo

    if (escudoActivo) {
      fill(255, 200, 0);
      circle(this.posicion.x, this.posicion.y, this.radio + 1);
    }

    image(avionJugadorGIF, this.posicion.x, this.posicion.y, this.radio, this.radio);
    dibujarBarraSalud();
  }

  private void dibujarBarraSalud() {
    float barAncho = 46;
    float barAltura = 6;
    float x = this.posicion.x;
    float y = this.posicion.y + this.radio;

    float porcentajeSalud = constrain(this.hp / 100, 0, 1);

    int green = color(0, 200, 0);
    int yellow = color(255, 200, 0);
    int red = color(255, 0, 0);

    int fillCol = (porcentajeSalud >= 0.5)
        ? lerpColor(yellow, green, map(porcentajeSalud, 0.5, 1, 0, 1))
        : lerpColor(red, yellow, map(porcentajeSalud, 0, 0.5, 0, 1));

    pushStyle();
    noStroke();
    fill(GRAY);
    rect(x, y, barAncho, barAltura, 2);
    fill(fillCol);
    rect(x, y, barAncho * porcentajeSalud, barAltura, 2);
    popStyle();
  }

  // ───────────────────────────────────────────────────────────────
  // Movimiento y disparo
  // ───────────────────────────────────────────────────────────────
  public void mover() {
    if (!isAlive) return;

    if (gm.getLeftPressed()) this.posicion.x -= this.velocidad;
    if (gm.getRightPressed()) this.posicion.x += this.velocidad;
    if (gm.getUpPressed()) this.posicion.y -= this.velocidad;
    if (gm.getDownPressed()) this.posicion.y += this.velocidad;

    this.posicion.x = constrain(this.posicion.x, 30, width - 30);
    this.posicion.y = constrain(this.posicion.y, 30, height - 30);
  }

  public void disparar() {
    int tiempoActual = millis();
    if (!isAlive) return;

    if (gm.spacePressed && tiempoActual - tiempoUltimoDisparo >= delayDisparo) {
      if (multidisparoActivo) {
        // Dispara en 8 direcciones
        gm.getPartida().crearBalasAliadas(this.posicion.x, this.posicion.y, 0, -1, 8, 9, 10);
        gm.getPartida().crearBalasAliadas(this.posicion.x, this.posicion.y, 0, 1, 8, 9, 10);
        gm.getPartida().crearBalasAliadas(this.posicion.x, this.posicion.y, 1, 0, 8, 9, 10);
        gm.getPartida().crearBalasAliadas(this.posicion.x, this.posicion.y, -1, 0, 8, 9, 10);
        gm.getPartida().crearBalasAliadas(this.posicion.x, this.posicion.y, -1, 1, 8, 9, 10);
        gm.getPartida().crearBalasAliadas(this.posicion.x, this.posicion.y, 1, 1, 8, 9, 10);
        gm.getPartida().crearBalasAliadas(this.posicion.x, this.posicion.y, -1, -1, 8, 9, 10);
        gm.getPartida().crearBalasAliadas(this.posicion.x, this.posicion.y, 1, -1, 8, 9, 10);
        actualizarMultidisparo();
      } else if (instakillActivo) {
        // Disparo potenciado
        gm.getPartida().crearBalasAliadas(this.posicion.x, this.posicion.y, 0, -1, 8, 9, 1000);
        actualizarInstakill();
      } else {
        // Disparo normal doble
        gm.getPartida().crearBalasAliadas(this.posicion.x - 10, this.posicion.y, 0, -1, 8, 9, 10);
        gm.getPartida().crearBalasAliadas(this.posicion.x + 10, this.posicion.y, 0, -1, 8, 9, 10);
      }
      tiempoUltimoDisparo = tiempoActual;
    }
  }

  // ───────────────────────────────────────────────────────────────
  // Vida e invulnerabilidad
  // ───────────────────────────────────────────────────────────────
  public void perderVida() {
    if (this.vidas > 1) {
      this.vidas -= 1;
      this.hp = 100;
    } else {
      this.murio();
    }
  }

  void activarInvulnerabilidad() {
    invulnerable = true;
    tiempoInvulnerableInicio = millis();
  }

  void actualizarInvulnerabilidad() {
    if (invulnerable && millis() - tiempoInvulnerableInicio > duracionInvulnerable)
      invulnerable = false;
  }

  // ───────────────────────────────────────────────────────────────
  // Power-ups
  // ───────────────────────────────────────────────────────────────
  public void activarMultidisparo() {
    this.multidisparoActivo = true;
    this.tiempoMultidisparo = millis();
  }

  public void actualizarMultidisparo() {
    if (multidisparoActivo && millis() - tiempoMultidisparo > duracionPowUp)
      multidisparoActivo = false;
  }

  public void activarInstakill() {
    this.instakillActivo = true;
    this.tiempoInstakill = millis();
  }

  public void actualizarInstakill() {
    if (instakillActivo && millis() - tiempoInstakill > duracionPowUp)
      instakillActivo = false;
  }
  // sumar puntos
  public void sumarPuntos(float i){this.puntaje += i;}

  // ───────────────────────────────────────────────────────────────
  // Getters y setters
  // ───────────────────────────────────────────────────────────────
  public void setPos(float x, float y) {
    this.posicion.x = x;
    this.posicion.y = y;
  }

  public void setPowUp(PowUp i) { this.powUp = i; }
  public void setEscudo(boolean i) { this.escudoActivo = i; }

  public float getPuntaje() { return this.puntaje; }
  public float getHp() { return this.hp; }
  public float getVelocidad() { return this.velocidad; }
  public int getVidas() { return this.vidas; }
  public boolean getInvulnerable() { return this.invulnerable; }
  public PowUp getPowUp() { return this.powUp; }
  public boolean getEscudoActivo() { return this.escudoActivo; }
  public boolean getMultidisparoActivo() { return this.multidisparoActivo; }
  public boolean getInstakillActivo() { return this.instakillActivo; }
}
