[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Захват изменений YDB и поставка в YDS

# Захват изменений Yandex Managed Service for YDB и поставка в Yandex Data Streams

# Захват изменений из YDB и поставка в YDS


В поток Data Streams можно в реальном времени поставлять данные из базы данных Managed Service for YDB с помощью технологии [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC).

{% note info %}

В YDB CDC-режим поддерживается, начиная с версии 22.5 и выше.

{% endnote %}

Чтобы настроить CDC с использованием сервиса Data Transfer:

1. [Подготовьте базу данных источника Managed Service for YDB](#prepare-source-ydb).
1. [Создайте поток данных приемника Data Streams](#create-target-yds).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Базы данных Managed Service for YDB ([тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
  	* Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Сервис Data Streams ([тарифы Data Streams](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных источника Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

    1. Если для источника вы выбрали режим БД Dedicated, [создайте](../../vpc/operations/security-group-create.md) и [настройте](../../ydb/operations/connection.md#configuring-security-groups) группу безопасности в сети, где находится БД.

    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md) любой подходящей конфигурации для потока данных приемника Data Streams.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-ydb-yds.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-ydb-to-yds/blob/main/data-transfer-ydb-yds.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к базе данных Managed Service for YDB;
        * база данных источника Managed Service for YDB;
        * база данных Managed Service for YDB для потока данных приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-ydb-yds.tf` переменные:

        * `source_db_name` — имя базы данных Managed Service for YDB источника;
        * `target_db_name` — имя базы данных Managed Service for YDB для потока данных приемника;
        * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинтов](#prepare-transfer).

    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Подготовьте базу данных источника Managed Service for YDB {#prepare-source-ydb}

1. Подготовьтесь к выполнению SQL-запросов в базе данных источника Managed Service for YDB:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужная база данных.
        1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
        1. Выберите базу из списка и перейдите на вкладку **Навигация**.
        1. Нажмите кнопку **Новый SQL-запрос**.

    - YDB CLI {#cli}

        1. [Настройте подключение к базе данных Managed Service for YDB](../../ydb/operations/connection.md).
        1. Убедитесь, что можете выполнять запросы с помощью YDB CLI с выбранным режимом аутентификации. Например, для [IAM-токена](../../iam/concepts/authorization/iam-token.md):

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

## Создайте поток данных приемника Data Streams {#create-target-yds}

[Создайте поток данных приемника Data Streams](../../data-streams/operations/manage-streams.md#create-data-stream).

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [источника `YDB`](../../data-transfer/operations/endpoint/source/ydb.md):

    * **Настройки подключения**:

        * **База данных** — выберите базу данных источника Managed Service for YDB из списка.
        * **Идентификатор сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.

    * **Список включенных путей**:

        * **Путь 1** — `test`.

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [приемника `Yandex Data Streams`](../../data-transfer/operations/endpoint/target/data-streams.md):

    * **Настройки подключения**:

        * **База данных** — выберите базу данных Managed Service for YDB для потока данных приемника из списка.
        * **Поток** — укажите имя потока Data Streams.
        * **Сервисный аккаунт** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

    * **Настройки сериализации** — `Auto`.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Репликация_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Укажите в файле `data-transfer-ydb-yds.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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

1. Дождитесь перехода трансфера в статус **Реплицируется**.

1. [Вставьте тестовые данные](../../ydb/operations/crud.md) в таблицу `test` в базе данных источника Managed Service for YDB:

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

Проверьте, что в поток данных Data Streams перенеслись данные из источника:

  {% list tabs group=instructions %}

  - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
      1. Перейдите в сервис **Data Streams**.
      1. Выберите поток-приемник из списка и перейдите в раздел ![image](../../_assets/console-icons/bars.svg) **Просмотр данных**.
      1. Убедитесь, что в сегменте `shard-000000` появились сообщения, содержащие строки таблицы из источника. Чтобы рассмотреть сообщения подробнее, нажмите на значок ![image](../../_assets/console-icons/eye.svg).

  - AWS CLI {#cli}

      1. [Установите AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
      1. [Настройте окружение](../../data-streams/quickstart/index.md) для Data Streams.
      1. Прочитайте данные из потока с помощью:

          * [AWS CLI](../../data-streams/operations/aws-cli/get-records.md).
          * [AWS SDK](../../data-streams/operations/aws-sdk/get-records.md).

  {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. Если при создании эндпоинтов вы создавали сервисные аккаунты, [удалите их](../../iam/operations/sa/delete.md).
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите базу данных источника Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).
       1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db) для потока данных приемника.

   - Terraform {#tf}

       1. В терминале перейдите в директорию с планом инфраструктуры.
       
           {% note warning %}
       
           Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
       
           {% endnote %}
       
       1. Удалите ресурсы:
       
           1. Выполните команду:
       
               ```bash
               terraform destroy
               ```
       
           1. Подтвердите удаление ресурсов и дождитесь завершения операции.
       
           Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

   {% endlist %}