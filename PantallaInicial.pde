import java.io.FileNotFoundException;

class PantallaInicial extends Pantalla {

  // ────────────────────────────────────────────────
  // Atributos visuales y de interfaz
  // ────────────────────────────────────────────────
  private PImage imgInicio, flecha;
  private int posicionFlecha;
  private int[][] posiciones = { {250, 320}, {250, 360}, {250, 410}, {250, 450} };
  private int x, y;
  private PFont fontID, fontTexto, fontOpciones;

  // ────────────────────────────────────────────────
  // Estado de entrada del jugador
  // ────────────────────────────────────────────────
  private boolean ingresandoID;
  private String playerID;

  // ────────────────────────────────────────────────
  // Constructor: inicializa fuentes, imágenes y estado
  // ────────────────────────────────────────────────
  PantallaInicial(GameManager gm) {
    super(gm);
    this.posicionFlecha = 0;
    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];

    // Fuentes
    fontID = createFont("data/fonts/PressStart2P-Regular.ttf", 16);
    fontTexto = createFont("data/fonts/PressStart2P-Regular.ttf", 14);

    this.ingresandoID = false;
    this.playerID = "";

    // Cargar imagen de fondo
    try {
      this.imgInicio = loadImage("background_inicio.jpg");
      if (this.imgInicio == null) {
        throw new FileNotFoundException("No se pudo cargar la imagen de inicio");
      }
    } catch (Exception e) {
      System.err.println("Error cargando imagen: " + e.getMessage());
      this.imgInicio = null;
    }

    // Cargar imagen de flecha
    try {
      this.flecha = loadImage("a.png");
      if (this.flecha == null) {
        throw new FileNotFoundException("No se pudo cargar la imagen de flecha");
      }
    } catch (Exception e) {
      System.err.println("Error cargando imagen: " + e.getMessage());
      this.flecha = null;
    }
  }

  // ────────────────────────────────────────────────
  // Reinicia el estado del menú principal
  // ────────────────────────────────────────────────
  public void resetearEstado() {
    this.ingresandoID = false;
    this.playerID = "";
    this.posicionFlecha = 0;
    actualizarPosicionFlecha();
  }

  // ────────────────────────────────────────────────
  // Dibuja la pantalla principal o el modo de ingreso de ID
  // ────────────────────────────────────────────────
  void dibujar() {
    if (this.imgInicio != null && this.flecha != null) {
      background(0);
      image(this.imgInicio, width / 2, height / 2, width, height);

      // Si el jugador está ingresando su ID
      if (ingresandoID) {
        dibujarPantallaID();
        return;
      }

      // Flecha parpadeante
      if ((millis() / 350) % 2 == 1) {
        image(flecha, x + 10, y + 15, 30, 30);
      }

      // Instrucciones
      textFont(fontTexto);
      fill(255, 255, 0);
      textAlign(CENTER, CENTER);
      text("Usa ↑ ↓ para navegar, ESPACIO para seleccionar", width / 2, height - 15);

    } else {
      // Si faltan imágenes, mostrar mensaje de error
      background(0);
      fill(255);
      text("Error: Imagen/es de pantalla de inicio no encontrada", 50, height / 2);

      if (this.imgInicio == null) text("• Fondo no cargado", 70, height / 2 + 20);
      if (this.flecha == null) text("• Flecha no cargada", 70, height / 2 + 40);
    }
  }

  // ────────────────────────────────────────────────
  // Dibuja la pantalla de ingreso del ID del jugador
  // ────────────────────────────────────────────────
  void dibujarPantallaID() {
    // Fondo semitransparente
    noStroke();
    fill(0, 0, 0, 80);
    rect(width / 2, (height / 2) + 50, 600, 300, 20);
    fill(30, 30, 30, 150);
    rect(width / 2, (height / 2) + 50, 600, 300, 20);

    // Título
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(24);
    textFont(fontID);
    text("INGRESA TU ID", width / 2 - 30, height / 2 - 50);

    // Mostrar ID ingresado (rellenando con guiones bajos)
    String idMostrar = playerID;
    while (idMostrar.length() < 3) {
      idMostrar += "_";
    }

    textSize(16);
    text(idMostrar, width / 2 - 30, height / 2);

    // Instrucciones
    fill(255, 255, 0);
    if (playerID.length() == 3) {
      textFont(fontID);
      text("Presiona ESPACIO para jugar", width / 2 - 30, height / 2 + 50);
    }
    text("Presiona TAB para volver al menú", width / 2 - 30, height / 2 + 100);
  }

  // ────────────────────────────────────────────────
  // Actualiza la navegación del menú o el ingreso de ID
  // ────────────────────────────────────────────────
  void actualizar() {
    // Si el jugador está ingresando su ID
    if (ingresandoID) {
      // Comienza la partida cuando se presiona ESPACIO y el ID tiene 3 letras
      if (playerID.length() == 3 && gm.getSpacePressed()) {
        gm.opcionSeleccionada("inicial", -1);
      }
      return;
    }

    // Navegación del menú principal
    if (gm.getDownPressed() && frameCount % 9 == 0) {
      this.posicionFlecha++;
      if (this.posicionFlecha > 3) this.posicionFlecha = 0;
      actualizarPosicionFlecha();
    }

    if (gm.getUpPressed() && frameCount % 9 == 0) {
      this.posicionFlecha--;
      if (this.posicionFlecha < 0) this.posicionFlecha = 3;
      actualizarPosicionFlecha();
    }
  }

  // ────────────────────────────────────────────────
  // Maneja las teclas mientras se ingresa el ID
  // ────────────────────────────────────────────────
  void keyTyped() {
    if (ingresandoID && playerID.length() < 3) {
      if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
        playerID += Character.toUpperCase(key);
      }
    }
  }

  void keyPressed() {
    if (ingresandoID) {
      if (key == TAB) {
        ingresandoID = false; // cancelar ingreso
      } else if (key == BACKSPACE && playerID.length() > 0) {
        // eliminar último carácter
        playerID = playerID.substring(0, playerID.length() - 1);
      }
    }
  }

  // ────────────────────────────────────────────────
  // Métodos auxiliares
  // ────────────────────────────────────────────────
  public void iniciarIngresoID() {
    this.ingresandoID = true;
    this.playerID = "";
  }

  public boolean isIngresandoID() { return ingresandoID; }

  private void actualizarPosicionFlecha() {
    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];
  }
  //getters
  public String getPlayerID() { return this.playerID; }
  public int getPosicionFlecha() { return this.posicionFlecha; }
}

