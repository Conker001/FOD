package eje7;

import java.util.ArrayList;

public class Invertir {
	  private static int i;
	  private static int d;
	public void invertirArrayList(ArrayList<Integer> lista) {
		int aux = lista.get(i);
		if (i < d) {
			lista.set(i, lista.get(d));
			lista.set(d, aux);
			i++;
			d--;
			invertirArrayList(lista);
		}
		
		
	}
	public int getI() {
		return i;
	}
	public void setI(int i) {
		Invertir.i = i;
	}
	public int getD() {
		return d;
	}
	public void setD(int d) {
		Invertir.d = d;
	}
}
