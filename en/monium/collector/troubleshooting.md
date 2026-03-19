# Data delivery troubleshooting

This section can help you diagnose and fix most of the issues you may encounter when delivering data to {{ monium-name }}.

{{ monium-name }} supports OTLP data without additional conversion. Therefore, start by studying the [OTLP configuration requirements](otlp-protocol.md) and [OTel Collector setup](opentelemetry.md).

## General diagnostics recommendations {#general-troubleshooting}

If you have issues sending data to {{ monium-name }}, go through these basic diagnostic steps:

1. **Enable logging**. Make sure your OTLP client has detailed logging activated to give you detailed error info. The logging activation method depends on your particular implementation.

1. **Check environment variables**. Make sure the `MONIUM_PROJECT` and `MONIUM_API_KEY` environment variables are correctly defined and available to your application or OTel Collector.

1. **Check the API key**:
    * The API key is valid, not expired.
    * The API key has the `yc.monium.telemetry.write` scope.
    * The service account associated with the API key has the `monium.telemetry.writer` role.
    * The `Authorization` header has the correct format: `Authorization: Api-Key <API_key>`.

1. **Check the project configuration in the OTEL exporter**:
    * The `MONIUM_PROJECT` variable is set and has the correct format. The project must have the same name as in the URL on the project home page.
    * The `x-monium-project` header provides the `MONIUM_PROJECT` variable value.
    * The API key and service account have write permissions for the project.

1. **Test network availability**. {{ monium-name }} may require you to configure a firewall depending on your network configuration. If gRPC connections are blocked from your network, configure sending over `http/protobuf`.

## Errors {#issue-catalog}

The table lists common errors you may get when using {{ monium-name }} over gRPC.

#|
|| **gRPC code** | **Error type** | **Error message** | **Solution** | **Notes** ||
|| rpc code 3 - InvalidArgument | No project header provided | `rpc error: code = InvalidArgument desc = project must be provided using 'x-monium-project' header` | Add the `x-monium-project` header to the exporter configuration | Make sure the `MONIUM_PROJECT` variable is defined and provided in the header ||
|| rpc code 7 - Unauthenticated | No project header provided (alternative message) | `rpc error: code = Unauthenticated desc = missing project header` | Add the `x-monium-project` header to the exporter configuration | Make sure the `MONIUM_PROJECT` variable is defined and provided in the header ||
|| rpc code 7 - Unauthenticated | No authorization provided | `rpc error: code = Unauthenticated desc = No valid Authorization header provided` | Make sure the `Authorization` header is present | Add the `Authorization: Api-Key <key>` header ||
|| rpc code 7 - Unauthenticated | No authorization provided | `rpc error: code = Unauthenticated desc = Api-Key token must not be blank` | The `Authorization` header is present but the token value is empty | Make sure the `MONIUM_API_KEY` variable is set ||
|| rpc code 16 - PermissionDenied | Obsolete API key | `rpc error: code = PermissionDenied desc = UNAUTHENTICATED: The apikey has expired` | The key has expired | Generate a new API key and update `MONIUM_API_KEY` ||
|| rpc code 16 - PermissionDenied | Unknown API key | `rpc error: code = PermissionDenied desc = UNAUTHENTICATED: Unknown api key '****'` | Unknown API key | Generate a new API key and update `MONIUM_API_KEY` ||
|| rpc code 16 - PermissionDenied | Invalid API key | `rpc error: code = PermissionDenied desc = UNAUTHENTICATED: API key is invalid` | Make sure the API key and the `Authorization` header format are correct | The API key must be provided as `Authorization: Api-Key <key>` ||
|| rpc code 16 - PermissionDenied | Not enough permissions | `rpc error: code = PermissionDenied desc = PERMISSION_DENIED: Permission denied` | Check the API key permissions for the folder | Make sure that the project is specified correctly, the API key has the `yc.monium.telemetry.write` scope, and the service account has the `monium.telemetry.writer` role ||
|| rpc code 16 - PermissionDenied | Project not found | `rpc error: code = PermissionDenied desc = PERMISSION_DENIED: Project not found` | Check the project name format | Copy the project name from the URL on the project home page ||
|| rpc code 8 - ResourceExhausted | Quota for number of stored metrics exceeded | `rpc error: code = ResourceExhausted desc = more than 100000 metrics in shard` | Increase the for stored metrics number quota | Contact support to increase the metrics per shard limit ||
|| transport | No network access | `connection error: desc = "transport: Error while dialing: dial tcp [2a0d:d6c1:0:1a::3d0]:443: connect: no route to host` | Check `https://{{ api-host-monium }}` for network accessibility | If the gRPC protocol is blocked, configure export over `http/protobuf` ||
|#

## More information {#additional-info}

If you get OTel Collector configuration errors, refer to the [official OpenTelemetry guide](https://opentelemetry.io/docs/collector/troubleshooting/).

You can check the configuration using this command:

```bash
otelcol validate --config=otel-collector.yaml
```