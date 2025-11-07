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
  PFont fontID;
  private boolean ingresandoID;
  private String playerID;
    
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
    fontID = createFont("data/fonts/PressStart2P-Regular.ttf", 16);
    this.ingresandoID = false;
    this.playerID = "";
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
  public void resetearEstado() {
    this.ingresandoID = false;
    this.playerID = "";
    this.posicionFlecha = 0;
    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];
  }

void dibujar()
  {
    if (this.imgInicio != null && this.flecha != null) 
    { background(0);
      image(this.imgInicio, width/2, height/2, width, height); 
      contadorParpadeo++; 
      if (ingresandoID) {
      dibujarPantallaID();
      return;
      } 
      else {
      dibujarMenuNormal();
      }
        
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
void dibujarMenuNormal() {
    contadorParpadeo++; 
     
    if ( contadorParpadeo >= 30 && contadorParpadeo <=100)
    {flechaVisible = true;
    } else {flechaVisible = false;}
    
    if (flechaVisible == true)
    {image(flecha, x + 10, y+15, 30, 30);}
    
    if (contadorParpadeo >70) 
    {contadorParpadeo = 0;
     flechaVisible = false;}
 }
 
 void dibujarPantallaID() {
    // Fondo transparente
    
   // noStroke();
   // fill(30, 30, 30, 200); // darker background, more transparent
    //rect(width/2, (height/2) + 50, 600, 300, 20); // rounded corners make it feel softer
    noStroke();
    fill(0, 0, 0, 80);
    rect(width/2, (height/2) + 50, 600, 300, 20); // shadow offset
    fill(30, 30, 30, 150);
    rect(width/2, (height/2) + 50, 600, 300, 20);


    // Título
    fill(255);
    
    textAlign(CENTER, CENTER);
    textSize(24);
    textFont(fontID);
    text("INGRESA TU ID", width/2 - 30, height/2 - 50);
    
    String idMostrar = playerID;
    while (idMostrar.length() < 3) {
      idMostrar += "_";
    }
 
    textSize(16);
    text(idMostrar, width/2 - 30, height/2);
    
    // Instrucciones
    //fill(255);
    fill(255, 255, 0);
    if (playerID.length() == 3) 
    {
      textFont(fontID);
      text("Presiona ESPACIO para jugar", width/2 - 30, height/2 + 50);
    } 
    fill(255, 255, 0);
    text("Presiona TAB para volver al menú", width/2 - 30, height/2 + 100);
  }


 
 
   
  void actualizar()
  { int tiempoActual = millis();
    if (ingresandoID) {
      
      if (playerID.length() == 3 && gm.getSpacePressed()) {
        gm.setPlayerID(playerID);
        gm.iniciarPartida();
      }
      return;
    }
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

 void keyTyped() {
   if (ingresandoID && playerID.length() < 3) {
     if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
       playerID += Character.toUpperCase(key);
     }
   }
 }

 void keyPressed() {
   if (ingresandoID) {
     if (key == ' ') {
       if (playerID.length() == 3) {
         gm.setPlayerID(playerID);
         gm.iniciarPartida();
       }
     } else if (key == TAB) {
       ingresandoID = false;
     } else if (key == BACKSPACE && playerID.length() > 0) {
       playerID = playerID.substring(0, playerID.length() - 1);
     }
   }
 }
  public int getPosicionFlecha(){return this.posicionFlecha;}
  
   public void iniciarIngresoID() {
    this.ingresandoID = true;
    this.playerID = "";
  }
  public boolean isIngresandoID() {
    return ingresandoID;
  }
}
