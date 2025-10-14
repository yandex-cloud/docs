---
title: Изменение настроек пользователя {{ VLK }} в {{ mrd-full-name }}
description: Вы можете изменять настройки пользователя {{ VLK }} в {{ mrd-name }}.
---

# Изменение настроек пользователя

После создания пользователя {{ VLK }} вы можете:

* [изменить пароль](#change-password);
* [изменить статус пользователя](#change-status);
* [настроить очистку данных](#change-sanitize-payload);
* [назначить разрешения пользователю](#change-permissions).

## Изменить пароль пользователя {#change-password}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя {{ VLK }}:

  1. Посмотрите описание команды CLI для изменения настроек пользователя:

      ```bash
      {{ yc-mdb-rd }} user update --help
      ```
  
  1. Измените пароль, выполнив команду:

      ```bash
      {{ yc-mdb-rd }} user update <имя_пользователя> \
        --cluster-id=<идентификатор_кластера> \
        --password="<пароль_пользователя>" 
      ```

      Где:
      
      * `--cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `--password` — пароль пользователя. Длина пароля — от 8 до 128 символов.
      
      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
  1. Измените в описании ресурса `yandex_mdb_redis_user` параметр `passwords`:
  
      ```hcl
      resource "yandex_mdb_redis_user" "<локальное_имя_ресурса>" {
        ...
        passwords  = ["<пароль_пользователя>"]
        ...
      }
      ```

      Где `passwords` — пароль пользователя. Длина пароля — от 8 до 128 символов.
      
      Можно указать только один пароль.
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "updateMask": "passwords",
        "passwords": [
          "<пароль_пользователя>"
        ]
      }
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в строку через запятую.

        {% include [update-mask-note-rest](../../_includes/mdb/mrd/update-mask-note-rest.md) %}

      * `passwords` — пароль пользователя. Длина пароля — от 8 до 128 символов.
      
        Можно указать только один пароль.

  1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
        --data "@body.json"
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:
      
      ```json
      {
        "cluster_id": "<идентификатор_кластера>",
        "user_name": "<имя_пользователя>",
        "update_mask": {
          "paths": [
            "passwords"
          ]
        },
        "passwords": [
          "<пароль_пользователя>"
        ]
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      
        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `user_name` — имя пользователя.

        Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
        
        {% cut "Формат перечисления настроек" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
            ]
          }
          ```

        {% endcut %}

        {% include [update-mask-note-grpc](../../_includes/mdb/mrd/update-mask-note-grpc.md) %}

      * `passwords` — пароль пользователя. Длина пароля — от 8 до 128 символов.
          
        Можно указать только один пароль.  

  1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить статус пользователя {#change-status}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить статус пользователя {{ VLK }}:

  1. Посмотрите описание команды CLI для изменения настроек пользователя:

      ```bash
      {{ yc-mdb-rd }} user update --help
      ```
  
  1. Измените статус пользователя, выполнив команду:

      ```bash
      {{ yc-mdb-rd }} user update <имя_пользователя> \
        --cluster-id=<идентификатор_кластера> \
        <статус_пользователя> 
      ```

      Где:
      
      * `--cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
      
      * Укажите один из флагов, определяющих статус пользователя:

        * `--disabled` — пользователь отключен;
        * `--enabled` — пользователь включен.
      
      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
  1. Измените в описании ресурса `yandex_mdb_redis_user` параметр `enabled`:
  
      ```hcl
      resource "yandex_mdb_redis_user" "<локальное_имя_ресурса>" {
        ...
        enabled = <статус_пользователя>
        ...
      }
      ```

      Где `enabled` — статус пользователя. Возможные значения:
        
      * `true` — пользователь включен;
      * `false` — пользователь отключен.
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "updateMask": "enabled",
        "enabled": <статус_пользователя>
      }
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в строку через запятую.

        {% include [update-mask-note-rest](../../_includes/mdb/mrd/update-mask-note-rest.md) %}

      * `enabled` — статус пользователя. Возможные значения:
        
        * `true` — пользователь включен;
        * `false` — пользователь отключен.

  1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
        --data "@body.json"
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:
      
      ```json
      {
        "cluster_id": "<идентификатор_кластера>",
        "user_name": "<имя_пользователя>",
        "update_mask": {
          "paths": [
            "enabled"
          ]
        },
        "enabled": <статус_пользователя>
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      
        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `user_name` — имя пользователя.

        Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
        
        {% cut "Формат перечисления настроек" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
            ]
          }
          ```

        {% endcut %}

        {% include [update-mask-note-grpc](../../_includes/mdb/mrd/update-mask-note-grpc.md) %}

      * `enabled` — статус пользователя. Возможные значения:
        
          * `true` — пользователь включен;
          * `false` — пользователь отключен.

  1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить очистку данных {#change-sanitize-payload}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы настроить очистку данных:

  1. Посмотрите описание команды CLI для изменения настроек пользователя:

      ```bash
      {{ yc-mdb-rd }} user update --help
      ```
  
  1. Настройте очистку данных, выполнив команду:

      ```bash
      {{ yc-mdb-rd }} user update <имя_пользователя> \
        --cluster-id=<идентификатор_кластера> \
        --sanitize-payload=<очистка_данных> 
      ```

      Где:
      
      * `--cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `--sanitize-payload` — очистка данных. Возможные значения:
        
        * `sanitize-payload` (по умолчанию) — очистка данных включена;
        * `skip-sanitize-payload` — очистка данных отключена.
      
      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
  1. Измените в описании ресурса `yandex_mdb_redis_user` параметр `sanitize_payload`:
  
      ```hcl
      resource "yandex_mdb_redis_user" "<локальное_имя_ресурса>" {
        ...
        sanitize_payload = "<очистка_данных>"
        ...
      }
      ```

      Где `sanitize_payload` — очистка данных. Возможные значения:
          
      * `sanitize-payload` (по умолчанию) — очистка данных включена;
      * `skip-sanitize-payload` — очистка данных отключена.
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "updateMask": "permissions.sanitizePayload",
        "permissions": {
          "sanitizePayload": "<очистка_данных>"
        }
      }
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в строку через запятую.

        {% include [update-mask-note-rest](../../_includes/mdb/mrd/update-mask-note-rest.md) %}

      * `permissions.sanitizePayload` — очистка данных. Возможные значения:
          
        * `sanitize-payload` (по умолчанию) — очистка данных включена;
        * `skip-sanitize-payload` — очистка данных отключена.

  1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
        --data "@body.json"
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:
      
      ```json
      {
        "cluster_id": "<идентификатор_кластера>",
        "user_name": "<имя_пользователя>",
        "update_mask": {
          "paths": [
            "permissions.sanitize_payload"
          ]
        },
        "permissions": {
          "sanitize_payload": "<очистка_данных>"
        }
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      
        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `user_name` — имя пользователя.

        Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
        
        {% cut "Формат перечисления настроек" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
            ]
          }
          ```

        {% endcut %}

        {% include [update-mask-note-grpc](../../_includes/mdb/mrd/update-mask-note-grpc.md) %}

      * `permissions.sanitize_payload` — очистка данных. Возможные значения:
          
        * `sanitize-payload` (по умолчанию) — очистка данных включена;
        * `skip-sanitize-payload` — очистка данных отключена.
          
  1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Назначить разрешения пользователю {#change-permissions}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы назначить разрешения пользователю {{ VLK }}:

  1. Посмотрите описание команды CLI для изменения настроек пользователя:

      ```bash
      {{ yc-mdb-rd }} user update --help
      ```
  
  1. Назначьте разрешения пользователю, выполнив команду:

      ```bash
      {{ yc-mdb-rd }} user update <имя_пользователя> \
        --cluster-id=<идентификатор_кластера> \
        --raw="<разрешения>" \
        --categories="<разрешения_на_категории_команд>" \
        --commands="<разрешения_на_команды>" \
        --patterns="<разрешения_на_шаблоны_ключей>" \
        --pub-sub-channels="<разрешения_на_каналы>"
      ```

      Где:
      
      * `--cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `--raw` — разрешения, в строку через пробел. Также строка должна включать настройку статуса пользователя:
        
        * `on` — пользователь включен;
        * `off` — пользователь отключен.
        
        Пример: `on ~data:* &* +@set +@hash +get +set`.

        {% note info %}

        Флаг `--raw` не используется с флагами отдельных разрешений и с флагами `--disabled` и `--enabled`.
      
        {% endnote %}
        
      * `--categories` — разрешения на категории команд, в строку через пробел.
      
      * `--commands` — разрешения на команды, в строку через пробел.
      
      * `--patterns` — разрешения на шаблоны ключей, в строку через пробел.
      
      * `--pub-sub-channels` — разрешения на каналы Pub/Sub, в строку через пробел.

      {% include [user-permissions-note](../../_includes/mdb/mrd/user-permissions-note.md) %}

      Подробнее о списках контроля доступа читайте в [документации {{ VLK }} ACL](https://valkey.io/topics/acl).
      
      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
  1. Измените в описании ресурса `yandex_mdb_redis_user` параметры в блоке `permissions`:
  
      ```hcl
      resource "yandex_mdb_redis_user" "<локальное_имя_ресурса>" {
        ...
        permissions = {
          categories       = "<разрешения_на_категории_команд>"
          commands         = "<разрешения_на_команды>"
          patterns         = "<разрешения_на_шаблоны_ключей>"
          pub_sub_channels = "<разрешения_на_каналы>"
          ...
        }
        ...
      }
      ```

      Где `permissions` — настройки разрешений пользователя:

      * `categories` — разрешения на категории команд, в строку через пробел.
        
      * `commands` — разрешения на команды, в строку через пробел.
        
      * `patterns` — разрешения на шаблоны ключей, в строку через пробел.
          
      * `pub_sub_channels` — разрешения на каналы Pub/Sub, в строку через пробел.

      {% include [user-permissions-note](../../_includes/mdb/mrd/user-permissions-note.md) %}

      Подробнее о списках контроля доступа читайте в [документации {{ VLK }} ACL](https://valkey.io/topics/acl).
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "updateMask": "<список_изменяемых_параметров>",
        "permissions": {
          "patterns": "<разрешения_на_шаблоны_ключей>",
          "pubSubChannels": "<разрешения_на_каналы>",
          "categories": "<разрешения_на_категории_команд>",
          "commands": "<разрешения_на_команды>"
        }
      }
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в строку через запятую.

        {% include [update-mask-note-rest](../../_includes/mdb/mrd/update-mask-note-rest.md) %}

      * `permissions.patterns` — разрешения на шаблоны ключей, в строку через пробел.

      * `permissions.pubSubChannels` — разрешения на каналы Pub/Sub, в строку через пробел.
      
      * `permissions.categories` — разрешения на категории команд, в строку через пробел.
      
      * `permissions.commands` — разрешения на команды, в строку через пробел.

      {% include [user-permissions-note](../../_includes/mdb/mrd/user-permissions-note.md) %}

      Подробнее о списках контроля доступа читайте в [документации {{ VLK }} ACL](https://valkey.io/topics/acl).

  1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
        --data "@body.json"
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:
      
      ```json
      {
        "cluster_id": "<идентификатор_кластера>",
        "user_name": "<имя_пользователя>",
        "update_mask": {
          "paths": [
            <список_изменяемых_параметров>
          ]
        },
        "permissions": {
          "patterns": "<разрешения_на_шаблоны_ключей>",
          "pub_sub_channels": "<разрешения_на_каналы>",
          "categories": "<разрешения_на_категории_команд>",
          "commands": "<разрешения_на_команды>"
        }
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      
        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `user_name` — имя пользователя.

        Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
        
        {% cut "Формат перечисления настроек" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
            ]
          }
          ```

        {% endcut %}

        {% include [update-mask-note-grpc](../../_includes/mdb/mrd/update-mask-note-grpc.md) %}

      * `permissions.patterns` — разрешения на шаблоны ключей, в строку через пробел.
          
      * `permissions.pub_sub_channels` — разрешения на каналы Pub/Sub, в строку через пробел.
          
      * `permissions.categories` — разрешения на категории команд, в строку через пробел.
          
      * `permissions.commands` — разрешения на команды, в строку через пробел.
            
      {% include [user-permissions-note](../../_includes/mdb/mrd/user-permissions-note.md) %}

      Подробнее о списках контроля доступа читайте в [документации {{ VLK }} ACL](https://valkey.io/topics/acl).
          
  1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}