# Stopping and starting a {{ GL }} instance

If necessary, you can stop and restart a [{{ GL }} instance](../../concepts/index.md#instance). When the instance is stopped, all its data is saved.

You are not charged while your instance is stopped: you continue to pay only for the data stored by the instance and the size of backups stored in {{ objstorage-full-name }} based on the [pricing policy](../../pricing.md#prices-storage).

## Stopping a {#stop-instance} instance

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Find the instance in the list, click ![options](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.common.stop }}**.
  1. In the dialog box that opens, confirm that you want to stop the instance, then click **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To stop a {{ GL }} instance, run this command:

  ```bash
  {{ yc-mdb-gl }} instance stop <instance_name_or_ID>
  ```

  You can [request](instance-list.md#list) the instance ID or name with the list of instances in the folder.

  Result:

  ```text
  done (20s)
  id: c17ab1ehdfag********
  folder_id: b1gmm82dtdb3********
  created_at: "2024-01-29T16:11:45.859Z"
  updated_at: "2025-06-25T20:38:41.325Z"
  name: inst-gitlab
  resource_preset_id: s2.micro
  disk_size: "32212254720"
  status: STOPPED
  admin_login: <admin_login>
  admin_email: <email>
  domain: example.gitlab.yandexcloud.net
  subnet_id: e9bp8qmchqh2********
  backup_retain_period_days: "7"
  approval_rules_id: NONE
  gitlab_version: 17.11.4
  ```

  For more information about this command, see the [CLI reference](../../cli-ref/instance/stop.md).

- API {#api}

  Use the [Stop](../../api-ref/Instance/stop.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Stop](../../api-ref/grpc/Instance/stop.md) gRPC API call.

{% endlist %}

## Starting a {#start-instance} instance

You can restart your **Stopped** instance.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Find the stopped instance in the list, click ![options](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.common.start }}**.
  1. In the dialog box that opens, confirm that you want to start the instance by clicking **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To start a {{ GL }} instance, run this command:

  ```bash
  {{ yc-mdb-gl }} instance start <instance_name_or_ID>
  ```

  You can [request](instance-list.md#list) the instance ID or name with the list of instances in the folder.

  Result:

  ```text
  done (1m44s)
  id: c17ab1ehdfag********
  folder_id: b1gmm82dtdb3********
  created_at: "2024-01-29T16:11:45.859Z"
  updated_at: "2025-06-25T20:38:41.325Z"
  name: inst-gitlab
  resource_preset_id: s2.micro
  disk_size: "32212254720"
  status: RUNNING
  admin_login: <admin_login>
  admin_email: <email>
  domain: example.gitlab.yandexcloud.net
  subnet_id: e9bp8qmchqh2********
  backup_retain_period_days: "7"
  approval_rules_id: NONE
  gitlab_version: 17.11.4
  ```

  For more information about this command, see the [CLI reference](../../cli-ref/instance/start.md).

- API {#api}

  Use the [Start](../../api-ref/Instance/start.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Start](../../api-ref/grpc/Instance/start.md) gRPC API call.

{% endlist %}
