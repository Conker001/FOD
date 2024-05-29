package eje8;

public class CircularQueue<T> extends Queue<T> {
	public T shift(){
		if (!super.isEmpty()) {
			T dato = super.dequeue();
			super.enqueue(dato);
			return dato;
		} else return null;
	}

}
