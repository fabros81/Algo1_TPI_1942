class Estadísticas
{
   //Estadisticas globales
    
    private Table tablaEstadisticas;
    private float max;
    private float min;
    private float media;
    private float desvioEstandar;

    Estadísticas()
    {
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
        this.tablaEstadisticas.addColumn("precision disparo");
        this.tablaEstadisticas.addColumn("player");
      }
        
    }


    public void calcularEstadisticas(String columna)
    {
        this.tablaEstadisticas = loadTable("data/prueba.csv", "header");
        float sumaTotal = 0;
        float max = Float.NEGATIVE_INFINITY;
        float min = Float.POSITIVE_INFINITY;
        float media = 0;
        float desvioEstandar = 0;
        int cantidadPartidas = tablaEstadisticas.getRowCount();

        if (cantidadPartidas == 0) {
            println("No hay datos disponibles para calcular estadísticas.");
            return;
        }
        for (TableRow row: tablaEstadisticas.rows())
        {
            float valor = row.getFloat(columna);
            sumaTotal += valor;
            if (valor > max) {
                max = valor;
            }
            if (min == 0 || valor < min) {
                min = valor;
            }
        }
        media = sumaTotal / cantidadPartidas;

        float sumaCuadrados = 0;
        for (TableRow row: tablaEstadisticas.rows())
        {
            float valor = row.getFloat(columna);
            sumaCuadrados += sq(valor - media);
        }
        if (cantidadPartidas > 1) {
            desvioEstandar = sqrt(sumaCuadrados / (cantidadPartidas - 1));
        } else {
            desvioEstandar = 0;
}
        this.max = max;
        this.min = min;
        this.media = media;
        this.desvioEstandar = desvioEstandar;
    }
    // ─── Getters ───────────────────────────────
    float getMax() { return this.max; }
    float getMin() { return this.min; }
    float getMedia() { return this.media; }
    float getDesvioEstandar() { return this.desvioEstandar; }



}
