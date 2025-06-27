---
title: История изменений в {{ mmy-full-name }}
description: В разделе представлена история изменений сервиса {{ mmy-name }}.
---

# История изменений в {{ mmy-full-name }}

## Апрель 2025 {#apr-2025}

Добавлена [интеграция с {{ connection-manager-name }}](operations/update.md#conn-man). Подключение в {{ connection-manager-name }} теперь создается для всех новых кластеров автоматически.

## Октябрь 2024 {#oct-2024}

Добавлена возможность [задавать срок хранения автоматических резервных копий](operations/cluster-backups.md#set-backup-retain).


## Сентябрь 2024 {#sep-2024}

В настройках кластера стала доступна опция **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** — она разрешает выполнять YQL-запросы из сервиса [{{ yq-full-name }}](../query/concepts/index.md) к базе данных {{ mgp-name }}.


## Май 2024 {#may-2024}

* Доступны новые версии {{ MY }} [5.7.44](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/news-5-7-44.html) и [8.0.35](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-35.html).

## IV квартал 2023 {#q4-2023}

* Доступна новая версия {{ MY }} [8.0.31](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-31.html).

## II квартал 2023 {#q2-2023}

* Доступны новые версии {{ MY }} [5.7.39](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/news-5-7-39.html) и [8.0.30](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-30.html).
* В версии {{ MY }} 5.7 добавлена возможность анализа запросов при помощи `query_response_time_stats`. Подробнее см. в [документации Percona](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html).
* Добавлены новые глобальные разрешения для пользователей `FLUSH_OPTIMIZER_COSTS` и `SHOW_ROUTINE`.

## IV квартал 2022 {#q4-2022}

* Состояние хоста на странице **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** в консоли управления теперь меняется на `READ-ONLY`, если хост недоступен для записи.
* Добавлена возможность [переместить кластер](operations/update.md#move-cluster) в другой каталог с помощью {{ TF }}.
* Добавлены новые настройки СУБД:

  * `Backup retain period days`;
  * [Lock wait timeout](./concepts/settings-list.md#setting-lock-wait-timeout);
  * [Max prepared stmt count](./concepts/settings-list.md#setting-max-prepared-stmt-count);
  * [Optimizer search depth](./concepts/settings-list.md#setting-optimizer-search-depth);
  * [Optimizer switch](./concepts/settings-list.md#setting-optimizer-switch).

## III квартал 2022 {#q3-2022}

* Добавлены графики `Free space` на вкладке [мониторинга кластера](operations/monitoring.md#monitoring-cluster) и `Inode usage` на странице [мониторинга хостов](operations/monitoring.md#monitoring-hosts).
* Добавлена настройка [Binlog transaction dependency tracking](concepts/settings-list.md#setting-binlog-transaction-dependency-tracking).

## II квартал 2022 {#q2-2022}

* В конфигурационных файлах {{ TF }} упразднены секции `database` и `user`, добавлены новые ресурсы `yandex_mdb_mysql_database` и `yandex_mdb_mysql_user`.
* Добавлена настройка [Innodb compression level](concepts/settings-list.md#setting-innodb-compression-level).
* Ускорен процесс восстановления реплики из резервной копии за счет использования инструмента WAL-G с последующей синхронизацией данных с мастера.
* Исправлено отображение длинных запросов на вкладке **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}**.

## I квартал 2022 {#q1-2022}

* Добавлена возможность изменения настроек [Innodb strict mode](concepts/settings-list.md#setting-strict-mode), [Max digest length](concepts/settings-list.md#setting-max-digest-length) и [Max sp recursion depth](concepts/settings-list.md#setting-max-sp-recursion-depth).
* Добавлена секция диагностики производительности кластера {{ MY }} в {{ TF }}.
* Добавлено управление настройками сервиса диагностики производительности.
* Доработан механизм переключения мастера: теперь переключение невозможно на значительно отставшую реплику или в случае отсутствия кворума. Максимальное отставание реплики задается настройкой [Mdb priority choice max lag](concepts/settings-list.md#setting-mdb-priority-choice-max-lag).
* Добавлена возможность задавать приоритет выбора мастер-хоста в случае смены мастера.
