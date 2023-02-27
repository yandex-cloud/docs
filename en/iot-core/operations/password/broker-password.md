---
title: "How to work with broker passwords in {{ iot-full-name }}"
description: "In this tutorial, you will learn how to get a list of broker passwords and add or delete a broker password in {{ iot-full-name }}."
---

# Managing broker passwords

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

To start exchanging messages between broker clients, you must [log in](../../concepts/authorization.md). This section describes how to manage broker passwords for the relevant authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Adding a password](#create-or-add)
* [Viewing a password list](#list)
* [Deleting a password](#delete)

## Adding a password to a broker {#create-or-add}

You can add a password to an existing broker or set it when creating a broker using the `--password` parameter.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Adding a password to an existing broker {#add}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to add a password to an existing broker.
   1. Select **{{ iot-short-name }}**.
   1. Select the broker.
   1. Under **Passwords**, click **Add password**.
   1. In the **Password** field, enter the password you will use to access the broker. To create a password, you can use the [password generator](https://passwordsgenerator.net/). Don't forget to save your password, you'll need it.
   1. Click **Add**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add a password:
   1. Get a list of brokers in the folder:

      ```
      yc iot broker list
      ```

      Result:
      ```
      +----------------------+-------------------+
      |          ID          |       NAME        |
      +----------------------+-------------------+
      | arenou2oj4********** | my-broker         |
      +----------------------+-------------------+
      ```
   1. Add a password to the broker:

      ```
      yc iot broker password add --broker-name my-broker --password Passw0rdForBroker
      ```

      Result:
      ```
      	broker_id: arenou2oj4**********
      id: areuu2hgsv6klgbd4e6d
      created_at: "2019-12-16T15:32:46.655139Z"
      ```

- API

   You can add a broker password using the API [addPassword](../../broker/api-ref/Broker/addPassword.md) method.

{% endlist %}

### Setting a password for a broker when creating it {#create}

{% list tabs %}

- Management console

   For information about how to set a password for a broker when creating it, see [{#T}](../broker/broker-create.md).

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Create a broker with a password:

   ```
   yc iot broker create --name broker-with-pass --password Passw0rdForDevice
   ```

   Result:
   ```
   	done (1s)
   id: areg96c8lo**********
   folder_id: b1g88tflru**********
   created_at: "2019-12-16T15:34:25.563Z"
   name: broker-with-pass
   status: ACTIVE
   log_group_id: ckghhil3b5**********
   ```

- API

   You can set a broker password when creating it using the API [create](../../broker/api-ref/Broker/create.md) method.

{% endlist %}

## Getting a list of broker passwords {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to get a list of broker passwords.
   1. Select **{{ iot-short-name }}**.
   1. Select the broker.
   1. On the **Overview** page, go to the **Passwords** section.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To get a list of passwords:
   1. Get a list of brokers in the folder:

      ```
      yc iot broker list
      ```

      Result:
      ```
      +----------------------+--------------------+
      |          ID          |        NAME        |
      +----------------------+--------------------+
      | areg96c8lo********** | broker-with-pass   |
      | arenou2oj4********** | my-broker          |
      +----------------------+--------------------+
      ```
   1. Get a list of broker passwords:

      ```
      yc iot broker password list --broker-name broker-with-pass
      ```

      Result:
      ```
      	+----------------------+---------------------+
      |          ID          |     CREATED AT      |
      +----------------------+---------------------+
      | are0gffs95********** | 2019-12-16 15:34:25 |
      +----------------------+---------------------+
      ```

- API

   You can get a list of broker passwords using the API [listPasswords](../../broker/api-ref/Broker/listPasswords.md) method.

{% endlist %}

## Deleting a broker password {#delete}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to delete the broker password from.
   1. Select **{{ iot-short-name }}**.
   1. Select the broker.
   1. In the row with the password you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To delete a password:
   1. Get a list of broker passwords:

      ```
      yc iot broker password list --broker-name broker-with-pass
      ```

      Result:
      ```
      	+----------------------+---------------------+
      |          ID          |     CREATED AT      |
      +----------------------+---------------------+
      | are0gffs95********** | 2019-12-16 15:34:25 |
      +----------------------+---------------------+
      ```
   1. Delete the password:

      ```
      yc iot broker password delete --broker-name broker-with-pass --password-id are0gffs957egmoksgf4
      ```
   1. Make sure that the password was deleted:

      ```
      yc iot broker password list --broker-name broker-with-pass
      ```

      Result:
      ```
      	+----+------------+
      | ID | CREATED AT |
      +----+------------+
      +----+------------+
      ```

- API

   You can delete a broker password using the API [deletePassword](../../broker/api-ref/Broker/deletePassword.md) method.

{% endlist %}