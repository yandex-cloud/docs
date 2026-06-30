# Поставка данных в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer

# Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer

Вы можете отслеживать изменения данных в _кластере-источнике_ Managed Service for PostgreSQL и отправлять их в _кластер-приемник_ Managed Service for Apache Kafka® с помощью технологии Change Data Capture (CDC).

Чтобы настроить CDC с использованием сервиса Data Transfer:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте кластер-приемник](#prepare-target).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../pricing.md)).
* Кластер Managed Service for Apache Kafka®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы Data Transfer](../../data-transfer/pricing.md)).


## Подготовьте инфраструктуру {#infra}


{% note info %}

Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.

{% endnote %}


{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте кластер-источник Managed Service for PostgreSQL](../operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

      * с базой данных `db1`;
    
      
      * с пользователем `pg-user`;
      * с хостами в публичном доступе.


  
  1. [Создайте кластер-приемник Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

  1. Если вы используете группы безопасности, настройте их так, чтобы к кластерам можно было подключаться из интернета:

      * [Инструкция для Managed Service for PostgreSQL](../operations/connect/index.md#configuring-security-groups).
      * [Инструкция для Managed Service for Apache Kafka®](../../managed-kafka/operations/connect/index.md#configuring-security-groups).



- Terraform {#tf}

  1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

  1. Скачайте в ту же рабочую директорию файл конфигурации [cdc-mpg-mkf.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-postgresql-to-kafka/blob/main/cdc-mpg-mkf.tf).

      В этом файле описаны:

      * [сеть](../../vpc/concepts/network.md#network);
      * [подсеть](../../vpc/concepts/network.md#subnet) в [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`;
      * [группа безопасности](../../vpc/concepts/security-groups.md) для кластера Managed Service for PostgreSQL и правила, необходимые для подключения к кластеру из интернета;
      * группа безопасности для кластера Managed Service for Apache Kafka® и правила, необходимые для подключения к кластеру из интернета;
      * кластер Managed Service for PostgreSQL с публичным доступом из интернета;
      * база данных и пользователь с ролью [mdb_replication](../concepts/roles.md#mdb-replication) в кластере Managed Service for PostgreSQL;
      * кластер Managed Service for Apache Kafka® с публичным доступом из интернета;
      * топик и пользователь с ролями [ACCESS_ROLE_CONSUMER](../../managed-kafka/concepts/account-roles.md#access-role-consumer) и [ACCESS_ROLE_PRODUCER](../../managed-kafka/concepts/account-roles.md#access-role-producer) на этот топик в кластере Managed Service for Apache Kafka®;
      * эндпоинты для источника и приемника;
      * трансфер.

  1. Укажите в конфигурационном файле следующие параметры:
        
      * `network_name` — имя сети.
      * `subnet_name` — имя подсети.
      * `pg_sg_name` — имя группы безопасности для кластера Managed Service for PostgreSQL.
      * `kf_sg_name` — имя группы безопасности для кластера Managed Service for Apache Kafka®.
      * `pg_cluster_version` — версия кластера Managed Service for PostgreSQL.
      * `pg_cluster_name` — имя кластера Managed Service for PostgreSQL.
      * `pg_password` — пароль пользователя в кластере Managed Service for PostgreSQL.
      * `kf_cluster_version` — версия кластера Managed Service for Apache Kafka®.
      * `kf_cluster_name` — имя кластера Managed Service for Apache Kafka®.
      * `kf_password` — пароль пользователя в кластере Managed Service for Apache Kafka®.
      * `source_endpoint_name` — имя эндпоинта для источника.
      * `target_endpoint_name` — имя эндпоинта для приемника.
      * `transfer_name` — имя трансфера.
      * `transfer_enabled = 0` — отключает создание эндпоинтов и трансфера. Они будут созданы при [подготовке трансфера](#prepare-transfer).

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


## Подготовьте кластер-источник {#prepare-source}


1. Если вы создавали инфраструктуру вручную, [назначьте](../operations/grant.md#grant-role) роль [mdb_replication](../concepts/roles.md#mdb-replication) пользователю `pg-user`. Это необходимо, чтобы пользователь мог создать публикацию, через которую Data Transfer получает информацию об изменениях в данных в кластере-источнике.


1. [Подключитесь к базе данных](../operations/connect/index.md) `db1` от имени пользователя `pg-user`.

1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию с некоторых датчиков автомобиля.

    Создайте таблицу:

    ```sql
    CREATE TABLE public.measurements (
        "device_id" text PRIMARY KEY NOT NULL,
        "datetime" timestamp NOT NULL,
        "latitude" real NOT NULL,
        "longitude" real NOT NULL,
        "altitude" real NOT NULL,
        "speed" real NOT NULL,
        "battery_voltage" real,
        "cabin_temperature" real NOT NULL,
        "fuel_level" real
    );
    ```

    Наполните таблицу данными:

    ```sql
    INSERT INTO public.measurements VALUES
        ('iv9a94th6rzt********', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
        ('iv9a94th678t********', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
    ```

## Подготовьте кластер-приемник {#prepare-target}


Если вы создавали инфраструктуру с помощью Terraform, пропустите этот шаг и перейдите к [подготовке и активации трансфера](#prepare-transfer).


Настройка кластера-приемника различается в зависимости от используемого [способа управления топиками](../../managed-kafka/concepts/topics.md#management). При этом имена топиков для данных конструируются по тому же принципу, что и в [Debezium](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-topic-names) — `<префикс_топика>.<имя_схемы>.<имя_таблицы>`. В этом руководстве в качестве примера будет использоваться префикс `cdc`.

{% list tabs group=topic_management %}

- Интерфейсы Yandex Cloud {#yc}

    Если для управления топиками используются интерфейсы Yandex Cloud (консоль управления, CLI, API):

    1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `cdc.public.measurements`.

        Если необходимо отслеживать изменения в нескольких таблицах, создайте для каждой из них отдельный топик.

    1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `kafka-user` и ролями `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER`, действующими на созданный топик.

- Admin API {#api}

    Если для управления топиками используется Kafka Admin API:

    1. Создайте [пользователя-администратора](../../managed-kafka/operations/cluster-accounts.md) с именем `kafka-user`.

    1. Помимо роли `ACCESS_ROLE_ADMIN` назначьте пользователю-администратору роли `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` на топики, имена которых начинаются с префикса `cdc`.

        Необходимые топики будут созданы автоматически при первом событии изменения в отслеживаемых таблицах кластера-источника. Такое решение может быть удобным для отслеживания изменений во множестве таблиц, однако, требует запас свободного места в хранилище кластера. Подробнее в разделе [Хранилище в Managed Service for Apache Kafka®](../../managed-kafka/concepts/storage.md).

{% endlist %}


## Подготовьте и активируйте трансфер {#prepare-transfer}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте эндпоинты](../../data-transfer/operations/endpoint/index.md#create).

      * Эндпоинт для источника:

        * **Тип базы данных** — `PostgreSQL`.
        * **Параметры эндпоинта**:
            * **Настройки подключения** — `Кластер Managed Service for PostgreSQL`.
            * **Кластер Managed Service for PostgreSQL** — выберите [созданный ранее](#before-you-begin) кластер Managed Service for PostgreSQL.
            * **База данных** — `db1`.
            * **Пользователь** — `pg-user`.
            * **Пароль** — укажите пароль пользователя `pg-user`.
            * **Список включённых таблиц** — `public.measurements`.

      * Эндпоинт для приемника:

        * **Тип базы данных** — `Kafka`.
        * **Параметры эндпоинта**:
            * **Тип подключения** — `Кластер Managed Service for Apache Kafka`.
                * **Кластер Managed Service for Apache Kafka** — выберите кластер-приемник.
                * **Аутентификация** — укажите данные созданного ранее пользователя `kafka-user`.

            * **Топик** — `Полное имя топика`.
            * **Полное имя топика** — `cdc.public.measurements`.

            Если необходимо отслеживать изменения в нескольких таблицах, заполните поля следующим образом:

            * **Топик** — `Префикс топика`.
            * **Префикс топика** — укажите префикс `cdc`, использованный при формировании имен топиков.

  1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) со следующими настройками:

      * **Эндпоинты**:
        * **Источник** — созданный ранее эндпоинт для источника.
        * **Приёмник** — созданный ранее эндпоинт для приемника.
      * **Тип трансфера** — **Репликация**.

  1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.


- Terraform {#tf}

  1. Укажите в файле `cdc-mpg-mkf.tf` значение параметра `transfer_enabled = 1`.

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

      Будут созданы эндпоинты и трансфер. Трансфер активируется автоматически после создания.
  
  1. Дождитесь перехода трансфера в статус **Реплицируется**.
      
      Проверить состояние трансфера можно в [консоли управления](https://console.yandex.cloud).


{% endlist %}


## Проверьте работоспособность трансфера {#verify-transfer}

1. Установите на локальный компьютер [утилиту](https://github.com/edenhill/kcat) `kcat` (`kafkacat`) и [клиент командной строки PostgreSQL](https://www.postgresql.org/download/). Например, в Ubuntu 20.04 выполните команду:

    ```bash
    sudo apt update && sudo apt install kafkacat postgresql-client --yes
    ```

    Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику Managed Service for Apache Kafka® через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

1. В отдельном терминале запустите утилиту `kafkacat` в режиме потребителя:

    ```bash
    kafkacat \
        -C \
        -b <FQDN_хоста-брокера_1>:9091,...,<FQDN_хоста-брокера_N>:9091 \
        -t cdc.public.measurements \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=kafka-user \
        -X sasl.password=<пароль> \
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt \
        -Z \
        -K:
    ```

    FQDN хостов-брокеров можно получить со [списком хостов в кластере Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-hosts.md).

    Будет выведена схема формата данных таблицы `public.measurements` и данные о добавленных в нее ранее строках.

    {% cut "Пример фрагмента сообщения" %}

    ```json
    {
      "payload": {
        "consumer":"dttuhfpp97l3********"
      },
      "schema": {
        "fields": [
          {
            "field": "consumer",
            "optional":false,
            "type":"string"
          }
        ],
        "name": "__data_transfer_stub.public.__consumer_keeper.Key",
        "optional":false,
        "type":"struct"
      }
    }:{
      "payload": {
        "after": {
          "consumer":"dttuhfpp97l3********l",
          "locked_by":"dttuhfpp97l3********-1",
          "locked_till":"2022-05-15T09:55:18Z"
        },
      "before": null,
      "op":"u",
      "source": {
        "connector":"postgresql",
        "db":"db1",
        "lsn":85865797008,
        "name":"__data_transfer_stub",
        "schema":"public",
        "snapshot":"false",
        "table":"__consumer_keeper",
        "ts_ms":1652608518883,
        "txId":245165,
        "version":"1.1.2.Final",
        "xmin":null
      },
    ...
    ```

    {% endcut %}

1. Подключитесь к кластеру-источнику и добавьте данные в таблицу `measurements`:

    ```sql
    INSERT INTO public.measurements VALUES ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что в терминале с запущенной утилитой `kafkacat` отобразились сведения о добавленной строке.

## Удалите созданные ресурсы {#clear-out}


Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:


{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) и [удалите](../../data-transfer/operations/transfer.md#delete) трансфер.
  1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).
  1. Удалите кластеры:

      * [Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).
      * [Managed Service for PostgreSQL](../operations/cluster-delete.md).

  
  1. Если для доступа к хостам кластеров использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.



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



## Дополнительные материалы {#video}

Больше информации о сценариях поставок данных в вебинаре Yandex Cloud:


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvkntkhjbfsn2c7ptv?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=bzWmmPp6KFg).