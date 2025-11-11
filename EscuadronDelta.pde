public class EscuadronDelta extends Escuadron {

  // Constructor: vincula el escuadrón con la partida actual
  public EscuadronDelta(Partida p) {
    super(p);
  }

  // Crea enemigos rojos que siguen una trayectoria parabólica
  public void añadirEnemigo(int cant) {
    if (cant <= 0) {
      println("Advertencia: La cantidad de enemigos debe ser mayor a cero.");
      return;
    }

    for (int i = 0; i < cant; i++) {
      AvionEnemigoRojo e = new AvionEnemigoRojo(100, -20);
      e.setPartida(this.partida);
      e.setCurva("parabolaParametrica");
      e.setTiempoInicioNivel(millis());
      this.enemigos.add(e);
    }

    // Añade los enemigos del escuadrón a la lista general de la partida
    partida.getListaEnemigos().addAll(this.enemigos);
  }

  // Activa los enemigos uno tras otro, con un retardo progresivo
  public void mandar(float tAct) {
    int cont = 0;
    for (AvionEnemigoRojo e : this.enemigos) {
      cont += 1;
      e.setTiempoActivacion(tAct + cont * 500); // intervalo de 0.5s entre cada enemigo
    }
  }
}
