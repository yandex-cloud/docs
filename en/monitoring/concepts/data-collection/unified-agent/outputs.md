# Outputs

You can describe an output in the `routes` section within the `channel`:`output` element. Alternatively, you can do this in the named channel section, `channels`.

The common output description format is:

```yaml
- output:
    plugin: ... # plugin name
    id: ... # (recommended) output ID, which is used in metrics and agent logs
```

## debug output {#debug_output}

This is a debug output that outputs incoming messages to a file or console.

Given that the storage does not support local data view, you can set up data export to a file using this output. You can use the `logrotate` utility to set up log rotation. For the agent to start writing logs to a new file, use the `reopen_file` method.

Configuration example:

```yaml
status:
  port: 16301

output:
  plugin: debug
  id: my_output_id
  config:
    file_name: ./data/output
    delimiter: "\n===\n"
    _test:
      register_test_handlers: true
```

Parameter descriptions:

```yaml
- channel:
    output:
        plugin: debug
        config:
            # Make sure to specify either the file_name or directory property.

            # Name of the file to write messages to.
            # To output data to the console, specify /dev/stdout.
            file_name: out.txt # optional, not set by default

            # Directory name. If specified, the data for each session is written to a separate file in this directory with a name equal to the session ID.
            directory: output_directory # optional, not set by default

            # Message separator used in the file, for example, \n.
            delimiter: null # required
```

## dev_null output {#dev_null_output}

An empty debug output does not save incoming messages. There are no parameters.

## yc_metrics output {#yc_metrics_output}

An output used for writing metrics in the {{ monitoring-full-name }} API.

Parameter descriptions:

```yaml
- channel:
    output:
        plugin: yc_metrics
        config:
        # The URL to send metrics to.
        url: https://monitoring.{{ api-host }}/monitoring/v2/data/write # optional, the default value is https://monitoring.{{ api-host }}/monitoring/v2/data/write

        folder_id: b1ge2vt0gml6******** # required, the folder ID

        # IAM authentication settings.
        iam: # required
            # Either the cloud_meta or jwt element must be specified.

            # If specified, the IAM token is taken from the metadata service.
            cloud_meta: {} # optional, not set by default

            # If specified, JWT is exchanged for an IAM token.
            jwt: # optional, not set by default
            # The name of the file containing the JWT parameters in the format returned by the `yc iam key create` command.
                file: "jwt_params.json" # required

                endpoint: iam.{{ api-host }} # optional, the default value is iam.{{ api-host }}

                refresh_period: 1h # optional, the default value is 1h

                request_timeout: 10s # optional, default value is 10 seconds

        # Number of repeat attempts if the request failed.
        # If the request was not completed successfully within the specified number of attempts (i.e., status 200 response was not received), the message is discarded: confirmation is generated for the agent.
        # Messages discarded this way are counted in the plugin's DroppedMessages counter. They are also displayed in the generic health counters MessagesLost and BytesLost.
        retry_count: inf # optional, default value is max_int (means that messages will not be discarded)

        # Interval between repeat attempts.
        retry_delay: 1s # optional, the default value is 1 second

        # Request timeout, including all repeated attempts.
        timeout: inf # optional, default value is max_int seconds (means that messages will not be discarded)

        # Timeout per attempt.
        request_timeout: 1s # optional, default value is 1 second
```



## yc_logs output {#yc_logs_output}

Output used for sending metrics to {{ cloud-logging-full-name }} via [gRPC](../../../../logging/api-ref/grpc/log_ingestion_service.md).

{% note info %}

The agent does not guarantee the absence of duplicate messages in the target system but does its best to avoid them. Duplicates may appear in case of a stop and subsequent restart.

{% endnote %}

Parameter descriptions:

```yaml
- channel:
    output:
        plugin: yc_logs
       config:
        # The URL to send metrics to.
        url: https://monitoring.{{ api-host }}/monitoring/v2/data/write # optional, the default value is https://monitoring.{{ api-host }}/monitoring/v2/data/write

        folder_id: b1ge2vt0gml6******** #required, the folder ID

        # IAM authentication settings.
        iam: # required
            # Either the cloud_meta or jwt element must be specified.

            # If specified, the IAM token is taken from the metadata service.
            cloud_meta: {} # optional, not set by default

            # If specified, JWT is exchanged for an IAM token.
            jwt: # optional, not set by default
            # The name of the file containing the JWT parameters in the format returned by the `yc iam key create` command.
                file: "jwt_params.json" # required

                endpoint: iam.{{ api-host }} # optional, the default value is iam.{{ api-host }}

                refresh_period: 1h # optional, the default value is 1h

                request_timeout: 10s # optional, default value is 10 seconds

        # Number of repeat attempts if the request failed.
        # If the request was not completed successfully within the specified number of attempts (i.e., status 200 response was not received), the message is discarded: confirmation is generated for the agent
        # Messages discarded this way are counted in the plugin's DroppedMessages counter. They are also displayed in the generic health counters MessagesLost and BytesLost.
        retry_count: inf # optional, default value is max_int (means that messages will not be discarded)

        # Interval between repeat attempts.
        retry_delay: 1s # optional, the default value is 1 second

        # Request timeout, including all repeated attempts.
        timeout: inf # optional, default value is max_int seconds (means that messages will not be discarded)

        # Timeout per attempt.
        request_timeout: 1s # optional, default value is 1 second
```

