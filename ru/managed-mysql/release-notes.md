# История изменений в {{ mmy-full-name }}

В разделе представлена история изменений сервиса {{ mmy-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## IV квартал 2022 {#q4-2022}

* Состояние хоста на странице **Хосты** в консоли управления теперь меняется на `READ-ONLY`, если хост недоступен для записи. {{ tag-con }}
* Добавлена возможность [переместить кластер](operations/update.md#move-cluster) в другой каталог с помощью {{ TF }}.
* Добавлены настройки `Backup retain period days`, `Lock wait timeout`, `Max prepared stmt count`, `Optimizer search depth` и `Optimizer switch`.

## III квартал 2022 {#q3-2022}

* Добавлены графики `Free space` на вкладке [мониторинга кластера](operations/monitoring.md#monitoring-cluster) и `Inode usage` на странице [мониторинга хостов](operations/monitoring.md#monitoring-hosts). {{ tag-con }}
* Добавлена настройка [Binlog transaction dependency tracking](concepts/settings-list.md#setting-binlog-transaction-dependency-tracking).

## II квартал 2022 {#q2-2022}

* В конфигурационных файлах {{ TF }} упразднены секции `database` и `user`, добавлены новые ресурсы `yandex_mdb_mysql_database` и `yandex_mdb_mysql_user`. {{ tag-tf }}
* Добавлена настройка [Innodb compression level](concepts/settings-list.md#setting-innodb-compression-level).
* Ускорен процесс восстановления реплики из резервной копии за счет использования инструмента WAL-G с последующей синхронизацией данных с мастера.
* Исправлено отображение длинных запросов на вкладке **Диагностика производительности**. {{ tag-con }}

## I квартал 2022 {#q1-2022}

* Добавлена возможность изменения настроек [Innodb strict mode](concepts/settings-list.md#setting-strict-mode), [Max digest length](concepts/settings-list.md#setting-max-digest-length) и [Max sp recursion depth](concepts/settings-list.md#setting-max-sp-recursion-depth).  {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}
* Добавлена секция диагностики производительности кластера {{ MY }} в {{ TF }}. {{ tag-tf }}
* Добавлено управление настройками сервиса диагностики производительности. {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}
* Доработан механизм переключения мастера: теперь переключение невозможно на значительно отставшую реплику или в случае отсутствия кворума. Максимальное отставание реплики задается настройкой [Mdb priority choice max lag](concepts/settings-list.md#setting-mdb-priority-choice-max-lag).
* Добавлена возможность задавать приоритет выбора мастер-хоста в случае смены мастера. {{ tag-con }} {{ tag-cli }}
