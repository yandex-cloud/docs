---
title: Получение информации о пользователях {{ VLK }} в {{ mrd-full-name }}
description: Вы можете получить информацию о пользователях {{ VLK }} и их разрешениях в {{ mrd-name }}.
---

# Получение информации о пользователях

{% include [user-about](../../_includes/mdb/mvk/user-about.md) %}

## Получить список пользователей {#list}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список пользователей:

  1. Посмотрите описание команды CLI для получения списка пользователей:

      ```bash
      {{ yc-mdb-rd }} user list --help
      ```
  
  1. Получите список пользователей, выполнив команду:

      ```bash
      {{ yc-mdb-rd }} user list \
        --cluster-id=<идентификатор_кластера> 
      ```

      Где `--cluster-id` — идентификатор кластера.

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- REST API {#api}
    
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.List](../api-ref/User/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/users'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/list.md#yandex.cloud.mdb.redis.v1.ListUsersResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [UserService.List](../api-ref/grpc/User/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "cluster_id": "<идентификатор_кластера>"
        }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.UserService.List
        ```
    
      Где `cluster_id` — идентификатор кластера.
      
      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.  

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/list.md#yandex.cloud.mdb.redis.v1.ListUsersResponse).

{% endlist %}

## Получить информацию о пользователе {#get}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о конкретном пользователе:

  1. Посмотрите описание команды CLI для получения информации о пользователе:

      ```bash
      {{ yc-mdb-rd }} user get --help
      ```
  
  1. Получите информацию о пользователе, выполнив команду:

      ```bash
      {{ yc-mdb-rd }} user get <имя_пользователя> \
        --cluster-id=<идентификатор_кластера>
      ```

      Где `--cluster-id` — идентификатор кластера. Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](#list) в кластере.

- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Get](../api-ref/User/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](#list) в кластере.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/get.md#yandex.cloud.mdb.redis.v1.User).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [UserService.Get](../api-ref/grpc/User/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "cluster_id": "<идентификатор_кластера>",
          "user_name": "<имя_пользователя>"
        }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.UserService.Get
        ```
      
      Где:

      * `cluster_id` — идентификатор кластера.
        
        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `user_name` — имя пользователя.
      
        Имя пользователя можно получить со [списком пользователей](#list) в кластере.  

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/get.md#yandex.cloud.mdb.redis.v1.User).

{% endlist %}