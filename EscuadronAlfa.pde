public class EscuadronAlfa extends Escuadron {

  // Constructor: asocia el escuadrón a la partida actual
  public EscuadronAlfa(Partida p) {
    super(p);
  }

  // Crea y añade una cantidad determinada de enemigos al escuadrón
  public void añadirEnemigo(int cant) {
    if (cant <= 0) {
      println("Advertencia: La cantidad de enemigos debe ser mayor a cero.");
      return;
    }

    // Genera enemigos rojos en posiciones diagonales hacia abajo
    for (int i = 0; i < cant; i++) {
      AvionEnemigoRojo e = new AvionEnemigoRojo((-80) - (i * 60), -120 * i * 0.5);
      e.setPartida(this.partida);
      e.setCurva("diag");
      e.setTiempoInicioNivel(millis());
      this.enemigos.add(e);
    }

    // Añade los enemigos creados a la lista global de la partida
    partida.getListaEnemigos().addAll(this.enemigos);
  }

  // Define el tiempo de activación para todos los enemigos del escuadrón
  public void mandar(float tAct) {
    for (AvionEnemigoRojo e : enemigos) {
      e.setTiempoActivacion(tAct);
    }
  }
}
