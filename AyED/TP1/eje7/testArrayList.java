package eje7;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.LinkedList;

public class testArrayList {

	public static void main(String[] args) {
		List <Integer> l= new ArrayList<Integer>();
		met1(l);
		imp(l);
		List<Integer> l1 = new LinkedList<Integer>();
		l1.add((Integer) 2);
		System.out.println(l1.get(0) + "cant: "+ l1.size()+ "index: "+ l1.indexOf(l1));
		List<Integer> l2 = l1;
		System.out.println(l2.size()+"c: "+ l2.get(0)+ " igual:" + l1.equals(l2));
		List<Estudiante> e = new ArrayList<Estudiante>();
		agregar(e);
		List<Estudiante> e2 = new ArrayList<Estudiante>();
		Estudiante p = new Estudiante();
		p = (((Estudiante) e.get(0)));
		e2.add(p);
		e2.add((Estudiante) e.get(1));
		e2.add((Estudiante) e.get(2));
		Estudiante aux = ((Estudiante) e.get(0)) ; 
		aux.setApellido("churbi");
		impe(e);
		impe(e2);
		//-----------------------
		//F
		List<Integer> li = new ArrayList<Integer>();
		li.add(4);
		li.add(5);
		li.add(6);
		li.add(3);
		li.add(4);
		System.out.println("Capicua: "+esCapicua(li));
		//G
		List <Integer> lint = EjercicioSucesion.calcularSucesion(10);
		for (int i: lint) {
		System.out.println(i);
		}
		//i
		LinkedList<Integer> listai = new LinkedList<Integer>(Arrays.asList(1,2,3,4,5,6,7,8,9,10));
		Sumatoria sum = new Sumatoria();
		System.out.println("comienza: " + sum.sumarLinkedList(listai));
		System.out.println(listai.isEmpty());
		//j
		ArrayList<Integer> lista1 = new ArrayList<Integer>(Arrays.asList(5,7,8,9,33));
		ArrayList<Integer> lista2 = new ArrayList<Integer>(Arrays.asList(1,2,4,6,22));
		combinar c= new combinar();
		ArrayList<Integer> lista3 = c.combinarOrdenado(lista1, lista2);
		for (int jj : lista3) {System.out.println("combinar: " + jj);}
	
	
	}

	public static boolean esCapicua(List<Integer> li) {
		int i= 0; int j= li.size()-1; boolean aux  = true;
		while ((i < j) && aux) {
			aux = (li.get(i).equals(li.get(j)));
			i++;
			j--;
		}
		return aux;
	}
	public static void met1(List<Integer> l) {
	    for (int i = 1; i<= 10; i++) {
	    	l.add((Integer) i);
	    }
		
	}
	public static void imp(List<Integer> l) {
		int i = 1;
		while( !l.isEmpty()){
			System.out.println("pos"+ i+ ": "+l.get(0));
			i++;
			l.remove(0);
		}
		
		
	}
	public static void agregar(List<Estudiante> e) {
		Estudiante e1 = new Estudiante ("emanuel","choque","ema@g.mail","2b","mate1");
		Estudiante e2 = new Estudiante("2","asd","qwe","rq","dq");
		Estudiante e3 = new Estudiante("3","ase","asde","asdwq","qwerty");
		e.add(e1);
		e.add(e2);
		e.add(e3);
	}
	public static void impe(List<Estudiante> e) {
		for(int i = 0; i < e.size(); i++) {
			System.out.println(((Estudiante) e.get(i)).tusDatos());
		}

		
	}

}
