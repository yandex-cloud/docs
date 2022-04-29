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

{% endlist %}
