# Managing device passwords

For devices and registries to begin exchanging data and commands, you need to [log in](../../concepts/authorization.md). This section describes how to manage device passwords for the appropriate authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Adding a password](#create-or-add)
* [Viewing a list of passwords](#list)
* [Deleting a password](#delete)

## Adding a password to a device {#create-or-add}

You can add a password to an already created device or set it when creating a device using the `--password` parameter.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Adding a password to an existing device {#add}

{% list tabs %}

- Management console

   To add a password to an existing device:
   1. In the [management console]({{ link-console-main }}), select the folder where you want to add a password to an existing device.
   1. Select **{{ iot-name }}**.
   1. Select the registry with the desired device from the list.
   1. In the left part of the window, select **Devices**.
   1. Select the desired device from the list.
   1. Under **Passwords**, click **Add password**.
   1. In the **Password** field, set a password that you'll use to access the device.<br/>To do this, you can use a [password generator](https://passwordsgenerator.net/).<br/>Don't forget to save your password because you'll need it later.
   1. Click **Add**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    To add a password:

    1. Get a list of devices in the registry:

        ```
        $ yc iot device --registry-name my-registry list
        +----------------------+--------+
        |          ID          |  NAME  |
        +----------------------+--------+
        | arenak5ciqss6pbas5tm | second |
        | areqjd6un3afc3cefuio | first  |
        +----------------------+--------+
        ```

    1. Add a password to the device:

        ```
        $ yc iot device password add --device-name first --password Passw0rdForDevice
        device_id: areqjd6un3afc3cefcvm
        id: areqjd6un3afc3cefuio
        created_at: "2019-12-16T15:11:36.892167Z"
        ```

{% endlist %}

### Setting a password for a device when creating it {#create}

{% list tabs %}

- Management console

   For information about how to set a password for a device when creating it, see [{#T}](../device/device-create.md).

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To set a password when creating a device:

    1. Get a list of registries in the folder:

        ```
        $ yc iot registry list
        +----------------------+-------------------+
        |          ID          |       NAME        |
        +----------------------+-------------------+
        | arenou2oj4ct42eq8f4m | my-registry       |
        +----------------------+-------------------+
        ```

    1. Create a device with a password:

        ```
        $ yc iot device create --registry-name my-registry --name device-with-pass --password Passw0rdForDevice
        id: arepomfambsg5biqc25n
        registry_id: arenou2oj4ct42eq8g3n
        created_at: "2019-12-16T15:18:39.358922Z"
        name: device-with-pass
        ```

{% endlist %}

## Getting a list of device passwords {#list}

{% list tabs %}

- Management console

   To view the list of device passwords:
   1. In the [management console]({{ link-console-main }}), select the folder where you want to get a list of device passwords.
   1. Select **{{ iot-name }}**.
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
        $ yc iot device --registry-name my-registry list
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
        $ yc iot device password list --device-name device-with-pass
        +----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | areuin5t7pndvlj6n4tr | 2019-12-16 15:18:39 |
        +----------------------+---------------------+
        ```

{% endlist %}

## Deleting a device password {#delete}

{% list tabs %}

- Management console

   To delete a device password:
   1. In the [management console]({{ link-console-main }}), select the folder to delete a device password from.
   1. Select **{{ iot-name }}**.
   1. Select the registry with the desired device from the list.
   1. In the left part of the window, select **Devices**.
   1. Select the desired device from the list.
   1. To the right of the password to delete, click ![image](../../../_assets/horizontal-ellipsis.svg), and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To delete a password:

    1. Get a list of device passwords:

        ```
        $ yc iot device password list --device-name device-with-pass
        +----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | areuin5t7pndvlj6n4tr | 2019-12-16 15:18:39 |
        +----------------------+---------------------+
        ```

    1. Delete the password:

        ```
        $ yc iot device password delete --device-name device-with-pass --password-id areuin5t7pndvlj6n4tr
        ```

    1. Make sure that the password was deleted:

        ```
        $ yc iot device password list --device-name device-with-pass
        +----+------------+
        | ID | CREATED AT |
        +----+------------+
        +----+------------+
        ```

{% endlist %}