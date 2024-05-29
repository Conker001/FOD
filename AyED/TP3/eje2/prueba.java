package eje2;
import java.util.List;
import java.util.Random;

import eje1.GeneralTree;
import eje1.RandomGeneralTreeGenerator;
import eje2.RecorridosAG;
public class prueba {

	public static void main(String[] args) {
		Random s = new Random();
		GeneralTree<Integer> arbol = RandomGeneralTreeGenerator.generateRandomTree(s, 6);
		RandomGeneralTreeGenerator.printTree(arbol);
		RecorridosAG a = new RecorridosAG();
		List<Integer> aux= arbol.numerosImparesMayoresQueInOrden(arbol, 6);
		// TODO Auto-generated method stub

	}

}
