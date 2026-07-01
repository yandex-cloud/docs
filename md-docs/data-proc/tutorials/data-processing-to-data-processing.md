# Совместная работа с таблицами с использованием Apache Hive™ Metastore

Вы можете сохранять данные из [кластера Yandex Data Processing](../concepts/index.md) в [бакет Yandex Object Storage](../../storage/concepts/bucket.md), используя отдельный [кластер Apache Hive™ Metastore](../../metadata-hub/concepts/metastore.md) для хранения метаданных таблиц. Это позволит затем работать с сохраненными данными другому кластеру Yandex Data Processing, имеющему доступ к бакету и подключенному к тому же кластеру Apache Hive™ Metastore.

Чтобы настроить совместное использование таблиц двумя кластерами Yandex Data Processing с помощью Apache Hive™ Metastore:

1. [Подготовьте инфраструктуру](#infra).
1. [Подключите Yandex Data Processing к Apache Hive™ Metastore](#connect).
1. [Создайте тестовую таблицу](#create-table).
1. [Получите данные во втором кластере](#test-target).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Если в кластере Yandex Data Processing есть таблицы, которые должны быть доступны в другом кластере Yandex Data Processing, [перенесите таблицы](metastore-import.md) в нужный кластер с помощью Apache Hive™ Metastore.

{% note warning %}

Если вы хотите настроить [политику доступа](../../storage/concepts/policy.md) для бакета и подключаться к нему из кластера Apache Hive™ Metastore, вам потребуется дополнительная настройка инфраструктуры. Подробнее в [инструкции](../../metadata-hub/operations/metastore/s3-policy-connect.md).

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
* Бакеты Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../../storage/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `dataproc-s3-sa` и назначьте ему роли `dataproc.agent` и `dataproc.provisioner`.
    1. В Object Storage [создайте бакеты](../../storage/operations/buckets/create.md) и [настройте доступ](../../storage/operations/buckets/edit-acl.md) к ним:
       
       1. Создайте бакет для исходных данных и предоставьте сервисному аккаунту кластера разрешение `READ` для этого бакета.
       1. Создайте бакет для результатов обработки и предоставьте сервисному аккаунту кластера разрешение `READ и WRITE` для этого бакета.
    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `dataproc-network`.
    1. В сети `dataproc-network` [создайте подсеть](../../vpc/operations/subnet-create.md) в любой зоне доступности.
    1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для созданной подсети.
    1. [Создайте два кластера Yandex Data Processing](../operations/cluster-create.md) с именами `dataproc-source` и `dataproc-target`, с любой [подходящей конфигурацией хостов](../concepts/instance-types.md) и следующими настройками:

        * **Окружение** — `PRODUCTION`.
        * **Сервисы**:
            * `SPARK`;
            * `YARN`.
        * **Сервисный аккаунт** — `dataproc-sa`.
        * **Свойства** — `spark:spark.sql.hive.metastore.sharedPrefixes` со значением `com.amazonaws,ru.yandex.cloud`. Нужно для выполнения заданий PySpark и для интеграции с Apache Hive™ Metastore.
        * **Имя бакета** — бакет, который вы создали для выходных данных.
        * **Сеть** — `dataproc-network`.

    1. Если в облачной сети используются [группы безопасности](../../vpc/concepts/security-groups.md), [добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности кластеров Yandex Data Processing следующее правило для исходящего трафика:

        * **Диапазон портов** — `9083`.
        * **Протокол** — `Любой` (`Any`).
        * **Источник** — `CIDR`.
        * **CIDR блоки** — `0.0.0.0/0`.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [dataproc-to-dataproc.tf](https://github.com/yandex-cloud-examples/yc-data-proc-to-data-proc/blob/main/dataproc-to-dataproc.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [NAT-шлюз](../../vpc/concepts/gateways.md) и таблица маршрутизации, необходимые для работы Yandex Data Processing;
        * [группы безопасности](../../vpc/concepts/security-groups.md), необходимые для кластеров Yandex Data Processing;
        * сервисный аккаунт, необходимый для работы кластера Yandex Data Processing;
        * сервисный аккаунт, необходимый для создания бакетов в Object Storage;
        * бакеты для входных и выходных данных;
        * два кластера Yandex Data Processing.

    1. Укажите в файле `dataproc-to-dataproc.tf`:

        * `folder_id` — идентификатор облачного каталога, такой же как в настройках провайдера.
        * `input-bucket` — имя бакета для входных данных.
        * `output-bucket` — имя бакета для выходных данных.
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

## Подключите Yandex Data Processing к Apache Hive™ Metastore {#connect}

1. [Создайте кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-create.md) с версией 3.1 в сети `dataproc-network`.

1. [Добавьте в настройки кластеров](../operations/cluster-update.md) Yandex Data Processing свойство `spark:spark.hive.metastore.uris` со значением `thrift://<IP-адрес_кластера_Apache Hive™ Metastore>:9083`.

   Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, откройте [консоль управления](https://console.yandex.cloud), затем Перейдите в сервис **Yandex MetaData Hub** и на левой панели выберите страницу ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**. Для нужного кластера скопируйте значение из колонки **IP-адрес**.

## Создайте тестовую таблицу {#create-table}

В кластере `dataproc-source` создайте тестовую таблицу `countries` и загрузите ее в Object Storage:

{% list tabs %}

- Spark

    1. Подготовьте файл скрипта:

        1. Создайте локально файл с именем `create-table.py` и скопируйте в него следующий скрипт:

            {% cut "create-table.py" %}

            ```python
            from pyspark.sql.types import *
            from pyspark.sql import SparkSession

            # Создание Spark-сессии
            spark = SparkSession.builder \
                .appName("create-table") \
                .enableHiveSupport() \
                .getOrCreate()

            # Создание схемы данных
            schema = StructType([StructField('Name', StringType(), True),
            StructField('Capital', StringType(), True),
            StructField('Area', IntegerType(), True),
            StructField('Population', IntegerType(), True)])

            # Создание датафрейма
            df = spark.createDataFrame([('Австралия', 'Канберра', 7686850, 19731984), ('Австрия', 'Вена', 83855, 7700000)], schema)

            # Запись датафрейма в бакет в виде таблицы countries
            df.write.mode("overwrite").option("path","s3a://<имя_выходного_бакета>/countries").saveAsTable("countries")
            ```

            {% endcut %}

        1. Укажите в скрипте имя выходного бакета, в который будет сохранен файл с таблицей `countries`.

        1. Создайте в бакете для входных данных папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `create-table.py`.

    1. [Создайте задание PySpark](../operations/jobs-pyspark.md#create), указав в поле **Main python файл** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/create-table.py`.

    1. Дождитесь завершения задания и проверьте, что в выходном бакете в папке `countries` появился файл `part-00000-...`.

{% endlist %}

Теперь данные из созданной таблицы хранятся в бакете Object Storage, а метаинформация о ней — в кластере Apache Hive™ Metastore. Кластер `dataproc-source` можно [удалить](../operations/cluster-delete.md).

## Получите данные во втором кластере {#test-target}

Загрузите метаинформацию о таблице `countries` в кластер `dataproc-target` и убедитесь, что таблица стала доступна в кластере для дальнейшей работы:

{% list tabs %}

- Spark

    1. Подготовьте файл скрипта:

        1. Создайте локально файл с именем `obtain-table.py` и скопируйте в него следующий скрипт:

            {% cut "obtain-table.py" %}

            ```python
            from pyspark.sql import SparkSession

            # Создание Spark-сессии
            spark = SparkSession.builder \
                .appName("obtain-table") \
                .enableHiveSupport() \
                .getOrCreate()

            spark.catalog.listDatabases()

            # Получение информации о таблице countries из Apache Hive™ Metastore
            df = spark.sql("describe extended countries")

            # Запрос данных из таблицы countries
            df = spark.sql("select * from countries")

            # Перенос таблицы в бакет для проверки
            df.repartition(1).write.csv(path='s3a://<имя_выходного_бакета>/csv', header=True, sep=',')
            ```

            {% endcut %}

        1. Укажите в скрипте имя выходного бакета, в который будет сохранен CSV-файл с таблицей `countries`.
        1. [Загрузите](../../storage/operations/objects/upload.md#simple) файл `obtain-table.py` в бакет для входных данных в папку `scripts`.

    1. [Создайте задание PySpark](../operations/jobs-pyspark.md#create), указав в поле **Main python файл** путь к файлу скрипта: `s3a://<имя_входного_бакета>/scripts/obtain-table.py`.
    1. Дождитесь выполнения задания и убедитесь, что в выходном бакете появилась папка `csv` с таблицей в формате CSV.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер Apache Hive™ Metastore](../../metadata-hub/operations/metastore/cluster-delete.md).
1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакетов.
1. Удалите остальные ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Кластеры Yandex Data Processing](../operations/cluster-delete.md).
        1. [Бакеты Object Storage](../../storage/operations/buckets/delete.md).
        1. [Подсеть](../../vpc/operations/subnet-delete.md).
        1. [Таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
        1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
        1. [Облачную сеть](../../vpc/operations/network-delete.md).
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