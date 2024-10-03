---
title: История изменений в {{ mch-full-name }}
description: В разделе представлена история изменений сервиса {{ mch-name }}.
---

# История изменений в {{ mch-full-name }}

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## Июль 2024 {#jule-2024}

* Доступна новая версия {{ CH }} [24.6](https://clickhouse.com/docs/en/whats-new/changelog#-clickhouse-release-246-2024-07-01).
* Добавлена возможность автоматического преобразования нереплицируемых таблиц в [реплицируемые](./concepts/replication.md#replicated-tables) при добавлении [{{ ZK }}-хостов](./operations/zk-hosts.md). Функциональность значительно упрощает процесс перехода к отказоустойчивой конфигурации для однохостовых кластеров.
* Добавлена возможность ручного удаления [резервных копий](./concepts/backup.md).

## Июнь 2024 {#june-2024}

Доступна новая версия {{ CH }} [24.5](https://clickhouse.com/docs/en/whats-new/changelog#-clickhouse-release-245-2024-05-30).

## Май 2024 {#may-2024}

Доступна новая версия {{ CH }} [24.4](https://clickhouse.com/docs/en/whats-new/changelog#-clickhouse-release-244-2024-04-30).

## Апрель 2024 {#apr-2024}

Доступна новая версия {{ CH }} [24.3 LTS](https://clickhouse.com/docs/en/whats-new/changelog#-clickhouse-release-243-lts-2024-03-27).

## Март 2024 {#mar-2024}

* Доступна новая версия {{ CH }} [24.2](https://clickhouse.com/docs/en/whats-new/changelog#-clickhouse-release-242-2024-02-29).
* Добавлена возможность создавать или удалять несколько хостов в рамках одной операции. Это поможет ускорить процесс добавления или удаления большого количества хостов в кластере.
* [Лимит](./concepts/limits.md#mch-limits) на размер сетевых дисков `network-ssd-nonreplicated` увеличен в 2 раза — с 8 до 16 ТБ. Это позволит расширять кластер без добавления дополнительных шардов.

## Февраль 2024 {#feb-2024}

* Доступны новые версии {{ CH }} [23.9](https://clickhouse.com/docs/en/whats-new/changelog/2023#239), [23.10](https://clickhouse.com/docs/en/whats-new/changelog/2023#2310), [23.11](https://clickhouse.com/docs/en/whats-new/changelog/2023#2311), [23.12](https://clickhouse.com/docs/en/whats-new/changelog/2023#2312) и [24.1](https://clickhouse.com/docs/en/whats-new/changelog#-clickhouse-release-241-2024-01-30).
* Добавлена возможность [перезапускать хосты](./operations/hosts.md#restart) кластера. В большинстве случаев пользователям не нужно перезапускать хосты — это инструмент экстренного устранения проблем, связанных с утечками памяти или зависанием внутренних процессов СУБД.

## II квартал 2023 {#q2-2023}

Доступны новые версии {{ CH }} [23.4](https://clickhouse.com/docs/en/whats-new/changelog#-clickhouse-release-234-2023-04-26) и [23.5](https://clickhouse.com/docs/en/whats-new/changelog#-clickhouse-release-235-2023-06-08).

## I квартал 2023 {#q1-2023}

Доступна новая версия {{ CH }} [23.3](https://clickhouse.com/docs/en/whats-new/changelog#-clickhouse-release-233-lts-2023-03-30).

## IV квартал 2022 {#q4-2022}

* Доступны новые версии {{ CH }} [22.10](https://clickhouse.com/docs/en/whats-new/changelog/2022/#-clickhouse-release-2210-2022-10-25) и [22.11](https://clickhouse.com/docs/en/whats-new/changelog/2022/#-clickhouse-release-2211-2022-11-17).
* Добавлена возможность создавать хосты {{ ZK }} с хранилищем на [нереплицируемых SSD-дисках](concepts/storage.md).
* Добавлена возможность настроить хосты {{ ZK }} при восстановлении кластера из резервной копии.
* Добавлена возможность настроить гибридное хранилище при восстановлении кластера из резервной копии. {{ tag-con }} {{ tag-api }}
* Добавлена возможность выполнения SQL-запросов из браузера с помощью [встроенного SQL-редактора](./operations/connect/clients.md#inline-editor).
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

* Доступна новая версия {{ CH }} 22.5 ([список изменений](https://clickhouse.com/docs/en/whats-new/changelog/2022/#-clickhouse-release-225-2022-05-19)).
* Добавлена поддержка запроса `SYSTEM UNFREEZE`. Запрос полностью удаляет резервную копию кластера из облачного хранилища, включая данные таблиц, которые могут занимать место в хранилище после удаления. Подробнее см. на [GitHub](https://github.com/ClickHouse/ClickHouse/pull/36424).
* Сокращено время восстановления кластера из резервной копии.
* Исправлена ошибка, в результате которой при редактировании списка подключений к топикам {{ KF }} могли удаляться уже настроенные пароли доступа к топикам.
* Добавлена возможность выдавать пользователям права на системные таблицы (`_system`).
* Включена настройка [force_remove_data_recursively_on_drop](https://github.com/ClickHouse/ClickHouse/pull/30054) для предотвращения ошибок `Directory not empty` при удалении баз данных.

## I квартал 2022 {#q1-2022}

* Доступна новая версия {{ CH }} 22.3 LTS ([список изменений](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md)).
* Добавлена возможность восстановления шардированного кластера из резервной копии целиком. {{ tag-cli }} {{ tag-api }}
* Добавлена возможность изменения настройки публичного доступа для хоста. {{ tag-con }} {{ tag-cli }} {{ tag-api }}

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
