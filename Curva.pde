import processing.core.PVector;
import processing.core.PApplet;

class Curva {
  private PVector posicion;
  private float t; 
  private float velocidadT;
  
  
  // Constructor
 public Curva() {
    this.t = 0;
    
    
  }
  

  PVector parabolaIzqDer(float ox, float oy, float velocidadT ){
      this.posicion = new PVector (ox,oy);
      this.velocidadT = velocidadT;
      t += velocidadT;
    
      float x = t*600 ;
      float y = 600 * (1-t)*t ;
      
      return new PVector(x, y);
    
  }
  
    PVector parabolaDerIzq(float ox, float oy, float velocidadT ){
      this.posicion = new PVector (ox,oy);
      this.velocidadT = velocidadT;
      t += velocidadT;
    
      float x = 600- (t*600) ;
      float y = 400 * (1-t)*t ;
      
      return new PVector(x, y);
          
  }

  
  PVector parabolaParametrica(float ox, float oy, float velocidadT){
    // recoorrido pensadopara arrancar de (400,0) y terminar en [?,600]
    // (t,1/80(t-400)^2) , t pertenece [400,619]
    // la velocidad esta seteada hoy en 3

    
      //t += velocidadT /150;
      t= ox + 1;
      
      float x = t;
      float y = 1.0f/240.0f*(t-400)*(t-400);
      System.out.println("curva: x: "+x+", y: "+y);
      return new PVector(x, y);
     }
 
  
      PVector coseno(float ox, float oy, float velocidadT ){
      this.posicion = new PVector (ox,oy);
      this.velocidadT = velocidadT;
      t += velocidadT/100;
    
      float x = 400+ cos(t)*200;
      float y = t;
      
      return new PVector(x, y);
    
  }

    PVector monio(float ox, float oy, float velocidadT ){
      this.posicion = new PVector (ox,oy);
      this.velocidadT = velocidadT;
      t += velocidadT;
    
      
    
    float x = pow(t,2)-1;
    float y = pow(t,3)-t;
    
      return new PVector(x, y);
    
  }
  
    PVector diag(float ox, float oy, float velocidadT ){
      // la velocidad esta seteada hoy en 3
      this.velocidadT = velocidadT;
      t += velocidadT /150;
    
      float x = ox + t;
      float y = oy + t;
      
      return new PVector(x, y);
    
  }  
 
  PVector diagInv(float ox, float oy, float velocidadT ){
      // la velocidad esta seteada hoy en 3
      
      this.velocidadT = velocidadT;
      t += velocidadT /300;
    
      float x = ox - t;
      float y = oy + t;
      //System.out.println("x: "+ this.posicion.x + "y: "+ this.posicion.y);
      
      return new PVector(x, y);
    
  }  

}
