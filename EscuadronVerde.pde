public class EscuadronVerde extends Escuadron{
    private ArrayList<AvionEnemigoVerde> enemigos;
    public EscuadronVerde(Partida p){
        super(p);
        this.enemigos = new ArrayList<AvionEnemigoVerde>();
    }

    public void añadirEnemigo(int cant) {
            for (int j = 0; j <cant ; j++) {
            int x = int(randomGaussian() * 100 + width / 2); // centrado en el medio de la pantalla
            int y = int(randomGaussian() * 100 - 600);       // aparecen arriba con algo de variación
            AvionEnemigoVerde e = new AvionEnemigoVerde(x, y);
            e.setPartida(this.partida);
            e.setCurva("gaussVertical");
            e.setTiempoInicioNivel(this.tiempoInicioNivel);
            this.enemigos.add(e);
        }
    
        partida.listaEnemigos.addAll(this.enemigos);
    
    }

    

    public void mandar(float tAct){
        int cont = 0;;
        for (AvionEnemigoVerde e : this.enemigos) {
            cont += 1;
            e.setTiempoActivacion(tAct + cont * 800);
        }
   }

   
}

 