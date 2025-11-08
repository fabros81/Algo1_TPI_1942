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



PVector parabolaParametrica(float ox, float oy, float velocidadT) {
    // velocidad controlada por el parámetro acumulado
    parametroT += velocidadT / 300; // podés ajustar el divisor para suavizar más

    // define la forma de la parábola (ajustá 600 y 240 para más o menos amplitud)
    float x = 400 + parametroT * 200; // el centro es 400, se desplaza 200px aprox.
    float y = 1.0f / 240.0f * (x - 400) * (x - 400);

    return new PVector(x, y);
}




PVector parabolaParametricaInv(float ox, float oy, float velocidadT) {
    // velocidad controlada por el parámetro acumulado
    parametroT += velocidadT / 300; // podés ajustar el divisor para suavizar más

    // define la forma de la parábola (ajustá 600 y 240 para más o menos amplitud)
    float x = 400 - parametroT * 200; // el centro es 400, se desplaza 200px aprox.
    float y = 1.0f / 240.0f * (x - 400) * (x - 400);

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

//JEFE----------------------------------------
// tiempos independientes por tipo de curva
  
  private float tEntrada = 0;
  private float tOcho = 0;
  private float tHorizontal = 0;


  // flags de ciclo completo
  private boolean cicloOcho = false;
  private boolean cicloHorizontal = false;


  // ---- ENTRADA ----
  
  PVector curvaJefeEntrada(float velocidadT, float alturaObjetivo) {
    // más lenta: divisor más grande → acumula más despacio
    tEntrada += velocidadT / 600.0;  // antes era /200, ahora 3 veces más lenta
    
    // menor pendiente → baja con suavidad
    float y = constrain(tEntrada * 100, -100, alturaObjetivo);
    
    // leve oscilación mientras baja
    float x = width / 2;
    
    return new PVector(x, y);
  }

  // ---- OCHO ----
  PVector curvaJefeOcho(float velocidadT, float alturaObjetivo) {
    tOcho += velocidadT / 200.0;
    float x = width / 2 + sin(tOcho) * 200;
    float y = alturaObjetivo + sin(tOcho * 2) * 100;
    cicloOcho = (tOcho >= TWO_PI);
    if (cicloOcho) tOcho -= TWO_PI;
    return new PVector(x, y);
  }

  boolean completoOcho() { return cicloOcho; }

  // ---- HORIZONTAL ----
  PVector curvaHorizontal(float velocidadT, float alturaObjetivo) {
  tHorizontal += velocidadT / 100.0;

  float amplitud = 320; // distancia lateral máxima (ajustable)
  float x = width / 2 + sin(tHorizontal) * amplitud;
  float y = alturaObjetivo;

  // Detecta ciclo completo (ida y vuelta)
  cicloHorizontal = (tHorizontal >= TWO_PI);
  if (cicloHorizontal) tHorizontal -= TWO_PI;

  return new PVector(x, y);
}

  boolean cicloHorizontal() { return cicloHorizontal; }

  
}

