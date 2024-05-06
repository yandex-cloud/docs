# Managing endpoints

The source [endpoint](../../concepts/index.md#endpoint) describes the settings of the database from which the information will be transferred using {{ data-transfer-name }}, while the target endpoint, the database you are going to transfer the data to. You can [create](#create), [edit](#update), [clone](#clone), or [delete](#delete) such endpoints.

## Getting a list of endpoints {#list}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To get a list of [transfers](../../concepts/index.md#transfer) in a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder), run the following command:

   ```bash
   {{ yc-dt }} endpoint list
   ```

- API {#api}

   Use the [list](../../api-ref/Endpoint/list.md) API method.

{% endlist %}

## Creating an endpoint {#create}


{% include [access-requirements](../../../_includes/data-transfer/note-on-required-role.md) %}


{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
   1. Click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
   1. In the **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** field, select **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}** or **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**.
   1. Enter a name for the endpoint. Use lowercase Latin letters and numbers.
   1. (Optional) Enter a description of the endpoint.
   1. Select the appropriate value in the **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** field. This will create an endpoint of the relevant type.
   1. Set the endpoint parameters:

      {% include [Parameter list](../../../_includes/data-transfer/endpoint-param-list.md) %}

   1. Click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.

- CLI {#cli}

   {% note info %}

   You can create endpoints using the [CLI](../../../cli/) commands only for sources and targets of the {{ CH }}, {{ MG }}, {{ MY }}, and {{ PG }} types.

   {% endnote %}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create endpoint command:

      ```bash
      {{ yc-dt }} endpoint create --help
      ```

   1. Specify the endpoint parameters in the create command (only some of the supported parameters are given in the example):

      ```bash
      {{ yc-dt }} endpoint create <endpoint_type> \
        --name <endpoint_name> \
        --description <endpoint_description> \
        <endpoint_parameters>
      ```

      You can view the endpoint type and parameters in the settings section for the appropriate data source or target.

- {{ TF }} {#tf}

   
   {% note info %}

   You can create endpoints with {{ TF }} only for {{ CH }}, {{ MG }}, {{ MY }}, and {{ PG }} sources and targets.

   {% endnote %}


   
   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}


   1. Create a configuration file with a description of your endpoint.

      Here is an example of the configuration file structure:

      ```hcl
      resource "ycp_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
        name = "<endpoint_name>"
        settings {
          <endpoint_type> {
            <endpoint_parameters>
          }
        }
      }
      ```

   You can retrieve a complete resource schema by running `terraform providers schema`.

   1. You can view the endpoint type and parameters in the settings section for the appropriate data source or target.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

   
   1. For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).


- API {#api}

    {% note info %}

    You can create endpoints with the API only for {{ CH }}, {{ KF }}, {{ MG }}, {{ MY }}, and {{ PG }} sources and targets.

    {% endnote %}

    Use the [create](../../api-ref/Endpoint/create) API method and include the following information in the request:
    * ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to contain the endpoint in the `folderId` parameter.
    * Endpoint name in the `name` parameter.
    * Endpoint description in the `description` parameter.
    * Endpoint parameters in the `settings` parameter.

    You can view the endpoint parameters in the settings section for the appropriate data source or target.

{% endlist %}

## Updating the endpoint {#update}


{% include [access-requirements](../../../_includes/data-transfer/note-on-required-role.md) %}


{% note info %}

You cannot change the endpoint type and the database type. For some endpoints, you cannot change the connection type, either.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
   1. Select an endpoint and click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** in the top panel.
   1. Edit the endpoint parameters:

      {% include [Parameter list](../../../_includes/data-transfer/endpoint-param-list.md) %}

   1. Click **{{ ui-key.yacloud.common.apply }}**.

- CLI {#cli}

   {% note info %}

   You can change endpoints using the CLI commands only for {{ CH }}, {{ MG }}, {{ MY }}, and {{ PG }} sources and targets.

   {% endnote %}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To update the endpoint settings:

   1. View a description of the update transfer CLI command:

      ```bash
      {{ yc-dt }} endpoint update --help
      ```

   1. Run the following command by providing a list of the settings to change (the example below does not contain a full list of parameters):

      ```bash
      {{ yc-dt }} transfer update <endpoint_type> <endpoint_ID> \
        --name <endpoint_name> \
        --description <endpoint_description> \
        <endpoint_parameters>
      ```

      You can view the endpoint type and parameters in the settings section for the appropriate data source or target. You can get the endpoint ID with a [list of endpoints in the folder](#list).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with the endpoint description.

      To learn how to create such a file, see [Create endpoint](#create).

   1. Edit the value in the `name` field (endpoint name) and the endpoint parameters under `settings`.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

   {% note info %}

   You can edit endpoints using the API only for {{ CH }}, {{ KF }}, {{ MG }}, {{ MY }}, and {{ PG }} sources and targets.

   {% endnote %}

   Use the [update](../../api-ref/Endpoint/update) API method and include the following in the request:

   * Endpoint ID in the `endpointId` parameter.
   * Endpoint name in the `name` parameter.
   * Endpoint description in the `description` parameter.
   * Endpoint parameters in the `settings` parameter.

   You can get the endpoint ID with a [list of endpoints in the folder](#list).

{% endlist %}

Editing the endpoint settings of a transfer with the {{ dt-type-repl }} type and the {{ dt-status-repl }} status will result in restarting the transfer.

## Cloning an endpoint {#clone}

{% note info %}

When cloning, you cannot change the endpoint type and the database type.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
   1. Select the endpoint to clone.
   1. Click **{{ ui-key.yacloud.common.clone }}** in the top panel.
   1. Specify a new endpoint name and edit other parameters, if required:

      {% include [Parameter list](../../../_includes/data-transfer/endpoint-param-list.md) %}

   1. Click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.

{% endlist %}

## Deleting an endpoint {#delete}

{% note warning %}

Before deleting an endpoint, [delete](../transfer.md#delete) all the transfers it is included in.

{% endnote %}

To delete an endpoint:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
   1. Select the endpoint to delete.
   1. Click **{{ ui-key.yacloud.common.delete }}** in the top panel.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To delete an endpoint, run the command:

    ```bash
    {{ yc-dt }} endpoint delete <endpoint_ID>
    ```

    You can get the endpoint ID with a [list of endpoints in the folder](#list).

- {{ TF }} {#tf}

    {% include [terraform-delete](../../../_includes/data-transfer/terraform-delete-endpoint.md) %}

- API {#api}

    Use the [delete](../../api-ref/Endpoint/delete) API method and provide the ID of the required endpoint in the `endpointID` request parameter.

    You can get the endpoint ID with a [list of endpoints in the folder](#list).

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}