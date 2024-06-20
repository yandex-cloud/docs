# Inputs

You can specify an input in the `routes`:`input` section. The common input description format is:

```yaml
- input:
    plugin: ... # plugin name
    id: ... id: ... # (recommended) input ID, which is used in metrics and logs
    flow_control: # session infrastructure settings
    ...
```

See also the [session infrastructure settings](services.md#flow_control).

## agent_metrics input {#agent_metrics_input}

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

## metrics_pull input {#metrics_pull_input}

The input polls the specified URL at the preset intervals to collect metrics in {{ prometheus-name }} format.

Parameter descriptions:

```yaml
  - input:
      plugin: metrics_pull
      config:
        # URL for collecting metrics.
        url: http://localhost:12345 # required

        # Format for received messages. Only the prometheus value is currently supported.
        format: # required
          # The input messages are in the prometheus format (https://github.com/prometheus/docs/blob/master/content/docs/instrumenting/exposition_formats.md).
          prometheus: {}

        # Data source polling frequency.
        # Start times are aligned to the poll_period grid starting from the Unix epoch.
        poll_period: 15s # optional, default value is 15 seconds

        # Namespace to accommodate all metrics.
        # If specified, it will be added as a prefix followed by a dot to every metric name.
        namespace: null # optional, not specified by default

        # Number of repeated attempts if the request failed.
        retry_count: 0 # optional, default value is 0

        # Interval between repeat attempts.
        retry_delay: 1s # optional, the default value is 1 second

        # Request timeout, including all repeated attempts.
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

## linux_metrics input {#linux_metrics_input}

An input to collect system usage statistics (CPU, RAM, network, disk) for Linux-compatible operating systems. The input collects metric values from [procfs](https://ru.wikipedia.org/wiki/Procfs) and [sysfs](https://ru.wikipedia.org/wiki/Sysfs).

{{ unified-agent-short-name }} only collects metrics from storage devices mounted as `/dev/..`. For example, there is no support for {{ compute-name }} [file storages](../../../../compute/concepts/filesystem.md).

{% note warning %}

If the agent is running in a Docker container, deliver the paths to procfs, sysfs, and disk mount points into the container in order to monitor the host's system metrics and secondary disks attached to the host. To do this, use the `docker run` command with the `-v` parameter. For example, if a secondary disk is mounted in the `/data` directory:

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
    # If the agent is running in a Docker container, deliver the host's /proc into the container using the -v parameter in order to monitor the host.
    proc_directory: "/proc " # optional, default value is /proc

    # The directory where sysfs is mounted and counters are taken from.
    # If the agent is running in a Docker container, deliver the host's /sys into the container using the -v parameter to monitor the host.
    sys_directory: "/sys" # optional, default value is /sys

    # List of resources to collect statistics from.
    # Key: One of the values: cpu, memory, network, storage, io, kernel.
    # Value: Level of detail, takes one of the values: basic, advanced.
    resources: # optional
        cpu: advanced # optional, the default value is basic

        memory: advanced # optional, the default value is basic

        network: advanced # optional, the default value is basic

        storage: advanced  # optional, the default value is basic

        io: advanced  # optional, the default value is basic

        kernel: advanced  # optional, the default value is basic
    ```
