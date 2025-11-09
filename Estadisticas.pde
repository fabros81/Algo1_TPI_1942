class Estadísticas
{
   //Estadisticas globales
    private String playerID;
    private Table tablaEstadisticas;
    private float max;
    private float min;
    private float media;
    private float desvioEstandar;
    private float winRate;
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
        this.tablaEstadisticas.addColumn("player_id");
        this.tablaEstadisticas.addColumn("win");
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
    public void calcularEstadisticas(String playerID, String columna) 
    {
        this.tablaEstadisticas = loadTable("data/prueba.csv", "header");

        float sumaTotal = 0;
        float max = Float.NEGATIVE_INFINITY;
        float min = Float.POSITIVE_INFINITY;
        float media = 0;
        float desvioEstandar = 0;
        int cantidadPartidas = 0;

        
        Iterable<TableRow> filas = playerID.equals("ALL")
            ? tablaEstadisticas.rows()
            : tablaEstadisticas.findRows(playerID, "player_id");

        // --- Calcular suma, max, min ---
        for (TableRow row : filas) {
            float valor = row.getFloat(columna);
            sumaTotal += valor;
            if (valor > max) max = valor;
            if (valor < min) min = valor;
            cantidadPartidas++;
        }

        if (cantidadPartidas == 0) {
            this.max = 0;
            this.min = 0;
            this.media = 0;
            this.desvioEstandar = 0;
            return;
        }

        // --- Calcular media ---
        media = sumaTotal / cantidadPartidas;

        // --- Calcular desviación estándar ---
        float sumaCuadrados = 0;
        for (TableRow row : filas) {
            float valor = row.getFloat(columna);
            sumaCuadrados += sq(valor - media);
        }

        if (cantidadPartidas > 1) {
            desvioEstandar = sqrt(sumaCuadrados / (cantidadPartidas - 1));
        }

        // --- Guardar resultados ---
        this.max = max;
        this.min = min;
        this.media = media;
        this.desvioEstandar = desvioEstandar;
    }
    public void winRate(String playerID)
    {
        this.tablaEstadisticas = loadTable("data/prueba.csv", "header");
        int wins = 0;
        int total = 0;

        Iterable<TableRow> filas = playerID.equals("ALL")
            ? tablaEstadisticas.rows()
            : tablaEstadisticas.findRows(playerID, "player_id");

        for (TableRow row : filas) {
            total++;
            if (row.getInt("win") == 1) {
                wins++;
            }
        }

        float winRate = total > 0 ? (float) wins / total * 100 : 0;
        this.winRate = winRate;
    }

    
    // ─── Getters ───────────────────────────────
    float getMax() { return this.max; }
    float getMin() { return this.min; }
    float getMedia() { return this.media; }
    float getDesvioEstandar() { return this.desvioEstandar; }
    float getWinRate(){return this.winRate;}


}
