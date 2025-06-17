# Inputs

You can specify an input in the `routes`:`input` section. The common input description format is:

```yaml
- input:
    plugin: ... # plugin name
    id: ... # (recommended) ID of the input, used in metrics and logs
    flow_control: # session infrastructure settings
    ...
```

See also [Session infrastructure settings](services.md#flow_control).

## agent_metrics input {#agent_metrics_input}

The input collects health metrics for {{ unified-agent-full-name }}.

Parameter descriptions:

```yaml
- input:
    plugin: agent_metrics
    config:
      # Data source polling frequency.
      poll_period: 15s  # optional, the default value is 15 seconds

      # Namespace to accommodate metrics.
      # If specified, it will be added as a prefix to every metric name.
      namespace: null  # optional, not set by default
```

## metrics_pull input {#metrics_pull_input}

The input polls the specified URL at the preset intervals to collect metrics in {{ prometheus-name }} format.

Parameter descriptions:

```yaml
  - input:
      plugin: metrics_pull
      config:
        # Metric collection URL.
        url: http://localhost:12345  # Required.

        # Format of received messages. Only the prometheus value is currently supported.
        format:  # Required.
          # Incoming messages are in the prometheus format (https://github.com/prometheus/docs/blob/master/content/docs/instrumenting/exposition_formats.md).
          prometheus: {}

        # Data source polling frequency.
        # Start times are aligned to the grid of the poll_period size starting from the Unix epoch.
        poll_period: 15s  # optional, the default value is 15 seconds

        # Namespace to accommodate metrics.
        # If specified, it will be added as a prefix followed by a dot to every metric name.
        namespace: null  # optional, not set by default

        # Number of repeat attempts if the request failed.
        retry_count: 0  # optional, the default value is 0

        # Interval between repeat attempts.
        retry_delay: 1s  # optional, the default value is 1 second

        # Request timeout, including all repeat attempts.
        timeout: 5s  # optional, the default value is 5 seconds

        # Headers to add to the request.
        headers:  # optional, not set by default
          h1: v1
          h2: v2

        # Names of HTTP response headers to be saved to the message metadata.
        capture_response_headers: []  # optional, not set by default

        # HTTP method to use in the request.
        # The possible values are: GET, POST.
        http_method: GET  # optional, the default value is GET

        # Section for setting up {{ prometheus-name }} labels
        prometheus_config:  # optional, not set by default
          # Sets a `job` label value for labels being collected.
          job_name: my_job  # optional, not set by default
          # An `instance` label is generated automatically based on the URL.

    # Description of the output channel for metric delivery to {{ monitoring-name }}.
    # Use it together with prometheus_config.
    channel:
      output:
        plugin: metrics
        config:  # URL to send metrics to.
          url: https://{{ api-host-monitoring-1 }}/prometheus/workspaces/workspace_id/api/v1/write
          # Request authorization parameters
          oauth:
            secret:
              file: file_token
```

## linux_metrics input {#linux_metrics_input}

An input to collect system usage statistics (CPU, RAM, network, disk) for Linux-compatible operating systems. The input collects metric values from [procfs](https://ru.wikipedia.org/wiki/Procfs) and [sysfs](https://ru.wikipedia.org/wiki/Sysfs).

{{ unified-agent-short-name }} collects metrics only from storage devices mounted as `/dev/..`. For example, there is no support for {{ compute-name }} [file storages](../../../../compute/concepts/filesystem.md).

{% note warning %}

If the agent is running in a Docker container, deliver the paths to procfs, sysfs, and disk mount points into the container in order to monitor the host's system metrics and secondary disks attached to the host. To do this, use the `docker run` command with the `-v` parameter. For example, if a secondary disk is mounted in the `/data` folder:

```bash
  docker run \
    -p 16241:16241 -it --detach --uts=host \
    --name=ua \
    -v /proc:/ua_proc \
    -v /data:/data \
    -e PROC_DIRECTORY=/ua_proc \
    -e FOLDER_ID=a1bs81qpemb4******** \
    {{ registry }}/yc/unified-agent
```

{% endnote %}

Parameter descriptions:

```yaml
- input:
    plugin: linux_metrics
    config:
    # Statistics collection frequency.
    poll_period: 15s  # optional, the default value is 15 seconds

    # Directory where procfs is mounted and counters will be taken from.
    # If the agent is running in a Docker container, provide the host's /proc into the container using the -v parameter in order to monitor the host.
    proc_directory: "/proc"  # optional, the default value is "/proc"

    # Directory where sysfs is mounted and counters will be taken from.
    # If the agent is running in a Docker container, provide the host's /sys into the container using the -v parameter in order to monitor the host.
    sys_directory: "/sys"  # optional, the default value is “/sys"

    # List of resources to collect statistics from.
    # Key: One out of the following: `cpu`, `memory`, `network`, `storage`, `io`, `kernel`.
    # Value: Level of detail, one out of the following: `basic`, `advanced`.
    resources:  # Optional.
        cpu: advanced  # optional, the default value is `basic`

        memory: advanced  # optional, the default value is `basic`

        network: advanced  # optional, the default value is `basic`

        storage: advanced  # optional, the default value is `basic`

        io: advanced  # optional, the default value is `basic`

        kernel: advanced  # optional, the default value is `basic`

        # Section for setting up {{ prometheus-name }} labels
        prometheus_config:  # optional, not set by default
          # Sets a `job` label value for labels being collected.
          job_name: my_job  # optional, not set by default
          # An `instance` label is generated automatically based on the URL.

    # Description of the output channel for metric delivery to {{ monitoring-name }}.
    # Use it together with prometheus_config.
    channel:
      output:
        plugin: metrics
        config:  # URL to send metrics to.
          url: https://{{ api-host-monitoring-1 }}/prometheus/workspaces/workspace_id/api/v1/write
          # Request authorization parameters
          oauth:
            secret:
              file: file_token
```

## file_input {#file_input}

This input reads data from text files and `.zst` archives. Your OS must support the `inotify` subsystem in the kernel and file system.

Rules for working with files:

* File external rotation based on the "move (rename) – create new file" scheme is supported. In `multiline` mode, lines with `multiline_start_prefix` will be considered the beginning of a multiline. All subsequent lines not containing this prefix are joined to the multiline.

* You can name a specific file or mask with the `multi_file` parameter as the data source.
  
  The `filename` key (file name without path) is added to the session metadata. To write the full path to the file into the metadata, use the `multi_add_full_path_to_meta` parameter.

* With the file for data writing, you can perform the operations of creating a file, writing new data to the end of the file, and rotation.
* Rotation implies moving a file; the file's location in the structure (inode) remains the same.
* The rotated file must remain unaltered for a certain period of time.

When working with archives:

* Archive format is detected automatically by the `.zst` extension or can be explicitly specified in the `file_format` parameter.
* We recommend breaking the archive into frames.
* The `read_only_newlines` parameter is ignored because it is not supported when working with an archive.
* To avoid CPU overconsumption and slowing down, we recommend enabling the `keep_open_file` parameter. Alternatively, you can set the `max_lines_in_record` parameter to a value commensurate with the size of each frame.

When working with files, information will be logged:

* If the `IN_Q_OVERFLOW` event is detected while reading events.
* {{ unified-agent-short-name }} stopping when deleting, moving, or unmounting folders containing the log file and rotated files.

Parameter descriptions:

```yaml
    plugin: file_input
        config:

          # Path to the log file.
          path: /path_to_file # required

          # Path to the folder the files are moved to during rotation.
          out_directory: "" # optional, by default it is the reference file folder (empty string)

          # Path to the folder where the auxiliary file of the current state (reading position, file name, inode, etc.) will be created.
          state_directory: /path_to_state # required

          # Skip existing lines on the first start.
          read_only_new_lines: false # optional, the default value is false

          # Maximum number of lines to be read simultaneously  
          max_lines_in_record: 100 # optional, the default value is 100

          # Maximum line size.
          # When reading, all subsequent characters will be ignored up to the line break character.
          max_bytes_in_line: 1kb # optional, the default value is 1kb

          # Minimum data block size for reading from the file.
          # If no data has been read for 100 ms due to this limitation, a read will be performed. 
          # The parameter cannot be used when reading from a rotated file.
          min_bytes_read: 1Mb # optional, the default value is 1kb

          # Line break character.
          line_delimiter: "\n" # optional, the default value is "\n"

          # Keeping the log file always open. Otherwise, the file opens only when read and the required reading position is set
          keep_open_file: false # optional, the default value is false

          # Log file format. The possible values are text, zstd, and auto.
          # If set to auto, the file format will be determined by its extension.
          file_format: auto # optional, the default value is auto

          # Maximum frequency for resetting the internal buffer with dearchived data (in milliseconds).
          # Small values result in efficient use of memory, but increase the load on the CPU.
          archive_shrink_period_ms: 1000 # optional, the default value is 1,000 (one second)

          # Treating the path parameter as a search mask for the files that need processing.
          multi_file: false # optional, the default value is false

          # How often to search for new files by mask in multi_file mode. 
          discovery_period_ms: 1000 # optional, the default value is 1,000 (one second)

          # Adding full file path to the session metadata. If false, only the file name is added.
          multi_add_full_path_to_meta: false # optional, the default value is false

          # Determines whether to calculate metrics for each input file in addition to aggregated metrics.
          per_file_metrics: false # optional, the default value is false

          # Processing multiline messages.
          multiline:

            # Enables multiline message processing.
            read_multiline: false # optional, the default value is false

            # Maximum number of lines in multiline messages.
            max_lines_in_multiline: # optional, the default value is 100

            # Regular expression that determines the beginning of a multiline message.
            # All subsequent lines not matching the regular expression will be joined to the current message.
            # The default value matches the beginning of the line in "2022-07-01 16:50:16,037 WARN" format.
            multiline_start_prefix: "^(\\d\\d\\d\\d-\\d\\d-\\d\\d)\\s*(\\d\\d:\\d\\d:\\d\\d,\\d\\d\\d)\\s*(\\w*)" # Optional.

            # To read log files, you can specify the group number according to the importance level.
            # Not used if set to a value higher than the number of groups in the regular expression.
            # Adding logging level to the message metadata.
            # It can be subsequently considered during message processing and its delivery to the agent’s output, e.g., by the yc_logs output.
            log_priority_group: 3 # optional, the default value is 3

            # Mapping the logging levels with values from the regular expression group.
            priority_resources: "RESOURCES"           # optional, the default value is "RESOURCES"
            priority_debug: "DEBUG"                   # optional, the default value is "DEBUG"
            priority_info: "INFO"                     # optional, the default value is "INFO"
            priority_notice: "NOTICE"                 # optional, the default value is "NOTICE"
            priority_warning: "WARN"                  # optional, the default value is "WARN"
            priority_error: "ERROR"                   # optional, the default value is "ERROR"
            priority_critical_info: "CRITICAL_INFO"   # optional, the default value is "CRITICAL_INFO"
            priority_alert: "ALERT"                   # optional, the default value is "ALERT"
            priority_emerg: "EMERG"                   # optional, the default value is "EMERG"
```

## HTTP input { #http_input }

HTTP input for sending logs to Unified Agent. Logs are sent in the body of an HTTP request to the specified address. The input supports configuring the server host and port, the path for the handler, capturing request headers, and adding session metadata.

Parameter descriptions:

```yaml
- input:
    plugin: http
    config:
      # Host to run the HTTP server on.
      # By default, the HTTP server runs on all network interfaces.
      host: null  # optional, the default value is null

      # Port to run the HTTP server on.
      port: 22132  # Required.

      # Path the handler will be registered at.
      path: '/write'  # optional, the default value is '/write'

      # Names of HTTP request headers you need to save to the message metadata.
      capture_request_headers: []  # optional, not set by default

      # Set of Unified Agent session metadata in "key:value" format.
      # For each endpoint (from the _endpoints_ parameter below) a separate session is created.
      session_meta: # optional, not set by default
        k: v

      # Allows you to define multiple connection points with different parameters on one HTTP port.
      # You can specify any configuration elements except host, port, and endpoints.
      # If _endpoints_ is specified, the default connection point (/write) is not used.
      # In this mode, you can only specify the host, port, and endpoints elements in the configuration.
      endpoints:  # optional, the default value is []
        - path: '/my_path'  # Required.
          # Names of HTTP request headers you need to save to the message metadata.
          capture_request_headers: [ ]  # optional, not set by default
```