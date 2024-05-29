program Emanuel;
type
  empleados = record
    nemp: integer;
    ape: string;
    nombre: string;
    edad: integer;
    dni: integer
  end;
  arch = file of empleados;
  
  procedure crear;
    procedure leer(var e:empleados);
    begin
      writeln('Apellido: ');
      readln(e.ape);
       if (e.ape <> 'fin') then begin
         writeln('num empleado: ');
         readln(e.nemp);  
         writeln('nombre: ');
         readln(e.nombre);
         writeln('edad: ');
         readln(e.edad);
         writeln('dni: ');
         readln(e.dni);
       end
    end;
  var
    a: arch; n: string; e: empleados;
  begin
    writeln('nombre de archivo: ');
    readln(n);
    assign(a,n);
    rewrite(a);
    leer(e);
    while (e.ape <> 'fin') do begin
      write(a,e);
      leer(e)
    end;
    close(a)
  end;
  procedure mostrar;
    procedure ver(e: empleados);
    begin
      writeln('num empleado: ',e.nemp);
      writeln('apellido: ',e.ape);
      writeln('nombre: ',e.nombre);
      writeln('edad: ',e.edad);
      writeln('dni: ',e.dni);
    end;
    procedure buscar(e: empleados; n:string; a:string);
    begin
      if ((n = e.nombre)and (a= e.ape)) then
        ver(e);
    end;
    procedure mayores(e: empleados);
    begin
      if(e.edad > 70) then
        ver(e);
    end;
    
  var
    carga: arch; n: string; e: empleados; i:char; nom: string; a: string;
  begin
    writeln('nombre de archivo: ');
    readln(n);
    assign(carga,n);
    reset(carga);
    writeln('a: buscar por nombre b: lista entera c: mayores a 70');
    readln(i);
    if (i = 'a') then begin
      writeln('nombre:'); readln(nom);
      writeln('apellido:'); readln(a);
    end;
    while not eof(carga) do begin
      read(carga,e);
      case i of
        'a': buscar(e,nom,a);
        'b': ver(e);
        'c': mayores(e);
      end
    end;
    close(carga)
  end;
var
  i:char;
begin
  writeln('1: crear reg ; 2: abrir reg');
  readln(i);
  case i of
    '1': crear;
    '2': mostrar;
  end
end.
