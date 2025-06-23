# Outputs

You can describe an output in the `routes` section within the `channel`:`output` element. Alternatively, you can do this in the named channel section, `channels`.

The common output description format is:

```yaml
- output:
    plugin: ... # Plugin name
    id: ... # (Recommended) Output ID, which is used in metrics and agent logs.
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

An output used for writing metrics in the {{ monitoring-full-name }} API.

Parameter descriptions:

```yaml
- channel:
    output:
        plugin: yc_metrics
        config:
        # URL to send metrics to.
        url: https://monitoring.{{ api-host }}/monitoring/v2/data/write  # Optional, the default value is https://monitoring.{{ api-host }}/monitoring/v2/data/write

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

                request_timeout: 10s  # Optional, the default value is 10s.

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


## yc_logs output {#yc_logs_output}

Output used for sending logs to [{{ cloud-logging-full-name }}](../../../../logging/) via [gRPC](../../../../logging/api-ref/grpc/LogIngestion/index.md).

{% note info %}

{{ unified-agent-short-name }} removes duplicate messages in the target system, but does not ensure there will be no duplicates at all. Duplicates may appear after a stop and subsequent restart.

{% endnote %}

Parameter descriptions:

```yml

- channel:
    output:
      plugin: yc_logs
      config:
        # It is optional. The URL to send logs to.
        url: "{{ logging-endpoint-ingester }}:443"

        # It is optional. Use an SSL connection.
        use_ssl: null # The directive disables SSL, by default SSL is enabled.
          # Optionally, you can explicitly specify a list of server root certificates
          # as a file path in PEM format.
          # The contents of the file are provided to the pem_root_certs parameter.
          root_certs_file: null  # Optional, not set by default.

        # Target log group settings.
        # One of the following elements must be specified: message_log_group_id, message_folder_id, log_group_id, or folder_id.
        # The value can be set at two levels:
        # 1) At the message level; you need to use the !expr syntax for message_log_group_id, and message_folder_id:
        #    message_log_group_id: !expr "{message_my_log_group}"
        #    The log_group_id name will be taken from the message metadata with the 'message_my_log_group' key.
        # 2) At the session level; you need to use the !expr syntax for log_group_id, and folder_id:
        #    log_group_id: !expr "{my_log_group}"
        #    The log_group_id name will be taken from the session metadata with the 'my_log_group' key.
        # Log group selection priority:
        # message_log_group_id > message_folder_id > log_group_id > folder_id
        # First the message metadata is searched for a log group (if the parameter is specified).
        # Next the message metadata is searched for a folder, and the session metadata is searched for a log group.
        # Then the session metadata is searched for a folder. The one found first will be selected.
        log_group_id: "b1ge2vt0gml6********"  # Optional, not set by default.

        folder_id: "b1ge2vt0gml6********"  # Not set by default; if specified, the default log group will be used.

        message_log_group_id: "b1ge2vt0gml6********" # Optional, not set by default

        message_folder_id: "b1ge2vt0gml6********"  # Not set by default; if specified, the default log group will be used.

        # Limit on the number of unique log groups to send logs to at the same time within a single session.
        # If a message arrives with a new unique log group to which no logs are being sent at the moment
        # and the buffer limit is reached, such message will be discarded.
        buffer_count_limit: 50 # Optional, the default value is 50.

        # Batching settings:
        batch:
          # Limit on the size of the result.
          # A new message is generated if the size of received ones reaches the limit.
          limit: # Optional
            # The limit can be specified in message units or bytes.
            # If both are specified, the first one reached will apply.

            # Number of incoming messages.
            count: 100  # Optional, the default value is 100. Possible values: [1-100].

            # Size of incoming messages in bytes.
            # It only factors in the size of the message body.
            bytes: null  # Optional, not set by default.

          # Waiting time limit.
          # A new message is generated if the waiting time has reached the limit since receipt.
          # It is generated if more time has passed since the first batch message was received.
          flush_period: 1s  # Optional, the default value is 1s.

        # Request timeout per attempt.
        grpc_call_timeout: 3s  # Optional, the default value is 3s.

        # Number of repeat attempts if the request failed.
        # If the request was not completed successfully during the specified time period,
        # i.e., the status 200 response was not received,
        # the message is discarded, i.e., an ack to the agent is generated for that message.
        # Messages discarded this way are counted in the plugin's DroppedMessages counter.
        # They are also displayed in the MessagesLost and BytesLost general health counters.
        retry_count: inf  # Optional, the default value is max_int (messages will not be discarded).

        # If the request fails as many times as set in retry_count, retry attempts
        # will be resumed with an exponentially increasing delay.
        # The parameter sets the minimum delay value.
        backoff_min_delay: 1s  # Optional, the default value is 1 second.

        # If the request fails as many times as set in retry_count, retry attempts
        # will be resumed with an exponentially increasing delay.
        # The parameter sets the maximum delay value.
        backoff_max_delay: 1m  # Optional, the default value is 1 minute.

        # Quota for message write rate (messages per second).
        message_quota: 1000

        # IAM authentication settings.
        iam:  # Optional, not set by default.
          # Either the cloud_meta or jwt element must be specified.

          # If specified, the IAM token is taken from the metadata service.
          cloud_meta:  # Optional, not set by default.
            url:  # Optional

            refresh_period: 1h  # Optional, the default value is 1h.

            request_timeout: 3s  # Optional, the default value is 10s.

          # If specified, a JWT token is exchanged for an IAM token.
          jwt:  # Optional, not set by default.
            # Name of the file containing JWT parameters in the format returned by the `yc iam key create` command.
            file: "jwt_params.json"  # Required

            endpoint: iam.api.cloud.yandex.net  # Optional, the default value is iam.api.cloud.yandex.net.

            refresh_period: 1h  # Optional, the default value is 1h.

            request_timeout: 10s  # Optional, the default value is 10s.

            use_private_api: false # Optional, false by default. If set to true, you must explicitly set the endpoint.

        # List of exported message metadata. Metadata with keys from this list will be sent to
        # Yandex Cloud Logging as json_payload.
        # List of strings with metadata keys.
        export_message_meta_keys:  # Optional, not set by default.
          - "_app"
          - "_random"

        # Usage mode for export_message_meta_keys: black or white list (​​white or black values).
        # In black list mode, all message metadata is exported, except for service metadata and that specified in export_message_meta_keys.
        message_meta_keys_list_mode: white # Optional, white by default.

        # Message body parsing settings.
        # If the message body is a valid JSON and a new payload is identified in it, then:
        #   1. The message body will be replaced with that payload.
        #   2. If special fields (timestamp, priority) are detected and parsed successfully, they will replace the respective message fields.
        #   3. All other fields will be transferred to json_payload.
        parse_json: # Optional
          # Rule specifying the source for a new message body.
          payload: # Required
            # List of first level keys.
            # The value matching the first key will be selected.
            keys: ["msg", "message"]

          # Keys in JSON matching the message time.
          # If there are no keys in JSON, or value parsing fails, the message receipt time will be used.
          # Acceptable values:
          # - unix timestamp (in seconds or adjusted unix_timestamp_format with an optional fractional part).
          # - ISO 8601
          # - RFC 822
          # - log4j {"epochSecond":123,"nanoOfSecond":456}
          timestamp: # Optional
            keys: ["ts", "timestamp", "instant"]

          # Timestamp measurement units: seconds, milliseconds, microseconds.
          unix_timestamp_format: seconds # Optional

          # Keys in JSON matching the priority.
          # If there are no keys in JSON, or value parsing fails, the value from meta information will be used.
          # Acceptable values: TRACE, DEBUG, INFO, WARN, ERROR, or FATAL (case insensitive).
          priority: # Optional
            keys: ["level"]

        # Parameters for LogEntryResource https://cloud.yandex.ru/docs/logging/api-ref/grpc/log_ingestion_service#LogEntryResource
        resource_id: some_id # Optional, not set by default.
        resource_type: some_type # Optional, not set by default.
        stream_name: some_name # Optional, not set by default.

```
