Feature: Perform integrated tests on the Avengers registration API

Background:

* url 'https://2117qp1ef3.execute-api.eu-west-2.amazonaws.com/Dev'

Scenario: Should return not found Avenger
Given path 'avengers','not-found-id'
When method get
Then status 404


Scenario: Get Avenger by Id
Given path 'avengers','aaaa-bbbb-cccc-dddd'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Create Avenger by Id #Criação
Given path 'avengers'
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Must return 400 for invalid creation payload #Consulta
Given path 'avengers'
And request {secretIdentity: 'Tony Stark'}
When method post
Then status 400

Scenario: Put Avenger by Id
Given path 'avengers','aaaa-bbbb-cccc-dddd' 
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'} 
When method put
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Delete Avenger by Id
Given path 'avengers','aaaa-bbbb-cccc-dddd' 
When method delete
Then status 204
