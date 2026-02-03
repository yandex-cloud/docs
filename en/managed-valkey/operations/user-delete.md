---
title: Deleting a {{ VLK }} user in {{ mrd-full-name }}
description: You can delete a {{ VLK }} user in {{ mrd-name }}.
---

# Deleting a user

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a {{ VLK }} user:

  1. See the description of the CLI command for deleting a user:

      ```bash
      {{ yc-mdb-rd }} user delete --help
      ```
  
  1. To delete a user, run this command:

      ```bash
      {{ yc-mdb-rd }} user delete <username> \
        --cluster-id=<cluster_ID>
      ```

      Where `--cluster-id` is the cluster ID. You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      You can get the username with the [list of users](user-list.md#list) in the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.
  
      To learn how to create this file, see [Creating a cluster](cluster-create.md).
  
  1. Delete the `yandex_mdb_redis_user` resource with the target user’s description.
  
  1. Validate your configuration.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm resource changes.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  1. Run this [CLI](../../cli/quickstart.md#install) command to make sure the user was deleted:
      
      ```bash
      {{ yc-mdb-rd }} user list \
        --cluster-id=<cluster_ID>
      ```

      Learn more on how to get a list of users [here](user-list.md#list).
  
  {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Delete](../api-ref/User/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/users/<username>'
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      You can get the username with the [list of users](user-list.md#list) in the cluster.

  1. Check the [server response](../api-ref/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [UserService.Delete](../api-ref/grpc/User/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "cluster_id": "<cluster_ID>",
          "user_name": "<username>"
        }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.UserService.Delete
        ```
      
      Where:

      * `cluster_id`: Cluster ID.
        
        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `user_name`: Username.
      
        You can get the username with the [list of users](user-list#list) in the cluster.  

  1. Check the [server response](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}