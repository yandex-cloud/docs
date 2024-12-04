# Transferring the {{ metastore-full-name }} cluster logs to {{ cloud-logging-full-name }}

You can set up regular collection of logs with information about [{{ metastore-full-name }} cluster](../../metadata-hub/concepts/metastore.md) performance. Such logs will be delivered to a custom [log group](../../logging/concepts/log-group.md) in {{ cloud-logging-full-name }}.

To set up delivery of {{ metastore-name }} cluster logs to {{ cloud-logging-name }}:

1. [Create a log group](#create-log-group).
1. [Create a service account](#create-service-account).
1. [Assign the service account a role for the folder](#assign-role).
1. [Create a {{ metastore-name }} cluster](#create-metastore).
1. [Test the delivery of cluster logs to the log group](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Create a log group {#create-log-group}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your log group.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Click **{{ ui-key.yacloud.logging.button_create-group }}**.
    1. Enter `metastore-log-group` as the name.
    1. Set the retention period for log group records.
    1. Click **{{ ui-key.yacloud.logging.button_create-group }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a log group, run this command:

    ```bash
    yc logging group create \
       --name metastore-log-group \
       --retention-period <record_retention_period>
    ```

    This will create a group named `metastore-log-group`.

    {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

- {{ TF }} {#tf}

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. In the configuration file, describe the log group parameters:

        ```hcl
        resource "yandex_logging_group" "metastore-log-group" {
          name             = "metastore-log-group"
          folder_id        = "<folder_ID>"
          retention_period = "<record_retention_period>"
        }
        ```

        You can get the folder ID together with the [list of folders](../../resource-manager/operations/folder/get-id.md).

        {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

        For more information about the `yandex_logging_group` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/logging_group).

    1. Make sure the configuration files are correct.

        1. In the command line, go to the folder where you created the configuration file.
        1. Run a check using this command:

            ```bash
            terraform plan
            ```

        If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out. 

    1. Deploy cloud resources.

        1. If the configuration does not contain any errors, run this command:

            ```bash
            terraform apply
            ```

        1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

            All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

            ```bash
            yc logging group list
            ```

- API {#api}

    To create a log group, use the [create](../../logging/api-ref/LogGroup/create.md) REST API method for the [LogGroup](../../logging/api-ref/LogGroup/index.md) resource or the [LogGroupService/Create](../../logging/api-ref/grpc/LogGroup/create.md) gRPC API call and provide the following in the request body:

    * Folder ID in the `folderId` parameter. You can get the ID with the [list of folders](../../resource-manager/operations/folder/get-id.md).
    * `metastore-log-group` as the log group name in the `name` parameter.
    * Retention period for log group records in the `retentionPeriod` parameter.

        You can specify it in seconds only. Use this format: `<number>s`. If you specify `0s` or no value, the retention period will be unlimited.

{% endlist %}

## Create a service account {#create-service-account}

Use the [service account](../../iam/concepts/users/service-accounts.md) to deliver logs to {{ cloud-logging-name }}.

{% list tabs group=instructions %}

- Management console {#console}

    To create a service account:

    1. In the management console, select the folder where you created the log group.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
    1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Enter a name for the service account: `metastore-logging-sa`.
    1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

    To create a service account, run the following command:

    ```bash
    yc iam service-account create --name metastore-logging-sa
    ```

    The naming requirements are as follows:

    {% include [name-format](../../_includes/name-format.md) %}

- {{ TF }} {#tf}

    To create a service account:

    1. In the configuration file, describe the service account parameters:

        ```hcl
        resource "yandex_iam_service_account" "sa" {
          name        = "metastore-logging-sa"
          folder_id   = "<folder_ID>"
        }
        ```

        For more information about the `yandex_iam_service_account` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account).

    1. Make sure the configuration files are correct.

        1. In the command line, go to the folder where you created the configuration file.
        1. Run a check using this command:

            ```bash
            terraform plan
            ```

        If the configuration is specified correctly, the terminal will display information about the service account. If the configuration contains any errors, {{ TF }} will point them out. 

    1. Deploy cloud resources.

        1. If the configuration does not contain any errors, run this command:

            ```bash
            terraform apply
            ```

        1. Confirm creating the service account: type `yes` in the terminal and press **Enter**.

            The service account will then be created. You can check the new service account using the management console or this CLI command:

            ```bash
            yc iam service-account list
            ```

- API {#api}

    To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call and provide the following in the request body:

    * Folder ID in the `folderId` parameter.
    * `metastore-logging-sa` as the service account name in the `name` parameter.

{% endlist %}

## Assign the service account a role for the folder {#assign-role}

Assign the [{{ roles.metastore.integrationProvider }}](../../metadata-hub/security/metastore-roles.md#managed-metastore-integrationProvider) role for the folder to the `metastore-logging-sa` service account. This role enables a {{ metastore-name }} cluster to work with various {{ yandex-cloud }} resources, which includes sending logs to {{ cloud-logging-name }}.

{% list tabs group=instructions %}

- Management console {#console}

    To assign a role:

    1. In the management console, select the appropriate folder.
    1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
    1. In the window that opens, enter the service account name,`metastore-logging-sa`, and select it.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `{{ roles.metastore.integrationProvider }}` role.
    1. Click **Save**.

- CLI {#cli}

    To assign a role, run this command:

    ```bash
    yc resource-manager folder add-access-binding <folder_name_or_ID> \
       --role {{ roles.metastore.integrationProvider }} \
       --subject serviceAccount:<service_account_ID>
    ```

    You can get the service account ID with the [list of service accounts](../../iam/operations/sa/get-id.md).

- {{ TF }} {#tf}

    To assign a role:

    1. In the configuration file, describe the service account role parameters:

        ```hcl
        resource "yandex_resourcemanager_folder_iam_member" "managed-metastore-integration-provider" {
          folder_id   = "<folder_ID>"
          role        = "{{ roles.metastore.integrationProvider }}"
          member      = "serviceAccount:<service_account_ID>"
        }
        ```

        You can get the service account ID with the [list of service accounts](../../iam/operations/sa/get-id.md).

    1. Make sure the configuration files are correct.

        1. In the command line, go to the folder where you created the configuration file.
        1. Run a check using this command:

            ```bash
            terraform plan
            ```

        If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

    1. Deploy cloud resources.

        1. If the configuration does not contain any errors, run this command:

            ```bash
            terraform apply
            ```

        1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

            All the resources you need will then be created in the specified folder. You can check the new resource using the management console or this CLI command:

            ```bash
            yc resource-manager folder list-access-bindings <folder_name_or_ID>
            ```

- API {#api}

    To assign a role, use the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call and provide the following in the request body:

    * `ADD` value in the `accessBindingDeltas.action` parameter to add a role.
    * `{{ roles.metastore.integrationProvider }}` role in the `accessBindingDeltas.accessBinding.roleId` parameter.
    * Service account ID in the `accessBindingDeltas.accessBinding.subject.id` parameter. You can get the ID with the [list of service accounts](../../iam/operations/sa/get-id.md).
    * `serviceAccount` value in the `accessBindingDeltas.accessBinding.subject.type` parameter to indicate the role is being assigned to a service account.

    Specify the ID of the appropriate folder in the request URL.

{% endlist %}

## Create a {{ metastore-name }} cluster {#create-metastore}

1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet the cluster will connect to. This will enable the cluster to work with {{ yandex-cloud }} services.
1. [Configure the security group](../../metadata-hub/operations/metastore/configure-security-group.md).
1. Create a {{ metastore-name }} cluster:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the management console, select the appropriate folder.
        1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
        1. In the left-hand panel, select the ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page.
        1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
        1. Specify `metastore-cluster` as the cluster name.
        1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select `metastore-logging-sa`.
        1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet with a NAT gateway configured.
        1. Under **{{ ui-key.yacloud.logging.label_title }}**:

            1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
            1. To write logs to a custom log group, select **{{ ui-key.yacloud.logging.label_loggroup }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field.
            1. Specify the log group, `metastore-log-group`.
            1. Select the minimum logging level.

                Logs of the specified level and higher will be written to the execution log. The available levels are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. The default level is `INFO`.

        1. Click **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

## Test the delivery of cluster logs to the log group {#check-result}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the management console, go to the relevant folder.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Click the row with the `metastore-log-group` log group.

    The page that opens will show the log group records.

- CLI {#cli}

    To view the records in JSON format, run the command:

    ```bash
    yc logging read --group-name=metastore-log-group --format=json
    ```

    Result:

    ```text
    [
      {
        "uid": "488ece3c-75b8-4d35-95ac-2b49********",
        "resource": {},
        "timestamp": "2024-08-22T02:10:40Z",
        "ingested_at": "2024-08-22T08:49:15.716Z",
        "saved_at": "2024-08-22T08:49:16.176097Z",
        "level": "INFO",
        "message": "My message",
        "json_payload": {
          "request_id": "1234"
        }
      }
    ]
    ```

- API {#api}

    To view log group records, use the [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

{% endlist %}

For more information, see [{#T}](../../logging/operations/read-logs.md).

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    Delete:

    1. [Service account](../../iam/operations/sa/delete.md)
    1. [Security group](../../vpc/operations/security-group-delete.md)
    1. [Route table](../../vpc/operations/delete-route-table.md)
    1. [NAT gateway](../../vpc/operations/delete-nat-gateway.md).
    1. [{{ metastore-name }} cluster](../../metadata-hub/operations/metastore/cluster-delete.md).

- {{ TF }} {#tf}

    1. In the terminal window, go to the directory containing the infrastructure plan.
    1. Delete the configuration files with the infrastructure created for delivering {{ metastore-name }} cluster logs.
    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        All the resources described in the deleted configuration files will be deleted.

{% endlist %}
