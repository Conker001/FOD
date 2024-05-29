{
A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
pueden venir 0, 1 ó más registros por cada provincia}
program Emanuel;
const
  valorAlto= 'zzzz';
type
  archivo= record
    provincia: string;
    alfabetizados: integer;
    encuestados: integer
  end;
  agencias= record
    provincia: string;
    codigoLoc: integer;
    alfabetizados: integer;
    encuestados: integer;
  end;
  total= record
    alfabetizados: integer;
    encuestados: integer;
  end;
  maestro= file of archivo;
  detalle= file of agencias;

  
  procedure actualizar(var mae: maestro; var det1: detalle; var det2: detalle);
    procedure leer(var det: detalle; var reg: agencias);
    begin
      if (not eof(det)) then read(det,reg)
      else reg.provincia:= valorAlto;
    end;
    procedure minimo(var min: agencias; var reg1:agencias; var reg2: agencias; var det1: detalle; var det2: detalle);
    begin
      if (reg1.provincia <= reg2.provincia) then begin
        min:= reg1; leer(det1,reg1)
      end
      else begin
        min:= reg2; leer(det2,reg2)
      end
    end;
  var
    regm: archivo;
    reg1,reg2,min: agencias;
  begin
    reset(mae); reset(det1); reset(det2);
    leer(det1,reg1); leer(det2,reg2);
    minimo(min,reg1,reg2,det1,det2);
    while(min.provincia <> valorAlto) do begin
      read(mae, regm);
      while (regm.provincia <> min.provincia) do
        read(mae, regm);
      while((min.provincia<> valorAlto) and (regm.provincia = min.provincia)) do begin
        regm.alfabetizados:= regm.alfabetizados + min.alfabetizados;
        regm.encuestados:= regm.encuestados +min.encuestados;
        minimo(min,reg1,reg2,det1,det2)
      end;
      seek(mae,filePos(mae)-1);
      write(mae, regm)
    end;
    close(mae); close(det1); close(det2)
  end;
var
  mae: maestro;
  det1,det2: detalle;
begin
  assign(mae,'maestro'); assign(det1,'detalle'); assign(det2,'detalle2');
  actualizar(mae,det1,det2)
end.
