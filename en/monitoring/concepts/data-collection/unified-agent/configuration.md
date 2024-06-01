# Configuration

This section describes how to configure {{ unified-agent-full-name }}. Before getting started, we recommend reading through the [basic concepts](../../index.md) used in agent configuration.

## Configuration files {#files}

{{ unified-agent-short-name }} is configured using YAML files with the following sections:

- routes: The definition of [delivery routes](index.md#routes).
- channels: The definition of [named channels](index.md#channels).
- pipes: The definition of [named pipes](index.md#pipes).
- storages: The definition of [storages](index.md#storages).
- main_thread_pool: The settings for the system thread pool.

The configuration file can also contain an `import` directive for [importing other configuration files](#import).

To use your configuration file, pass its path in the command line parameter `--config` at agent startup. For example:
```bash
/usr/bin/unified_agent --config /etc/yandex/unified_agent/config.yml
```
When you use the {{ unified-agent-short-name }} deb package distribution, the basic configuration file `/etc/yandex/unified_agent/config.yml` is automatically set and passed to the `--config` parameter.

We recommend adding your custom configuration to a separate file in the directory `/etc/yandex/unified_agent/conf.d`. Files from that directory are imported from the main configuration file using the `import` directive in alphabetical order. The import mechanism is described in the [{#T}](#import) chapter of this section.

In [{#T}](#examples), you can find a variety of sample configurations as well as a reference example with a complete list of configuration parameters and their descriptions.

## Importing configuration files {#import}
You can import other configuration files using the `import` directive. The value of the directive is a string or array of strings, each string expanded using the [glob](http://man7.org/linux/man-pages/man7/glob.7.html). Files are imported in the order of the `import` directives. Within each directive, they follow the lexicographic file name order.

When importing configuration files, the following rules apply:

- The `status` and `main_thread_pool` sections are pulled from the last imported file.
- The `channels`, `storages`, `pipes`, and `services` sections are presented as a list. New items are added to the end of the list or replaced if the item's `name` is already in the list.
- The `routes` section is a list. New items are added to the end of the list.

The `import` directive can be included in the imported files. To do so, specify only absolute paths in `import`. Relative paths start from the agent's startup directory.

{% note info %}

We don't recommend using `import` in nested files to simplify configuration.

{% endnote %}

If the {{ unified-agent-short-name }} configuration import loops, it terminates with an error. You can find the error details in the agent logs. The maximum recursion depth is 100. If an imported file contains errors, a full path to the original with the erroneous node is output.

## Output and validation of the final configuration {#validation}

To validate the agent settings, run the command:
```bash
unified_agent --config /etc/yandex/unified_agent/config.yml check-config
```

If the validation is successful, the agent outputs to `stdout` the final variant once all imports are complete and returns the null return code.

If the validation fails, the agent outputs configuration errors to `stderr` and returns a non-zero return code:
```bash
unified_agent --config console_to_lb.yml check-config
yaml-cpp: error at line 10, column 3: unrecognized field [statos_port]
```

## Configuration directives {#configuration_sections}

Below are the configuration sections and parameters of different {{ unified-agent-short-name }} components. For optional parameters, the values given in the examples are the default.

### Status section {#status}

This section contains the {{ unified-agent-short-name }} status viewing configuration.

```yaml
status: # optional
  # You can disable status viewing with the "false" value.
  enabled: true # optional, true by default

  # Host for viewing the status, null/empty string/:: — on all interfaces.
  # For security reasons, the status service is only available locally by default.
  host: localhost # optional

  # Port for viewing the status.
  port: 16301 # required
```

### Storages section {#storages_section}
This section contains a list of [storages](index.md#storages).

The storage definition consists of the following elements:

- `name`: The name of the storage that can be referenced from the pipe.
- `plugin`: The [storage's plugin](#storages).
- `config`: The input configuration. Configuration parameters for all storages are listed in [{#T}](#storages).

You can reference a storage from a pipe using the `storage_ref` directive.

The `storage_ref` directive consists of the following elements:

- `name`: The name of the storage defined in `storages`.
- `flow_control`: The settings for the [session creation mechanism](#flow_control).

Sample `storages` section:

```yaml
storages:
- name: main
  plugin: fs
  config:
    directory: ./data/storage/main
    max_partition_size: 500mb
- name: secondary
  plugin: fs
  config:
    directory: ./data/storage/secondary
    max_partition_size: 100mb
```

Example of a pipe that uses a storage:

```yaml
pipe:
  - storage_ref:
      # A storage name.
      name: main # required

      # Configuration for the session infrastructure.
      flow_control:
        new_sessions_rate_limit: null # optional, not set by default
```

### Routes section {#routes}
This section contains a list of [delivery routes](index.md#routes).

Delivery routes consist of the following elements:

- `input`: The [input](index.md#inputs).
- `channel`: The [channel](index.md#channels).

Inputs consist of the following elements:

- `plugin`: The [input](#inputs) plugin.
- `config`: The [input](#inputs) configuration.
- `flow_control`: The configuration of the mechanism for creating input sessions.

Channels consist of the following elements:

- `pipe`: The pipe.
- One of the following elements:
   - `output`: Contains the output configuration.
   - `channel_ref`: The link to a named channel.
   - `case`: A splitter that redirects the input stream to one or more child channels based on a condition.
   - `fanout`: A splitter that unconditionally directs the input stream to all child channels.

An example of the `routes` section:

```yaml
routes:
  - input:
      plugin: someinput
    channel:
      pipe:
        - filter:
            plugin: somefilter
            config: ...
        - filter:
            plugin: somefilter
            config: ...
        - storage:
            storage_ref:
              name: mystorage
      output:
        plugin: someoutput
        config: ...

  - input:
      plugin: someinput
    channel:
      pipe:
        - filter:
            plugin: somefilter
            config: ...
      channel_ref:
        name: mychannel

  - input:
      plugin: someinput
    channel:
      pipe:
        - filter:
            plugin: somefilter
            config: ...
      fanout:
        - channel:
            ...
        - channel:
            ...
        - channel:
            ...
```

An example of the `case` element:

```yaml
- input:
    plugin: console
  channel:
    # The case element directs the input stream to the first child channel that matches the "when" condition.
    # The message is discarded if no matching channel is found for it.
    # This event is added to the health counters (Errors) and pipeline counters (DroppedMessages/DroppedBytes).
    # An ERROR-level entry is added to the agent's logs.
    # Situations like this are abnormal.
    # To avoid them, add the last "catch all channel" element to the case and omit the when filter.
    case:
      # Inside when, you can define the conditions for matching between the message and session metadata, similar to the "match" filter.
      - when:
          message:
            message-key: v1
          session:
            session-key: v2
        channel:
          output:
            plugin: dev_null

      # Any message and session elements can be omitted inside when.
      # The continue property is supported: do not stop searching for a suitable channel if the "when condition" is met.
      # You can send incoming messages to multiple matching channels that way.
      - when:
          message:
            message-key: v1
        channel:
          output:
            plugin: dev_null
        continue: true

      # You may omit the when element, in which case the input stream is sent to the channel unconditionally if a session can be created for it (if none of its nested filters rejected the session creation).
      - channel:
          output:
            plugin: dev_null
```

### Channels section {#channels}
This section contains a list of named [channels](index.md#channels). You can use channels from this section in delivery routes, referring to them by name.

An example of the `channels` section:

```yaml
channels:
  - name: named_channel
    channel:
      # Named channels can reference other named channels.
      channel_ref:
        name: other_named_channel

  - name: other_named_channel
    channel:
      output:
        plugin: dev_null

        # You can add an input ID, output ID, storage ID, and filter ID to any plugin.
        # This ID will replace the plugin_id label in the monitoring system.
        # This ID will also be used to label the plugin's entries in the agent's log.
        id: my_dev_null_output
```

An example of a delivery route that uses a named channel:

```yaml
- input:
    plugin: console
  channel:
    channel_ref:
      name: named_channel
```

### Pipes section {#pipes}
This section contains a list of named [pipes](index.md#pipes). You can use pipes from this section in channels, referring to them by name.

An example of a `pipes` section:

```yaml
pipes:
  - name: named_pipe
    pipe:
      - filter:
          plugin: batch
          config:
              limit:
                bytes: 100kb
      - filter:
            plugin: assign
            config:
              message:
                - _payload: "{_timestamp:%b %d %H:%M:%S} {_payload}"
```

An example of a delivery route that uses a named pipe:

```yaml
- input:
    plugin: console
  channel:
    pipe:
      - pipe_ref:
          name: named_pipe
    output:
      plugin: debug
```

### main_thread_pool section {#main_thread_pool}
This section contains a configuration for execution threads.

Parameter descriptions:

```yaml
main_thread_pool: # optional
  # Number of threads.
  threads: 1 # optional, default value is 1
```

### agent_log section {#agent_log}
This section contains the agent's log settings. You can override the setting using command line parameters.

Parameter descriptions:

```yaml
agent_log: # optional
  # Logging level.
  # Acceptable values: EMERG, ALERT, CRITICAL_INFO, ERROR, WARNING, NOTICE, INFO, DEBUG, RESOURCES.
  priority: NOTICE # optional, the default value is NOTICE

  # Write logs to the specified file.
  file: cerr # optional, the default value is cerr (standard error stream)

  # Limit the log write rate to the specified value.
  # Write attempts exceeding this rate are discarded. The number of bytes discarded this way is reflected in the DroppedBytes counter in the "agent-log" group.
  rate_limit_bytes: null # optional, not set by default
```

### System section {#system}
Miscellaneous system settings.

Parameter descriptions:

```yaml
system: # optional
  # Prevents the agent's executable code from being paged from RAM to the swap area by using the mlock system call.
  # This can help you reduce delays, since there will be no major page faults due to swapping code from the disk.
  lock_executable_in_memory: false # optional, default value is false

  # Set a limit on RAM taken up using the setrlimit system call.
  memory_limit: null # optional, not set by default
```

### flow_control section {#flow_control}
This section contains a configuration for session control. The settings allow you to configure various session limits and their behavior upon reaching the limits.

You can use the `flow_control` section for inputs and storage references (storage_ref).

Parameter descriptions:

```yaml
flow_control: # optional
  # Session buffer settings.
  # The limit can be expressed as a number of bytes or message count.
  # Exceeding any of the limits triggers the logic specified in the action attribute.
  # The message count limit can be helpful when the input receives many small messages, each triggering a large output message.
  inflight:
    # Buffer size in bytes.
    limit: 10mb # optional, default value is 10 MB

    # Buffer size expressed as message count.
    limit_messages: null # optional, not set by default

    # Behavior when the buffer is full:
    #   * backpressure: Pause receiving new messages until the buffer is released.
    #   * drop: Drop new messages if they exceed the buffer.
    action: backpressure # optional, default value is backpressure

  # Limit on how often new sessions can be created. It's expressed as a number of new sessions created per second.
  # If the limit is exceeded, the StartSession method returns TStartSessionResult::Throttled in the Status field.
  # There's no default value for storages.
  # For inputs, the default value is 5.
  new_sessions_rate_limit: 5 # optional, the default value is 5 for inputs, not supported for storage_ref
```

### Inputs {#inputs}

#### agent_metrics input {#agent_metrics_input}

The input collects health metrics for {{ unified-agent-full-name }}.

Parameter descriptions:

```yaml
- input:
    plugin: agent_metrics
    config:
      # Data source polling frequency.
      poll_period: 15s # optional, default value is 15 seconds

      # The namespace to accommodate all metrics.
      # If specified, it will be added as a prefix to every metric name.
      namespace: null # optional, not set by default
```

#### metrics_pull input {#metrics_pull_input}

The input polls the specified URL at preset intervals and parses the response for metrics in the specified format, for example, {{ prometheus-name }}.

Parameter descriptions:

```yaml
  - input:
      plugin: metrics_pull
      config:
        # URL to poll for metrics data.
        url: http://localhost:12345 # required

        # The format for received messages. Only the prometheus value is currently supported.
        format: # required
          # The input messages are in the prometheus format (https://github.com/prometheus/docs/blob/master/content/docs/instrumenting/exposition_formats.md).
          prometheus: {}

        # Data source polling frequency.
        # Start times are aligned to the poll_period grid starting from the Unix epoch.
        poll_period: 15s # optional, default value is 15 seconds

        # The namespace to accommodate all metrics.
        # If specified, it will be added as a prefix followed by a dot to every metric name.
        namespace: null # optional, not set by default

        # Number of repeat attempts if the request failed.
        retry_count: 0 # optional, default value is 0

        # The interval between repeat attempts.
        retry_delay: 1s # optional, default value is 1 second

        # Request timeout, including all repeat attempts.
        timeout: 5s # optional, default value is 5 seconds

        # Headers to add to the request.
        headers: # optional, not set by default
          h1: v1
          h2: v2

        # Names of HTTP response headers to be saved to the message metadata.
        capture_response_headers: [] # optional, not set by default

        # HTTP method to use in the request.
        # Acceptable values: GET, POST.
        http_method: GET # optional, default value is GET
```

#### linux_metrics input {#linux_metrics_input}

An input to collect system usage statistics (CPU, RAM, network, disk) for Linux-compatible operating systems. The input collects metric values from [procfs](https://ru.wikipedia.org/wiki/Procfs) and [sysfs](https://ru.wikipedia.org/wiki/Sysfs).

{{ unified-agent-short-name }} only collects metrics from storage devices mounted as `/dev/..`. For example, there is no support for {{ compute-name }} [file storages](../../../../compute/concepts/filesystem.md).

{% note warning %}

If the agent is running in a Docker container, pass the paths to procfs, sysfs, and disk mount points to the container in order to monitor the host system metrics and secondary disks attached to the host. To do this, use the `docker run` command with the `-v` parameter. For example, if a secondary disk is mounted in the `/data` directory:

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
    # How often statistics are collected.
    poll_period: 15s # optional, default value is 15 seconds

    # The directory where procfs is mounted and counters are taken from.
    # If the agent is running in a Docker container, pass the host /proc inside the container using the -v parameter in order to monitor the host.
    proc_directory: "/proc " # optional, default value is /proc

    # The directory where sysfs is mounted and counters are taken from.
    # If the agent is running in a Docker container, pass the host /sys inside the container using the -v parameter to monitor the host.
    sys_directory: "/sys" # optional, default value is /sys

    # List of resources to collect statistics from.
    # Key: one of the values: cpu, memory, network, storage, io, kernel.
    # Value: level of detail, takes one of basic or advanced.
    resources: # optional
        cpu: advanced # optional, default value is basic

        memory: advanced # optional, default value is basic

        network: advanced # optional, default value is basic

        storage: advanced # optional, default value is basic

        io: advanced # optional, default value is basic

        kernel: advanced # optional, default value is basic
```

### Filters {#filters}

#### assign filter {#assign_filter}

A filter for assigning metadata to a session or message.

The metadata value is generated using a template. Template syntax: `{key:format|default}`. Curly brackets are escaped by `\`: `"\{\}"`.

The `key` value:

- `_timestamp`: Message timestamp.
- `_payload`: Message body.
- `key`: Metadata that has the "key" key.

If the metadata key is not found at the message level (in the `message` section), the key is searched for in the session metadata. If the key is not found at the session level, the default value `({_host|default_host})` is used. If no default value is set, an empty string is used.

You can also use the following macros as `key` values:
- `$host_name`: Local name of the machine.
- `$short_host_name`: Short local name of the machine (in other words, cut at the first dot).
- `$env('name')`: Environment variable with the name `name`.
- `$file('name')`: Contents of the file with the name `name`.

The macro's arguments can be substituted from the metadata.
For example, in the case of `$file(name)`, the file name is taken from the metadata with the `name` key.

The `format` value: The format string [strftime](http://man7.org/linux/man-pages/man3/strftime.3.html). Can only be specified for `_timestamp`.

The `default` value:

- Specifies the default value if there is no metadata with this key or `_payload` is empty.
- Can't be specified for `_timestamp` because `_timestamp` is always present.
- Supported for macros `$env` and `$file`. It is used if the specified file is not found or the environment variable is an empty string.
- An empty string is used by default.

Parameter descriptions:

```yaml
- filter:
    plugin: assign
    config:
        # At least one of the message and session sections must be specified.

        # Values to be assigned to the message metadata.
        # message must contain a list of single-element map functions with the key equal to the metadata name and a value equal to the formatting template.
        # The macros enclosed in curly brackets in the template may contain the metadata keys ({_host}) as well as built-in functions ({$file('test-file')}).
        # If the metadata key is not found at the message level (in the message section), the key is searched for in the session metadata.
        # If the key is not found at the session level, the default value `({_host|default_host})` is used. If no default value is set, an empty string is used.
        # Below are some template examples.
        message: # optional, not set by default
            # Output example: 'Nov 27 21:03:24 test-host test-app:test_payload'.
            # The timestamp uses the strftime format (http://man7.org/linux/man-pages/man3/strftime.3.html).
            # In this example, the value _app test-app: has a colon at the end, which is a typical result of parsing a syslog message.
            - _payload: "{_timestamp:%b %d %H:%M:%S} {_host} {_app}{_payload}"

            # Replace $file with the value from the file named test-file.
            # If the contents of the test-file file is test-content, the output is prefix_test-content_suffix.
            - m1: "prefix_{$file('test-file')}_suffix"

            # Substitute a value from the file whose name is taken from the metadata with the test-file-name key.
            - m2: "prefix_{$file(test-file-name)}_suffix"

            # Substitute the value from the test-env environment variable.
            - m3: "prefix_{$env('test-env')}_suffix"

            # Substitute the value from the environment variable whose name is taken from the metadata with the test-env-name key.
            - m4: "prefix_{$env(test-env-name)}_suffix"

            # Substitute the name of the host where the agent is running.
            - m5: "$host_name"

            # It's similar to $host_name but without the domain (the prefix is cut at the first dot).
            # For example, if $host_name is lbk-dev-02.search.yandex.net, then $short_host_name becomes lbk-dev-02.
            - m6: "$short_host_name"

        # Values to be assigned to the session metadata.
        session: # optional, not set by default
            # Similar to message.
            - m1: v1
            - m2: v2
```

#### convert_metrics filter {#convert_metrics_filter}

A filter for converting metrics between different formats. The format for input messages is taken from the session metadata with the key `_metrics_format` (if it exists) or from the message metadata with the same key (if it exists).

If the format of an incoming message can't be identified (`_metrics_format` isn't specified at the session level or the message level), the incoming message is discarded and the `RejectedMessages` counter for this plugin increases by 1.

Parameter descriptions:

```yaml
- filter:
    plugin: convert_metrics
    config:
        # The output format to convert the incoming set of metrics to.
        # Exactly one of the nested elements must be specified.
        format:  # Required
          # Convert to JSON {{ monitoring-full-name }} (../../../api-ref/MetricsData/write.md)
          json:
              # Whether you need to merge metrics with the same tags.
              # Possible values: default (merging disabled), merge_metrics (merging enabled).
              merging_mode: default # optional, default value is default (merging disabled)

              # Whether to prettify JSON using a human-readable format (with line breaks and indents).
              # Sets the size of indents. If 0, no formatting is needed.
              indentation: 0 # optional, formatting is disabled by default

        # A set of labels to be added to the output set of metrics.
        labels: # optional, not specified by default
            l1: v1
            l2: v2

        # The default time value to be added to the output set of metrics.
        # Two syntax formats for these parameters are supported: absolute and relative.
        # In the absolute format, the time value is expected in the ISO 8601 format.
        # Examples: 2014-03-25 03:59:56.654563, 2012-11-23 11:12:13, 2012-11-23, 1990-03-15T15:10:12.
        # In the relative format, an offset from a preset value must be specified:
        # * now: The current time.
        # * today: The beginning of today.
        # * yesterday: The beginning of yesterday.
        # * tomorrow: The beginning of tomorrow.
        # The offset includes an arbitrary number of time deltas separated by the + or - operators.
        # Possible values for the delta:
        # * m: Minute.
        # * h: Hour.
        # * d: Day.
        # * w: Week.
        # For example, --since yesterday leaves messages for yesterday and today, while --since now-5m --until now-5m+10s leaves messages in the interval of 10 seconds that began five minutes ago.
        # By default, deltas are counted from now. That means you can use -2m instead of now-2m.
        common_time: null # optional, not set by default
```

#### filter_metrics filter {#filter_metrics_filter}

The filter allows you to decrease the set of metrics being transferred based on the label values.

```yaml
- filter:
    plugin: filter_metrics
    config:
        # Condition for metrics to be left. All other metrics are filtered out.
        # You can learn more about the syntax here: https://yandex.cloud/en/docs/monitoring/concepts/querying#selectors
        match: "{name=gauge-*}" # Required
```

#### match filter {#match_filter}

Filtering messages based on metadata: the filter only skips messages that contain all listed metadata.

Parameter descriptions:

```yaml
- filter:
    plugin: match

    config:
        # The session metadata in the key:value format.
        session: # optional
            a: b

        # The message metadata in the key:value format.
        message: # optional
            c: d
            e: f

        # In the above configuration, the filter only passes messages where:
        # * The session metadata includes the key a with the value b.
        # * The message metadata includes the key c with the value d and the key e with the value f (both are required).
        # The metadata may also include any other keys.
```

#### transform_metric_label filter {#transform_metric_label_filter}

The filter helps add new labels to metrics, as well as delete and replace existing labels. A label value can be a string literal or a text expression with other labels. You can use the `match` expression to limit the collection of metrics the transformation is applied to.

Parameter descriptions:
```yaml
- filter:
    plugin: transform_metric_labels

    config:
      # The filter will only apply to those metrics that meet this condition.
      # You can learn more about the syntax here: https://yandex.cloud/en/docs/monitoring/concepts/querying#selectors
      match: "{name=gauge-*}" # Optional parameter which is not specified by default, which means the filter applies to all metrics

      # Metric conversion description in "metric name: expression" format.
      # Label name: label that is being assigned a new value.
      # Expression: text string describing the new value.
      # This string can refer to current label values using the "{my_label}" syntax,
      # including the label being modified at that moment in time. This reference will use its previous value.
      # Transformations take place in a specified order; in the expressions that follow
      # you can reference the output of the previous ones.
      # Expression syntax is similar to that used in the assign filter.
      # Using {my_label|default_value}, you can specify a default value if my_label is not found.
      # To delete a label, use my_label: "-".
      labels:
        - l2: "prefix_{l1}_suffix"                # required
        - l3: "prefix2_{l2}_s_{l1|default_value}" # required
        - l4: "-"                                 # required
```


### Storages {#storages}

#### Fs storage {#fs_storage}

File storage. Messages are saved in partitions. Partitions are the directories that contain the segment files with message data and the files with metadata.

{% note warning %}

We do not recommend using the file storage with the `nobarrier` file system mount option. Data integrity in case of power failure is not guaranteed, so manual intervention might be needed.

{% endnote %}

Parameter descriptions:

```yaml
storages: # optional
  # A storage based on a file system.

  # A storage name. You can use this name to reference the storage from pipes using storage_ref.
  # You can only reference storages once.
- name: main # required
  # Plugin name. For now, only the fs plugin for binary storages in the file system is supported.
  plugin: fs # required

  config:
    # Directory with the storage data.
    # Subdirectories for partitions are created here.
    directory: ./data/storage # required

    # The maximum partition size.
    # By default, the storage has just one partition named default.
    # A new partition is only created if the user explicitly requested this by specifying the partition name in the _partition key of the session metadata.
    # In the core use cases, there is only one partition. This parameter can therefore be considered a limit imposed on the total storage size.
    max_partition_size: 10mb # required

    # The directory that stores auxiliary information for the storage.
    # Default value: .state inside directory.
    state_directory: {directory} / .state # optional, default value is .state inside directory

    # The maximum size of a segment (one file) within a partition.
    # The default value is one-tenth of the partition size.
    max_segment_size: {max_partition_size} / 10 # optional, the default value is one-tenth of max_partition_size

    # Block size for writing.
    # To reduce the overhead for system calls, messages are grouped into a block before calling write.
    # write is called if the block exceeds the specified size.
    block_flush_size: 1mb # optional, the default value is 1 MB

    # The block's lifetime for writing.
    # write will be called if more than the specified time has passed since the first message was received in the block.
    block_flush_period: 10ms # optional, the default value is 10 ms

    # The buffer size for calling syscall read.
    # By default, it's equal to block_flush_size.
    read_buffer_size: {block_flush_size} # optional, equal to block_flush_size by default

    # Time to store the session information.
    # As soon as the incoming session is closed, the storage stops storing information about the session.
    # The mapping sessionid->last_seq_no and the session metadata are deleted.
    # The session is only deleted if all its data is written to the outputs.
    session_retention_time: 1h # optional, the default value is 1h

    # Partition data storage time.
    # The partition is deleted after the specified time if:
    # * All its data is written to outputs and confirmation is received.
    # * There are no active sessions that write data to this partition.
    partition_retention_time: 1h # optional, the default value is 1h

    # Check frequency for session_retention_time and partition_retention_time.
    retention_check_period: 1m # optional, default value is 1m

    # The fsync execution frequency.
    # The more often you run fsync, the less data you need to check on failure recovery, and the faster the agent starts.
    checkpoint_period: 1s # optional, not set by default

    # This parameter describes the conditions for saving data segments after receiving confirmation from the output.
    # When no condition is met, the segments are deleted in order from oldest to newest.
    # An old segment is one not currently being written to.
    #
    # The conditions are checked:
    # * When receiving confirmation from the output.
    # * When receiving new data.
    # * Periodically, based on retention_check_period.
    #
    # The TrailingMessageAgeMs and TrailingSegmentAgeMs counters are supported at the partition level.
    # TrailingMessageAgeMs is determined by the timestamp of the first message of the oldest segment.
    # This counter approximately evaluates (in other words, without accounting for timestamp irregularity) the period of time for which the partition contains data.
    # TrailingSegmentAgeMs is determined in a similar manner based on the segment that follows it.
    # This counter shows when the last segment will be deleted (when the value of the by_age property is reached).
    # The values of both counters are measured in milliseconds.
    # If there is no segment in the partition, both counters equal zero.
    # If there is only one segment in the partition, TrailingSegmentAgeMs is zero.
    #
    # This parameter is not set by default. In other words, the oldest segment is deleted when confirmation for the last message of this segment is received from the output.
    data_retention: # optional
      # The segment is not deleted as there are more recent messages.
      # Whether the messages are up-to-date is determined by the time in the timestamp field of the first message in the penultimate segment.
      # The partition stores data for approximately the specified period.
      by_age: 10d # optional, not set by default

      # The segment is not deleted as long as the partition's data size without the segment's own size remains less than the specified size.
      # That means the partition size will be maintained at a value at or above the one specified.
      # If you specify by_size: max, the data is deleted only when the partition size limit is reached.
      by_size: 500mb # optional, not set by default

    # The logging level to be used when deleting unconfirmed data.
    # The agent's monitoring usually tracks the value of the Errors counter: the total number of events inside the agent logged with the ERROR level.
    # If storage overflow is a possible scenario (for example, the data is written to the agent more intensively than set in the new_sessions_rate_limit parameter of the flow_control section), you can use this parameter to disable alert firing.
    # Acceptable values: EMERG, ALERT, CRITICAL_INFO, ERROR, WARNING, NOTICE, INFO, DEBUG, RESOURCES.
    unacknowledged_eviction_log_priority: ERROR # optional, default value is ERROR
```

### Outputs {#outputs}

#### Debug output {#debug_output}

This is a debug output that outputs incoming messages to a file or console.

Local data cannot be viewed in the storage yet. You can set up data export to a file using this output. You can use the utility `logrotate` to set up log rotation. For the agent to start writing logs to a new file, use the method `reopen_file`. To enable that, you'll need this configuration:

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

#### dev_null output {#dev_null_output}

An empty debug output: disposes of incoming messages.

Contains no parameters.

#### yc_metrics output {#yc_metrics_output}

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
        # If the request was not completed successfully within the specified number of attempts (in other words, the response with status 200 was not received), the message is discarded: confirmation is generated for the agent.
        # Messages discarded this way are counted in the plugin's DroppedMessages counter. They are also displayed in the generic health counters MessagesLost and BytesLost.
        retry_count: inf # optional, default value is max_int (means that messages will not be discarded)

        # The interval between repeat attempts.
        retry_delay: 1s # optional, default value is 1 second

        # Request timeout, including all repeat attempts.
        timeout: inf # optional, default value is max_int seconds (means that messages will not be discarded)

        # Timeout per attempt.
        request_timeout: 1s # optional, default value is 1 second
```



#### yc_logs output {#yc_logs_output}

Output used for sending metrics to {{ cloud-logging-full-name }} via [gRPC](../../../../logging/api-ref/grpc/log_ingestion_service.md).

{% note info %}

The agent doesn't guarantee there will be no duplicate messages in the target system but does its best to avoid them. Duplicates may appear after a stop and subsequent restart.

{% endnote %}

Parameter descriptions:

```yaml
- channel:
    output:
        plugin: yc_logs
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
        # If the request was not completed successfully within the specified number of attempts (in other words, the response with status 200 was not received), the message is discarded: confirmation is generated for the agent
        # Messages discarded this way are counted in the plugin's DroppedMessages counter. They are also displayed in the generic health counters MessagesLost and BytesLost.
        retry_count: inf # optional, default value is max_int (means that messages will not be discarded)

        # The interval between repeat attempts.
        retry_delay: 1s # optional, default value is 1 second

        # Request timeout, including all repeat attempts.
        timeout: inf # optional, default value is max_int seconds (means that messages will not be discarded)

        # Timeout per attempt.
        request_timeout: 1s # optional, default value is 1 second
```



## Examples {#examples}

Sample configurations are given in [{#T}](../../../operations/index.md#working-with-metrics).
