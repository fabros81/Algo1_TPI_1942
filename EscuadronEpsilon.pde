public class EscuadronEpsilon extends Escuadron {

  // Constructor: asocia el escuadrón con la partida actual
  public EscuadronEpsilon(Partida p) {
    super(p);
  }

  // Crea enemigos rojos alineados horizontalmente
  public void añadirEnemigo(int cant) {
    if (cant <= 0) {
      println("Advertencia: La cantidad de enemigos debe ser mayor a cero.");
      return;
    }

    for (int i = 0; i < cant; i++) {
      AvionEnemigoRojo e = new AvionEnemigoRojo(100 + i * 100, 0);
      e.setPartida(this.partida);
      e.setCurva("rectaHorizontal");
      e.setTiempoInicioNivel(millis());
      this.enemigos.add(e);
    }

    // Registra los enemigos creados en la lista global de la partida
    partida.getListaEnemigos().addAll(this.enemigos);
  }

  // Crea dos líneas de enemigos simétricas (efecto espejo)
  public void añadirEnemigoEspejo(int cant) {
    if (cant <= 0) {
      println("Advertencia: La cantidad de enemigos debe ser mayor a cero.");
      return;
    }

    for (int i = 0; i < cant; i++) {
      // Primera línea (izquierda a derecha)
      AvionEnemigoRojo e = new AvionEnemigoRojo(100 + i * 100, 0);
      e.setPartida(this.partida);
      e.setCurva("rectaHorizontal");
      e.setTiempoInicioNivel(millis());
      this.enemigos.add(e);

      // Segunda línea espejo (derecha a izquierda)
      AvionEnemigoRojo e2 = new AvionEnemigoRojo(700 - i * 100, 0);
      e2.setPartida(this.partida);
      e2.setCurva("rectaHorizontal");
      e2.setTiempoInicioNivel(millis());
      this.enemigos.add(e2);
    }

    // Añade todos los enemigos del escuadrón a la lista de la partida
    partida.getListaEnemigos().addAll(this.enemigos);
  }

  // Activa todos los enemigos del escuadrón simultáneamente
  public void mandar(float tAct) {
    for (AvionEnemigoRojo e : this.enemigos) {
      e.setTiempoActivacion(tAct);
    }
  }
}
