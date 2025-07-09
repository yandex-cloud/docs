# Getting information about instances

You can get detailed information about each [{{ GL }} instance](../../concepts/index.md#instance) you created in {{ yandex-cloud }}.

## Getting a list of instances in a folder {#list}

{% list tabs group=instructions %}

- Management console {#console}

  Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To get a list of available {{ GL }} instances in the default folder, run this command:

    ```bash
    {{ yc-gl }} instance list
    ```

    Result:

    ```bash
    +----------------------+-------+-------------------------------+---------------------+---------------------+----------------+---------+
    |          ID          | NAME  |            DOMAIN             |     CREATED AT      |     UPDATED AT      | GITLAB VERSION | STATUS  |
    +----------------------+-------+-------------------------------+---------------------+---------------------+----------------+---------+
    | c17gehgsk7gq******** | my-gl | domain.gitlab.yandexcloud.net | 2025-06-10 12:10:55 | 2025-06-10 12:10:55 | 17.11.2        | RUNNING |
    +----------------------+-------+-------------------------------+---------------------+---------------------+----------------+---------+
    ```

    Where:

    * `ID`: Instance ID.
    * `NAME`: Instance name.
    * `DOMAIN`: Instance address on the internet.
    * `CREATED AT`: Date and time when the instance was created.
    * `UPDATED AT`: Date and time when the instance was updated.
    * `GITLAB VERSION`: {{ GL }} version.
    * `STATUS`: Instance status. Learn more about possible statuses [here](monitoring.md#statuses).

    For more information about this command, see the [CLI reference](../../cli-ref/instance/list.md).

{% endlist %}

## Getting instance details {#get}

Instance details include:
* Domain.
* Status.
* Resources: RAM, vCPU, and disk size.
* Admin's username and email address.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ GL }} instance is located.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To get details for a {{ GL }} instance, run this command:

    ```bash
    {{ yc-gl }} instance get <instance_name_or_ID>
    ```
    
    Result:

    ```bash
    id: c17gehgsk7gq********
    folder_id: b1gutjgdvq50********
    created_at: "2025-06-10T12:10:55.902Z"
    updated_at: "2025-06-10T12:10:55.902Z"
    name: my-gl
    resource_preset_id: s2.micro
    disk_size: "32212254720"
    status: RUNNING
    admin_login: my-login
    admin_email: admin@mail.ru
    domain: domain.gitlab.yandexcloud.net
    subnet_id: e9bk8uu1lv1sg********
    backup_retain_period_days: "7"
    maintenance_delete_untagged: true
    deletion_protection: true
    approval_rules_id: NONE
    gitlab_version: 17.11.2
    ```

    Where:

    * `id`: Instance ID.
    * `folder_id`: ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the instance.
    * `created_at`: Date and time when the instance was created.
    * `updated_at`: Date and time when the instance was updated.
    * `name`: Instance name.
    * `resource_preset_id`: [Instance type](../../concepts/index.md#config) ID.
    * `disk_size`: Disk size.
    * `status`: Instance status. Learn more about possible statuses [here](monitoring.md#statuses).
    * `admin_login`: Administrator login.
    * `admin_email`: Administrator email.
    * `domain`: Instance address on the internet.
    * `subnet_id`: [Subnet](../../../vpc/concepts/network.md#subnet) ID.
    * `backup_retain_period_days`: Backup retention in days.
    * `maintenance_delete_untagged`: Enables deletion of untagged images during maintenance. The possible values are `true` or `false`.
    * `deletion_protection`: Instance protection from accidental deletion by a user. The possible values are `true` or `false`.
    * `approval_rules_id`: Approval rules. [Learn more about supported rule configurations](../../concepts/approval-rules.md#packages).
    * `gitlab_version`: {{ GL }} version.

    You can request the instance name and ID with the [list of instances in the folder](instance-list.md#list).  

    For more information about this command, see the [CLI reference](../../cli-ref/instance/get.md).

{% endlist %}

## Viewing a list of operations in an instance {#list-operations}

The list shows operations with instances and resources linked to them.

All actions with {{ mgl-name }} instances are logged as a list of operations. Each operation gets its own unique ID.

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of operations for a specific instance:

  1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.gitlab.switch_instances }}**.
  1. Select the instance you need.
  1. Go to the ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected cluster.

     You will see the list of operations with the selected instance.

{% endlist %}


#### See also {#see-also}

* [{#T}](../../../api-design-guide/concepts/about-async.md)