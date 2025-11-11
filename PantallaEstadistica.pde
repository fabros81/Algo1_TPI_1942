class PantallaEstadistica extends Pantalla {

  // Fuentes y componentes visuales
  private PFont fontTitulo, fontTexto, fontOpciones, fontSubtitulo;

  // Lógica de estadísticas
  private Estadísticas estadisticas;

  // Estado del input de jugador
  private String playerID = "ALL";
  private boolean ingresandoID = false;

  // Constructor: inicializa fuentes y carga las estadísticas
  PantallaEstadistica(GameManager gm) {
    super(gm);
    fontTitulo = createFont("data/fonts/PressStart2P-Regular.ttf", 36);
    fontTexto = createFont("data/fonts/PressStart2P-Regular.ttf", 12);
    fontOpciones = createFont("data/fonts/PressStart2P-Regular.ttf", 20);
    fontSubtitulo = createFont("data/fonts/PressStart2P-Regular.ttf", 18);

    estadisticas = new Estadísticas();
  }

  // Dibuja la pantalla principal de estadísticas
  void dibujar() {
    // Fondo y overlay
    noStroke();
    background(0);
    fill(0, 0, 0, 200);
    rect(width / 2, height / 2, 800, 500);

    // Título principal
    textFont(fontTitulo);
    fill(255);
    textAlign(CENTER, CENTER);
    text("ESTADISTICAS", width / 2, 80);
    textFont(fontSubtitulo);

    // Subtítulo según modo actual
    if (!isIngresandoID()) {
      if (playerID.equals("ALL")) text("GLOBALES", width / 2, 130);
      else text("DE: " + playerID, width / 2, 130);
    } else {
      // Modo de ingreso de ID
      dibujarPantallaID();
      textFont(fontTexto);
      fill(150);
      textAlign(LEFT, BOTTOM);
      text("Si quiere ver las estadisticas globales ingrese 'ALL'", 20, height - 20);
      return;
    }

    // Instrucciones
    textFont(fontTexto);
    fill(150);
    textAlign(LEFT, BOTTOM);
    text("Pulse 'R' para ir a menú", 20, height - 20);
    text("Pulse 'SPACE' para filtrar por jugador", 20, height - 40);

    // Header de la tabla
    String[] headers = {"MAX", "MIN", "AVG", "SD"};
    float startX = width / 2 - 110;
    float spacing = 120;
    for (int i = 0; i < headers.length; i++) {
      text("|  " + headers[i] + "  ", startX + i * spacing, 200);
    }
    text("|", startX + headers.length * spacing - 50, 200);

    // Dibuja la tabla con las estadísticas
    dibujarEstadisticas();
  }

  // Calcula y muestra los valores estadísticos en pantalla
  public void dibujarEstadisticas() {
    float startX = width / 2 - 60;
    float spacing = 120;

    // --- Puntaje ---
    estadisticas.calcularEstadisticas(playerID, "puntaje");
    float[] puntaje = {
      estadisticas.getMax(), estadisticas.getMin(),
      estadisticas.getMedia(), estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT); text("PUNTAJE", 10, 250);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < puntaje.length; i++)
      text(nf(puntaje[i], 1, 2), startX + i * spacing, 240);

    // --- Tiempo ---
    estadisticas.calcularEstadisticas(playerID, "tiempo");
    float[] tiempo = {
      estadisticas.getMax(), estadisticas.getMin(),
      estadisticas.getMedia(), estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT); text("TIEMPO (s)", 10, 290);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < tiempo.length; i++)
      text(nf(tiempo[i] / 1000, 1, 2), startX + i * spacing, 280);

    // --- Enemigos Derrotados ---
    estadisticas.calcularEstadisticas(playerID, "enemigos derrotados");
    float[] enemigosDerrotados = {
      estadisticas.getMax(), estadisticas.getMin(),
      estadisticas.getMedia(), estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT); text("ENEMIGOS DERROTADOS", 10, 330);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < enemigosDerrotados.length; i++)
      text(nf(enemigosDerrotados[i], 1, 2), startX + i * spacing, 320);

    // --- Enemigos Rojos ---
    estadisticas.calcularEstadisticas(playerID, "enemigos rojos derrotados");
    float[] enemigosRojos = {
      estadisticas.getMax(), estadisticas.getMin(),
      estadisticas.getMedia(), estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT); text("ENEMIGOS ROJOS", 10, 370);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < enemigosRojos.length; i++)
      text(nf(enemigosRojos[i], 1, 2), startX + i * spacing, 360);

    // --- Enemigos Verdes ---
    estadisticas.calcularEstadisticas(playerID, "enemigos verdes derrotados");
    float[] enemigosVerdes = {
      estadisticas.getMax(), estadisticas.getMin(),
      estadisticas.getMedia(), estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT); text("ENEMIGOS VERDES", 10, 410);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < enemigosVerdes.length; i++)
      text(nf(enemigosVerdes[i], 1, 2), startX + i * spacing, 400);

    // --- Precisión de disparo ---
    estadisticas.calcularEstadisticas(playerID, "precision disparo");
    float[] precision = {
      estadisticas.getMax(), estadisticas.getMin(),
      estadisticas.getMedia(), estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT); text("PRECISIÓN DISPARO (%)", 10, 450);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < precision.length; i++)
      text(nf(precision[i], 1, 2), startX + i * spacing, 440);

    // --- Win Rate ---
    textAlign(LEFT);
    text("WIN RATE: ", 10, 500);
    estadisticas.winRate(playerID);
    text(nf(estadisticas.getWinRate(), 1, 2) + " %", 150, 500);
  }

  // Dibuja la pantalla para ingresar ID de jugador
  void dibujarPantallaID() {
    noStroke();
    fill(0, 0, 0, 80);
    rect(width / 2, (height / 2) + 50, 600, 300, 20);
    fill(30, 30, 30, 150);
    rect(width / 2, (height / 2) + 50, 600, 300, 20);

    fill(255);
    textAlign(CENTER, CENTER);
    textFont(fontTexto);
    text("INGRESA UN ID PARA FILTRAR", width / 2, height / 2 - 50);

    // Muestra el ID o placeholders si faltan letras
    String idMostrar = playerID;
    while (idMostrar.length() < 3) idMostrar += "_";
    text(idMostrar, width / 2, height / 2);

    // Instrucciones de entrada
    fill(255, 255, 0);
    if (playerID.length() == 3)
      text("Presiona ENTER para confirmar", width / 2, height / 2 + 50);
    text("Presiona TAB para cancelar", width / 2, height / 2 + 100);
  }

  // Actualización de lógica (no usada en esta pantalla)
  void actualizar() {}

  // INPUT
  void keyTyped() {
    // Permite ingresar hasta 3 letras para el ID
    if (ingresandoID && playerID.length() < 3) {
      if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
        playerID += Character.toUpperCase(key);
      }
    }
  }

  void keyPressed() {
    if (!ingresandoID) {
      // Entrar en modo de ingreso de ID
      if (key == ' ') {
        ingresandoID = true;
        playerID = "";
      }
      // Volver al menú
      else if (key == 'r' || key == 'R') {
        gm.opcionSeleccionada("estadisticas", 0);
      }
      return;
    }

    // Si se está ingresando ID
    if (ingresandoID) {
      if (key == BACKSPACE && playerID.length() > 0) {
        playerID = playerID.substring(0, playerID.length() - 1);
      } else if (key == TAB) {
        // Cancelar entrada
        ingresandoID = false;
        playerID = "ALL";
      } else if (keyCode == ENTER && playerID.length() == 3) {
        // Confirmar ID ingresado
        ingresandoID = false;
      }
    }
  }

  // Getters y control de estado
  public boolean isIngresandoID() { return ingresandoID; }

  public void resetearEstado() {
    this.ingresandoID = false;
    this.playerID = "ALL";
    background(0);
  }
}
