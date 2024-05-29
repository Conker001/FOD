package eje8;

import java.util.ArrayList;
import java.util.List;

public class Queue<T> extends Sequence{
	protected List<T> data;
	
	public Queue() {
		this.data = new ArrayList <T>();
	}
	public void enqueue (T dato) {
		data.add(dato);
	}
	public T dequeue() {
	   return data.remove(0);
	}
    public T head() {
    	return data.get(0);
    }
    public boolean isEmpty() {
    	
    	return (0 == data.size());
    }
    public int size() {
    	return data.size();
    }
    public String toString() {
    	String aux = null;
    	for (T dato: data) {
    		aux += dato.toString() + ", \n";
    	}
    	aux = aux.substring(0, aux.length()-2);
    	return aux;
    }
}
