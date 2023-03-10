# Управление эндпоинтами

[Эндпоинт](../../concepts/index.md#endpoint)-источник описывает настройки базы данных, из которой будет передаваться информация с помощью {{ data-transfer-name }}, а эндпоинт-приемник — базы, в которую будет производиться перенос. Вы можете [создать](#create), [изменить](#update) или [удалить](#delete) такие эндпоинты.

## Создать эндпоинт {#create}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. Нажмите кнопку **Создать эндпоинт**.
    1. В поле **Направление** выберите **Источник** или **Приемник**.
    1. Укажите имя эндпоинта. Используйте строчные латинские буквы и цифры.
    1. (опционально) Укажите описание эндпоинта.
    1. Выберите нужное значение в поле **Тип базы данных**. Будет создан эндпоинт соответствующего типа.
    1. Задайте параметры эндпоинта:
        * Источники:
            * Airbyte®:
                * [AWS CloudTrail](source/aws-cloudtrail.md)
                * [BigQuery](source/bigquery.md)
                * [S3](source/s3.md)
            * [{{ KF }}](source/kafka.md)
            * [{{ CH }}](source/clickhouse.md)
            * [{{ eventhub-name }}](source/eventhub.md)
            * [{{ GP }}](source/greenplum.md)
            * [{{ MG }}](source/mongodb.md)
            * [{{ MY }}](source/mysql.md)
            * [Oracle](source/oracle.md)
            * [{{ PG }}](source/postgresql.md)
             * [{{ yds-full-name }}](source/data-streams.md)
            * [{{ ydb-full-name }}](source/ydb.md)
        * Приемники:
            * [{{ KF }}](target/kafka.md)
            * [{{ CH }}](target/clickhouse.md)
            * [{{ ES }}](target/elasticsearch.md)
            * [{{ GP }}](target/greenplum.md)
            * [{{ MG }}](target/mongodb.md)
            * [{{ MY }}](target/mysql.md)
            * [{{ objstorage-name }}](target/object-storage.md)
            * [{{ OS }}](target/opensearch.md)
            * [{{ PG }}](target/postgresql.md)
            * [{{ yds-full-name }}](target/data-streams.md)
            * [{{ ydb-full-name }}](target/yandex-database.md)
    1. Нажмите кнопку **Создать**.

- CLI

    {% note info %}

    Создание эндпоинта с помощью команд CLI поддерживается только для источников и приемников типа {{ MY }} и {{ PG }}.

    {% endnote %}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать эндпоинт:

    1. Посмотрите описание команды CLI для создания эндпоинта:

        ```bash
        {{ yc-dt }} endpoint create --help
        ```

    1. Укажите параметры эндпоинта в команде создания (в примере приведены не все параметры):

        ```bash
        {{ yc-dt }} endpoint create <тип эндпоинта> \
          --name <имя эндпоинта> \
          --description <описание эндпоинта> \
          <параметры эндпоинта>
        ```

        Тип эндпоинта и его параметры см. в разделе настроек для нужного источника или приемника данных.

- {{ TF }}
        {% note info %}

    Создание эндпоинта с помощью {{ TF }} поддерживается только для источников и приемников типа {{ MY }}, {{ PG }}, {{ MG }} и {{ CH }}.

    {% endnote %}

    
    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
 
    Чтобы создать эндпоинт:

    1. В командной строке перейдите в директорию, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.
       
    1. Если у вас еще нет {{ TF }}, [установите его и создайте конфигурационный файл с настройками провайдера](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Создайте конфигурационный файл с описанием эндпоинта.

       Пример структуры конфигурационного файла:

       ```hcl
       resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
         name = "<имя эндпоинта>"
         settings {
           <тип эндпоинта> {
             <параметры эндпоинта>
           }
         }
       }
       ```

    1. Тип эндпоинта и его параметры см. в разделе настроек для нужного источника или приемника данных.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
     
        
    1. Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).
    

- API

    {% note info %}

    Создание эндпоинта с помощью [API](../../../glossary/rest-api.md) поддерживается только для источников и приемников типа {{ MY }} и {{ PG }}.

    {% endnote %}

    Воспользуйтесь методом API [create](../../api-ref/Endpoint/create) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен эндпоинт, в параметре `folderId`.
    * Имя эндпоинта в параметре `name`.
    * Описание эндпоинта в параметре `description`.
    * Параметры эндпоинта в параметре `settings`.

    Параметры эндпоинта см. в разделе настроек для нужного источника или приемника данных.

{% endlist %}

## Изменить эндпоинт {#update}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. Выберите эндпоинт и нажмите кнопку ![pencil](../../../_assets/pencil.svg) **Редактировать** на панели сверху.
    1. Отредактируйте параметры эндпоинта:
        * Источники:
            * Airbyte®:
                * [AWS CloudTrail](source/aws-cloudtrail.md)
                * [BigQuery](source/bigquery.md)
                * [S3](source/s3.md)
            * [{{ KF }}](source/kafka.md)
            * [{{ CH }}](source/clickhouse.md)
            * [{{ eventhub-name }}](source/eventhub.md)
            * [{{ GP }}](source/greenplum.md)
            * [{{ MG }}](source/mongodb.md)
            * [{{ MY }}](source/mysql.md)
            * [Oracle](source/oracle.md)
            * [{{ PG }}](source/postgresql.md)
            * [{{ yds-full-name }}](source/data-streams.md)
            * [{{ ydb-full-name }}](source/ydb.md) 
        * Приемники:
            * [{{ KF }}](target/kafka.md)
            * [{{ CH }}](target/clickhouse.md)
            * [{{ GP }}](target/greenplum.md)
            * [{{ MG }}](target/mongodb.md)
            * [{{ MY }}](target/mysql.md)
            * [{{ objstorage-name }}](target/object-storage.md)
            * [{{ PG }}](target/postgresql.md)
            * [{{ yds-full-name }}](target/data-streams.md)
            * [{{ ydb-full-name }}](target/yandex-database.md)
    1. Нажмите кнопку **Применить**.

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с описанием эндпоинта.

        О том, как создать такой файл, см. в подразделе [Создать эндпоинт](#create).

    1. Измените значение поля `name` (имя эндпоинта) и параметры эндпоинта в блоке `settings`.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% note info %}

    Изменение эндпоинта с помощью API поддерживается только для источников и приемников типа {{ MY }} и {{ PG }}.

    {% endnote %}

    Воспользуйтесь методом API [update](../../api-ref/Endpoint/update) и передайте в запросе:

    * Идентификатор эндпоинта в параметре `endpointId`
    * Имя эндпоинта в параметре `name`.
    * Описание эндпоинта в параметре `description`.
    * Параметры эндпоинта в параметре `settings`.

    Чтобы получить идентификатор эндпоинта:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) в консоли управления и выберите сервис **{{ data-transfer-full-name }}**.
    1. Нажмите на нужный эндпоинт.

    Параметры эндпоинта см. в разделе настроек для нужного источника или приемника данных.

{% endlist %}

Изменение настроек эндпоинта для трансфера с типом {{ dt-type-repl }} в статусе {{ dt-status-repl }} приведет к перезапуску трансфера.

## Удалить эндпоинт {#delete}

{% note warning %}

Перед удалением эндпоинта [удалите](../transfer.md#delete) все трансферы, в которые он входит.

{% endnote %}

Чтобы удалить эндпоинт:

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. Выберите эндпоинт, который нужно удалить.
    1. Нажмите кнопку **Удалить** на панели сверху.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы удалить эндпоинт, выполните команду:

    ```bash
    {{ yc-dt }} endpoint delete <идентификатор эндпоинта>
    ```

    Чтобы получить идентификатор эндпоинта:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) в консоли управления и выберите сервис **{{ data-transfer-full-name }}**.
    1. Нажмите на нужный эндпоинт.

- {{ TF }}

    {% include [terraform-delete](../../../_includes/data-transfer/terraform-delete-endpoint.md) %}

- API

    Воспользуйтесь методом API [delete](../../api-ref/Endpoint/delete) и передайте в запросе идентификатор нужного эндпоинта в параметре `endpointId`.

    Чтобы получить идентификатор эндпоинта:
    1. Перейдите на [страницу каталога]({{ link-console-main }}) в консоли управления и выберите сервис **{{ data-transfer-full-name }}**.
    1. Нажмите на нужный эндпоинт.

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
