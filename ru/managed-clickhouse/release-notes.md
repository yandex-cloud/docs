# История изменений в {{ mch-full-name }}

В разделе представлена история изменений сервиса {{ mch-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## IV квартал 2022 {#q4-2022}

* Доступны новые версии {{ CH }} [22.10](https://clickhouse.com/docs/en/whats-new/changelog/2022/#-clickhouse-release-2210-2022-10-25) и [22.11](https://clickhouse.com/docs/en/whats-new/changelog/2022/#-clickhouse-release-2211-2022-11-17).
* Добавлена возможность создавать хосты {{ ZK }} с хранилищем на [нереплицируемых SSD-дисках](concepts/storage.md).
* Добавлена возможность настроить хосты {{ ZK }} при восстановлении кластера из резервной копии.
* Добавлена возможность настроить гибридное хранилище при восстановлении кластера из резервной копии. {{ tag-con }} {{ tag-api }}
* Добавлена возможность выполнения SQL-запросов из браузера с помощью [встроенного SQL-редактора](./operations/connect.md#inline-editor).
* На странице [мониторинга кластера](operations/monitoring.md#monitoring-cluster) добавлены графики **Data parts**, **Databases**, **Inode usage**, **Rows of MergeTree tables** и **Tables**.
* Графики **Failed insert queries per host**, **Failed queries per host** и **Failed select queries per host** теперь показывают процент неуспешных запросов, а не их количество.
* График **Max replication queue across tables** теперь показывает суммарную очередь репликации всех таблиц и называется **Replication queue**.
* Переименованы следующие графики:
    * **CPU** → **CPU usage**.
    * **Disk bytes** → **Disk read/write bytes**.
    * **Memory** → **Memory usage**.
    * **Read parts per host** → **Read rows per host**.

## III квартал 2022 {#q3-2022}

* В команде `{{ yc-mdb-ch }} cluster restore` следующие параметры сделаны опциональными:

    * `--name`;
    * `--description`;
    * `--host`;
    * `--user`.

    Если значения этих параметров не указаны, их значения будут взяты из исходного кластера. При этом хосты {{ CH }} и {{ ZK }} будут восстановлены с той же конфигурацией, что и в исходном кластере. Хосты {{ CH }} будут восстановлены только для тех шардов, чьи резервные копии указаны для восстановления.

* Добавлены настойки гибридного хранилища: `data_cache_enabled`, `data_cache_max_size` и `move_factor`.

## II квартал 2022 {#q2-2022}

* Доступна новая версия {{ CH }} 22.5 ([список изменений](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md#225)).
* Добавлена поддержка запроса `SYSTEM UNFREEZE`. Запрос полностью удаляет резервную копию кластера из облачного хранилища, включая данные таблиц, которые могут занимать место в хранилище после удаления. Подробнее см. на [GitHub](https://github.com/ClickHouse/ClickHouse/pull/36424).
* Сокращено время восстановления кластера из резервной копии.
* Исправлена ошибка, в результате которой при редактировании списка подключений к топикам {{ KF }} могли удаляться уже настроенные пароли доступа к топикам.
* Добавлена возможность выдавать пользователям права на системные таблицы (`_system`).
* Включена настройка [force_remove_data_recursively_on_drop](https://github.com/ClickHouse/ClickHouse/pull/30054) для предотвращения ошибок `Directory not empty` при удалении баз данных.

## I квартал 2022 {#q1-2022}

* Доступна новая версия {{ CH }} 22.3 LTS ([список изменений](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md)).
* Добавлена возможность восстановления шардированного кластера из резервной копии целиком. {{ tag-cli }} {{ tag-api }}
* Добавлена возможность изменения настройки публичного доступа для хоста. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
