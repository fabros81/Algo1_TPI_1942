class Colision {

  //chequea si hay colision entre dos circulos, devuelve true si hay colision, false si no

  public boolean colision(AvionAliado a1, AvionEnemigo a2) 
  {
    return dist(a1.posicion.x, a1.posicion.y, a2.posicion.x, a2.posicion.y) <= (a1.radio + a2.radio)/2; 
  }

  public boolean colision(AvionAliado a1, Bala b) 
  {
    return dist(a1.posicion.x, a1.posicion.y, b.posicion.x, b.posicion.y) <= (a1.radio + b.radio)/2; 
  } 
  
  public boolean colision(AvionEnemigo a1, Bala b) 
  {
    return dist(a1.posicion.x, a1.posicion.y, b.posicion.x, b.posicion.y) <= (a1.radio + b.radio)/2; 
  } 
  

 
}
