# Migrating from {{ cloud-logging-name }} to {{ monium-name }}

{% include [deprecation-warning](../../_includes/logging/deprecation-warning.md) %}

## {{ cloud-logging-name }} and {{ monium-name }} comparison {#comparison}

{% include [migration-comparison](../../_pricing_examples/monium/migration-comparison.md) %}

## Testing {{ monium-name }} without migration {#preview}

Logs from {{ cloud-logging-name }} are already available in {{ monium-name }}. Open them in the [management console]({{ link-console-main }}) by doing one of the following: 

* When viewing logs in {{ cloud-logging-name }}, click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.
* Open the link:

  ```
  {{ link-monium }}/projects/folder__<folder_ID>/logs
  ```

For each folder, the system creates a project with an ID in `folder__<folder_ID>` format, where you can access logs of each log group by its name.

To search for logs, specify this query:

```
{project="folder__<folder_ID>", cluster="default", service="<log_group_name>"}
```

## Migration steps {#migration-steps}

1. [Make sure](#preview) the data is available in {{ monium-name }} in the `folder__<folder_ID>` project.

1. Update your data delivery agent (Unified Agent, Fluent Bit 4.0) or use [Otel Collector](../collector/opentelemetry.md) and [configure delivery in OTel format](#agent-setup).

1. Specify a new endpoint: `{{ api-host-monium }}:443`. Otherwise, logs will continue to be delivered via {{ cloud-logging-name }} and billed accordingly.

1. Make sure logs are delivered to {{ monium-name }} directly, not via {{ cloud-logging-name }}.

   To check this, [view service usage details](../../billing/operations/check-charges.md#products) by products in {{ billing-name }}. After migration, you should see usage details for logs in {{ monium-name }}. {{ cloud-logging-name }} consumption should decrease or stop entirely.

   After migration, logs will be billed according to the {{ monium-name }} pricing and all platform features will become available.

1. Optionally, rename the projects, clusters, and services. You can leave the current structure: `folder__<folder_ID>` → `default` → `log group name` or set custom names. For more information, see [{#T}](../concepts/data-model.md).

## Configuring an agent for OTel delivery {#agent-setup}

### Unified Agent {#unified-agent}

1. Replace the `output` section in the configuration file.

   **Previously:**

   ```yaml
   channel:
     output:
       plugin: yc_logs
       config:
         url: "{{ logging-endpoint-ingester }}:443"
         log_group_id: "<log_group_ID>"
         folder_id: "<folder_ID>"
         iam:
           cloud_meta:
   ```

   **Now:**

   ```yaml
   channel:
     output:
       plugin: otel_logs
       config:
         url: "{{ api-host-monium }}:443"
         project: folder__<folder_ID>
         service: <service_name>
         iam:
           cloud_meta:
   ```

   You can specify any `project`: you can [create your own projects](../collector/project.md) in {{ monium-name }}. In the `service` property, specify the log group name to save the data structure.

1. To specify a cluster, add the `cluster: <cluster_name>` property. The default value is `default`.

### Fluent Bit {#fluent-bit}

You can continue using Fluent Bit or configure delivery via [OTel Collector](../collector/opentelemetry.md).

1. Make sure that your [Fluent Bit](https://fluentbit.io/) version is 4.0 or higher:

   ```bash
   apt show fluent-bit
   ```

1. Make sure the configuration file is in YAML format. Support for the standard INI format will be discontinued at the end of 2026.

1. Replace the `outputs` section.

   **Previously** (`yc-logging` plugin):

   ```yaml
   pipeline:
     outputs:
       - name: yc-logging
         ...
   ```

   **Now** (`opentelemetry` plugin):

   ```yaml
   pipeline:
     outputs:
       - name: opentelemetry
         host: {{ api-host-monium }}
         port: 443
         logs_uri: /otlp/v1/logs
         tls: on
         tls.verify: off
         header:
           - Authorization Api-Key ${API_KEY}
           - x-monium-project folder__<folder_ID>
   ```

   You can provide an IAM token instead of an API key: `Authorization Bearer ${IAM_TOKEN}`.

1. If the input plugin does not use OpenTelemetry or the `service` property is not set in messages, add the `opentelemetry_envelope` processor with these resource attributes:

   ```yaml
   pipeline:
     inputs:
       - name: <input_plugin>
         processors:
           logs:
             - name: opentelemetry_envelope
             - name: content_modifier
               context: otel_resource_attributes
               action: upsert
               key: service.name
               value: <log_group_name>
             - name: content_modifier
               context: otel_resource_attributes
               action: upsert
               key: cluster
               value: default
   ```

   In the `service.name` property, specify the log group name to save the data structure. The `cluster` property is optional. The default value is `default`.

## Reading logs via the API {#api-reading}

[Reading logs via the {{ cloud-logging-name }} API](../../logging/api-ref/grpc/LogReading/read.md) will be supported until March 1, 2027 if you preserve the `folder__<folder_ID>` → `default` → `log group name` structure. All data remains accessible within the 31-day retention period.

Reading data via the {{ monium-name }} API and the associated documentation will become available in July 2026. Make sure to migrate read requests to the new API before the old API support is discontinued.