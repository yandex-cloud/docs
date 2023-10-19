# Visualizing logs in {{ grafana-name }} using the {{ cloud-logging-full-name }} plugin

The [{{ cloud-logging-full-name }} plugin for {{ grafana-name }}](https://github.com/yandex-cloud/grafana-logs-plugin/tree/master) is an extension for {{ grafana-name }} that allows you to add [{{ cloud-logging-name }}](https://cloud.yandex.ru/services/logging) as a data source.

To visualize logs:
1. [Install the plugin](#install-plugin).
1. [Create a service account](#create-account).
1. [Connect a data source](#create-group).
1. [Create a log group](#create-group).
1. [Add records to a log group](#add-records).
1. [View the logs in {{ grafana-name }}](#see-logs).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of resources includes a fee for logging operations and log storage in a log group (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).

## Install the plugin {#install-plugin}

To install the {{ cloud-logging-full-name }} plugin for {{ grafana-name }}, follow this [guide](https://grafana.com/docs/grafana/latest/administration/plugin-management/#install-plugin-on-local-grafana).

The plugin is currently unsigned, so you need to explicitly [allow its installation](https://grafana.com/docs/grafana/latest/administration/plugin-management/#allow-unsigned-plugins).

## Create a service account {#create-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
   1. Go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter `grafana-plugin` as your service account name.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `logging.reader` role.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a service account named `grafana-plugin`:

      ```bash
      yc iam service-account create --name grafana-plugin
      ```

      Result:

      ```
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-09-26T10:36:29.726397755Z"
      name: grafana-plugin
      ```

      Save the `id` of the `grafana-plugin` service account and that of the folder where it was created (`folder_id`).

   1. Assign the service account the `logging.reader` role for the folder:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role logging.reader \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```
      done (1s)
      ```

- {{ TF }}

   
   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   1. In the configuration file, describe the service account parameters:

      ```hcl
      resource "yandex_iam_service_account" "grafana-plugin" {
        name        = "grafana-plugin"
        folder_id   = "<folder_ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "reader" {
        folder_id = "<folder_ID>"
        role      = "logging.reader"
        member    = "serviceAccount:${yandex_iam_service_account.grafana-plugin id}"
      }
      ```

      Where:

      * `name`: Service account name. This is a required parameter.
      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md). This is an optional parameter. By default, the value specified in the provider settings is used.
      * `role`: Role being assigned.

      For more information about the `yandex_iam_service_account` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays information about the service account. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

   1. If the configuration does not contain any errors, run this command:

      ```bash
      terraform apply
      ```

   1. Confirm creating the service account by typing `yes` in the terminal and pressing **Enter**.

      The service account will then be created. You can check the new service account using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc iam service-account list
      ```

- API

   To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API call.

   To assign the service account the `logging.reader` role for the folder, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC API call.

{% endlist %}

## Connect a data source {#connect-plugin}

To enable the plugin, follow this [guide](https://grafana.com/docs/grafana/latest/administration/data-source-management/#add-data-source-plugins).

In the **API Key** field, specify the [authorized key](../../iam/concepts/authorization/api-key.md) for the service account to authenticate with the {{ cloud-logging-name }} API.

## Create a log group {#create-group}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you created the service account.
   1. Select **{{ cloud-logging-name }}**.
   1. Click **Create group**.
   1. Enter `grafana-plugin` as the log group name.
   1. Set the log group record retention period.
   1. Click **Create group**.

- CLI

   To create a log group, run the command:

   ```
   yc logging group create \
     --name=grafana-plugin \
     --retention-period=<retention_period> \
   ```

   Where:
   * `--name`: Name of the log group
   * `--retention-period`: Log group record retention period

   Result:

   ```
   done (1s)
   id: af3flf29t8**********
   folder_id: aoek6qrs8t**********
   cloud_id: aoegtvhtp8**********
   created_at: "2023-09-26T09:56:38.970Z"
   name: grafana-plugin
   status: ACTIVE
   retention_period: 3600s
   ```

- {{ TF }}

   1. In the configuration file, describe the log group parameters:

      ```hcl
      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_logging_group" "grafana-plugin" {
        name      = "grafana-plugin"
        folder_id = "<folder ID>"
        retention_period = "1h"
      }
      ```

      Where:

      * `name`: Name of the log group

      * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md)

      * `retention_period`: Record retention period in the log group

      For more detailed information about the `yandex_logging_group` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/logging_group).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

   1. If the configuration does not contain any errors, run this command:

      ```
      terraform apply
      ```

   1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```
      yc logging group list
      ```

- API

   To create a log group, use the [create](../../logging/api-ref/LogGroup/create.md) REST API method for the [LogGroup](../../logging/api-ref/LogGroup/index.md) resource or the [LogGroupService/Create](../../logging/api-ref/grpc/log_group_service.md#Create) gRPC API call.

{% endlist %}

## Add records to the log group {#add-records}

{% list tabs %}

- CLI

   To add records to a log group, run the command:

   * Linux, macOS:
      ```
      yc logging write \
        --group-name=grafana-plugin \
        --message="My message" \
        --level=INFO
      ```
   * Windows (cmd):
      ```
      yc logging write ^
        --group-name=grafana-plugin ^
        --message="My message" ^
        --level=INFO
      ```
   * Windows (PowerShell):
      ```
      yc logging write `
        --group-name=grafana-plugin `
        --message="My message" `
        --level=INFO
      ```

      Where:

      * `--group-name`: Name of the log group to add records to
      * `--message`: Message
      * `--level`: Logging level

- API

   To add entries to the log group, use the [LogIngestionService/Write](../../logging/api-ref/grpc/log_ingestion_service.md#Write) gRPC API call.

{% endlist %}

## View the logs in {{ grafana-name }} {#see-logs}

To view the logs in {{ grafana-name }}, follow this [guide](https://grafana.com/docs/grafana/latest/explore/).

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete the log group](../../logging/operations/delete-group.md).
