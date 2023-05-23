# Managing device passwords

For devices and registries to begin exchanging data and commands, you need to [log in](../../concepts/authorization.md). This section describes how to manage device passwords for the appropriate authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Adding a password](#create-or-add)
* [Viewing a password list](#list)
* [Deleting a password](#delete)

## Adding a password to a device {#create-or-add}

You can add a password to an already created device or set it when creating a device using the `--password` parameter.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Adding a password to an existing device {#add}

{% list tabs %}

- Management console

   To add a password to an existing device:

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to set a password for a previously created device.
   1. Select **{{ iot-short-name }}**.
   1. Select the registry with the desired device from the list.
   1. In the left part of the window, select **Devices**.
   1. Select the desired device from the list.
   1. Under **Passwords**, click **Add password**.
   1. In the **Password** field, enter the password you will be using to access your device.<br/>You can use a [password generator](https://passwordsgenerator.net/) to create a password.<br/>Make sure you save the password - you will need it later.
   1. Click **Add**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   To add a password:
   1. Get a list of devices in the registry:

      ```
      yc iot device --registry-name my-registry list
      ```

      Result:
      ```
      +----------------------+--------+
      |          ID          |  NAME  |
      +----------------------+--------+
      | arenak5ciqss6pbas5tm | second |
      | areqjd6un3afc3cefuio | first  |
      +----------------------+--------+
      ```
   1. Add a password to the device:

      ```
      yc iot device password add --device-name first --password Passw0rdForDevice
      ```

      Result:
      ```
      device_id: areqjd6un3afc3cefcvm
      id: areqjd6un3afc3cefuio
      created_at: "2019-12-16T15:11:36.892167Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add a password to a device created using {{ TF }}:

   1. In the configuration file, describe the parameters of the resource to create:

      * `yandex_iot_core_device`: Device parameters:
         * `registry_id`: [ID of the registry](../registry/registry-list.md#registry-list) where the device was created.
         * `name`: [Device name](../device/device-list.md#device-list).
         * `description`: Device description.
         * `passwords`: List of passwords for authorization using a [username and password](../../concepts/authorization.md#log-pass).

      Sample resource structure in the configuration file:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry_ID>"
        name        = "<device_name>"
        description = "test device for terraform provider documentation"
      ...
        passwords = [
          "<password>",
        ]
      ...
      }
      ```

      For more information about the `yandex_iot_core_device` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_device).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify device passwords in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device password list --device-name <device_name>
      ```

- API

   To add a password to a device, use the [addPassword](../../api-ref/Device/addPassword.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/AddPassword](../../api-ref/grpc/device_service.md#AddPassword) gRPC API call.

{% endlist %}

### Setting a password for a device when creating it {#create}

{% list tabs %}

- Management console

   For information on setting a password for a device being created, see [{#T}](../device/device-create.md).

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To set a password when creating a device:
   1. Get a list of registries in the folder:

      ```
      yc iot registry list
      ```

      Result:
      ```
      +----------------------+-------------------+
      |          ID          |       NAME        |
      +----------------------+-------------------+
      | arenou2oj4ct42eq8f4m | my-registry       |
      +----------------------+-------------------+
      ```
   1. Create a device with a password:

      ```
      yc iot device create --registry-name my-registry --name device-with-pass --password Passw0rdForDevice
      ```

      Result:
      ```
      id: arepomfambsg5biqc25n
      registry_id: arenou2oj4ct42eq8g3n
      created_at: "2019-12-16T15:18:39.358922Z"
      name: device-with-pass
      ```

- {{ TF }}

   For information on setting a password for a device being created, see [{#T}](../device/device-create.md).

- API

   To set a password for a device when creating it, use the [create](../../api-ref/Device/create.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/Create](../../api-ref/grpc/device_service.md#Create) gRPC API call.

{% endlist %}

## Getting a list of device passwords {#list}

{% list tabs %}

- Management console

   To view the list of device passwords:

   1. In the [management console]({{ link-console-main }}), select the folder to get the list of device passwords for.
   1. Select **{{ iot-short-name }}**.
   1. Select the registry with the desired device from the list.
   1. In the left part of the window, select **Devices**.
   1. Select the desired device from the list.
   1. On the **Overview** page, go to the **Passwords** section.

   The list of device passwords is displayed in the **Passwords** section.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To get a list of passwords:
   1. Get a list of devices in the registry:

      ```
      yc iot device --registry-name my-registry list
      ```

      Result:
      ```
      +----------------------+------------------+
      |          ID          |       NAME       |
      +----------------------+------------------+
      | arenak5ciqss6pbas5tm | second           |
      | arepomfambsg5biqc77p | device-with-pass |
      | areqjd6un3afc3cefuio | first            |
      +----------------------+------------------+
      ```
   1. Get a list of device passwords:

      ```
      yc iot device password list --device-name device-with-pass
      ```

      Result:
      ```
      +----------------------+---------------------+
      |          ID          |     CREATED AT      |
      +----------------------+---------------------+
      | areuin5t7pndvlj6n4tr | 2019-12-16 15:18:39 |
      +----------------------+---------------------+
      ```

- API

   To get a list of device passwords, use the [listPasswords](../../api-ref/Device/listPasswords.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/ListPasswords](../../api-ref/grpc/device_service.md#ListPasswords) gRPC API call.

{% endlist %}

## Deleting a device password {#delete}

{% list tabs %}

- Management console

   To delete a device password:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the device password from.
   1. Select **{{ iot-short-name }}**.
   1. Select the registry with the desired device from the list.
   1. In the left part of the window, select **Devices**.
   1. Select the desired device from the list.
   1. In the row with the password you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To delete a password:
   1. Get a list of device passwords:

      ```
      yc iot device password list --device-name device-with-pass
      ```

      Result:
      ```
      +----------------------+---------------------+
      |          ID          |     CREATED AT      |
      +----------------------+---------------------+
      | areuin5t7pndvlj6n4tr | 2019-12-16 15:18:39 |
      +----------------------+---------------------+
      ```
   1. Delete the password:
      ```
      yc iot device password delete --device-name device-with-pass --password-id areuin5t7pndvlj6n4tr
      ```
   1. Make sure that the password was deleted:

      ```
      yc iot device password list --device-name device-with-pass
      ```

      Result:
      ```
      +----+------------+
      | ID | CREATED AT |
      +----+------------+
      +----+------------+
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete the password of a device created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the value of the password in the `passwords` block, in the fragment with the device description. To delete all passwords, delete the entire `passwords` block.

      Example device description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry_ID>"
        name        = "<device_name>"
        description = "test device for terraform provider documentation"
      ...
        passwords = [
          "<password>",
        ]
      ...
      }
      ```

      For more information about the `yandex_iot_core_device` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_device).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify device passwords in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device password list --device-name <device_name>
      ```

- API

   To delete a device password, use the [deletePassword](../../api-ref/Device/deletePassword.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/DeletePassword](../../api-ref/grpc/device_service.md#DeletePassword) gRPC API call.

{% endlist %}