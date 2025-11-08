class PantallaJuego extends Pantalla
{
  private Partida partida;
<<<<<<< HEAD
  private GameManager gm;
=======
>>>>>>> origin/main
  private PFont fontUI;
  private PFont fontNumeros;
  PantallaJuego(GameManager gm)
  {
    super(gm);
    
    // Usar misma fuente que pantalla de estadísticas
    this.fontUI = createFont("data/fonts/PressStart2P-Regular.ttf", 12);
    this.fontNumeros = createFont("data/fonts/PressStart2P-Regular.ttf", 16);
  }
  
  void dibujar()
  {
    // Fondo completamente negro
    // image(fondoJuego, width/2, height/2, width, height);
    image(fondoBuffer, width/2, height/2);

    
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
    int vidas = partida.jugador.getVidas();
    text("VIDAS: ", infoX, infoY);
    for (int i = 1; i <= vidas; i++)
    {
      image(corazon, infoX + 70 + 20 * i, infoY + 5, 40, 30);
    }

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

  public void dibujarPantallaNivel() {
  if (this.partida.getMostrandoPantallaNivel()) {
    background(0);

    // Configuración de estilo
    textAlign(CENTER, CENTER);
    textSize(64);
    fill(92,12,12); // rojo oscuro
    text("NIVEL " + this.partida.getNivel(), width / 2, height / 2 - 50);

    /*
    // Texto adicional opcional
    textSize(24);
    fill(200);
    text("Se acercan enemigos...", width / 2, height / 2 + 30);*/

    // Dibuja la nave del jugador
    this.partida.getJugador().dibujar();

    // Controla el tiempo que se muestra la pantalla
    if (millis() - this.partida.getTiempoTransicionNivel() > 2000) {
      this.partida.setMostrandoPantallaNivel(false);
    }

    return; // detener el resto del dibujado
  }
}

}