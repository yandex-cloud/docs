# Outputs

You can describe an output in the `routes` section within the `channel`:`output` element, or in the `channels` section for named channels.

The common output description format is:

```yaml
- output:
    plugin: ... # Plugin name.
    id: ... # (Recommended) output ID, which is used in metrics and agent logs.
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
            # To output data to the console, specify "/dev/stdout".
            file_name: out.txt  # Optional, not set by default.

            # Directory name. If specified, the data for each session is written to a separate file in this directory with a name equal to the session ID.
            directory: output_directory  # Optional, not set by default.

            # Message separator used in the file, for example, "\n".
            delimiter: null  # Required
```

## dev_null output {#dev_null_output}

An empty debug output does not save incoming messages. There are no parameters.

## yc_metrics output {#yc_metrics_output}

An output used for writing metrics in the {{ monium-name }} API.

Parameter descriptions:

```yaml
- channel:
    output:
        plugin: yc_metrics
        config:
        # URL to send metrics to.
        url: https://monitoring.{{ api-host }}/monitoring/v2/data/write  # Optional, the default value is https://monitoring.{{ api-host }}/monitoring/v2/data/write.

        folder_id: b1ge2vt0gml6********  # Required, folder ID.

        # IAM authentication settings.
        iam:  # Required
            # Either the cloud_meta or jwt element must be specified.

            # If specified, the IAM token is taken from the metadata service.
            cloud_meta: {} # Optional, not set by default.

            # If specified, the JWT is exchanged for the IAM token.
            jwt: # Optional, not set by default.
            # Name of the file containing the JWT parameters in the format returned by the `yc iam key create` command.
                file: "jwt_params.json"  # Required

                endpoint: iam.{{ api-host }}  # Optional, the default value is iam.{{ api-host }}.

                refresh_period: 1h  # Optional, the default value is 1h.

                request_timeout: 10s  # Optional, the default value is 10s

        # Number of repeat attempts if the request failed.
        # If all the repeat attempts fail, i.e., no status 200 response is received, the message is discarded (for that message, an acknowledgement to the agent is generated).
        # Messages discarded this way are counted in the plugin's DroppedMessages counter. They are also displayed in the MessagesLost and BytesLost general health counters.
        retry_count: inf  # Optional, the default value is max_int (messages will not be discarded).

        # Interval between repeat attempts.
        retry_delay: 1s  # Optional, the default value is 1 second.

        # Request timeout, including all repeat attempts.
        timeout: inf  # Optional, the default value is max_int seconds (messages will not be discarded).

        # Timeout per attempt.
        request_timeout: 1s  # Optional, the default value is 1 second.
```

