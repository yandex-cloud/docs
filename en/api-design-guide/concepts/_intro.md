# API architecture

{{ yandex-cloud }} APIs are based on the [gRPC](https://grpc.io/docs/) mechanism. Methods and data structures in APIs are described using [Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3) (proto 3).

{{ yandex-cloud }} supports JSON REST to enable API communication.

When a client sends HTTP requests to an API, the service translates incoming requests
into gRPC messages. When a gRPC response is ready, the service translates it
into an HTTP response and returns it to the client. REST to gRPC translation is done via the [gRPC-JSON transcoder](https://www.envoyproxy.io/docs/envoy/v1.5.0/api-v1/http_filters/grpc_json_transcoder_filter).

Both REST and gRPC APIs use a resource-based approach.
API concepts are described in the section [Basic API concepts](general.md).
