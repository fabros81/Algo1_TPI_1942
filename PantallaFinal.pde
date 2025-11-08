class PantallaFinal extends Pantalla
{
  private PFont fontTitulo, fontTexto, fontOpciones;
  private PImage flecha;
  private int posicionFlecha;
  private int[][] posiciones = {
    {276, 378}, 
    {257, 428},  
    {240, 478}  
  };
  private int x;
  private int y;
  private Table tablaEstadisticas;
  
  private int tiempoEntrada;   // when we entered this screen
  private int delayEntrada = 2000; // milliseconds to wait before enabling input
  private String textoPuntaje, textoTiempo, textoPrecision;
  private int enemigos, enemigosRojos, enemigosVerdes, partidaId;
  private boolean ganada;

  PantallaFinal(GameManager gm)  
  {
    super(gm);
    fontTitulo = createFont("data/fonts/PressStart2P-Regular.ttf", 36);
    fontTexto = createFont("data/fonts/PressStart2P-Regular.ttf", 16);
    fontOpciones = createFont("data/fonts/PressStart2P-Regular.ttf", 20);
  
    this.posicionFlecha = 0;
    
    // Cargar imágenes
    try {
      this.flecha = loadImage("a.png");
    } catch (Exception e) {  
      this.flecha = null;
    }
    
    // Cargar tabla de estadísticas
    try {
      this.tablaEstadisticas = loadTable("data/prueba.csv", "header");
    } catch (Exception e) {
      this.tablaEstadisticas = new Table();
      this.tablaEstadisticas.addColumn("id");
      this.tablaEstadisticas.addColumn("puntaje");
      this.tablaEstadisticas.addColumn("tiempo");
      this.tablaEstadisticas.addColumn("enemigos derrotados");
      this.tablaEstadisticas.addColumn("enemigos rojos derrotados");
      this.tablaEstadisticas.addColumn("enemigos verdes derrotados");
    }
    
    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];
  }
  
  void dibujar() {
  // Fondo y overlay
  background(0);
  fill(0, 0, 0, 200);
  rect(width/2, height/2, 800, 500);

  textAlign(CENTER, CENTER);

  // ─── TÍTULO ────────────────────────────────────────────────
  boolean ganada = this.ganada; // preloaded in resetearEstado()
  int colorResultado = ganada ? color(0, 255, 0) : color(255, 0, 0);

  textFont(fontTitulo);
  fill(colorResultado);
  text(ganada ? "YOU WIN" : "GAME OVER", width / 2, 80);

  stroke(colorResultado);
  strokeWeight(2);
  line(width/2 - 150, 110, width/2 + 150, 110);
  noStroke();

  // ─── ESTADÍSTICAS ───────────────────────────────────────────
  textFont(fontTexto);
  fill(255);
  textAlign(CENTER, CENTER);

  if (textoPuntaje != null) { // valores ya calculados en resetearEstado()
    text("PUNTAJE FINAL: " + textoPuntaje, width/2, 140);
    text("TIEMPO: " + textoTiempo, width/2, 170);
    text("ID: " + partidaId, width/2, 200);
    text("ENEMIGOS DERROTADOS: " + enemigos, width/2, 230);
    text("ENEMIGOS ROJOS DERROTADOS: " + enemigosRojos, width/2, 260);
    text("ENEMIGOS VERDES DERROTADOS: " + enemigosVerdes, width/2, 290);
    text("PRECISIÓN DISPARO: " + textoPrecision, width/2, 320);
  }

  // Línea separadora
  stroke(150);
  strokeWeight(1);
  line(width/2 - 150, 340, width/2 + 150, 340);
  noStroke();

  // ─── FLECHA PARPADEANTE ────────────────────────────────────
  if ((millis() / 350) % 2 == 1) {
    image(flecha, x, y - 10, 30, 30);
  }

  // ─── OPCIONES DEL MENÚ ─────────────────────────────────────
  textFont(fontOpciones);
  fill(255);
  text("REINTENTAR", width/2, 370);
  text("ESTADÍSTICAS", width/2, 420);
  text("MENÚ PRINCIPAL", width/2, 470);

  // ─── INSTRUCCIONES ─────────────────────────────────────────
  fill(255, 255, 0);
  textSize(14);
  text("Usa ↑ ↓ para navegar, ESPACIO para seleccionar", width/2, 550);
}

  void actualizar()
  { 
     if (millis() - tiempoEntrada < delayEntrada) return; 
    // Navegación con flechas
    if (gm.getDownPressed()&& frameCount % 9 == 0) {
      this.posicionFlecha = (this.posicionFlecha + 1) % posiciones.length;
      actualizarPosicionFlecha();
    }
    
    if (gm.getUpPressed()&& frameCount % 9 == 0) {
      this.posicionFlecha = (this.posicionFlecha - 1 + posiciones.length) % posiciones.length;
      actualizarPosicionFlecha();
    }
  }
  
  public void actualizarPosicionFlecha() {
    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];
  }
  public int getPosicionFlecha(){return this.posicionFlecha;}

  public void resetearEstado() 
  {
    this.posicionFlecha = 0;
    actualizarPosicionFlecha();
    this.tiempoEntrada = millis();

    Partida p = gm.getPartida();
    this.ganada = gm.getPartidaGanada();

    if (p != null) {
      float puntaje = p.getPuntos();
      float tiempoSegundos = p.getDuracion() / 1000;
      this.enemigos = p.getEnemigosDerrotados();
      this.enemigosRojos = p.getEnemigosRojosDerrotados();
      this.enemigosVerdes = p.getEnemigosVerdesDerrotados();
      this.partidaId = p.getPartidaId();

      this.textoPuntaje = (puntaje > 9999) ? nf(puntaje / 1000, 0, 1) + "K" : nf(puntaje, 0, 2);
      this.textoTiempo = nf(tiempoSegundos, 0, 2) + "s";
      this.textoPrecision = nf(p.getPrecisionDisparo(), 0, 2) + "%";
    } else {
      this.textoPuntaje = this.textoTiempo = this.textoPrecision = null;
      this.enemigos = this.enemigosRojos = this.enemigosVerdes = this.partidaId = 0;
    }
  }
  public boolean puedeRecibirInput() {
    return millis() - tiempoEntrada >= delayEntrada;
  }
} 