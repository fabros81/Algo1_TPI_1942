class AvionEnemigoRojo extends AvionEnemigo
{
 private boolean perteneceEscuadron;
 private int direccion = 1;
 private float tiempoActivacion; 
 private float tiempoInicioPartida;
 private Curva recorrido;
 private String curva;
 private int tiempoUltimoDisparo = 0;     // Tiempo del último disparo
 private int delayDisparo = int(random(1500, 4000));
 

 public AvionEnemigoRojo(GameManager gm,float x, float y)
 {
   super(gm,x, y, 20, 3, 20, 100);
   this.perteneceEscuadron = false;
   
 }

 

 public void dibujar()
 { 

   if (!this.perteneceEscuadron){
     
     if (!isAlive) return;  
     fill(255,0,0);
     circle(this.posicion.x, this.posicion.y, this.radio);
  }else {
    if (this.tiempoActivacion + this.tiempoInicioPartida < millis()){
      if (!isAlive) return;  
      fill(255,0,0);
      circle(this.posicion.x, this.posicion.y, this.radio);
    }
    
      
    }
  
    
 }
 
 public void mover()
 {  
    if (!this.perteneceEscuadron){

      this.posicion.x += this.direccion * this.velocidad;
      
      //cuando pega con los bordes laterales, cambia direccion y baja en y
      if (this.posicion.x > width-30 || this.posicion.x <0)
      {
        this.direccion *= (-1);
        this.posicion.y += 50;
      }
    } else {
        this.go();
    }
    //si pasa el borde inferior, mueren
    if (this.posicion.y > height - 50)
    {
      murio();
    }
  }
 
  void go()
  {
    if(this.curva.equals("alfa"))
    {
      if (millis() - this.tiempoInicioPartida >= this.tiempoActivacion)
      {
        this.posicion = this.recorrido.diag(this.getX(),this.getY(),this.getVel());
      }
    }
    if(this.curva.equals("beta"))
    {
      if (millis() - this.tiempoInicioPartida >= this.tiempoActivacion)
      {
        this.posicion = this.recorrido.diagInv(this.getX(),this.getY(),this.getVel());
      }
    }
       
    if(this.curva.equals("delta"))
    {
      if (millis() - this.tiempoInicioPartida >= this.tiempoActivacion)
      {
        this.posicion = this.recorrido.parabolaParametrica(this.getX(),this.getY(),this.getVel());
        
      }
    }
  }    



 
 public void disparar()
 {
   if (!isAlive) return;
   if (this.posicion.y > 0) //dispara solo si está en pantalla
   {
    int tiempoActual = millis();

    if(tiempoActual - tiempoUltimoDisparo >= delayDisparo)
      {
        gm.getPartida().crearBalasEnemigas(this.posicion.x, this.posicion.y,  0, 1, 5, 9, 33.4);
        tiempoUltimoDisparo = tiempoActual;
        delayDisparo = int(random(1000, 4000));
      }
    }
  }
   
 
  public void setPerteneceEscuadron (){this.perteneceEscuadron = true;}
  public float getTiempoActivacion(){return this.tiempoActivacion;}
  public void setTiempoActivacion(float tAct){this.tiempoActivacion = tAct;}
  public void setTiempoInicioPartida(float tIni){this.tiempoInicioPartida = tIni;}
  public void setRecorrido(Curva r){this.recorrido = r;}
  public void setCurva(String c){this.curva = c;}

}
