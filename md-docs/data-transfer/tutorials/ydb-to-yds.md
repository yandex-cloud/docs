# Захват изменений данных из {{ ydb-short-name }} и поставка в {{ DS }}

# Захват изменений из {{ ydb-short-name }} и поставка в {{ DS }}


В поток {{ yds-name }} можно в реальном времени поставлять данные из базы данных {{ ydb-name }} с помощью технологии [Change Data Capture](../concepts/cdc.md) (CDC).

{% note info %}

В {{ ydb-short-name }} CDC-режим поддерживается, начиная с версии {{ ydb.version-cdc }} и выше.

{% endnote %}

Чтобы настроить CDC с использованием сервиса {{ data-transfer-name }}:

1. [Подготовьте базу данных источника {{ ydb-name }}](#prepare-source-ydb).
1. [Создайте поток данных приемника {{ yds-name }}](#create-target-yds).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Базы данных {{ ydb-name }} (см. [тарифы {{ ydb-name }}](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
  	* Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Сервис {{ yds-name }} (см. [тарифы {{ yds-name }}](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных источника {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

    1. Если для источника вы выбрали режим БД {{ dd }}, [создайте](../../vpc/operations/security-group-create.md) и [настройте](../../ydb/operations/connection.md#configuring-security-groups) группу безопасности в сети, где находится БД.

    1. [Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации для потока данных приемника {{ yds-name }}.

- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-ydb-yds.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-ydb-to-yds/blob/main/data-transfer-ydb-yds.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к базе данных {{ ydb-name }};
        * база данных источника {{ ydb-name }};
        * база данных {{ ydb-name }} для потока данных приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-ydb-yds.tf` переменные:

        * `source_db_name` — имя базы данных {{ ydb-name }} источника;
        * `target_db_name` — имя базы данных {{ ydb-name }} для потока данных приемника;
        * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинтов](#prepare-transfer).

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

## Подготовьте базу данных источника {{ ydb-name }} {#prepare-source-ydb}

1. Подготовьтесь к выполнению SQL-запросов в базе данных источника {{ ydb-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
        1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
        1. Выберите базу из списка и перейдите на вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.ydb.browse.button_sql-query }}**.

    - {{ ydb-short-name }} CLI {#cli}

        1. [Настройте подключение к базе данных {{ ydb-name }}](../../ydb/operations/connection.md).
        1. Убедитесь, что можете выполнять запросы с помощью {{ ydb-short-name }} CLI с выбранным режимом аутентификации. Например, для [IAM-токена](../../iam/concepts/authorization/iam-token.md):

            ```bash
            ydb \
              --endpoint <эндпоинт> \
              --database <имя_БД> \
              --iam-token-file <путь_к_IAM-токену> \
              yql -s "SELECT 1;"
            ```

            Результат:

            ```text
            ┌─────────┐
            | column0 |
            ├─────────┤
            | 1       |
            └─────────┘
            ```

    {% endlist %}

1. [Создайте таблицу](../../ydb/operations/schema.md#create-table) для тестовых данных:

    ```sql
    CREATE TABLE test
    (
        id Uint64,
        text Utf8,
        PRIMARY KEY (id)
    );
    ```

## Создайте поток данных приемника {{ yds-name }} {#create-target-yds}

[Создайте поток данных приемника {{ yds-name }}](../../data-streams/operations/manage-streams.md#create-data-stream).

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../operations/endpoint/index.md#create) для [источника `YDB`](../operations/endpoint/source/ydb.md):

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.connection.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}** — выберите базу данных источника {{ ydb-name }} из списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.array_item_label }} 1** — `test`.

1. [Создайте эндпоинт](../operations/endpoint/index.md#create) для [приемника `{{ yds-full-name }}`](../operations/endpoint/target/data-streams.md):

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTarget.connection.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите базу данных {{ ydb-name }} для потока данных приемника из списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока {{ yds-name }}.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}`.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**, использующий созданные эндпоинты.
        1. [Активируйте](../operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

        1. Укажите в файле `data-transfer-ydb-yds.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
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

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. [Вставьте тестовые данные](../../ydb/operations/crud.md) в таблицу `test` в базе данных источника {{ ydb-name }}:

    ```sql
    INSERT INTO test
    (
        id,
        text
    )
    VALUES
    (
        1,
        'text 1'
    ),
    (
        2,
        'text 2'
    ),
    (
        3,
        'text 3'
    );
    ```

Проверьте, что в поток данных {{ yds-name }} перенеслись данные из источника:

  {% list tabs group=instructions %}

  - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
      1. Выберите поток-приемник из списка и перейдите в раздел ![image](../../_assets/console-icons/bars.svg) **{{ ui-key.yacloud.data-streams.label_data-introspection }}**.
      1. Убедитесь, что в сегменте `shard-000000` появились сообщения, содержащие строки таблицы из источника. Чтобы рассмотреть сообщения подробнее, нажмите на значок ![image](../../_assets/console-icons/eye.svg).

  - AWS CLI {#cli}

      1. [Установите AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
      1. [Настройте окружение](../../data-streams/quickstart/index.md) для {{ yds-name }}.
      1. Прочитайте данные из потока с помощью:

          * [AWS CLI](../../data-streams/operations/aws-cli/get-records.md).
          * [AWS SDK](../../data-streams/operations/aws-sdk/get-records.md).

  {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../operations/transfer.md#delete).
1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.
1. Если при создании эндпоинтов вы создавали сервисные аккаунты, [удалите их](../../iam/operations/sa/delete.md).
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите базу данных источника {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).
       1. [Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db) для потока данных приемника.

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