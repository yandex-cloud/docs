# Delivering custom application metrics

{{ unified-agent-full-name }} collects metrics in the {{ prometheus-name }} format and converts them to the {{ monitoring-full-name }} format. {{ unified-agent-short-name }} enables you to pull metrics from applications that deliver them in the {{ prometheus-name }} format.

To deliver custom application metrics to {{ monitoring-full-name }}, use the [metrics_pull input](../../concepts/data-collection/unified-agent/configuration.md#metrics_pull_input) that regularly polls an application over HTTP expecting to receive metrics in {{ prometheus-name }} format.

As an example, let's discuss delivery of metrics from a test application written in Python. You can run your test application and {{ unified-agent-short-name }} both on different VMs and on a single VM. If run on different VMs, make sure their [security groups](../../../vpc/concepts/security-groups.md) allow incoming and outgoing traffic on port `8000` via `TCP`.

## Example of delivering custom application metrics {#example}

You can also use this method to deliver metrics from any custom applications that use [Prometheus client libraries](https://prometheus.io/docs/instrumenting/clientlibs/).

1. Set up a service account under which metrics will be written to {{ monitoring-full-name }}.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder you want to write metrics to and [assign it](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

   1. [Link your service account](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to the VM to install {{unified-agent-short-name}} on.

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

      For successful metric delivery to {{ unified-agent-short-name }}, make sure your test application keeps running: do not stop it.

   1. Check that the application delivers metrics. To do this, execute the following command by specifying the public IP of your VM with the running application:

      ```bash
      curl http://<VM_public_IP>:8000
      ```

      Result:

      ```text
      # HELP python_gc_objects_collected_total Objects collected during gc
      # TYPE python_gc_objects_collected_total counter
      python_gc_objects_collected_total{generation="0"} 362.0
      python_gc_objects_collected_total{generation="1"} 0.0
      python_gc_objects_collected_total{generation="2"} 0.0
      # HELP python_gc_objects_uncollectable_total Uncollectable object found during GC
      # TYPE python_gc_objects_uncollectable_total counter
      ```

1. Install and configure {{ unified-agent-full-name }}:

   1. Install Docker if needed:

      ```bash
      sudo apt-get install docker.io
      ```

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
                 folder_id: "<folder_ID>"
                 iam:
                   cloud_meta: {}

       routes:
         - input:
             plugin: metrics_pull
             config:
               url: http://<VM_public_IP>:8000/metrics
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

      Where:

      * `folder_id`: ID of the folder you want to write metrics to.
      * `url`: Public address of the VM hosting the test application that delivers metrics.

   1. Install {{ unified-agent-short-name }} by running the following command in your home directory:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=<folder_id> \
      {{ registry }}/yc/unified-agent
      ```

      Where `FOLDER_ID` is the ID of the folder to write metrics to.

      You can find more ways to install the agent in [{#T}](../../concepts/data-collection/unified-agent/installation.md).

1. Make sure the metrics are delivered to {{ monitoring-full-name }}:

   1. On the {{ monitoring-full-name }} [home page]({{ link-monitoring }}), go to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

   1. In the query block, select:
   - Folder where metrics are collected.
   - `Custom Metrics` label value.
   - Metric name starting with the `app` prefix.

#### What's next {#what-is-next}

- [Read about {{ unified-agent-short-name }} concepts](../../concepts/data-collection/unified-agent/index.md)
- [Learn more about configuring {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Read the {{ unified-agent-short-name }} operating instructions](../../concepts/data-collection/unified-agent/best-practices.md)
