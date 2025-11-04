class Curva {
  private PVector posicion;
  private float parametroT; 
  private float velocidadT;
  
  
  // Constructor
 public Curva() {
    this.parametroT = 0;
  }
  

  PVector parabolaIzqDer(float ox, float oy, float velocidadT ){
      this.posicion = new PVector (ox,oy);
      this.velocidadT = velocidadT;
      parametroT += velocidadT;
    
      float x = parametroT*600 ;
      float y = 600 * (1-parametroT)*parametroT ;
      
      return new PVector(x, y);
    
  }
  
    PVector parabolaDerIzq(float ox, float oy, float velocidadT ){
      this.posicion = new PVector (ox,oy);
      this.velocidadT = velocidadT;
      parametroT += velocidadT;
    
      float x = 600- (parametroT*600) ;
      float y = 400 * (1-parametroT)*parametroT ;
      
      return new PVector(x, y);
          
  }

  /*
  PVector parabolaParametrica(float ox, float oy, float velocidadT){
    // recoorrido pensadopara arrancar de (400,0) y terminar en [?,600]
    // (t,1/80(t-400)^2) , t pertenece [400,619]
    // la velocidad esta seteada hoy en 3

    
      //t += velocidadT /150;
      parametroT = ox + 1;
      
      float x = parametroT;
      float y = 1.0f/240.0f*(parametroT-400)*(parametroT-400);
      return new PVector(x, y);
     }*/

PVector parabolaParametrica(float ox, float oy, float velocidadT) {
    // velocidad controlada por el parámetro acumulado
    parametroT += velocidadT / 300; // podés ajustar el divisor para suavizar más

    // define la forma de la parábola (ajustá 600 y 240 para más o menos amplitud)
    float x = 400 + parametroT * 200; // el centro es 400, se desplaza 200px aprox.
    float y = 1.0f / 240.0f * (x - 400) * (x - 400);

    return new PVector(x, y);
}


 /*
  PVector parabolaParametricaInv(float ox, float oy, float velocidadT){
  // recoorrido pensadopara arrancar de (400,0) y terminar en [?,600]
  // (t,1/80(t-400)^2) , t pertenece [400,619]
  // la velocidad esta seteada hoy en 3

  
    //t += velocidadT /150;
    parametroT= ox - 1;
    
    float x = parametroT;
    float y = 1.0f/240.0f*(parametroT-400)*(parametroT-400);
    return new PVector(x, y);
  }*/
 

PVector parabolaParametricaInv(float ox, float oy, float velocidadT) {
    // velocidad controlada por el parámetro acumulado
    parametroT += velocidadT / 300; // podés ajustar el divisor para suavizar más

    // define la forma de la parábola (ajustá 600 y 240 para más o menos amplitud)
    float x = 400 - parametroT * 200; // el centro es 400, se desplaza 200px aprox.
    float y = 1.0f / 240.0f * (x - 400) * (x - 400);

    return new PVector(x, y);
}



  
    PVector coseno(float ox, float oy, float velocidadT ){
    this.posicion = new PVector (ox,oy);
    this.velocidadT = velocidadT;
    parametroT += velocidadT/100;
  
    float x = 400+ cos(parametroT)*200;
    float y = parametroT;
    
    return new PVector(x, y);
    }

    PVector monio(float ox, float oy, float velocidadT ){
      this.posicion = new PVector (ox,oy);
      this.velocidadT = velocidadT;
      parametroT += velocidadT;
    
      
    
    float x = pow(parametroT,2)-1;
    float y = pow(parametroT,3)-parametroT;
    
      return new PVector(x, y);
    
  }
  
    PVector diag(float ox, float oy, float velocidadT ){
      // la velocidad esta seteada hoy en 3
      this.velocidadT = velocidadT;
      parametroT += velocidadT /150;
    
      float x = ox + parametroT;
      float y = oy + parametroT*0.7;
      
      return new PVector(x, y);
    
  }  
 
  PVector diagInv(float ox, float oy, float velocidadT ){
      // la velocidad esta seteada hoy en 3
      
      this.velocidadT = velocidadT;
      parametroT += velocidadT /300;
    
      float x = ox - parametroT;
      float y = oy + parametroT*0.8;
      //System.out.println("x: "+ this.posicion.x + "y: "+ this.posicion.y);
      
      return new PVector(x, y);
    
  }  

  PVector rectaHorizontal(float ox, float oy, float velocidadT) {
    // Mantiene la posición X constante (ox)
    this.velocidadT = velocidadT;
    parametroT += velocidadT / 100;  // controla la velocidad de bajada

    float x = ox;                   // fijo
    float y = oy + parametroT;      // se desplaza en Y

    return new PVector(x, y);
  }



}
