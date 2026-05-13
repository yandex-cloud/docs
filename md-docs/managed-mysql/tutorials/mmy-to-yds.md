# Захват изменений MySQL® и поставка в YDS

Вы можете отслеживать изменения данных в _кластере-источнике_ Managed Service for MySQL® и отправлять их в _кластер-приемник_ Data Streams с помощью технологии [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC).

Чтобы настроить CDC с использованием сервиса Data Transfer:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу репликации](#check-replication).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for MySQL®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for MySQL®](../pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* База данных Managed Service for YDB (см. [тарифы Managed Service for YDB](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

    * Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
    * Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервных копий.

* Сервис Data Streams (см. [тарифы Data Streams](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник Managed Service for MySQL®](../operations/cluster-create.md) любой подходящей [конфигурации](../concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
        * **Имя БД** — `db1`.
        * **Имя пользователя** — `mmy-user`.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    1. [Выдайте пользователю административные привилегии](../concepts/settings-list.md#setting-administrative-privileges) `REPLICATION CLIENT` и `REPLICATION SLAVE`.

    
    1. Настройте [группы безопасности](../operations/connect/index.md#configure-security-groups) и убедитесь, что они допускают подключение к кластеру.


    1. [Создайте базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#create-db) с именем `ydb-example` любой подходящей конфигурации.

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `yds-sa` и ролью `yds.editor`. Трансфер будет использовать его для доступа к Data Streams.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [mysql-yds.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-mysql-to-yds/blob/main/mysql-yds.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
        * кластер-источник Managed Service for MySQL®;
        * база данных Managed Service for YDB;
        * сервисный аккаунт, который будет использоваться для доступа к Data Streams;
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `mysql-yds.tf` пароль пользователя MySQL®.

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

## Подготовьте трансфер {#prepare-transfer}

1. [Создайте поток данных Data Streams](../../data-streams/operations/aws-cli/create.md) с именем `mpg-stream`.

1. [Подключитесь к кластеру Managed Service for MySQL®](../operations/connect/index.md), создайте в базе данных `db1` таблицу `measurements` и заполните ее данными:

    ```sql
    CREATE TABLE measurements (
        device_id varchar(200) NOT NULL,
        datetime timestamp NOT NULL,
        latitude real NOT NULL,
        longitude real NOT NULL,
        altitude real NOT NULL,
        speed real NOT NULL,
        battery_voltage real,
        cabin_temperature real NOT NULL,
        fuel_level real,
        PRIMARY KEY (device_id)
    );
    INSERT INTO measurements VALUES
        ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/data-streams.md) типа `Data Streams` со следующими настройками:

    * **База данных** — `ydb-example`.
    * **Поток** — `mpg-stream`.
    * **Сервисный аккаунт** — `yds-sa`.

1. Создайте эндпоинт-источник и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/mysql.md) типа `MySQL®` и укажите в нем параметры подключения к кластеру:

            * **Тип подключения** — `Кластер Managed Service for MySQL`.
            * **Кластер Managed Service for MySQL** — `<имя_кластера-источника>` из выпадающего списка.
            * **База данных** — `db1`.
            * **Пользователь** — `mmy-user`.
            * **Пароль** — пароль пользователя `mmy-user`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Репликация_**, использующий созданные эндпоинты.

    - Terraform {#tf}

        1. Укажите в файле `mysql-yds.tf` переменные:

            * `yds_endpoint_id` — значение идентификатора эндпоинта для приемника;
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

    {% endlist %}

## Активируйте трансфер {#activate-transfer}

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус _**Реплицируется**_.

Проверьте, что в поток данных Data Streams перенеслись данные из источника:

  {% list tabs group=instructions %}

  - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Data Streams**.
      1. Выберите поток-приемник из списка и перейдите в раздел ![image](../../_assets/console-icons/bars.svg) **Просмотр данных**.
      1. Убедитесь, что в сегменте `shard-000000` появились сообщения, содержащие строки таблицы из источника. Чтобы рассмотреть сообщения подробнее, нажмите на значок ![image](../../_assets/console-icons/eye.svg).

  - AWS CLI {#cli}

      1. [Установите AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
      1. [Настройте окружение](../../data-streams/quickstart/index.md) для Data Streams.
      1. Прочитайте данные из потока с помощью:

          * [AWS CLI](../../data-streams/operations/aws-cli/get-records.md).
          * [AWS SDK](../../data-streams/operations/aws-sdk/get-records.md).

  {% endlist %}

## Проверьте работу репликации {#check-replication}

1. Подключитесь к кластеру-источнику.
1. Добавьте в таблицу `measurements` новую строку:

    ```sql
    INSERT INTO measurements VALUES
        ('ad02l5ck6sdt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 19, 45);
    ```

1. Убедитесь, что новая строка отобразилась в потоке данных Data Streams.

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
1. [Удалите поток данных Data Streams](../../data-streams/operations/manage-streams.md#delete-data-stream).
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите эндпоинт-источник](../../data-transfer/operations/endpoint/index.md#delete).
       1. [Удалите кластер Managed Service for MySQL®](../operations/cluster-delete.md).
       1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).

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