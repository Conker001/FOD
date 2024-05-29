{ Una compañía aérea dispone de un archivo maestro donde guarda información sobre sus
próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida y la
cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles
para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida
y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino
más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada
uno del maestro. Se pide realizar los módulos necesarios para:
a. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje
sin asiento disponible.
b. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que
tengan menos de una cantidad específica de asientos disponibles. La misma debe
ser ingresada por teclado.
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.}
program Emanuel;
const
  valorAlto= 'zzzz';
type
  fecha = record
    anio: integer;
    mes: integer;
    dia: integer
  end;
  vuelos= record
    destino: string;
    fecha: fecha;
    hora: integer;
    asientos: integer
  end;
  archivo= record
    destino: string;
    fecha: fecha;
    hora: integer;
    cantidad: integer
  end;
  lista = ^nodo;
  nodo = record
    dato: vuelos;
    sig: lista
  end;
  maestro= file of vuelos;
  detalle= file of archivo;
  arrayD = array[1..2] of detalle;
  arrayA = array[1..2] of archivo;
  procedure leer(var det: detalle; var reg: archivo);
  begin
    if (not eof(det))then read(det,reg)
    else reg.destino:= valorAlto
  end;
  procedure minimo(var min: archivo; var det: arrayD; var reg: arrayA);
  var
    i,save: integer;
  begin
    min.destino:= valorAlto;
    for i:= 1 to 2 do begin
      if (reg[i].destino < min.destino) then begin
        min:= reg[i];
        save:= i
      end
    end;
    if (min.destino <> valorAlto) then
      leer(det[save], reg[save])
  end;
  function comprobar(f: fecha; f2: fecha): boolean;
  var
    ok: boolean;
  begin
    ok:= false;
    if ((f.anio = f2.anio)and(f.mes = f2.mes)and(f.dia = f2.dia)) then
      ok:= not ok;
    comprobar:= ok
  end;
  procedure actualizar(var mae: maestro; var l: lista);
    procedure crearL(reg: vuelos; var l: lista);
    var
      nuevo: lista;
    begin
      if (l <> nil) then begin
        new(nuevo); nuevo^.dato:= reg; nuevo^.sig:= l;
        l:= nuevo
      end
      else begin
        l^.dato:= reg; l^.sig:= nil
        end
    end;
  var
    vdet: arrayD;
    regd: arrayA;
    regm: vuelos;
    min: archivo;
    i,asientosN: integer;
  begin
    for i:= 1 to 2 do begin
      assign(vdet[i], '  '); reset(vdet[i]);
      leer(vdet[i], regd[i])
    end;
    readln(asientosN);
    minimo(min,vdet,regd);
    while (min.destino <> valorAlto) do begin
      read(mae,regm);
      while (regm.destino <> min.destino) do begin
        if (regm.asientos < asientosN) then
          crearL(regm,l);
        read(mae, regm)
        end;
      while (regm.destino = min.destino) do begin
        while(not comprobar(regm.fecha, min.fecha)) do begin
          if (regm.asientos < asientosN) then
            crearL(regm,l);
          read(mae,regm)
          end;
        while ((regm.destino = min.destino) and (comprobar(regm.fecha,min.fecha)))do begin
          while (regm.hora <> min.hora) do begin
            if (regm.asientos < asientosN) then
              crearL(regm,l);
            read(mae,regm)
            end;
          while((regm.destino = min.destino) and (comprobar(regm.fecha,min.fecha))and (regm.hora = min.hora)) do begin
            regm.asientos:= regm.asientos - min.cantidad;
            minimo(min,vdet,regd)
          end;
          if (regm.asientos < asientosN) then
            crearL(regm,l);
          seek(mae, filePos(mae)-1);
          write(mae, regm)
        end;
        //fecha
      end;
      //destino
    end;
  end;
var
  mae: maestro;
  l: lista;
begin
  assign(mae,'maestro'); reset(mae);
  l:= nil;
  actualizar(mae,l);
  close(mae)
end.
