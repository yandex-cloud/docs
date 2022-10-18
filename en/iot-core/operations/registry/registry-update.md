# Updating a registry

You can edit a registry [name](registry-update.md#update-name) or [description](registry-update.md#update-description) and [manage registry labels](registry-update.md#manage-label).

To access a registry, use its unique ID or name. For information on retrieving the unique registry ID or name, see [{#T}](registry-list.md).

## Updating the name of a registry {#update-name}

{% list tabs %}

- Management console

   To update the name of a registry:

   1. In the [management console]({{ link-console-main }}), select the folder to update the registry name in.
   1. Select **{{ iot-short-name }}**.
   1. To the right of the name of the registry you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. Edit the **Name** field.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Change the registry name:

   ```
   yc iot registry update my-registry --new-name test-registry
   ```

   Result:
   ```
   id: b91ki3851hab9m0l68je
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-05-28T11:29:42.420Z"
   name: test-registry
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update the name of a registry created using {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the value of the `name` parameter in the fragment with the registry description.

      Example registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        }
      ...
      }
      ```

      For more information about the `yandex_iot_core_registry` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_registry).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify the updated registry name in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry list
      ```

{% endlist %}

## Updating the description of a registry {#update-description}

{% list tabs %}

- Management console

   To update the description of a registry:

   1. In the [management console]({{ link-console-main }}), select the folder to update the registry description in.
   1. Select **{{ iot-short-name }}**.
   1. To the right of the name of the registry you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. Edit the **Description** field.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Change the registry description:

   ```
   yc iot registry update my-registry --description "My test registry."
   ```

   Result:
   ```
   id: b91ki3851hab9m0l68je
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-05-28T11:29:42.420Z"
   name: my-registry
   description: My test registry.
   labels:
     test_label: my_registry_label
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update the description of a registry created using {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the value of the `description` parameter in the fragment with the registry description.

      Example registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        }
      ...
      }
      ```

      For more information about the `yandex_iot_core_registry` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_registry).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify the updated registry description in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry get <registry_name>
      ```

{% endlist %}

## Managing registry labels {#manage-label}

You can perform the following actions related to registry labels:

* [Add](registry-update.md#add-label).
* [Edit](registry-update.md#update-label).
* [Delete](registry-update.md#remove-label).

### Adding a label {#add-label}

{% list tabs %}

- Management console

   To add a registry label:

   1. In the [management console]({{ link-console-main }}), select the folder to add the registry label to.
   1. Select **{{ iot-short-name }}**.
   1. To the right of the name of the registry you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. Fill in the **Key** and **Value** fields and click **Add label**.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Add a label to a registry:

   ```
   yc iot registry add-labels my-registry --labels new_label=test_label
   ```

   Result:
   ```
   id: b91ki3851hab9m0l68je
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-05-28T11:29:42.420Z"
   name: my-registry
   labels:
     new_label: test_label
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add a label to a registry created using {{ TF }}:

   1. In the configuration file, describe the parameters of the resource to create:

      * `yandex_iot_core_registry`: Registry parameters:
         * `name`: Registry name.
         * `description`: Registry description.
         * `labels`: Registry labels in `key:value` format.

      Sample resource structure in the configuration file:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        labels = {
          new-label = "test-label"
        }
      ...
      }
      ```

      For more information about the `yandex_iot_core_registry` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_registry).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify registry labels using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry get <registry_name>
      ```

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- Management console

   To update the label of a registry:

   1. In the [management console]({{ link-console-main }}), select the folder to update the registry label in.
   1. Select **{{ iot-short-name }}**.
   1. To the right of the name of the registry you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. Edit the **Key** and **Value** fields.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Change a registry label:

   {% note warning %}

   The existing set of `labels` is completely replaced by the set transmitted.

   {% endnote %}

   ```
   yc iot registry update my-registry --labels test_label=my_registry_label
   ```

   Result:
   ```
   id: b91ki3851hab9m0l68je
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-05-28T11:29:42.420Z"
   name: my-registry
   labels:
     test_label: my_registry_label
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update the label of a registry created using {{ TF }}:

   1. Open the {{ TF }} configuration file and update the value of the label in the `labels` block, in the fragment with the registry description.

      Example registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        labels = {
          test-label = "my-registry-label"
        }
      ...
      }
      ```

      For more information about the `yandex_iot_core_registry` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_registry).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify registry labels using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry get <registry_name>
      ```

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- Management console

   To delete a registry label:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the registry label from.
   1. Select **{{ iot-short-name }}**.
   1. To the right of the name of the registry you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. To the right of the label to delete, click ![image](../../../_assets/cross.svg).
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Delete a registry label:

   ```
   yc iot registry remove-labels my-registry --labels new_label
   ```

   Result:
   ```
   id: b91ki3851hab9m0l68je
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-05-28T11:29:42.420Z"
   name: my-registry
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete the label of a registry created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the value of the label in the `labels` block, in the fragment with the registry description. To remove all labels, delete the entire `labels` block.

      Example registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        labels = {
          test-label = "my-registry-label"
        }
      ...
      }
      ```

      For more information about the `yandex_iot_core_registry` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_registry).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify registry labels using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry get <registry_name>
      ```

{% endlist %}