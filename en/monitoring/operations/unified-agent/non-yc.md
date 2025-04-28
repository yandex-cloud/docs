---
title: Delivering metrics from hosts outside {{ yandex-cloud }}
description: Follow this guide to deliver metrics from hosts outside {{ yandex-cloud }}.
---

# Delivering metrics from hosts outside {{ yandex-cloud }}

To deliver metrics to {{ monitoring-full-name }} from hosts outside {{ yandex-cloud }}:

1. Create an authorized service account [key](../../../iam/concepts/authorization/key.md) to access the folder that will receive metrics.

1. [Install and configure {{ unified-agent-full-name }}](../../concepts/data-collection/unified-agent/installation.md) to collect and send metrics.

You can also use this method to send metrics from {{ yandex-cloud }} VMs without a linked service account.

{% note warning %}

System metrics can only be delivered from Linux hosts on the AMD platform. Windows and macOS support is planned for upcoming {{ unified-agent-full-name }} releases.

{% endnote %}

## Delivering metrics using an authorized key {#example}

1. Set up a service account to use for writing metrics to {{ monitoring-full-name }} and create an authorized key.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder for metric storage and [assign it](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

   1. [Create an authorized key](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for your new service account using [YC CLI](../../../cli/quickstart.md):

       ```bash
       yc iam key create --service-account-id <service_account_ID> --output jwt_params.json
       ```

       Where `--service-account-id` is the ID of the service account you created.

      You can find more ways to create authorized keys in [{#T}](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key).

   1. Deliver the **jwt_params.json** file with the authorized key parameters to the host where {{ unified-agent-short-name }} will be installed.

       Example of `jwt_params.json`:
       ```json
       {
           "id": "ajt4yut8vb12********",
           "service_account_id": "ajeo5pert10z********",
           "created_at": "2024-05-15T07:10:32.585653195Z",
           "key_algorithm": "RSA_2048",
           "public_key": "-----BEGIN PUBLIC KEY-----\nMD...",
           "private_key": "-----BEGIN PRIVATE KEY-----\nMI..."
       }
       ```

1. [Install and configure {{ unified-agent-full-name }} on the host](../../concepts/data-collection/unified-agent/installation.md):

   1. Install [Docker](https://docs.docker.com).

   1. Create a file named **config.yml** in your home directory.

       **config.yml**:
       ```yaml
        status:
          port: "16241"
          host: null
        agent_log:
          priority: NOTICE

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
                  url: https://{{ api-host-monitoring-1 }}/monitoring/v2/data/write
                  folder_id: "$FOLDER_ID"
                  iam:
                    jwt:
                      file: "/etc/yandex/unified_agent/jwt_params.json"

        routes:
          - input:
              plugin: linux_metrics
              config:
                namespace: sys
                proc_directory: /ua_proc
                sys_directory: /sys
                resources:
                  cpu: basic
                  memory: basic
                  network: basic
                  storage: basic
                  io: basic
                  kernel: basic
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

       * `$FOLDER_ID`: ID of the folder you want to write metrics to.
       * `iam.jwt.file`: Path to the file with JWT parameters.

   1. Install {{ unified-agent-short-name }} by running the following command in your home directory:

      ```bash
      docker run \
      -p 16241:16241 -it -d --uts=host \
      --name unified-agent-$(echo $(cat /proc/sys/kernel/random/uuid) | cut -d '-' -f1) \
      -v /proc:/ua_proc \
      -v $(pwd)/config.yml:/etc/yandex/unified_agent/config.yml \
      -v $(pwd)/jwt_params.json:/etc/yandex/unified_agent/jwt_params.json \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs81qpemb4******** \
      --entrypoint="unified_agent" \
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
