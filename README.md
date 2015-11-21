# nanoTwitter
nanoTwitter is a toy-mimic of popular social service [twitter](www.twitter.com), developed by 4 students at Brandeis as a course project from *Software Engineering for scalability*.

## License
This is a free software under [MIT license](LICENSE)

## Routing

TODO

## REST API
 as of 10/22/2015

### GET /tweets/:tweet_id

* Description: Returns a tweet based on its ID.
* Resource URL: https://localhost:4567/api/v1/tweets/:id.json
* Resource Information
    * Response formats: JSON
    * Requires authentication?: No
* Parameters
    * id (*required*): The tweet id of the specific tweet to return.

##### Example Request

`GET https://localhost:4567/api/v1/tweets?id=123.json`

```javascript
{ 
  "id": 123, 
  "text": "foobar", 
  "creator_id": 456,
  "created": "jan-11-2015"
}
```
### POST /tweets/:user_id

* Description: Creates a new tweet and returns it.
* Resource URL: https://localhost:4567/api/v1/tweets/:user_id.json
* Resource Information
	* Response formats: JSON
	* Requires authentication?: No
* Parameters
	* user_id (*required*): The user id to be designated as the creator of the tweet.
	* text (*optional*): The text of the tweet. Defaults to empty.

##### Example Request
POST https://localhost:4567/api/v1/tweets?user_id=123&text=sample.json
```javascript
{ 
  "id": 101, 
  "text": "sample", 
  "creator_id": 123,
  "created": "jan-11-2015"
}
```

### GET /users/:user_id

* Resource URL: https://localhost:4567/api/v1/users/:id.json
* Resource Information
	* Response formats: JSON
	* Requires authentication?: No
* Parameters
	* id (*required*): The user id of the user whose information is to be returned.

##### Example Request
`GET https://localhost:4567/api/v1/users?user_id=123.json`
```javascript
{ 
  "id": 123, 
  "name": "John Doe"
}
```

### POST /users/:name

* Resource URL: https://localhost:4567/api/v1/users/:name.json
* Resource Information
	* Response formats: JSON
	* Requires authentication?: No
* Parameters
	* name (*required*): The name of the user to create.

##### Example Request
`POST https://localhost:4567/api/v1/users.json?name=John+Doe`
```javascript
{ 
  "id": 101, 
  "name": "John Doe"
}
```


### PUT /users/:id
* Resource URL: https://localhost:4567/api/v1/users/:id.json
* Resource Information
	* Response formats: JSON
	* Requires authentication?: No
* Parameters
	* id (*required*): The id of the user to update.
	* name (*optional*): The new name of the user.

##### Example Request
`PUT https://localhost:4567/api/v1/users?id=101&name=Jane+Doe.json`
```javascript
{ 
  "id": 101, 
  "name": "Jane Doe"
}
```


### GET /tweets/recent

* Resource URL: https://localhost:4567/api/v1/tweets/recent.json
* Resource Information
	* Response formats: JSON
	* Requires authentication?: No
* Parameters
	* num (*optional*): Returns num recent tweets. Defaults to 10. Max of 50.

##### Example Request
`GET https://localhost:4567/api/v1/tweets/recent?num=2.json`
```javascript
[ 
  { 
    "id": 1, 
    "text": "foobar", 
    "creator_id": 456,
    "created": "jan-11-2015"
  },
  { 
    "id": 2, 
    "text": "foobar", 
    "creator_id": 789,
    "created": "jan-12-2015"
  }
]
```

### GET /users/:user_id/tweets

* Resource URL: https://localhost:4567/api/v1/users/:user_id/tweets.json
* Resource Information
	* Response formats: JSON
	* Requires authentication?: No
* Parameters
	* user_id (*required*): The user id of the specific user whose tweets will be returned
	* num (*optional*): The number of recent tweets for this user to return. Defaults to 10. Max of 50.

##### Example Request
`GET https://localhost:4567/api/v1/users/123/tweets?num=2.json`
```javascript
[ 
  { 
    "id": 1, 
    "text": "foobar", 
    "creator_id": 456,
    "created": "jan-11-2015"
  },
  { 
    "id": 2, 
    "text": "foobar", 
    "creator_id": 456,
    "created": "jan-12-2015"
  }
]
```

### GET /users/:user_id/followers

* Resource URL: https://localhost:4567/api/v1/users/:user_id/followers.json
* Resource Information
	* Response formats: JSON
	* Requires authentication?: No
* Parameters
	* user_id (*required*): The user id of the specific user whose tweets will be returned

##### Example Request
`GET https://localhost:4567/api/v1/users/123/followers.json`
```javascript
[
  { 
    "id": 124, 
    "name": "Some Person"
  },
  { 
    "id": 125, 
    "name": "Other Person"
  },
]
```
# nanotwitter_redis
