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
  procedure buscar();
  var
    a:arch; n:string; c:celular;
  begin
    write('nombre de archivo: '); readln(n);
    assign(a,n);
    reset(a);
    write('descripcion a buscar:'); readln(n);
    while (not eof(a)) do begin
      read(a,c);
      if (c.desc = n) then begin
        mostrar(c)
      end
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
      writeln(t,c.cod,' ',c.precio:5:2,' ',c.marca);
      writeln(t,c.stock,' ',c.stockm,' ',c.desc);
      writeln(t,c.nombre);
    end;
    close(a);
    close(t)
  end;
  procedure exportarSinStock();
    procedure add(cel: celular; var texto: text);
    begin
      writeln(texto,cel.cod,' ',cel.precio:5:2,'',cel.marca);
      writeln(texto,cel.stock,' ',cel.stockm,'',cel.desc);
      writeln(texto,cel.nombre)
    end;
  var
    archivo: arch; cel: celular; texto: text;
  begin
    assign(archivo,'p');
    reset(archivo);
    assign(texto,'SinStock.txt');
    rewrite(texto);
    while(not eof(archivo)) do begin
      read(archivo,cel);
      if (cel.stock = 0) then
        add(cel,texto);
    end;
    close(archivo);
    close(texto)
  end;
  procedure modificarStock();
  var
    archivo: arch; cel: celular; ok: boolean; aux: string; int: integer;
  begin
    assign(archivo,'p');
    reset(archivo);
    writeln('nombre del cel a modificar el stock: '); readln(aux);
    writeln('nuevo stock: '); readln(int);
    ok:= false;
    while (not eof(archivo))and(not ok) do begin
      read(archivo,cel);
      if (cel.nombre = aux) then begin
        cel.stock:= int;
        seek(archivo,filepos(archivo)-1);
        write(archivo,cel);
        ok:= true
      end
    end;
    close(archivo);
    writeln('se modifico el dato')
  end;
  procedure anadir();
    procedure add(var archivo: arch);
    var
      cel: celular;
    begin
      writeln('nombre: '); readln(cel.nombre);
      while(cel.nombre <> 'fin') do begin
        writeln('codigo: '); readln(cel.cod);
        writeln('precio: '); readln(cel.precio);
        writeln('marca: '); readln(cel.marca);
        writeln('stock: '); readln(cel.stock);
        writeln('stock min: '); readln(cel.stockm);
        writeln('descripcion: '); readln(cel.desc);
        write(archivo,cel);
        writeln('nombre: '); readln(cel.nombre)
      end
    end;
  var
    archivo: arch; cel: celular;
  begin
    assign(archivo,'p');
    reset(archivo);
    while(not eof(archivo))do
      read(archivo,cel);
    add(archivo);
    close(archivo)
  end;
var
  i: char;
begin
  writeln('a: crear; b: lista debajo de stockmin  ; c: buscar en desc.  ; d: exportar '); 
  writeln('1: add; 2: modificarStock; 3: exportarSinStock; x: salir'); readln(i);
  while (i <> 'x') do begin  
    case i of
      '1': anadir;
      '2': modificarStock;
      '3': exportarSinStock;
      'a': crear;
      'b': minimos;
      'c': buscar;
      'd': exportar
    end;
    writeln('a: crear; b: lista debajo de stockmin  ; c: buscar en desc.  ; d: exportar ');
    writeln('1: add; 2: modificarStock; 3: exportarSinStock; x: salir'); readln(i)
  end
end.
