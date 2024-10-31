# Delivering metrics from HAProxy and other third-party applications

{{ unified-agent-full-name }} supports metric collection in the {{ prometheus-name }} format and metric conversion to the {{ monitoring-full-name }} format. {{ unified-agent-short-name }} enables you to pull metrics from applications that deliver them in the {{ prometheus-name }} format.

To deliver metrics from third-party applications to {{ monitoring-full-name }}, use the [metrics_pull input](../../concepts/data-collection/unified-agent/configuration.md#metrics_pull_input) that regularly polls a third-party application directly (if the application supports metrics in {{ prometheus-name }} format) or polls a special export application that integrates with {{ prometheus-name }}.

As an example, let's consider the delivery of [HAProxy](https://www.haproxy.org) metrics to {{ monitoring-full-name }}.

## Example of delivering HAProxy metrics {#example}

This procedure can also be used to send metrics from any third-party applications [integrated with Prometheus](https://prometheus.io/docs/instrumenting/exporters/).

1. Install [HAProxy](https://www.haproxy.org).

   1. To install HAProxy, run this command:

      ```bash
      sudo apt install haproxy
      ```

   1. To implement {{ prometheus-name }} integration, configure the exporter. To do this, add a section named `frontend` to the `haproxy.cfg` configuration file:

      ```bash
      frontend stats
          bind *:8404
          http-request use-service prometheus-exporter if { path /metrics }
          stats enable
          stats uri /stats
          stats refresh 10s
      ```

   1. Restart the service:

      ```
      sudo service haproxy restart
      ```

   1. Make sure the exporter is running and exposes metrics. To do this, run the `curl http://localhost:8404/metrics` command. Command output example:

      ```bash
      # HELP haproxy_process_nbthread Number of started threads (global.nbthread)
      # TYPE haproxy_process_nbthread gauge
      haproxy_process_nbthread 2
      # HELP haproxy_process_nbproc Number of started worker processes (historical, always 1)
      # TYPE haproxy_process_nbproc gauge
      haproxy_process_nbproc 1
      # HELP haproxy_process_relative_process_id Relative worker process number (1)
      # TYPE haproxy_process_relative_process_id gauge
      haproxy_process_relative_process_id 1
      # HELP haproxy_process_uptime_seconds How long ago this worker process was started (seconds)
      # TYPE haproxy_process_uptime_seconds gauge
      haproxy_process_uptime_seconds 5
      # HELP haproxy_process_pool_failures_total Number of failed pool allocations since this worker was started
      # TYPE haproxy_process_pool_failures_total counter
      haproxy_process_pool_failures_total 0
      ```

1. Set up a service account under which metrics will be written to {{ monitoring-full-name }}.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder you want to write metrics to and [assign it](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

   1. [Link your service account](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to a virtual machine with {{ unified-agent-short-name }} installed.

1. Install and configure {{ unified-agent-full-name }}:

   1. Create a file named `config.yml` in your home folder:

       ```yaml
        status:
          port: "16241"

        storages:
          - name: main
            plugin: fs
            config:
              directory: /var/lib/yandex/unified_agent/main
              max_partition_size: 100mb
              max_segment_size: 10mb

        channels:
          - name: cloud_monitoring
            channel:
              pipe:
                - storage_ref:
                    name: main
              output:
                plugin: yc_metrics
                config:
                  folder_id: "$FOLDER_ID"
                  iam:
                    cloud_meta: {}

        routes:
          - input:
              plugin: metrics_pull
              config:
                url: http://localhost:8404/metrics
                format:
                  prometheus: {}
                namespace: haproxy
            channel:
              channel_ref:
                name: cloud_monitoring

          - input:
              plugin: agent_metrics
              config:
                namespace: ua
            channel:
              pipe:
                - filter:
                    plugin: filter_metrics
                    config:
                      match: "{scope=health}"
              channel_ref:
                name: cloud_monitoring

        import:
          - /etc/yandex/unified_agent/conf.d/*.yml
       ```

       Where `$FOLDER_ID` is the ID of the folder you want to write metrics to.

   1. Install {{ unified-agent-short-name }} on your VM by running the following command in the home folder:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs81qpemb4******** \
      {{ registry }}/yc/unified-agent
      ```

       You can find more ways to install the agent in [{#T}](../../concepts/data-collection/unified-agent/installation.md).


1. Make sure the metrics are delivered to {{ monitoring-full-name }}:

    1. On the {{ monitoring-full-name }} [home page]({{ link-monitoring }}), go to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

    1. In the query block, select:
      - Folder where metrics are collected.
      - `service=custom` label value.
      - Metric name starting with the `haproxy` prefix.

#### What's next {#what-is-next}

- Read about [{{ unified-agent-short-name }} concepts](../../concepts/data-collection/unified-agent/index.md).
- [Learn more about configuring {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md).
- [Read the {{ unified-agent-short-name }} operating guidelines](../../concepts/data-collection/unified-agent/best-practices.md).
