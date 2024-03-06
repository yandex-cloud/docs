# История изменений в {{ mpg-full-name }}

В разделе представлена история изменений сервиса {{ mpg-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## II квартал 2023 {#q2-2023}

* Добавлена возможность экспортировать сырые данные диагностики производительности с помощью методов API [ListRawSessionStates](api-ref/grpc/perf_diag_service.md#ListRawSessionStates) и [ListRawStatements](api-ref/grpc/perf_diag_service.md#ListRawStatements).
* Добавлена настройка `Session duration timeout`, регулирующая время жизни самой длинной активной сессии или транзакции. Значение по умолчанию — 12 часов.

## IV квартал 2022 {#q4-2022}

* Добавлена поддержка {{ PG }} версии 15.

    Основные изменения в новой версии:

    * Добавлена команда `SQL MERGE`, которая позволяет выполнить действия `INSERT`, `UPDATE` или `DELETE` в зависимости от условий.
    * Добавлена возможность задавать списки столбцов и условия для фильтрации строк. Это позволяет выборочно публиковать содержимое таблиц с логической репликацией.
    * Добавлена возможность указать [ICU]({{ pg.docs.org }}/15/locale.html#id-1.6.11.3.7) для базы данных по умолчанию.
    * Увеличена производительность, особенно для сортировок в памяти и на диске.

    О том, как обновить кластер, см. в разделе [{#T}](operations/cluster-version-update.md).

    Подробнее об изменениях {{ PG }} версии 15 см. в [документации {{ PG }}]({{ pg.docs.org }}/release/15.0/).

* Добавлена поддержка расширений [pgaudit](https://www.pgaudit.org/) и [pg_prewarm]({{ pg-docs }}/pgprewarm.html).
* Добавлена возможность восстановить кластер из резервной копии в другом каталоге с помощью любого интерфейса.

## III квартал 2022 {#q3-2022}

* На вкладке [мониторинга кластера](operations/monitoring.md#monitoring-cluster) добавлены графики `Inode usage`, `Memory usage` и `Free space`. {{ tag-con }}
* [Прекращена](https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/) поддержка {{ PG }} версии 10. С 15 августа недоступно создание новых кластеров этой версии, а с 1 сентября запланировано автоматическое обновление кластеров в рамках окна обслуживания. О том, как обновить кластер самостоятельно, см. в разделе [{#T}](operations/cluster-version-update.md).
* Создание базы из шаблона теперь доступно в CLI и {{ TF }}. {{ tag-cli }} {{ tag-tf }}
* Добавлена поддержка [расширения](operations/extensions/pg_cron.md) `pg_cron`.
* Установлено [обновление версии 14.4]({{ pg.docs.org }}/release/14.4/), где исправлены проблемы с коррупцией индексов.

## II квартал 2022 {#q2-2022}

* Установлены [обновления](https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/) из версий 14.3, 13.7, 12.11, 11.16 и 10.21.
* Доступно создание кластера версии 13 и 14 для 1С. {{ tag-con }}
* Добавлена возможность обновления с версии 13 на 14.
* Добавлена роль `mdb_monitor`, которая включает в себя привилегии системной роли [pg_monitor](https://www.postgresql.org/docs/10/default-roles.html). Подробнее см. в разделе [Назначение ролей](concepts/roles.md#mdb-monitor).
* В конфигурационных файлах {{ TF }} упразднены секции `database` и `user`, добавлены новые ресурсы `yandex_mdb_postgresql_database` и `yandex_mdb_postgresql_user`. {{ tag-tf }}
* Доступна версия [Odyssey 1.3](https://www.postgresql.org/about/news/odyssey-13-released-2476/): поддержка подготовленных выражений (prepared statements) в режиме пулинга транзакций. С помощью настройки `pool_reserve_prepared_statement` можно активировать пул подготовленных выражений для базы данных, в котором Odyssey подготовит выражения для сессий в случае необходимости.
* Добавлены настройки `max_logical_replication_workers` и `max_replication_slots`.

## I квартал 2022 {#q1-2022}

* Добавлены [расширения](operations/extensions/cluster-extensions.md) `pgcompacttable`, `clickhouse_fdw` и `orafce`. 
* Добавлена возможность создания новой базы данных из шаблона. {{ tag-con }}
