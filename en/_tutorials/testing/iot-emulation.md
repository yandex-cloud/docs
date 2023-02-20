# Emulating multiple IoT devices

In this scenario, you will learn to emulate many devices that send messages to MQTT topics. The example shows the emulation of air sensors that measure the following parameters:

* Temperature.
* Humidity.
* Pressure.
* CO<sub>2</sub> levels.

Each sensor sends its result in JSON format. For example:

```json
{
 "DeviceId":"0e3ce1d0-1504-4325-972f-55c961319814",
 "TimeStamp":"2020-05-21T22:53:16Z",
 "Values":[
     {"Type":"Float","Name":"Humidity","Value":"25.281837"},
     {"Type":"Float","Name":"CarbonDioxide","Value":"67.96608"},
     {"Type":"Float","Name":"Pressure","Value":"110.7021"},
     {"Type":"Float","Name":"Temperature","Value":"127.708824"}
     ]
}
```

To emulate the operation of multiple devices:

1. [Before you start](#before-begin).
1. [Install {{ TF }}](#install-terraform).
1. [Describe the infrastructure](#set-configuration).
1. [Deploy cloud resources](#deploy).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

## Install {{ TF }} {#install-terraform}

By using {{ TF }} in {{ yandex-cloud }}, you can create all kinds of cloud resources, such as VMs, disks, and images. For more information about resources that can be created with {{ TF }}, see the [provider's documentation]({{ tf-provider-link }}).

{% include [terraform_install](../terraform-install.md) %}

## Describe the infrastructure {#set-configuration}

1. Create the `iot-terraform` directory. It will store the {{ TF }} configuration files.

1. [Download](https://{{ s3-storage-host }}/doc-files/emulator_publish.zip) an archive containing the files that you will needed to execute the script, and unpack it to `iot-terraform`.

   The archive contains:
    * `common.tf`: {{ TF }} provider settings.
    * `files.tf`: Code file parameters to publish from the local folder.
    * `function.tf`: Parameters of a [function](../../functions/concepts/function.md) to write emulated messages to [devices](../../iot-core/concepts/index.md#device).
    * `iot_core.tf`: Parameters of the [registry](../../iot-core/concepts/index.md#registry) where the devices are located.
    * `output.tf.tf`: Output variables.
    * `publish`: Files required to create a function.
    * `service_account.tf`: Parameters of the [service account](../../iam/concepts/users/service-accounts.md) created by the script.
    * `trigger.tf`: Parameters of the [trigger](../../functions/concepts/trigger/index.md) to invoke a function with a specified timeout.
    * `variables.tf`: Variables used and their values.

1. Edit the `variables.tf` file, specifying the following emulation parameters:

    * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md) to access {{ yandex-cloud }}.
    * `cloud_id`: cloud ID.
    * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md).
    * `zone`: The [availability zone](../../overview/concepts/geo-scope.md).
    * `device_count`: number of emulated devices.

        {% note info %}

        To emulate the operation of over 1000 devices, you need to increase [quotas](../../iot-core/concepts/limits.md) by making a request to technical support.

        {% endnote %}

    * `subtopic_for_publish`: [subtopic](../../iot-core/concepts/topic/subtopic.md) in the following format: `$devices/<device ID>/events/<subtopic>`.
    * `publish_execution_timeout`: message send timeout in seconds.
    * `publish_cron_expression`: schedule for sending messages to an MQTT topic as a cron expression. By default, messages send every minute.

    You can leave the remaining files unchanged.

## Deploy cloud resources {#deploy}

1. Go to the `iot-terraform` folder and check the configuration using the following command:

   ```
   terraform validate
   ```

   Result:

   ```
   Success! The configuration is valid.
   ```

1. Format the configuration files in the current folder and subfolders:

   ```
   terraform fmt
   ```

   Result:

   ```
   main.tf
   variables.tf
   ```

1. After checking the configuration, run the command:

   ```
   terraform plan
   ```

   The terminal will display a list of resources with parameters. This is a test step. No resources are created. If there are errors in the configuration, {{ TF }} points them out.

     {% note alert %}

     You're charged for all resources created using {{ TF }}. Check the plan carefully.

     {% endnote %}

1. To create resources, run the command:

   ```
   terraform apply
   ```

1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

   Result:

   ```
   Outputs:
   
   function = "d4erep.......aq085f0"
   iot_core = "are.......ht10enkb3u"
   service_account = "ajestqfepa.......0l6"
   trigger = "a1sva8sse.......7kf6"
   ```

   {{ TF }} will create all the required resources, and the terminal will display the IDs of the resources created. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

## Delete the resources created {#clear-out}

{% list tabs %}

- Management console

  1. Delete the registry:
      1. Go to your working folder.
      1. In the list of services, select **{{ iot-full-name }}**.
      1. To the right of the registry created, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.
  1. Delete devices:
      1. Go to your working folder.
      1. In the list of services, select **{{ iot-full-name }}**.
      1. Select the registry.
      1. Go to the **Devices** tab.
      1. To the right of the name of the device created, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.
  1. Delete the function:
      1. Go to your working folder.
      1. In the list of services, select **{{ sf-name }}**.
      1. To the right of the function name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.
  1. Delete the trigger:
      1. Go to your working folder.
      1. In the list of services, select **{{ sf-name }}**.
      1. Go to the **Triggers** tab.
      1. To the right of the name of the trigger created, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.
  1. Delete the service account:
      1. Go to your working folder.
      1. In the left pane, select **Service accounts**.
      1. To the right of the service account name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.

{% endlist %}
