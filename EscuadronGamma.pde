public class EscuadronGamma extends Escuadron {

  // Constructor: vincula el escuadrón con la partida actual
  public EscuadronGamma(Partida p) {
    super(p);
  }

  // Crea enemigos rojos con trayectoria parabólica invertida (de derecha a izquierda)
  public void añadirEnemigo(int cant) {
    if (cant <= 0) {
      println("Advertencia: La cantidad de enemigos debe ser mayor a cero.");
      return;
    }

    for (int i = 0; i < cant; i++) {
      AvionEnemigoRojo e = new AvionEnemigoRojo(750, 0);
      e.setPartida(this.partida);
      e.setCurva("parabolaParametricaInv");
      e.setTiempoInicioNivel(millis());
      this.enemigos.add(e);
    }

    // Registra los enemigos generados en la lista de enemigos
    partida.getListaEnemigos().addAll(this.enemigos);
  }

  // Activa los enemigos del escuadrón con una ligera demora entre cada uno
  public void mandar(float tAct) {
    int cont = 0;
    for (AvionEnemigoRojo e : this.enemigos) {
      cont += 1;
      e.setTiempoActivacion(tAct + cont * 500); // retardo de 0.5s entre activaciones
    }
  }
}
