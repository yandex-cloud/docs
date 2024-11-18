---
title: Как управлять схемами формата данных в {{ mch-name }}
description: Следуя данной инструкции, вы научитесь управлять схемами формата данных в {{ mch-name }}.
---

# Управление схемами формата данных в {{ mch-name }}

{% include [Format schemas intro](../../_includes/mdb/mch/format-schemas-intro.md) %}

Примеры работы с форматами Cap'n Proto и Protobuf при вставке данных в кластер приведены в разделе [Добавление данных в кластер](../tutorials/insert.md).

## Перед подключением схемы формата данных {#prereq}

{{ mch-name }} работает только со схемами формата данных, которые загружены в {{ objstorage-full-name }} и к которым предоставлен доступ на чтение. Перед подключением схемы к кластеру:

1. Подготовьте файл со схемой формата (см. документацию [Cap'n Proto](https://capnproto.org/language.html) и [Protobuf](https://developers.google.com/protocol-buffers/docs/tutorials?hl=ru)).


1. Для привязки [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) к кластеру [убедитесь](../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в {{ yandex-cloud }} назначена роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.
1. [Загрузите](../../storage/operations/objects/upload.md) файл со схемой формата данных в {{ objstorage-full-name }}.
1. [Подключите сервисный аккаунт к кластеру](s3-access.md#connect-service-account). С помощью сервисного аккаунта вы настроите доступ к файлу схемы.
1. [Назначьте роль](s3-access.md#configure-acl) `storage.viewer` сервисному аккаунту.
1. В ACL бакета [добавьте разрешение](../../storage/operations/buckets/edit-acl.md) `READ` сервисному аккаунту.
1. [Получите ссылку](s3-access.md#get-link-to-object) на файл схемы.


## Создать схему формата данных {#add-format-schema}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_format-schemas }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.format-schemas.button-action_add-format-schema }}**.
    1. В диалоговом окне **{{ ui-key.yacloud.clickhouse.cluster.format-schemas.dialog.title_add }}** заполните форму, указав в поле **{{ ui-key.yacloud.clickhouse.cluster.format-schemas.dialog.field_format-schema-uri }}** полученную ранее ссылку на файл со схемой формата.
    1. Нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.format-schemas.dialog.label_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать схему формата данных, выполните команду:
  - для формата **Cap'n Proto**:

    ```bash
    {{ yc-mdb-ch }} format-schema create "<имя_схемы_формата>" \
      --cluster-name="<имя_кластера>" \
      --type="capnproto" \
      --uri="<ссылка_на_файл_в_Object_Storage>"
    ```

  - для формата **Protobuf**:

    ```bash
    {{ yc-mdb-ch }} format-schema create "<имя_схемы_формата>" \
      --cluster-name="<имя_кластера>" \
      --type="protobuf" \
      --uri="<ссылка_на_файл_в_Object_Storage>"
    ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `format_schema`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          format_schema {
            name = "<имя_схемы>"
            type = "<тип_схемы>"
            uri  = "<ссылка_на_файл_схемы_формата_данных_в_Object_Storage>"
          }
        }
        ```

        Где `type` — тип схемы: `FORMAT_SCHEMA_TYPE_CAPNPROTO` или `FORMAT_SCHEMA_TYPE_PROTOBUF`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    Чтобы создать схему формата данных, воспользуйтесь методом REST API [create](../api-ref/FormatSchema/create.md) для ресурса [FormatSchema](../api-ref/FormatSchema/index.md) или вызовом gRPC API [FormatSchemaService/Create](../api-ref/grpc/FormatSchema/create.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя схемы формата в параметре `formatSchemaName`.
    * Тип схемы: `FORMAT_SCHEMA_TYPE_CAPNPROTO` или `FORMAT_SCHEMA_TYPE_PROTOBUF` в параметре `type`.
    * Ссылку на файл в {{ objstorage-full-name }} в параметре `uri`.

{% endlist %}

## Изменить схему формата данных {#update-format-schema}

{{ mch-name }} не отслеживает изменения в файле со схемой формата данных, который находится в бакете {{ objstorage-full-name }}.

Чтобы актуализировать содержимое схемы, которая уже подключена к кластеру:


1. [Загрузите файл](../../storage/operations/objects/upload.md) с актуальной схемой формата данных в {{ objstorage-full-name }}.
1. [Получите ссылку](s3-access.md#get-link-to-object) на этот файл.
1. Измените параметры схемы формата данных, подключенной к {{ mch-name }}, передав новую ссылку на файл со схемой формата.


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_format-schemas }}**.
    1. Выберите нужную схему, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить ссылку на файл в объектном хранилище со схемой формата данных, выполнив команду:

    ```bash
    {{ yc-mdb-ch }} format-schema update "<имя_схемы_данных>" \
      --cluster-name="<имя_кластера>" \
      --uri="<новая_ссылка_на_файл_в_Object_Storage>"
    ```

    Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `uri` в блоке `format_schema`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          format_schema {
            name = "<имя_схемы>"
            type = "<тип_схемы>"
            uri  = "<новая_ссылка_на_файл_схемы_в_Object_Storage>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

        {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    Чтобы изменить схему формата данных, воспользуйтесь методом REST API [update](../api-ref/FormatSchema/update.md) для ресурса [FormatSchema](../api-ref/FormatSchema/index.md) или вызовом gRPC API [FormatSchemaService/Update](../api-ref/grpc/FormatSchema/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя схемы формата в параметре `formatSchemaName`. Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas).
    * Новую ссылку на файл в {{ objstorage-full-name }} в параметре `uri`.
    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

        {% include [Сброс настроек изменяемого объекта](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Отключить схему формата данных {#disable-format-schema}

{% note info %}


После отключения схемы формата данных соответствующий объект остается в бакете {{ objstorage-full-name }}. Если этот объект со схемой формата больше не нужен, его можно [удалить](../../storage/operations/objects/delete.md).


{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_format-schemas }}**.
   1. Выберите нужную схему, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы отключить схему формата данных, выполните команду:

  ```bash
  {{ yc-mdb-ch }} format-schema delete "<имя_схемы_формата>" \
    --cluster-name="<имя_кластера>"
  ```

  Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок описания нужной схемы формата данных `format_schema`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    Чтобы удалить схему формата данных, воспользуйтесь методом REST API [delete](../api-ref/FormatSchema/delete.md) для ресурса [FormatSchema](../api-ref/FormatSchema/index.md) или вызовом gRPC API [FormatSchemaService/Delete](../api-ref/grpc/FormatSchema/delete.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя схемы формата в параметре `formatSchemaName`. Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas).

{% endlist %}

## Получить список схем формата данных в кластере {#list-format-schemas}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_format-schemas }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список схем формата данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} format-schema list --cluster-name="<имя_кластера>"
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить список схем формата данных, воспользуйтесь методом REST API [list](../api-ref/FormatSchema/list.md) для ресурса [FormatSchema](../api-ref/FormatSchema/index.md) или вызовом gRPC API [FormatSchemaService/List](../api-ref/grpc/FormatSchema/list.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Получить детальную информацию о схеме формата данных {get-format-schema}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить детальную информацию о схеме формата данных, выполните команду:

  ```bash
  {{ yc-mdb-ch }} format-schema get "<имя_схемы_формата>" \
    --cluster-name="<имя_кластера>"
  ```

  Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить детальную информацию о схеме формата данных, воспользуйтесь методом REST API [get](../api-ref/FormatSchema/get.md) для ресурса [FormatSchema](../api-ref/FormatSchema/index.md) или вызовом gRPC API [FormatSchemaService/Get](../api-ref/grpc/FormatSchema/get.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя схемы формата в параметре `formatSchemaName`. Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
