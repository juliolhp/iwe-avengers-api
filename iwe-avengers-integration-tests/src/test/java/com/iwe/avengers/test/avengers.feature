Feature: Perform integrated tests on the Avengers registration API

Background:

* url 'https://2117qp1ef3.execute-api.eu-west-2.amazonaws.com/Dev'

* def getToken =
"""
function() {
 var TokenGenerator = Java.type('com.iwe.avengers.test.authorization.TokenGenerator');
 var sg = new TokenGenerator();
 return sg.getToken();
}
"""
* def token = call getToken

Scenario: Should Return invalid acess
Given path 'avengers'
And request {name:'Iron Man' , secretIdentity: 'Tony Stark'}
When method post
Then status 401

Scenario: Should return not found Avenger

Given path 'avengers','not-found-id'
And header Authorization = 'Bearer ' + token
When method get
Then status 404

Scenario: Should return not found Avenger for a attempt to delete

Given path 'avengers','not-found-id'
And header Authorization = 'Bearer ' + token
When method delete
Then status 204

Scenario: Should return not found Avenger for a attempt do update

Given path 'avengers','not-found-id'
And header Authorization = 'Bearer ' + token
And request {name:'Iron Man' , secretIdentity: 'Tony Stark'}
When method put
Then status 404


Scenario: Create Avenger by Id #Criação

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match response == savedAvenger

Scenario: Must return 400 for invalid creation payload #Consulta
Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {secretIdentity: 'Tony Stark'}
When method post
Then status 400

Scenario: Create and Update Avenger by Id
Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Iron', secretIdentity: 'Tony'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron', secretIdentity: 'Tony'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'} 
When method put
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Create, Delete and Get Avenger by Id

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

* def savedAvenger = response

Given path 'avengers',savedAvenger.id
And header Authorization = 'Bearer ' + token
When method delete
Then status 204

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 404