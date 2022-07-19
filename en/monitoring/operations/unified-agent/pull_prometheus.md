# Delivering custom application metrics

{{unified-agent-full-name}} collects metrics in {{ prometheus-name }} format and converts them to {{ monitoring-full-name }} format. Using {{unified-agent-short-name}} lets you pull metrics from applications that deliver them in the {{ prometheus-name }} format.

To deliver custom application metrics to {{ monitoring-full-name }}, use the [metrics_pull input](../../concepts/data-collection/unified-agent/configuration.md#metrics_pull_input) that regularly polls an application over HTTP expecting to receive metrics in {{ prometheus-name }} format.

As an example, let's discuss delivery of metrics from a test application written in Python.

## Example of delivering custom application metrics {#example}

You can also use this method to deliver metrics from any custom applications that use [Prometheus client libraries](https://prometheus.io/docs/instrumenting/clientlibs/).

1. Run a test Python application that provides metrics in {{ prometheus-name }} format.

   1. Install the [prometheus_client](https://github.com/prometheus/client_python) Python library by running the following commands:

      ```bash
      sudo apt install python3-pip
      pip3 install prometheus_client
      ```

   1. Create a test Python application by writing the following code to the **example.py** file:

      **example.py:**
      ```python
      from prometheus_client import start_http_server, Summary
      import random
      import time

      # Create a metric to track the number of requests and their execution time.
      REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

      # Add the metric to the request processing function.
      @REQUEST_TIME.time()
      def process_request(t):
          """A dummy function that takes some time."""
          time.sleep(t)

      if __name__ == '__main__':
          # Start the HTTP server so that the application provides metrics.
          start_http_server(8000)
          # Generate random requests.
          while True:
              process_request(random.random())
      ```

   1. Run the test Python application with the command:

      ```bash
      python3 example.py
      ```

   1. Check that the application provides metrics by running the `curl http://localhost:8000` command. Sample command output:

      ```bash
      curl http://localhost:8000
      # HELP python_gc_objects_collected_total Objects collected during gc
      # TYPE python_gc_objects_collected_total counter
      python_gc_objects_collected_total{generation="0"} 362.0
      python_gc_objects_collected_total{generation="1"} 0.0
      python_gc_objects_collected_total{generation="2"} 0.0
      # HELP python_gc_objects_uncollectable_total Uncollectable object found during GC
      # TYPE python_gc_objects_uncollectable_total counter
      ...
      ```

1. Set up a service account from which metrics will be written to {{ monitoring-full-name }}.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder you want to write metrics to and [assign it](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

   1. [Link your service account](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to a virtual machine with {{unified-agent-short-name}} installed.

1. Install and configure {{unified-agent-full-name}}.

   1. Create a file named **config.yml** in your home folder.

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

      Where `$FOLDER_ID` is the ID of the folder you want to write metrics.

   1. Install {{unified-agent-short-name}} on your VM by running the following command in the home folder:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      cr.yandex/yc/unified-agent
      ```

      You can find more ways to install the agent in [{#T}](../../concepts/data-collection/unified-agent/installation.md).

1. Make sure the metrics are delivered to {{ monitoring-full-name }}.

   1. On the [home page]({{ link-monitoring }}) {{ monitoring-full-name }}, go to **Metric Explorer**.

   1. In the query block, select:
   - The folder where metrics are collected.
   - The label value `service=custom`.
   - The metric name starting with the `app` prefix.

#### What's next {#what-is-next}

- [Review {{ unified-agent-short-name }} concepts](../../concepts/data-collection/unified-agent/index.md)
- [Learn more about configuring {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Read the {{ unified-agent-short-name }} operating instructions](../../concepts/data-collection/unified-agent/best-practices.md)
