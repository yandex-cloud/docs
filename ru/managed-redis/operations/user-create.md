---
title: Создание пользователя {{ VLK }} в {{ mrd-full-name }}
description: Вы можете создавать пользователей {{ VLK }} и управлять их разрешениями в {{ mrd-name }}.
---

# Создание пользователя

{% include [user-about](../../_includes/mdb/mrd/user-about.md) %}

## Создать пользователя {#create-user}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать пользователя {{ VLK }}:

  1. Посмотрите описание команды CLI для создания пользователя:

      ```bash
      {{ yc-mdb-rd }} user create --help
      ```
  
  1. Создайте пользователя, выполнив команду (приведены не все флаги):

      ```bash
      {{ yc-mdb-rd }} user create <имя_пользователя> \
        --cluster-id=<идентификатор_кластера> \
        --password="<пароль_пользователя>" \
        --disabled \
        --raw="<разрешения>" \
        --categories="<разрешения_на_категории_команд>" \
        --commands="<разрешения_на_команды>" \
        --patterns="<разрешения_на_шаблоны_ключей>" \
        --pub-sub-channels="<разрешения_на_каналы>" \
        --sanitize-payload=<очистка_данных>
      ```

      Где:
      
      * `--cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `--password` — пароль пользователя. Длина пароля — от 8 до 128 символов.
      
      * `--disabled` — отключает пользователя. По умолчанию — `false`.
      
      * `--raw` — разрешения, в строку через пробел. Также строка должна включать настройку статуса пользователя:
        
        * `on` — пользователь включен;
        * `off` — пользователь отключен.
        
        Пример: `on ~data:* &* +@set +@hash +get +set`.

        {% note info %}

        Флаг `--raw` не используется с флагами отдельных разрешений и с `--disabled`.

        {% endnote %}
      
      * `--categories` — разрешения на категории команд, в строку через пробел.
      
      * `--commands` — разрешения на команды, в строку через пробел.
      
      * `--patterns` — разрешения на шаблоны ключей, в строку через пробел.
      
      * `--pub-sub-channels` — разрешения на каналы Pub/Sub, в строку через пробел.
      
      * `--sanitize-payload` — очистка данных. Возможные значения:
        
        * `sanitize-payload` (по умолчанию) — очистка данных включена;
        * `skip-sanitize-payload` — очистка данных отключена.

      {% include [user-permissions-note](../../_includes/mdb/mrd/user-permissions-note.md) %}

      Подробнее о списках контроля доступа читайте в [документации {{ VLK }} ACL](https://valkey.io/topics/acl).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
  1. Чтобы создать пользователя, добавьте ресурс `yandex_mdb_redis_user`:
  
      ```hcl
      resource "yandex_mdb_redis_user" "<локальное_имя_ресурса>" {
        cluster_id = <идентификатор_кластера>
        name       = "<имя_пользователя>"
        passwords  = ["<пароль_пользователя>"]
        enabled    = <статус_пользователя>
        
        permissions = {
          categories       = "<разрешения_на_категории_команд>"
          commands         = "<разрешения_на_команды>"
          patterns         = "<разрешения_на_шаблоны_ключей>"
          pub_sub_channels = "<разрешения_на_каналы>"
          sanitize_payload = "<очистка_данных>"
        }
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      
      * `name` — имя пользователя.
        
      * `passwords` — пароль пользователя. Длина пароля — от 8 до 128 символов.
          
        Можно указать только один пароль.

      * `enabled` — статус пользователя. Возможные значения:
        
        * `true` — пользователь включен;
        * `false` — пользователь отключен.
      
      * `permissions` — настройки разрешений пользователя:

        * `categories` — разрешения на категории команд, в строку через пробел.
        
        * `commands` — разрешения на команды, в строку через пробел.
        
        * `patterns` — разрешения на шаблоны ключей, в строку через пробел.
          
        * `pub_sub_channels` — разрешения на каналы Pub/Sub, в строку через пробел.
          
        * `sanitize_payload` — очистка данных. Возможные значения:
          
          * `sanitize-payload` (по умолчанию) — очистка данных включена;
          * `skip-sanitize-payload` — очистка данных отключена.
        
        {% include [user-permissions-note](../../_includes/mdb/mrd/user-permissions-note.md) %}

        Подробнее о списках контроля доступа читайте в [документации {{ VLK }} ACL](https://valkey.io/topics/acl).
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  1. Убедитесь, что пользователь создан, выполнив команду [CLI](../../cli/quickstart.md#install):
      
      ```bash
      {{ yc-mdb-rd }} user get <имя_пользователя> \
        --cluster-id=<идентификатор_кластера>
      ```

      [Подробнее о том, как получить информацию о пользователе](user-list.md#get).
  
  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "userSpec": {
          "name": "<имя_пользователя>",
          "passwords": [
            "<пароль_пользователя>"
          ],
          "permissions": {
            "patterns": "<разрешения_на_шаблоны_ключей>",
            "pubSubChannels": "<разрешения_на_каналы>",
            "categories": "<разрешения_на_категории_команд>",
            "commands": "<разрешения_на_команды>",
            "sanitizePayload": "<очистка_данных>"
          },
          "enabled": <статус_пользователя>
        }
      }
      ```

      Где `userSpec` — настройки пользователя:
      
      * `name` — имя пользователя.

      * `passwords` — пароль пользователя. Длина пароля — от 8 до 128 символов.
      
        Можно указать только один пароль.
      
      * `permissions` — настройки разрешений пользователя:

        * `patterns` — разрешения на шаблоны ключей, в строку через пробел.
        * `pubSubChannels` — разрешения на каналы Pub/Sub, в строку через пробел.
        * `categories` — разрешения на категории команд, в строку через пробел.
        * `commands` — разрешения на команды, в строку через пробел.
        * `sanitizePayload` — очистка данных. Возможные значения:
          
          * `sanitize-payload` (по умолчанию) — очистка данных включена;
          * `skip-sanitize-payload` — очистка данных отключена.
        
        {% include [user-permissions-note](../../_includes/mdb/mrd/user-permissions-note.md) %}

        Подробнее о списках контроля доступа читайте в [документации {{ VLK }} ACL](https://valkey.io/topics/acl). 

      * `enabled` — статус пользователя. Возможные значения:
        
        * `true` — пользователь включен;
        * `false` — пользователь отключен. 

  1. Воспользуйтесь методом [User.Create](../api-ref/User/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/users' \
        --data "@body.json"
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:
      
      ```json
      {
        "cluster_id": "<идентификатор_кластера>",
        "user_spec": {
          "name": "<имя_пользователя>",
          "passwords": [
            "<пароль_пользователя>"
          ],
          "permissions": {
            "patterns": "<разрешения_на_шаблоны_ключей>",
            "pub_sub_channels": "<разрешения_на_каналы>",
            "categories": "<разрешения_на_категории_команд>",
            "commands": "<разрешения_на_команды>",
            "sanitize_payload": "<очистка_данных>"
          },
          "enabled": <статус_пользователя>
        }
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      
        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `user_spec` — настройки пользователя:
      
        * `name` — имя пользователя.
        
        * `passwords` — пароль пользователя. Длина пароля — от 8 до 128 символов.
          
          Можно указать только один пароль.
      
        * `permissions` — настройки разрешений пользователя:

          * `patterns` — разрешения на шаблоны ключей, в строку через пробел.
          
          * `pub_sub_channels` — разрешения на каналы Pub/Sub, в строку через пробел.
          
          * `categories` — разрешения на категории команд, в строку через пробел.
          
          * `commands` — разрешения на команды, в строку через пробел.
          
          * `sanitize_payload` — очистка данных. Возможные значения:
          
            * `sanitize-payload` (по умолчанию) — очистка данных включена;
            * `skip-sanitize-payload` — очистка данных отключена.
        
          {% include [user-permissions-note](../../_includes/mdb/mrd/user-permissions-note.md) %}

          Подробнее о списках контроля доступа читайте в [документации {{ VLK }} ACL](https://valkey.io/topics/acl).

        * `enabled` — статус пользователя. Возможные значения:
        
          * `true` — пользователь включен;
          * `false` — пользователь отключен.

  1. Воспользуйтесь вызовом [UserService.Create](../api-ref/grpc/User/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}