public class EscuadronVerde extends Escuadron {

  // Lista específica de enemigos verdes del escuadrón
  private ArrayList<AvionEnemigoVerde> enemigos;

  // Constructor: vincula el escuadrón con la partida y prepara la lista de enemigos verdes
  public EscuadronVerde(Partida p) {
    super(p);
    this.enemigos = new ArrayList<AvionEnemigoVerde>();
  }

  // Crea enemigos verdes distribuidos aleatoriamente con una variación gaussiana
  public void añadirEnemigo(int cant) {
    if (cant <= 0) {
      println("Advertencia: La cantidad de enemigos debe ser mayor a cero.");
      return;
    }

    for (int j = 0; j < cant; j++) {
      // Posiciones aleatorias centradas en el medio de la pantalla
      int x = int(randomGaussian() * 100 + width / 2);
      int y = int(randomGaussian() * 100 - 600); // aparecen fuera de pantalla (parte superior)

      AvionEnemigoVerde e = new AvionEnemigoVerde(x, y);
      e.setPartida(this.partida);
      e.setCurva("gaussVertical"); // tipo de trayectoria vertical
      e.setTiempoInicioNivel(this.tiempoInicioNivel);
      this.enemigos.add(e);
    }

    // Añade todos los enemigos del escuadrón a la lista global de la partida
    partida.getListaEnemigos().addAll(this.enemigos);
  }

  // Activa los enemigos con una diferencia temporal progresiva
  public void mandar(float tAct) {
    int cont = 0;
    for (AvionEnemigoVerde e : this.enemigos) {
      cont += 1;
      e.setTiempoActivacion(tAct + cont * 800); // 0.8s entre activaciones
    }
  }
}
