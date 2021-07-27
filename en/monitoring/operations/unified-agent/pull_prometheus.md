---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Delivering custom application metrics

{{unified-agent-full-name}} builds metrics in the {{ prometheus-name }} format and converts them to the {{ monitoring-full-name }} format. You can use {{unified-agent-short-name}} to build metrics for any apps that provide metrics in the {{ prometheus-name }} format.

To deliver custom application metrics to {{ monitoring-full-name }}, the [metrics_pull input](../../concepts/data-collection/unified-agent/configuration.md#metrics_pull_input) is used: it polls the application over HTTP periodically, expecting metrics in the {{ prometheus-name }} format.

As an example, let's take metrics delivery for a test Python app.

## Example of delivery of custom application metrics { #example }

You can also use this method to deliver metrics for any custom application that use the [Prometheus client libraries](https://prometheus.io/docs/instrumenting/clientlibs/).

1. Run a test Python application that provides metrics in the {{ prometheus-name }} format.

   1. To install the [prometheus_client](https://github.com/prometheus/client_python) Python library, run the following commands:

       ```bash
       sudo apt install python3-pip
       pip3 install prometheus_client
       ```

   1. To create a test Python application, write the following code to the **example.py** file:

       **example.py:**
       ```python
       from prometheus_client import start_http_server, Summary
       import random
       import time

       # Create a metric to track the number of requests and their execution time.
       REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

       # Decorate the request processing function by the metric.
       @REQUEST_TIME.time()
       _defprocess_request(t):
           """A dummy function that takes some time."""
           time.sleep(t)

       if __name__ == '__main__':
           # Run an HTTP server so that the application can provide metrics.
           start_http_server(8000)
           # Generate random requests.
           while True:
               process_request(random.random())
       ```

   1. To start the test Python application, run the following command:

       ```bash
       python3 example.py
       ```

    1. Make sure that the application provides metrics by running the command `curl http://localhost:8000`. Example of command execution:

        ```bash
        $ curl http://localhost:8000
        # HELP python_gc_objects_collected_total Objects collected during gc
        # TYPE python_gc_objects_collected_total counter
        python_gc_objects_collected_total{generation="0"} 362.0
        python_gc_objects_collected_total{generation="1"} 0.0
        python_gc_objects_collected_total{generation="2"} 0.0
        # HELP python_gc_objects_uncollectable_total Uncollectable object found during GC
        # TYPE python_gc_objects_uncollectable_total counter
        ...
        ```

1. Set up a service account on behalf of which metrics will be written to {{ monitoring-full-name }}.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder where the metrics will be written and [assign it the `{{ roles-monitoring-editor }}` role](../../../iam/operations/sa/assign-role-for-sa.md).

   1. [Link the service account](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to a virtual machine with {{unified-agent-short-name}} installed.

1. Install and configure {{unified-agent-full-name}}.

   1. Install {{unified-agent-short-name}} on your VM by running the following command in the home folder:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v config.yml:/etc/yandex/unified_agent/conf.d/config.yml \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      cr.yandex/yc/unified-agent
      ```

       You can find more ways to install the agent in [{#T}](../../concepts/data-collection/unified-agent/installation.md).

   1. Create a file named **config.yml** in your home folder. Replace `$FOLDER_ID` in the file with the ID of the folder you want to write metrics to.

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
              url: http://localhost:8000
              format:
                prometheus: {}
              namespace: app
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

 1. Make sure that metrics are delivered to {{ monitoring-full-name }}.

    1. On the {{ monitoring-full-name }} [home page](https://monitoring.cloud.yandex.com), go to **Metric Explorer**.

    1. In the query block, select:
      - The folder where metrics are collected.
      - The label value `service=custom`.
      - The metric name starting with the `app` prefix.

#### What's next {#what-is-next}

- [Review Unified Agent concepts](../../concepts/data-collection/unified-agent/index.md)
- [Learn more about configuring Unified Agent](../../concepts/data-collection/unified-agent/configuration.md)
- [Read the Unified Agent operating instructions](../../concepts/data-collection/unified-agent/best-practices.md)
