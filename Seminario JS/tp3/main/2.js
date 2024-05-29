var jsonStr ='[' +
'{"name":"Alice","dob": "2001-03-04T00:00:00.000Z","trips": "21"},' +
'{"name":"Robert","dob": "1997-01-31T00:00:00.000Z","trips": "9"},' +
'{"name":"Charles","dob": "1978-10-15T00:00:00.000Z","trips": "22"},' +
'{"name":"Lucía","dob": "1955-08-07T00:00:00.000Z","trips": "30"},' +
'{"name":"Peter","dob": "1988-03-09T00:00:00.000Z","trips": "4"},' +
'{"name":"Lucas","dob": "1910-12-04T00:00:00.000Z","trips": "5"}' +
']';


function frequentTravelers(people){
    return people.filter(p => p.trips > 10).map(p=>p.name).reduce((n1, n2)=>n1 +","+ n2)}

console.log(frequentTravelers(JSON.parse(jsonStr)));


function sigCumple(people){
    return people.reduce(function(acum,cont){
        if (acum == null){
             acum= cont;
        } else if (acum.dob < cont.dob){
            acum = cont;
        }
        return acum;
    },null )}
console.log(sigCumple(JSON.parse(jsonStr)));