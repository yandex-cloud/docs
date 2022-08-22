# Delivering Linux system metrics

To deliver system metrics for virtual machines running on Linux-compatible operating systems to {{ monitoring-full-name }}, use the input [linux_metrics](../../concepts/data-collection/unified-agent/configuration.md#linux_metrics_input).

{% note warning %}

Delivery of system metrics for virtual machines run on Windows and macOS is planned for upcoming {{ unified-agent-full-name }} releases.

{% endnote %}

To configure {{unified-agent-full-name}} to collect system metrics from a {{ yandex-cloud }} VM, follow these steps:

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
             plugin: linux_metrics
             config:
               namespace: sys
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
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -v /proc:/ua_proc \
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
   - The metric name starting with the `sys` prefix.


#### What's next {#what-is-next}

- [Review {{ unified-agent-short-name }} concepts](../../concepts/data-collection/unified-agent/index.md)
- [Learn more about configuring {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Read the {{ unified-agent-short-name }} operating instructions](../../concepts/data-collection/unified-agent/best-practices.md)
