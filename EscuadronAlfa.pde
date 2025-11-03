public class EscuadronAlfa extends Escuadron{

public EscuadronAlfa(float tiempoInicioPartida){
    super(tiempoInicioPartida);
    
    
    
}
    AvionEnemigoRojo alfa(float tAct){
        
        AvionEnemigoRojo e = new AvionEnemigoRojo(-20,-20);    
        e.setPerteneceEscuadron(true);
        e.setTiempoActivacion(tAct);
        e.setTiempoInicioPartida(tiempoInicioPartida);
        e.setRecorrido(new Curva());
        e.setCurva("alfa");
        return e;
   }
    
    AvionEnemigoRojo beta(float tAct){
        
        AvionEnemigoRojo e = new AvionEnemigoRojo(820,-20);    
        e.setPerteneceEscuadron(true);
        e.setTiempoActivacion(tAct);
        e.setTiempoInicioPartida(tiempoInicioPartida);
        e.setRecorrido(new Curva());
        e.setCurva("beta");
        return e;
   }    

   AvionEnemigoRojo delta(float tAct){
        
        AvionEnemigoRojo e = new AvionEnemigoRojo(400,0);    
        e.setPerteneceEscuadron(true);
        e.setTiempoActivacion(tAct);
        e.setTiempoInicioPartida(tiempoInicioPartida);
        e.setRecorrido(new Curva());
        e.setCurva("delta");
        return e;
   } 
}
 
