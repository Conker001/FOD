program emanuel;
type
  novelas= record
    codigo: integer;
    nombre: string;
    genero: string;
    precio: real
  end;
  arch= file of novelas;
  
  procedure abrir();
    procedure add(var archivo: arch);
      procedure leer(var aux: novelas);
      begin
        writeln('codigo: '); readln(aux.codigo);
        writeln('nombre: '); readln(aux.nombre);
        writeln('genero: '); readln(aux.genero);
        writeln('precio: '); readln(aux.precio)
      end;
    var
      aux: novelas;
    begin
      reset(archivo);
      while (not eof(archivo)) do
        read(archivo,aux);
      leer(aux);
      write(archivo,aux)
    end;
    procedure modificar(var archivo: arch);
      procedure opciones(var aux: novelas);
      var
        indice: char;
      begin
        writeln('1: codigo; 2: nombre; 3: genero; 4: precio'); readln(indice);
        case indice of
          '1': readln(aux.codigo);
          '2': readln(aux.nombre);
          '3': readln(aux.genero);
          '4': readln(aux.precio);
        end
      end;
    var
      cod: integer; aux: novelas; ok: boolean;
    begin
      reset(archivo);
      writeln('inserte el codigo de la novela a modificar: '); readln(cod);
      ok:= false;
      while (not eof(archivo) and not ok) do begin
        read(archivo,aux);
        if (aux.codigo = cod) then begin
          opciones(aux);
          seek(archivo, filepos(archivo)-1);
          write(archivo,aux);
          ok:= true;
        end
      end
    end;
  var
    archivo: arch; nombre: string; indice: char;
  begin
    writeln('selec archivo: '); readln(nombre);
    assign(archivo,nombre);
    writeln('1: agregar; 2: modificar; x: salir'); readln(indice);
    while(indice <> 'x') do begin
      case indice of
        '1': add(archivo);
        '2': modificar(archivo);
      end;
      writeln('1: agregar; 2: modificar; x: salir'); readln(indice);
    end;
    close(archivo)
  end;
  procedure crear();
  var
    archivo: arch; texto: text; nombre: string; aux: novelas;
  begin
    writeln('asignar nombre: '); readln(nombre);
    assign(archivo,nombre);
    rewrite(archivo);
    assign(texto,'novelas.txt');
    reset(texto);
    while (not eof(texto)) do begin
      readln(texto,aux.codigo,aux.precio,aux.genero);
      readln(texto,aux.nombre);
      write(archivo,aux)
    end;
    close(texto);
    close(archivo)
  end;
  
  
var
  indice: char;
begin
  writeln('a: crear un archivo; b: abrir un archivo bin; x: finalizar'); readln(indice);
  while (indice <> 'x')do begin
    case indice of
      'a': crear;
      'b': abrir
    end;
    writeln('a: crear un archivo; b: abrir un archivo bin; x: finalizar'); readln(indice);
  end
end.
