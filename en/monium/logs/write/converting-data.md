# Input data transformation

{{ monium-name }} currently receives data only in the [OpenTelemetry](https://opentelemetry.io/) format. See [this proto specification](https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/collector/logs/v1/logs_service.proto#L33C14-L33C38) for the API and data formats.

As the OpenTelemetry data model is not a full match of the {{ monium-name }} logical data model (e.g., it does not distinguish between `labels` and `meta`), a number of rules and transformations are applied.

## Attribute transformations {#transformations}

Attributes from resources (`ResourceLogs.resource.attributes`), instrumentation scopes (`ScopeLogs.scope.attributes`), and log lines (`LogRecord.attributes`) are merged and transferred into labels (`labels`) and metadata (`meta`) based on the following algorithm:

1. At each level (**resource**/**scope**/**log**), attributes are collected and sorted between `labels` and `meta`:
   * Attributes with names starting with `labels.` go to `labels` (the `labels.` prefix will be deleted).
   * Attributes with names starting with `meta.` go to `meta` (the `meta.` prefix will be deleted).
   * All other attributes go to `meta`, except for the [known attributes](#well-known-attributes).
   * Attributes whose keys start with the `_` character or contain non-printable characters are discarded. The number of discarded attributes will be shown in a [metric](#invalid-attributes-destiny).
1. `labels` and `meta` of all levels (**resource**/**scope**/**log**) get merged; the **log**-level attributes have the highest priority, the **scope**-level attributes have lower priority, and **resource**-level attributes have the lowest priority. For more information, see the [table of priorities](#priorities).
1. Values in `int64` or `double` type attributes remain numeric. Other types are converted to strings:
   * Bool, a string with the `true` or `false` value.
   * Bytes are serialized as a base64 string ([RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648#section-4)).
   * Arrays and dictionaries are serialized similarly to JSON.
1. Attributes from `labels` that do not comply with the [label limitations](../../concepts/data-model.md#labels) are moved to the `meta` level (the existing attribute gets removed).
1. Attributes from `meta` that do not comply with the metadata limitations are discarded. The number of discarded attributes will be shown in a [metric](#invalid-attributes-destiny).


### Priorities {#priorities}

#### Priorities for attributes in `labels`
| Attribute                               | Resource | Scope | Log |
|---------------------------------------|----------|-------|-----|
| Valid value of the `labels.abc` label | 2        | 1     | 0   |

(0 for the highest priority, 2 for the lowest)

#### Priorities for attributes in `meta`
| Attribute                                 | Resource | Scope | Log |
|-----------------------------------------|----------|-------|-----|
| `abc`                                   | 8        | 6     | 4   |
| `meta.abc`                              | 7        | 5     | 3   |
| Invalid value of the `labels.abc` label | 2        | 1     | 0   |

(0 for the highest priority, 8 for the lowest)

### Known attributes {#well-known-attributes}

Some system attributes are treated as labels without the `labels.` prefix:
- `project`
- `cluster`
- `service`, `service.name`
- `host`, `host.name`, `hostname`
- `service.component`
- `service.version`
- `deployment.environment`
- `dc`

{% note warning %}

The `request_id` attribute is also treated as a known label but will be migrated to `meta` soon.

{% endnote %}

{% note warning %}

The `project`, `cluster`, `service`, and `host` system attributes are expected at the resource level.

{% endnote %}

Specifics of transforming reserved labels:

If a non-empty and non-null value is found by the first key in the list (the highest priority one), it is written to the relevant attribute label. The key that was used is removed. Preservation of the remaining keys in the list is not guaranteed.

| Label in otel format (attribute key)   | Transformed into (attribute label) |
|----------------------------------------|----------------------------------|
| `service`/`service.name`               | `service`                        |
| `host`/`host.name`/`hostname`          | `host`                           |
| `labels.component`/`service.component` | `component`                      |
| `labels.version`/`service.version`     | `version`                        |
| `labels.env`/`deployment.environment`  | `env`                            |
| `labels.dc`/`dc`                       | `dc`                             |


## Invalid attributes {#invalid-attributes-destiny}

Attributes that do not comply with the limitations will be deleted and will not go to the long-term storage. The rest of the information from the log line will be saved.

## Supported OTLP fields {#supported-fields-otlp}

### Scope level {#scope-level}

[Scope-level fields](https://github.com/open-telemetry/opentelemetry-proto/blob/e4fd4f681f583b1bdea4d375ad19ddc0dc1f2e9c/opentelemetry/proto/common/v1/common.proto#L71) are transformed into labels:
* The `name` field, into the `scope.name` attribute.
* The `version` field, into the `scope.version` attribute.

The resulting attributes have the lowest priority.

### Log level {#log-level}

#### Trace and span IDs {#trace-span-ids}

The `trace_id` and `span_id` fields are optional. Field values must have the following lengths:
* `trace_id`: 16-byte ID.
* `span_id`: 8-byte ID.

Valid IDs will be saved in the system in HEX format as `trace.id` and `span.id`, respectively.

For more information, see [this specification](https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/logs/v1/logs.proto#L187-L212).

In JSON format, the `trace_id` and `span_id` visualization depends on the protocol:

| Protocol  | Visualization |
|-----------|---------------|
| HTTP+JSON | HEX string    |
| GRPC+JSON | Base64 string |