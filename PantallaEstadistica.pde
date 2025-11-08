class PantallaEstadistica extends Pantalla
{
<<<<<<< HEAD
  private PFont fontTitulo;
  private PFont fontTexto;
  private PFont fontOpciones;
  private Estadísticas estadisticas;
  private GameManager gm;
=======
  private PFont fontTitulo, fontTexto, fontOpciones, fontSubtitulo;
  private Estadísticas estadisticas;
  
  private String playerID = "ALL";
  private boolean ingresandoID = false;
  
>>>>>>> origin/main
  PantallaEstadistica(GameManager gm)
  {
    super(gm);
    fontTitulo = createFont("data/fonts/PressStart2P-Regular.ttf", 36);
    fontTexto = createFont("data/fonts/PressStart2P-Regular.ttf", 12);
    fontOpciones = createFont("data/fonts/PressStart2P-Regular.ttf", 20);
<<<<<<< HEAD
=======
    fontSubtitulo = createFont("data/fonts/PressStart2P-Regular.ttf", 18);
>>>>>>> origin/main
    

    estadisticas = new Estadísticas();
  }

  void dibujar()
  {
    // Fond
    
    background(0);
    
    
    // Overlay oscuro
    fill(0, 0, 0, 200);
    rect(width/2, height/2, 800, 500);
    
    // Título ESTADÍSTICAS
    textFont(fontTitulo);
    fill(255, 255, 255);
    textAlign(CENTER, CENTER);
    text("ESTADISTICAS", width / 2, 80);
<<<<<<< HEAD

    textFont(fontTexto);
    fill(255);
    textAlign(CENTER, CENTER);

     textFont(fontTexto);
    fill(150); 
    textAlign(RIGHT, BOTTOM);
    text("Pulse 'R' para ir a menú", width - 20, height - 20);

    // ─── Header ─────────────────────────────
    String[] headers = {"MAX", "MIN", "AVG", "SD"};
    float startX = width/2 -60;  // center alignment anchor
    float spacing = 120;           // distance between columns

=======
    textFont(fontSubtitulo);

    if (!isIngresandoID()){
      if (playerID.equals("ALL")){
      text("GLOBALES", width / 2, 130);
      }
      else
      {
        text("DE: " + playerID, width / 2, 130);
      }
    }
    else{
      dibujarPantallaID();
      textFont(fontTexto);
      fill(150); 
      textAlign(LEFT, BOTTOM);
      text("Si quiere ver las estadisticas globales ingrese 'ALL'", 20, height - 20);
      return;
    }
  


    textFont(fontTexto);
    fill(150); 
    textAlign(LEFT, BOTTOM);
    text("Pulse 'R' para ir a menú", 20, height - 20);
    text("Pulse 'SPACE' para filtrar por jugador", 20, height - 40);


    // ─── Header ─────────────────────────────
    String[] headers = {"MAX", "MIN", "AVG", "SD"};
    float startX = width/2 -110;  // center alignment anchor
    float spacing = 120;           // distance between columns
>>>>>>> origin/main
    for (int i = 0; i < headers.length; i++) {
      text("|  " + headers[i] + "  ", startX + i * spacing, 200);
    }
    text("|", startX + headers.length  * spacing - 50, 200); // closing pipe

<<<<<<< HEAD
    // ─── Puntaje ───────────────────────────
    estadisticas.calcularEstadisticas("puntaje");
=======
    // ─── Estadísticas ──────────────────────
    dibujarEstadisticas();
  }
  public void dibujarEstadisticas()
  {
    float startX = width/2 -60;  // center alignment anchor
    float spacing = 120;           // distance between columns

      // ─── Puntaje ───────────────────────────
    estadisticas.calcularEstadisticas(playerID, "puntaje");
>>>>>>> origin/main
    float[] puntaje = {
    estadisticas.getMax(),
    estadisticas.getMin(),
    estadisticas.getMedia(),
    estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT);
    text("PUNTAJE", 10, 250);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < puntaje.length; i++) {
      text(nf(puntaje[i], 1, 2), startX + i * spacing, 240);
    }

    // ─── Tiempo ───────────────────────────
<<<<<<< HEAD
    estadisticas.calcularEstadisticas("tiempo");
=======
    estadisticas.calcularEstadisticas(playerID, "tiempo");
>>>>>>> origin/main
    float[] tiempo = {
    estadisticas.getMax(),
    estadisticas.getMin(),
    estadisticas.getMedia(),
    estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT);
    text("TIEMPO (s)", 10, 290);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < tiempo.length; i++) {
      text(nf(tiempo[i]/1000, 1, 2), startX + i * spacing, 280);
    }
    // ─── Enemigos Derrotados ──────────────
<<<<<<< HEAD
    estadisticas.calcularEstadisticas("enemigos derrotados");
=======
    estadisticas.calcularEstadisticas(playerID, "enemigos derrotados");
>>>>>>> origin/main
    float[] enemigosDerrotados = {
    estadisticas.getMax(),
    estadisticas.getMin(),
    estadisticas.getMedia(),
    estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT);
    text("ENEMIGOS DERROTADOS", 10, 330);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < enemigosDerrotados.length; i++) {
      text(nf(enemigosDerrotados[i], 1, 2), startX + i * spacing, 320);
    }
    // ─── Enemigos Rojos Derrotados ────────
<<<<<<< HEAD
    estadisticas.calcularEstadisticas("enemigos rojos derrotados");
=======
    estadisticas.calcularEstadisticas(playerID, "enemigos rojos derrotados");
>>>>>>> origin/main
    float[] enemigosRojosDerrotados = {
    estadisticas.getMax(),
    estadisticas.getMin(),
    estadisticas.getMedia(),
    estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT);
    text("ENEMIGOS ROJOS", 10, 370);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < enemigosRojosDerrotados.length; i++) {
      text(nf(enemigosRojosDerrotados[i], 1, 2), startX + i * spacing, 360);
    }
    // ─── Enemigos Verdes Derrotados ───────
<<<<<<< HEAD
    estadisticas.calcularEstadisticas("enemigos verdes derrotados");
=======
    estadisticas.calcularEstadisticas(playerID, "enemigos verdes derrotados");
>>>>>>> origin/main
    float[] enemigosVerdesDerrotados = {
    estadisticas.getMax(),
    estadisticas.getMin(),
    estadisticas.getMedia(),
    estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT);
    text("ENEMIGOS VERDES", 10, 410);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < enemigosVerdesDerrotados.length; i++) {
        text(nf(enemigosVerdesDerrotados[i], 1, 2), startX + i * spacing, 400);
    }
    // ─── Precisión Disparo ─────────────────
<<<<<<< HEAD
    estadisticas.calcularEstadisticas("precision disparo");
=======
    estadisticas.calcularEstadisticas(playerID, "precision disparo");
>>>>>>> origin/main
    float[] precisionDisparo = {
    estadisticas.getMax(),
    estadisticas.getMin(),
    estadisticas.getMedia(),
    estadisticas.getDesvioEstandar()
    };
    textAlign(LEFT);
    text("PRECISIÓN DISPARO (%)", 10, 450);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < precisionDisparo.length; i++) {
      text(nf(precisionDisparo[i], 1, 2), startX + i * spacing, 440);
    }

<<<<<<< HEAD
}
  void actualizar()
  {

=======
  }
    // ─── PANTALLA DE INGRESO DE ID ─────────────────────────
  void dibujarPantallaID() {
    noStroke();
    fill(0, 0, 0, 80);
    rect(width/2, (height/2) + 50, 600, 300, 20);
    fill(30, 30, 30, 150);
    rect(width/2, (height/2) + 50, 600, 300, 20);

    fill(255);
    textAlign(CENTER, CENTER);
    textFont(fontTexto);
    text("INGRESA UN ID PARA FILTRAR", width/2, height/2 - 50);

    String idMostrar = playerID;
    while (idMostrar.length() < 3) idMostrar += "_";
    text(idMostrar, width/2, height/2);

    fill(255, 255, 0);
    if (playerID.length() == 3) {
      text("Presiona ENTER para confirmar", width/2, height/2 + 50);
    }
    text("Presiona TAB para cancelar", width/2, height/2 + 100);
  }
  void actualizar()
  {
  }

   // ─── INPUT ─────────────────────────────────────────────
  void keyTyped() {
    if (ingresandoID && playerID.length() < 3) {
      if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
        playerID += Character.toUpperCase(key);
      }
    }
  }

  void keyPressed() {
    if (!ingresandoID) {
      // Enter ID mode
      if (key == ' ') {
        ingresandoID = true;
        playerID = "";
      } else if (key == 'r' || key == 'R') {
        gm.opcionSeleccionada("estadisticas", 0); // volver al menú
      }
      return;
    }

    // mientras ingresas ID
    if (ingresandoID) {
      if (key == BACKSPACE && playerID.length() > 0) {
        playerID = playerID.substring(0, playerID.length() - 1);
      } else if (key == TAB) {
        // Cancel input
        ingresandoID = false;
        playerID = "ALL";
      } else if (keyCode == ENTER && playerID.length() == 3) {
        // Confirm and apply
        ingresandoID = false;
      }
    }
  }

  public boolean isIngresandoID() {
    return ingresandoID;
>>>>>>> origin/main
  }
}