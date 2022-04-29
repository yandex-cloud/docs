# Managing registry passwords

For devices and registries to begin exchanging data and commands, you need to [log in](../../concepts/authorization.md). This section describes how to manage registry passwords for the appropriate authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Adding a password](#create-or-add)
* [Viewing a password list](#list)
* [Deleting a password](#delete)

## Adding a password to a registry {#create-or-add}

You can add a password to an existing registry or set it when creating a registry using the `--password` parameter.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Adding a password to an existing registry {#add}

{% list tabs %}

- Management console

   To add a password to an existing registry:

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to set a password for a previously created registry.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. Under **Passwords**, click **Add password**.
   1. In the **Password** field, enter the password you will be using to access your registry.<br/>You can use a [password generator](https://passwordsgenerator.net/) to create a password.<br/>Make sure you save the password - you will need it later.
   1. Click **Add**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   To add a password:
   1. Get a list of registries in the folder:

      ```
      yc iot registry list
      ```

      Result:
      ```
      +----------------------+-------------------+
      |          ID          |       NAME        |
      +----------------------+-------------------+
      | arenou2oj4ct42eq82er | my-registry       |
      +----------------------+-------------------+
      ```
   1. Add a password to the registry:

      ```
      yc iot registry password add --registry-name my-registry --password Passw0rdForRegistry
      ```

      Result:
      ```
      registry_id: arenou2oj4ct42eq8g3n
      id: areuu2hgsv6klgbd4e6d
      created_at: "2019-12-16T15:32:46.655139Z"
      ```

{% endlist %}

### Setting a password for a registry when creating it {#create}

{% list tabs %}

- Management console

   To lean about setting a password for a registry being created, please see [{#T}](../registry/registry-create.md).

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Create a registry with a password:

   ```
   yc iot registry create --name registry-with-pass --password Passw0rdForDevice
   ```

   Result:
   ```
   done (1s)
   id: areg96c8loruvvudj54t
   folder_id: b1g88tflru0ek1omtfd3
   created_at: "2019-12-16T15:34:25.563Z"
   name: registry-with-pass
   status: ACTIVE
   log_group_id: ckghhil3b5o9t4pf1nvg
   ```

{% endlist %}

## Getting a list of registry passwords {#list}

{% list tabs %}

- Management console

   To view the list of registry passwords:

   1. In the [management console]({{ link-console-main }}), select the folder to get the list of registry passwords for.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. On the **Overview** page, go to the **Passwords** section.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To get a list of passwords:
   1. Get a list of registries in the folder:

      ```
      yc iot registry list
      ```

      Result:
      ```
      +----------------------+--------------------+
      |          ID          |        NAME        |
      +----------------------+--------------------+
      | areg96c8loruvvudj54t | registry-with-pass |
      | arenou2oj4ct42eq82er | my-registry        |
      +----------------------+--------------------+
      ```
   1. Get a list of registry passwords:

      ```
      yc iot registry password list --registry-name registry-with-pass
      ```

      Result:
      ```
      +----------------------+---------------------+
      |          ID          |     CREATED AT      |
      +----------------------+---------------------+
      | are0gffs957egmoksgf4 | 2019-12-16 15:34:25 |
      +----------------------+---------------------+
      ```

{% endlist %}

## Deleting a registry password {#delete}

{% list tabs %}

- Management console

   To delete a registry password:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the registry password from.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the row with the password you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To delete a password:
   1. Get a list of registry passwords:

      ```
      yc iot registry password list --registry-name registry-with-pass
      ```

      Result:
      ```
      +----------------------+---------------------+
      |          ID          |     CREATED AT      |
      +----------------------+---------------------+
      | are0gffs957egmoksgf4 | 2019-12-16 15:34:25 |
      +----------------------+---------------------+
      ```
   1. Delete the password:

      ```
      yc iot registry password delete --registry-name registry-with-pass --password-id are0gffs957egmoksgf4
      ```
   1. Make sure that the password was deleted:

      ```
      yc iot registry password list --registry-name registry-with-pass
      ```

      Result:
      ```
      +----+------------+
      | ID | CREATED AT |
      +----+------------+
      +----+------------+
      ```

{% endlist %}
