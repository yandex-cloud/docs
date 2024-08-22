---
title: "Resource relationships in {{ api-gw-full-name }}"
description: "API gateway is an interface for working with services in {{ yandex-cloud }} or on the internet. API gateways are set in a declarative way using specifications. A specification is a JSON or YAML file with an API gateway description based on the OpenAPI 3.0 standard. In {{ api-gw-name }}, the specification is supplemented with extensions that you can use for integrating with other cloud platforms."
---

# Resource relationships in {{ api-gw-name }}

_API gateway_ is an interface for working with services in {{ yandex-cloud }} or on the internet.

API gateways are set in a declarative way using specifications. A specification is a JSON or YAML file with an API gateway description based on the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) standard. In {{ api-gw-name }}, the specification is supplemented with extensions that you can use for integrating with other cloud platforms.

Available extensions:
* [Static response](../concepts/extensions/dummy.md)
* [Access over HTTP](../concepts/extensions/http.md)
* [Integration with {{ sf-name }}](../concepts/extensions/cloud-functions.md)
* [Integration with {{ serverless-containers-name }}](../concepts/extensions/containers.md)
* [Integration with {{ objstorage-name }}](../concepts/extensions/object-storage.md)
* [Integration with {{ ml-platform-name }}](../concepts/extensions/datasphere.md)
* [Integration with {{ yds-name }}](../concepts/extensions/datastreams.md)
* [Integration with {{ message-queue-short-name }}](../concepts/extensions/ymq.md)
* [Integration with {{ ydb-short-name }}](../concepts/extensions/ydb.md)
* [{#T}](../concepts/extensions/greedy-parameters.md)
* [Generalized HTTP method](../concepts/extensions/any-method.md)
* [Authorization using a {{ sf-name }} function](../concepts/extensions/function-authorizer.md)
* [Authorization using a JWT](../concepts/extensions/jwt-authorizer.md)
* [{#T}](../concepts/extensions/websocket.md)
* [{#T}](../concepts/extensions/validator.md)
* [CORS support](../concepts/extensions/cors.md)
* [{#T}](../concepts/extensions/parametrization.md)
* [{#T}](../concepts/extensions/canary.md)
* [{#T}](../concepts/extensions/rate-limit.md)
* [Response code replacement](../concepts/extensions/status-mapping.md)
* [Transformation of response and request bodies](../concepts/extensions/schema-mapping.md)

## Using domains {#domains}

{{ api-gw-short-name }} is integrated with the {{ certificate-manager-short-name }} domain management system.

You can use domains with confirmed rights when accessing the API. In this case, a certificate linked to the domain is used to provide a TLS connection.

For more information about domains, see [{#T}](../../certificate-manager/concepts/domains/services.md).

## Authorization {#authorization}

{{ api-gw-short-name }} enables you to implement common [authentication and authorization tools](https://swagger.io/docs/specification/authentication/) as described in the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) specification. Currently, you can use [authorization through a function](../concepts/extensions/function-authorizer.md) and [through JWT](../concepts/extensions/jwt-authorizer.md).

## WebSocket {#websocket}

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

For two-way asynchronous communication between clients and an API gateway, {{ api-gw-short-name }} supports the [WebSocket](https://en.wikipedia.org/wiki/WebSocket) protocol. Clients can send messages to an API gateway, which in turn can independently send messages to client applications. This means clients can receive data without having to make an HTTP request. Web sockets are often used in apps that require real-time data updates, such as messengers and online chats, multiplayer games, collaboration tools, trading apps, and sports betting services.

To connect to an API gateway using WebSocket, you can use a service domain allocated when creating the API gateway or any other domain added to the API gateway.

Integrations are supported for the following events:
* Opening a connection.
* Sending messages via a web socket.
* Closing a connection.

To set up integrations, there are [special extensions](extensions/websocket.md) of the OpenAPI specification.

You can manage web sockets using the [API](../api-ref/websocket/authentication.md) that receives information about a connection, sends data to the client side, and closes the connection.

For limits related to WebSocket support, see [Quotas and limits](../concepts/limits.md).

To view an example of a serverless WebSocket app, [click here](http://github.com/yandex-cloud-examples/yc-serverless-game).

#### See also {#see-also}

* [Overview of available extensions](extensions/index.md)
