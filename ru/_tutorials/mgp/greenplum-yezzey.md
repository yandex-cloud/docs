# Выгрузка данных {{ GP }} в холодное хранилище

Данные {{ mgp-full-name }} хранятся на дисках кластера. С помощью [расширения {{ YZ }}](https://github.com/yezzey-gp/yezzey/) от {{ yandex-cloud }} эти данные можно перенести в холодное хранилище {{ objstorage-full-name }}. Тогда они будут храниться в служебном бакете в сжатом и зашифрованном виде. Это удобно, если данные нужно хранить долго, а работать с ними планируется редко. Так хранение [будет дешевле](../../storage/pricing.md).

{{ YZ }} поддерживает таблицы AO и AOCO (append-optimized storage). Подробнее о таблицах см. в разделе [{#T}](../../managed-greenplum/concepts/tables.md) и [документации {{ GP }}](https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/admin_guide-ddl-ddl-storage.html).


{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и не тарифицируется.

{% endnote %}


Чтобы перенести данные с дисков кластера {{ mgp-name }} в холодное хранилище {{ objstorage-name }}:

1. [Перенесите таблицу {{ GP }} в {{ objstorage-name }}](#transfer).
1. [Проверьте результат](#check).

Также есть возможность [перенести данные обратно](#offload-to-local-storage) на диски кластера.

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер](../../managed-greenplum/operations/cluster-create.md) {{ mgp-name }}. При создании убедитесь, что включена опция **{{ ui-key.yacloud.greenplum.section_cloud-storage }}**.

   {% note info %}

   Эту опцию нельзя отключить после сохранения настроек кластера.

   {% endnote %}

1. Получите SSL-сертификат для подключения к базе данных {{ GP }}:

   {% include [install-certificate](../../_includes/mdb/mgp/install-certificate.md) %}

   {% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Выгрузите таблицу {{ GP }} в {{ objstorage-name }} {#transfer}

1. Подключитесь к кластеру:

   {% include [default-connstring](../../_includes/mdb/mgp/default-connstring.md) %}

1. Создайте БД `db_with_yezzey`:

   ```bash
   CREATE DATABASE db_with_yezzey;
   ```

   Для новой БД будут предоставлены права доступа на установку расширений. Такие права не выдаются для БД, установленной по умолчанию.

1. Подключитесь к новой БД:

   ```bash
   \connect db_with_yezzey
   ```

1. Создайте расширение {{ YZ }}:

   ```bash
   CREATE EXTENSION yezzey;
   ```

1. Создайте AO-таблицу `ao_table`:

   ```bash
   CREATE TABLE ao_table (a int)
       WITH (appendoptimized=true)
       DISTRIBUTED BY (a);
   ```

1. Заполните таблицу рядом целых чисел от 1 до 10 000:

   ```bash
   INSERT INTO ao_table SELECT * FROM GENERATE_SERIES(1, 10000);
   ```

1. Перенесите данные таблицы `ao_table` в холодное хранилище {{ objstorage-name }}:

   ```bash
   SELECT yezzey_define_offload_policy('ao_table');
   ```

## Проверьте результат {#check}

1. Проверьте, сколько места в локальном кеше кластера и в хранилище {{ objstorage-name }} занимают:

   * таблица `ao_table`:

      ```bash
      SELECT * FROM yezzey_offload_relation_status('ao_table');
      ```

   * каждый сегментный файл таблицы `ao_table`:

      ```bash
      SELECT * FROM yezzey_offload_relation_status_per_filesegment('ao_table');
      ```

   Если столбец `external_bytes` в выводе команд содержит ненулевые значения, значит, таблица перенесена в холодное хранилище {{ objstorage-name }}.

1. Посмотрите, какие сегментные файлы таблицы перенесены в хранилище {{ objstorage-name }}:

   ```bash
   SELECT * FROM yezzey_relation_describe_external_storage_structure('ao_table');
   ```

1. Убедитесь, что доступно чтение данных из {{ objstorage-name }}:

   ```bash
   SELECT AVG(a) FROM ao_table;
   ```

   Результат:

   ```text
             avg          
   -----------------------
    5000.5000000000000000
   (1 row)
   ```

1. Убедитесь, что доступна запись в {{ objstorage-name }}:

   1. Добавьте в таблицу `ao_table` ряд целых чисел от 1 до 10 000:

      ```bash
      INSERT INTO ao_table SELECT * FROM GENERATE_SERIES(1, 10000);
      ```

   1. Проверьте, что количество строк увеличилось вдвое:

      ```bash
      SELECT COUNT(1) FROM ao_table;
      ```

      Результат:

      ```text
       count
      -------
       20000
      (1 row)
      ```

## Перенесите таблицу из {{ objstorage-name }} на диски кластера {#offload-to-local-storage}

Если нужно перенести таблицу `ao_table` из хранилища {{ objstorage-name }} обратно на диски кластера {{ mgp-name }}, выполните команду:

```bash
SELECT yezzey_load_relation('ao_table');
```

## Удалите созданные ресурсы {#clear-out}

Если созданный кластер вам больше не нужен, [удалите его](../../managed-greenplum/operations/cluster-delete.md).
