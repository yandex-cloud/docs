# Emulating multiple IoT devices


In this scenario, you will learn to emulate multiple [devices](../../iot-core/concepts/index.md#device) that send messages to MQTT [topics](../../iot-core/concepts/topic/index.md). The example shows the emulation of air sensors that measure the following parameters:
* Temperature
* Humidity
* Pressure
* CO<sub>2</sub> level

Each sensor sends its readings in JSON format. Here is an example:

```json
{
  "DeviceId":"0e3ce1d0-1504-4325-972f-55c961319814",
  "TimeStamp":"2020-05-21T22:53:16Z",
  "Values":[{
    "Type":"Float",
    "Name":"Humidity",
    "Value":"25.281837"
  },
  {
    "Type":"Float",
    "Name":"CarbonDioxide",
    "Value":"67.96608"
  },
  {
    "Type":"Float",
    "Name":"Pressure",
    "Value":"110.7021"
  },
  {
    "Type":"Float",
    "Name":"Temperature",
    "Value":"127.708824"
  }]
}
```

To emulate the operation of multiple devices:
1. [Prepare your cloud](#before-begin).
1. [Install {{ TF }}](#install-terraform).
1. [Describe the infrastructure](#set-configuration).
1. [Deploy cloud resources](#deploy).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

## Install {{ TF }} {#install-terraform}

Using {{ TF }} in {{ yandex-cloud }}, you can create cloud resources of any type, such as [VMs](../../compute/concepts/vm.md), [disks](../../compute/concepts/disk.md), or [images](../../compute/concepts/image.md). For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

{% include [terraform_install](../_tutorials_includes/terraform-install.md) %}

## Describe the infrastructure {#set-configuration}

1. Create the `iot-terraform` directory. It will store the {{ TF }} configuration files.
1. [Download](https://{{ s3-storage-host }}/doc-files/emulator_publish.zip) the archive with the files required to run the script and unpack it to `iot-terraform`.

   The archive contains:
   * `common.tf`: {{ TF }} provider settings.
   * `files.tf`: Code file parameters to publish from the local folder.
   * `function.tf`: Parameters of a [function](../../functions/concepts/function.md) to write emulated messages to devices.
   * `iot_core.tf`: Parameters of the [registry](../../iot-core/concepts/index.md#registry) where the devices are located.
   * `output.tf.tf`: Output variables.
   * `publish`: Files required to create a function.
   * `service_account.tf`: Parameters of the [service account](../../iam/concepts/users/service-accounts.md)created by the script.
   * `trigger.tf`: Parameters of the [trigger](../../functions/concepts/trigger/index.md) to invoke a function with a specified timeout.
   * `variables.tf`: Variables used and their values.
1. Edit the `variables.tf` file, specifying the following emulation parameters:
   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md) for {{ yandex-cloud }} access.
   * `cloud_id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md).
   * `device_count`: Number of emulated devices.

      {% note info %}

      To emulate the operation of over 1000 devices, you need to increase [quotas](../../iot-core/concepts/limits.md) by making a request to technical support.

      {% endnote %}

   * `subtopic_for_publish`: [Subtopic](../../iot-core/concepts/topic/subtopic.md) in the following format: `$devices/<device_ID>/events/<subtopic>`.
   * `publish_execution_timeout`: Message send timeout in seconds.
   * `publish_cron_expression`: Schedule for sending messages to an MQTT topic as a cron expression. By default, messages send every minute.

   You can leave the remaining files unchanged.

## Deploy cloud resources {#deploy}

1. Go to the `iot-terraform` folder and check the configuration using the following command:

   ```bash
   terraform validate
   ```

   Result:

   ```text
   Success! The configuration is valid.
   ```

1. Format the configuration files in the current folder and subfolders:

   ```bash
   terraform fmt
   ```

   Result:

   ```text
   main.tf
   variables.tf
   ```

1. After checking the configuration, run the command:

   ```bash
   terraform plan
   ```

   The terminal will display a list of resources with parameters. This is a test step; no resources will be created. If the configuration contains any errors, {{ TF }} will point them out.

   {% note alert %}

   You will be charged for all the resources created with {{ TF }}. Check the pricing plan carefully.

   {% endnote %}

1. To create resources, run the command:

   ```bash
   terraform apply
   ```

1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

   Result:

   ```text
   Outputs:

   function = "d4erep.......aq085f0"
   iot_core = "are.......ht10enkb3u"
   service_account = "ajestqfepa.......0l6"
   trigger = "a1sva8sse.......7kf6"
   ```

   {{ TF }} will create all the required resources, and the terminal will display the IDs of the resources created. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

## Delete the resources you created {#clear-out}

{% list tabs group=instructions %}

- Management console {#console}

   1. Delete the registry:
      1. Go to your working [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
      1. To the right of the registry you created, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
      1. Click **{{ ui-key.yacloud.common.delete }}**.
   1. Delete the devices:
      1. Go to your working folder.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
      1. Select the registry.
      1. Go to the **{{ ui-key.yacloud.iot.label_devices }}** tab.
      1. To the right of the device you created, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
      1. Click **{{ ui-key.yacloud.common.delete }}**.
   1. Delete the function:
      1. Go to your working folder.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
      1. To the right of the function you created, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.serverless-functions.list.button_action-delete }}**.
      1. Click **{{ ui-key.yacloud.serverless-functions.list.popup-confirm_button_delete }}**.
   1. Delete the trigger:
      1. Go to your working folder.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
      1. Go to the **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** tab.
      1. To the right of the trigger you created, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
      1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.popup-confirm_button_delete }}**.
   1. Delete the service account:
      1. Go to your working folder.
      1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. To the right of the service account you created, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.iam.folder.service-accounts.button_action-delete }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.popup-confirm_button_delete }}**.

{% endlist %}