class Partida {
  private AvionAliado jugador;
  private PowUp powUp;
  private float puntaje;
  private ArrayList<Bala> listaBalasAliadas;
  private ArrayList<Bala> listaBalasEnemigas;
  private ArrayList<AvionEnemigo> listaEnemigos;
  private ArrayList<Explosion> explosiones = new ArrayList<Explosion>();


  private Colision colision;
  private Table table;

  private GameManager gm;
  private int nivel = 1;
  private int tiempoInicio; //cuando arranca la partida
  private int tiempoInicioNivel; //cuando arranca un nivel
  private int duracionNivel; //almacena cuanto dura el nivel actual
  private int duracion; //almacena cuanto dura la partida
  private boolean mostrandoPantallaNivel = false;
  private int tiempoTransicionNivel;

  private boolean nivelCompletado = false;
  private boolean kAlreadyProcessed = false; //-----------

  private float puntajeUltimoPowUp = 0;
  private int intervaloPowUp = 1000;

  private int partidaId; // ID de la partida actual

  //Contadores para estadísticas
  private int enemigosDerrotados = 0;
  private int enemigosRojosDerrotados = 0;
  private int enemigosVerdesDerrotados = 0;
  private int balasDisparadas = 0;
  private int balasImpactadas = 0;
  private float precisionDisparo = 0;
  private String playerID;

  private boolean debeReiniciarNivel = false;
  Partida(GameManager gm) {
    this.gm = gm;

    // Inicializar objetos y listas
    //arranco el timer
    tiempoInicio = millis();
    tiempoInicioNivel = millis();
    this.jugador = new AvionAliado(this.gm, width / 2, height - 50);
    this.powUp = new PowUp(this);
    this.jugador.setPowUp(this.powUp);
    this.puntaje = jugador.getPuntaje();
    this.listaBalasAliadas = new ArrayList<Bala>();
    this.listaBalasEnemigas = new ArrayList<Bala>();
    this.listaEnemigos = new ArrayList<AvionEnemigo>();
    this.colision = new Colision();
    this.playerID = gm.getPlayerID();



    // Cargar o crear tabla de puntajes
    this.table = loadTable("data/prueba.csv", "header");
    this.partidaId = table.getRowCount(); // ID basado en la cantidad de filas existentes
    // Iniciar pantalla nivel 1 y Generar enemigos iniciales
    this.tiempoTransicionNivel = millis();
    this.mostrandoPantallaNivel = true;
    generarEnemigos();
  }

  // ─── CREACIÓN DE BALAS ───────────────────────────────
  public void crearBalasAliadas(float x, float y, float direccionX, float direccionY, float velocidad, float radio, float daño) {
    Bala b = new Bala(x, y, direccionX, direccionY, velocidad, radio, daño);
    listaBalasAliadas.add(b);
    balasDisparadas += 1;
  }

  public void crearBalasEnemigas(float x, float y, float direccionX, float direccionY, float velocidad, float radio, float daño)
  {
    Bala b = new Bala(x, y, direccionX, direccionY, velocidad, radio, daño);
    listaBalasEnemigas.add(b);
  }

  // ─── DIBUJADO ────────────────────────────────────────
  void dibujar() {
    for (Bala b : listaBalasAliadas) b.dibujar();
    for (Bala b : listaBalasEnemigas) b.dibujar();
    for (AvionEnemigo e : listaEnemigos) e.dibujar();
    jugador.dibujar();

    for (Explosion ex : explosiones) ex.draw();
    explosiones.removeIf(ex -> ex.isFinished());
  }

  // ─── ACTUALIZACIÓN ───────────────────────────────────
  void actualizar() {
    // Mover y limpiar balas aliadas
    for (Bala b : listaBalasAliadas) b.mover();
    listaBalasAliadas.removeIf(b -> b.getPosicion().y < 20);

    // Mover y limpiar balas enemigas
    for (Bala b : listaBalasEnemigas) b.mover();
    listaBalasEnemigas.removeIf(b -> b.getPosicion().y > height);

    // Mover y disparar enemigos
    for (AvionEnemigo e : listaEnemigos) {
      e.mover();
      e.disparar();
    }

    // Mover y disparar jugador
    jugador.mover();
    jugador.disparar();
    

// ─── PASAR DE NIVEL CON TECLA K ────────────────────
    if (gm.getKPressed()) {
      if (!kAlreadyProcessed) {
        pasarDeNivel();
        kAlreadyProcessed = true;
      }
    } else {
      kAlreadyProcessed = false; // Reset cuando se suelta la tecla
    }
    
    // MODIFICACIÓN TEO
    verificarVictoria();
    
    // Verificar condición de victoria/derrota
    if (jugador != null && !jugador.isAlive) {
        // Jugador perdió
        gm.finalizarPartida(false);
    } else if (jugador != null && jugador.isAlive && nivelCompletado) {
        // Jugador ganó - condición simplificada
        gm.finalizarPartida(true);
    }

// ─── POWER-UPS ──────────────────────────────
    //cada x puntos active un power up random
    if (this.puntaje - this.puntajeUltimoPowUp >= intervaloPowUp)
    {
      int r = int(random(3));
      if (r == 0) powUp.escudo();
      else if (r == 1) powUp.instakill();
      else powUp.multidisparo();
      this.puntajeUltimoPowUp = this.puntaje;
    }

    jugador.actualizarInstakill();
    jugador.actualizarMultidisparo();
// ─── COLISIONES ──────────────────────────────
    //impacto bala aliada con nave enemiga, resto vida y sumo puntos
    for (Bala b : listaBalasAliadas)
    {
      for (AvionEnemigo e : listaEnemigos)
      {
        if (colision.colision(e, b))
        {
          b.colisiono();
          balasImpactadas += 1;
          e.restarVida(b.getDaño());
          if (e.hp <= 0)
          {
            explosiones.add(new Explosion(e.getX(), e.getY(), explode));


            e.murio();
            jugador.sumarPuntos(e.getPuntos());
            this.puntaje = jugador.getPuntaje();
            this.enemigosDerrotados += 1; // Incrementar enemigos derrotados
            if (e instanceof AvionEnemigoRojo) {
              this.enemigosRojosDerrotados += 1;
            } else if (e instanceof AvionEnemigoVerde) {
              this.enemigosVerdesDerrotados += 1;
            }
          }
        }
      }
    }
    jugador.actualizarInvulnerabilidad();
    if (!jugador.getInvulnerable())
    {
      //Aliado vs Bala enemiga
      for (Bala b : listaBalasEnemigas)
      {
        if (colision.colision(jugador, b))
        {
          b.colisiono();
          jugador.activarInvulnerabilidad();
          if (this.jugador.getEscudoActivo() == false)
          {
            jugador.restarVida(b.getDaño());
            if (jugador.hp <= 0)
            {
              jugador.perderVida();
              this.debeReiniciarNivel = true;
            }
          } else
          {
            jugador.setEscudo(false);
          }
        }
      }

      for (AvionEnemigo e : listaEnemigos)
      {
        if (colision.colision(jugador, e))
        {
          jugador.perderVida();
          explosiones.add(new Explosion(e.getX(), e.getY(), explode));
          this.debeReiniciarNivel = true;
        }
      }
    }
    if (this.debeReiniciarNivel)
    {
      reiniciarNivel();
      this.jugador.activarInvulnerabilidad();
      this.debeReiniciarNivel = false;
    }
    // Colisiones
    listaBalasEnemigas.removeIf(Bala::getColisiono);
    listaBalasAliadas.removeIf(Bala::getColisiono);
    listaEnemigos.removeIf(e -> !e.isAlive);


// ─── GESTIÓN DE NIVELES ──────────────────────────────
    //duracion del nivel actual
    duracionNivel = millis() - tiempoInicioNivel;


    // 1 minute 
    if (duracionNivel >= 60_000 && nivel == 1)
    {

      nivel = 2;
      tiempoInicioNivel = millis();
      listaEnemigos.clear();
      listaBalasEnemigas.clear();
      mostrandoPantallaNivel = true;
      tiempoTransicionNivel = millis();
      generarEnemigos();
    }
    //1 minuto
    if (duracionNivel >= 60_000 && nivel == 2)
    {
      nivel = 3;
      tiempoInicioNivel = millis();
      listaEnemigos.clear();
      listaBalasEnemigas.clear();
      mostrandoPantallaNivel = true;
      tiempoTransicionNivel = millis();
      generarEnemigos();
    }

    this.duracion = millis() - tiempoInicio;

    // Si muere el jugador → pasar a pantalla final
    if (!jugador.isAlive || gm.getPartidaGanada()) {
      // Guardar puntaje en CSV
      TableRow newRow = table.addRow();
      newRow.setInt("id", this.partidaId);
      newRow.setFloat("puntaje", jugador.puntaje);
      newRow.setFloat("tiempo", this.duracion); //carga los milisegundos q duro la partida
      newRow.setInt("enemigos derrotados", this.enemigosDerrotados);
      newRow.setInt("enemigos rojos derrotados", this.enemigosRojosDerrotados);
      newRow.setInt("enemigos verdes derrotados", this.enemigosVerdesDerrotados);
      newRow.setString("player_id", this.playerID);

      if (balasDisparadas > 0) {
        precisionDisparo = (float) balasImpactadas / balasDisparadas * 100;
      } else {
        precisionDisparo = 0;
      }
      newRow.setFloat("precision disparo", precisionDisparo);
      saveTable(table, "data/prueba.csv");

      gm.estado = 2;
    }
    
  }
    public void reiniciarNivel()
    {
      listaBalasAliadas.clear();
      listaEnemigos.clear();
      listaBalasEnemigas.clear();
      tiempoInicioNivel = millis();
      jugador.setPos(width / 2, height - 50);
      generarEnemigos();
      //println("Nivel " + nivel + " reiniciado - vidas restantes: " + jugador.getVidas());
    }
    public void verificarVictoria(){
      // Verificar si todos los enemigos fueron eliminados
        // y no hay más oleadas por venir
        if (listaEnemigos.isEmpty() && nivel == 3) { 
            nivelCompletado = true;
        }
    }
    // ─── MÉTODO PARA PASAR DE NIVEL ──────────────────────
  private void pasarDeNivel() {
    if (nivel == 1) {
      println("PASANDO A NIVEL 2 CON TECLA K");
      nivel = 2;
      tiempoInicioNivel = millis();
      duracionNivel = 0;
      listaEnemigos.clear();
      listaBalasEnemigas.clear();
      mostrandoPantallaNivel = true;
      tiempoTransicionNivel = millis();
      jugador.setPos(width / 2, height - 50);
      generarEnemigos();
    } else if (nivel == 2) {
      println("PASANDO A NIVEL 3 CON TECLA K");
      nivel = 3;
      tiempoInicioNivel = millis();
      duracionNivel = 0;
      listaEnemigos.clear();
      listaBalasEnemigas.clear();
      mostrandoPantallaNivel = true;
      tiempoTransicionNivel = millis();
      jugador.setPos(width / 2, height - 50);
      generarEnemigos();
    } else if (nivel == 3) {
      println("PARTIDA COMPLETADA CON TECLA K");
      nivelCompletado = true;
      gm.finalizarPartida(true);
    }
  }

  // ─── ENEMIGOS ────────────────────────────────────────
  void escuadronVerde(int cant, float tAct){
    EscuadronVerde verde1 = new EscuadronVerde(this);
      verde1.añadirEnemigo(cant);
      verde1.mandar(tAct);

    for (int j = 0; j <cant ; j++) {
          int x = int(randomGaussian() * 100 + width / 2); // centrado en el medio de la pantalla
          int y = int(randomGaussian() * 100 - 600);       // aparecen arriba con algo de variación

          AvionEnemigoVerde verde = new AvionEnemigoVerde(x, y);

          // 🔸 Agregar activación escalonada
          verde.setTiempoInicioNivel(this.tiempoInicioNivel);
          verde.setTiempoActivacion(tAct + j * 800); // uno cada ~0.8s después del tiempo i

          listaEnemigos.add(verde);
        }
      }
      
    void escuadronAlfa(int cant,float tAct){
      Escuadron alfa1 = new EscuadronAlfa(this);
      alfa1.añadirEnemigo(cant);
      alfa1.mandar(tAct);
    }
    void escuadronBeta(int cant,float tAct){
      Escuadron beta1 = new EscuadronBeta(this);
      beta1.añadirEnemigo(cant);
      beta1.mandar(tAct);

    }
    void escuadronDelta(int cant, float tAct){
      Escuadron delta1 = new EscuadronDelta(this);
      delta1.añadirEnemigo(cant);
      delta1.mandar(tAct);

    }
    void escuadronGamma(int cant, float tAct){
      Escuadron escGamma = new EscuadronGamma(this);
      escGamma.añadirEnemigo(cant);
      escGamma.mandar(tAct);
    }

    void escuadronEpsilon(int cant, float tAct){
      Escuadron escEpsilon = new EscuadronEpsilon(this);
          
        escEpsilon.añadirEnemigoEspejo(cant);
        escEpsilon.mandar(tAct);

    }
    void escuadronFinal(float tAct){
      EscuadronFinal escFinal = new EscuadronFinal(this);
      escFinal.añadirEnemigo(1);
      escFinal.mandar(tAct);
    }
    
      
      
  void generarEnemigos() {
    switch (nivel) {
    case 1:
      //int[] tiempoSpawnEnemigos = {3000, 7000, 10000};
      //for (int i : tiempoSpawnEnemigos) {}
      
      escuadronVerde(2,2000);
      escuadronAlfa(2,4000);
      escuadronBeta(2,6000);
      escuadronVerde(6,9000);
      escuadronDelta(4,12000);
      escuadronVerde(10,12000);
      escuadronGamma(3,13000);
      escuadronEpsilon(3,15000);



      break;

    case 2:
      // --- FASE 1
      escuadronAlfa(4, 2000);       // izquierda -> derecha (diagonal)
      escuadronBeta(4, 2000);       // derecha -> izquierda (diagonal)
      escuadronVerde(3, 3000);      // dispersión central (gauss vertical)

      // --- FASE 2
      escuadronDelta(3, 8000);     // parábola derecha (entrada suave)
      escuadronGamma(3, 8000);     // parábola invertida (simétrica)
      escuadronEpsilon(2, 9500);   // bajan en línea recta (columna)

      // --- FASE 3
      escuadronAlfa(5, 13000);
      escuadronBeta(5, 13000);
      escuadronVerde(9, 12000);     // ráfaga gaussiana

      // --- FASE 4
      escuadronEpsilon(4, 19000);   // líneas espejo
      escuadronGamma(4, 23000);     // parábola invertida
      escuadronDelta(4, 23000);     // parábola normal
      escuadronVerde(6, 22000);     // última oleada vertical rápida
      escuadronEpsilon(3, 26000);

      // --- FASE 5
      escuadronGamma(4, 28000);
      escuadronDelta(4, 30000);
      escuadronAlfa(5, 32000);
      escuadronBeta(5, 34000);
      escuadronVerde(8, 36000);
      escuadronEpsilon(4, 38000);
      escuadronVerde(5, 40000);

      // --- FASE 6
      escuadronAlfa(6, 42000);
      escuadronBeta(6, 44000);
      escuadronVerde(9, 46000);
      escuadronGamma(5, 48000);
      escuadronDelta(5, 50000);
      escuadronEpsilon(4, 52000);
      escuadronVerde(10, 54000);   // ráfaga final

      break;
    case 3:

      escuadronFinal(5000);
      println("nivel 3"); //imprime en consola
      break;
    }
  }
  

  // ─── getters ────────────────────────────────────────
  public float getPuntos() {
    return this.puntaje;
  }
  public int getPartidaId() {
    return this.partidaId;
  }
  public AvionAliado getJugador() {
    return this.jugador;
  }
  public PowUp getPowUp() {
    return this.powUp;
  }
  public int getDuracion() {
    return this.duracion;
  }
  public int getEnemigosDerrotados() {
    return this.enemigosDerrotados;
  }
  public int getEnemigosRojosDerrotados() {
    return this.enemigosRojosDerrotados;
  }
  public int getEnemigosVerdesDerrotados() {
    return this.enemigosVerdesDerrotados;
  }
  public int getTiempoSupervivencia() {
    return this.duracion / 1000;
  } //retorna en segundos
  public float getPrecisionDisparo() {
    return this.precisionDisparo;
  }
  public int getTiempoInicioNivel() {
    return this.tiempoInicioNivel;
  }
  public int getNivel() {
    return this.nivel;
  }
  public boolean getMostrandoPantallaNivel() {
    return this.mostrandoPantallaNivel;
  }
  public int getTiempoTransicionNivel() {
    return this.tiempoTransicionNivel;
  }

  public void setMostrandoPantallaNivel(boolean i) {
    this.mostrandoPantallaNivel = i;
  }
}

