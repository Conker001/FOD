package ej2;

import java.util.Scanner;

public class met {

	public static int[] Comp() {
		Scanner s = new Scanner(System.in);
		int[] vec = new int[s.nextInt()];
		for(int i = 0; i < vec.length; i++) {
			vec[i]= (i+1)*vec.length;
			System.out.println(vec[i]);
		}
		return vec;
	}


}
