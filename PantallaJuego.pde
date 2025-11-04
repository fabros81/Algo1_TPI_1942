class PantallaJuego
{
  private Partida partida;
  private GameManager gm;
  private PFont fontUI;
  private PFont fontNumeros;
  PantallaJuego(GameManager gm)
  {
    this.gm = gm;
    
    // Usar misma fuente que pantalla de estadísticas
    this.fontUI = createFont("data/fonts/PressStart2P-Regular.ttf", 12);
    this.fontNumeros = createFont("data/fonts/PressStart2P-Regular.ttf", 16);
  }
  
  void dibujar()
  {
    // Fondo completamente negro
    background(0);
    
    // Dibujar elementos del juego
    if (partida != null) {
      this.partida.dibujar();
    }
    
    // Interfaz de usuario minimalista
    dibujarUI();

    //Pantalla de transicion entre niveles
    dibujarPantallaNivel();
  }
  
  void dibujarUI() {
    if (partida == null || partida.jugador == null) return;
    
    pushStyle();
    
    // Panel superior simple
    dibujarPanelSuperior();
    
    // Información básica del jugador
    dibujarInfoJugador();
    
    // Indicadores de power-ups
    dibujarIndicadoresPowerUps();
    
    popStyle();
  }
  
  void dibujarPanelSuperior() {
    // Solo texto blanco con fuente PressStart2P
    fill(255);
    textFont(fontNumeros);
    textAlign(LEFT, TOP);
    
    // Puntaje
    String puntajeTexto = "PUNTOS: " + nf(partida.getPuntos(), 0, 0);
    text(puntajeTexto, 20, 20);
    
    // Tiempo de juego
    int tiempoTranscurrido = partida.getDuracion() / 1000;
    int minutos = tiempoTranscurrido / 60;
    int segundos = tiempoTranscurrido % 60;
    textAlign(RIGHT, TOP);
    text("TIEMPO: " + nf(minutos, 2) + ":" + nf(segundos, 2), width - 20, 20);
    
    // Nivel actual
    textAlign(CENTER, TOP);
    text("NIVEL " + partida.nivel, width/2, 20);
  }
  
  void dibujarInfoJugador() {
    float infoX = 20;
    float infoY = height - 40;
    
    textFont(fontUI);
    textAlign(LEFT, TOP);
    fill(255);
    
    // Salud del jugador
    float salud = partida.jugador.getHp();
    text("VIDA: %" + nf(salud, 1, 0), infoX, infoY);
  }
  
  void dibujarIndicadoresPowerUps() {
    float powerX = width - 180;
    float powerY = 60;
    
    textFont(fontUI);
    textAlign(LEFT, TOP);
    fill(255);
    
    // Multidisparo
    if (partida.jugador.getMultidisparoActivo()) {
      text("MULTIDISPARO", powerX, powerY);
    }
    
    // Instakill
    if (partida.jugador.getInstakillActivo()) {
      text("INSTAKILL", powerX, powerY + 20);
    }
    
    // Escudo
    if (partida.jugador.getEscudoActivo()) {
      text("ESCUDO", powerX, powerY + 40);
    }
  }
  
  void actualizar()
  {
    if (this.partida != null) {
      this.partida.actualizar();
    }
  }
  
  void setPartida(Partida partida) {
    this.partida = partida;
  }

  public void dibujarPantallaNivel(){
    if (this.partida.getMostrandoPantallaNivel())
    {
      background(0);
      fill(255);
      text("NIVEL " + this.partida.getNivel(), width / 2, height / 2);
      this.partida.getJugador().dibujar();
      if (millis() - this.partida.getTiempoTransicionNivel() > 2000) {
        this.partida.setMostrandoPantallaNivel(false);
      }
      return; // stop here so nothing else is drawn
    }
  }
}
