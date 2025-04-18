---
title: Resource relationships in {{ api-gw-full-name }}
description: An API gateway is an interface for working with services in {{ yandex-cloud }} or on the internet. API gateways are set in a declarative way using specifications. A specification is a JSON or YAML file with an API gateway description based on the OpenAPI 3.0 standard. In {{ api-gw-name }}, the specification includes extensions for integration with other cloud platforms.
---

# Resource relationships in {{ api-gw-name }}

An _API gateway_ is an interface for working with services in {{ yandex-cloud }} or on the internet.

API gateways are set in a declarative way using specifications. A specification is a JSON or YAML file with an API gateway description based on the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) standard. In {{ api-gw-name }}, the specification includes extensions for integration with other cloud platforms.

Available extensions:
* [Static response](../concepts/extensions/dummy.md)
* [Access over HTTP](../concepts/extensions/http.md)
* [Integration with {{ sf-name }}](../concepts/extensions/cloud-functions.md)
* [Integration with {{ serverless-containers-name }}](../concepts/extensions/containers.md)
* [Integration with {{ sws-name }}](../concepts/extensions/sws.md)
* [Integration with {{ objstorage-name }}](../concepts/extensions/object-storage.md)
* [Integration with {{ ml-platform-name }}](../concepts/extensions/datasphere.md)
* [Integration with {{ yds-name }}](../concepts/extensions/datastreams.md)
* [Integration with {{ message-queue-short-name }}](../concepts/extensions/ymq.md)
* [Integration with {{ ydb-short-name }}](../concepts/extensions/ydb.md)
* [{#T}](../concepts/extensions/greedy-parameters.md)
* [Generic HTTP method](../concepts/extensions/any-method.md)
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

## Algorithm for a handler search in the OpenAPI specification {#algorithm}

When searching for a handler, {{ api-gw-name }} does the following:
1. Selects routes in the OpenAPI specification matching the request being processed.
1. Sorts the selected routes by priority:
    * The highest priority is given to fixed routes, which do not contain path parameters and [greedy parameters](extensions/greedy-parameters.md), e.g., `/simple/path`.
    * Routes that contain path parameters but do not have any greedy parameters get the medium priority, e.g., `/{param}/path`.
    * The lowest priority is given to routes with greedy parameters, e.g., `/{greedy_param+}`.

    If two routes have the same priority:
    * Two routes with medium priority are consistently compared across URL segments. There are two types of segments: fixed (e.g., `simple`) and parameterized (e.g., `{param}`). A fixed segment has a higher priority than a parameterized one. If all route segments have the same priority, the longer route is selected.
    * If two routes have the lowest priority, the longer one is selected.

### Examples of route comparison

{% cut "`/a/{param1}/b` and `/a/{param2}/{param3}`" %}

Both routes have medium priority because they contain path parameters, but do not contain greedy parameters, so they are consistently compared across URL segments.

1. The `a` and `a` segments are both fixed and have the same priority.
1. The `{param1}` and `{param2}` segments are both parameterized and have the same priority.
1. The `b` segment is fixed and the `{param3}` segment is parameterized, so the `b` segment is selected.

Thus, `/a/{param1}/b` is selected as a handler.

{% endcut %}

{% cut "`/a/b/{param1}` and `/a/{param2}/d`" %}

Both routes contain path parameters but do not contain greedy parameters, so they have medium priority and are consistently compared across URL segments.

1. The `a` and `a` segments are both fixed and have the same priority.
1. The `b` segment is fixed and the `{param2}` segment is parameterized, so the `b` segment is selected.

Thus, `/a/b/{param1}` is selected as a handler.

{% endcut %}

{% cut "`/a/b/{param+}` and `/a/{param2}/d`" %}

The `/a/b/{param+}` route contains a greedy parameter, which means it has the lowest priority. The `/a/{param2}/d` route contains a path parameter, but does not contain a greedy parameter, so it has medium priority. Out of the medium and lowest-priority routes, the route with the medium priority is selected.

Thus, `/a/{param2}/d` is selected as a handler.

{% endcut %}

{% cut "`/a/{param}` and `/a/{prm}`" %}

Both routes contain path parameters but do not contain greedy parameters, so they have medium priority and are consistently compared across URL segments.

1. The `a` and `a` segments are both fixed and have the same priority.
1. The `{param}` and `{prm}` segments are both parameterized and have the same priority.

Since it is not possible to select a route based on segments, the route lengths are compared. The `/a/{param}` route is longer than the `/a/{prm}` route.

Thus, `/a/{param}` is selected as a handler.

{% endcut %}

{% cut "`/a/{param1}/{param+}` and `/a/{param2}/{prm+}`" %}

Both routes contain greedy parameters, so they have the lowest priority and their lengths are compared. The `/a/{param1}/{param+}` route is longer than the `/a/{param2}/{prm+}` route.

Thus, `/a/{param1}/{param+}` is selected as a handler.

{% endcut %}

## Using domains {#domains}

{{ api-gw-short-name }} allows you to add your own domain to access the API gateway. To establish a TLS connection, you can use certificates added in {{ certificate-manager-short-name }}.

For more information on connecting your own domain to the API gateway, see [{#T}](../operations/api-gw-domains.md).

For more information on adding certificates, see [{#T}](../../certificate-manager/operations/managed/cert-create.md).

## Authorization {#authorization}

{{ api-gw-short-name }} enables you to implement common [authentication and authorization algorithms](https://swagger.io/docs/specification/authentication/) as described in the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) specification. Currently, you can use [authorization using a function](../concepts/extensions/function-authorizer.md) and [using JWT](../concepts/extensions/jwt-authorizer.md).

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

To set up integrations, you can use [special extensions](extensions/websocket.md) in the OpenAPI specification.

You can manage web sockets using the [API](../api-ref/websocket/authentication.md) that receives information about a connection, sends data to the client side, and closes the connection.

For limits related to WebSocket support, see [Quotas and limits](../concepts/limits.md).

To view an example of a serverless WebSocket app, [click here](http://github.com/yandex-cloud-examples/yc-serverless-game).
 
#### See also {#see-also}

* [Overview of available extensions](extensions/index.md)
