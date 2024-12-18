---
title: '{{ api-gw-full-name }} release notes'
description: This section contains {{ api-gw-name }} release notes.
---

# {{ api-gw-full-name }} release notes

## November 2024 {#november-2024}

### Updates {#updates}

* Added support for labels.

## September — October 2024 {#sept-oct-2024}

### Updates {#updates}

* Added [validation error handler](concepts/extensions/validator.md#errorhandler) support.

### Fixes and improvements {#fixes-improvements}

* Enhanced the [{{ yagpt-full-name }} integration](operations/spec-constructor/yagpt.md) form in the specification constructor.
* Updated [integration with {{ objstorage-full-name }}](operations/spec-constructor/object-storage.md): changed the logic of managing the response code returned if a queried object is not in the specified bucket.

## August 2024 {#august-2024}

### Updates {#updates}

* Added support for [integration with {{ yagpt-name }}](operations/spec-constructor/yagpt.md).
* Added support for [integration with {{ sws-full-name }}](concepts/extensions/sws.md).
* Added support for the following extensions:
    * `x-yc-status-mapping`: [Response code replacement](concepts/extensions/status-mapping.md).
    * `x-yc-schema-mapping`: [Transformation of response and request bodies](concepts/extensions/schema-mapping.md).

## July 2024 {#july-2024}

### Updates {#updates}

* Added support for [triggers](concepts/trigger/index.md) that send messages to WebSocket connections.

### Fixes and improvements {#fixes-improvements}

* Fixed errors when [selecting a handler](concepts/index.md#algorithm) in the OpenAPI specification.

## May – June 2024 {#may-june-2024}

### Updates {#updates}

* Added support for the [specification constructor](operations/spec-constructor/index.md).

## April 2024 {#april-2024}

### Updates {#updates}

* Updates to the [x-yc-apigateway-authorizer:jwt](concepts/extensions/jwt-authorizer.md) extension:
    * Added an alternative name for the `scopes` parameter: `scp`.
    * Added an option to select the array data type for one of the `scopes`/`scp` objects.
* Added support for automatically sending the result of invoking an integration to a [WebSocket connection](concepts/extensions/websocket.md) when running the `x-yc-apigateway-websocket-connect` operation.

### Fixes and improvements {#fixes-improvements}

* Removed the [user network](concepts/networking#user-network) requirement to have a subnet in the `ru-central1-c` availability zone because [this zone is discontinued](../overview/concepts/ru-central1-c-deprecation).

## March 2024 {#march-2024}

### Updates {#updates}

* Added the `default_object` parameter to the OpenAPI specification extension for [integration with {{ objstorage-full-name }}](concepts/extensions/object-storage.md).
* Added parameter substitution support to `error_object` and `default_object` in the OpenAPI specification extension for integration with {{ objstorage-full-name }}.
* Added support for provision of the `Via` and `Www-Authenticate` headers from integrations' responses.
* Added support for automatic sending of an integration response to a web socket within the `x-yc-apigateway-websocket-connect` [operation](concepts/extensions/websocket.md#connect).

## January – February 2024 {#jan-feb-2024}

### Updates {#updates}

* Added support for the API gateway logging settings in {{ TF }}.
* Added transfer of authorization context in the [HTTP Access](concepts/extensions/http.md) integration.
* Added an extra message to the response from the API gateway if there is an error validating the response from the [{{ sf-name }} function used to authorize an HTTP request](concepts/extensions/function-authorizer.md).

### Fixes and improvements {#fixes-improvements}

* Fixed the error with validation of the names of variables in the API gateway specification.
* Fixed the error with transferring the array of query parameter values in the [HTTP Access](concepts/extensions/http.md) integration.
* Reduced API gateway response time at high RPS.
