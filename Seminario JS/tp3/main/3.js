/**Desarrolla habilidades en solicitudes a APIs y
 manejo del DOM para mostrar y actualizar imágenes
 de gatos automáticamente.
1.
Use la función predefinida Fetch
para hacer una página HTML quemuestre una imagen de temática gatuna
obtenida de
https://aws.random.cat/meow
o de
https://api.thecatapi.com/v1/images/search
.
2.
Haga que la imagen cambie automáticamente cada 2 segundos
Pista: Puede usar
setTimeout
. */
function imagenes(){
    fetch('https://api.thecatapi.com/v1/images/search')
    .then(response=> response.json())
    .then(data =>{
       const img = document.getElementById('gatos')
       img.src = data[0].url
       // document.getElementById('gatos').setAttribute('src',data[0].url)
    }
    )
    .catch(error => console.log('error: ', error))
    .finally(imagenes,2000)
    }
imagenes();