# Импорт данных в кластер {{ dataproc-full-name }} из кластера {{ mmy-full-name }} с помощью Sqoop

{% include [What is the Sqoop](./header.md) %}

## Перед началом работы {#before-you-begin}

{% note info %}

Разместите кластеры и виртуальную машину в одной [облачной сети](../../../vpc/concepts/network.md).

{% endnote %}

1. {% include [Settings for MMY](./mmy/create.md) %}

1. Чтобы импортировать данные в бакет {{ objstorage-full-name }}:

    1. [Создайте бакет](../../../storage/operations/buckets/create.md) с именем `my-bucket`.
    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с именем `bucket-sa`.
    1. [Выдайте этому сервисному аккаунту](../../../storage/operations/buckets/edit-acl.md) права на запись в бакет `my-bucket`.

1. [Создайте кластер {{ dataproc-full-name }}](../../../data-proc/operations/cluster-create.md) любой подходящей вам [конфигурации](../../../data-proc/concepts/instance-types.md).

    {% include [Settings for DataProc cluster](./data-proc-cluster-settings.md) %}

1. [Создайте виртуальную машину](../../../compute/operations/vm-create/create-linux-vm.md) для подключения к кластеру-источнику и {{ dataproc-full-name }}.

1. Настройте группы безопасности кластеров и виртуальной машины, чтобы разрешить подключение:

    * [к виртуальной машине и кластеру {{ dataproc-full-name }}](../../../data-proc/operations/connect.md);
    * [к кластеру {{ mmy-full-name }}](../../../managed-mysql/operations/connect.md#configure-security-groups).

## Подготовка кластера-источника {#prepare}

{% include [Prepare MMY source](./mmy/prepare.md) %}

## Импорт базы данных {#database-import}

Чтобы обеспечить [параллелизм базы данных](https://sqoop.apache.org/docs/1.4.2/SqoopUserGuide.html#_controlling_parallelism), Sqoop позволяет разделять импортируемые данные не только по первичному ключу, но и по другим столбцам таблицы. В примере разделение данных выполняется по столбцу `age`.

Пусть:

{% include [Shared settings](./shared-properties.md) %}
* Идентификатор кластера {{ mmy-full-name }}: `c9qo26aher8lc71ns36p`.

### Импорт в {{ objstorage-full-name }} {#import-object-storage}

1. [Выполните все необходимые подготовительные шаги](../../../data-proc/operations/sqoop-usage.md#object-storage).
1. Выполните команду:

    {% include [Command for MMY](./mmy/storage.md) %}

### Импорт в директорию HDFS {#import-hdfs}

1. [Выполните все необходимые подготовительные шаги](../../../data-proc/operations/sqoop-usage.md#hdfs).
1. Выполните команду:

    {% include [HDFS for MMY](./mmy/hdfs.md) %}

### Импорт в Apache Hive {#import-hive}

1. [Выполните все необходимые подготовительные шаги](../../../data-proc/operations/sqoop-usage.md#apache-hive).
1. Выполните команду:

    {% include [HIVE for MMY](./mmy/hive.md) %}

### Импорт в Apache HBase {#import-hbase}

1. [Выполните все необходимые подготовительные шаги](../../../data-proc/operations/sqoop-usage.md#apache-hbase).
1. Выполните команду:

    {% include [HBASE for MMY](./mmy/hbase.md) %}

## Проверка корректности импорта {#check}

{% include [Check import](./check-import.md) %}

## Удаление созданных ресурсов {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите виртуальную машину](../../../compute/operations/vm-control/vm-delete.md).
1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, освободите и [удалите его](../../../vpc/operations/address-delete.md).
1. Удалите кластеры:

    * [{{ mmy-full-name }}](../../../managed-mysql/operations/cluster-delete.md);
    * [{{ dataproc-full-name }}](../../../data-proc/operations/cluster-delete.md).

1. Если вы создавали бакет {{ objstorage-full-name }}, [удалите его](../../../storage/operations/buckets/delete.md).
