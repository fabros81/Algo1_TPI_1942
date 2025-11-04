public class EscuadronGamma extends Escuadron{

    public EscuadronGamma(Partida p){
        super(p);
    }

    public void añadirEnemigo(int cant) {
        for (int i = 0; i < cant; i++) {
            //AvionEnemigoRojo e = new AvionEnemigoRojo(820,-20); 
            AvionEnemigoRojo e = new AvionEnemigoRojo(400, 0);    
            e.setPerteneceEscuadron(true);
            e.setRecorrido(new Curva());
            e.setCurva("parabolaParametricaInv");
            e.setTiempoInicioNivel(millis());
            this.enemigos.add(e);
        }
    
        partida.listaEnemigos.addAll(this.enemigos);
    
    }

    public void mandar(float tAct){
        int cont = 0;
        for (AvionEnemigoRojo e : this.enemigos) {
            cont += 1;
            e.setTiempoActivacion(tAct + cont * 500);
        }
   }
}