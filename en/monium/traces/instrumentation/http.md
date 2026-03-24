# HTTP communication

If you are using [automatic instrumentation](auto.md), spans are created and attributes are filled automatically. If using [manual instrumentation](manual.md), follow the conventions described below:

## Naming convention {#naming}

* **Client span**: `<Method>` if the URL template is unknown, or `<url.template> <method>` if known, e.g., `GET /users/{user_id}`.
* **Server span**: `<http.route> <method>`, e.g., `GET /users/:user_id`.

If the client does not use templated URLs, the span name contains only the method. If the template is known, it is included into the name via the `url.template` attribute. The server span includes a templated route (`/users/:user_id`) instead of a specific path (`/users/321`). For more information, see the [HTTP span naming specification](https://opentelemetry.io/docs/specs/semconv/http/http-spans/#name).

## Attributes {#attributes}

#|
|| Attribute | Description ||
|| `http.request_method` | HTTP method: `GET`, `POST`, etc. ||
|| `http.response.status_code` | Response code: `200`, `404`, etc. ||
|| `http.route` | Templated server-side route: `/users/:user_id` ||
|| `url.scheme` | Request schema: `http` or `https` ||
|| `url.full` | Full request URL ||
|| `url.template` | Templated client-side URL: `/users/{user_id}` ||
|| `server.address` | Host name or IP address of the target server ||
|| `server.port` | Target server port ||
|| `client.address` | Client IP address ||
|#

## Example {#example}

`order-service` requests user data from `user-service` over HTTP:

#|
|| Attribute | Client span | Server span ||
|| Name | `GET` | `GET /users/:user_id` ||
|| Kind | `CLIENT` | `SERVER` ||
|| Status | `OK` | `OK` ||
|| `http.request_method` | `GET` | `GET` ||
|| `http.route` | — | `/users/:user_id` ||
|| `url.template` | `/users/{user_id}` | — ||
|| `http.response.status_code` | `200` | `200` ||
|| `url.scheme` | `https` | `https` ||
|| `url.full` | `https://user-service.example.com/users/321` | — ||
|| `server.address` | `user-service.example.com` | — ||
|| `server.port` | `443` | — ||
|| `client.address` | — | `192.0.2.4` ||
|#
