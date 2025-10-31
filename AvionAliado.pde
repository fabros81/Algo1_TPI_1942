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
  private Partida partida;


  public AvionAliado(GameManager gm, float x, float y){
    super(gm,x, y, 40, 5, 100);
    this.gm = gm;
  }

  public void sumarPuntos(float i){this.puntaje += i;}
  public float getPuntaje(){return this.puntaje;}
  public float getHp(){return this.hp;}
  public float getVelocidad(){return this.velocidad;}
  public PowUp getPowUp(){return this.powUp;}
  public boolean getEscudoActivo(){return this.escudoActivo;}
  public void setEscudo(boolean i){this.escudoActivo = i;}
  public void setPowUp(PowUp i){this.powUp = i;}

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
  
  public void activarEscudo()
  {
    powUp.escudo();
  }




  public void dibujar()
  {
    if (!isAlive) return;
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
        powUp.multidisparo();
        actualizarMultidisparo();
      }
      else if (instakillActivo)
      {
        powUp.instakill();
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