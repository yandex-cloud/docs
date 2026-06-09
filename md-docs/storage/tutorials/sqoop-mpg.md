# Импорт данных из {{ mpg-full-name }} в {{ dataproc-full-name }} с помощью Sqoop

# Импорт данных из {{ mpg-full-name }} в {{ dataproc-full-name }} с помощью Sqoop


Утилита [Sqoop](../../data-proc/operations/sqoop-usage.md) позволяет импортировать базы данных в кластер {{ dataproc-name }}. В зависимости от конфигурации кластера {{ dataproc-name }} вы можете выполнить импорт в:

* бакет {{ objstorage-full-name }};
* директорию HDFS;
* Apache Hive;
* Apache HBase.

Чтобы импортировать базы данных кластера-источника с помощью Sqoop в кластер-приемник {{ dataproc-name }}:

1. [Подготовьте кластер-источник](#prepare).
1. [Выполните импорт](#import).
1. [Проверьте корректность импорта](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

Утилита Sqoop не поддерживается для кластеров {{ dataproc-name }} версии 2.0 и выше. В качестве альтернативы используйте [функциональные возможности {{ SPRK }}](https://spark.apache.org/docs/latest/sql-data-sources-jdbc.html).

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mpg-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Кластер {{ dataproc-name }}: использование вычислительных ресурсов с наценкой за сервис {{ dataproc-name }}, использование сетевых дисков, получение и хранение логов, объем исходящего трафика (см. [тарифы {{ dataproc-name }}](../../data-proc/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../pricing.md)).
* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).


## Перед началом работы {#before-you-begin}

{% note info %}

Разместите кластеры и [виртуальную машину](../../compute/concepts/vm.md) в одной [облачной сети](../../vpc/concepts/network.md#network).

{% endnote %}

1. [Создайте облачную сеть](../../vpc/operations/network-create.md).
1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности `{{ zone-id }}`.
1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для созданной подсети — это обязательное условие для работы кластера {{ dataproc-name }}.

Остальные ресурсы вы можете создать вручную или с помощью {{ TF }}.

### Вручную {#create-manual}

1. [Создайте кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей вам [конфигурации](../../managed-postgresql/concepts/instance-types.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`;
    * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `user1`.

1. Чтобы импортировать данные в бакет {{ objstorage-name }}:

    1. [Создайте бакет](../operations/buckets/create.md) с ограниченным доступом.
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями:

        * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent);
        * [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner);
        * [{{ roles-monitoring-viewer }}](../../monitoring/security/index.md#monitoring-viewer);
        * [storage.viewer](../security/index.md#storage-viewer);
        * [storage.uploader](../security/index.md#storage-uploader).

    1. [Выдайте этому сервисному аккаунту](../operations/buckets/edit-acl.md) разрешения на чтение и запись в бакет.

1. [Создайте кластер {{ dataproc-name }}](../../data-proc/operations/cluster-create.md) любой подходящей вам [конфигурации](../../data-proc/concepts/instance-types.md).

    Укажите настройки, соответствующие хранилищу, в которое будут импортированы данные:
    
    {% list tabs group=storage_system %}
    
    - {{ objstorage-name }} {#storage}
    
        * **{{ ui-key.yacloud.mdb.cluster.overview.label_service-account }}** — имя созданного ранее сервисного аккаунта.
        * **{{ ui-key.yacloud.mdb.cluster.overview.label_bucket }}** — имя созданного ранее бакета.
        * **{{ ui-key.yacloud.mdb.cluster.overview.label_services }}** — `Sqoop`.
    
    - Директория HDFS {#hdfs}
    
        **Сервисы**:
    
        * `HBase`,
        * `HDFS`,
        * `Sqoop`,
        * `Yarn`,
        * `Zookeeper`.
    
    - Apache Hive {#hive}
    
        * **Сервисы**:
    
            * `HDFS`,
            * `Hive`,
            * `Mapreduce`,
            * `Sqoop`,
            * `Yarn`.
    
        * **Свойства** — ключ `hive:hive.execution.engine` со значением `mr`.
    
    - Apache HBase {#hbase}
    
        **Сервисы**:
    
        * `HBase`,
        * `HDFS`,
        * `Sqoop`,
        * `Yarn`,
        * `Zookeeper`.
    
    {% endlist %}

1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) для подключения к кластерам {{ mpg-name }} и {{ dataproc-name }}.

1. Если вы используете группы безопасности для кластеров и виртуальной машины, настройте их так, чтобы разрешить подключение:

    * [к виртуальной машине и кластеру {{ dataproc-name }}](../../data-proc/operations/security-groups.md);
    * [к кластеру {{ mpg-name }}](../../managed-postgresql/operations/connect/index.md#configuring-security-groups).

### С помощью {{ TF }} {#create-terraform}

1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

1. Скачайте в ту же рабочую директорию файл конфигурации [clusters-postgresql-data-proc-and-vm.tf](https://github.com/yandex-cloud-examples/yc-data-proc-postgresql-data-import/blob/main/clusters-postgresql-data-proc-and-vm.tf).

    В этом файле описаны:

    * [группы безопасности](../../vpc/concepts/security-groups.md) для кластеров и виртуальной машины;
    * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для кластера {{ dataproc-name }};
    * [бакет {{ objstorage-name }}](../concepts/bucket.md);
    * кластер {{ mpg-name }};
    * кластер {{ dataproc-name }};
    * виртуальная машина с публичным доступом из интернета.

1. Укажите параметры инфраструктуры в файле конфигурации `clusters-postgresql-data-proc-and-vm.tf` в блоке `locals`:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
    * `network_id` — идентификатор созданной ранее облачной сети.
    * `subnet_id` — идентификатор созданной ранее подсети.
    * `storage_sa_id` — идентификатор сервисного аккаунта, с помощью которого будет создан бакет в {{ objstorage-name }}.
    * `data_proc_sa` — имя сервисного аккаунта для кластера {{ dataproc-name }}. Оно должны быть уникальным в каталоге.
    * `pg_cluster_version` — версия {{ PG }} кластера {{ mpg-name }}.
    * `pg_cluster_password` — пароль для пользователя `user1` базы данных `db1` {{ mpg-name }}.
    * `vm_image_id` — идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list.md) с Ubuntu без [GPU](../../glossary/gpu.md). Например, для [Ubuntu 20.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts).
    * `vm_username` и `vm_public_key` — логин и абсолютный путь к [публичному SSH-ключу](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине. По умолчанию в образе [Ubuntu 20.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts) указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.
    * `bucket_name` — имя бакета в {{ objstorage-name }}. Оно должны быть уникальным для всего {{ objstorage-name }}.
    * `dp_public_key` — абсолютный путь к [публичному SSH-ключу](../../data-proc/operations/connect-ssh.md) для кластера {{ dataproc-name }}.

        Для [SSH-подключения](../../glossary/ssh-keygen.md) к хостам кластера {{ dataproc-name }} версии 1.х используйте имя пользователя `root`.

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

## Подготовка кластера-источника {#prepare}

1. [Подключитесь к базе данных](../../managed-postgresql/operations/connect/index.md) `db1` кластера {{ mpg-name }} от имени пользователя `user1`.
1. Наполните базу тестовыми данными. В качестве примера используется простая таблица с именами и возрастом людей:

    1. Создайте таблицу:

        ```sql
        CREATE TABLE persons (
            Name VARCHAR(30) NOT NULL,
            Age INTEGER DEFAULT 0,
            PRIMARY KEY (Name)
        );
        ```

    1. Наполните таблицу данными:

        ```sql
        INSERT INTO persons (Name, Age) VALUES
            ('Anna', 19),
            ('Michael', 65),
            ('Fred', 28),
            ('Alsou', 50),
            ('Max', 27),
            ('John', 34),
            ('Dmitry', 42),
            ('Oleg', 19),
            ('Alina', 20),
            ('Maria', 28);
        ```

## Импорт базы данных {#import}

Чтобы обеспечить [параллелизм базы данных](https://sqoop.apache.org/docs/1.4.2/SqoopUserGuide.html#_controlling_parallelism), Sqoop позволяет разделять импортируемые данные не только по первичному ключу, но и по другим столбцам таблицы. В примере разделение данных выполняется по столбцу `age`.

Пусть:

* FQDN хоста подкластера {{ dataproc-name }} для хранения данных: `rc1c-dataproc-d-vfw6fa8x********.{{ dns-zone }}`.
* Имя бакета в {{ objstorage-name }}.
* Имена директорий в {{ objstorage-name }} и HDFS: `import-directory`.
* Имя базы данных Apache Hive: `db-hive`.
* Имя семейства столбцов Apache HBase: `family1`.
* Имена таблиц HBase и Hive: `import-table`.
* Идентификатор кластера {{ mpg-name }}: `c9qgcd6lplrs********`.

{% list tabs group=storage_system %}

- {{ objstorage-name }} {#storage}

    1. [Выполните все необходимые подготовительные шаги](../../data-proc/operations/sqoop-usage.md#object-storage).
    1. Выполните команду:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:postgresql://c-c9qgcd6lplrs********.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
            --username "user1" \
            --P \
            --table "persons" \
            --target-dir "s3a://<имя_бакета>/import-directory" \
            --split-by "age"
        ```

- Директория HDFS {#hdfs}

    1. [Выполните все необходимые подготовительные шаги](../../data-proc/operations/sqoop-usage.md#hdfs).
    1. Выполните команду:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:postgresql://c-c9qgcd6lplrs********.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
            --username "user1" \
            --table "persons" \
            --target-dir "import-directory" \
            --P \
            --split-by "age"
        ```

- Apache Hive {#hive}

    1. [Выполните все необходимые подготовительные шаги](../../data-proc/operations/sqoop-usage.md#apache-hive).
    1. Выполните команду:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:postgresql://c-c9qgcd6lplrs********.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
            --username "user1" \
            --P \
            --table "persons" \
            --hive-import \
            --create-hive-table \
            --hive-database "db-hive" \
            --hive-table "import-table" \
            --split-by "age"
        ```

- Apache HBase {#hbase}

    1. [Выполните все необходимые подготовительные шаги](../../data-proc/operations/sqoop-usage.md#apache-hbase).
    1. Выполните команду:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:postgresql://c-c9qgcd6lplrs********.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
            --username "user1" \
            --P \
            --table "persons" \
            --hbase-create-table \
            --column-family "family1" \
            --hbase-table "import-table" \
            --split-by "age"
        ```

{% endlist %}

## Проверка корректности импорта {#check}

Если импорт прошел успешно, вы увидите содержимое таблицы `persons`.

{% list tabs group=storage_system %}

- {{ objstorage-name }} {#storage}

    [Скачайте из бакета](../operations/objects/download.md) файлы с результатами импорта.

- Директория HDFS {#hdfs}

    1. [Подключитесь](../../data-proc/operations/connect-ssh.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
    1. Выполните команду:

        ```bash
        hdfs dfs -cat /user/root/import-directory/*
        ```

- Apache Hive {#hive}

    1. [Подключитесь](../../data-proc/operations/connect-ssh.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
    1. Выполните команду:

        ```bash
        hive -e "SELECT * FROM import-table;"
        ```

- Apache HBase {#hbase}

    1. [Подключитесь](../../data-proc/operations/connect-ssh.md) по SSH к хосту подкластера {{ dataproc-name }} для хранения данных.
    1. Выполните команду:

        ```bash
        echo -e "scan 'import-table'" | hbase shell -n
        ```

{% endlist %}

## Удаление созданных ресурсов {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, освободите и [удалите его](../../vpc/operations/address-delete.md).
    1. Удалите кластеры:

        * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md);
        * [{{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).

    1. Если вы создавали бакет {{ objstorage-name }}, [удалите его](../operations/buckets/delete.md).
    1. [Удалите подсеть](../../vpc/operations/subnet-delete.md).
    1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
    1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
    1. [Удалите облачную сеть](../../vpc/operations/network-delete.md).
    1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    Чтобы удалить инфраструктуру, созданную с помощью {{ TF }}:

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

    Удалите созданные вручную:

    1. [Подсеть](../../vpc/operations/subnet-delete.md).
    1. [Таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
    1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
    1. [Облачную сеть](../../vpc/operations/network-delete.md).

{% endlist %}