# Delivering metrics from hosts outside {{ yandex-cloud }}

To deliver metrics to {{ monitoring-full-name }} from hosts located outside {{ yandex-cloud }}, use service account [authorized keys](../../../iam/concepts/authorization/key.md). You can also use this method to send metrics from {{ yandex-cloud }} VMs without a linked service account.

## Delivering metrics using an authorized key {#example}

To configure {{unified-agent-full-name}} to deliver metrics using an authorized key, follow these steps:

1. Set up a service account from which metrics will be written to {{ monitoring-full-name }} and create an authorized key.

   1. [Create a service account](../../../iam/operations/sa/create.md) in the folder you want to write metrics to and [assign it](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}`.

   1. [Create an authorized key](../../../iam/operations/authorized-key/create.md) for your new service account using [YC CLI](../../../cli/quickstart.md):

      ```bash
      yc iam key create --service-account-id <SA_ID> --output jwt_params.json
      ```

      Where `<SA_ID>` is the service account ID.

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

1. Install and configure {{unified-agent-full-name}}:

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

      Where:

      * `$FOLDER_ID`: ID of the folder you want to write metrics to.
      * `iam.jwt.file`: Name of the file with JWT parameters.

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

1. Make sure the metrics are delivered to {{ monitoring-full-name }}:

   1. On the {{ monitoring-full-name }} [homepage]({{ link-monitoring }}), go to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

   1. In the query block, select:
   - The folder where metrics are collected.
   - The label value `service=custom`.
   - The metric name starting with the `sys` prefix.

#### What's next {#what-is-next}

- [Read about {{ unified-agent-short-name }} concepts](../../concepts/data-collection/unified-agent/index.md)
- [Learn more about configuring {{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/configuration.md)
- [Read the {{ unified-agent-short-name }} operating instructions](../../concepts/data-collection/unified-agent/best-practices.md)
