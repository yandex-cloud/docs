# Загрузка данных из {{ objstorage-full-name }} в витрину {{ CH }}

# Загрузка данных из {{ objstorage-full-name }} в {{ mch-full-name }} с помощью {{ data-transfer-full-name }}


Вы можете перенести данные из {{ objstorage-full-name }} в таблицу {{ mch-name }} с помощью сервиса {{ data-transfer-name }}. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Кластер {{ mch-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}


Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-приемник {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `user1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_пользователя>`.
        * Количество хостов {{ CH }} — не меньше 2 (для включения репликации в кластере).
        * Выделен публичный доступ к хостам кластера.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}

    
    1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) и допускают подключение к нему.


    1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md).

    
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-viewer` и ролью `storage.viewer`. Трансфер будет использовать его для доступа к бакету.

    1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта `storage-viewer`.


- С помощью {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [object-storage-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-clickhouse/blob/main/object-storage-to-clickhouse.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
        * сервисный аккаунт, который будет использоваться для создания бакета и дальнейшего доступа к нему;
        * секрет {{ lockbox-name }}, в котором будет храниться статический ключ сервисного аккаунта для настройки эндпоинта-источника;
        * бакет-источник {{ objstorage-name }};
        * кластер-приемник {{ mch-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `object-storage-to-clickhouse.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
        * `ch_password` — пароль пользователя {{ CH }}.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

1. Подготовьте два CSV-файла с тестовыми данными:

    * `demo_data1.csv`:

        ```csv
        1,Anna
        2,Robert
        3,Umar
        4,Algul
        5,Viktor
        ```

    * `demo_data2.csv`:

        ```csv
        6,Maria
        7,Alex
        ```

1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл `demo_data1.csv` в бакет {{ objstorage-name }}.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../operations/endpoint/source/object-storage.md#endpoint-settings) типа `{{ objstorage-name }}` со следующими настройками:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Object Storage`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}** — имя бакета в {{ objstorage-name }}.

    
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}** — открытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}** — закрытая часть статического ключа сервисного аккаунта. Если вы создали инфраструктуру с помощью {{ TF }}, [скопируйте значение ключа из секрета {{ lockbox-name }}](../../lockbox/operations/secret-get-info.md#secret-contents).


    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}** — `https://{{ s3-storage-host }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}** — `{{ region-id }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}** — знак запятой `,`.
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}** — `table1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` и укажите имена полей и тип данных:

        * `Id`: `Int64`;
        * `Name`: `UTF8`.

    Остальные параметры оставьте по умолчанию.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../operations/endpoint/target/clickhouse.md#endpoint-settings) типа `{{ CH }}` и укажите в нем параметры подключения к кластеру:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.managed.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}** — `<имя_кластера_приемника_{{ CH }}>` из выпадающего списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}** — `user1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}** — `<пароль_пользователя>`.

        1. [Создайте трансфер](../operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - С помощью {{ TF }} {#tf}

        1. Укажите в файле `object-storage-to-clickhouse.tf` значения параметров:

            * `source_endpoint_id` — идентификатор эндпоинта для источника.
            * `transfer_enabled` — значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            1. Выполните команду для просмотра планируемых изменений:
            
               ```bash
               terraform plan
               ```
            
               Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
            
            1. Если вас устраивают планируемые изменения, внесите их:
               1. Выполните команду:
            
                  ```bash
                  terraform apply
                  ```
            
               1. Подтвердите изменение ресурсов.
               1. Дождитесь завершения операции.

        1. Трансфер активируется автоматически. Дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Чтобы убедиться в работоспособности трансфера, проверьте работу копирования и репликации.

### Проверьте работу копирования {#verify-copy}

1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md) `db1` в кластере-приемнике {{ mch-name }}.

1. Выполните запрос:

    ```sql
    SELECT * FROM db1.table1;
    ```

    {% cut "Пример ответа" %}

    ```sql
      __file_name  | __row_index | Id |  Name
    --------------+-------------+----+--------
    demo_data1.csv |           1 |  1 | Anna
    demo_data1.csv |           2 |  2 | Robert
    demo_data1.csv |           3 |  3 | Umar
    demo_data1.csv |           4 |  4 | Algul
    demo_data1.csv |           5 |  5 | Viktor
    ```

    {% endcut %}

### Проверьте работу репликации {#verify-replication}

1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл `demo_data2.csv` в бакет {{ objstorage-name }}.

1. Убедитесь, что данные из файла `demo_data2.csv` появились в базе данных приемника:

    1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect/clients.md) `db1` в кластере-приемнике {{ mch-name }}.

    1. Выполните запрос:

        ```sql
        SELECT * FROM db1.table1;
        ```

        {% cut "Пример ответа" %}

        ```sql
          __file_name  | __row_index | Id |  Name
        --------------+-------------+----+--------
        demo_data1.csv |           1 |  1 | Anna
        demo_data1.csv |           2 |  2 | Robert
        demo_data1.csv |           3 |  3 | Umar
        demo_data1.csv |           4 |  4 | Algul
        demo_data1.csv |           5 |  5 | Viktor
        demo_data2.csv |           1 |  6 | Maria
        demo_data2.csv |           2 |  7 | Alex
        ```

        {% endcut %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../operations/transfer.md#delete).
1. [Удалите эндпоинт-источник](../operations/endpoint/index.md#delete).
1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакета.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите эндпоинт-приемник](../operations/endpoint/index.md#delete).
        1. [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).
        1. [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).

    - С помощью {{ TF }} {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

    {% endlist %}