class Partida {
  AvionAliado jugador;
  PowUp powUp;
  float puntaje;
  ArrayList<Bala> listaBalasAliadas;
  ArrayList<Bala> listaBalasEnemigas;
  ArrayList<AvionEnemigo> listaEnemigos;
  EscuadronAlfa escuadronAlfa;

  Colision colision;
  PFont font;
  Table table;
  
  GameManager gm;
  int nivel = 1;
  int tiempoInicio; //cuando arranca la partida
  int duracion; //almacena cuanto dura la partida
  boolean mostrandoPantallaNivel = false;
  int tiempoTransicionNivel;

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
  Partida(GameManager gm) {
    this.gm = gm;
    
    // Inicializar objetos y listas
    //arranco el timer
    tiempoInicio = millis(); 
    this.jugador = new AvionAliado(this.gm,width / 2, height - 50);
    this.powUp = new PowUp(this);
    this.jugador.setPowUp(this.powUp);
    this.puntaje = jugador.getPuntaje();
    this.listaBalasAliadas = new ArrayList<Bala>();
    this.listaBalasEnemigas = new ArrayList<Bala>();
    this.listaEnemigos = new ArrayList<AvionEnemigo>();
    this.colision = new Colision();
    this.escuadronAlfa = new EscuadronAlfa(tiempoInicio,gm);


    // Cargar o crear tabla de puntajes
    this.table = loadTable("data/prueba.csv", "header");
    this.partidaId = table.getRowCount(); // ID basado en la cantidad de filas existentes
    // Generar enemigos iniciales
    generarEnemigos();
    
  }

  // ─── CREACIÓN DE BALAS ───────────────────────────────
  public void crearBalasAliadas(float x, float y, int direccionX, int direccionY, float velocidad, float radio, float daño) {
    Bala b = new Bala(x, y, direccionX, direccionY, velocidad, radio, daño);
    listaBalasAliadas.add(b);
    balasDisparadas += 1;
  }
  
  public void crearBalasEnemigas(float x, float y, int direccionX, int direccionY, float velocidad, float radio, float daño)
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
    
    if (mostrandoPantallaNivel) 
    {
      background(0);
      fill(255);
      text("NIVEL " + nivel, width / 2, height / 2);
    
      // after 2 seconds, resume gameplay
      if (millis() - tiempoTransicionNivel > 2000) {
        mostrandoPantallaNivel = false;
        generarEnemigos();       // create new enemies for level 2
      }
      return; // stop here so nothing else is drawn
    }
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
  
  
    //cada x puntos active un power up random
    if (this.puntaje - this.puntajeUltimoPowUp >= intervaloPowUp) 
    {
    int r = int(random(3));
    if (r == 0) jugador.activarEscudo();
    else if (r == 1) jugador.activarInstakill();
    else jugador.activarMultidisparo();
    this.puntajeUltimoPowUp = this.puntaje;
    }

    jugador.actualizarInstakill();
    jugador.actualizarMultidisparo();
    //impacto bala aliada con nave enemiga, resto vida y sumo puntos
    for (Bala b: listaBalasAliadas) 
    {
      for (AvionEnemigo e: listaEnemigos)
      {
        if (colision.colision(e,b))
        {
          b.colisiono();
          balasImpactadas += 1; 
          e.restarVida(b.getDaño());
          if (e.hp <= 0)
          {
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
      for (Bala b: listaBalasEnemigas) 
      {      
        if (colision.colision(jugador,b))
        {        
          b.colisiono();
          jugador.activarInvulnerabilidad();
          if (this.jugador.getEscudoActivo() == false)
          {
            jugador.restarVida(b.getDaño());
            if (jugador.hp <= 0)
            {
              jugador.murio();          
            }
          }else 
          {
            jugador.setEscudo(false);
          }        
        }      
      }
      
      for (AvionEnemigo e: listaEnemigos)
      {
        if (colision.colision(jugador, e))
        {
          jugador.murio();
        }
      }
    }
    // Colisiones
    listaBalasEnemigas.removeIf(Bala::getColisiono);
    listaBalasAliadas.removeIf(Bala::getColisiono);
    listaEnemigos.removeIf(e -> !e.isAlive);
    
    
    //tiempo es el tiempo de juego actual
    duracion = millis() - tiempoInicio;

    // 1 minute 30 seconds = 90,000 milliseconds 
    if (duracion >= 90_000 && nivel == 1) 
    {  
      
      nivel = 2;
      listaEnemigos.clear();
      listaBalasEnemigas.clear();  
      mostrandoPantallaNivel = true;
      tiempoTransicionNivel = millis();

      //generarEnemigos();
    }
    if (duracion >= 180_000 && nivel == 2) 
    {
      listaEnemigos.clear();
      listaBalasEnemigas.clear();
      mostrandoPantallaNivel = true;
      tiempoTransicionNivel = millis();

      nivel = 3;
      //generarEnemigos();
    }
    

    // Si muere el jugador → pasar a pantalla final
    if (!jugador.isAlive) {
      // Guardar puntaje en CSV
      TableRow newRow = table.addRow();
      newRow.setInt("id", this.partidaId);
      newRow.setFloat("puntaje", jugador.puntaje);
      newRow.setFloat("tiempo", this.duracion); //carga los milisegundos q duro la partida
      newRow.setInt("enemigos derrotados", this.enemigosDerrotados);
      newRow.setInt("enemigos rojos derrotados", this.enemigosRojosDerrotados);
      newRow.setInt("enemigos verdes derrotados", this.enemigosVerdesDerrotados);
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

  // ─── ENEMIGOS ────────────────────────────────────────
  void generarEnemigos() {
    switch (nivel) {
      case 1:
        // Formación roja
      
        listaEnemigos.add(new EscuadronAlfa(tiempoInicio,gm).delta(3000));
        listaEnemigos.add(new EscuadronAlfa(tiempoInicio,gm).beta(3000));
        listaEnemigos.add(new EscuadronAlfa(tiempoInicio, gm).alfa(3000));
                

        for (float j = 1; j <= 3; j++)
        {
          listaEnemigos.add(new EscuadronAlfa(tiempoInicio,gm).beta(j*500+6000));
          listaEnemigos.add(new EscuadronAlfa(tiempoInicio, gm).alfa(j*500+8000));
          listaEnemigos.add(new EscuadronAlfa(tiempoInicio,gm).delta(j*500+8000));
          
        }
        

        // Verdes distribuidos aleatoriamente
        
        for (int i = 1; i < 20; i++) {
          int x = int(randomGaussian() * 300 + 300);
          int y = int(randomGaussian() * 300 - 500);
          listaEnemigos.add(new AvionEnemigoVerde(this.gm,x, y));
        }
        

        break;

      case 2:

        
        println("nivel 2"); //imprime en consola
        
        break;
      case 3:
        
        
        println("nivel 3"); //imprime en consola
        break;
    }
  }
  
  // ─── getters ────────────────────────────────────────
  public float getPuntos(){return this.puntaje;}
  public int getPartidaId(){return this.partidaId;}
  public AvionAliado getJugador(){return this.jugador;}
  public PowUp getPowUp(){return this.powUp;}
  public int getDuracion(){return this.duracion;}
  public int getEnemigosDerrotados(){return this.enemigosDerrotados;}
  public int getEnemigosRojosDerrotados(){return this.enemigosRojosDerrotados;}
  public int getEnemigosVerdesDerrotados(){return this.enemigosVerdesDerrotados;}
  public int getTiempoSupervivencia(){return this.duracion / 1000;} //retorna en segundos
  public float getPrecisionDisparo(){return this.precisionDisparo;}
}