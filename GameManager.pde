class GameManager {
  // ─── INPUT ────────────────────────────────────────────
  private boolean leftPressed = false;
  private boolean rightPressed = false;
  private boolean upPressed = false;
  private boolean downPressed = false;
  private boolean spacePressed = false;
  private boolean kPressed = false; 
  private boolean kPressedThisFrame = false;


  // ─── ESTADO DEL JUEGO ─────────────────────────────────
  private int estado; // 0 = menú, 1 = jugando, 2 = fin, 3 = estadísticas
  
  private PantallaInicial menu;
  private PantallaJuego juego;
  private PantallaFinal fin;
  private PantallaEstadistica estadisticas;

  private Partida partida;
  private boolean partidaGanada = false; 
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
    this.partidaGanada = false; 
  }
  //MODIFICACION TEO
  public void finalizarPartida(boolean ganada) {
    this.partidaGanada = ganada;
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

      if (this.estado == 0 && this.spacePressed)
      {
        switch(this.menu.getPosicionFlecha()){
          case 0:
            iniciarPartida(); //creo la partida y paso a jugar
            break;
          case 1:
          // implementar 2 jugadores
            break;
          case 2:
            this.estado = 3; // ir a estadísticas
            break;           
        }
        
      }
      
    
    if ((this.estado == 2 || this.estado == 3) && key == 'r') 
    {
      this.estado = 0; // volver al menú
    }
  }
  

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
}
