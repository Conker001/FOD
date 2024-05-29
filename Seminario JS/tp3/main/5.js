function boton(){
    /*fetch("https://restcountries.com/v3.1/all")
    .then(Response => Response.json())
    .then(data => {
        const l = data.filter(elem => elem.name.common == 'Moldova')
        console.log(l)
     })
    .catch(error => console.log('error', error))
    
    */
    const text =  document.getElementById('texto').value;
    const li = document.getElementById('lista');
    
    // const lista = li.getElementsByTagName('li');
    while(li.firstChild && !li.firstChild.textContent.includes(text)){
        li.removeChild(li.firstChild)
    }
    while(li.lastChild && !li.lastChild.textContent.includes(text)){
        li.removeChild(li.lastChild)
    }

    //text and content : .toUpperCase() sin distincion de mayus and minus
    //funcionan:
    /*let g;
    for(let i=0; i<lista.length; i++){
        if(lista[i].textContent.includes(text)){
            g= lista[i]
        }
    }
    li.innerHTML= ''
    li.appendChild(g)*/
    
    
    
    /*let vec = [...li.getElementsByTagName('li')];
    vec= vec.filter(ele => {return ele.textContent.includes(text)})
    li.innerHTML = ''
    li.appendChild(vec[0])*/
}