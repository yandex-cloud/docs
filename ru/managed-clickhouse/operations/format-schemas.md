# Управление схемами формата данных

{% include [Format schemas intro](../../_includes/mdb/mch/format-schemas-intro.md) %}

Примеры работы с форматами Cap'n Proto и Protobuf при вставке данных в кластер приведены в разделе [{#T}](insert.md).

## Перед подключением схемы формата данных {#prereq}

{{ mch-name }} работает только со схемами формата данных, которые загружены в {{ objstorage-full-name }} и к которым предоставлен доступ на чтение. Перед подключением схемы к кластеру:

1. Подготовьте файл со схемой формата (см. документацию [Cap'n Proto](https://capnproto.org/language.html) и [Protobuf](https://developers.google.com/protocol-buffers/docs/tutorials?hl=ru)).

{% if audience != "internal" %}

1. [Загрузите](../../storage/operations/objects/upload.md) файл со схемой формата данных в {{ objstorage-full-name }}.

1. Настройте доступ к файлу схемы одним из способов:

    * Используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) (рекомендуется). Этот способ позволяет получить доступ к файлу без ввода учетных данных.

        1\. [Подключите сервисный аккаунт к кластеру](s3-access.md#connect-service-account).
        2\. [Назначьте аккаунту роль](s3-access.md#configure-acl) `storage.viewer`.
        3\. В ACL бакета [добавьте аккаунту разрешение](../../storage/operations/buckets/edit-acl.md) `READ`.

    * [Включите публичный доступ](../../storage/operations/objects/edit-acl.md) к бакету с файлом.

1. [Получите ссылку](s3-access.md#get-link-to-object) на файл схемы.

{% else %}

1. Загрузите файл со схемой формата в {{ objstorage-full-name }}.

1. Настройте публичный доступ на чтение к файлу схемы формата данных.

1. Получите ссылку на файл схемы.

{% endif %}

## Подключить схему формата данных {#add-format-schema}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Схемы формата данных**.
    1. Нажмите кнопку **Добавить схему**.
    1. В диалоговом окне **Добавление схемы** заполните форму, указав в поле **URL** полученную ранее ссылку на файл со схемой формата.
    1. Нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы подключить схему формата данных к кластеру, выполните команду:
  - для формата **Cap'n Proto**:

    ```bash
    {{ yc-mdb-ch }} format-schema create "<имя схемы формата>" \
      --cluster-name="<имя кластера>" \
      --type="capnproto" \
      --uri="<ссылка на файл в {{ objstorage-full-name }}>"
    ```

  - для формата **Protobuf**:

    ```bash
    {{ yc-mdb-ch }} format-schema create "<имя схемы формата>" \
      --cluster-name="<имя кластера>" \
      --type="protobuf" \
      --uri="<ссылка на файл в {{ objstorage-full-name }}>"
    ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `format_schema`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          format_schema {
            name = "<имя схемы>"
            type = "<тип схемы: FORMAT_SCHEMA_TYPE_CAPNPROTO или FORMAT_SCHEMA_TYPE_PROTOBUF>"
            uri  = "<ссылка на файл схемы формата данных в {{ objstorage-full-name }}>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

{% endlist %}

## Изменить схему формата данных {#update-format-schema}

{{ mch-name }} не отслеживает изменения в файле со схемой формата данных, который находится в бакете {{ objstorage-full-name }}.

Чтобы актуализировать содержимое схемы, которая уже подключена к кластеру:

{% if audience != "internal" %}

1. [Загрузите файл](../../storage/operations/objects/upload.md) с актуальной схемой формата данных в {{ objstorage-full-name }}.
1. [Получите ссылку](s3-access.md#get-link-to-object) на этот файл.
1. Измените параметры схемы формата данных, подключенной к {{ mch-name }}, передав новую ссылку на файл со схемой формата.

{% else %}

1. Загрузите файл с актуальной схемой формата данных в {{ objstorage-full-name }}.
1. Получите ссылку на этот файл.
1. Измените параметры схемы формата данных, подключенной к {{ mch-name }}, передав новую ссылку на файл со схемой формата.

{% endif %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Схемы формата данных**.
    1. Выберите нужную схему, нажмите значок ![image](../../_assets/options.svg) и выберите пункт **Изменить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить ссылку на файл в объектном хранилище со схемой формата данных, выполнив команду:

    ```bash
    {{ yc-mdb-ch }} format-schema update "<имя схемы данных>" \
      --cluster-name="<имя кластера>" \
      --uri="<новая ссылка на файл в {{ objstorage-full-name }}>"
    ```

    Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `uri` в блоке `format_schema`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          format_schema {
            name = "<имя схемы>"
            type = "<тип схемы>"
            uri  = "<новая ссылка на файл схемы в {{ objstorage-full-name }}>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_clickhouse_cluster).

        {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

{% endlist %}

## Отключить схему формата данных {#disable-format-schema}

{% note info %}

{% if audience != "internal" %}

После отключения схемы формата данных соответствующий объект остается в бакете {{ objstorage-full-name }}. Если этот объект со схемой формата больше не нужен, его можно [удалить](../../storage/operations/objects/delete.md).

{% else %}

После отключения схемы формата данных соответствующий объект остается в бакете {{ objstorage-full-name }}. Если этот объект со схемой формата больше не нужен, его можно удалить.

{% endif %}

{% endnote %}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
   1. Нажмите на имя нужного кластера и выберите вкладку **Схемы формата данных**.
   1. Выберите нужную схему, нажмите значок ![image](../../_assets/options.svg) и выберите пункт **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы отключить схему формата данных, выполните команду:

  ```bash
  {{ yc-mdb-ch }} format-schema delete "<имя схемы формата>" \
    --cluster-name="<имя кластера>"
  ```

  Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок описания нужной схемы формата данных `format_schema`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

{% endlist %}

## Получить список схем формата данных в кластере {#list-format-schemas}

{% list tabs %}

 - Консоль управления

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
   1. Нажмите на имя нужного кластера и выберите вкладку **Схемы формата данных**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список схем формата данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} format-schema list --cluster-name="<имя кластера>"
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Получить детальную информацию о схеме формата данных {get-format-schema}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить детальную информацию о схеме формата данных, выполните команду:

  ```bash
  {{ yc-mdb-ch }} format-schema get "<имя схемы формата>" \
    --cluster-name="<имя кластера>"
  ```

  Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
