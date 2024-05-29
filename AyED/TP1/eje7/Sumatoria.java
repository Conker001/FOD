package eje7;

import java.util.LinkedList;

public class Sumatoria {
	private int ini= 0;
	private int total=0;
	
	public int sumarLinkedList(LinkedList<Integer> lista) {
		if (lista.isEmpty()) {
			return 0;
		}else { return lista.removeFirst() + sumarLinkedList(lista);
		}
		
	
	}
	
	
	
	public int getIni() {
		return ini;
	}
	public void setIni(int ini) {
		this.ini = ini;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}

}
