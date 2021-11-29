# Payload

_Payloads_ are used by load generators for testing applications. A payload can be any relevant data that can be used to test your application. For example:

* Sets of names of test scripts that the load generator should execute.
* Sets of SQL queries for loading the database.
* HTTP requests to be sent to the server.
* Different parameters for the same request.

Yandex.Tank uses Phantom and Pandora load generators. Available data types depend on the formats supported by the load generator you select.

Types of payloads:

* [URI](payloads/uri.md)
* [URIPOST](payloads/uripost.md)
* [PHANTOM](payloads/phantom.md)
* [RAW](payloads/raw.md)
* [HTTP_JSON](payloads/http-json.md)