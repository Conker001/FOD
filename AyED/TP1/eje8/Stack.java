package eje8;

import java.util.ArrayList;
import java.util.List;

public class Stack<T> extends Sequence {
	private List<T> data;
	public Stack() {
		data= new ArrayList<T>();
	}
	public void push(T dato) {
		data.add(0,dato);
	}
	public T pop() {
		return data.remove(0);
	}
	public T top() {
		return data.get(0);
	}
	
	@Override
	public int size() {
		return data.size();
	}
	@Override
	public boolean isEmpty() {
		return (0 == data.size());
	}
	public String toString() {
		String aux= null;
		for (T dato : data ) {
			aux+= (dato.toString() + ",\n");
		}
		aux = aux.substring(0, aux.length()-1);
		return aux;
	}

}
