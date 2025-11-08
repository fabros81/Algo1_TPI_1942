class PantallaRanking extends Pantalla {
  private PFont fontTexto, fontR;
  private ArrayList<FilaRanking> ranking;

  PantallaRanking(GameManager gm){
    super(gm);
    ranking = new ArrayList<FilaRanking>();
    cargarDatos();
    fontR = createFont("data/fonts/PressStart2P-Regular.ttf", 12);
    fontTexto = createFont("data/fonts/PressStart2P-Regular.ttf", 15);

  }

  // ───────────────────────────────────────────────────────────────
  // Cargar y procesar el CSV
  // ───────────────────────────────────────────────────────────────
  void cargarDatos(){
    ranking.clear();

    Table t = loadTable("prueba.csv", "header");

    if(t == null){
      println("ERROR: No se pudo leer prueba.csv");
      return;
    }

    for (TableRow row : t.rows()) {

      String usuario = row.getString("player");
      int id = row.getInt("id");
      float precision = row.getFloat("precision disparo");
      float puntaje = row.getFloat("puntaje");

      ranking.add(new FilaRanking(usuario, id, precision, puntaje));
    }

    // Ordenar de mayor a menor puntaje
    ranking.sort((a, b) -> Float.compare(b.puntaje, a.puntaje));
  }

  // ───────────────────────────────────────────────────────────────
  // Pantalla Ranking
  // ───────────────────────────────────────────────────────────────
  void actualizar(){
    // si queres volver al menú:
    if(key == 'r' || key == 'R'){ 
      gm.estado = 0;
    }
  }

  void dibujar(){
    background(20);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("TOP 10 - RANKING", width/2 - 10, 80);

    textSize(16);
    textAlign(LEFT);

    int startY = 150;

    // Encabezados
    text("Jugador", 60, startY);
    text("Partida", 250, startY);
    text("Precision", 430, startY);
    text("Puntos", 640, startY);

    stroke(255);
    line(60, startY + 10, width - 60, startY + 10);

    int limite = min(10, ranking.size());

    for(int i = 0; i < limite; i++){
      FilaRanking r = ranking.get(i);
      int y = startY + 50 + i * 35;
       if(i == 0){
    fill(255, 215, 0);   // Oro
  } else if(i == 1){
    fill(192, 192, 192); // Plata
  } else if(i == 2){
    fill(205, 127, 50); // Bronce
 } else {
    textFont(fontTexto);
      fill(150);           // Blanco para el resto
  }   
      textAlign(CENTER, BOTTOM);
      text(r.usuario, 110, y);
      text(r.id, 305, y);
      text(nf(r.precision, 1, 2) + "%", 505, y);
      text((int)(r.puntaje), 690, y);
    }

    textFont(fontR);
    fill(150); 
    textAlign(RIGHT, BOTTOM);
    text("Pulse 'R' para ir a menú", width - 20, height - 20);
  }

  // ───────────────────────────────────────────────────────────────
  // Clase interna: fila del ranking
  // ───────────────────────────────────────────────────────────────
  class FilaRanking {
    String usuario;
    int id;
    float precision;
    float puntaje;

    FilaRanking(String u, int i, float p, float pts){
      usuario = u;
      id = i;
      precision = p;
      puntaje = pts;
    }
  }
}
