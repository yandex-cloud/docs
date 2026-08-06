---
title: How to update a broker
description: Follow this guide to update a broker.
---

# Updating a broker

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

You can update a broker [name](broker-update.md#update-name) or [description](broker-update.md#update-description), as well as [manage broker labels](broker-update.md#manage-label).

To access a broker, use its unique ID or name. For info on how to get the unique broker ID or name, see [{#T}](broker-list.md).

## Updating a broker name {#update-name}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update the broker name.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. To the right of the name of your broker, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. Edit the **{{ ui-key.yacloud.common.name }}** field.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Update the broker name:

  ```bash
  yc iot broker update my-broker --new-name test-broker
  ```

  Result:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: test-broker
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To update the name of a broker created with {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the `name` parameter value in the broker description.

      Here is an example of a broker description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        }
      ...
      }
      ```

      For more information about `yandex_iot_core_broker` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_broker).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Type `yes` and press **Enter** to confirm the changes.

      You can check the updated broker name using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker list
      ```

- API {#api}

  To update a broker name, use the [update](../../broker/api-ref/Broker/update.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md) gRPC API call.

{% endlist %}

## Updating a broker description {#update-description}

{% list tabs group=instructions %}

- Management console {#console}

   To update a broker description:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update the broker description.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. To the right of the name of your broker, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. Edit the **{{ ui-key.yacloud.common.description }}** field.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Update the broker description:

  ```bash
  yc iot broker update my-broker --description "My test broker."
  ```

  Result:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  description: My test broker.
  labels:
    test_label: my_broker_label
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To update the description of a broker created with {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the `description` parameter value in the broker description.

      Here is an example of a broker description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        }
      ...
      }
      ```

      For more information about `yandex_iot_core_broker` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_broker).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Type `yes` and press **Enter** to confirm the changes.

      You can check the updated broker description using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker get <broker_name>
      ```

- API {#api}

  To update a broker description, use the [update](../../broker/api-ref/Broker/update.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md) gRPC API call.

{% endlist %}

## Managing broker labels {#manage-label}

You can manage broker labels in the following ways:

* [Add](broker-update.md#add-label)
* [Edit](broker-update.md#update-label)
* [Delete](broker-update.md#remove-label)

### Adding a label {#add-label}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to add a broker label.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. To the right of the name of your broker, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. Fill out the **{{ ui-key.yacloud.component.key-values-input.label_key }}** and **{{ ui-key.yacloud.component.key-values-input.label_value }}** fields and click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Add a broker label:

  ```bash
  yc iot broker add-labels my-broker --labels new_label=test_label
  ```

  Result:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  labels:
    new_label: test_label
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To add a label to a broker created with {{ TF }}:

  1. In the configuration file, describe the resource you want to create:

     * `yandex_iot_core_broker`: Broker settings:
       * `name`: Broker name.
       * `description`: Broker description.
       * `labels`: Broker labels in `key:value` format.

      Here is an example of a resource structure in the configuration file:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        labels = {
          new-label = "test-label"
        }
      ...
      }
      ```

      For more information about `yandex_iot_core_broker` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_broker).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Type `yes` and press **Enter** to confirm the changes.

      You can check broker labels using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker get <broker_name>
      ```

- API {#api}

  To add a label to a broker, use the [update](../../broker/api-ref/Broker/update.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md) gRPC API call.

{% endlist %}

### Updating a label {#update-label}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update a broker label.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. To the right of the name of your broker, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. Edit the **{{ ui-key.yacloud.component.key-values-input.label_key }}** and **{{ ui-key.yacloud.component.key-values-input.label_value }}** fields.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Update a broker label:

  {% include [labels-rewrite-warning](../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc iot broker update my-broker --labels test_label=my_broker_label
  ```

  Result:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  labels:
    test_label: my_broker_label
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To update a label of a broker created with {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the label value in the `labels` section of the broker description.

      Here is an example of a broker description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        labels = {
          test-label = "my-broker-label"
        }
      ...
      }
      ```

      For more information about `yandex_iot_core_broker` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_broker).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Type `yes` and press **Enter** to confirm the changes.

      You can check broker labels using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker get <broker_name>
      ```

- API {#api}

  To update a broker label, use the [update](../../broker/api-ref/Broker/update.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md) gRPC API call.

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a broker label.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. To the right of the name of your broker, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. To the right of the label to delete, click ![image](../../../_assets/console-icons/xmark.svg).
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Delete a broker label:

  ```bash
  yc iot broker remove-labels my-broker --labels new_label
  ```

  Result:
  ```text
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-broker
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a label of a broker created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the label value from the `labels` section of the broker description. To delete all labels, delete the entire `labels` section.

      Here is an example of a broker description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        labels = {
          test-label = "my-broker-label"
        }
      ...
      }
      ```

      For more information about `yandex_iot_core_broker` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_broker).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Type `yes` and press **Enter** to confirm the changes.

      You can check broker labels using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot broker get <broker_name>
      ```

- API {#api}

  To delete a broker label, use the [update](../../broker/api-ref/Broker/update.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/Update](../../broker/api-ref/grpc/Broker/update.md) gRPC API call.

{% endlist %}