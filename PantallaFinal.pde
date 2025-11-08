class PantallaFinal
{
  private GameManager gm;
  private PFont fontTitulo;
  private PFont fontTexto;
  private PFont fontOpciones;
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
  
  PantallaFinal(GameManager gm)  
  {
    this.gm = gm;
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
  
  void dibujar()
  {
    // Fondo
    background(0);
    
    // Overlay oscuro
    fill(0, 0, 0, 200);
    rect(width/2, height/2, 800, 500);
    
    textFont(fontTitulo);
    textAlign(CENTER, CENTER);
        
    // Título GAME OVER O WIN - CORREGIDO
    if (gm.getPartidaGanada()) {
      fill(0, 255, 0); // VERDE para victoria
      text("YOU WIN", width / 2, 80);
    } else {
      fill(255, 0, 0); // ROJO para derrota
      text("GAME OVER", width / 2, 80);
    }
    
    // Línea decorativa - color según resultado
    stroke(255);
    if (gm.getPartidaGanada()) {
      stroke(0, 255, 0); // Verde para victoria
    } else {
      stroke(255, 0, 0); // Rojo para derrota
    }
    strokeWeight(2);
    line(width/2 - 150, 110, width/2 + 150, 110);
    noStroke();
    
    // Estadísticas
    textFont(fontTexto);
    fill(255); // Blanco para las estadísticas
    textAlign(CENTER, CENTER);

    //Flecha parpadeante
    if ((millis() / 350) % 2 == 1) 
    {
      image(flecha, x + 10, y + 15, 30, 30);
    }
    if (gm.getPartida() != null) {
      Partida p = gm.getPartida();
      float puntaje = p.getPuntos();
      float tiempoSegundos = p.getDuracion() / 1000.0;
      
      // Formatear puntaje si es muy grande
      String textoPuntaje;
      if (puntaje > 9999) {
        textoPuntaje = nf(puntaje/1000, 0, 1) + "K";
      } else {
        textoPuntaje = nf(puntaje, 0, 2);
      }
      
      text("PUNTAJE FINAL: " + textoPuntaje, width/2, 140);
      text("TIEMPO: " + nf(tiempoSegundos, 0, 2) + "s", width/2, 170);
      
      int partidaId = p.getPartidaId();
      text("ID: " + partidaId, width/2, 200);

      text("ENEMIGOS DERROTADOS: " + p.getEnemigosDerrotados(), width/2, 230);
      text("ENEMIGOS ROJOS DERROTADOS: " + p.getEnemigosRojosDerrotados(), width/2, 260);
      text("ENEMIGOS VERDES DERROTADOS: " + p.getEnemigosVerdesDerrotados(), width/2, 290);
      text("PRECISIÓN DISPARO: " + nf(p.getPrecisionDisparo(), 0, 2) + "%", width/2, 320);
    }
    
    // Línea separadora
    stroke(150);
    strokeWeight(1);
    line(width/2 - 150, 340, width/2 + 150, 340);
    noStroke();
    
    // Opciones del menú
    textFont(fontOpciones);
    fill(255); // Blanco para las opciones
    textAlign(CENTER, CENTER);
    text("REINTENTAR", width/2, 370);
    text("ESTADÍSTICAS", width/2, 420);
    text("MENÚ PRINCIPAL", width/2, 470);
    
    // Instrucciones
    fill(255, 255, 0); // Amarillo para instrucciones
    textAlign(CENTER, CENTER);
    textSize(14);
    text("Usa ↑ ↓ para navegar, ESPACIO para seleccionar", width/2, 550);
  }
  
  void actualizar()
  {    
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
} 