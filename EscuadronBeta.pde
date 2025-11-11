public class EscuadronBeta extends Escuadron {

  // Constructor: asocia el escuadrón a la partida actual
  public EscuadronBeta(Partida p) {
    super(p);
  }

  // Crea y añade enemigos rojos que entran desde el lado derecho en trayectoria diagonal
  public void añadirEnemigo(int cant) {
    if (cant <= 0) {
      println("Advertencia: La cantidad de enemigos debe ser mayor a cero.");
      return;
    }

    for (int i = 0; i < cant; i++) {
      AvionEnemigoRojo e = new AvionEnemigoRojo(820 + i * 60, -120 - i * 30);
      e.setPartida(this.partida);
      e.setCurva("diagInv");
      e.setTiempoInicioNivel(millis());
      this.enemigos.add(e);
    }

    // Registra todos los enemigos generados en la lista global de la partida
    partida.getListaEnemigos().addAll(this.enemigos);
  }

  // Configura el tiempo de activación para todos los enemigos del escuadrón
  public void mandar(float tAct) {
    for (AvionEnemigoRojo e : enemigos) {
      e.setTiempoActivacion(tAct);
    }
  }
}
