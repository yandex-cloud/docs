# История изменений в {{ mpg-full-name }}

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.07.2022 {#01.07.2022}

* Добавлена роль `mdb_monitor`, которая включает в себя привилегии системной роли [pg_monitor](https://www.postgresql.org/docs/10/default-roles.html). Подробнее см. в разделе [Назначение ролей {{ PG }}](concepts/roles.md#mdb-monitor).
* В конфигурационных файлах {{ TF }} упразднены секции `database` и `user`, добавлены новые ресурсы `yandex_mdb_postgresql_database` и `yandex_mdb_postgresql_user`. {{ tag-tf }}
* Добавлена возможность обновления с версии 13 на 14.
* Доступно создание кластера версии 13 и 14 для 1С. {{ tag-con }}
* Доступна версия [Odyssey 1.3](https://www.postgresql.org/about/news/odyssey-13-released-2476/).

## 01.06.2022 {#01.06.2022}

* Установлены [обновления](https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/) из версий 14.3, 13.7, 12.11, 11.16 и 10.21.

## 01.05.2022 {#01.05.2022}

* Добавлены настройки `max_logical_replication_workers` и `max_replication_slots`.

## 01.04.2022 {#01.04.2022}

* Добавлены [расширения {{ PG }}](operations/cluster-extensions#postgresql) `pgcompacttable`, `clickhouse_fdw` и `orafce`. 
* Добавлена возможность создания новой базы данных из шаблона. {{ tag-con }}
