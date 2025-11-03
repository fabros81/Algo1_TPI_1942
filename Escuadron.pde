abstract class  Escuadron {
    ArrayList<AvionEnemigoRojo> enemigos;
    AvionEnemigoRojo enemigo;  
    //Curva recorrido;
    boolean activo ;
    float tiempoActivacion;
    float tiempoInicioPartida;
    //PVector pos;
  GameManager gm;
    

  public Escuadron(float tInicioPartida,GameManager gm){
    this.gm = gm;
    this.activo= false;
    this.tiempoInicioPartida = tInicioPartida;
    //this.recorrido = new Curva()  ;
    
    
    
  }
  public float getTiempoInicioPartida(){return this.tiempoInicioPartida;}
  public void addEnemigos(AvionEnemigoRojo e){this.enemigo = e;}
  public void setTiempoActivacion(float t){this.tiempoActivacion =t;}
  public void setEnemigo(AvionEnemigoRojo e){this.enemigo = e;}
  
  
  


  }
