# Emulating multiple IoT devices

{% include [iot-sunset-warning](../../_includes/iot-core/sunset-warning.md) %}


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
1. [Get your cloud ready](#before-begin).
1. [Install {{ TF }}](#install-terraform).
1. [Describe the infrastructure](#set-configuration).
1. [Deploy the cloud resources](#deploy).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

## Install {{ TF }} {#install-terraform}

With {{ TF }}, you can create {{ yandex-cloud }} resources of any type, such as [VMs](../../compute/concepts/vm.md), [disks](../../compute/concepts/disk.md), or [images](../../compute/concepts/image.md). For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-link }}).

{% include [terraform_install](../_tutorials_includes/terraform-install.md) %}

## Describe the infrastructure {#set-configuration}

1. Create the `iot-terraform` folder. It will store the {{ TF }} configuration files.
1. [Download](https://{{ s3-storage-host }}/doc-files/emulator_publish.zip) an archive with the files you need for this scenario and unpack it to the `iot-terraform` directory.

   The archive contains:
   * `common.tf`: {{ TF }} provider settings.
   * `files.tf`: Parameters for publishing code files from the local directory.
   * `function.tf`: Parameters of the [function](../../functions/concepts/function.md) used to write emulated messages to devices.
   * `iot_core.tf`: Parameters of the [registry](../../iot-core/concepts/index.md#registry) where the devices are located.
   * `output.tf.tf`: Output variables.
   * `publish`: Files required to create a function.
   * `service_account.tf`: Parameters of the [service account](../../iam/concepts/users/service-accounts.md) being created in this scenario.
   * `trigger.tf`: Parameters of the [trigger](../../functions/concepts/trigger/index.md) to invoke a function with a specified timeout.
   * `variables.tf`: Applicable variables and their values.
1. Edit the `variables.tf` file specifying the following emulation parameters:
   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md) for {{ yandex-cloud }} access.
   * `cloud_id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md).
   * `device_count`: Number of emulated devices.

     {% note info %}

     To emulate the operation of over 1000 devices, you need to increase [quotas](../../iot-core/concepts/limits.md) by making a request to technical support.

     {% endnote %}

   * `subtopic_for_publish`: [Subtopic](../../iot-core/concepts/topic/subtopic.md) in `$devices/<device_ID>/events/<subtopic>` format.
   * `publish_execution_timeout`: Timeout for sending messages in seconds.
   * `publish_cron_expression`: Schedule for sending messages to an MQTT topic as a cron expression. By default, messages are sent every minute.

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

   You will see a list of resources and their properties. This is a verification step: no resources will be created. {{ TF }} will show any errors detected in the configuration.

   {% note alert %}

   You will be charged for all the resources created with {{ TF }}. Check the pricing plan carefully.

   {% endnote %}

1. To create resources, run the command:

   ```bash
   terraform apply
   ```

1. Confirm creating the resources by typing `yes` and pressing **Enter**.

   Result:

   ```text
   Outputs:

   function = "d4erep.......aq085f0"
   iot_core = "are.......ht10enkb3u"
   service_account = "ajestqfepa.......0l6"
   trigger = "a1sva8sse.......7kf6"
   ```

   {{ TF }} will create all the required resources, and the terminal will display the IDs of the resources created. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

## Delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../iot-core/operations/registry/registry-delete.md) the registry.
1. [Delete](../../iot-core/operations/device/device-delete.md) the devices.
1. [Delete](../../functions/operations/function/function-delete.md) the function.
1. [Delete the trigger](../../functions/operations/trigger/trigger-delete.md).
1. [Delete](../../iam/operations/sa/delete.md) the service account.
