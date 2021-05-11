# Delivering metrics from hosts outside {{ yandex-cloud }}

To deliver metrics to {{ monitoring-full-name }} from hosts located outside {{ yandex-cloud }}, use [authorized keys](../../../iam/concepts/authorization/key.md) of service accounts. You can also use this method to send metrics from {{ yandex-cloud }} VMs without a linked service account.

## Delivering metrics using an authorized key { #example }

To configure {{unified-agent-full-name}} to deliver metrics using an authorized key, follow these steps:

1. Set up a service account from which metrics will be written to {{ monitoring-full-name }} and create an authorized key.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder you want to write metrics to and [assign it the](../../../iam/operations/sa/assign-role-for-sa.md) `editor` role.

   1. [Create an authorized key](../../../iam/operations/authorized-key/create.md) for your new service account using [YC CLI](../../../cli/quickstart.md), replacing `<SA_ID>` with your service account ID:

       ```bash
       yc iam key create --service-account-id <SA_ID> --output jwt_params.json
       ```

      You can find more ways to create authorized keys in [{#T}](../../../iam/operations/authorized-key/create.md).

   1. Deliver the **jwt_params.json** file with the parameters of the authorized key to the host where {{unified-agent-short-name}} is installed.

       Sample **jwt_params.json** file:

       ```json
       {
           "id": "ajt...",
           "service_account_id": "aje...",
           "created_at": "2021-01-14T13:18:51.070026Z",
           "key_algorithm": "RSA_2048",
           "public_key": "-----BEGIN PUBLIC KEY-----\nMD...",
           "private_key": "-----BEGIN PRIVATE KEY-----\nMI..."
       }
       ```

1. Install and configure {{unified-agent-full-name}}.

   1. Install {{unified-agent-short-name}} on your VM by running the following command in the home folder:

      ```bash
      docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v \/proc:/ua_proc \
      -v config.yml:/etc/yandex/unified_agent/conf.d/config.yml \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      cr.yandex/yc/unified-agent
      ```

       You can find more ways to install the agent in [{#T}](../../concepts/data-collection/unified-agent/installation.md).

   1. Create a file named **config.yml** in your home folder. Replace `$FOLDER_ID` in the file with the ID of the folder you want to write metrics to.  Enter the file name with the JWT parameters in the `iam.jwt.file` section.

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
                    jwt:
                      file: "jwt_params.json"
       
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

1. Make sure the metrics are delivered to {{ monitoring-full-name }}.

    1. On the {{ monitoring-full-name }} [home page](https://monitoring.cloud.yandex.com), go to **Metric Explorer**.

    1. In the query block, select:
      - The folder where metrics are collected.
      - The label value `service=custom`.
      - The metric name starting with the `sys` prefix.

#### What's next {#what-is-next}

- [Review Unified Agent concepts](../../concepts/data-collection/unified-agent/index.md)
- [Learn more about configuring Unified Agent](../../concepts/data-collection/unified-agent/configuration.md)
- [Read the Unified Agent operating instructions](../../concepts/data-collection/unified-agent/best-practices.md)

