# Delivering custom application metrics

{{ unified-agent-full-name }} collects metrics in {{ prometheus-name }} format and converts them to {{ monitoring-full-name }} format. {{ unified-agent-short-name }} enables you to pull metrics from applications that provide them in {{ prometheus-name }} format.

To deliver custom application metrics to {{ monitoring-full-name }}, use the [metrics_pull input](../../concepts/data-collection/unified-agent/configuration.md#metrics_pull_input) that regularly polls the app over HTTP, expecting to receive metrics in {{ prometheus-name }} format.

As an example, let's consider delivery of metrics from a test app written in Python. Your test app and {{ unified-agent-short-name }} can run either on different VMs or on the same one. If the VMs are different, make sure their [security groups](../../../vpc/concepts/security-groups.md) allow incoming and outgoing traffic on port `8000` via `TCP`.

## Example of delivering custom application metrics {#example}

You can also use this method to deliver metrics from any custom applications that use [Prometheus client libraries](https://prometheus.io/docs/instrumenting/clientlibs/).

1. Set up a service account to use for writing metrics to {{ monitoring-full-name }}.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder for metric storage and [assign it](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

   1. [Link your service account](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to the VM where {{unified-agent-short-name}} will be deployed.

1. Run a test Python app that provides metrics in {{ prometheus-name }} format.

   1. Install the [prometheus_client](https://github.com/prometheus/client_python) Python library by running the following commands:

       ```bash
       sudo apt install python3-pip
       pip3 install prometheus_client
       ```

   1. Create a test Python app by writing the following code to the **example.py** file:

       **example.py:**
       ```python
       from prometheus_client import start_http_server, Summary
       import random
       import time

       # Create a metric to monitor the number of requests and their processing time.
       REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

       # Use a decorator to add the metric to the request handler function.
       @REQUEST_TIME.time()
       def process_request(t):
           """A dummy function that takes some time."""
           time.sleep(t)

       if __name__ == '__main__':
           # Start the HTTP server to expose metrics from the application.
           start_http_server(8000)
           # Generate random requests.
           while True:
               process_request(random.random())
       ```

   1. Run your test Python app with this command:

       ```bash
       python3 example.py
       ```

       To successfully deliver metrics to {{ unified-agent-short-name }}, keep your test app running.

    1. Check that the application delivers metrics by running the following command, specifying the public IP address of your VM running the app:

        ```bash
        curl http://<VM_public_address>:8000
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

   1. Install Docker, if required:

      ```bash
      sudo apt-get install docker.io
      ```

   1. Create a file named **config.yml** in your home directory.

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
                url: http://<VM_public_address>:8000/metrics
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
       ```

       Where:

       * `folder_id`: ID of the folder to which you want to write metrics.
       * `url`: Public address of the VM hosting the test app that delivers metrics.

   1. Install {{ unified-agent-short-name }} by running the following command in your home directory:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v $(pwd)/config.yml:/etc/yandex/unified_agent/conf.d/config.yml \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=<folder_ID> \
      {{ registry }}/yc/unified-agent
      ```

      Where `FOLDER_ID` is the ID of the folder to which you want to write metrics.
      
      You can find more ways to install the agent in [{#T}](../../concepts/data-collection/unified-agent/installation.md).

 1. Make sure {{ monitoring-full-name }} receives the metrics:

    1. On the {{ monitoring-full-name }} [home page]({{ link-monitoring }}), go to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

    1. In the query string, specify the following:
      - Folder for storing collected metrics.
      - `Custom Metrics` label value.
      - Metric name prefixed with `app`.

#### What's next {#what-is-next}

- [Read about {{ unified-agent-short-name }} concepts](../../concepts/data-collection/unified-agent/index.md)
- [Learn more about configuring {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Read best practices for using {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/best-practices.md)
