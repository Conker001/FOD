program emanuel;
type
  celular= record
    cod: integer;
    nombre: string;
    desc: string;
    marca: string;
    precio: real;
    stockm: integer;
    stock: integer
  end;
  arch= file of celular;
  
  procedure crear();
    procedure cargar(var e:arch; var t:text);
    var
      a: celular;
    begin
      while (not eof(t))do begin
        readln(t,a.cod,a.precio,a.marca);
        readln(t,a.stock,a.stockm,a.desc);
        readln(t,a.nombre);
        write(e,a)
      end
    end;
  var
    a: arch; t: text; n: string;
  begin
    write('asignar nombre: '); readln(n);
    assign(a,n);
    rewrite(a);
    assign(t,'celulares.txt');
    reset(t);
    cargar(a,t);
    close(a);
    close(t)
  end;
  procedure mostrar(c: celular);
  begin
    writeln('codigo: ',c.cod,' precio: ',c.precio:5:2,' marca: ',c.marca);
    writeln('stock: ',c.stock,' stockmin: ',c.stockm,' descripcion: ',c.desc);
    writeln('nombre: ',c.nombre)
  end;
  procedure minimos();
  var
    a:arch; n:string; c:celular;
  begin
    write('nombre de archivo: '); readln(n);
    assign(a,n);
    reset(a);
    while (not eof (a)) do begin
      read(a,c);
      if (c.stock< c.stockm) then
        mostrar(c)
    end;
    close(a)
  end;
  function Trim(const s: string): string;
  var
    i, j: Integer;
  begin
    // Buscar el primer caracter no espaciado desde el principio
    i := 1;
    while (i <= Length(s)) and (s[i] = ' ') do
      Inc(i);
    // Buscar el último caracter no espaciado desde el final
    j := Length(s);
    while (j >= 1) and (s[j] = ' ') do
      Dec(j);
    // Retornar la subcadena sin espacios al principio y al final
    Trim := Copy(s, i, j - i + 1);
  end;
  procedure buscar();
var
  a: arch; 
  n: string; 
  c: celular;
begin
  write('nombre de archivo: '); 
  readln(n);
  assign(a, n);
  reset(a);
  writeln('ddd');
  // Limpiar el búfer de entrada para evitar problemas

  writeln('descripcion a buscar (presiona Enter para finalizar): ');

  // Leer descripciones hasta que se ingrese una cadena vacía
  while true do begin
    readln(n);
    if n = '' then
      break;

    // Limpiar la entrada eliminando cualquier espacio al principio y al final
    n := Trim(n);
    writeln('asdasdasasd');
    while (not eof(a)) do begin
      read(a, c);
      // Utilizar función AnsiContainsText para buscar la descripción sin distinción de mayúsculas y minúsculas
      if (c.desc = n) then begin
        mostrar(c)
      end
    end;
    // Volver al inicio del archivo después de cada búsqueda
    reset(a);
  end;

  close(a)
end;
  procedure exportar();
  var
    a: arch; t: text; n:string; c: celular;
  begin
    write('nombre archivo: '); readln(n);
    assign(a,n);
    assign(t,'celulares.txt');
    reset(a);
    rewrite(t);
    while (not eof(a)) do begin
      read(a,c);
      writeln(t,c.cod,' ',c.precio:5:2,'',c.marca);
      writeln(t,c.stock,' ',c.stockm,'',c.desc);
      writeln(t,c.nombre);
    end;
    close(a);
    close(t)
  end;
var
  i: char;
begin
  writeln('a: crear; b: lista debajo de stockmin  ; c: buscar en desc.  ; d: '); readln(i);
  while (i <> 'x') do begin  
    case i of
      'a': crear;
      'b': minimos;
      'c': buscar;
      'd': exportar
    end;
    writeln('a: crear; b: lista debajo de stockmin  ; c: buscar en desc.  ; d: '); readln(i)
  end
end.
