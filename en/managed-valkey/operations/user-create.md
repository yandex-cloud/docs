---
title: Creating a {{ VLK }} user in {{ mrd-full-name }}
description: You can create {{ VLK }} users and manage their permissions in {{ mrd-name }}.
---

# Creating a user

{% include [user-about](../../_includes/mdb/mvk/user-about.md) %}

## Creating a user {#create-user}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}** in the top-right corner of the page.
  
  
  1. Choose the authorization method:
      
      * **Password**: Authorization by username and password. For this authorization method:
        
        1. Enter the username.

        
        1. Set a user password in one of the following ways:
 
            * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Enter a password manually. It must be from 8 to 128 characters long.
            * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password using [{{ connection-manager-full-name }}](../../metadata-hub/concepts/connection-manager.md) and store it in a [{{ lockbox-full-name }} secret](../../lockbox/concepts/secret.md).

              To view the password, navigate to the cluster page, select the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-full-name }} secret containing the password.

              You need the [lockbox.payloadViewer](../../lockbox/security/index.md#lockbox-payloadViewer) role to view passwords.
        

      * **IAM**: Authorization via [{{ yandex-cloud }} accounts](../../iam/concepts/users/accounts.md).
        
        For this authorization method, select the right account in the **User** field.


  1. Select the **{{ ui-key.yacloud.mdb.cluster.users.field_enable-user }}** option to enable the user to connect to the cluster and execute commands.
  1. Under `Permissions`, specify user permissions:

      * `Patterns`: Permissions for key patterns.
      * `Pub Sub Channels`: Permissions for Pub/Sub channels.
      * `Categories`: Permissions for command categories.
      * `Commands`: Permissions for commands.
      * `Sanitize Payload`: Permission for data cleanup. The possible values are:
        
        * `sanitize-payload`: Data cleanup is enabled. This is the default value.
        * `skip-sanitize-payload`: Data cleanup is disabled.
        
      {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

      For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl).
  
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ VLK }} user:

  1. See the description of the CLI command for creating a user:

      ```bash
      {{ yc-mdb-rd }} user create --help
      ```
  
  1. Run this command to create a user (our example lists only some flags):

      ```bash
      {{ yc-mdb-rd }} user create <username> \
        --cluster-id=<cluster_ID> \
        --password="<user_password>" \
        --disabled \
        --raw="<permissions>" \
        --categories="<permissions_for_command_categories>" \
        --commands="<permissions_for_commands>" \
        --patterns="<permissions_for_key_patterns>" \
        --pub-sub-channels="<permissions_for_channels>" \
        --sanitize-payload=<data_cleanup>
      ```

      Where:
      
      * `--cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `--password`: User password. It must be from 8 to 128 characters long.
      
      * `--disabled`: Disables the user. The default value is `false`.
      
      * `--raw`: String of space-separated permissions. Also, the string must set the user status:
        
        * `on`: User is enabled.
        * `off`: User is disabled.
        
        Example: `on ~data:* &* +@set +@hash +get +set`.

        {% note info %}

        The `--raw` flag cannot be used with separate permission flags or with `--disabled`.

        {% endnote %}
      
      * `--categories`: String of space-separated permissions for command categories.
      
      * `--commands`: String of space-separated permissions for commands.
      
      * `--patterns`: String of space-separated permissions for key patterns.
      
      * `--pub-sub-channels`: String of space-separated permissions for Pub/Sub channels.
      
      * `--sanitize-payload`: Data cleanup. The possible values are:
        
        * `sanitize-payload`: Data cleanup is enabled. This is the default value.
        * `skip-sanitize-payload`: Data cleanup is disabled.

      {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

      For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.
  
      To learn how to create this file, see [Creating a cluster](cluster-create.md).
  
  1. To create a user, add the `yandex_mdb_redis_user` resource:
  
      ```hcl
      resource "yandex_mdb_redis_user" "<local_resource_name>" {
        cluster_id = <cluster_ID>
        name       = "<username>"
        passwords  = ["<user_password>"]
        enabled    = <user_status>
        
        permissions = {
          categories       = "<permissions_for_command_categories>"
          commands         = "<permissions_for_commands>"
          patterns         = "<permissions_for_key_patterns>"
          pub_sub_channels = "<permissions_for_channels>"
          sanitize_payload = "<data_cleanup>"
        }
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.
      
      * `name`: Username.
        
      * `passwords`: Password. It must be from 8 to 128 characters long.
          
        You can specify only one password.

      * `enabled`: User status. The possible values are:
        
        * `true`: User is enabled.
        * `false`: User is disabled.
      
      * `permissions`: User permission settings:

        * `categories`: String of space-separated permissions for command categories.
        
        * `commands`: String of space-separated permissions for commands.
        
        * `patterns`: String of space-separated permissions for key patterns.
          
        * `pub_sub_channels`: String of space-separated permissions for Pub/Sub channels.
          
        * `sanitize_payload`: Data cleanup. The possible values are:
          
          * `sanitize-payload`: Data cleanup is enabled. This is the default value.
          * `skip-sanitize-payload`: Data cleanup is disabled.
        
        {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

        For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl).
  
  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm resource changes.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  1. Make sure the user is created by running this [CLI](../../cli/quickstart.md#install) command:
      
      ```bash
      {{ yc-mdb-rd }} user get <username> \
        --cluster-id=<cluster_ID>
      ```

      Learn more on how to get information about a user [here](user-list.md#get).
  
  {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "userSpec": {
          "name": "<username>",
          "passwords": [
            "<user_password>"
          ],
          "permissions": {
            "patterns": "<permissions_for_key_patterns>",
            "pubSubChannels": "<permissions_for_channels>",
            "categories": "<permissions_for_command_categories>",
            "commands": "<permissions_for_commands>",
            "sanitizePayload": "<data_cleanup>"
          },
          "enabled": <user_status>
        }
      }
      ```

      Where `userSpec` stands for the user settings:
      
      * `name`: Username.

      * `passwords`: Password. It must be from 8 to 128 characters long.
      
        You can specify only one password.
      
      * `permissions`: User permission settings:

        * `patterns`: String of space-separated permissions for key patterns.
        * `pubSubChannels`: String of space-separated permissions for Pub/Sub channels.
        * `categories`: String of space-separated permissions for command categories.
        * `commands`: String of space-separated permissions for commands.
        * `sanitizePayload`: Data cleanup. The possible values are:
          
          * `sanitize-payload`: Data cleanup is enabled. This is the default value.
          * `skip-sanitize-payload`: Data cleanup is disabled.
        
        {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

        For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl). 

      * `enabled`: User status. The possible values are:
        
        * `true`: User is enabled.
        * `false`: User is disabled. 

  1. Call the [User.Create](../api-ref/User/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/users' \
        --data "@body.json"
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

  1. Check the [server response](../api-ref/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:
      
      ```json
      {
        "cluster_id": "<cluster_ID>",
        "user_spec": {
          "name": "<username>",
          "passwords": [
            "<user_password>"
          ],
          "permissions": {
            "patterns": "<permissions_for_key_patterns>",
            "pub_sub_channels": "<permissions_for_channels>",
            "categories": "<permissions_for_command_categories>",
            "commands": "<permissions_for_commands>",
            "sanitize_payload": "<data_cleanup>"
          },
          "enabled": <user_status>
        }
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.
      
        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `user_spec`: User settings:
      
        * `name`: Username.
        
        * `passwords`: Password. It must be from 8 to 128 characters long.
          
          You can specify only one password.
      
        * `permissions`: User permission settings:

          * `patterns`: String of space-separated permissions for key patterns.
          
          * `pub_sub_channels`: String of space-separated permissions for Pub/Sub channels.
          
          * `categories`: String of space-separated permissions for command categories.
          
          * `commands`: String of space-separated permissions for commands.
          
          * `sanitize_payload`: Data cleanup. The possible values are:
          
            * `sanitize-payload`: Data cleanup is enabled. This is the default value.
            * `skip-sanitize-payload`: Data cleanup is disabled.
        
          {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

          For more information about access control lists, see [this {{ VLK }} ACL guide](https://valkey.io/topics/acl).

        * `enabled`: User status. The possible values are:
        
          * `true`: User is enabled.
          * `false`: User is disabled.

  1. Call the [UserService.Create](../api-ref/grpc/User/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.UserService.Create \
        < body.json
        ```

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}