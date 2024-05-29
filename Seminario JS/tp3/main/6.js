function Ordenar(){
    /*const lista= document.getElementById('lista');
    let vec = [...lista.getElementsByTagName('li')]
    //vec.sort((a,b)=> {a.nombre.localeCompare(b.nombre)})
    vec.sort()
    console.log(vec[0])*/
    const text = document.getElementById('porclass').value;
    fetch('https://restcountries.com/v3.1/all')
    .then(response => response.json())
    .then(data => {
        const lista = document.getElementById('lista');
        lista.innerHTML='';
        data.sort((a,b)=> {
            return a.name.common.localeCompare(b.name.common)}) //
        console.log(data[0])
        data.forEach(actual => {
            const li = document.createElement('li')
            li.textContent = `Nombre: ${actual.name.common}, Poblacion: ${actual.population}`
            lista.appendChild(li)
        });
        


    }
    )
    .catch(error=> console.log('error',error))


}