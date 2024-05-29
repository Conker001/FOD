program Emanuel;
const
  valorAlto = 'zzzz';
type
  empleados = record
    nemp: integer;
    ape: string;
    nombre: string;
    edad: integer;
    dni: integer
  end;
  arch = file of empleados;
  
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
  procedure crear;
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
  procedure add();
  var
    a: arch; act,e:empleados; n:string;
  begin
    writeln('nombre del archivo: ');
    readln(n);
    assign(a,n);
    reset(a);
    leer(e);
    while not eof(a) and (e.ape <> 'fin') do begin
      read(a,act);
      while not eof(a) and (e.nemp <> act.nemp) do begin
        read(a,act);
      end;
      if (eof (a)) and (e.nemp <> act.nemp) then begin
        write(a,e)
      end;
      reset(a);
      leer(e)
    end;
    close(a)
  end;
  procedure modificar();
    procedure cambiar(var a:arch; e:empleados; c: integer);
    begin
      e.edad:= c;
      seek(a,filepos(a)-1);
      write(a,e)
    end;
  var
    a: arch; n: string; e: empleados; c,i:integer; ok: boolean;
  begin
    writeln('nombre de archivo: '); readln(n);
    assign(a,n);
    reset(a);
    writeln('numero de empleado: '); readln(i);
    writeln('cambiar edad a: '); readln(c);
    ok:= false;
    while not eof(a) and (not ok) do begin
      read(a,e);
      if (e.nemp = i) then begin
        cambiar(a,e,c);
        ok:= true
      end
    end;
    close(a)
  end;
  procedure exportar();
  var
    a:arch ; n: string; e: empleados; t: text;
  begin
    writeln('nombre de archivo: '); readln(n);
    assign(a,n);
    assign(t,'todos_empleados.txt');
    reset(a);
    rewrite(t);
    while not eof(a) do begin
      read(a,e);
      writeln(t,'numero de empleado: ',e.nemp,' nombre: ',e.nombre,' apellido: ',e.ape,' edad: ',e.edad,' dni: ',e.dni)
    end;
    close(a);
    close(t)
  end;
  procedure nDni();
    procedure cargar(e: empleados; var t: text);
    begin
      writeln(t,'numero empleado: ',e.nemp);
      writeln(t,'nombre: ',e.nombre);
      writeln(t,'apellido: ',e.ape);
      writeln(t,'dni: ',e.dni);
      writeln(t,'edad: ',e.edad);
      writeln(t,'');
    end;
  var
    a: arch; n: string; e:empleados; t: text;
  begin
    writeln('nombre de archivo: '); readln(n);
    assign(a,n);
    reset(a);
    assign(t,'faltaDNIEmpleado.txt');
    rewrite(t);
    while not eof(a) do begin
      read(a,e);
      if (e.dni = 00) then
        cargar(e,t);
    end;
    close(a);
    close(t)
  end;
  {Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados),
agregándole una opción para realizar bajas copiando el último registro del archivo en
la posición del registro a borrar y luego truncando el archivo en la posición del último
registro de forma tal de evitar duplicados}
  procedure eliminar;
    procedure leer(var dato: arch; var actual: empleados);
    begin
      if (not eof(dato)) then read(dato,actual)
      else actual.nombre:= valorAlto;
    end;
  var
    n: string;
    dato: arch;
    actual,ult: empleados;
  begin
    write('nombre de archivo: '); readln(n);
    assign(dato,n); reset(dato);
    seek(dato,fileSize(dato)-1); read(dato,ult);
    seek(dato,0);
    write('nombre de empleado a borrar: '); readln(n);
    leer(dato,actual);
    while ((actual.nombre <> valorAlto) and (actual.nombre <> n)) do
      leer(dato,actual);
    if(actual.nombre = n) then begin
      seek(dato,filePos(dato)-1);
      write(dato, ult);
      seek(dato,fileSize(dato)-1);
      truncate(dato);
      writeln('dato borrado')
    end
    else writeln('nombre no encontrado');
    close(dato)
  end;
  
var
  i:char;
begin
  writeln('1: crear reg ; 2: abrir reg ; 3: add; 4: modificar edad; 5: exportar archivo; 6: no tienen dni; 7: eliminar; x: finalizar');
  readln(i);
  while (i <> 'x') do begin
    case i of
      '1': crear;
      '2': mostrar;
      '3': add;
      '4': modificar;
      '5': exportar;
      '6': nDni;
      '7': eliminar
    end;
    writeln('1: crear reg ; 2: abrir reg ; 3: add; 4: modificar edad; 5: exportar archivo; 6: no tienen dni; 7: eliminar; x: finalizar');
    readln(i)
  end
end.
