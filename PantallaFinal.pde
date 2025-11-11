class PantallaFinal extends Pantalla {

  // Fuentes y recursos gráficos
  private PFont fontTitulo, fontTexto, fontOpciones;
  private PImage flecha;

  // Control del menú
  private int posicionFlecha;
  private int[][] posiciones = { {276, 378}, {257, 428}, {240, 478} };
  private int x, y;

  // Datos de la partida
  private Table tablaEstadisticas;
  private String textoPuntaje, textoTiempo, textoPrecision;
  private int enemigos, enemigosRojos, enemigosVerdes, partidaId;
  private boolean ganada;

  // Control de entrada y temporización
  private int tiempoEntrada;        // Momento en que se entra a esta pantalla
  private int delayEntrada = 2000;  // Tiempo de espera antes de aceptar input

  // Constructor: inicializa fuentes, imágenes y tabla de datos
  PantallaFinal(GameManager gm) {
    super(gm);
    fontTitulo = createFont("data/fonts/PressStart2P-Regular.ttf", 36);
    fontTexto = createFont("data/fonts/PressStart2P-Regular.ttf", 16);
    fontOpciones = createFont("data/fonts/PressStart2P-Regular.ttf", 20);
    this.posicionFlecha = 0;

    // Cargar imagen de flecha (si no existe, evitar error)
    try {
      this.flecha = loadImage("a.png");
    } catch (Exception e) {
      this.flecha = null;
    }

    // Cargar tabla de estadísticas (o crear una vacía si no hay archivo)
    try {
      this.tablaEstadisticas = loadTable("data/data.csv", "header");
    } catch (Exception e) {
      this.tablaEstadisticas = new Table();
      this.tablaEstadisticas.addColumn("id");
      this.tablaEstadisticas.addColumn("puntaje");
      this.tablaEstadisticas.addColumn("tiempo");
      this.tablaEstadisticas.addColumn("enemigos derrotados");
      this.tablaEstadisticas.addColumn("enemigos rojos derrotados");
      this.tablaEstadisticas.addColumn("enemigos verdes derrotados");
      this.tablaEstadisticas.addColumn("precision disparo");
      this.tablaEstadisticas.addColumn("player_id");
      this.tablaEstadisticas.addColumn("win");
    }

    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];
  }

  // Dibuja la pantalla de resultados finales (victoria o derrota)
  void dibujar() {
    // Fondo oscuro con overlay
    background(0);
    fill(0, 0, 0, 200);
    rect(width / 2, height / 2, 800, 500);
    textAlign(CENTER, CENTER);

    // ─── TÍTULO PRINCIPAL ───────────────────────────────────
    boolean ganada = this.ganada; // valor definido en resetearEstado()
    int colorResultado = ganada ? color(0, 255, 0) : color(255, 0, 0);
    textFont(fontTitulo);
    fill(colorResultado);
    text(ganada ? "YOU WIN" : "GAME OVER", width / 2, 80);

    // Línea decorativa
    stroke(colorResultado);
    strokeWeight(2);
    line(width / 2 - 150, 110, width / 2 + 150, 110);
    noStroke();

    // ─── SECCIÓN DE ESTADÍSTICAS ────────────────────────────
    textFont(fontTexto);
    fill(255);
    textAlign(CENTER, CENTER);

    // Muestra las estadísticas de la última partida
    if (textoPuntaje != null) {
      text("PUNTAJE FINAL: " + textoPuntaje, width / 2, 140);
      text("TIEMPO: " + textoTiempo, width / 2, 170);
      text("ID: " + partidaId, width / 2, 200);
      text("ENEMIGOS DERROTADOS: " + enemigos, width / 2, 230);
      text("ENEMIGOS ROJOS DERROTADOS: " + enemigosRojos, width / 2, 260);
      text("ENEMIGOS VERDES DERROTADOS: " + enemigosVerdes, width / 2, 290);
      text("PRECISIÓN DISPARO: " + textoPrecision, width / 2, 320);
    }

    // Línea separadora entre estadísticas y menú
    stroke(150);
    strokeWeight(1);
    line(width / 2 - 150, 340, width / 2 + 150, 340);
    noStroke();

    // ─── FLECHA PARPADEANTE ────────────────────────────────
    if ((millis() / 350) % 2 == 1 && flecha != null) {
      image(flecha, x, y - 10, 30, 30);
    }

    // ─── OPCIONES DEL MENÚ FINAL ───────────────────────────
    textFont(fontOpciones);
    fill(255);
    text("REINTENTAR", width / 2, 370);
    text("ESTADÍSTICAS", width / 2, 420);
    text("MENÚ PRINCIPAL", width / 2, 470);

    // ─── INSTRUCCIONES ─────────────────────────────────────
    fill(255, 255, 0);
    textSize(14);
    text("Usa ↑ ↓ para navegar, ESPACIO para seleccionar", width / 2, 550);
  }

  // Actualiza la navegación del menú (con retardo inicial)
  void actualizar() {
    // Evita mover el cursor hasta que pasen los 2 segundos de entrada
    if (millis() - tiempoEntrada < delayEntrada) return;

    // Desplazamiento hacia abajo
    if (gm.getDownPressed() && frameCount % 9 == 0) {
      this.posicionFlecha = (this.posicionFlecha + 1) % posiciones.length;
      actualizarPosicionFlecha();
    }

    // Desplazamiento hacia arriba
    if (gm.getUpPressed() && frameCount % 9 == 0) {
      this.posicionFlecha = (this.posicionFlecha - 1 + posiciones.length) % posiciones.length;
      actualizarPosicionFlecha();
    }
  }

  // Actualiza la posición gráfica de la flecha
  public void actualizarPosicionFlecha() {
    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];
  }

  // Devuelve el índice actual del cursor
  public int getPosicionFlecha() { return this.posicionFlecha; }

  // Reinicia la pantalla final con los datos de la partida recién terminada
  public void resetearEstado() {
    this.posicionFlecha = 0;
    actualizarPosicionFlecha();
    this.tiempoEntrada = millis(); // registra el tiempo de entrada
    Partida p = gm.getPartida();
    this.ganada = gm.getPartidaGanada();

    // Si existe una partida válida, extrae sus estadísticas
    if (p != null) {
      float puntaje = p.getPuntos();
      float tiempoSegundos = p.getDuracion() / 1000;
      this.enemigos = p.getEnemigosDerrotados();
      this.enemigosRojos = p.getEnemigosRojosDerrotados();
      this.enemigosVerdes = p.getEnemigosVerdesDerrotados();
      this.partidaId = p.getPartidaId();

      // Formatea los valores para mostrarlos en texto
      this.textoPuntaje = (puntaje > 9999) ? nf(puntaje / 1000, 0, 1) + "K" : nf(puntaje, 0, 2);
      this.textoTiempo = nf(tiempoSegundos, 0, 2) + "s";
      this.textoPrecision = nf(p.getPrecisionDisparo(), 0, 2) + "%";
    } 
    // Si no hay partida, limpiar valores
    else {
      this.textoPuntaje = this.textoTiempo = this.textoPrecision = null;
      this.enemigos = this.enemigosRojos = this.enemigosVerdes = this.partidaId = 0;
    }
  }

  // Indica si ya se puede recibir input (tras el retardo inicial)
  public boolean puedeRecibirInput() {
    return millis() - tiempoEntrada >= delayEntrada;
  }
}
