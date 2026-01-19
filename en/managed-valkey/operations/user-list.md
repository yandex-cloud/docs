---
title: Getting {{ VLK }} user info in {{ mrd-full-name }}
description: You can get information about {{ VLK }} users and their permissions in {{ mrd-name }}.
---

# Getting user info

{% include [user-about](../../_includes/mdb/mvk/user-about.md) %}

## Getting a list of users {#list}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of users:

  1. See the description of the CLI command for getting a list of users:

      ```bash
      {{ yc-mdb-rd }} user list --help
      ```
  
  1. Get a list of users by running this command:

      ```bash
      {{ yc-mdb-rd }} user list \
        --cluster-id=<cluster_ID> 
      ```

      Where `--cluster-id` is the cluster ID.

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

- REST API {#api}
    
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [User.List](../api-ref/User/list.md) method to execute the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/users'
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

  1. Check the [server response](../api-ref/User/list.md#yandex.cloud.mdb.redis.v1.ListUsersResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Use the [UserService.List](../api-ref/grpc/User/list.md) call to execute the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "cluster_id": "<cluster_ID>"
        }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.UserService.List
        ```
    
      Where `cluster_id` is the cluster ID.
      
      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.  

  1. Check the [server response](../api-ref/grpc/User/list.md#yandex.cloud.mdb.redis.v1.ListUsersResponse) to make sure your request was successful.

{% endlist %}

## Getting user info {#get}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a specific user:

  1. See the description of the CLI command for getting user info:

      ```bash
      {{ yc-mdb-rd }} user get --help
      ```
  
  1. Get user info by running this command:

      ```bash
      {{ yc-mdb-rd }} user get <username> \
        --cluster-id=<cluster_ID>
      ```

      Where `--cluster-id` is the cluster ID. You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      You can get the username with the [list of users](#list) in the cluster.

- REST API {#api}
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [User.Get](../api-ref/User/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/users/<username>'
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      You can get the username with the [list of users](#list) in the cluster.

  1. Check the [server response](../api-ref/User/get.md#yandex.cloud.mdb.redis.v1.User) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Use the [UserService.Get](../api-ref/grpc/User/get.md) call to execute the following request, e.g., via {{ api-examples.grpc.tool }}:

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
        yandex.cloud.mdb.redis.v1.UserService.Get
        ```
      
      Where:

      * `cluster_id`: Cluster ID.
        
        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `user_name`: Username.
      
        You can get the username with the [list of users](#list) in the cluster.  

  1. Check the [server response](../api-ref/grpc/User/get.md#yandex.cloud.mdb.redis.v1.User) to make sure your request was successful.

{% endlist %}