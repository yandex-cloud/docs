---
title: Как управлять пользователями кластера {{ KF }} в {{ mkf-full-name }}
description: Следуя данной инструкции, вы сможете управлять пользователями кластера {{ KF }}.
---

# Управление пользователями Apache Kafka®

Пользователи в {{ KF }}:
* Разграничивают права доступа [производителей и потребителей](../concepts/producers-consumers.md) данных. [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.

  Производитель или потребитель получает доступ только к тем [топикам](../concepts/topics.md), которые разрешены для его пользователя. Вы можете использовать одного и того же пользователя для нескольких производителей или потребителей: первые получат права на запись в определенные топики, а вторые — на чтение.
* [Управляют топиками](cluster-topics.md#admin-api). Подробнее см. в разделе [{#T}](../concepts/topics.md).

После [создания кластера](cluster-create.md) {{ KF }} вы можете:
* [получить список пользователей в кластере](#list-accounts);
* [создать пользователя](#create-account);
* [изменить настройки пользователя](#update-account):
    * [изменить пароль](#update-password);
    * [выдать права](#grant-permission);
    * [отозвать права](#revoke-permission);
* [импортировать пользователя в {{ TF }}](#import-account);
* [удалить пользователя](#delete-account).

## Получить список пользователей в кластере {#list-accounts}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_users }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Чтобы получить список пользователей, выполните команду:

     ```bash
     {{ yc-mdb-kf }} user list --cluster-name <имя_кластера>
     ```

  1. Чтобы получить подробную информацию по конкретному пользователю, выполните команду:

     ```bash
     {{ yc-mdb-kf }} user get <имя_пользователя> --cluster-name <имя_кластера>
     ```

  Чтобы узнать имя кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.list](../api-ref/User/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/users'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/list.md#yandex.cloud.mdb.kafka.v1.ListUsersResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/List](../api-ref/grpc/User/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.List
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/list.md#yandex.cloud.mdb.kafka.v1.ListUsersResponse).

{% endlist %}

## Создать пользователя {#create-account}

{% note info %}

Для создания пользователя-администратора воспользуйтесь интерфейсами командной строки, [API](../../glossary/rest-api.md) или {{ TF }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать пользователя для производителя или потребителя в кластере:
  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_users }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Введите имя пользователя и пароль.

     {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

  1. [Выдайте права доступа](#grant-permission) к нужным топикам.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать пользователя:

  1. Посмотрите описание команды CLI для создания пользователей:

     ```bash
     {{ yc-mdb-kf }} user create --help
     ```

  1. Создайте пользователя с ролью `producer` для производителя или `consumer` для потребителя и выдайте права доступа к нужным топикам:

     ```bash
     {{ yc-mdb-kf }} user create <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --password <пароль> \
       --permission topic=<имя_топика>,role=<роль_пользователя>,allow_host=<разрешенный_IP-адрес_1>,allow_host=<разрешенный_IP-адрес_2>,...,allow_host=<разрешенный_IP-адрес_N>
     ```

     Параметр `--permission` должен содержать хотя бы одну пару топик-роль, где:
       * `topic` — имя топика.
       * `role` — роль пользователя: `producer`, `consumer`, `admin` или `topic_admin`. [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.
       * `allow_host` — (опционально) IP-адрес, с которого разрешен доступ этому пользователю. Чтобы задать несколько адресов, добавьте нужное количество опций `allow_host` через запятую.

  Чтобы создать [пользователя-администратора](../concepts/topics.md#management) для управления топиками в кластере:

  1. Посмотрите описание команды CLI для создания пользователя:

     ```bash
     {{ yc-mdb-kf }} user create --help
     ```

  1. Создайте пользователя с ролью `admin`, действующей на все (`*`) топики кластера:

     ```bash
     {{ yc-mdb-kf }} user create <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --password <пароль> \
       --permission topic=*,role=admin,allow_host=<разрешенный_IP-адрес_1>,allow_host=<разрешенный_IP-адрес_2>,...,allow_host=<разрешенный_IP-адрес_N>
     ```

  1. Создайте пользователя с ролью `topic_admin`, действующей на все топики кластера с префиксом `pref`:

     ```bash
     {{ yc-mdb-kf }} user create <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --password <пароль> \
       --permission topic=pref*,role=topic_admin
     ```

  {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

  Чтобы узнать имя кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Добавьте ресурс `yandex_mdb_kafka_user`:

     ```hcl
     resource "yandex_mdb_kafka_user" "<имя_пользователя>" {
       cluster_id = "<идентификатор_кластера>"
       name       = "<имя_пользователя>"
       password   = "<пароль>"
       ...
     }
     ```

     {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

  1. [Выдайте права доступа](#grant-permission) к нужным топикам.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.create](../api-ref/User/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/users' \
       --data '{
                 "userSpec": {
                   "name": "<имя_пользователя>",
                   "password": "<пароль_пользователя>",
                   "permissions": [
                     {
                       "topicName": "<имя_топика>",
                       "role": "<уровень_прав_доступа_к_топику>",
                       "allowHosts": [
                         <список_IP-адресов>
                       ]
                     }
                   ]
                 }
               }'
     ```

     Где `userSpec` — настройки нового пользователя {{ KF }}:

     * `name` — имя пользователя.
     * `password` — пароль пользователя.

       {% include [username-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

     * `permissions` — права доступа к топикам. Каждый элемент массива соответствует отдельному топику и имеет следующую структуру:
       * `topicName` — имя или шаблон имени топика:
         * `*` — чтобы разрешить доступ к любым топикам.
         * Полное название топика — чтобы разрешить доступ конкретно к нему. Чтобы узнать название, [получите список топиков в кластере](cluster-topics.md#list-topics).
         * `<префикс>*` — чтобы выдать доступ к топикам, названия которых начинаются с указанного префикса. Допустим, есть топики `topic_a1`, `topic_a2`, `a3`. Если указать значение `topic*`, доступ будет разрешен для топиков `topic_a1` и `topic_a2`.Для указания всех топиков в кластере используйте маску `*`.
       * `role` — роль пользователя: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN` или `ACCESS_ROLE_ADMIN`. Роль `ACCESS_ROLE_ADMIN` доступна только если выбраны все топики (`topicName: "*"`). [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.
       * `allowHosts` — (опционально) список IP-адресов, с которых пользователю разрешен доступ к топику.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Create](../api-ref/grpc/User/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_spec": {
               "name": "<имя_пользователя>",
               "password": "<пароль_пользователя>",
               "permissions": [
                  {
                    "topic_name": "<имя_топика>",
                    "role": "<уровень_прав_доступа_к_топику>",
                    "allow_hosts": [
                      <список_IP-адресов>
                    ]
                  }
               ]
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.Create
     ```

     Где `user_spec` — настройки нового пользователя БД:

     * `name` — имя пользователя.
     * `password` — пароль пользователя.

       {% include [username-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

     * `permissions` — права доступа к топикам. Каждый элемент массива соответствует отдельному топику и имеет следующую структуру:
       * `topic_name` — имя или шаблон имени топика:
         * `*` — чтобы разрешить доступ к любым топикам.
         * Полное название топика — чтобы разрешить доступ конкретно к нему. Чтобы узнать название, [получите список топиков в кластере](cluster-topics.md#list-topics).
         * `<префикс>*` — чтобы выдать доступ к топикам, названия которых начинаются с указанного префикса. Допустим, есть топики `topic_a1`, `topic_a2`, `a3`. Если указать значение `topic*`, доступ будет разрешен для топиков `topic_a1` и `topic_a2`.
       * `role` — роль пользователя: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN` или `ACCESS_ROLE_ADMIN`. Роль `ACCESS_ROLE_ADMIN` доступна только если выбраны все топики (`topicName: "*"`). [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.
       * `allow_hosts` — (опционально) список IP-адресов, с которых пользователю разрешен доступ к топику.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки пользователя {#update-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного пользователя и выберите пункт:

     * **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**, чтобы [указать другой пароль](#update-password) для пользователя.
     * **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**, чтобы [выдать](#grant-permission) или [отозвать](#revoke-permission) права доступа к топикам.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  С помощью CLI можно [изменить пароль](#update-password) пользователя, а также [выдать](#grant-permission) или [отозвать](#revoke-permission) права доступа к топикам.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Найдите в этом файле ресурс `yandex_mdb_kafka_user` для нужного пользователя и внесите правки.

     С помощью {{ TF }} можно [изменить пароль](#update-password) пользователя, а также [выдать](#grant-permission) или [отозвать](#revoke-permission) права доступа к топикам.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.update](../api-ref/User/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                 "updateMask": "permissions",
                 "permissions": [
                   {
                    "topicName": "<имя_топика>",
                    "role": "<уровень_прав_доступа_к_топику>",
                    "allowHosts": [
                      <список_IP-адресов>
                    ]
                  }
                 ]
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        В данном случае указан только один параметр: `permissions`.

     * `permissions` — новый набор прав на доступ к топикам. Каждый элемент массива соответствует отдельному топику и имеет следующую структуру:
       * `topicName` — имя или шаблон имени топика. Чтобы узнать имя, [получите список топиков в кластере](cluster-topics.md#list-topics). Для указания всех топиков в кластере используйте маску `*`.
       * `role` — новая роль пользователя: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN` или `ACCESS_ROLE_ADMIN`. Роль `ACCESS_ROLE_ADMIN` доступна только если выбраны все топики (`topicName: "*"`). [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.
       * `allowHosts` — (опционально) новый список IP-адресов, с которых пользователю разрешен доступ к топику.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

  С помощью метода `User.update` вы также можете [изменить пароль](#update-password) пользователя, а с помощью методов `grantPermission` и `revokePermission` — [выдать](#grant-permission) или [отозвать](#revoke-permission) права доступа к топику.

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Update](../api-ref/grpc/User/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "update_mask": {
               "paths": [
                 "permissions"
               ]
             },
             "permissions": [
               {
                 "topic_name": "<имя_топика>",
                 "role": "<уровень_прав_доступа_к_топику>",
                 "allow_hosts": [
                   <список_IP-адресов>
                 ]
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        В данном случае массив состоит только из одной строки: `permissions`.

     * `permissions` — новый набор прав на доступ к топикам. Каждый элемент массива соответствует отдельному топику и имеет следующую структуру:
       * `topic_name` — имя или шаблон имени топика. Чтобы узнать имя, [получите список топиков в кластере](cluster-topics.md#list-topics). Для указания всех топиков в кластере используйте маску `*`.
       * `role` — новая роль пользователя: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN` или `ACCESS_ROLE_ADMIN`. Роль `ACCESS_ROLE_ADMIN` доступна только если выбраны все топики (`topicName: "*"`). [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.
       * `allow_hosts` — (опционально) новый список IP-адресов, с которых пользователю разрешен доступ к топику.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

  С помощью вызова `UserService/Update` вы также можете [изменить пароль](#update-password) пользователя, а с помощью методов `grantPermission` и `revokePermission` — [выдать](#grant-permission) или [отозвать](#revoke-permission) права доступа к топику.

{% endlist %}

### Изменить пароль пользователя {#update-password}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Задайте новый пароль и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя, выполните следующую команду:

  ```bash
  {{ yc-mdb-kf }} user update <имя_пользователя> \
    --cluster-name <имя_кластера> \
    --password <новый_пароль>
  ```

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

  Чтобы узнать имя кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Найдите в этом файле ресурс `yandex_mdb_kafka_user` для нужного пользователя.
  1. Измените значение поля `password`:

     ```hcl
     resource "yandex_mdb_kafka_user" "<имя_пользователя>" {
       ...
       password = "<пароль>"
       ...
     }
     ```

     {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.update](../api-ref/User/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                 "updateMask": "password",
                 "password": "<новый_пароль_пользователя>"
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        В данном случае указан только один параметр: `password`.

     * `password` — новый пароль пользователя.

       {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Update](../api-ref/grpc/User/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "update_mask": {
               "paths": [
                 "password"
               ]
             },
             "password": "<новый_пароль_пользователя>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        В данном случае массив состоит только из одной строки: `password`.

     * `password` — новый пароль пользователя.

       {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}

### Выдать пользователю права {#grant-permission}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Выберите кластер.
  1. Перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для пользователя, которому нужно выдать права на топик, и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.kafka.button_add-topic }}**. Если такой кнопки нет — значит, для этого пользователя добавлены права на все существующие топики кластера.

     Если на какие-либо топики не нужны права, [их можно отозвать](#revoke-permission).

  1. Выберите нужный топик из выпадающего списка или введите его название:

     1. Укажите в поле **{{ ui-key.yacloud.kafka.label_topic }}**:

        * `*` — чтобы разрешить доступ к любым топикам.
        * Полное название топика — чтобы разрешить доступ конкретно к нему.
        * `<префикс>*` — чтобы выдать доступ к топикам, названия которых начинаются с указанного префикса. Допустим, есть топики `topic_a1`, `topic_a2`, `a3`. Если указать значение `topic*`, доступ будет разрешен для топиков `topic_a1` и `topic_a2`.

     1. Нажмите кнопку **{{ ui-key.yacloud.kafka.button_add-topic }}**.

  1. Нажмите на значок ![image](../../_assets/console-icons/plus.svg) в столбце **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** для нужного топика и выберите роль:
     * `ACCESS_ROLE_CONSUMER`: потребителям, которые используют этого пользователя, будет разрешен доступ к топику.
     * `ACCESS_ROLE_PRODUCER`: производителям, которые используют этого пользователя, будет разрешен доступ к топику.
     * `ACCESS_ROLE_ADMIN`: роль доступна только если выбран доступ к любым топикам.
     * `ACCESS_ROLE_TOPIC_ADMIN`: роль с максимальными правами на управление топиками через [Admin API {{ KF }}](https://kafka.apache.org/documentation/#adminapi).

     Вы можете выбрать роли `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` одновременно — тогда пользователь будет подходить и производителям, и потребителям.

     [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.

     Пользователю также предоставляется доступ к субъектам схем данных. То, какие субъекты доступны, зависит от указанных ролей и топиков. Подробнее читайте в разделе [{#T}](../concepts/managed-schema-registry.md#subjects).

  1. Чтобы выдать права на другие топики — повторите процедуру.
  1. (Опционально) Если права были назначены топику по ошибке — [отзовите их](#revoke-permission).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы выдать права пользователю:
  1. Получите список топиков кластера:

     ```bash
     {{ yc-mdb-kf }} topic list --cluster-name <имя_кластера>
     ```

  1. Выдайте права на доступ к нужным топикам, передав параметры `--permission`:

     ```bash
     {{ yc-mdb-kf }} user update <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --permission topic=<имя_топика>,role=<роль_пользователя>,allow_host=<разрешенный_IP-адрес_1>,allow_host=<разрешенный_IP-адрес_2>,...,allow_host=<разрешенный_IP-адрес_N>
     ```

     Доступны следующие параметры `--permission`:
     * `topic` — имя топика, к которому нужно выдать права доступа.

        Если на какие-либо топики не нужны права, [их можно отозвать](#revoke-permission).

     * `role` — роль пользователя: `producer`, `consumer`, `admin` или `topic_admin`. [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.

       Роль `admin` доступна только если выбраны все топики (`topic=*`).

     * `allow_host` — (опционально) IP-адрес, с которого разрешен доступ этому пользователю. Чтобы задать несколько адресов, добавьте нужное количество опций `allow_host` через запятую.

     При изменении прав пользователя, существующие права удаляются и заменяются новыми. То есть в команде всегда нужно передавать полный список прав, которые должны быть у пользователя.

     Например, чтобы выдать права пользователю `test-user` в кластере `kafka-cli` к топику `topic2` с ролью `producer`, при этом сохранить существующий доступ к топику `topic1`, выполните команду:

     ```bash
     {{ yc-mdb-kf }} user update test-user \
       --cluster-name kafka-cli \
       --permission topic=topic1,role=consumer \
       --permission topic=topic2,role=producer
     ```

     Вместе с доступом к топику пользователю также предоставляется доступ к субъектам схем данных. То, какие субъекты доступны, зависит от указанных ролей и топиков. Подробнее читайте в разделе [{#T}](../concepts/managed-schema-registry.md#subjects).

  Чтобы узнать имя кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Найдите в этом файле ресурс `yandex_mdb_kafka_cluster` для нужного пользователя.
  1. Добавьте блок `permission`:

     ```hcl
     resource "yandex_mdb_kafka_user" "<имя_пользователя>" {
       ...
       permission {
         topic_name  = "<топик>"
         role        = "<роль_пользователя>"
         allow_hosts = [ <список_разрешенных_IP-адресов> ] 
       }
     }
     ```

     Где:

     * `topic_name` — имя топика. Укажите:

       * `*` — чтобы разрешить доступ к любым топикам.
       * Полное название топика — чтобы разрешить доступ конкретно к нему.
       * `<префикс>*` — чтобы выдать доступ к топикам, названия которых начинаются с указанного префикса. Допустим, есть топики `topic_a1`, `topic_a2`, `a3`. Если указать значение `topic*`, доступ будет разрешен для топиков `topic_a1` и `topic_a2`.

     * `role` — роль пользователя: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN` или `ACCESS_ROLE_ADMIN`. Роль `ACCESS_ROLE_ADMIN` доступна только если выбраны все топики (`topicName: "*"`). [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.

     * `allow_hosts` — список IP-адресов, с которых пользователю разрешен доступ к топику.

     Вместе с доступом к топику пользователю также предоставляется доступ к субъектам схем данных. Список доступных субъектов зависит от указанных ролей и топиков. Подробнее см. в разделе [Субъекты в {{ mkf-msr }}](../concepts/managed-schema-registry.md#subjects).

    Если на какие-либо топики не нужны права, [их можно отозвать](#revoke-permission).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.grantPermission](../api-ref/User/grantPermission.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>:grantPermission' \
       --data '{
                 "permission": [
                   {
                    "topicName": "<имя_топика>",
                    "role": "<роль_пользователя>",
                    "allowHosts": [
                      <список_IP-адресов>
                    ]
                  }
                 ]
               }'
     ```

     Где:

     * `permission` — новое право на доступ к топику:
       * `topicName` — имя топика. Чтобы узнать имя, [получите список топиков в кластере](cluster-topics.md#list-topics).
       * `role` — роль пользователя: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN` или `ACCESS_ROLE_ADMIN`. Роль `ACCESS_ROLE_ADMIN` доступна только если выбраны все топики (`topicName: "*"`). [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.
       * `allowHosts` — (опционально) список IP-адресов, с которых пользователю разрешен доступ к топику.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/grantPermission.md#yandex.cloud.operation.Operation).

  Вместе с доступом к топику пользователю также предоставляется доступ к субъектам схем данных. То, какие субъекты доступны, зависит от указанных ролей и топиков. Подробнее читайте в разделе [{#T}](../concepts/managed-schema-registry.md#subjects).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/GrantPermission](../api-ref/grpc/User/grantPermission.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "permission": [
               {
                 "topic_name": "<имя_топика>",
                 "role": "<роль_пользователя>",
                 "allow_hosts": [
                   <список_IP-адресов>
                 ]
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.GrantPermission
     ```

     Где:

     * `permission` — новое право на доступ к топику:
       * `topic_name` — имя или шаблон имени топика. Чтобы узнать имя, [получите список топиков в кластере](cluster-topics.md#list-topics). Для указания всех топиков в кластере используйте маску `*`.
       * `role` — роль пользователя: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN` или `ACCESS_ROLE_ADMIN`. Роль `ACCESS_ROLE_ADMIN` доступна только если выбраны все топики (`topicName: "*"`). [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.
       * `allow_hosts` — (опционально) список IP-адресов, с которых пользователю разрешен доступ к топику.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/grantPermission.md#yandex.cloud.operation.Operation).

  Вместе с доступом к топику пользователю также предоставляется доступ к субъектам схем данных. То, какие субъекты доступны, зависит от указанных ролей и топиков. Подробнее читайте в разделе [{#T}](../concepts/managed-schema-registry.md#subjects).

{% endlist %}

### Отозвать права у пользователя {#revoke-permission}

Если в кластере отозвать у [пользователя-администратора](../concepts/topics.md#management) роль `ACCESS_ROLE_ADMIN`, то будет потеряна возможность управлять топиками. Не отзывайте эту роль или выдайте ее другому пользователю.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Выберите кластер.
  1. Перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Найдите нужный топик в списке топиков.
  1. Удалите роль, которая больше не нужна: нажмите значок ![image](../../_assets/console-icons/xmark.svg) рядом с именем роли. Если нужно отозвать все права на доступ к топику, удалите его из списка: наведите курсор на имя топика и нажмите значок ![image](../../_assets/console-icons/xmark.svg) в конце строки.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы отозвать права доступа к нужным топикам, передайте обновленный список параметров `--permission`:

  ```bash
  {{ yc-mdb-kf }} user update <имя_пользователя> \
    --cluster-name <имя_кластера> \
    --permission topic=<имя_топика>,role=<роль_пользователя>,allow_host=<разрешенный_IP-адрес_1>,allow_host=<разрешенный_IP-адрес_2>,...,allow_host=<разрешенный_IP-адрес_N>
  ```

  При изменении прав пользователя, существующие права удаляются и заменяются новыми. То есть в команде всегда нужно передавать полный список прав, которые должны быть у пользователя.

  Параметр `--permission` должен содержать хотя бы одну пару топик-роль, где:

  * `topic` — имя топика.
  * `role` — роль пользователя: `producer`, `consumer`, `admin` или `topic_admin`. [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.
  * `allow_host` — (опционально) IP-адрес, с которого разрешен доступ этому пользователю. Чтобы задать несколько адресов, добавьте нужное количество опций `allow_host` через запятую.

  Чтобы узнать имя кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

  Чтобы отозвать у пользователя все имеющиеся права доступа, воспользуйтесь консолью или удалите пользователя.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Найдите в этом файле ресурс `yandex_mdb_kafka_user` для нужного пользователя.
  1. Измените или удалите блок `permission`.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.revokePermission](../api-ref/User/revokePermission.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>:revokePermission' \
       --data '{
                 "permission": [
                   {
                    "topicName": "<имя_топика>",
                    "role": "<роль_пользователя>",
                    "allowHosts": [
                      <список_IP-адресов>
                    ]
                  }
                 ]
               }'
     ```

     Где:

     * `permission` — отзываемое право на доступ к топику:
       * `topicName` — имя топика. Чтобы узнать имя, [получите список топиков в кластере](cluster-topics.md#list-topics).
       * `role` — роль пользователя, которую требуется отозвать: `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_ADMIN` или `ACCESS_ROLE_TOPIC_ADMIN`.
       * `allowHosts` – (опционально) список IP-адресов, с которых пользователю будет отозван доступ к топику.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/revokePermission.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/RevokePermission](../api-ref/grpc/User/revokePermission.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "permission": [
               {
                 "topic_name": "<имя_топика>",
                 "role": "<роль_пользователя>",
                 "allow_hosts": [
                   <список_IP-адресов>
                 ]
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.RevokePermission
     ```

     Где:

     * `permission` — отзываемое право на доступ к топику:
       * `topic_name` — имя или шаблон имени топика. Чтобы узнать имя, [получите список топиков в кластере](cluster-topics.md#list-topics).
       * `role` — роль пользователя, которую требуется отозвать: `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_ADMIN` или `ACCESS_ROLE_TOPIC_ADMIN`.
       * `allow_hosts` — (опционально) список IP-адресов, доступ к топику с которых будет отозван у пользователя.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/revokePermission.md#yandex.cloud.operation.Operation).

{% endlist %}

## Импортировать пользователя в {{ TF }} {#import-account}

С помощью импорта вы можете передать существующих в кластере пользователей под управление {{ TF }}.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. Укажите в конфигурационном файле {{ TF }} пользователя, которого необходимо импортировать:

        ```hcl
        resource "yandex_mdb_kafka_user" "<имя_пользователя>" {}
        ```

    1. Выполните команду для импорта пользователя:

        ```hcl
        terraform import yandex_mdb_kafka_user.<имя_пользователя> <идентификатор_кластера>:<имя_пользователя>
        ```

        Подробнее об импорте пользователей см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_user#import).

{% endlist %}

## Удалить пользователя {#delete-account}

Если в кластере удалить [пользователя-администратора](../concepts/topics.md#management) с ролью `ACCESS_ROLE_ADMIN`, то будет потеряна возможность управлять топиками. Перед удалением выдайте эту роль другому пользователю.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить пользователя, выполните команду:

  ```bash
  {{ yc-mdb-kf }} user delete <имя_пользователя> --cluster-name <имя_кластера>
  ```

  Чтобы узнать имя кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Удалите ресурс `yandex_mdb_kafka_user` для нужного пользователя.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.delete](../api-ref/User/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Delete](../api-ref/grpc/User/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.Delete
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-accounts).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation).

{% endlist %}
