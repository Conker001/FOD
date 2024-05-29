package ej1;

public class metodo {
 public static void xFor(int a, int b) {
	 for( int i = a ; i < b+1 ; i++) {
		 System.out.println(i);
	 }
	 
 }
 public static void xwhile(int a, int b) {
	 while(a <= b) {
		 System.out.println(a);
		 a++;
	 }
	 
 }
 public static void xRecursivo(int a, int b) {
	 if (a <= b) {
		 System.out.println(a);
		 ++a;
		 metodo.xRecursivo(a, b);
	 }
 }
}
