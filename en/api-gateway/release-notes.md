---
title: '{{ api-gw-full-name }} release notes'
description: This section contains {{ api-gw-name }} release notes.
---

# {{ api-gw-full-name }} release notes

## July 2025 {#july-2025}

### Updates {#updates}

* Increased the default number of [user networks](concepts/networking.md#user-network) per cloud from 1 to 10. This is no longer a limit but a [quota](concepts/limits.md#api-gw-quotas), which can be changed through a request to support.

## June 2025 {#june-2025}

### Fixes and improvements {#fixes-improvements}

* Improved WebSocket protocol stability in {{ api-gw-full-name }}: fixed incorrect ping event processing, fixed unresponsive long-lived connections, optimized event processing.

## May 2025 {#may-2025}

### Updates {#updates}

* Added support for [integration with {{ sw-full-name }}](operations/spec-constructor/workflows.md).

## March 2025 {#march-2025}

### Updates {#updates}

* Added the request execution timeout setting.

## February 2025 {#february-2025}

### Fixes and improvements {#fixes-improvements}

* Added error output to API-gateway logs when using [integration with {{ yds-full-name }}](concepts/extensions/datastreams.md).

## January 2025 {#january-2025}

### Updates {#updates}

* Updated the load distribution mechanism:
    * Changed the API gateway service domain format from `https://d5ds7sk1ahjl********.apigw.yandexcloud.net` to `{{ api-host-apigw }}`: the new format contains one level more.
    * Increased the number of external IP addresses used to process user requests; one API gateway can now have multiple IP addresses.

    With the new mechanism in place, the network remains stable when the load increases.

## November 2024 {#november-2024}

### Updates {#updates}

* Added support for labels.

## September — October 2024 {#sept-oct-2024}

### Updates {#updates}

* Added [validation error handler](concepts/extensions/validator.md#errorhandler) support.

### Fixes and improvements {#fixes-improvements}

* Upgraded the [{{ foundation-models-full-name }} integration](operations/spec-constructor/yagpt.md) form in the specification constructor.
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
    * Added the option to select the array data type for one of the `scopes`/`scp` objects.
* Added support for automatic sending of the result of invoking an integration to a [WebSocket connection](concepts/extensions/websocket.md) when running the `x-yc-apigateway-websocket-connect` operation.

### Fixes and improvements {#fixes-improvements}

* Removed the [user network](concepts/networking#user-network) requirement to have a subnet in the `ru-central1-c` availability zone because [this zone is discontinued](../overview/concepts/region.md).

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

* Fixed an error with validation of the names of variables in the API gateway specification.
* Fixed the error of transferring an array of query parameter values in the [HTTP Access](concepts/extensions/http.md) integration.
* Reduced API gateway response time at high RPS.
