---
title: Updating {{ VLK }} user settings in {{ mrd-full-name }}
description: You can update {{ VLK }} user settings in {{ mrd-name }}.
---

# Updating user settings

After creating a {{ VLK }} user, you can:

* [Change the password](#change-password).
* [Change the user status](#change-status).
* [Configure data cleanup](#change-sanitize-payload).
* [Assign user permissions](#change-permissions).

## Changing a user password {#change-password}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  
    
  1. Set a user password in one of the following ways:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Enter a password manually. It must be from 8 to 128 characters long.
      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password using [{{ connection-manager-full-name }}](../../metadata-hub/concepts/connection-manager.md) and store it in a [{{ lockbox-full-name }} secret](../../lockbox/concepts/secret.md).

        To view the password, navigate to the cluster page, select the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-full-name }} secret containing the password.

        You need the [lockbox.payloadViewer](../../lockbox/security/index.md#lockbox-payloadViewer) role to view passwords.


  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change a {{ VLK }} user password:

  1. View the description of the CLI command for updating user settings:

      ```bash
      {{ yc-mdb-rd }} user update --help
      ```

  1. Change the password by running this command:

      ```bash
      {{ yc-mdb-rd }} user update <username> \
        --cluster-id=<cluster_ID> \
        --password="<user_password>" 
      ```

      Where:

      * `--cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `--password`: User password. It must be from 8 to 128 characters long.

      You can get the username with the [list of users](user-list.md#list) in the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      For more on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Update the `passwords` argument in the `yandex_mdb_redis_user` resource description:

      ```hcl
      resource "yandex_mdb_redis_user" "<local_resource_name>" {
        ...
        passwords = [ "<user_password>" ]
      }
      ```

      Where `passwords` is the user password. It must be from 8 to 128 characters long.

      You can specify only one password.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "updateMask": "passwords",
        "passwords": [
          "<user_password>"
        ]
      }
      ```

      Where:

      * `updateMask`: Comma-separated string of settings you want to update.

        {% include [update-mask-note-rest](../../_includes/mdb/mvk/update-mask-note-rest.md) %}

      * `passwords`: User password. It must be from 8 to 128 characters long.

        You can specify only one password.

  1. Call the [User.Update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/users/<username>' \
        --data "@body.json"
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      You can get the username with the [list of users](user-list.md#list) in the cluster.

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "cluster_id": "<cluster_ID>",
        "user_name": "<username>",
        "update_mask": {
          "paths": [
            "passwords"
          ]
        },
        "passwords": [
          "<user_password>"
        ]
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `user_name`: Username.

        You can get the username with the [list of users](user-list.md#list) in the cluster.

      * `update_mask`: List of settings to update as an array of strings (`paths[]`).

        {% cut "Format for listing settings" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<setting_1>",
              "<setting_2>",
              ...
              "<setting_N>"
            ]
          }
          ```

        {% endcut %}

        {% include [update-mask-note-grpc](../../_includes/mdb/mvk/update-mask-note-grpc.md) %}

      * `passwords`: Password. It must be from 8 to 128 characters long.

        You can specify only one password.  

  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.UserService.Update \
        < body.json
        ```

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing a user status {#change-status}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Change the user status with the **{{ ui-key.yacloud.mdb.cluster.users.field_enable-user }}** option:
      
      * Enable the option to allow the user to connect to the cluster and run commands.
      * Disable the option to prevent the user from connecting to the cluster.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change a {{ VLK }} user status:

  1. View the description of the CLI command for updating user settings:

      ```bash
      {{ yc-mdb-rd }} user update --help
      ```

  1. Change the user status by running this command:

      ```bash
      {{ yc-mdb-rd }} user update <username> \
        --cluster-id=<cluster_ID> \
        <user_status> 
      ```

      Where:

      * `--cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * Specify one of these user status flags:

        * `--disabled`: User is disabled.
        * `--enabled`: User is enabled.

      You can get the username with the [list of users](user-list.md#list) in the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      For more on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Update the `enabled` argument in the `yandex_mdb_redis_user` resource description:

      ```hcl
      resource "yandex_mdb_redis_user" "<local_resource_name>" {
        ...
        enabled = <user_status>
      }
      ```

      Where `enabled` is the user status. The possible values are:

      * `true`: User is enabled.
      * `false`: User is disabled.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "updateMask": "enabled",
        "enabled": <user_status>
      }
      ```

      Where:

      * `updateMask`: Comma-separated string of settings to update.

        {% include [update-mask-note-rest](../../_includes/mdb/mvk/update-mask-note-rest.md) %}

      * `enabled`: User status. The possible values are:

        * `true`: User is enabled.
        * `false`: User is disabled.

  1. Call the [User.Update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/users/<username>' \
        --data "@body.json"
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      You can get the username with the [list of users](user-list.md#list) in the cluster.

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "cluster_id": "<cluster_ID>",
        "user_name": "<username>",
        "update_mask": {
          "paths": [
            "enabled"
          ]
        },
        "enabled": <user_status>
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `user_name`: Username.

        You can get the username with the [list of users](user-list.md#list) in the cluster.

      * `update_mask`: List of settings to update as an array of strings (`paths[]`).

        {% cut "Format for listing settings" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<setting_1>",
              "<setting_2>",
              ...
              "<setting_N>"
            ]
          }
          ```

        {% endcut %}

        {% include [update-mask-note-grpc](../../_includes/mdb/mvk/update-mask-note-grpc.md) %}

      * `enabled`: User status. The possible values are:

          * `true`: User is enabled.
          * `false`: User is disabled.

  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.UserService.Update \
        < body.json
        ```

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring data cleanup {#change-sanitize-payload}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Under `Permissions`, in the `Sanitize Payload` field, specify the user permission to clean up data. The possible values are:
        
      * `sanitize-payload`: Data cleanup is enabled. This is the default value.
      * `skip-sanitize-payload`: Data cleanup is disabled.
  
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To configure data cleanup:

  1. View the description of the CLI command for updating user settings:

      ```bash
      {{ yc-mdb-rd }} user update --help
      ```

  1. Configure data cleanup by running this command:

      ```bash
      {{ yc-mdb-rd }} user update <username> \
        --cluster-id=<cluster_ID> \
        --sanitize-payload=<data_cleanup> 
      ```

      Where:

      * `--cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `--sanitize-payload`: Data cleanup. The possible values are:

        * `sanitize-payload`: Data cleanup is enabled. This is the default value.
        * `skip-sanitize-payload`: Data cleanup is disabled.

      You can get the username with the [list of users](user-list.md#list) in the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      For more on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Update the `sanitize_payload` argument in the `yandex_mdb_redis_user` resource description:

      ```hcl
      resource "yandex_mdb_redis_user" "<local_resource_name>" {
        ...
        sanitize_payload = "<data_cleanup>"
      }
      ```

      Where `--sanitize-payload` stands for data cleanup. The possible values are:

      * `sanitize-payload`: Data cleanup is enabled. This is the default value.
      * `skip-sanitize-payload`: Data cleanup is disabled.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "updateMask": "permissions.sanitizePayload",
        "permissions": {
          "sanitizePayload": "<data_cleanup>"
        }
      }
      ```

      Where:

      * `updateMask`: Comma-separated string of settings to update.

        {% include [update-mask-note-rest](../../_includes/mdb/mvk/update-mask-note-rest.md) %}

      * `permissions.sanitizePayload`: Data cleanup. The possible values are:

        * `sanitize-payload`: Data cleanup is enabled. This is the default value.
        * `skip-sanitize-payload`: Data cleanup is disabled.

  1. Call the [User.Update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/users/<username>' \
        --data "@body.json"
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      You can get the username with the [list of users](user-list.md#list) in the cluster.

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "cluster_id": "<cluster_ID>",
        "user_name": "<username>",
        "update_mask": {
          "paths": [
            "permissions.sanitize_payload"
          ]
        },
        "permissions": {
          "sanitize_payload": "<data_cleanup>"
        }
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `user_name`: Username.

        You can get the username with the [list of users](user-list.md#list) in the cluster.

      * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

        {% cut "Format for listing settings" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<setting_1>",
              "<setting_2>",
              ...
              "<setting_N>"
            ]
          }
          ```

        {% endcut %}

        {% include [update-mask-note-grpc](../../_includes/mdb/mvk/update-mask-note-grpc.md) %}

      * `permissions.sanitize_payload`: Data cleanup. The possible values are:

        * `sanitize-payload`: Data cleanup is enabled. This is the default value.
        * `skip-sanitize-payload`: Data cleanup is disabled.

  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.UserService.Update \
        < body.json
        ```

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Assigning user permissions {#change-permissions}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Under `Permissions`, specify user permissions:

      * `Patterns`: Permissions for key patterns.
      * `Pub Sub Channels`: Permissions for Pub/Sub channels.
      * `Categories`: Permissions for command categories.
      * `Commands`: Permissions for commands.
        
      {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

      For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl).
  
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign permissions to a {{ VLK }} user:

  1. View the description of the CLI command for updating user settings:

      ```bash
      {{ yc-mdb-rd }} user update --help
      ```

  1. Run this command to assign permissions to a user:

      ```bash
      {{ yc-mdb-rd }} user update <username> \
        --cluster-id=<cluster_ID> \
        --raw="<permissions>" \
        --categories="<permissions_for_command_categories>" \
        --commands="<permissions_for_commands>" \
        --patterns="<permissions_for_key_patterns>" \
        --pub-sub-channels="<permissions_for_channels>"
      ```

      Where:

      * `--cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `--raw`: String of space-separated permissions. Also, the string must set the user status:

        * `on`: User is enabled.
        * `off`: User is disabled.

        Example: `on ~data:* &* +@set +@hash +get +set`.

        {% note info %}

        The `--raw` flag cannot be used with separate permission flags or with `--disabled` and `--enabled`.

        {% endnote %}

      * `--categories`: String of space-separated permissions for command categories.

      * `--commands`: String of space-separated permissions for commands.

      * `--patterns`: String of space-separated permissions for key patterns.

      * `--pub-sub-channels`: String of space-separated permissions for Pub/Sub channels.

      {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

      For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl).

      You can get the username with the [list of users](user-list.md#list) in the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      For more on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Update the arguments in the `permissions` section of the `yandex_mdb_redis_user` resource description:

      ```hcl
      resource "yandex_mdb_redis_user" "<local_resource_name>" {
        ...
        permissions = {
          categories       = "<permissions_for_command_categories>"
          commands         = "<permissions_for_commands>"
          patterns         = "<permissions_for_key_patterns>"
          pub_sub_channels = "<permissions_for_channels>"
          ...
        }
        ...
      }
      ```

      Where `permissions` is the user permission settings:

      * `categories`: String of space-separated permissions for command categories.

      * `commands`: String of space-separated permissions for commands.

      * `patterns`: String of space-separated permissions for key patterns.

      * `pub_sub_channels`: String of space-separated permissions for Pub/Sub channels.

      {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

      For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "updateMask": "<list_of_settings_to_update>",
        "permissions": {
          "patterns": "<permissions_for_key_patterns>",
          "pubSubChannels": "<permissions_for_channels>",
          "categories": "<permissions_for_command_categories>",
          "commands": "<permissions_for_commands>"
        }
      }
      ```

      Where:

      * `updateMask`: Comma-separated string of settings to update.

        {% include [update-mask-note-rest](../../_includes/mdb/mvk/update-mask-note-rest.md) %}

      * `permissions.patterns`: String of space-separated permissions for key patterns.

      * `permissions.pubSubChannels`: String of space-separated permissions for Pub/Sub channels.

      * `permissions.categories`: String of space-separated permissions for command categories.

      * `permissions.commands`: String of space-separated permissions for commands.

      {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

      For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl).

  1. Call the [User.Update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/users/<username>' \
        --data "@body.json"
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      You can get the username with the [list of users](user-list.md#list) in the cluster.

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "cluster_id": "<cluster_ID>",
        "user_name": "<username>",
        "update_mask": {
          "paths": [
            <list_of_settings_to_update>
          ]
        },
        "permissions": {
          "patterns": "<permissions_for_key_patterns>",
          "pub_sub_channels": "<permissions_for_channels>",
          "categories": "<permissions_for_command_categories>",
          "commands": "<permissions_for_commands>"
        }
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `user_name`: Username.

        You can get the username with the [list of users](user-list.md#list) in the cluster.

      * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

        {% cut "Format for listing settings" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<setting_1>",
              "<setting_2>",
              ...
              "<setting_N>"
            ]
          }
          ```

        {% endcut %}

        {% include [update-mask-note-grpc](../../_includes/mdb/mvk/update-mask-note-grpc.md) %}

      * `permissions.patterns`: String of space-separated permissions for key patterns.

      * `permissions.pub_sub_channels`: String of space-separated permissions for Pub/Sub channels.

      * `permissions.categories`: String of space-separated permissions for command categories.

      * `permissions.commands`: String of space-separated permissions for commands.

      {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

      For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl).

  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.UserService.Update \
        < body.json
        ```

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
