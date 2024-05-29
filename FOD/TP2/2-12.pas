{Suponga que usted es administrador de un servidor de correo electrónico. En los logs del
mismo (información guardada acerca de los movimientos que ocurren en el server) que se
encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información:
nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el
servidor de correo genera un archivo con la siguiente información: nro_usuario,
cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los
usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se
sabe que un usuario puede enviar cero, uno o más mails por día.
a. Realice el procedimiento necesario para actualizar la información del log en un
día particular. Defina las estructuras de datos que utilice su procedimiento.
b. Genere un archivo de texto que contenga el siguiente informe dado un archivo
detalle de un día determinado:-
nro_usuarioX…………..cantidadMensajesEnviados
………….
nro_usuarioX+n………..cantidadMensajesEnviados
Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que
existen en el sistema. Considere la implementación de esta opción de las
siguientes maneras:
i- Como un procedimiento separado del punto a).
ii- En el mismo procedimiento de actualización del punto a). Qué cambios
se requieren en el procedimiento del punto a) para realizar el informe en
el mismo recorrido?}
program emanuel;
const
  valorAlto= 9999;
type
  usuarios= record
    nroU: integer;
    nombreU: string;
    nombre: string;
    apellido: string;
    cantidadM: integer
  end;
  archivo= record
    nroU: integer;
    cuentaD: string;
    msj: string;
  end;
  maestro = file of usuarios;
  detalle= file of archivo;
  procedure leer(var det: detalle; var regd: archivo);
  begin
    if(not eof(det))then read(det,regd)
    else regd.nroU:= valorAlto;
  end;
  procedure actualizar(var mae: maestro);
  var
    det: detalle;
    texto: text;
    regm: usuarios;
    regd: archivo;
  begin
    assign(mae,'maestro'); reset(mae);
    assign(det,'detalle'); reset(det);
    assign(texto,'texto'); rewrite(texto);
    read(mae,regm);
    leer(det,regd);
    while (regd.nroU <> valorAlto) do begin
      while(regm.nroU <> regd.nroU) do begin
        writeln(texto,'numero de usuario ',regm.nroU,' cantidad de msjs enviados: ',regm.cantidadM);
        read(mae,regm);
      end;
      while (regm.nroU = regd.nroU) do begin
        regm.cantidadM:= regm.cantidadM +1;
        leer(det,regd)
      end;
      //msjs
      seek(mae,filePos(mae) -1);
      write(mae,regm);
      writeln(texto,'numero de usuario ',regm.nroU,' cantidad de msjs enviados: ',regm.cantidadM)
    end;
    read(mae,regm);
    while (not eof(mae)) do begin
      writeln(texto,'numero de usuario ',regm.nroU,' cantidad de msjs enviados: ',regm.cantidadM);
      read(mae,regm)
    end;
    close(mae); close(det); close(texto)
  end;
var
  mae: maestro;
begin
  actualizar(mae)
  
end.
