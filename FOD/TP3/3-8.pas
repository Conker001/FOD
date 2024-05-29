{Se cuenta con un archivo con información de las diferentes distribuciones de linux
existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de
versión del kernel, cantidad de desarrolladores y descripción. El nombre de las
distribuciones no puede repetirse. Este archivo debe ser mantenido realizando bajas
lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida.
Escriba la definición de las estructuras de datos necesarias y los siguientes
procedimientos:
a. ExisteDistribucion: módulo que recibe por parámetro un nombre y devuelve
verdadero si la distribución existe en el archivo o falso en caso contrario.
b. AltaDistribución: módulo que lee por teclado los datos de una nueva
distribución y la agrega al archivo reutilizando espacio disponible en caso
de que exista. (El control de unicidad lo debe realizar utilizando el módulo
anterior). En caso de que la distribución que se quiere agregar ya exista se
debe informar “ya existe la distribución”.
c. BajaDistribución: módulo que da de baja lógicamente una distribución
cuyo nombre se lee por teclado. Para marcar una distribución como
borrada se debe utilizar el campo cantidad de desarrolladores para
mantener actualizada la lista invertida. Para verificar que la distribución a
borrar exista debe utilizar el módulo ExisteDistribucion. En caso de no existir
se debe informar “Distribución no existente”.}
program Emanuel;
const
  valorAlto = 'zzzz';
type
  distribucion = record
    nombre: string;
    anio: integer;
    numeroVK:integer;
    desarolladores: integer;
    descripcion: string
  end;
  archivo= file of distribucion;
  procedure leer(var mae: archivo; var reg: distribucion);
  begin
    if(not eof(mae)) then read(mae,reg)
    else reg.nombre:= valorAlto
  end;
  function existeDistribucion(nombre: string): boolean;
  var
  mae: archivo;
  reg:distribucion;
  begin
    assign(mae,''); reset(mae);
    leer(mae,reg);
    while((reg.nombre <> valorAlto) and (reg.nombre <> nombre)) do
      leer(mae,reg);
    close(mae);
    existeDistribucion:= reg.nombre = nombre
  end;
  {b. AltaDistribución: módulo que lee por teclado los datos de una nueva
  distribución y la agrega al archivo reutilizando espacio disponible en caso
  de que exista. (El control de unicidad lo debe realizar utilizando el módulo
  anterior). En caso de que la distribución que se quiere agregar ya exista se
  debe informar “ya existe la distribución”.}
  procedure nuevo(var reg: distribucion);
  begin
    writeln('ingrese nombre: '); readln(reg.nombre);
    writeln('ingrese año: '); readln(reg.anio);
    writeln('ingrese numero de version de kernel: '); readln(reg.numeroVK);
    writeln('ingrese cantidad de desarolladores: '); readln(reg.desarolladores);
    writeln('ingrese descripcion: '); readln(reg.descripcion)
  end;
  procedure Alta(var mae: archivo; reg: distribucion);
  var
    actual: distribucion;
  begin
    read(mae,actual);
    if (actual.desarolladores = 0) then begin
      seek(mae,fileSize(mae));
      write(mae,reg)
    end
    else begin
      seek(mae,actual.desarolladores*-1);
      read(mae,actual);
      seek(mae,filePos(mae)-1);
      write(mae,reg);
      seek(mae,0);
      write(mae,actual)
    end;
  end;
  procedure AltaDistribucion;
  var
    mae: archivo;
    reg: distribucion;
  begin
    assign(mae,''); reset(mae);
    nuevo(reg);
    if (not ExisteDistribucion(reg.nombre)) then begin
      Alta(mae,reg);
    end
    else writeln('la distribucion ya existe');
    close(mae)
  end;
  {c. BajaDistribución: módulo que da de baja lógicamente una distribución
  cuyo nombre se lee por teclado. Para marcar una distribución como
  borrada se debe utilizar el campo cantidad de desarrolladores para
  mantener actualizada la lista invertida. Para verificar que la distribución a
  borrar exista debe utilizar el módulo ExisteDistribucion. En caso de no existir
  se debe informar “Distribución no existente”.}
  procedure Baja(nombre: string);
  var
    mae: archivo;
    reg,cab:distribucion;
  begin
    assign(mae,' '); reset(mae);
    read(mae,cab); read(mae,reg);
    while(reg.nombre <> nombre) do
      read(mae,reg);
    seek(mae,filePos(mae)-1);
    write(mae,cab);
    seek(mae,0);
    reg.desarolladores:= reg.desarolladores*-1;
    write(mae,reg)
  end;
  procedure BajaDistribucion;
  var
    nombre: string;
  begin
    writeln('ingrese distribucion a borrar: '); readln(nombre);
    if(ExisteDistribucion(nombre)) then begin
      Baja(nombre);
    end
    else writeln('la distribucion no existe');
  end;
begin
  
  
end.
