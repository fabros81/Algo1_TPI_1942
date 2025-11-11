class AvionEnemigoRojo extends AvionEnemigo
{
  // Constructor: configura tamaño, velocidad, vida y puntos del enemigo rojo
  public AvionEnemigoRojo(float x, float y) {
    super(x, y, 20, 2, 20, 100);
  }

  // Dibuja el avión solo después de su tiempo de activación
  public void dibujar() {
    if (this.tiempoActivacion + this.tiempoInicioNivel < millis()) {
      if (!isAlive) return;

      fill(255, 0, 0);
      image(enemigoR, this.posicion.x, this.posicion.y, this.radio, this.radio);
    }
  }

  // Actualiza posición y elimina al enemigo si sale de pantalla
  public void mover() {
    this.go();

    // Si pasa el borde inferior, se considera destruido
    if (this.posicion.y > height - 50) murio();
  }

  // Define el movimiento según el tipo de curva asignada
  void go() {
    // Espera hasta que se cumpla su tiempo de activación
    if (millis() - this.tiempoInicioNivel < this.tiempoActivacion) return;

    switch (this.curva) {
      case "diag":
        this.posicion = this.recorrido.diag(this.getX(), this.getY(), this.getVel());
        break;

      case "diagInv":
        this.posicion = this.recorrido.diagInv(this.getX(), this.getY(), this.getVel());
        break;

      case "parabolaParametrica":
        this.posicion = this.recorrido.parabolaParametrica(this.getX(), this.getY(), this.getVel());
        break;

      case "parabolaParametricaInv":
        this.posicion = this.recorrido.parabolaParametricaInv(this.getX(), this.getY(), this.getVel());
        break;

      case "rectaHorizontal":
        this.posicion = this.recorrido.rectaHorizontal(this.getX(), this.getY(), this.getVel());
        break;
    }
  }

  // Dispara proyectiles hacia abajo con un delay aleatorio
  public void disparar() {
    if (!isAlive) return;
    if (this.posicion.y > 10) { // dispara solo si está visible
      int tiempoActual = millis();

      if (tiempoActual - tiempoUltimoDisparo >= delayDisparo) {
        partida.crearBalasEnemigas(this.posicion.x, this.posicion.y, 0, 1, 5, 9, 33.4);
        tiempoUltimoDisparo = tiempoActual;
        delayDisparo = int(random(1000, 4000)); // nuevo delay aleatorio entre disparos
      }
    }
  }
}
