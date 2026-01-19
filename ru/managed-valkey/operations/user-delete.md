---
title: Удаление пользователя {{ VLK }} в {{ mrd-full-name }}
description: Вы можете удалить пользователя {{ VLK }} в {{ mrd-name }}.
---

# Удаление пользователя

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить пользователя {{ VLK }}:

  1. Посмотрите описание команды CLI для удаления пользователя:

      ```bash
      {{ yc-mdb-rd }} user delete --help
      ```
  
  1. Удалите пользователя, выполнив команду:

      ```bash
      {{ yc-mdb-rd }} user delete <имя_пользователя> \
        --cluster-id=<идентификатор_кластера>
      ```

      Где `--cluster-id` — идентификатор кластера. Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
  1. Удалите ресурс `yandex_mdb_redis_user` с описанием нужного пользователя.
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  1. Убедитесь, что пользователь удален, выполнив команду [CLI](../../cli/quickstart.md#install):
      
      ```bash
      {{ yc-mdb-rd }} user list \
        --cluster-id=<идентификатор_кластера>
      ```

      [Подробнее о том, как получить список пользователей](user-list.md#list).
  
  {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Delete](../api-ref/User/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [UserService.Delete](../api-ref/grpc/User/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
        yandex.cloud.mdb.redis.v1.UserService.Delete
        ```
      
      Где:

      * `cluster_id` — идентификатор кластера.
        
        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `user_name` — имя пользователя.
      
        Имя пользователя можно получить со [списком пользователей](user-list#list) в кластере.  

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation).

{% endlist %}