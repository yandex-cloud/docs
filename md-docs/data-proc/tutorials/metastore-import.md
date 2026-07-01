# Перенос метаданных между кластерами Yandex Data Processing с помощью Apache Hive™ Metastore

# Перенос метаданных между кластерами Yandex Data Processing с помощью Apache Hive™ Metastore


Вы можете перенести метаданные между [кластерами Yandex Data Processing](../concepts/index.md) с СУБД Hive. Сначала метаданные экспортируются из одного кластера, затем импортируются в другой с помощью [Apache Hive™ Metastore](../../metadata-hub/concepts/metastore.md).

Чтобы перенести метаданные между кластерами Yandex Data Processing:

1. [Подготовьте инфраструктуру](#infra)
1. [Создайте тестовую таблицу](#create-table).
1. [Экспортируйте данные](#export-data).
1. [Подключите Yandex Data Processing к Apache Hive™ Metastore](#connect).
1. [Импортируйте данные](#import-data).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note warning %}

Если вы хотите настроить [политику доступа](../../storage/concepts/policy.md) для бакета и подключаться к нему из кластера Apache Hive™ Metastore, вам потребуется дополнительная настройка инфраструктуры. Подробнее в [инструкции](../../metadata-hub/operations/metastore/s3-policy-connect.md).

{% endnote %}

{% note info %}

Apache Hive™ Metastore находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластеры Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../../data-proc/pricing.md)).
* Кластер Apache Hive™ Metastore: вычислительные ресурсы компонентов кластера ([тарифы Yandex MetaData Hub](../../metadata-hub/pricing.md)).
* Бакет Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../../storage/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `dataproc-s3-sa` и назначьте ему роли `dataproc.agent`, `dataproc.provisioner`, `managed-metastore.integrationProvider` и `storage.uploader`.
    1. В Object Storage [создайте бакет](../../storage/operations/buckets/create.md) `dataproc-bucket` и предоставьте сервисному аккаунту разрешение `READ и WRITE` для этого бакета.
    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) `dataproc-network`.
    1. В этой сети [создайте подсеть](../../vpc/operations/subnet-create.md) `dataproc-subnet`.
    1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для созданной подсети.
    1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) `dataproc-security-group` со следующими правилами:

        {% cut "Правила группы безопасности" %}

        #|
        || **Для какого сервиса нужно правило** | **Зачем нужно правило** | **Настройки правила** ||
        || Yandex Data Processing | Для входящего служебного трафика.
        |
        * Диапазон портов — `0-65535`.
        * Протокол — `Любой` (`Any`).
        * Источник — `Группа безопасности`.
        * Группа безопасности — `Текущая` (`Self`). ||
        || Yandex Data Processing | Для входящего трафика, чтобы разрешить доступ к NTP-серверам для синхронизации времени.
        |
        * Диапазон портов — `123`.
        * Протокол — `UDP`.
        * Источник — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`. ||
        || Yandex Data Processing | Для входящего трафика, чтобы из интернета подключаться по SSH к хостам подкластеров с публичным доступом.
        |
        * Диапазон портов — `22`.
        * Протокол — `TCP`.
        * Источник — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`. ||
        || Apache Hive™ Metastore | Для входящего трафика от клиентов.
        |
        * Диапазон портов — `30000-32767`.
        * Протокол — `Любой` (`Any`).
        * Источник — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`. ||
        || Apache Hive™ Metastore | Для входящего трафика от балансировщика.
        |
        * Диапазон портов — `10256`.
        * Протокол — `Любой` (`Any`).
        * Источник — `Проверки состояния балансировщика`. ||
        || Yandex Data Processing | Для исходящего служебного трафика.
        |
        * Диапазон портов — `0-65535`.
        * Протокол — `Любой` (`Any`).
        * Источник — `Группа безопасности`.
        * Группа безопасности — `Текущая` (`Self`). ||
        || Yandex Data Processing | Для исходящего HTTPS-трафика.
        |
        * Диапазон портов — `443`.
        * Протокол — `TCP`.
        * Назначение — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`. ||
        || Yandex Data Processing | Для исходящего трафика, чтобы разрешить доступ к NTP-серверам для синхронизации времени.
        |
        * Диапазон портов — `123`.
        * Протокол — `UDP`.
        * Источник — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`. ||
        || Yandex Data Processing | Для исходящего трафика, чтобы разрешить подключение кластера Yandex Data Processing к Apache Hive™ Metastore.
        |
        * Диапазон портов — `9083`.
        * Протокол — `Любой` (`Any`).
        * Источник — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`. ||
        |#

        {% endcut %}

    1. [Создайте два кластера Yandex Data Processing](../operations/cluster-create.md) с именами `dataproc-source` и `dataproc-target` и следующими настройками:

        * **Окружение** — `PRODUCTION`.
        * **Сервисы**:

            * `HDFS`
            * `HIVE`
            * `SPARK`
            * `YARN`
            * `ZEPPELIN`

        * **Сервисный аккаунт** — `dataproc-s3-sa`.
        * **Зона доступности** — та, в которой находится подсеть `dataproc-subnet`.
        * **Свойства** — `spark:spark.sql.hive.metastore.sharedPrefixes` со значением `com.amazonaws,ru.yandex.cloud`. Нужно для выполнения заданий PySpark и для интеграции с Apache Hive™ Metastore.
        * **Имя бакета** — `dataproc-bucket`.
        * **Сеть** — `dataproc-network`.
        * **Группы безопасности** — `dataproc-security-group`.
        * **UI Proxy** — включен.
        * **Подсеть** у подкластеров Yandex Data Processing — `dataproc-subnet`.
        * **Публичный доступ** у хоста-мастера — включен.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
    1. Скачайте в ту же рабочую директорию файл конфигурации [metastore-import.tf](https://github.com/yandex-cloud-examples/yc-data-proc-metadata-import/blob/main/metastore-import.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [NAT-шлюз](../../vpc/concepts/gateways.md) и таблица маршрутизации, необходимые для работы Yandex Data Processing;
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) для Yandex Data Processing и Apache Hive™ Metastore;
        * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера Yandex Data Processing;
        * сервисный аккаунт, необходимый для создания бакета Object Storage;
        * [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для создания [бакета Yandex Object Storage](../../storage/concepts/bucket.md);
        * бакет;
        * два кластера Yandex Data Processing.

    1. Укажите в файле `metastore-import.tf`:

        * `folder_id` — идентификатор облачного каталога (такой же, как в настройках провайдера).
        * `dp_ssh_key` — абсолютный путь к публичному ключу для кластеров Yandex Data Processing. [Подробнее о подключении к хосту Yandex Data Processing по SSH](../operations/connect-ssh.md).

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

## Создайте тестовую таблицу {#create-table}

В кластере `dataproc-source` создайте тестовую таблицу `countries`:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Yandex Data Processing**.
1. Откройте страницу кластера `dataproc-source`.
1. Перейдите по ссылке **Zeppelin Web UI** в разделе **UI Proxy**.
1. Выберите **Notebook**, затем ![image](../../_assets/console-icons/plus.svg) **Create new note**.
1. В появившемся окне укажите название записи и нажмите кнопку **Create**.
1. Чтобы выполнить PySpark-задание, вставьте скрипт Python в строку ввода:

    ```python
    %pyspark

    from pyspark.sql.types import *

    schema = StructType([StructField('Name', StringType(), True),
    StructField('Capital', StringType(), True),
    StructField('Area', IntegerType(), True),
    StructField('Population', IntegerType(), True)])

    df = spark.createDataFrame([('Австралия', 'Канберра', 7686850, 19731984), ('Австрия', 'Вена', 83855, 7700000)], schema)
    df.write.mode("overwrite").option("path","s3a://dataproc-bucket/countries").saveAsTable("countries")
    ```

1. Нажмите кнопку ![image](../../_assets/console-icons/play.svg) **Run all paragraphs** и дождитесь завершения задания.
1. Замените в строке ввода Python-код на SQL-запрос:

    ```sql
    %sql

    SELECT * FROM countries;
    ```

1. Нажмите кнопку ![image](../../_assets/console-icons/play.svg) **Run all paragraphs**.

    Результат:

    ```text
    |   Name    |  Capital |  Area   | Population |
    | --------- | -------- | ------- | ---------- |
    | Австралия | Канберра | 7686850 | 19731984   |
    | Австрия   | Вена     | 83855   | 7700000    |
    ```

## Экспортируйте данные {#export-data}

Чтобы перенести данные из одного кластера Yandex Data Processing в другой, создайте резервную копию данных в кластере `dataproc-source` с помощью утилиты `pg_dump`:

1. [Подключитесь по SSH](../operations/connect-ssh.md) к хосту-мастеру кластера `dataproc-source`:

    ```bash
    ssh ubuntu@<FQDN_хоста-мастера>
    ```

    [Узнайте, как получить FQDN](../operations/fqdn.md).

1. Создайте резервную копию и сохраните ее в файле `metastore_dump.sql`:

    ```bash
    pg_dump --data-only --schema public postgres://hive:hive-p2ssw0rd@localhost/metastore > metastore_dump.sql
    ```

1. Отключитесь от хоста-мастера.
1. Скачайте файл `metastore_dump.sql` на локальную машину, в текущую директорию:

    ```bash
    scp ubuntu@<FQDN_хоста-мастера>:metastore_dump.sql .
    ```

1. [Загрузите файл](../../storage/operations/objects/upload.md#simple) `metastore_dump.sql` в бакет `dataproc-bucket`.

## Подключите Yandex Data Processing к Apache Hive™ Metastore {#connect}

1. [Создайте кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-create.md) с параметрами:

    * **Сервисный аккаунт** — `dataproc-s3-sa`.
    * **Версия** — `3.1`.
    * **Сеть** — `dataproc-network`.
    * **Подсеть** — `dataproc-subnet`.
    * **Группы безопасности** — `dataproc-security-group`.

1. [Добавьте в настройки кластера](../operations/cluster-update.md) `dataproc-target` свойство `spark:spark.hive.metastore.uris` со значением `thrift://<IP-адрес_кластера_Apache Hive™ Metastore>:9083`.

    Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в консоли управления выберите сервис **Yandex MetaData Hub** и на левой панели выберите страницу ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**. Для нужного кластера скопируйте значение из колонки **IP-адрес**.

## Импортируйте данные {#import-data}

1. Откройте страницу кластера Apache Hive™ Metastore.
1. Нажмите кнопку ![image](../../_assets/console-icons/arrow-down-to-square.svg) **Импорт**.
1. В открывшемся окне укажите бакет `dataproc-bucket` и файл `metastore_dump.sql`.
1. Нажмите кнопку **Импортировать**.
1. Дождитесь, когда импорт завершится. Статус импорта можно проверить на странице кластера Apache Hive™ Metastore, в разделе ![image](../../_assets/console-icons/list-check.svg) **Операции**.

## Проверьте результат {#check-result}

1. Откройте страницу кластера `dataproc-target`.
1. Перейдите по ссылке **Zeppelin Web UI** в разделе **UI Proxy**.
1. Выберите **Notebook**, затем ![image](../../_assets/console-icons/plus.svg) **Create new note**.
1. В появившемся окне укажите название записи и нажмите кнопку **Create**.
1. Отправьте SQL-запрос:

    ```sql
    %sql

    SELECT * FROM countries;
    ```

1. Нажмите кнопку ![image](../../_assets/console-icons/play.svg) **Run all paragraphs**.

    Результат:

    ```text
    |   Name    |  Capital |  Area   | Population |
    | --------- | -------- | ------- | ---------- |
    | Австралия | Канберра | 7686850 | 19731984   |
    | Австрия   | Вена     | 83855   | 7700000    |
    ```

В итоге в кластер `dataproc-target` были импортированы метаданные из кластера `dataproc-source`.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-delete.md).
1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакета.
1. Удалите остальные ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Кластеры Yandex Data Processing](../operations/cluster-delete.md).
        1. [Бакет Object Storage](../../storage/operations/buckets/delete.md).
        1. [Таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
        1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
        1. [Группу безопасности](../../vpc/operations/security-group-delete.md).
        1. [Подсеть](../../vpc/operations/subnet-delete.md).
        1. [Сеть](../../vpc/operations/network-delete.md).
        1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).

    
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

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._