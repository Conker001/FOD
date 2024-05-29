package eje7;

import java.util.ArrayList;
import java.util.List;

public  class EjercicioSucesion {
	public static List<Integer> calcularSucesion(int n){
		List<Integer> sucesion = new ArrayList<Integer>();
		sucesion.add(n);
		System.out.println("pos: "+ n);
		if (n == 1) {
			return sucesion;
		}
		if ((n%2) == 0) {
			sucesion.addAll(calcularSucesion(n/2));
		} else {
			sucesion.addAll(calcularSucesion((3*n)+1));
		}
		return sucesion;
	}


public static void main(String [] arg) {
	List<Integer> sucesion;
	
	sucesion = calcularSucesion(6);
	for(int elem : sucesion) {
		System.out.println(elem);
	}
		ArrayList<Integer> lista = new ArrayList<Integer>();
		Invertir in = new Invertir();
		lista.add(1);
		lista.add(2);
		lista.add(3);
		lista.add(4);
		in.setD(lista.size()-1);
		in.setI(0);
		in.invertirArrayList(lista);
		for (int inv: lista) {
			System.out.println(" pos"+ inv);
		
        
	}
  
}

}