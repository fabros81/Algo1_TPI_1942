class GameManager {
  // ─── INPUT ────────────────────────────────────────────
  private boolean leftPressed = false;
  private boolean rightPressed = false;
  private boolean upPressed = false;
  private boolean downPressed = false;
  private boolean spacePressed = false;
  private String playerID; 
  private boolean kPressed = false; 
  private boolean kPressedThisFrame = false;
<<<<<<< HEAD
  boolean altPresionado = false;
=======

>>>>>>> origin/main

  // ─── ESTADO DEL JUEGO ─────────────────────────────────
  private int estado; // 0 = menú, 1 = jugando, 2 = fin, 3 = estadísticas
  
  private PantallaInicial menu;
  private PantallaJuego juego;
  private PantallaFinal fin;
  private PantallaEstadistica estadisticas;
<<<<<<< HEAD
  private PantallaRanking ranking;
=======

>>>>>>> origin/main
  private Partida partida;
  private boolean partidaGanada = false; 
  // ─── CONSTRUCTOR ──────────────────────────────────────
  GameManager() {
    this.menu = new PantallaInicial(this);
    this.juego = new PantallaJuego(this);
    this.fin = new PantallaFinal(this);
    this.estadisticas = new PantallaEstadistica(this);
<<<<<<< HEAD
    this.ranking = new PantallaRanking(this);
=======
>>>>>>> origin/main
    this.estado = 0; // empieza en menú
  }

  // ─── CICLO PRINCIPAL ─────────────────────────────────
  void actualizar() {
    switch (this.estado) {
      case 0:
        this.menu.actualizar();
        
        break;
      case 1:
        if (partida != null) this.juego.actualizar();
        break;
      case 2:
        this.fin.actualizar();
        break;
      case 3:
        this.estadisticas.actualizar();
        break;
<<<<<<< HEAD
      case 4: 
        this.ranking.actualizar();
        break;
=======
>>>>>>> origin/main
    }
  }

  void dibujar() {
    switch (this.estado) {
      case 0:
        this.menu.dibujar();
        
        break;
      case 1:
        if (partida != null) this.juego.dibujar();
        break;
     case 2:
        this.fin.dibujar();
        break;
      case 3:
        this.estadisticas.dibujar();
        break;
<<<<<<< HEAD
      case 4: 
        this.ranking.dibujar();
        break;
=======
>>>>>>> origin/main
    }
  }

  // ─── PARTIDA ─────────────────────────────────────────
  public void iniciarPartida() {
    this.partida = new Partida(this);
    this.juego.setPartida(this.partida);
    this.estado = 1;
    this.partidaGanada = false; 
  }
  //MODIFICACION TEO
  public void finalizarPartida(boolean ganada) {
    this.partidaGanada = ganada;
<<<<<<< HEAD
    //this.fin.resetearEstado();
=======
    if (this.partida != null) {
      this.partida.guardarEstadisticas(); 
    }
    this.fin.resetearEstado();   
>>>>>>> origin/main
    this.estado = 2; // Ir a pantalla final
  }

  // ─── INPUT ────────────────────────────────────────────
  public void keyPressed() 
  {
    
    if (keyCode == LEFT) this.leftPressed = true;
    if (keyCode == RIGHT) this.rightPressed = true;
    if (keyCode == UP) this.upPressed = true;
    if (keyCode == DOWN) this.downPressed = true;
    if (key == ' ') this.spacePressed = true;
    if (key == 'k' || key == 'K') {
        this.kPressed = true;
        this.kPressedThisFrame = true; // ← Solo true en el frame inicial
    }
    switch (estado) 
    {
      case 0: // MENÚ
        if (spacePressed) {
          if (menu.isIngresandoID()) {
            menu.keyPressed();
          } else {
            opcionSeleccionada("inicial", menu.getPosicionFlecha());
          }
        }
        if (menu.isIngresandoID() && (key == TAB || key == BACKSPACE)) {
          menu.keyPressed();
        }
        break;

      case 2: // FINAL
        if (spacePressed && this.fin.puedeRecibirInput()) {
          opcionSeleccionada("final", fin.getPosicionFlecha());
        }
        break;
      case 3: // ESTADÍSTICAS
<<<<<<< HEAD
        if (key == 'r') {
          menu.resetearEstado();
          estado = 0;
        }
        break;
    }
    if (keyCode == ALT) {
    altPresionado = true;
  }
     if (altPresionado && (key== 'g' || key=='G')) {
        resetearDatosGlobal();}
=======
        this.estadisticas.keyPressed();
        break;
    }
>>>>>>> origin/main
  }
  public void keyTyped() {
    if (this.estado == 0 && this.menu.isIngresandoID()) {
      this.menu.keyTyped();
    }
<<<<<<< HEAD
  }
void resetearDatosGlobal() {
    Table tablaVacia = new Table();
    tablaVacia.addColumn("id");
    tablaVacia.addColumn("usuario");
    tablaVacia.addColumn("puntaje");
    tablaVacia.addColumn("tiempo");
    tablaVacia.addColumn("enemigos derrotados");
    tablaVacia.addColumn("enemigos rojos derrotados");
    tablaVacia.addColumn("enemigos verdes derrotados");
    tablaVacia.addColumn("precision disparo");
    
    saveTable(tablaVacia, "data/prueba.csv");
    println("=== DATOS RESETEADOS ===");
}
=======
    if (this.estado == 3 && this.estadisticas.isIngresandoID()) {
      this.estadisticas.keyTyped();
    }
  }
  
>>>>>>> origin/main

  public void keyReleased() {
    if (keyCode == LEFT) this.leftPressed = false;
    if (keyCode == RIGHT) this.rightPressed = false;
    if (keyCode == UP) this.upPressed = false;
    if (keyCode == DOWN) this.downPressed = false;
    if (key == ' ') this.spacePressed = false;
    if (key == 'k' || key == 'K') this.kPressed = false;
    
  }
  public void resetFrameInput() {
    this.kPressedThisFrame = false;
  }

  public void opcionSeleccionada(String pantalla, int opcion)
  {
    switch(pantalla) {
    case "inicial":
      if (opcion == -1) { // Iniciar partida con ID ingresado
          this.playerID = menu.getPlayerID();
          iniciarPartida();
      }else{
      switch(opcion) {
        case 0: // "1 jugador"
          menu.iniciarIngresoID();
          break;
        case 1: // "2 jugadores" (future)
          break;
        case 2: // "Ver estadísticas"
          estado = 3;
          break;
<<<<<<< HEAD
        case 3: 
          this.ranking.cargarDatos();
          estado = 4;   // 🚀 IR A LA PANTALLA RANKING
          break;
=======
>>>>>>> origin/main
      }
    }
      break;

    case "final":
      switch(opcion) {
        case 0: // Reintentar
          iniciarPartida();
          break;
        case 1: // Ver estadísticas
          estado = 3;
          break;
        case 2: // Menú principal
          menu.resetearEstado();
          estado = 0;
          break;
      }
      break;
<<<<<<< HEAD
=======
    case "estadisticas":
      switch(opcion) {
        case 0: // Volver al menú
          menu.resetearEstado();
          estado = 0;
          break;
      }
      break;
    
>>>>>>> origin/main
  }
}

  // ─── GETTERS ─────────────────────────────────────────
  public boolean getLeftPressed() { return this.leftPressed; }
  public boolean getRightPressed() { return this.rightPressed; }
  public boolean getUpPressed() { return this.upPressed; }
  public boolean getDownPressed() { return this.downPressed; }
  public boolean getSpacePressed() { return this.spacePressed; }
  public boolean getKPressed() { return this.kPressed; }
  public boolean getKPressedThisFrame() { return this.kPressedThisFrame; }
  public boolean getPartidaGanada() { return this.partidaGanada; }
  public Partida getPartida() {return this.partida;}
  public String getPlayerID(){return this.playerID;}
}
