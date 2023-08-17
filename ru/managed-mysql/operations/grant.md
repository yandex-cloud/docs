---
title: "Управление правами пользователей MySQL"
description: "Вы можете управлять правами пользователей MySQL на уровне отдельной базы данных, изменяя привилегии пользователей. Пользователи могут иметь разные наборы привилегий для разных баз данных. Чтобы узнать подробнее про поддерживаемые привилегии, см. описание привилегий."
---
# Управление правами пользователей

Вы можете управлять правами пользователей на уровне отдельной базы данных, изменяя [привилегии пользователей](../concepts/user-rights.md).

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Изменить привилегии пользователя {#grant-privilege}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/mdb/user.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.

  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.

  1. При необходимости добавьте пользователю нужные базы данных:

     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}**.
     1. Выберите базу данных из выпадающего списка.
     1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
     1. Чтобы отозвать доступ к определенной базе, удалите ее из перечня, нажав значок ![image](../../_assets/cross.svg) справа от имени базы данных.

  1. Задайте нужные привилегии пользователя для каждой из баз данных пользователя:

     1. Нажмите значок ![image](../../_assets/plus-sign.svg) в столбце **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}**.
     1. Выберите привилегию, которую вы хотите добавить пользователю из выпадающего списка.
     1. Повторите два предыдущих шага, пока не будут добавлены все требуемые привилегии.

  1. Чтобы отозвать привилегию, нажмите значок ![image](../../_assets/cross.svg) справа от ее имени.
  1. При необходимости задайте [административные привилегии](../concepts/settings-list.md#setting-administrative-privileges) для пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  * Добавить привилегии пользователю:

      ```bash
      {{ yc-mdb-my }} user grant-permission <имя пользователя> \
        --cluster-name <имя кластера> \
        --database <имя базы данных> \
        --permissions <набор привилегий через запятую>
      ```

      Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md), имя базы данных — со [списком баз данных в кластере](databases.md#list-db), имя пользователя — со [списком пользователей в кластере](cluster-users.md#list-users).

  * Отозвать привилегии у пользователя:

      ```bash
      {{ yc-mdb-my }} user revoke-permission <имя пользователя> \
        --cluster-name <имя кластера> \
        --database <имя базы данных> \
        --permissions <набор привилегий через запятую>
      ```

      Чтобы добавить или отозвать привилегию `ALL_PRIVILEGES`, передайте в качестве названия синоним `ALL`.

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Найдите ресурс `yandex_mdb_mysql_user` нужного пользователя и измените список его привилегий для требуемой БД в параметре `roles`:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя пользователя>" {
        cluster_id = "<идентификатор кластера>"
        name       = "<имя пользователя>"
        permission {
          database_name = "<имя БД, к которой пользователь должен иметь доступ>"
          roles         = [<список привилегий пользователя по отношению к БД>]
        }
        ...
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_user).

- API

  Чтобы изменить привилегии пользователя, воспользуйтесь методом REST API [update](../api-ref/User/update.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Update](../api-ref/grpc/user_service.md#Update) и передайте в запросе:

  * Идентификатор кластера, в котором находится пользователь, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](cluster-users.md#list-users).
  * Имя базы данных, для которой вы хотите изменить список привилегий пользователя, в параметре `permissions.databaseName`. Чтобы узнать имя, [получите список баз данных в кластере](databases.md#list-db).
  * Новый список привилегий пользователя, представленный в виде массива, в параметре `permissions.roles`.
  * Список полей конфигурации пользователя, которые необходимо изменить (в данном случае — `permissions`), в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
