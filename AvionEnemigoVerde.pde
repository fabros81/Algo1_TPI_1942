class AvionEnemigoVerde extends AvionEnemigo
{
  // Control del tiempo de aparición en pantalla
  private float tiempoActivacion;
  private float tiempoInicioNivel;

  // Constructor: enemigo más rápido pero con poca vida y puntaje bajo
  public AvionEnemigoVerde(int x, int y) {
    super(x, y, 15, 4.5, 10, 50);
    this.tiempoActivacion = 0;
    this.tiempoInicioNivel = 0;
  }

  // Dibuja el avión verde si está vivo
  public void dibujar() {
    if (!isAlive) return;
    fill(0, 255, 0);
    image(enemigoV, this.posicion.x, this.posicion.y, this.radio, this.radio);
  }

  // Movimiento simple: baja en línea recta y desaparece al salir del borde inferior
  public void mover() {
    go();
    if (this.posicion.y > height + 30) murio();
  }

  // Movimiento lineal vertical controlado por tiempo de activación
  public void go() {
    if (millis() - this.tiempoInicioNivel < this.tiempoActivacion) return;
    this.posicion = new PVector(this.posicion.x, this.posicion.y + this.getVel());
  }

  // Este tipo de enemigo no dispara
  public void disparar() { }

  // Setters de tiempo de aparición
  public void setTiempoInicioNivel(float t) { this.tiempoInicioNivel = t; }
  public void setTiempoActivacion(float t) { this.tiempoActivacion = t; }
}
