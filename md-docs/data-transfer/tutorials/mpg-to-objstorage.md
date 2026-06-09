# Загрузка данных из {{ PG }} в {{ objstorage-full-name }}

Вы можете перенести базу данных из {{ mpg-full-name }} в {{ objstorage-full-name }} с помощью сервиса {{ data-transfer-full-name }}. Для этого:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу копирования при повторной активации](#example-check-copy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mpg-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. Создайте кластер-источник {{ mpg-name }} любой подходящей [конфигурации](../../managed-postgresql/concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `pg-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_источника>`.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    
    1. Если вы используете [группы безопасности](../../managed-postgresql/operations/connect/index.md#configuring-security-groups) в кластере, убедитесь, что они настроены правильно и допускают подключение к нему.


    1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md).

    
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-sa` и ролью `storage.uploader`. Трансфер будет использовать его для доступа к бакету.


- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [postgresql-to-objstorage.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-postgresql-to-object-storage/blob/main/postgresql-to-objstorage.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
        * кластер-источник {{ mpg-name }};
        * сервисный аккаунт, который будет использоваться для создания бакета и дальнейшего доступа к нему;
        * бакет-приемник {{ objstorage-name }};
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `postgresql-to-objstorage.tf`:
        * пароль пользователя {{ PG }};
        * имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).

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

## Подготовьте трансфер {#prepare-transfer}

1. [Подключитесь к кластеру {{ mpg-name }}](../../managed-postgresql/operations/connect/index.md), создайте в базе данных `db1` таблицу `x_tab` и заполните ее данными:

     ```sql
     CREATE TABLE x_tab
     (
         id NUMERIC PRIMARY KEY,
         name CHAR(5)
     );
     INSERT INTO x_tab (id, name) VALUES
       (40, 'User1'),
       (41, 'User2'),
       (42, 'User3'),
       (43, 'User4'),
       (44, 'User5');
     ```

1. [Создайте эндпоинт-приемник](../operations/endpoint/target/object-storage.md) типа `{{ objstorage-name }}` со следующими настройками:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}** — `<имя_созданного_ранее_бакета>`

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}** — `storage-sa`.

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}** — `UNCOMPRESSED`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout.title }}** — `from_PostgreSQL`.

1. Создайте эндпоинт-источник и трансфер:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт-источник](../operations/endpoint/source/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}** — `<имя_кластера-источника_{{ PG }}>` из выпадающего списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — `pg-user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — `<пароль_пользователя>`.

    1. [Создайте трансфер](../operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**, использующий созданные эндпоинты.

- {{ TF }} {#tf}

    1. Укажите в файле `postgresql-to-objstorage.tf` переменные:

        * `objstorage_endpoint_id` — значение идентификатора эндпоинта для приемника;
        * `transfer_enabled` – значение `1` для создания трансфера.

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

{% endlist %}

## Активируйте трансфер {#activate-transfer}

1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.

1. Убедитесь, что в бакете {{ objstorage-name }} появилась таблица `public_x_tab.csv` с данными из таблицы `x_tab`.

## Проверьте работу копирования при повторной активации {#example-check-copy}

1. [Подключитесь к кластеру {{ mpg-name }}](../../managed-postgresql/operations/connect/index.md), удалите строку с идентификатором `41` и измените строку с идентификатором `42` в таблице `x_tab`:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Повторно [активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.
1. Убедитесь, что изменения отобразились в таблице `public_x_tab.csv` на приемнике.

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. Убедитесь, что трансфер находится в статусе **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.
1. [Удалите эндпоинт-приемник](../operations/endpoint/index.md#delete).
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите трансфер](../operations/transfer.md#delete).
        1. [Удалите эндпоинт-источник](../operations/endpoint/index.md#delete).
        1. [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
        1. [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).

    - {{ TF }} {#tf}

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