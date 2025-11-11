public class EscuadronFinal extends Escuadron {

  // Constructor: vincula el escuadrón con la partida actual
  public EscuadronFinal(Partida p) {
    super(p);
  }

  // Crea el jefe final (solo se permite uno)
  public void añadirEnemigo(int cant) {
    if (cant != 1) {
      println("Advertencia: La cantidad de enemigos debe ser 1.");
      return;
    }

    AvionEnemigoJefeFinal e = new AvionEnemigoJefeFinal(400, -200);
    e.setPartida(this.partida);
    e.setTiempoInicioNivel(millis());

    // Se agrega directamente a la lista de enemigos
    partida.getListaEnemigos().add(e);
  }

  // Activa el jefe final 
  public void mandar(float tAct) {
    for (AvionEnemigoRojo e : enemigos) {
      e.setTiempoActivacion(tAct);
    }
  }
}
