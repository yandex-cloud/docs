# Delivering Linux system metrics

{{ monitoring-full-name }} gets general virtual machine metrics from {{ compute-full-name }}. For example, this can be the size of RAM allocated to a VM at its start. However, you can measure how a VM utilizes its memory only by collecting data within that VM. {{ unified-agent-full-name }} is a utility that collects and transmits [Linux system metrics](../../metrics-ref/unifiedagent-ref.md).

{% note warning %}

Delivery of system metrics for Windows and macOS VMs is planned for upcoming {{ unified-agent-full-name }} releases.

{% endnote %}



To configure {{ unified-agent-full-name }} to collect system metrics from a {{ yandex-cloud }} VM, follow these steps:

1. Set up a service account to use for writing metrics to {{ monitoring-full-name }}.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder for metric storage and [assign it](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

   1. [Link your service account](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to a virtual machine with {{ unified-agent-short-name }} installed.

1. Install and configure {{ unified-agent-full-name }}:

   1. Create a file named **config.yml** in your home directory.

       **config.yml**:
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

       Where `$FOLDER_ID` is the ID of the folder to which you want to write metrics.

   1. Install {{ unified-agent-short-name }} on your VM by running the following command in your home directory:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      -v /proc:/ua_proc \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs81qpemb4******** \
      {{ registry }}/yc/unified-agent
      ```

       You can find more ways to install the agent in [{#T}](../../concepts/data-collection/unified-agent/installation.md).

1. Make sure {{ monitoring-full-name }} receives the metrics:

    1. On the {{ monitoring-full-name }} [home page]({{ link-monitoring }}), go to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

    1. In the query string, specify the following:
      - Folder for storing collected metrics.
      - `service=custom` label value.
      - Metric name prefixed with `sys`.


#### What's next {#what-is-next}

- [Read about {{ unified-agent-short-name }} concepts](../../concepts/data-collection/unified-agent/index.md)
- [Learn more about configuring {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Read best practices for using {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/best-practices.md)
