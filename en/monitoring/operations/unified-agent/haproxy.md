# Delivering metrics from HAProxy and other third-party applications

{{unified-agent-full-name}} supports metric collection in the {{ prometheus-name }} format and metric conversion to the {{ monitoring-full-name }} format. Using {{unified-agent-short-name}} lets you pull metrics from applications that deliver them in the {{ prometheus-name }} format.

To deliver metrics from third-party applications to {{ monitoring-full-name }}, use the [metrics_pull input](../../concepts/data-collection/unified-agent/configuration.md#metrics_pull_input) that regularly polls a third-party application directly (if the application supports metrics in {{ prometheus-name }} format) or polls a special export application that integrates with {{ prometheus-name }}.

As an example, let's discuss delivery to {{ monitoring-full-name }} of [HAProxy](https://www.haproxy.org) metrics.

## Example of delivering HAProxy metrics {#example}

This procedure can also be used to send metrics from any third-party applications [integrated with Prometheus](https://prometheus.io/docs/instrumenting/exporters/).

1. Install [HAProxy](https://www.haproxy.org) and [HAProxy Exporter for Prometheus](https://github.com/prometheus/haproxy_exporter).

   1. To install HAProxy and HAProxy Exporter for Prometheus, run the following command:

      ```bash
      sudo apt install haproxy prometheus-haproxy-exporter
      ```

   1. Make sure the exporter is running and exposes metrics. To do so, run `curl http://localhost:9101/metrics`. Sample command output:

      ```bash
      curl http://localhost:9101/metrics
      # HELP go_gc_duration_seconds A summary of the GC invocation durations.
      # TYPE go_gc_duration_seconds summary
      go_gc_duration_seconds{quantile="0"} 0
      go_gc_duration_seconds{quantile="0.25"} 0
      go_gc_duration_seconds{quantile="0.5"} 0
      go_gc_duration_seconds{quantile="0.75"} 0
      go_gc_duration_seconds{quantile="1"} 0
      go_gc_duration_seconds_sum 0
      go_gc_duration_seconds_count 0
      # HELP go_goroutines Number of goroutines that currently exist.
      # TYPE go_goroutines gauge
      go_goroutines 6
      # HELP go_info Information about the Go environment.
      # TYPE go_info gauge
      go_info{version="go1.10.4"} 1
      ```

1. Set up a service account from which metrics will be written to {{ monitoring-full-name }}.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder you want to write metrics to and [assign it](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

   1. [Link your service account](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to a virtual machine with {{unified-agent-short-name}} installed.

1. Install and configure {{unified-agent-full-name}}.

   1. Create a file named **config.yml** in your home folder:

      **config.yml:**
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
             url: http://localhost:9101/metrics
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

      Where `$FOLDER_ID` is the ID of the folder to write metrics to.

   1. Install {{unified-agent-short-name}} on your VM by running the following command in the home folder:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      {{ registry }}/yc/unified-agent
      ```

      You can find more ways to install the agent in [{#T}](../../concepts/data-collection/unified-agent/installation.md).


1. Make sure the metrics are delivered to {{ monitoring-full-name }}.

   1. On the [home page]({{ link-monitoring }}) {{ monitoring-full-name }}, go to **Metric Explorer**.

   1. In the query block, select:
   - The folder where metrics are collected.
   - The label value `service=custom`.
   - The metric name starting with the `haproxy` prefix.

#### What's next {#what-is-next}

- [Read about {{ unified-agent-short-name }} concepts](../../concepts/data-collection/unified-agent/index.md)
- [Learn more about configuring {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Read the {{ unified-agent-short-name }} operating instructions](../../concepts/data-collection/unified-agent/best-practices.md)
