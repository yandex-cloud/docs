# Импорт данных из {{ mmy-full-name }} в {{ dataproc-full-name }} с помощью Sqoop

{% include [What is the Sqoop](./header.md) %}

## Перед началом работы {#before-you-begin}

{% include [Same Network](../_tutorials_includes/note-same-network.md) %}

1. [Создайте облачную сеть](../../vpc/operations/network-create.md).
1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности `{{ zone-id }}`.
1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для созданной подсети — это обязательное условие для работы кластера {{ dataproc-name }}.

Остальные ресурсы вы можете создать вручную или с помощью {{ TF }}.

### Вручную {#create-manual}

1. [Создайте кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей вам [конфигурации](../../managed-mysql/concepts/instance-types.md) со следующими настройками:

    * базой данных `db1`;
    * пользователем `user1`.

1. Чтобы импортировать данные в бакет {{ objstorage-name }}:

    1. [Создайте бакет](../../storage/operations/buckets/create.md).
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
    1. [Выдайте этому сервисному аккаунту](../../storage/operations/buckets/edit-acl.md) разрешения на чтение и запись в бакет.

1. [Создайте кластер {{ dataproc-name }}](../../data-proc/operations/cluster-create.md) любой подходящей вам [конфигурации](../../data-proc/concepts/instance-types.md).

    {% include [Settings for DataProc cluster](./data-proc-cluster-settings.md) %}

1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) для подключения к кластерам {{ mmy-name }} и {{ dataproc-name }}.

1. Настройте группы безопасности кластеров и виртуальной машины, чтобы разрешить подключение:

    * [к виртуальной машине и кластеру {{ dataproc-name }}](../../data-proc/operations/connect.md);
    * [к кластеру {{ mmy-name }}](../../managed-mysql/operations/connect.md#configure-security-groups).

### С помощью {{ TF }} {#create-terraform}

1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
1. Скачайте в ту же рабочую директорию файл конфигурации [clusters-mysql-data-proc-and-vm.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/sqoop/clusters-mysql-data-proc-and-vm.tf).

    В этом файле описаны:

    * [группы безопасности](../../vpc/concepts/security-groups.md) для кластеров и виртуальной машины;
    * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для кластера {{ dataproc-name }};
    * [бакет {{ objstorage-name }}](../../storage/concepts/bucket.md);
    * кластер {{ mmy-name }};
    * кластер {{ dataproc-name }};
    * виртуальная машина с публичным доступом из интернета.

1. Укажите параметры инфраструктуры в файле конфигурации `clusters-mysql-data-proc-and-vm.tf` в блоке `locals`:

    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
    * `network_id` — идентификатор созданной ранее облачной сети.
    * `subnet_id` — идентификатор созданной ранее подсети.
    * `storage_sa_id` — идентификатор сервисного аккаунта, с помощью которого будет создан бакет в {{ objstorage-name }}.
    * `data_proc_sa` — имя сервисного аккаунта для кластера {{ dataproc-name }}. Оно должны быть уникальным в каталоге.
    * `my_cluster_version` — версия {{ MY }} кластера {{ mmy-name }}.
    * `my_cluster_password` — пароль для пользователя `user1` базы данных `db1` {{ mmy-name }}.
    * `vm_image_id` — идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list) с Ubuntu без [GPU](../../glossary/gpu.md). Например, для [Ubuntu 20.04 LTS](https://cloud.yandex.ru/marketplace/products/yc/ubuntu-20-04-lts).
    * `vm_username` и `vm_public_key` — логин и абсолютный путь к [публичному SSH-ключу](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине. По умолчанию в образе [Ubuntu 20.04 LTS](https://cloud.yandex.ru/marketplace/products/yc/ubuntu-20-04-lts) указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.
    * `bucket_name` — имя бакета в {{ objstorage-name }}. Оно должны быть уникальным для всего {{ objstorage-name }}.
    * `dp_public_key` — абсолютный путь к [публичному SSH-ключу](../../data-proc/operations/connect.md#data-proc-ssh) для кластера {{ dataproc-name }}.

        Для [SSH-подключения](../../glossary/ssh-keygen.md) к хостам кластера {{ dataproc-name }} версии 1.х используйте имя пользователя `root`.

1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

    ```bash
    terraform validate
    ```

    Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

1. Создайте необходимую инфраструктуру:

    {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовка кластера-источника {#prepare}

1. [Подключитесь к базе данных](../../managed-mysql/operations/connect.md) `db1` кластера {{ mmy-full-name }} от имени пользователя `user1`.
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

{% include [Shared settings](./shared-properties.md) %}
* Идентификатор кластера {{ mmy-name }}: `c9qgcd6lplrsjt9jhtuu`.

{% list tabs %}

* {{ objstorage-name }}

    1. [Выполните все необходимые подготовительные шаги](../../data-proc/operations/sqoop-usage.md#object-storage).
    1. Выполните команду:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:mysql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mmy }}/db1" \
            --username "user1" \
            --P \
            --table "persons" \
            --target-dir "s3a://my-bucket/import-directory" \
            --split-by "age"
        ```

* Директория HDFS

    1. [Выполните все необходимые подготовительные шаги](../../data-proc/operations/sqoop-usage.md#hdfs).
    1. Выполните команду:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:mysql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mmy }}/db1" \
            --username "user1" \
            --table "persons" \
            --target-dir "import-directory" \
            --P \
            --split-by "age"
        ```

* Apache Hive

    1. [Выполните все необходимые подготовительные шаги](../../data-proc/operations/sqoop-usage.md#apache-hive).
    1. Выполните команду:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:mysql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mmy }}/db1" \
            --username "user1" \
            --P \
            --table "persons" \
            --hive-import \
            --create-hive-table \
            --hive-database "db-hive" \
            --hive-table "import-table" \
            --split-by "age"
        ```

* Apache HBase

    1. [Выполните все необходимые подготовительные шаги](../../data-proc/operations/sqoop-usage.md#apache-hbase).
    1. Выполните команду:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:mysql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mmy }}/db1" \
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

{% include [Check import](./check-import.md) %}

## Удаление созданных ресурсов {#clear-out}

{% list tabs %}

* Вручную

    Если созданные ресурсы вам больше не нужны, удалите их:

    1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, освободите и [удалите его](../../vpc/operations/address-delete.md).
    1. Удалите кластеры:

        * [{{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md);
        * [{{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).

    1. Если вы создавали бакет {{ objstorage-full-name }}, [удалите его](../../storage/operations/buckets/delete.md).
    1. Удалите [подсеть](../../vpc/operations/subnet-delete.md).
    1. Удалите [облачную сеть](../../vpc/operations/network-delete.md).

* С помощью Terraform

    Чтобы удалить инфраструктуру, созданную с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `clusters-mysql-data-proc-and-vm.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `clusters-mysql-data-proc-and-vm.tf`, будут удалены.

    Удалите созданные вручную:

    1. [Подсеть](../../vpc/operations/subnet-delete.md).
    1. [Облачную сеть](../../vpc/operations/network-delete.md).

{% endlist %}
