Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://2117qp1ef3.execute-api.eu-west-2.amazonaws.com/Dev'

Scenario: Get Avenger by Id

Given path 'avengers','aaaa-bbbb-cccc-dddd'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}