package eje5;

public class test5 {


	public static void main(String[] args) {
		int[] cont = {1,2,3,4,5};
		String a = met1(cont);
		System.out.println(a);
        Clase b = new Clase();
        for(int e: cont) {
        met2(e,b);
        }
        System.out.println("Max: " + b.getMax()+" min: "+b.getMin()+" prom: "+b.getProm());
	}
	public static String met1(int[] vec) {
		int max= -99999; int min= 99999; int prom= 0;
		for(int elemento : vec) {
			if(elemento > max) {
				max = elemento;
			}
			if(elemento < min) {
				min = elemento; 
			}
			prom += elemento;
		}
		return ("maximo:"+ max+" minimo: "+min+" promedio: "+ prom);
	}
	public static void met2(int n, Clase b) {
		if (n > b.getMax()) {
			b.setMax(n);
		}
		if(n < b.getMin()) {
			b.setMin(n);
		}
		b.setProm(b.getProm()+ n);
		
	}

}
