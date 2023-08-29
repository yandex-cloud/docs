# История изменений в {{ mmy-full-name }}

В разделе представлена история изменений сервиса {{ mmy-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## II квартал 2023 {#q2-2023}

* Доступны новые версии {{ MY }} [5.7.39](https://docs.percona.com/percona-server/5.7/release-notes/Percona-Server-5.7.39-42.html) и [8.0.30](https://docs.percona.com/percona-server/8.0/release-notes/8.0.30-22.upd.html).
* В версии {{ MY }} 5.7 добавлена возможность анализа запросов при помощи `query_response_time_stats`. Подробнее см. в [документации Percona](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html).
* Добавлены новые глобальные разрешения для пользователей `FLUSH_OPTIMIZER_COSTS` и `SHOW_ROUTINE`.

## IV квартал 2022 {#q4-2022}

* Состояние хоста на странице **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** в консоли управления теперь меняется на `READ-ONLY`, если хост недоступен для записи. {{ tag-con }}
* Добавлена возможность [переместить кластер](operations/update.md#move-cluster) в другой каталог с помощью {{ TF }}.
* Добавлены новые настройки СУБД:

  * `Backup retain period days`;
  * [Lock wait timeout](./concepts/settings-list.md#setting-lock-wait-timeout);
  * [Max prepared stmt count](./concepts/settings-list.md#setting-max-prepared-stmt-count);
  * [Optimizer search depth](./concepts/settings-list.md#setting-optimizer-search-depth);
  * [Optimizer switch](./concepts/settings-list.md#setting-optimizer-switch).

## III квартал 2022 {#q3-2022}

* Добавлены графики `Free space` на вкладке [мониторинга кластера](operations/monitoring.md#monitoring-cluster) и `Inode usage` на странице [мониторинга хостов](operations/monitoring.md#monitoring-hosts). {{ tag-con }}
* Добавлена настройка [Binlog transaction dependency tracking](concepts/settings-list.md#setting-binlog-transaction-dependency-tracking).

## II квартал 2022 {#q2-2022}

* В конфигурационных файлах {{ TF }} упразднены секции `database` и `user`, добавлены новые ресурсы `yandex_mdb_mysql_database` и `yandex_mdb_mysql_user`. {{ tag-tf }}
* Добавлена настройка [Innodb compression level](concepts/settings-list.md#setting-innodb-compression-level).
* Ускорен процесс восстановления реплики из резервной копии за счет использования инструмента WAL-G с последующей синхронизацией данных с мастера.
* Исправлено отображение длинных запросов на вкладке **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}**. {{ tag-con }}

## I квартал 2022 {#q1-2022}

* Добавлена возможность изменения настроек [Innodb strict mode](concepts/settings-list.md#setting-strict-mode), [Max digest length](concepts/settings-list.md#setting-max-digest-length) и [Max sp recursion depth](concepts/settings-list.md#setting-max-sp-recursion-depth).  {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}
* Добавлена секция диагностики производительности кластера {{ MY }} в {{ TF }}. {{ tag-tf }}
* Добавлено управление настройками сервиса диагностики производительности. {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}
* Доработан механизм переключения мастера: теперь переключение невозможно на значительно отставшую реплику или в случае отсутствия кворума. Максимальное отставание реплики задается настройкой [Mdb priority choice max lag](concepts/settings-list.md#setting-mdb-priority-choice-max-lag).
* Добавлена возможность задавать приоритет выбора мастер-хоста в случае смены мастера. {{ tag-con }} {{ tag-cli }}
