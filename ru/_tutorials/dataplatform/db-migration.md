# Стратегия миграции базы данных в {{ yandex-cloud }}

Перенести базу данных в управляемый сервис баз данных {{ yandex-cloud }} можно несколькими способами: с помощью сервиса [{{ data-transfer-short-name }}](../../data-transfer/index.yaml), используя логическую репликацию, логический дамп или снапшоты. Способ зависит от того, какую базу данных вы переносите, какой у нее объем данных и какой простой допустим. Под _минимальным простоем_ понимается окно переключения: источник переводится в режим «только чтение», после того как данные перенесутся на приемник, переключается приложение. Если минимальный простой недоступен — запись на источнике останавливается на все время переноса.

Общие правила для всех баз данных:

* Пользователи и права доступа не переносятся ни одним способом — создайте их в кластере управляемой базы данных заново.
* Для [{{ data-transfer-short-name }}](../../data-transfer/index.yaml) нужен сетевой доступ к источнику: из интернета, через VPN или [Cloud Interconnect](../../interconnect/concepts/index.md).
* [Квота](../../data-transfer/concepts/limits.md) по умолчанию — 50 трансферов, из них 10 могут быть запущены одновременно.

## Выбор СУБД-источника {#db}

::: page-constructor
blocks:
  - type: 'card-layout-block'
    animated: false
    colSizes:
      all: 12
      sm: 3
    indent:
      top: '0'
      bottom: '0'
    children:
      - type: 'basic-card'
        title: 'PostgreSQL'
        text: 'Перенесите в Managed Service for PostgreSQL'
        urlTitle: 'PostgreSQL'
        url: '#pg'
        size: 's'
        border: 'shadow'
        centered: true
        indent:
            top: '0'
            bottom: '0'
      - type: 'basic-card'
        title: 'ClickHouse®'
        text: 'Перенесите в Managed Service for ClickHouse®'
        urlTitle: 'ClickHouse®'
        url: '#ch'
        size: 's'
        border: 'shadow'
        centered: true
        indent:
            top: '0'
            bottom: '0'
      - type: 'basic-card'
        title: 'MySQL®'
        text: 'Перенесите в Managed Service for MySQL®'
        urlTitle: 'MySQL®'
        url: '#my'
        size: 's'
        border: 'shadow'
        centered: true
        indent:
            top: '0'
            bottom: '0'
      - type: 'basic-card'
        title: 'MongoDB'
        text: 'Перенесите в Yandex StoreDoc'
        urlTitle: 'MongoDB'
        url: '#mg'
        size: 's'
        border: 'shadow'
        centered: true
        indent:
            top: '0'
            bottom: '0'
      - type: 'basic-card'
        title: 'Redis и Valkey™'
        text: 'Перенесите в Managed Service for Valkey™'
        urlTitle: 'Redis и Valkey™'
        url: '#rd-vlk'
        size: 's'
        border: 'shadow'
        centered: true
        indent:
            top: '0'
            bottom: '0'
      - type: 'basic-card'
        title: 'Greenplum®'
        text: 'Перенесите в Managed Service for Greenplum®'
        urlTitle: 'Greenplum®'
        url: '#gp'
        size: 's'
        border: 'shadow'
        centered: true
        indent:
            top: '0'
            bottom: '0'
      - type: 'basic-card'
        title: 'Elasticsearch или OpenSearch'
        text: 'Перенесите в Managed Service for OpenSearch'
        urlTitle: 'Elasticsearch или OpenSearch'
        url: '#es-os'
        size: 's'
        border: 'shadow'
        centered: true
        indent:
            top: '0'
            bottom: '0'
:::

## {{ PG }} {#pg}

  Приемник: [{{ mpg-short-name }}](../../managed-postgresql/index.yaml). 
  Способы: [{{ data-transfer-short-name }}](#pg-recommended), [логическая репликация](#pg-logical), [логический дамп](#pg-dump). 

  | Особенности БД | Способ                                                                      |
  | --- |-----------------------------------------------------------------------------|
  | База до 4 ТБ, у таблиц есть первичные ключи, допустим минимальный простой | **Рекомендуемый способ**: [{{ data-transfer-short-name }}](#pg-recommended) |
  | База больше 4 ТБ | [Логическая репликация](#pg-logical)                                        |
  | На источнике нельзя установить плагин `wal2json` | [Логическая репликация](#pg-logical)                                        |
  | Простой допустим и база небольшая | [Логический дамп: `pg_dump` и `pg_restore`](#pg-dump)                       |
  | Нельзя включить `wal_level = logical`, много таблиц без первичных ключей, есть большие объекты | [Логический дамп](#pg-dump)   |

{% list tabs group=db-migration %}

- {{ data-transfer-short-name }} {#pg-recommended}
   
  Используйте, если размер БД до 4 ТБ, на источнике установлен плагин `wal2json`, у таблиц на источнике есть первичные ключи. Выбирайте трансфер типа «Копирование и репликация».

  {% include [data-transfer](../_tutorials_includes/mdb-migration/data-transfer.md) %}

  Особенности применения {{ data-transfer-short-name }}:

  * Пока трансфер активен, слот репликации удерживает WAL на источнике. Лимит по умолчанию — 50 ГБ.
  * Таблицы без первичных ключей не переносятся на этапе репликации.
  * Не переносятся большие объекты и данные материализованных представлений.
  * Изменения схемы на этапе репликации применяются на приемнике вручную.

  Подробности в [руководстве](../../managed-postgresql/tutorials/data-migration.md).

- Логическая репликация {#pg-logical}
 
  Используйте [логическую репликацию {{ PG }}](../../managed-postgresql/tutorials/data-migration.md#logical-replication), если размер БД более 4 ТБ, на источнике нельзя установить плагин `wal2json`. Источник {{ PG }} должен быть версии 10 и выше, схема переносится вручную, изменения схемы не реплицируются. Минимальный простой — окно переключения. 

- Логический дамп {#pg-dump}

  Используйте [логический дамп](../../managed-postgresql/tutorials/data-migration.md#backup), когда на источнике нельзя включить `wal_level = logical`, много таблиц без первичных ключей и есть большие объекты (large objects). Этот способ применим для БД размером до 4 ТБ, допускающих простой.

{% endlist %}

## {{ CH }} {#ch}

  Приемник — [{{ mch-short-name }}](../../managed-clickhouse/index.yaml). Способы: [{{ data-transfer-short-name }}](#ch-recommended), [`BACKUP` и `RESTORE`](#ch-backup) через {{ objstorage-name }}, [функция `remoteSecure()`](#ch-remote). Все способы однократные: изменения, сделанные на источнике после начала переноса, в приемник не попадут.

  | Особенности БД | Способ                                                                      |
  | --- |-----------------------------------------------------------------------------|
  | База до 1 ТБ, у таблиц есть первичные ключи, допускается остановка записи на время переноса | **Рекомендуемый способ**: [{{ data-transfer-short-name }}](#ch-recommended) |
  | База больше 1 ТБ | [`BACKUP` и `RESTORE` через {{ objstorage-name }}](#ch-backup)              |
  | Шардированный приемник | [`BACKUP` и `RESTORE`](#ch-backup) или [`remoteSecure()`](#ch-remote)       |
  | Нужно перенести таблицы как есть: с движками, TTL и проекциями | [`BACKUP` и `RESTORE`](#ch-backup)                                          |
  | Отдельные таблицы | [`remoteSecure()`](#ch-remote)                                              |
  | Останавливать запись нельзя | [Обратитесь в техническую поддержку]({{ link-console-support }})            |

{% list tabs group=db-migration %}

- {{ data-transfer-short-name }} {#ch-recommended}
   
  Используйте для баз данных, не превышающих 1 ТБ. Тип трансфера — «Копирование», приемник нешардированный. Запись на источнике останавливается на время переноса.

  {% include [data-transfer](../_tutorials_includes/mdb-migration/data-transfer.md) %}

  Особенности применения {{ data-transfer-short-name }}:

  * Переносятся таблицы семейства `MergeTree` и материализованные представления. Обычные представления и словари создаются вручную.
  * Для каждой базы данных нужен отдельный трансфер. Базы с дефисом в названии не переносятся.
  * {{ data-transfer-short-name }} не поддерживает шардирование.

  Подробности в [руководстве](../../managed-clickhouse/tutorials/ch-to-mch-migration.md).

- `BACKUP` и `RESTORE` {#ch-backup}

  Используйте встроенные команды [`BACKUP` и `RESTORE` через {{ objstorage-name }}](../../managed-clickhouse/tutorials/data-migration.md), если размер БД более 1 ТБ, приемник шардированный или нужно перенести таблицы с сохранением движков, TTL и проекций. Источник {{ CH }} должен быть версии и выше с доступом к {{ objstorage-name }}.

- `remoteSecure()` {#ch-remote}
 
  Используйте [функцию `remoteSecure()`](../../managed-clickhouse/tutorials/data-migration.md) для отдельных таблиц. Запрос нагружает источник, большие таблицы переносите по партициям.

{% endlist %}

## {{ MY }} {#my}

  Приемник: [{{ mmy-short-name }}](../../managed-mysql/index.yaml). 
  Способы: [{{ data-transfer-short-name }}](#my-recommended), [логический дамп](#my-dump).

  | Особенности БД | Способ                                                                      |
  | --- |-----------------------------------------------------------------------------|
  | База до 1 ТБ, у таблиц есть первичные ключи, допускается остановка записи на время переноса | **Рекомендуемый способ**: [{{ data-transfer-short-name }}](#my-recommended) |
  | Простой допустим и база небольшая | [Логический дамп: `mysqldump` или `mydumper`](#my-dump)                     |
  | На источнике нельзя включить `binlog_format = ROW` | [Логический дамп](#my-dump)                                                 |
  | Много таблиц без первичных ключей и уникальных индексов | [Логический дамп](#my-dump)                                                 |
  | База больше 1 ТБ | [Обратитесь в техническую поддержку]({{ link-console-support }})            |

{% list tabs group=db-migration %}

- {{ data-transfer-short-name }} {#my-recommended}
   
  Используйте для баз данных, не превышающих 1 ТБ. Тип трансфера — «Копирование», приемник нешардированный. Запись на источнике останавливается на время переноса.

  {% include [data-transfer](../_tutorials_includes/mdb-migration/data-transfer.md) %}

  Особенности применения {{ data-transfer-short-name }}:

  * Таблицы без первичных ключей и уникальных индексов не переносятся на этапе репликации.
  * Команда `ALTER` на этапе копирования прерывает трансфер.
  * Если источник находится за балансировщиком, включите GTID.
  * Транзакция с бинарным логом больше 4 ГБ приводит к ошибке активации.

  Подробности в [руководстве](../../managed-mysql/tutorials/data-migration/data-transfer.md).

- Логический дамп {#my-dump}

  Используйте [логический дамп](../../managed-mysql/tutorials/data-migration/logical-dump-migration.md) (`mysqldump` или `mydumper`), если простой допустим и база небольшая. Также, если нельзя включить `binlog_format = ROW` или база данных содержит много таблиц без первичных ключей и уникальных индексов.

{% endlist %}

## {{ MG }} {#mg}

  Приемник: [{{ mmg-short-name }}](../../storedoc/index.yaml). 
  Способы: [{{ data-transfer-short-name }}](#mg-recommended), [дамп](#mg-dump).

  | Особенности БД | Способ                                                                      |
  |-------------------------------------------------|-----------------------------------------------------------------------------|
  | Источник — набор реплик | **Рекомендуемый способ**: [{{ data-transfer-short-name }}](#mg-recommended) |
  | База до 100 ГБ, и простой допустим | [Дамп: `mongodump` и `mongorestore`](#mg-dump)                              |
  | Есть коллекции `Time Series` | [Дамп](#mg-dump)                                                            |
  | Большой объем, тысячи операций записи в секунду | [Несколько трансферов {{ data-transfer-short-name }}](#mg-recommended)      |


{% list tabs group=db-migration %}

- {{ data-transfer-short-name }} {#mg-recommended}
   
  Используйте для переноса {{ MG }} версии 3.6 и выше, источник — набор реплик. При тысячах операций записи в секунду перенос делят на несколько эндпоинтов и трансферов.

  {% include [data-transfer](../_tutorials_includes/mdb-migration/data-transfer.md) %}

  Особенности применения {{ data-transfer-short-name }}:

  * Коллекции `Time Series` трансфер не поддерживает — исключите их в эндпоинте-источнике.
  * При нагрузке выше 10 000 операций записи в секунду перенос делят на несколько эндпоинтов и трансферов.
  * Если копирование длится дольше окна `oplog`, трансфер завершится ошибкой — перед переносом увеличьте размер `oplog`.
  * Репликация прерывается на объектах размером более 16 МБ.

  Подробности в [руководстве](../../storedoc/tutorials/storedoc-migration-with-data-transfer.md).

- Дамп {#mg-dump}

  Используйте [дамп](../../storedoc/tutorials/data-migration.md) (`mongodump` и `mongorestore`), если размер БД не более 100 ГБ, простой допустим или есть коллекции `Time Series`. Возможен также перенос сторонним инструментом [Percona ClusterSync for {{ MG }}](https://docs.percona.com/percona-clustersync-for-mongodb/).

{% endlist %}

## {{ RD }} и {{ VLK }} {#rd-vlk}

  Приемник: [{{ mrd-short-name }}](../../managed-valkey/index.yaml). 
  Способ: [логический дамп](#vk-dump).

  | Особенности БД | Способ                                                           |
  | --- |------------------------------------------------------------------|
  | Данные нужно сохранить | [Логический дамп: `redis-dump-go` и `redis-cli`](#vk-dump)       |
  | В базе только кеш | Создайте кластер без переноса — кеш восстанавливается сам        |
  | Останавливать запись нельзя | [Обратитесь в техническую поддержку]({{ link-console-support }}) |

[Логический дамп](../../managed-valkey/tutorials/data-migration.md) — файл с набором команд, последовательное выполнение которых восстанавливает состояние баз данных в кластере. {#vk-dump}

Для переноса с помощью логического дампа:

  1. Создайте кластер-приемник.
  1. Остановите запись и снимите дамп на хосте-мастере источника.
  1. Подготовьте промежуточную виртуальную машину, если к кластеру нет доступа из интернета.
  1. Загрузите дамп в кластер-приемник.
  1. Сверьте число ключей и переключите приложение.

Особенности применения логического дампа:

* Бинарный RDB-файл загрузить нельзя: доступа к файловой системе хостов нет.
* В шардированный кластер дамп загружается в мастер каждого шарда.

Подробности в [руководстве](../../managed-valkey/tutorials/data-migration.md).

## {{ GP }} {#gp}

  Приемник: [{{ mgp-short-name }}](../../managed-greenplum/index.yaml). 
  Способы: [{{ data-transfer-short-name }}](#gp-recommended), [загрузка из {{ objstorage-name }} через PXF](#gp-pxf).

  | Особенности БД | Способ                                                                      |
  |-----------------------------------------------------------|-----------------------------------------------------------------------------|
  | Данные не выгружены, запись на источнике можно остановить | **Рекомендуемый способ**: [{{ data-transfer-short-name }}](#gp-recommended) |
  | Данные уже выгружены файлами в {{ objstorage-name }} | [Загрузка через PXF](#gp-pxf)                                               |
  | Останавливать запись нельзя | [Обратитесь в техническую поддержку]({{ link-console-support }})            |


{% list tabs group=db-migration %}

- {{ data-transfer-short-name }} {#gp-recommended}
   
  Используйте для переноса {{ GP }} версии 6.28 и выше или {{ CB }} 2, если на источнике допускается остановка записи. Используйте трансфер типа «Копирование».

  {% include [data-transfer](../_tutorials_includes/mdb-migration/data-transfer.md) %}

  Особенности применения {{ data-transfer-short-name }}:

  * Данные материализованных представлений не переносятся.
  * При параллельном копировании переносятся только таблицы. Таблицы `DISTRIBUTED REPLICATED` не переносятся.
  * Число потоков копирования ограничено числом сегментов источника.

  Подробности в [руководстве](../../managed-greenplum/tutorials/data-migration.md).

- Загрузка через PXF {#gp-pxf}

  [Загрузка через PXF](../../managed-greenplum/operations/pxf/create-s3-source.md) — если данные уже выгружены в {{ objstorage-name }} файлами. С помощью внешних таблиц вы сможете загрузить наборы данных в кластер {{ mgp-name }}. Подробнее в описании [внешних таблиц](../../managed-greenplum/concepts/external-tables.md).

{% endlist %}

## {{ ES }} или {{ OS }} {#es-os}

  Приемник: [{{ mos-short-name }}](../../managed-opensearch/index.yaml). 
  Способы: [удаленная переиндексация](#os-recommended), [снапшоты через {{ objstorage-name }}](#os-snapshot), [{{ data-transfer-short-name }}](#os-recommended).

  | Особенности БД | Способ                                                                                  |
  |-----------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
  | Источник доступен из интернета, допустим минимальный простой | **Рекомендуемый способ**: [удаленная переиндексация](#os-recommended)                   |
  | Источник закрыт от интернета, но может писать в {{ objstorage-name }} | [Снапшоты через {{ objstorage-name }}](#os-snapshot); источник — {{ ES }} не новее 7.11 |
  | Остальные способы не подошли                                          | [{{ data-transfer-short-name }}](#os-dt), тип «Копирование», включается по запросу      |

{% list tabs group=db-migration %}

- Удаленная переиндексация {#os-recommended}
   
  Используйте удаленную [переиндексацию]({{ os.docs }}/opensearch/reindex-data/) (reindex data) для переноса существующих индексов, псевдонимов (aliases) или потоков данных. Этот способ подходит для всех кластеров {{ ES }} версии 7 и выше. Источник должен быть доступен из интернета.

- Снапшоты через {{ objstorage-name }} {#os-snapshot}

  Используйте [снапшоты через {{ objstorage-name }}](../../managed-opensearch/tutorials/migration-to-opensearch.md) — если источник закрыт от интернета, но может писать в {{ objstorage-name }}. Источник — {{ ES }} не новее 7.11, на всех хостах источника должен быть установлен плагин `repository-s3`. Чтобы мигрировать данные из кластера-источника {{ ES }} в кластер-приемник {{ mos-name }} с помощью снапшотов:

  1. [Создайте снапшот на кластере-источнике](../../managed-opensearch/tutorials/migration-to-opensearch.md#create-snapshot).
  1. [Восстановите снапшот в кластере-приемнике](../../managed-opensearch/tutorials/migration-to-opensearch.md#restore-snapshot).
  1. [Закончите миграцию](../../managed-opensearch/tutorials/migration-to-opensearch.md#finish-migration-snapshot).

- {{ data-transfer-short-name }} {#os-dt}

  Используйте [{{ data-transfer-short-name }}](../../data-transfer/tutorials/mes-to-mos.md) как запасной способ. Выберите тип трансфера «Копирование» — включается по запросу. В индексе по умолчанию должно быть не более 1000 полей. Если у документов нет первичных ключей, то при повторной передаче появятся дубли.

{% endlist %}

## Если ни один способ не подошел {#fallback}

Для миграции больших баз данных и таких баз, для которых не допустим простой, [обратитесь в техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

Подробнее о переносе баз данных с помощью {{ data-transfer-short-name }}:

  * [Доступные трансферы](../../data-transfer/transfer-matrix.md) и [квоты и лимиты {{ data-transfer-short-name }}](../../data-transfer/concepts/limits.md)
  * [Подготовка к трансферу](../../data-transfer/operations/prepare.md) и [создание и активация трансфера](../../data-transfer/operations/transfer.md)
  * [Решение проблем {{ data-transfer-short-name }}](../../data-transfer/troubleshooting/index.md)
