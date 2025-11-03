public class EscuadronAlfa extends Escuadron{

public EscuadronAlfa(float tiempoInicioPartida,GameManager gm){
    super(tiempoInicioPartida,gm);
    
    
    
}
    AvionEnemigoRojo alfa(float tAct){
        
        AvionEnemigoRojo e = new AvionEnemigoRojo(gm,-20,-20);    
        e.setPerteneceEscuadron();
        e.setTiempoActivacion(tAct);
        e.setTiempoInicioPartida(tiempoInicioPartida);
        e.setRecorrido(new Curva());
        e.setCurva("alfa");
        return e;
   }
    
    AvionEnemigoRojo beta(float tAct){
        
        AvionEnemigoRojo e = new AvionEnemigoRojo(gm,820,-20);    
        e.setPerteneceEscuadron();
        e.setTiempoActivacion(tAct);
        e.setTiempoInicioPartida(tiempoInicioPartida);
        e.setRecorrido(new Curva());
        e.setCurva("beta");
        return e;
   }    

   AvionEnemigoRojo delta(float tAct){
        
        AvionEnemigoRojo e = new AvionEnemigoRojo(gm,400,0);    
        e.setPerteneceEscuadron();
        e.setTiempoActivacion(tAct);
        e.setTiempoInicioPartida(tiempoInicioPartida);
        e.setRecorrido(new Curva());
        e.setCurva("delta");
        return e;
   } 
}
 
