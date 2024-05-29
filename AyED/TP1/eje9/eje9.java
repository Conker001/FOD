package eje9;

import eje8.Stack;

public class eje9{
public static void main(String[] args) {
	String a = "e(s{o[]{}jsgjikgififiy}o))";
	System.out.println(testBalanceo(a));
	
	
}



public static boolean testBalanceo(String a) {
	Boolean ok= true; int i= 0;
	Stack<Character> pila= new Stack<Character>();
	if (a.length() == 0) return ok;
	while (i < a.length() && ok) {
		if ((a.charAt(i) == '(') || a.charAt(i) == '{' || a.charAt(i) == '[') {
			pila.push(a.charAt(i));}
		else if ((a.charAt(i) == ')' || a.charAt(i) == ']' || a.charAt(i) == '}') && !pila.isEmpty()) {
			    switch (a.charAt(i)) {
			    case ')': {
			    	  if (pila.top() == '(') pila.pop();
			    	  break;}
			      
			    case '}': 
			    	if (pila.top() == '{') pila.pop();
			    	break;
			    case ']': 
			    	if (pila.top() == '[') pila.pop();
			    	break;
			    default:{ ok= !ok; }
			    }
		}
		if (a.charAt(i) == ')' || a.charAt(i) == ']' || a.charAt(i)== '}') ok= false;
		i++;
	}
	return (pila.isEmpty() && ok);
}
}
