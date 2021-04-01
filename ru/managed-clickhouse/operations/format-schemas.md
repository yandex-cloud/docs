# Управление схемами формата данных

{% include [mch-format-schemas-intro](../../_includes/mdb/mch-format-schemas-intro.md) %}

Примеры работы с форматами Cap'n Proto и Protobuf при вставке данных в кластер приведены в разделе [{#T}](insert.md).

## Перед подключением схемы формата данных {#prereq}

{{ mch-name }} работает только со схемами формата данных, которые загружены в {{ objstorage-name }}. Перед подключением схемы к кластеру:

1. Подготовьте файл со схемой формата (см. документацию [Cap'n Proto](https://capnproto.org/language.html) и [Protobuf](https://developers.google.com/protocol-buffers/docs/tutorials?hl=ru)).
1. [Загрузите файл](../../storage/operations/objects/upload.md) со схемой формата в {{ objstorage-name }}.
1. [Получите ссылку](../../storage/operations/objects/link-for-download.md) на этот файл.

## Подключить схему формата данных {#add-format-schema}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
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
        --uri="<ссылка на файл в {{ objstorage-name }}>"
    ```

  - для формата **Protobuf**:

    ```bash
    {{ yc-mdb-ch }} format-schema create "<имя схемы формата>" \
        --cluster-name="<имя кластера>" \
        --type="protobuf" \
        --uri="<ссылка на файл в {{ objstorage-name }}>"
    ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

    Чтобы подключить схему формата данных к кластеру:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `format_schema`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          format_schema {
            name = "<имя схемы>"
            type = "<тип схемы: FORMAT_SCHEMA_TYPE_CAPNPROTO или FORMAT_SCHEMA_TYPE_PROTOBUF>"
            uri  = "<публичная ссылка на файл схемы в {{ objstorage-name }}>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

{% endtabs %}

## Изменить схему формата данных {#update-format-schema}

{{ mch-name }} не отслеживает изменения в файле со схемой формата данных, который находится в бакете {{ objstorage-name }}.

Чтобы актуализировать содержимое схемы, которая уже подключена к кластеру:

1. [Загрузите файл](../../storage/operations/objects/upload.md) с актуальной схемой формата данных в {{ objstorage-name }}.
1. [Получите ссылку](../../storage/operations/objects/link-for-download.md) на этот файл.
1. Измените параметры схемы формата данных, подключенной к {{ mch-name }}, передав новую ссылку на файл со схемой формата.

   {% list tabs %}

    - Консоль управления

      1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
      1. Нажмите на имя нужного кластера и выберите вкладку **Схемы формата данных**.
      1. Выберите нужную схему, нажмите значок ![image](../../_assets/dots.svg) и выберите пункт **Изменить**.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Чтобы изменить ссылку на файл в объектном хранилище со схемой формата данных, выполнив команду:

     ```bash
     {{ yc-mdb-ch }} format-schema update "<имя схемы данных>" \
         --cluster-name="<имя кластера>" \
         --uri="<новая ссылка на файл в {{ objstorage-name }}>"
     ```

     Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    - Terraform

        Чтобы изменить схему формата данных:

        1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

            О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

        1. Измените в описании кластера {{ mch-name }} значение параметра `uri` в блоке `format_schema`:

            ```hcl
            resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
              ...
              format_schema {
                name = "<имя схемы>"
                type = "<тип схемы>"
                uri  = "<новая публичная ссылка на файл схемы в {{ objstorage-name }}>"
              }
            }
            ```

        1. Проверьте корректность настроек.

            {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

   {% endtabs %}

## Отключить схему формата данных {#disable-format-schema}

{% note info %}

После отключения схемы формата данных соответствующий объект остается в бакете {{ objstorage-name }}. Если этот объект со схемой формата больше не нужен, его можно [удалить](../../storage/operations/objects/delete.md).

{% endnote %}

{% list tabs %}

- Консоль управления

   1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
   1. Нажмите на имя нужного кластера и выберите вкладку **Схемы формата данных**.
   1. Выберите нужную схему, нажмите значок ![image](../../_assets/dots.svg) и выберите пункт **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы отключить схему формата данных, выполните команду:

  ```bash
  {{ yc-mdb-ch }} format-schema delete "<имя схемы формата>" \
      --cluster-name="<имя кластера>"
  ```

  Имя схемы можно запросить со [списком схем формата данных в кластере](#list-format-schemas); имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

    Чтобы отключить схему формата данных:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок описания нужной схемы формата данных `format_schema`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

{% endtabs %}

## Получить список схем формата данных в кластере {#list-format-schemas}

{% list tabs %}

 - Консоль управления

   1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
   1. Нажмите на имя нужного кластера и выберите вкладку **Схемы формата данных**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список схем формата данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} format-schema list --cluster-name="<имя кластера>"
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endtabs %}

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

{% endtabs %}
