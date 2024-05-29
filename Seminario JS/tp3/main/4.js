function pais(){
    fetch("https://restcountries.com/v3.1/all")
    .then(response => response.json())
    .then(data =>{
        const lista= document.getElementById('lista');
        lista.innerHTML= '';
        data.forEach(actual => {
            const li = document.createElement('li');
            let idioma;
            if (actual.languages != null){
              idioma = Object.values(actual.languages);}
            li.textContent= `Nombre: ${actual.name.common}, Capital: ${ actual.capital}, Población: ${actual.population}, code: ${actual.cca2}, idioma: ${idioma != null? idioma[0]: 'no tiene'} `;
            lista.appendChild(li);
        });
    })
    .catch(error => console.log('error: ', error));
    }
    pais()