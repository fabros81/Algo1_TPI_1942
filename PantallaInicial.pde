import java.io.FileNotFoundException;

class PantallaInicial
{
  private GameManager gm;
  //private PFont font;
  private PImage imgInicio;
  private int delayTecla;
  private int ultimoMillisTecla;
  private PImage flecha;
  private boolean flechaVisible;
  private int contadorParpadeo;
  private int posicionFlecha;
  private int[][] posiciones = {{250, 320},{250, 360}, {250, 410} };
  private int x;
  private int y;

    
  PantallaInicial(GameManager gm)
  {
    this.gm = gm;
    //this.font = createFont("data/fonts/PressStart2P-Regular.ttf", 32);
    this.delayTecla = 300;
    this.ultimoMillisTecla =0;
    this.flechaVisible =true;
    this.contadorParpadeo = 0;
    this.posicionFlecha = 0; // esto puede ser 0,1 o 2 (actualizar lo ajusta cuando se toca tecla)
    //this.estado = 0;
    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];
        try {
            this.imgInicio = loadImage("background_inicio.jpg");  
            if (this.imgInicio == null) {
                throw new FileNotFoundException("No se pudo cargar la imagen de inicio");
            } else {
                this.imgInicio.resize(800, 600); 
            }
        } catch (Exception e) {
            System.err.println("Error cargando imagen: " + e.getMessage());
            this.imgInicio = null;
        }
        
        try {
            this.flecha = loadImage("a.png");
            if (this.flecha == null) {
                throw new FileNotFoundException("No se pudo cargar la imagen de flecha");
            }
        } catch (Exception e) {  
            System.err.println("Error cargando imagen: " + e.getMessage());
            this.flecha = null;
        }
  }



  void dibujar(){
         if (this.imgInicio != null && this.flecha != null) 
        {background(0);
          image(this.imgInicio, width/2, height/2, width, height); 
               contadorParpadeo++; 
         
              if ( contadorParpadeo >= 30 && contadorParpadeo <=50)
              {flechaVisible = true;
              } else {flechaVisible = false;}
              
              if (flechaVisible == true)
              {image(flecha, x + 10, y+15, 30, 30);}
              
              if (contadorParpadeo >40) 
              {contadorParpadeo = 0;
               flechaVisible = false;}
            
            
        } else 
        {background(0); 
        fill(255);
        text("Error: Imagen/es de pantalla de inicio no encontrada", 50, height/2);
        
              // Msj
              if (this.imgInicio == null) 
              {text("• Fondo no cargado", 70, height/2 + 20);}
              
              if (this.flecha == null) {text("• Flecha no cargada", 70, height/2 + 40);}
        }
 }

 
 
   
  void actualizar()
  { int tiempoActual = millis();
    if (gm.getDownPressed() && tiempoActual - ultimoMillisTecla >= delayTecla ){
      this.posicionFlecha = this.posicionFlecha +1 ;
        if (this.posicionFlecha >2){this.posicionFlecha = 0;
        }
      this.x = posiciones[this.posicionFlecha][0];
      this.y = posiciones[this.posicionFlecha][1];
      ultimoMillisTecla = tiempoActual;
    }
     if (gm.getUpPressed() && tiempoActual - ultimoMillisTecla >= delayTecla ){
      this.posicionFlecha = this.posicionFlecha -1 ;
        if (this.posicionFlecha <0){this.posicionFlecha = 2;
        }
      this.x = posiciones[this.posicionFlecha][0];
      this.y = posiciones[this.posicionFlecha][1];
      ultimoMillisTecla = tiempoActual;
    }
 }
    
  }


