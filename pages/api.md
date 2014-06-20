# CAPE.io API [v2.api.cape.io]

## GITHUB HOOK [/hook/github]


## All Make ID's [/make_ids.json]
`make_ids()`

## Make Info [/{make_id}/_make.json]
`make_load()`
The make data file in json form.

## Update Entity [/{make_id}/_api/{api_id}/_update/{entity_id}]
Pass the entity object in the body as json or just pass the entity_id in the url.

## Make API Load [/{make_id}/_api/{api_id}/index.json]
`api_load()`
Get json array of entities (may be object with ID field or simply the ID) for a particular make API definition.

## Load all API Entities and process views [{make_id}/load.json]
`load()`

## POST [/{make_id}/{api_id}]
Send it an array of entity_ids or entity objects and it will return a list of the data models and a list of entity ids for each model. This saves the updated entities to disk cache.

## [/{make_id}/{view_id}/process.json
Returns a list of views that have been processed.

# Tests

* Loaded make file correctly
* Loaded entities of API correctly and filtered them into views correctly.
* File field gets saved
* File of other types of fields get saved
* Model that contains no entities
* Model of type files
* Model of type set
* Model of type object
* Model of type list