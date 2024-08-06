---
title: "Как управлять пользователями кластера {{ KF }} в {{ mkf-full-name }}"
description: "Следуя данной инструкции, вы сможете управлять пользователями кластера {{ KF }}." 
---

# Управление пользователями Apache Kafka®

Пользователи в {{ KF }}:
* Разграничивают права доступа [производителей и потребителей](../concepts/producers-consumers.md) данных.

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


- API {#api}

  Чтобы получить список пользователей, воспользуйтесь методом REST API [list](../api-ref/User/list.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/List](../api-ref/grpc/user_service.md#List) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](#list-clusters).


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
       --permission topic=<имя_топика>,role=<роль_пользователя>
     ```

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
       --permission topic=*,role=admin
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


- API {#api}

  Чтобы создать пользователя, воспользуйтесь методом REST API [create](../api-ref/User/create.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Create](../api-ref/grpc/user_service.md#Create) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки пользователя в параметре `userSpec`:
    * Имя пользователя в параметре `name`.
    * Пароль пользователя в параметре `password`.
    * Права доступа к топикам (один или несколько параметров `permissions`, по одному на каждый топик):
      * Имя топика в параметре `topicName`. Чтобы узнать имя, [получите список топиков в кластере](cluster-topics.md#list-topics).
      * Права доступа к топику в параметре `role`: `ACCESS_ROLE_PRODUCER` для производителя либо `ACCESS_ROLE_CONSUMER` для потребителя.

  Чтобы создать [пользователя-администратора](../concepts/topics.md#management) для управления топиками в кластере, при создании пользователя передайте в параметре `userSpec` блок `permission` со следующими значениями:
  * `topicName`: `*`.
  * `role`: `ACCESS_ROLE_ADMIN`.

  {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}


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


- API {#api}

  Чтобы изменить настройки пользователя, воспользуйтесь методом REST API [update](../api-ref/User/update.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Update](../api-ref/grpc/user_service.md#Update) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-accounts).
  * Список настроек, которые необходимо изменить, в параметре `updateMask` (одной строкой через запятую). Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки пользователя, которые не были явно указаны в запросе.
  * Новый набор прав на доступ к топикам (один или несколько параметров `permissions`, по одному на каждый топик).

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

  С помощью метода `update` вы также можете [изменить пароль](#update-password) пользователя, а с помощью методов `grantPermission` и `revokePermission` — [выдать](#grant-permission) или [отозвать](#revoke-permission) права доступа к топику.


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


- API {#api}

  Чтобы изменить пароль пользователя, воспользуйтесь методом REST API [update](../api-ref/User/update.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Update](../api-ref/grpc/user_service.md#Update) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-accounts).
  * Новый пароль пользователя в параметре `password`.
  * Название настройки `password` в параметре `updateMask`.

    {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


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

     Вы можете выбрать роли `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` одновременно — тогда пользователь будет подходить и производителям, и потребителям.

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
       --permission topic=<имя_топика>,role=<роль_пользователя>
     ```

     Доступны следующие параметры `--permission`:
     * `topic` — имя топика, к которому нужно выдать права доступа.

        Если на какие-либо топики не нужны права, [их можно отозвать](#revoke-permission).

     * `role` — роль пользователя: `producer`, `consumer` или `admin`.

       Роль `admin` доступна только если выбраны все топики (`topic=*`).

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
         topic_name = "<топик>"
         role       = "<роль_пользователя>"
       }
     }
     ```

     Где:

     * `topic_name` — имя топика. Укажите:

       * `*` — чтобы разрешить доступ к любым топикам.
       * Полное название топика — чтобы разрешить доступ конкретно к нему.
       * `<префикс>*` — чтобы выдать доступ к топикам, названия которых начинаются с указанного префикса. Допустим, есть топики `topic_a1`, `topic_a2`, `a3`. Если указать значение `topic*`, доступ будет разрешен для топиков `topic_a1` и `topic_a2`.

     * `role` — роль пользователя: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER` или `ACCESS_ROLE_ADMIN`. Роль `ACCESS_ROLE_ADMIN` доступна только если выбраны все топики (`topic_name = "*"`).

     Вместе с доступом к топику пользователю также предоставляется доступ к субъектам схем данных. То, какие субъекты доступны, зависит от указанных ролей и топиков. Подробнее читайте в разделе [{#T}](../concepts/managed-schema-registry.md#subjects).

     Если на какие-либо топики не нужны права, [их можно отозвать](#revoke-permission).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API {#api}

  Чтобы выдать пользователю права, воспользуйтесь методом REST API [grantPermission](../api-ref/User/grantPermission.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/GrantPermission](../api-ref/grpc/user_service.md#GrantPermission) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-accounts).
  * Новое право на доступ к топику в параметре `permission`.

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
    --permission topic=<имя_топика>,role=<роль_пользователя>
  ```

  При изменении прав пользователя, существующие права удаляются и заменяются новыми. То есть в команде всегда нужно передавать полный список прав, которые должны быть у пользователя.

  Флаг `--permission` должен содержать хотя бы одну пару топик/роль, где:

  * `topic` — имя топика.
  * `role` — роль пользователя: `producer`, `consumer` или `admin`.

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


- API {#api}

  Чтобы отозвать права у пользователя, воспользуйтесь методом REST API [revokePermission](../api-ref/User/revokePermission.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/RevokePermission](../api-ref/grpc/user_service.md#RevokePermission) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-accounts).
  * Право на доступ к топику, которое требуется отозвать, в параметре `permission`.


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


- API {#api}

  Чтобы удалить пользователя, воспользуйтесь методом REST API [delete](../api-ref/User/delete.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Delete](../api-ref/grpc/user_service.md#Delete) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя, которого требуется удалить, в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-accounts).


{% endlist %}
