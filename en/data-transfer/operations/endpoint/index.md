# Endpoint management

The source [endpoint](../../concepts/index.md#endpoint) describes the settings of the database that information will be transferred from using {{ data-transfer-name }}, and the target endpoint — the database you are going to transfer the data to. You can [create](#create), [edit](#update), [clone](#clone), or [delete](#delete) such endpoints.

## Getting a list of endpoints {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../../_assets/data-transfer/endpoint.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To get a list of transfers in a folder, run the following command:

   ```bash
   {{ yc-dt }} endpoint list
   ```

- API

   Use the API [list](../../api-ref/Endpoint/list.md) method.

{% endlist %}

## Getting a list of endpoints {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../../_assets/data-transfer/endpoint.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.

{% endlist %}

## Creating an endpoint {#create}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. Click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
   1. In the **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** field, select **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}** or **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**.
   1. Enter a name for the endpoint. Use lowercase Latin letters and numbers.
   1. (optional) Enter a description of the endpoint.
   1. Select the appropriate value in the **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** field. This will create an endpoint of the relevant type.
   1. Set the endpoint parameters:

      {% include [Parameter list](../../../_includes/data-transfer/endpoint-param-list.md) %}

   1. Click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.

- CLI

   {% note info %}

   You can create endpoints using the CLI commands only for {{ CH }}, {{ MG }}, {{ MY }}, and {{ PG }} sources and targets.

   {% endnote %}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create an endpoint:

   1. View a description of the CLI create endpoint command:

      ```bash
      {{ yc-dt }} endpoint create --help
      ```

   1. Specify the endpoint parameters in the create command (only some of the supported parameters are given in the example):

      ```bash
      {{ yc-dt }} endpoint create <endpoint type> \
         --name <endpoint name> \
         --description <endpoint description> \
         <endpoint parameters>
      ```

      You can view the endpoint type and parameters in the settings section for the appropriate data source or target.

- {{ TF }}

   
   {% note info %}

   You can create endpoints with {{ TF }} only for {{ CH }}, {{ MG }}, {{ MY }}, and {{ PG }} sources and targets.

   {% endnote %}


   
   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }}, [install it and configure the provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To create an endpoint:

   1. Create a configuration file with a description of your endpoint.

      Example of the configuration file structure:

      ```hcl
      resource "ycp_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
        name = "<endpoint name>"
        settings {
          <endpoint type> {
            <endpoint parameters>
          }
        }
      }
      ```

   You can retrieve a complete resource schema by running `terraform providers schema`.

    1. You can view the endpoint type and parameters in the settings section for the appropriate data source or target.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the resources have been updated.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        
    1. For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).


- API

    {% note info %}

    You can create endpoints with the API only for {{ CH }}, {{ KF }}, {{ MG }}, {{ MY }}, and {{ PG }} sources and targets.

    {% endnote %}

    Use the [create](../../api-ref/Endpoint/create) API method and include the following information in the request:

    * ID of the folder to host the endpoint, in the `folderId` parameter.
    * Endpoint name in the `name` parameter.
    * Endpoint description in the `description` parameter.
    * Endpoint parameters in the `settings` parameter.

    You can view the endpoint parameters in the settings section for the appropriate data source or target.

{% endlist %}

## Updating the endpoint {#update}

{% note info %}

You cannot change the endpoint and database types. For some endpoints, you cannot change the connection type, either.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. Select an endpoint and click ![pencil](../../../_assets/pencil.svg) **{{ ui-key.yacloud.common.edit }}** in the top panel.
   1. Edit the endpoint parameters:

      {% include [Parameter list](../../../_includes/data-transfer/endpoint-param-list.md) %}

   1. Click **{{ ui-key.yacloud.common.apply }}**.

- CLI

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
      {{ yc-dt }} transfer update <endpoint type> <endpoint ID> \
         --name <endpoint name> \
         --description <endpoint description> \
         <endpoint parameters>
      ```

      You can view the endpoint type and parameters in the settings section for the appropriate data source or target. You can get the endpoint ID with a [list of endpoints in the folder](#list).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with the endpoint description.

        To learn how to create such a file, see [Create endpoint](#create).

    1. Edit the value in the `name` field (endpoint name) and the endpoint parameters under `settings`.
    1. Make sure the settings are correct.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the resources have been updated.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

    {% note info %}

    You can edit endpoints using the API only for {{ CH }}, {{ KF }}, {{ MG }}, {{ MY }}, and {{ PG }} sources and targets.

    {% endnote %}

    Use the [update](../../api-ref/Endpoint/update) API method and include the following in the request:

    * Endpoint ID in the `endpointId` parameters.
    * Endpoint name in the `name` parameter.
    * Endpoint description in the `description` parameter.
    * Endpoint parameters in the `settings` parameter.

    You can get the endpoint ID with a [list of endpoints in the folder](#list).

{% endlist %}

Editing the endpoint settings of a transfer with the {{ dt-type-repl }} type and the {{ dt-status-repl }} status will result in restarting the transfer.

## Cloning an endpoint {#clone}

{% note info %}

You cannot change the endpoint and database types when cloning.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. Select the endpoint to clone.
   1. Click **{{ ui-key.yacloud.common.clone }}** in the top panel.
   1. Specify a new endpoint name and edit other parameters, if required:

      {% include [Parameter list](../../../_includes/data-transfer/endpoint-param-list.md) %}

   1. Click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.

{% endlist %}

## Deleting an endpoint {#delete}

{% note warning %}

Before you [delete](../transfer.md#delete) an endpoint, delete all the transfers it's included in.

{% endnote %}

To delete an endpoint:

{% list tabs %}

- Management console

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
    1. Select the endpoint to delete.
    1. Click **{{ ui-key.yacloud.common.delete }}** in the top panel.
    1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To delete an endpoint, run the command:

    ```bash
    {{ yc-dt }} endpoint delete <endpoint ID>
    ```

    You can get the endpoint ID with a [list of endpoints in the folder](#list).

- {{ TF }}

    {% include [terraform-delete](../../../_includes/data-transfer/terraform-delete-endpoint.md) %}

- API

    Use the [delete](../../api-ref/Endpoint/delete) API method and provide the ID of the required endpoint in the `endpointID` request parameter.

    You can get the endpoint ID with a [list of endpoints in the folder](#list).

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
