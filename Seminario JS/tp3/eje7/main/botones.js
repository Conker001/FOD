function izq(){
  
  const url = document.getElementById('botonI').getAttribute('alt')
    if (url != 'null'){
      document.getElementById('desc').innerHTML= ''
      listar(url)}
}
function der(){
    const url = document.getElementById('botonD').getAttribute('alt')
    if (url != 'null'){
      document.getElementById('desc').innerHTML= ''
      listar(url)}
}
async function description(data){
    const lista = document.getElementById('desc');
    lista.innerHTML=''
    const keys = Object.keys(data);
    let li = document.createElement('li')
    console.log(data)
    lista.appendChild(document.createElement('li')).textContent = 'Descripcion: '
    lista.appendChild(document.createElement('li')).textContent = `Nombre: ${data.name}`
    lista.appendChild(document.createElement('li')).textContent = `Altura: ${data.height}`
    lista.appendChild(document.createElement('li')).textContent = `Peso: ${data.mass}kgs `
    lista.appendChild(document.createElement('li')).textContent = `Planeta: ${await apiSrc(data.homeworld)}`
    lista.appendChild(document.createElement('li')).textContent = `Pelicula: ${data.films.length > 0? await apiSrc(data.films[0]): 'No tiene'}`
    lista.appendChild(document.createElement('li')).textContent = `Nave Espacial: ${data.starships.length > 0? await apiSrc(data.starships[0]): 'No tiene'}`
    //lista.appendChild(document.createElement('li')).textContent = `Peliculas:${}`

    //lista.appendChild(document.createElement('li')).textContent = 'Descripcion: '
    /*for(let i= 0; i< keys.length; i++){
        const li = document.createElement('li')
        li.textContent= `${keys[i]}: ${data[keys[i]]}`
        lista.appendChild(li)
    }*/
  };
  function apiSrc(url){
    return fetch(url)
    .then(response=> response.json())
    .then(data=> {
      return Object.values(data)[0];
    })
    .catch(error => console.log('error', error))
  }