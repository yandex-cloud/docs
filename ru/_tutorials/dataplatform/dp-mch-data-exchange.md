# Обмен данными между {{ mch-full-name }} и {{ dataproc-full-name }}

Чтобы настроить загрузку и выгрузку данных между кластерами {{ mch-name }} и {{ dataproc-name }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Выгрузите данные из {{ mch-name }}](#export-from-mch).
1. [Загрузите данные в {{ mch-name }}](#import-to-mch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [Same Network](../../_includes/same-network.md) %}

1. [Создайте облачную сеть](../../vpc/operations/network-create.md).
1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности `{{ zone-id }}`.
1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для созданной подсети — это обязательное условие для работы кластера {{ dataproc-full-name }}.

Создайте ресурсы:

{% list tabs %}

- Вручную

    1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой [подходящей вам конфигурации](../../managed-clickhouse/concepts/instance-types.md) со следующими настройками:
        * с публичным доступом к хостам кластера;
        * с базой данных `db1`;
        * с пользователем `user1`.
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) для кластера {{ dataproc-name }} . [Назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md):

        * `dataproc.agent`
        * `dataproc.provisioner`
        * `monitoring.viewer`.
    1. [Создайте кластер {{ dataproc-name }}](../../data-proc/operations/cluster-create.md) любой [подходящей вам конфигурации](../../data-proc/concepts/instance-types.md) со следующими настройками:
        * с включенной опцией **UI Proxy**;
        * с созданным ранее сервисным аккаунтом;
        * c компонентами:
            * **HBASE**
            * **HDFS**
            * **HIVE**
            * **MAPREDUCE**
            * **SPARK**
            * **TEZ**
            * **YARN**
            * **ZEPPELIN**
            * **ZOOKEEPER**
    1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) для подключения к кластерам {{ mch-name }} и {{ dataproc-name }}.
    1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по [SSH](../../glossary/ssh-keygen.md) и настройте подключения к кластерам:
        * [{{ mch-name }}](../../managed-clickhouse/operations/connect.md);
        * [{{ dataproc-name }}](../../data-proc/operations/connect.md).
    1. (Опционально) Чтобы экспортировать данные в [бакет {{ objstorage-full-name }}](../../storage/concepts/bucket.md):
        1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md).
        1. [Выдайте права на запись в него](../../storage/operations/buckets/edit-acl.md) сервисному аккаунту кластера {{ dataproc-name }}.

- С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [data-proc-data-exchange-with-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-proc-data-exchange-with-mch.tf).

        В файле описаны:
        * [Группы безопасности](../../vpc/concepts/security-groups.md) для кластеров и виртуальной машины.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для кластера {{ dataproc-name }}.
        * [Бакет {{ objstorage-name }}](../../storage/concepts/bucket.md).
        * Кластер {{ mch-name }}.
        * Кластер {{ dataproc-name }}.
        * Виртуальная машина.

    1. Укажите параметры инфраструктуры в файле конфигурации `data-proc-data-exchange-with-mch.tf` в блоке `locals`:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
        * `network_id` — идентификатор созданной ранее облачной сети.
        * `subnet_id` — идентификатор созданной ранее подсети.
        * `zone_id` – зона доступности, в которой будут созданы ресурсы.
        * `ch_user_name` — имя пользователя базы данных `db1` {{ mch-name }}.
        * `ch_user_password` — пароль для пользователя `user1` базы данных `db1` {{ mch-name }}.
        * `vm_username` — имя пользователя для виртуальной машины.
        * `vm_ssh_key` — абсолютный путь к публичному ключу для виртуальной машины. Подробнее см. в разделе [{#T}](../../compute/operations/vm-connect/ssh.md).
        * `vm_image_id` — образ виртуальной машины. [Выберите нужный образ из списка](../../compute/operations/images-with-pre-installed-software/get-list.md) или используйте уже заданный образ Ubuntu 20.04 (`fd8ciuqfa001h8s9sa7i`).
        * `dp_ssh_key` — абсолютный путь к публичному ключу для кластера {{ dataproc-name }}. Подробнее см. в разделе [{#T}](../../data-proc/operations/connect.md#data-proc-ssh).
        * `bucket_name` — имя бакета {{ objstorage-name }}. Оно должно быть уникальным в рамках {{ yandex-cloud }}.

    1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационном файле, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки обмена данными между {{ mch-name }} и {{ dataproc-name }} входит:
* плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Выгрузите данные из {{ mch-name }} {#export-from-mch}

### Подготовьте кластер {{ mch-name }} {#prepare-mch}

1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect.md) `db1` кластера {{ mch-name }} от имени пользователя `user1`.
1. Наполните базу тестовыми данными. В качестве примера используется простая таблица с именами и возрастом людей.

    1. Создайте таблицу:

        ```sql
        CREATE TABLE persons (
            `name` String,
            `age` UInt8) ENGINE = MergeTree ()
        ORDER BY
            `name`;
        ```

    1. Наполните таблицу данными:

        ```sql
        INSERT INTO persons VALUES
           ('Anna', 19),
           ('Michael', 65),
           ('Alvar', 28),
           ('Lilith', 50),
           ('Max', 27),
           ('Jaimey', 34),
           ('Dmitry', 42),
           ('Qiang', 19),
           ('Augustyna', 20),
           ('Maria', 28);
        ```

### Запустите выгрузку из {{ mch-name }} {#start-mch-export}

1. Откройте [веб-интерфейс Zeppelin](../../data-proc/operations/connect-interfaces.md#ui-proxy-list) кластера {{ dataproc-name }}.
1. Нажмите ссылку **Create new note** и укажите параметры заметки:
    * **Note name** — введите произвольное имя заметки.
    * **Default Interpreter** — выберите `spark`.
1. Нажмите кнопку **Create**.
1. Чтобы сформировать датафрейм, создайте и запустите параграф с кодом. Для этого выделите нужный параграф и нажмите кнопку **Run this paragraph** (также можно использовать сочетание клавиш **Shift**+**Enter**).

    ```python
    %spark.pyspark
    jdbcPort = 8443
    jdbcHostname = "c-<идентификатор кластера {{ mch-name }}>.rw.{{ dns-zone }}"
    jdbcDatabase = "db1"
    jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"
    df = spark.read.format("jdbc") \
    .option("url", jdbcUrl) \
    .option("user","user1") \
    .option("password","<пароль к базе данных {{ mch-name }}>") \
    .option("dbtable","persons") \
    .load()
    df.show()
    ```

    Если датафрейм сформирован успешно, ответ на запрос будет содержать таблицу с исходными данными.

1. Чтобы выгрузить информацию из датафрейма в бакет {{ objstorage-name }} или таблицу Hive, создайте и запустите параграф с кодом.

    {% list tabs %}

    - {{ objstorage-name }}

        ```python
        %spark.pyspark
        df.write.parquet('s3a://<имя бакета>/<директория бакета>/')
        spark.read.parquet('s3a://<имя бакета>/<директория бакета/').show()
        ```

    - Hive

        ```python
        %spark.pyspark
        df.createOrReplaceTempView("mytempTable")
        spark.sql("CREATE TABLE IF NOT EXISTS persons AS SELECT * FROM mytempTable");
        spark.sql("SELECT * FROM persons").show()
        ```

    {% endlist %}

    Если выгрузка прошла успешно, ответ на запрос будет содержать таблицу с исходными данными.

## Загрузите данные в {{ mch-name }} {#import-to-mch}

### Подготовьте исходные данные {#prepare-source-data}

Источником данных может быть директория HDFS или бакет {{ objstorage-name }}. В качестве исходных данных будет использоваться CSV-файл с именами и возрастом людей:

```text
name,age
Anna,19
Michael,65
Fred,28
Alsou,50
Max,27
John,34
Dmitry,42
Oleg,19
Alina,20
Maria,28
```

{% list tabs %}

- {{ objstorage-name }}

    Создайте файл `example.csv` с тестовыми данными и [загрузите его в бакет {{ objstorage-name }}](../../storage/operations/objects/upload.md).

- Директория HDFS

    1. [Подключитесь к хосту кластера {{ dataproc-name }}](../../data-proc/operations/connect.md) в подкластере для хранения данных.
    1. Определите адрес сервера HDFS. Этот адрес понадобится указать при выгрузке данных в директорию HDFS.

        ```bash
        hdfs getconf -confKey fs.defaultFS
        ```

    1. Создайте файл `example.csv` с тестовыми данными.
    1. Создайте директорию HDFS для записи тестовых данных:

        ```bash
        hdfs dfs -mkdir /user/testdata
        ```

    1. Скопируйте файл с тестовыми данными из локальной файловой системы в директорию HDFS:

        ```bash
        hdfs dfs -copyFromLocal example.csv /user/testdata/example.csv
        ```

{% endlist %}

### Запустите выгрузку из {{ dataproc-name }} {#start-dp-export}

1. Откройте [веб-интерфейс Zeppelin](../../data-proc/operations/connect-interfaces.md#ui-proxy-list) кластера {{ dataproc-name }}.
1. Нажмите ссылку **Create new note** и укажите параметры заметки:
    * **Note name** — введите произвольное имя заметки.
    * **Default Interpreter** — выберите `spark`.
1. Нажмите кнопку **Create**.
1. Чтобы сформировать датафрейм, создайте и запустите параграф с кодом.

    {% list tabs %}

    - {{ objstorage-name }}

        ```python
        %spark.pyspark
        df = spark.read.option("header", True).csv("s3a://<имя бакета>/<директория бакета>/example.csv")
        df.show()
        ```

    - Директория HDFS

        ```python
        %spark.pyspark
        df = spark.read.option("header", True).csv("hdfs://<адрес сервера HDFS>/user/testdata/example.csv")
        df.show()
        ```

    Если выгрузка прошла успешно, ответ на запрос будет содержать таблицу с исходными данными.

    {% endlist %}

1. Чтобы выгрузить информацию из датафрейма в базу данных {{ mch-name }}, создайте и запустите параграф с кодом.

    ```python
    %spark.pyspark
    jdbcPort = 8443
    jdbcHostname = "c-<идентификатор кластера {{ mch-name }}>.rw.{{ dns-zone }}"
    jdbcDatabase = "db1"
    jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"
    df.write.format("jdbc") \
    .mode("error") \
    .option("url", jdbcUrl) \
    .option("dbtable", "example") \
    .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
    .option("user","user1") \
    .option("password","<пароль к базе данных {{ mch-name }}>") \
    .save()
    ```

### Проверьте загрузку данных в {{ mch-name }} {#check-mch-export}

1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect.md) `db1` кластера {{ mch-name }} от имени пользователя `user1`.
1. Выполните запрос:

    ```sql
    SELECT * FROM example;
    ```

    Если выгрузка прошла успешно, ответ на запрос будет содержать таблицу с данными.

## Удалите созданные ресурсы {#clear-out}

{% list tabs %}

* Вручную

    * [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, освободите и [удалите его](../../vpc/operations/address-delete.md).
    * Удалите кластеры:
        * [{{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md);
        * [{{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).
    * Если вы создавали бакет {{ objstorage-name }}, [удалите его](../../storage/operations/buckets/delete.md).

* С помощью Terraform

    Если вы создали ресурсы с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-proc-data-exchange-with-mch.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-proc-data-exchange-with-mch.tf`, будут удалены.

{% endlist %}
