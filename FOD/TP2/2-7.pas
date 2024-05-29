{
Se desea modelar la información necesaria para un sistema de recuentos de casos de covid
para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad de
casos activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad de casos activos, cantidad de casos
nuevos, cantidad de recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}
program Emanuel;
const
  valorAlto= 9999;
type
  infectados= record
    codigoL: integer;
    nombreL: string;
    codigoC: integer;
    nombreC: string;
    activos: integer;
    nuevos: integer;
    recuperados: integer;
    fallecidos: integer;
  end;
  casos = record
    codigoL: integer;
    codigoC: integer;
    activos: integer;
    nuevos: integer;
    recuperados: integer;
    fallecidos: integer
  end;
  maestro = file of infectados;
  detalle = file of casos;
  arrayD= array[1..10] of detalle;
  arrayC= array[1..10] of casos;
  procedure leer(var det:detalle; var reg: casos);
    begin
      if (not eof (det)) then read(det,reg)
      else reg.codigoL:= valorAlto
    end;
  procedure iniciar(var mae: maestro; var det: arrayD; var reg: arrayC);
  var
    i: integer;
  begin
    assign(mae,''); 
    reset(mae);
    for i:= 1 to 10 do begin
      assign(det[i],'');
      reset(det[i]);
      leer(det[i],reg[i])
      end
  end;
  procedure cerrar(var mae: maestro; var det: arrayD);
  var
    i: integer;
  begin
    close(mae);
    for i := 1 to 10 do
      close(det[i])
  end;
  procedure actualizar(var mae : maestro; var det: arrayD);
    procedure minimo(var actual: casos; var det: arrayD; var reg: arrayC);
    var
      i,save: integer;
    begin
      actual.codigoL:= valorAlto;
      actual.codigoC:= valorAlto;
      for i:= 1 to 10 do begin
        if (reg[i].codigoL <= actual.codigoL) and (reg[i].codigoC < actual.codigoC) then begin
            actual:= reg[i];
            save:= i
        end
      end;
      if (actual.codigoL <> valorAlto) then leer(det[save],reg[save])
    end;
  var
    regm: infectados;
    reg: arrayC;
    actual: casos;
  begin
    iniciar(mae,det,reg);
    minimo(actual,det,reg);
    while (actual.codigoL <> valorAlto)do begin
      read(mae,regm);
      while ((regm.codigoL <> actual.codigoL)) do
        read(mae,regm);
      while((regm.codigoL = actual.codigoL))do begin
        while(regm.codigoC <> actual.codigoC) do
          read(mae,regm);
        while ((regm.codigoL = actual.codigoL) and (regm.codigoC = actual.codigoC)) do begin
          regm.activos:= actual.activos;
          regm.nuevos:= actual.nuevos; 
          regm.recuperados:= regm.recuperados + actual. recuperados; 
          regm.fallecidos:= regm.fallecidos + actual.fallecidos;
          minimo(actual,det,reg)
          end
      end;
      seek(mae,filePos(mae)-1);
      write(mae,regm)
    end
  end;
  procedure informar(var mae:maestro);
    procedure leer(var mae:maestro; var regm: infectados);
    begin
      if (not eof (mae)) then read(mae,regm)
      else regm.codigoL:= valorAlto
    end;
  var
    regm: infectados;
    codL,activos: integer;
  begin
    reset(mae);
    leer(mae,regm);
    while(regm.codigoL <> valorAlto)do begin
      codL:= regm.codigoL;
      activos:= 0;
      while((regm.codigoL <> valorAlto)and (codL = regm.codigoL)) do begin
        activos:= activos +regm.activos;
        leer(mae,regm)
      end;
      if (activos > 50) then writeln(codl, activos)
    end 
  end;
var
  mae: maestro;
  det: arrayD;
begin
  actualizar(mae,det);
  informar(mae);
  cerrar(mae,det)
end.
