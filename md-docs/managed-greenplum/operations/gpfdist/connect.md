# Подключение к внешнему файловому серверу

[Greenplum® Parallel File Server](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/utility_guide-ref-gpfdist.html) (`gpfdist`) — утилита для чтения и записи данных из файлов, расположенных на удаленных серверах. Она установлена на всех хостах-сегментах кластера Yandex MPP Analytics for PostgreSQL и обеспечивает параллельную загрузку данных, распределяя их между сегментами равномерно или согласно заданному [ключу дистрибуции](../../concepts/sharding.md#distribution-key). Это повышает производительность при работе с большими объемами внешних данных.

Для кластера Yandex MPP Analytics for PostgreSQL с СУБД Apache Cloudberry™ используется собственная утилита `gpfdist`. Подробнее в [документации Apache Cloudberry™](https://cloudberry.apache.org/docs/sys-utilities/gpfdist).

Утилита `gpfdist` может работать с любыми текстовыми файлами, которые содержат разделители, а также со сжатыми файлами gzip и bzip2.

Для чтения или записи файлов на внешнем сервере:

1. [Установите и запустите](#run-gpfdist) `gpfdist` на удаленном сервере, где находятся нужные файлы.

    Для СУБД Greenplum® `gpfdist` устанавливается с помощью пакета Greenplum® Loader или Greenplum® Database.

    Для СУБД Apache Cloudberry™ `gpfdist` устанавливается вместе с СУБД Apache Cloudberry™.

1. В кластере Yandex MPP Analytics for PostgreSQL [создайте внешнюю таблицу](#create-gpfdist-table), которая будет ссылаться на эти файлы.

## Запуск gpfdist {#run-gpfdist}

1. Установите `gpfdist`:

    {% list tabs %}

    - Для Greenplum®

        Скачайте и установите пакет Greenplum® Loader с [сайта VMware](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/client_tool_guides-installing.html) или пакет Greenplum® Database из бакета Yandex Object Storage по [инструкции](../greenplum-db.md).

        
        {% note info %}

        Скачивание и использование продуктов с сайта VMware не входит в [условия использования Yandex MPP Analytics for PostgreSQL](https://yandex.ru/legal/cloud_termsofuse/?lang=ru) и является предметом отдельного регулирования между клиентом и VMware. Яндекс не несет ответственности за взаимоотношения клиента и VMware, вытекающие из использования клиентом продуктов или услуг VMware.

        {% endnote %}


    - Для Apache Cloudberry™

        Установите СУБД Apache Cloudberry™ по инструкции из [документации Apache Cloudberry™](https://cloudberry.apache.org/docs/deployment).

    {% endlist %}

1. Запустите утилиту `gpfdist`:

    ```bash
    gpfdist -d <директория_с_файлами_данных> -p <порт_подключения> -l <путь_к_файлу_логов>
    ```

    Где:

    * `<директория_с_файлами_данных>` — локальный путь к директории, в которой хранятся файлы для чтения или записи данных через [внешнюю таблицу](../../concepts/external-tables.md).
    * `<порт_подключения>` — порт, через который будет работать утилита. По умолчанию — `8080`.
    * `<путь_к_файлу_логов>` — (опционально) путь к файлу, в который `gpfdist` будет записывать логи своей работы.

    Чтобы распределить нагрузку на сеть, вы можете запустить несколько экземпляров `gpfdist` на одном сервере, указав разные директории и порты для подключения, например:

    ```bash
    gpfdist -d /var/load_files1 -p 8081 -l /home/gpadmin/log1 & \
    gpfdist -d /var/load_files2 -p 8082 -l /home/gpadmin/log2 &
    ```

1. Проверьте, что файлы в указанной директории доступны на указанном порту из Yandex Cloud. Для этого выполните команду с ВМ в Yandex Cloud:

    ```bash
    wget http://hostname:port/filename
    ```

## Создание внешней таблицы с использованием утилиты gpfdist {#create-gpfdist-table}

Синтаксис SQL-запроса для создания внешней таблицы:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <имя_таблицы>
       (<имя_столбца> <тип_данных> [, ...])
       LOCATION('gpfdist://<путь_к_файлу_на_удаленном_сервере>' [, ...])
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Где:

* `<имя_таблицы>` — имя внешней таблицы, которая будет создана в кластере Yandex MPP Analytics for PostgreSQL.
* `<имя_столбца>` — имя столбца таблицы.
* `<тип_данных>` — тип данных столбца таблицы.
* `<путь_к_файлу_на_удаленном_сервере>` — адрес сервера, на котором запущен `gpfdist`, порт для подключения и путь к файлу. Вы можете указать конкретный файл или задать маску с помощью символа звездочки (\*).

Опция `WRITABLE` позволяет записывать данные во внешний объект. Чтобы считать данные из внешнего объекта, создайте внешнюю таблицу с опцией `READABLE`.

## Примеры создания внешних таблиц {#gpfdist-examples}

* Создание внешней таблицы с данными из файла `file.csv` на сервере `hostname`:

    ```sql
    CREATE EXTERNAL TABLE tableName (id int)
           LOCATION('gpfdist://hostname:8080/file.csv')
           FORMAT 'CSV' (DELIMITER ',');
    ```

* Создание внешней таблицы, объединяющей данные из всех файлов формата `txt`, где `|` — символ разделителя, а пробел — значение `NULL`, на серверах `hostname1` и `hostname2`:

    ```sql
    CREATE EXTERNAL TABLE tableName (...)
           LOCATION('gpfdist://hostname1:8081/*.txt',
                    'gpfdist://hostname2:8081/*.txt')
           FORMAT 'TEXT' (DELIMITER '|' NULL ' ');
    ```

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._