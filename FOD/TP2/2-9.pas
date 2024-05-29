{
Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Código de Provincia
Código de Localidad | Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información está ordenada por código de provincia y código de localidad
}
program emanuel;
const
  valorAlto= 9999;
type
  votos = record
    codigoP: integer;
    codigoL: integer;
    NMesa: integer;
    cantidad: integer;
  end;
  maestro= file of votos;
  procedure leer(var mae: maestro; var reg: votos);
  begin
    if(not eof(mae)) then read(mae,reg)
    else reg.codigoP:= valorAlto
  end;
  procedure informar(var mae: maestro);
  var
    actual,reg: votos;
    total,totalP,totalL: integer;
  begin
    leer(mae,reg);
    total:=0;
    while(reg.codigoP <> valorAlto) do begin
      actual.codigoP:= reg.codigoP;
      totalP:=0;
      writeln(reg.codigoP);
      while(actual.codigoP = reg.codigoP) do begin
        actual.codigoL:= reg.codigoL;
        totalL:=0;
        while((actual.codigoP = reg.codigoP) and (actual.codigoL = reg.codigoL))do begin
          totalL:= totalL+ reg.cantidad;
          leer(mae,reg)
        end;
        writeln(actual.codigoL, totalL);
        totalP:=totalP + totalL
      end;
      writeln('total de provincia:', totalP);
      total:= total+ totalP
    end;
    writeln('total general:', total)
  end;
var
  mae: maestro;
begin
  assign(mae, ''); reset(mae);
  informar(mae);
  close(mae)
end.
