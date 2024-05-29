package ej3;
public class Test {

	public static void main(String[] args) {
		Estudiante[] est= new Estudiante[2];
		Profesor[] prof= new Profesor[3];
		est[0]= new Estudiante("emanuel","choque","emanuelch2@hotmail.com","2b","128 475");
		est[1]= new Estudiante ("maria","han","pp","3a","567 654");
		prof[0]= new Profesor("conker","asd","qwe2","qwet","pla");
		prof[1]= new Profesor("rakion","dsa","qwe1","qwety","plat");
		prof[2]= new Profesor("lol","123","qwe","qwety","lapla");
		System.out.println(est[0].tusDatos());
		System.out.println(est[1].tusDatos());
		System.out.println(prof[0].tusDatos());
		System.out.println(prof[2].tusDatos());
		System.out.println(prof[1].tusDatos());
	}

}
