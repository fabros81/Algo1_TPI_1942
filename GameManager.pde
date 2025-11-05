class GameManager {
  // ─── INPUT ────────────────────────────────────────────
  private boolean leftPressed = false;
  private boolean rightPressed = false;
  private boolean upPressed = false;
  private boolean downPressed = false;
  private boolean spacePressed = false;
  private String playerID; 


  // ─── ESTADO DEL JUEGO ─────────────────────────────────
  private int estado; // 0 = menú, 1 = jugando, 2 = fin, 3 = estadísticas
  
  PantallaInicial menu;
  PantallaJuego juego;
  PantallaFinal fin;
  PantallaEstadistica estadisticas;

  private Partida partida;

  // ─── CONSTRUCTOR ──────────────────────────────────────
  GameManager() {
    this.menu = new PantallaInicial(this);
    this.juego = new PantallaJuego(this);
    this.fin = new PantallaFinal(this);
    this.estadisticas = new PantallaEstadistica(this);
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
    }
  }

  // ─── PARTIDA ─────────────────────────────────────────
  public void iniciarPartida() {
    this.partida = new Partida(this);
    this.juego.setPartida(this.partida);
    this.estado = 1;
  }

  // ─── INPUT ────────────────────────────────────────────
  public void keyPressed() 
  {
    
      if (keyCode == LEFT) this.leftPressed = true;
      if (keyCode == RIGHT) this.rightPressed = true;
      if (keyCode == UP) this.upPressed = true;
      if (keyCode == DOWN) this.downPressed = true;
      if (key == ' ') this.spacePressed = true;

      if (this.estado == 0 && this.spacePressed)
      {
        if (this.menu.isIngresandoID()) {
          this.menu.keyPressed();
        } else {
          switch(this.menu.getPosicionFlecha()){
            case 0:
              this.menu.iniciarIngresoID(); 
              break;
            case 1:
              // implementar 2 jugadores
              break;
            case 2:
              this.estado = 3; // ir a estadísticas
              break;           
          }
        }
      }
      if (this.estado == 0 && this.menu.isIngresandoID() && (key == TAB || key == BACKSPACE)) {
        this.menu.keyPressed();
      }
    
    if ((this.estado == 2 || this.estado == 3) && key == 'r') 
    {
      this.menu.resetearEstado();
      this.estado = 0; 
    }
  }
  public void keyTyped() {
    if (this.estado == 0 && this.menu.isIngresandoID()) {
      this.menu.keyTyped();
    }
  }

  public void keyReleased() {
    if (keyCode == LEFT) this.leftPressed = false;
    if (keyCode == RIGHT) this.rightPressed = false;
    if (keyCode == UP) this.upPressed = false;
    if (keyCode == DOWN) this.downPressed = false;
    if (key == ' ') this.spacePressed = false;
    
    
  }

  // ─── GETTERS ─────────────────────────────────────────
  public boolean getLeftPressed() { return this.leftPressed; }
  public boolean getRightPressed() { return this.rightPressed; }
  public boolean getUpPressed() { return this.upPressed; }
  public boolean getDownPressed() { return this.downPressed; }
  public boolean getSpacePressed() { return this.spacePressed; }
  public Partida getPartida() {return this.partida;}
  public String getPlayerId(){return this.playerID;}
   // ─── SETTERS ─────────────────────────────────────────
  public void setPlayerID(String id) { this.playerID = id; }

}
