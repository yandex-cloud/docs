# {{ api-gw-full-name }} release notes

## January-February 2024

### Updates

* Added support for the API gateway logging settings in {{ TF }}.
* Added transfer of authorization context in the [HTTP Access](concepts/extensions/http.md) integration.
* Added an extra message to the response from the API gateway if there is an error validating the response from the [{{ sf-name }} function used to authorize an HTTP request](concepts/extensions/function-authorizer.md).

### Fixes and improvements

* Fixed the error with validation of the names of variables in the API gateway specification.
* Fixed the error with transferring the array of query parameter values in the [HTTP Access](concepts/extensions/http.md) integration.
* Reduced API gateway response time at high RPS.
