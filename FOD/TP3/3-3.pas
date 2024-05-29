{Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:
a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.
b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de
novela como enlace).Una vez abierto el archivo, brindar operaciones para:
i. Dar de alta una novela leyendo la información desde teclado. Para
esta operación, en caso de ser posible, deberá recuperarse el
espacio libre. Es decir, si en el campo correspondiente al código de
novela del registro cabecera hay un valor negativo, por ejemplo -5,
se debe leer el registro en la posición 5, copiarlo en la posición 0
(actualizar la lista de espacio libre) y grabar el nuevo registro en la
posición 5. Con el valor 0 (cero) en el registro cabecera se indica
que no hay espacio libre.
ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.
iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.
c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario.}
program Emanuel;
const
  valorAlto= 9999;
type
  {Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:
a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.}
  novelas= record
    codigo: integer;
    genero: string;
    nombre: string;
    duracion: real;
    director: string;
    precio: real
  end;
  archivo = file of novelas;
  procedure leer(var reg: novelas);
  begin
    writeln('ingrese codigo: ');  readln(reg.codigo);
    if (reg.codigo <> -1) then begin
      writeln('ingrese genero: ');  readln(reg.genero);
      writeln('ingrese nombre: ');  readln(reg.nombre);
      writeln('ingrese duracion: ');readln(reg.duracion);
      writeln('ingrese director: ');readln(reg.director);
      writeln('ingrese precio: ');  readln(reg.precio)
      end
  end;
  procedure crear;
  var
    dato: archivo;
    reg: novelas;
  begin
    assign(dato,'novelas'); rewrite(dato);
    reg.codigo:= 0; write(dato,reg);
    leer(reg);
    while (reg.codigo <> -1) do begin
      write(dato,reg);
      leer(reg)
    end;
    close(dato)
  end;
  {b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de
novela como enlace).Una vez abierto el archivo, brindar operaciones para:
i. Dar de alta una novela leyendo la información desde teclado. Para
esta operación, en caso de ser posible, deberá recuperarse el
espacio libre. Es decir, si en el campo correspondiente al código de
novela del registro cabecera hay un valor negativo, por ejemplo -5,
se debe leer el registro en la posición 5, copiarlo en la posición 0
(actualizar la lista de espacio libre) y grabar el nuevo registro en la
posición 5. Con el valor 0 (cero) en el registro cabecera se indica
que no hay espacio libre.}
  procedure leo(var arch: archivo; var reg: novelas);
  begin
    if (not eof(arch)) then read(arch,reg)
    else reg.codigo:= valorAlto
  end;
  procedure alta;
  var
    reg,actual: novelas;
    n: string;
    arch: archivo;
  begin
    writeln('ingrese nombre del archivo: '); readln(n);
    assign(arch,n); reset(arch);
    leer(reg);
    read(arch,actual);
    if (actual.codigo <> 0) then begin
      seek(arch,actual.codigo* -1);
      read(arch,actual);
      seek(arch,filePos(arch)-1);
      write(arch,reg);
      seek(arch,0);
      write(arch,actual)
    end
    else begin
      seek(arch, fileSize(arch));
      write(arch, reg)
    end;
    close(arch)
  end;
  {ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.}
  procedure modificar;
  var
    arch: archivo;
    reg:novelas;
    n: string;
    i: integer;
  begin
    writeln('nombre del archivo'); readln(n);
    assign(arch,n); reset(arch);
    writeln('insert cod de novela a modif.'); readln(i);
    leo(arch,reg);
    while ((reg.codigo <> valorAlto) and (reg.codigo <> i)) do
      leo(arch,reg);
    if (reg.codigo = i) then begin
      readln(reg.genero);
      readln(reg.nombre);
      readln(reg.duracion);
      readln(reg.director);
      readln(reg.precio);
      seek(arch,filePos(arch)-1);
      write(arch,reg)
    end
    else writeln('novela no encontrada');
    close(arch)
  end;
  {iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.}
  procedure eliminar;
  var
    arch: archivo;
    reg,ant: novelas;
    i: integer;
    n: string;
  begin
    writeln('nombre del archivo: '); readln(n);
    assign(arch,n); reset(arch);
    writeln('codigo a elim.'); readln(i);
    read(arch,reg);
    leo(arch,actual);
    while ((actual.codigo <> valorAlto)and(actual.codigo <> i)) do
      leo(arch,actual);
    if (actual.codigo = i) then begin
      seek(arch,filePos(arch)-1);
      actual.codigo:= (filePos(arch)* -1);
      write(arch,reg);
      seek(arch,0);
      write(arch,actual)
    else writeln('codigo no encontrado');
    close(arch)
  end;
var
  i: char;
begin
  writeln('1 crear; ; x salir');
  readln(i);
  while (i <> 'x') do begin
  case i of
    '1': crear;
    '2': alta;
    '3': modificar;
    '4': eliminar;
    
    
  end;
  writeln('1 crear; ; x salir');
  readln(i)
  end
end.
