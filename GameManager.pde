class GameManager {

  // INPUT
  private boolean leftPressed = false;
  private boolean rightPressed = false;
  private boolean upPressed = false;
  private boolean downPressed = false;
  private boolean spacePressed = false;
  private boolean kPressed = false;
  private boolean kPressedThisFrame = false;
  private String playerID;

  // ESTADO DEL JUEGO
  // 0 = menú | 1 = jugando | 2 = fin | 3 = estadísticas | 4 = ranking
  private int estado;
  private PantallaInicial menu;
  private PantallaJuego juego;
  private PantallaFinal fin;
  private PantallaEstadistica estadisticas;
  private PantallaRanking ranking;
  private Partida partida;
  private boolean partidaGanada = false;

  // Constructor
  GameManager() {
    this.menu = new PantallaInicial(this);
    this.juego = new PantallaJuego(this);
    this.fin = new PantallaFinal(this);
    this.estadisticas = new PantallaEstadistica(this);
    this.ranking = new PantallaRanking(this);
    this.estado = 0; // empieza en el menú
  }

  // Actualiza la lógica general según el estado actual del juego
  void actualizar() {
    switch (this.estado) {
      case 0: // Menú principal
        this.menu.actualizar();
        break;
      case 1: // En juego
        if (partida != null) this.juego.actualizar();
        break;
      case 2: // Pantalla final (win/lose)
        this.fin.actualizar();
        break;
      case 3: // Estadísticas
        this.estadisticas.actualizar();
        break;
      case 4: // Ranking
        this.ranking.actualizar();
        break;
    }
  }

  // Dibuja la pantalla correspondiente al estado actual
  void dibujar() {
    switch (this.estado) {
      case 0: this.menu.dibujar(); break;
      case 1: if (partida != null) this.juego.dibujar(); break;
      case 2: this.fin.dibujar(); break;
      case 3: this.estadisticas.dibujar(); break;
      case 4: this.ranking.dibujar(); break;
    }
  }

  // Inicia una nueva partida y cambia al estado "jugando"
  public void iniciarPartida() {
    this.partida = new Partida(this);
    this.juego.setPartida(this.partida);
    this.estado = 1;
    this.partidaGanada = false;
  }

  // Finaliza la partida, guarda estadísticas y cambia a la pantalla final
  public void finalizarPartida(boolean ganada) {
    this.partidaGanada = ganada;

    // Guarda los datos de la partida si existe
    if (this.partida != null) this.partida.guardarEstadisticas();

    // Reinicia el estado de la pantalla final para mostrar nuevo resultado
    this.fin.resetearEstado();

    this.estado = 2; // Cambia a pantalla final
  }

  // Detecta y maneja las teclas presionadas
  public void keyPressed() {
    // Señales de movimiento y disparo
    if (keyCode == LEFT) this.leftPressed = true;
    if (keyCode == RIGHT) this.rightPressed = true;
    if (keyCode == UP) this.upPressed = true;
    if (keyCode == DOWN) this.downPressed = true;
    if (key == ' ') this.spacePressed = true;

    // Tecla especial K (usada para funciones de un solo frame)
    if (key == 'k' || key == 'K') {
      this.kPressed = true;
      this.kPressedThisFrame = true;
    }

    // Acciones específicas según la pantalla activa
    switch (estado) {
      case 0: // MENÚ PRINCIPAL
        // Si se presiona espacio mientras se ingresa un ID, delega el evento
        if (spacePressed) {
          if (menu.isIngresandoID()) menu.keyPressed();
          else opcionSeleccionada("inicial", menu.getPosicionFlecha());
        }

        // Permite borrar o navegar al escribir ID
        if (menu.isIngresandoID() && (key == TAB || key == BACKSPACE))
          menu.keyPressed();
        break;

      case 2: // PANTALLA FINAL
        // Solo permite input si la pantalla ya terminó su animación de entrada
        if (spacePressed && this.fin.puedeRecibirInput())
          opcionSeleccionada("final", fin.getPosicionFlecha());
        break;

      case 3: // ESTADÍSTICAS
        this.estadisticas.keyPressed();
        break;
    }
  }

  // Maneja texto ingresado (como el ID del jugador)
  public void keyTyped() {
    if (this.estado == 0 && this.menu.isIngresandoID())
      this.menu.keyTyped();
    if (this.estado == 3 && this.estadisticas.isIngresandoID())
      this.estadisticas.keyTyped();
  }

  // Maneja cuando se sueltan las teclas (para evitar movimiento continuo)
  public void keyReleased() {
    if (keyCode == LEFT) this.leftPressed = false;
    if (keyCode == RIGHT) this.rightPressed = false;
    if (keyCode == UP) this.upPressed = false;
    if (keyCode == DOWN) this.downPressed = false;
    if (key == ' ') this.spacePressed = false;
    if (key == 'k' || key == 'K') this.kPressed = false;
  }

  // Resetea el input de "kPressedThisFrame" (solo dura un frame)
  public void resetFrameInput() {
    this.kPressedThisFrame = false;
  }

  // Gestiona las acciones de cada pantalla según la opción seleccionada
  public void opcionSeleccionada(String pantalla, int opcion) {
    switch (pantalla) {

      case "inicial": // MENÚ PRINCIPAL
        if (opcion == -1) {
          // Inicia partida con el ID ingresado
          this.playerID = menu.getPlayerID();
          iniciarPartida();
        } else {
          switch (opcion) {
            case 0: // "1 "
              menu.iniciarIngresoID();
              break;
            case 1: // "2 jugadores" (futuro)
              break;
            case 2: // Ver estadísticas
              background(0);
              this.estadisticas.resetearEstado();
              estado = 3;
              break;
            case 3: // Ver ranking
              background(0);
              this.ranking.cargarDatos();
              estado = 4;
              break;
          }
        }
        break;

      case "final": // PANTALLA FINAL
        switch (opcion) {
          case 0: // Reintentar
            iniciarPartida();
            break;
          case 1: // Ver estadísticas
            this.estadisticas.resetearEstado();
            estado = 3;
            break;
          case 2: // Volver al menú principal
            menu.resetearEstado();
            estado = 0;
            break;
        }
        break;

      case "estadisticas": // PANTALLA DE ESTADÍSTICAS
        if (opcion == 0) {
          menu.resetearEstado();
          estado = 0;
        }
        break;

      case "ranking": // PANTALLA DE RANKING
        if (opcion == 0) {
          menu.resetearEstado();
          estado = 0;
        }
        break;
    }
  }

  // GETTERS
  public boolean getLeftPressed() { return this.leftPressed; }
  public boolean getRightPressed() { return this.rightPressed; }
  public boolean getUpPressed() { return this.upPressed; }
  public boolean getDownPressed() { return this.downPressed; }
  public boolean getSpacePressed() { return this.spacePressed; }
  public boolean getKPressed() { return this.kPressed; }
  public boolean getKPressedThisFrame() { return this.kPressedThisFrame; }
  public boolean getPartidaGanada() { return this.partidaGanada; }
  public Partida getPartida() { return this.partida; }
  public String getPlayerID() { return this.playerID; }
}
