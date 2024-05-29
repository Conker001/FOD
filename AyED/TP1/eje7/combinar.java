package eje7;

import java.util.ArrayList;

public class combinar {
	public ArrayList<Integer> combinarOrdenado(ArrayList<Integer> lista1,
			ArrayList<Integer> lista2){
		ArrayList<Integer> nuevo = new ArrayList<Integer>();
		while (!lista1.isEmpty() && !lista2.isEmpty()) {
			if (lista1.get(0) < lista2.get(0)) {
				nuevo.add(lista1.get(0));
				lista1.remove(0);
			} else {nuevo.add(lista2.get(0));
			        lista2.remove(0);
			}
		}
		if (lista1.isEmpty()) nuevo.addAll(lista2);
		   else nuevo.addAll(lista1);
		return nuevo;
	}

}
