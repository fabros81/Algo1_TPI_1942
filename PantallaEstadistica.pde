class PantallaEstadistica extends Pantalla
{
  private PFont fontTitulo;
  private PFont fontTexto;
  private PFont fontOpciones;
  private Estadísticas estadisticas;
  private GameManager gm;
  PantallaEstadistica(GameManager gm)
  {
    super(gm);
    fontTitulo = createFont("data/fonts/PressStart2P-Regular.ttf", 36);
    fontTexto = createFont("data/fonts/PressStart2P-Regular.ttf", 12);
    fontOpciones = createFont("data/fonts/PressStart2P-Regular.ttf", 20);
    

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

    textFont(fontTexto);
    fill(255);
    textAlign(CENTER, CENTER);

    // ─── Header ─────────────────────────────
    String[] headers = {"MAX", "MIN", "AVG", "SD"};
    float startX = width/2 -60;  // center alignment anchor
    float spacing = 120;           // distance between columns

    for (int i = 0; i < headers.length; i++) {
      text("|  " + headers[i] + "  ", startX + i * spacing, 200);
    }
    text("|", startX + headers.length  * spacing - 50, 200); // closing pipe

    // ─── Puntaje ───────────────────────────
    estadisticas.calcularEstadisticas("puntaje");
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
    estadisticas.calcularEstadisticas("tiempo");
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
    estadisticas.calcularEstadisticas("enemigos derrotados");
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
    estadisticas.calcularEstadisticas("enemigos rojos derrotados");
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
    estadisticas.calcularEstadisticas("enemigos verdes derrotados");
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
    estadisticas.calcularEstadisticas("precision disparo");
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

}
  void actualizar()
  {

  }
}
