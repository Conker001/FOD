const url = 'https://swapi.dev/api/people/?page=1';
listar(url);
function listar(url){
fetch(url)
.then(response=> response.json())
.then(data=>{
    const lista = document.getElementById('lista');
    lista.innerHTML= ''
    document.getElementById('botonI').setAttribute('alt', data.previous)
    document.getElementById('botonD').setAttribute('alt', data.next)
    data.results.forEach(actual => {
        const li = document.createElement(`li`)
        const a = document.createElement('a')
        a.textContent= actual.name
        a.onclick= ()=> description(actual)
        a.href = '#'
        li.appendChild(a)
        lista.appendChild(li)
    });
}
)
.catch(error=> console.log('error',error))
}

