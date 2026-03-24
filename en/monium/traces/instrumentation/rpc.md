# RPC calls

If you are using [automatic instrumentation](auto.md), RPC call spans are created and attributes filled automatically. If using [manual instrumentation](manual.md), follow the conventions described below:

## Naming convention {#naming}

The span name has the `<package>.<service>/<method>` format, e.g., `grpc.users.UserService/GetUserInfo`. If the package name is missing or unknown, the `<package>.` part is omitted. For more information, see the [RPC span naming specification](https://opentelemetry.io/docs/specs/semconv/rpc/rpc-spans/#span-name).

## Attributes {#attributes}

#|
|| Attribute | Description ||
|| `rpc.system` | RPC system type: `grpc`, `java_rmi`, `dotnet_wcf`, etc. ||
|| `rpc.service` | Service name: `UserService` ||
|| `rpc.method` | Method name: `GetUserInfo` ||
|| `rpc.grpc.status_code` | gRPC status code: `0` is OK, `2` is UNKNOWN, etc. ||
|| `server.address` | Host name or IP address of the target server ||
|| `server.port` | Target server port ||
|| `client.address` | Client IP address ||
|| `client.port` | Client port ||
|#

For a full list of attributes, see the [OpenTelemetry specification for RPC spans](https://opentelemetry.io/docs/specs/semconv/rpc/rpc-spans/).

## Example {#example}

`order-service` requests user data from `user-service` over gRPC:

#|
|| Attribute | Client span | Server span ||
|| Name | `grpc.users.UserService/GetUserInfo` | `grpc.users.UserService/GetUserInfo` ||
|| Kind | `CLIENT` | `SERVER` ||
|| Status | `OK` | `OK` ||
|| `rpc.system` | `grpc` | `grpc` ||
|| `rpc.service` | `UserService` | `UserService` ||
|| `rpc.method` | `GetUserInfo` | `GetUserInfo` ||
|| `rpc.grpc.status_code` | `0` | `0` ||
|| `server.address` | `grpc.users.example.com` | — ||
|| `server.port` | `443` | — ||
|| `client.address` | — | `10.1.2.80` ||
|| `client.port` | — | `65123` ||
|#
