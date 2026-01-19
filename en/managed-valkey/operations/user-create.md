---
title: Creating a {{ VLK }} user in {{ mrd-full-name }}
description: You can create {{ VLK }} users and manage their permissions in {{ mrd-name }}.
---

# Creating a user

{% include [user-about](../../_includes/mdb/mvk/user-about.md) %}

## Creating a user {#create-user}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ VLK }} user:

  1. View the description of the CLI command to create s user:

      ```bash
      {{ yc-mdb-rd }} user create --help
      ```
  
  1. To create a user, run the command below. Note that some flags are omitted:

      ```bash
      {{ yc-mdb-rd }} user create <username> \
        --cluster-id=<cluster_ID> \
        --password="<user_password>" \
        --disabled \
        --raw="<permissions>" \
        --categories="<permissions_for_command_categories>" \
        --commands="<permissions_for_commands>" \
        --patterns="<permissions_for_key_templates>" \
        --pub-sub-channels="<permissions_for_channels>" \
        --sanitize-payload=<data_cleanup>
      ```

      Where:
      
      * `--cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `--password`: Password. The password must be from 8 to 128 characters long.
      
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
      
      * `--patterns`: String of space-separated permissions for key templates.
      
      * `--pub-sub-channels`: String of space-separated permissions for Pub/Sub channels.
      
      * `--sanitize-payload`: Data cleanup. The possible values are:
        
        * `sanitize-payload`: Data cleanup is enabled. This is the default value.
        * `skip-sanitize-payload`: Data cleanup is disabled.

      {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

      For more information about access control lists, see this [{{ VLK }} ACL guide](https://valkey.io/topics/acl).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.
  
      For more information about creating this file, see [this guide](cluster-create.md).
  
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
          patterns         = "<permissions_for_key_templates>"
          pub_sub_channels = "<permissions_for_channels>"
          sanitize_payload = "<data_cleanup>"
        }
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.
      
      * `name`: Username.
        
      * `passwords`: Password. The password must be from 8 to 128 characters long.
          
        You can specify only one password.

      * `enabled`: User status. The possible values are:
        
        * `true`: User is enabled.
        * `false`: User is disabled.
      
      * `permissions`: User permission settings:

        * `categories`: String of space-separated permissions for command categories.
        
        * `commands`: String of space-separated permissions for commands.
        
        * `patterns`: String of space-separated permissions for key templates.
          
        * `pub_sub_channels`: String of space-separated permissions for Pub/Sub channels.
          
        * `sanitize_payload`: Data cleanup. The possible values are:
          
          * `sanitize-payload`: Data cleanup is enabled. This is the default value.
          * `skip-sanitize-payload`: Data cleanup is disabled.
        
        {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

        For more information about access control lists, see this [{{ VLK }} ACL guide](https://valkey.io/topics/acl).
  
  1. Validate your configuration.
  
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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

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
            "patterns": "<permissions_for_key_templates>",
            "pubSubChannels": "<permissions_for_channels>",
            "categories": "<permissions_for_command_categories>",
            "commands": "<permissions_for_commands>",
            "sanitizePayload": "<data_cleanup>"
          },
          "enabled": <user_status>
        }
      }
      ```

      Where `userSpec` represents the user settings:
      
      * `name`: Username.

      * `passwords`: Password. The password must be from 8 to 128 characters long.
      
        You can specify only one password.
      
      * `permissions`: User permission settings:

        * `patterns`: String of space-separated permissions for key templates.
        * `pubSubChannels`: String of space-separated permissions for Pub/Sub channels.
        * `categories`: String of space-separated permissions for command categories.
        * `commands`: String of space-separated permissions for commands.
        * `sanitizePayload`: Data cleanup. The possible values are:
          
          * `sanitize-payload`: Data cleanup is enabled. This is the default value.
          * `skip-sanitize-payload`: Data cleanup is disabled.
        
        {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

        For more information about access control lists, see this [{{ VLK }} ACL guide](https://valkey.io/topics/acl). 

      * `enabled`: User status. The possible values are:
        
        * `true`: User is enabled.
        * `false`: User is disabled. 

  1. Use the [User.Create](../api-ref/User/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

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
            "patterns": "<permissions_for_key_templates>",
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
        
        * `passwords`: Password. The password must be from 8 to 128 characters long.
          
          You can specify only one password.
      
        * `permissions`: User permission settings:

          * `patterns`: String of space-separated permissions for key templates.
          
          * `pub_sub_channels`: String of space-separated permissions for Pub/Sub channels.
          
          * `categories`: String of space-separated permissions for command categories.
          
          * `commands`: String of space-separated permissions for commands.
          
          * `sanitize_payload`: Data cleanup. The possible values are:
          
            * `sanitize-payload`: Data cleanup is enabled. This is the default value.
            * `skip-sanitize-payload`: Data cleanup is disabled.
        
          {% include [user-permissions-note](../../_includes/mdb/mvk/user-permissions-note.md) %}

          For more information about access control lists, see this [{{ VLK }} ACL guide](https://valkey.io/topics/acl).

        * `enabled`: User status. The possible values are:
        
          * `true`: User is enabled.
          * `false`: User is disabled.

  1. Use the [UserService.Create](../api-ref/grpc/User/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

  1. View the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}