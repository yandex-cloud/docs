# Managing labels

You can add, delete, or update resource [labels](../concepts/labels.md#services) in the management console, {{ yandex-cloud }} CLI, and {{ TF }}.

Labels are supported in certain [services](../concepts/labels.md#services). Label management in some services, such as [{{ objstorage-name }}](../../storage/operations/buckets/tagging.md), may be different.

## Adding a label {#add-label}

{% list tabs group=instructions %}

- Management console {#console}

   The example below shows how to add a label to a {{ compute-name }} VM instance. You can add a label to another resource in the same way.

   1. In the [management console]({{ link-console-main }}), select the folder where the VM is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
   1. Select the VM you need from the list.
   1. Click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
   1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
   1. Specify the key and value and press **Enter**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a label to a service resource, use this command:

   ```
   yc <service_name> <resource_type> add-labels <resource_name_or_ID> \
     --labels <label_name>=<label_value>
   ```

   **Example**

   Adding a label to a VM:

   > ```
   > yc compute instance add-labels cl123g4dridnn5cn****-**** --labels project=test
   > ```
   >
   > Result:
   >
   > ```
   > done (5s)
   > id: fhm1pr2bu3p4********
   > folder_id: b1g23ga45mev********
   > created_at: "2020-08-07T11:29:18Z"
   > name: cl123g4dridnn5cn****-****
   > labels:
   >   project: test
   > zone_id: {{ region-id }}-a
   > ...
   > ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, add the following fragment to the resource:

      ```
        labels = {
          <label_key> = "<label_value>"
        }
      ```

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   That will add the label to the resource. You can check the new label using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

   ```
   yc <service_name> <resource_type> get <resource_name_or_ID>
   ```

   **Example**

   Defining a label for a {{ lockbox-name }} secret:

   > ```
   > resource "yandex_lockbox_secret" "my_secret" {
   >   name   = lockbox-test-secret
   >   labels = {
   >     label-test-key = "label-test-value"
   >   }
   > }
   > ```

{% endlist %}

You can create a label with multiple values. For example, create a label named `my-cloud` with the following values:

* `my-vm`: For your VM instance.
* `my-disk`: For your disk.

## Editing a label {#update-label}

You can only edit a label using the {{ yandex-cloud }} CLI and {{ TF }}.

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% note warning %}

   The existing set of `labels` is completely overwritten by the transmitted set.

   {% endnote %}

   To edit a label of a service resource, use this command:

   ```
   yc <service_name> <resource_type> update < resource_name_or_ID> \
     --labels <label_name>=<label_value>
   ```

   **Example**

   Editing labels for {{ k8s }} cluster:

   > ```
   > yc managed-kubernetes cluster update k8s-gpu --labels new_lable=test_label
   > ```
   >
   > Result:
   >
   > ```
   > done (1m36s)
   > id: cat1hknor234********
   > folder_id: b1g23ga45mev********
   > created_at: "2020-08-07T11:15:59Z"
   > name: cluster
   > labels:
   >   new_lable: test_label
   > status: RUNNING
   > ...
   > ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, find the following fragment:

      ```
        labels = {
          <label_key> = "<label_value>"
        }
      ```

   1. Update both the key and the value.
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   After that, the label for the resource will be updated. You can check the label update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

   ```
   yc <service_name> <resource_type> get <resource_name_or_ID>
   ```

{% endlist %}

## Deleting a label {#remove-label}

{% list tabs group=instructions %}

- Management console {#console}

   The example below shows how to delete a label from a {{ compute-name }} VM. You can delete a label from another resource in the same way.

   1. In the [management console]({{ link-console-main }}), select the folder where the VM is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
   1. Select the VM you need from the list.
   1. Click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
   1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, select the label in question and click ![cross](../../_assets/console-icons/xmark.svg) next to its name.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Delete a service resource label:

   ```
   yc <service_name> <resource_type> remove-labels <resource_name_or_ID> \
     --labels <label_name>
   ```

   **Example**

   Removing a label from a {{ mmy-short-name }} cluster:

   > ```
   > yc managed-mysql cluster remove-labels mysql123 --labels my_lable
   > ```
   >
   > Result:
   >
   > ```
   > id: c1qmjaatlurm********
   > folder_id: b1g23ga45mev********
   > created_at: "2020-08-20T11:53:20.015543Z"
   > name: mysql123
   > environment: PRODUCTION
   > ...
   > ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, find the following fragment:

      ```
        labels = {
          <label_key> = "<label_value>"
        }
      ```

   1. Delete the fragment.
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   After that, the label will be removed from the resource. You can check the deletion of the label using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

   ```
   yc <service_name> <resource_type> get <resource_name_or_ID>
   ```

{% endlist %}
