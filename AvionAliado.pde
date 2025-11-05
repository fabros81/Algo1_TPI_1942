class AvionAliado extends Avion
{
  private int tiempoUltimoDisparo = 0;     // Tiempo del último disparo
  private int delayDisparo = 300;  //delay disparo
  private float puntaje = 0.0;
  private PowUp powUp;
  private boolean multidisparoActivo = false;
  private boolean instakillActivo = false;
  private boolean escudoActivo = false;
  private int tiempoMultidisparo;
  private int tiempoInstakill;
  private int duracionPowUp = 5000;
  private boolean invulnerable = false;
  private int tiempoInvulnerableInicio = 0;
  private int duracionInvulnerable = 2000;
  private int vidas = 3;
  private GameManager gm;

  public AvionAliado(GameManager gm, float x, float y){
    super(x, y, 40, 5, 100);
    this.gm = gm;
  }
  public void setPos(float x, float y)
  {
    this.posicion.x = x;
    this.posicion.y = y;
  }
  public int getVidas(){return this.vidas;}
  public boolean getInvulnerable(){return this.invulnerable;}
  public void sumarPuntos(float i){this.puntaje += i;}
  public float getPuntaje(){return this.puntaje;}
  public float getHp(){return this.hp;}
  public float getVelocidad(){return this.velocidad;}
  public PowUp getPowUp(){return this.powUp;}
  public boolean getEscudoActivo(){return this.escudoActivo;}
  public boolean getMultidisparoActivo(){return this.multidisparoActivo;}
  public boolean getInstakillActivo(){return this.instakillActivo;}
  public void setEscudo(boolean i){this.escudoActivo = i;}
  public void setPowUp(PowUp i){this.powUp = i;}

  public void perderVida()
  {
    if (this.vidas > 1)
    {
      this.vidas -= 1;
      this.hp = 100;
      //println("Perdiste una vida " + this.vidas);
    }else{
      this.murio();
    }
    
  }


  void activarInvulnerabilidad() {
  invulnerable = true;
  tiempoInvulnerableInicio = millis();
  }

  void actualizarInvulnerabilidad() {
    if (invulnerable && millis() - tiempoInvulnerableInicio > duracionInvulnerable) {
      invulnerable = false;
    }
  }


  public void activarMultidisparo()
  {
    this.multidisparoActivo = true;
    this.tiempoMultidisparo = millis();
  }
  public void actualizarMultidisparo() {
    if (multidisparoActivo && millis() - tiempoMultidisparo > duracionPowUp) {
        multidisparoActivo = false;
    }
  }
  public void activarInstakill()
  {
    this.instakillActivo = true;
    this.tiempoInstakill = millis();
  }
  public void actualizarInstakill()
  {
    if (instakillActivo && millis() - tiempoInstakill > duracionPowUp) {
        instakillActivo = false;
    }
  }
  





  public void dibujar()
  {
    if (!isAlive) return;
    if (invulnerable && (millis() / 100) % 2 == 0) return; // simple flicker

    //fill(0,0,255);
    // circle(this.posicion.x,this.posicion.y , this.radio);
    if (escudoActivo)
    {
      fill(255, 200,   0);
      circle(this.posicion.x, this.posicion.y, this.radio+1);
      //santi pone una burbuja o un aura.
    }
    image(avionJugadorGIF, this.posicion.x, this.posicion.y, this.radio, this.radio);
    dibujarBarraSalud();
    
  } 
  
  public void mover()
  {
    if (!isAlive) return;
      
    if (gm.getLeftPressed()) this.posicion.x -= this.velocidad;
    if (gm.getRightPressed()) this.posicion.x += this.velocidad;
    if (gm.getUpPressed()) this.posicion.y -= this.velocidad;
    if (gm.getDownPressed()) this.posicion.y += this.velocidad;
    
     this.posicion.x = constrain ( this.posicion.x, 30, width-30);
     this.posicion.y = constrain (this.posicion.y, 30, height-30);
  }
  
  public void disparar()
  {
    int tiempoActual = millis();
    if (!isAlive) return;
    if(gm.spacePressed && tiempoActual - tiempoUltimoDisparo >= delayDisparo)
    { 
      if (multidisparoActivo)
      {
      gm.getPartida().crearBalasAliadas(this.posicion.x , this.posicion.y, 0, -1, 8, 9, 10); // arriba
      gm.getPartida().crearBalasAliadas(this.posicion.x , this.posicion.y, 0, 1, 8, 9, 10); // abajo 
      gm.getPartida().crearBalasAliadas(this.posicion.x , this.posicion.y, 1, 0, 8, 9, 10); // derecha
      gm.getPartida().crearBalasAliadas(this.posicion.x , this.posicion.y, -1, 0, 8, 9, 10); // izquierda
      gm.getPartida().crearBalasAliadas(this.posicion.x , this.posicion.y, -1, 1, 8, 9, 10); // abajo izquierda
      gm.getPartida().crearBalasAliadas(this.posicion.x , this.posicion.y, 1, 1, 8, 9, 10); // abajo derecha
      gm.getPartida().crearBalasAliadas(this.posicion.x , this.posicion.y, -1, -1, 8, 9, 10); // arriba izquierda
      gm.getPartida().crearBalasAliadas(this.posicion.x , this.posicion.y, 1, -1, 8, 9, 10); // arriba derecha
        actualizarMultidisparo();
      }
      else if (instakillActivo)
      {
        gm.getPartida().crearBalasAliadas(this.posicion.x , this.posicion.y, 0, -1, 8, 9, 1000); 
        actualizarInstakill();
      }
      else
      {
        gm.getPartida().crearBalasAliadas(this.posicion.x-10, this.posicion.y, 0, -1, 8, 9, 10);
        gm.getPartida().crearBalasAliadas(this.posicion.x+10, this.posicion.y, 0, -1, 8, 9, 10);
      }
    
      tiempoUltimoDisparo = tiempoActual;
    }
  }

    // dibuja una barra de salud bajo el avión
  private void dibujarBarraSalud() {
    
    float barAncho = 46;              
    float barAltura = 6;               
    float x = this.posicion.x; 
    float y = this.posicion.y + this.radio;

    float porcentajeSalud = constrain(this.hp / 100, 0, 1);

    // --- colors (green → yellow → red) ---
    int green  = color(  0, 200,   0);
    int yellow = color(255, 200,   0);
    int red    = color(255,   0,   0);

    int fillCol = (porcentajeSalud >= 0.5)
    //funciona como un if
        ? lerpColor(yellow, green, map(porcentajeSalud, 0.5, 1, 0, 1)) //si hp >= 50% 
        : lerpColor(red,  yellow, map(porcentajeSalud, 0, 0.5, 0, 1)); //si hp < 50%

    pushStyle();
    noStroke();

    // background bar
    fill(GRAY);
    rect(x, y, barAncho, barAltura, 2); // el 2 hace las esquinas redondeadas

    // barra de salud
    fill(fillCol);
    rect(x, y, barAncho * porcentajeSalud, barAltura, 2);

    
    popStyle();
  }

}
