import java.io.FileNotFoundException;

class PantallaInicial extends Pantalla
{
  //private PFont font;
  private PImage imgInicio;
  private PImage flecha;
  private int posicionFlecha;
  private int[][] posiciones = {{250, 320},{250, 360}, {250, 410}, {250, 450}};
  private int x;
  private int y;
  PFont fontID, fontTexto, fontOpciones;
  private boolean ingresandoID;
  private String playerID;
    
  PantallaInicial(GameManager gm)
  {
    super(gm);
    //this.font = createFont("data/fonts/PressStart2P-Regular.ttf", 32);
    this.posicionFlecha = 0; // esto puede ser 0,1 o 2 (actualizar lo ajusta cuando se toca tecla)
    //this.estado = 0;
    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];
    fontID = createFont("data/fonts/PressStart2P-Regular.ttf", 16);
    fontTexto = createFont("data/fonts/PressStart2P-Regular.ttf", 14);
    this.ingresandoID = false;
    this.playerID = "";
    try {
        this.imgInicio = loadImage("background_inicio.jpg");  
        if (this.imgInicio == null) {
            throw new FileNotFoundException("No se pudo cargar la imagen de inicio");
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
    actualizarPosicionFlecha();
  }

void dibujar()
  {
    if (this.imgInicio != null && this.flecha != null) 
    { 
      background(0);
      image(this.imgInicio, width/2, height/2, width, height); 
      if (ingresandoID) 
      {
        dibujarPantallaID();
        return;
      } else 
      {
        if ((millis() / 350) % 2 == 1) //flecha parpadeante
        {
         image(flecha, x + 10, y + 15, 30, 30);
        }
        // Instrucciones
        textFont(fontTexto);
        fill(255, 255, 0); // Amarillo para instrucciones
        textAlign(CENTER, CENTER);
        text("Usa ↑ ↓ para navegar, ESPACIO para seleccionar", width/2, height-15);
      }
    } else //si no estan las imagenes
    {
      background(0); 
      fill(255);
      text("Error: Imagen/es de pantalla de inicio no encontrada", 50, height/2);
      
      // Msj
      if (this.imgInicio == null) 
      {text("• Fondo no cargado", 70, height/2 + 20);}
      
      if (this.flecha == null) {text("• Flecha no cargada", 70, height/2 + 40);}
    }
  }

 void dibujarPantallaID() {
    
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
  { 
    if (ingresandoID) {
      
      // avisa a GameManager si se presiona espacio y el ID tiene 3 caracteres
      if (playerID.length() == 3 && gm.getSpacePressed()) {
        gm.opcionSeleccionada("inicial", -1);
      }
      return;
    }
    if (gm.getDownPressed() && frameCount % 9 == 0){
      this.posicionFlecha = this.posicionFlecha +1 ;
      if (this.posicionFlecha >3){this.posicionFlecha = 0;}
      actualizarPosicionFlecha();
    }
     if (gm.getUpPressed()&& frameCount % 9 == 0){
      this.posicionFlecha = this.posicionFlecha -1 ;
      if (this.posicionFlecha <0){this.posicionFlecha = 3;}
      actualizarPosicionFlecha(); 
    }
 }

 void keyTyped() {
   if (ingresandoID && playerID.length() < 3) {
     if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
       playerID += Character.toUpperCase(key);
     }
   }
 }

  void keyPressed() 
  {
    if (ingresandoID) 
    {
      if (key == TAB) {
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

  private void actualizarPosicionFlecha() 
  {
    this.x = posiciones[this.posicionFlecha][0];
    this.y = posiciones[this.posicionFlecha][1];
  }
  public String getPlayerID() { return this.playerID; }

}
