class PantallaJuego extends Pantalla {

  // ────────────────────────────────────────────────
  // Atributos principales
  // ────────────────────────────────────────────────
  private Partida partida;
  private PFont fontUI, fontNumeros;

  // ────────────────────────────────────────────────
  // Constructor: inicializa fuentes
  // ────────────────────────────────────────────────
  PantallaJuego(GameManager gm) {
    super(gm);
    this.fontUI = createFont("data/fonts/PressStart2P-Regular.ttf", 12);
    this.fontNumeros = createFont("data/fonts/PressStart2P-Regular.ttf", 16);
  }

  // ────────────────────────────────────────────────
  // Dibuja toda la pantalla de juego
  // ────────────────────────────────────────────────
  void dibujar() {
    // Fondo animado (desde el buffer del gif)
    image(fondoBuffer, width / 2, height / 2);

    // Elementos del juego
    if (partida != null) {
      this.partida.dibujar();
    }

    // Interfaz del jugador
    dibujarUI();

    // Pantalla de transición entre niveles
    dibujarPantallaNivel();
  }

  // ────────────────────────────────────────────────
  // Dibuja la interfaz de usuario (HUD)
  // ────────────────────────────────────────────────
  void dibujarUI() {
    if (partida == null || partida.jugador == null) return;

    pushStyle();
    dibujarPanelSuperior();     // puntaje, tiempo, nivel
    dibujarInfoJugador();       // vidas, corazones
    dibujarIndicadoresPowerUps(); // power-ups activos
    popStyle();
  }

  // ────────────────────────────────────────────────
  // Dibuja el panel superior con puntaje, tiempo y nivel
  // ────────────────────────────────────────────────
  void dibujarPanelSuperior() {
    fill(255);
    textFont(fontNumeros);

    // Puntaje
    textAlign(LEFT, TOP);
    String puntajeTexto = "PUNTOS: " + nf(partida.getPuntos(), 0, 0);
    text(puntajeTexto, 20, 20);

    // Tiempo transcurrido
    int tiempoTranscurrido = partida.getDuracion() / 1000;
    int minutos = tiempoTranscurrido / 60;
    int segundos = tiempoTranscurrido % 60;
    textAlign(RIGHT, TOP);
    text("TIEMPO: " + nf(minutos, 2) + ":" + nf(segundos, 2), width - 20, 20);

    // Nivel actual
    textAlign(CENTER, TOP);
    text("NIVEL " + partida.nivel, width / 2, 20);
  }

  // ────────────────────────────────────────────────
  // Muestra la información del jugador (vidas)
  // ────────────────────────────────────────────────
  void dibujarInfoJugador() {
    float infoX = 20;
    float infoY = height - 40;

    textFont(fontUI);
    textAlign(LEFT, TOP);
    fill(255);

    // Texto "VIDAS"
    text("VIDAS: ", infoX, infoY);

    // Dibuja corazones según cantidad de vidas
    int vidas = partida.jugador.getVidas();
    for (int i = 1; i <= vidas; i++) {
      image(corazon, infoX + 70 + 20 * i, infoY + 5, 40, 30);
    }
  }

  // ────────────────────────────────────────────────
  // Muestra indicadores de power-ups activos
  // ────────────────────────────────────────────────
  void dibujarIndicadoresPowerUps() {
    float powerX = width - 180;
    float powerY = 60;

    textFont(fontUI);
    textAlign(LEFT, TOP);
    fill(255);

    if (partida.jugador.getMultidisparoActivo()) {
      text("MULTIDISPARO", powerX, powerY);
    }
    if (partida.jugador.getInstakillActivo()) {
      text("INSTAKILL", powerX, powerY + 20);
    }
    if (partida.jugador.getEscudoActivo()) {
      text("ESCUDO", powerX, powerY + 40);
    }
  }

  // ────────────────────────────────────────────────
  // Actualiza la lógica de la partida
  // ────────────────────────────────────────────────
  void actualizar() {
    if (this.partida != null) {
      this.partida.actualizar();
    }
  }

  // ────────────────────────────────────────────────
  // Muestra pantalla de transición entre niveles
  // ────────────────────────────────────────────────
  public void dibujarPantallaNivel() {
    if (this.partida.getMostrandoPantallaNivel()) {
      background(0);

      // Título del nivel
      textAlign(CENTER, CENTER);
      textSize(64);
      fill(92, 12, 12);
      text("NIVEL " + this.partida.getNivel(), width / 2, height / 2 - 50);

      // Dibuja la nave del jugador
      this.partida.getJugador().dibujar();

      // Desaparece después de 2 segundos
      if (millis() - this.partida.getTiempoTransicionNivel() > 2000) {
        this.partida.setMostrandoPantallaNivel(false);
      }
      return;
    }
  }

  // ────────────────────────────────────────────────
  // Setter
  // ────────────────────────────────────────────────
  void setPartida(Partida partida) {
    this.partida = partida;
  }
}
