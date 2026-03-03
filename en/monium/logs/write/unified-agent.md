# Sending logs via {{ unified-agent-short-name }}

{% include [about-agent](../../../_includes/monium/about-agent.md) %}

{{ unified-agent-short-name }} is a versatile telemetry collection agent by Yandex that works with metrics, traces, and logs. It supports authentication via the TVM protocol and integrates with various log sources, including the file system, logrotate-compatible sources, and HTTP/GRPC interfaces. You can deploy {{ unified-agent-short-name }} directly to the host system, including a real-time container (RTC) environment.

This section provides common examples of how to configure {{ unified-agent-short-name }} to send logs to {{ cloud-logging-name }}. For more information on setting up an agent, see [this {{ unified-agent-short-name }} guide](../../concepts/data-collection/unified-agent/).

## Sending logs from an application {#logs-from-app}

{% cut "Configuration example" %}

```yaml
routes:
    - input:
          plugin: otel_logs
          config:
              port: 8889

      channel:
          output:
              plugin: otel_logs
              config:
                  project: folder__<folder_ID>
                  cluster: doc

                  format: proto
                  url: "{{ api-host-monium }}:443"

                  tvm:
                      client_id: 2025442
                      destination_id: 2045111
                      secret:
                          file: /my/secret/token
```

{% endcut %}

In this configuration, the agent expects logs in OpenTelemetry format at `localhost:8889`. The collected logs then go to the collector to be saved in the `folder__<folder_ID>` project.

A TVM is used for authentication. The `secret` section specifies the path to the file with the API key for obtaining the TVM token, and the `client_id` section specifies the ID of the service account with the `yc.logging.write` role.

## Collecting logs from a file {#send-logs-from-file}

{% cut "Configuration example" %}

```yaml
routes:
  - input:
      plugin: file_input
      config:
        path: /logs/fetcher.log
        state_directory: <path_to_directory>

    channel:
      pipe:
        - filter:
            plugin: subprocess
            config:
              command: <path_to_parser>
              arguments:
                - "--project=examples"
                - "--cluster=doc"
                - "--service=example"
      output:
        plugin: otel_logs
        config:
          project: folder__<folder_ID>
          cluster: doc
          service: example

          format: json
          url: "{{ api-host-monium }}:443"

          tvm:
            client_id: 2025442
            destination_id: 2045111
            secret:
              file: <path_to_secret_file>
```

{% endcut %}

Where:

* `<path_to_folder>`: Folder with agent state files, e.g., `/var/lib/ua/state`.
* `<path_to_parser>`: Full path to the parser executable file. The parser accepts log strings as input, converts them to the required format, e.g., protobuf or JSON, and outputs the result. For example, `/usr/local/bin/cpp_processes`.
* `<path_to_secret_file>`: File with the TVM secret, e.g., `/etc/ua/tvm_secret`.

In this configuration, the agent reads entries from the `/logs/fetcher.log` file. The `state_directory` parameter defines the folder for storing service status files to ensure logs are read correctly after the agent restarts.

The read logs are processed with an external parser, which converts the logs into OpenTelemetry format.

The final data goes to the `folder__<folder_ID>` project in {{ monium-name }} at the address specified under `url`. 

A TVM is used for authentication. The `secret` section specifies the path to the file with the API key for obtaining the TVM token, and the `client_id` section specifies the ID of the service account with the `yc.logging.write` role.