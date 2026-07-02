[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for MySQL®](index.md) > История изменений

# История изменений в Yandex Managed Service for MySQL®

## Май 2026 {#may-2026}

* Добавлена возможность [создавать и восстанавливать](operations/cluster-backups.md) из резервной копии кластеры с шифрованными локальными дисками. Шифрование осуществляется пользовательским KMS-ключом.
* Максимальный размер локальных дисков на одном хосте увеличен до 36 ТБ. Диски такого размера доступны для конфигураций с 16 и более ядрами на платформе Intel Ice Lake (`standard-v3`). Для создания кластеров особо большого размера может потребоваться обращение в [техническую поддержку](https://center.yandex.cloud/support) для резервирования необходимых ресурсов.
* Опубликованы обновленные [политики поддержки версий](concepts/update-policy.md), в которых подробнее описаны сроки и условия поддержки разных версий СУБД.
* Добавлена настройка **Innodb adaptive hash index**, которая задает количество секций [адаптивного хеш-индекса](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_adaptive_hash_index) InnoDB. Разбиение на секции снижает конкуренцию между потоками и повышает производительность в системах с высоким уровнем параллелизма. Подробнее в разделе [Настройки MySQL®](concepts/settings-list.md).
* Добавлена настройка **Max write lock count**, которая задает максимальное количество последовательных блокировок записи, после которого сервер начинает обрабатывать ожидающие запросы на блокировку чтения. Подробнее в разделе [Настройки MySQL®](concepts/settings-list.md).

## Апрель 2026 {#apr-2026}

* Пользователи с [ролью](security/index.md#mdb-admin) `mdb.admin` теперь могут [просматривать список](operations/cluster-users.md##list-users) созданных ими пользователей с помощью представлений `mysql.v_user`, `mysql.v_db` и `mysql.v_procs_priv`.
* Добавлена защита от случайного удаления базы данных по аналогии с защитой кластера.
* После операции [технического обслуживания](concepts/maintenance.md) мастер автоматически возвращается на приоритетный хост. Переключение выполняется при отставании репликации менее чем на 10 секунд; при необходимости система ожидает до 30 минут.

## Март 2026 {#mar-2026}

* Добавлены отдельные [роли](security/index.md) для просмотра и редактирования (переноса) [технического обслуживания](concepts/maintenance.md) без доступа к кластеру.

## Февраль 2026 {#feb-2026}

* Доступны новые минорные версии MySQL® [8.4.7](https://docs.percona.com/percona-server/8.4/release-notes/8.4.7-7.html), [8.0.43](https://docs.percona.com/percona-server/8.0/release-notes/8.0.43-34.html) и [5.7.44-54](https://docs.percona.com/percona-server/5.7/release-notes/5.7.44-54.html). Запланированы обновления кластеров.

## Декабрь 2025 {#dec-2025}

* Добавлены [детальные метрики](operations/monitoring.md#hosts) использования дисков в хостах кластера.
* Добавлена детализация выполнения [операций над кластером](operations/cluster-list.md#list-operations).

## Ноябрь 2025 {#nov-2025}

Добавлена роль `managed-mysql.restorer`, позволяющая восстанавливать кластеры из резервных копий. Подробнее в разделе [Управление доступом](security/index.md#managed-mysql-restorer).

## Октябрь 2025 {#oct-2025}

* Увеличен размер бинарных логов на кластерах с большим объемом дисков, что позволяет ускорить восстановление больших кластеров при сбоях.
* Добавлены новые [классы хостов](concepts/instance-types.md) на платформах AMD Zen 4 и AMD Zen 4 HighFreq.

## Сентябрь 2025 {#sep-2025}

* Доступна новая мажорная версия MySQL® [8.4.6](https://docs.percona.com/percona-server/8.4/release-notes/8.4.6-6.html). Апгрейд пока недоступен, будет поддержан позже.
* Доступны новые минорные версии MySQL® [5.7.44-53](https://docs.percona.com/percona-server/5.7/release-notes/5.7.44-53.html) и [8.0.41](https://docs.percona.com/percona-server/8.0/release-notes/8.0.41-32.html).
* Добавлена возможность настроить пошаговое [автоматическое увеличение размера хранилища](concepts/storage.md#disk-size-autoscaling) в кластере. Пользователь может задать порог заполненности дискового хранилища и максимальное значение размера диска. При достижении порога диск будет автоматически увеличиваться фиксированными шагами до максимального значения.
* Добавлена новая [административная привилегия](concepts/settings-list.md#setting-administrative-privileges) `mdb_admin`.


## Июль 2025 {#jul-2025}

Добавлена возможность [шифрования дисков хранилища](concepts/storage.md#disk-encryption) пользовательским ключом KMS при создании кластера и восстановлении его из резервной копии.


## Апрель 2025 {#apr-2025}

Добавлена [интеграция с Connection Manager](operations/update.md#conn-man). Подключение в Connection Manager теперь создается для всех новых кластеров автоматически.

## Октябрь 2024 {#oct-2024}

Добавлена возможность [задавать срок хранения автоматических резервных копий](operations/cluster-backups.md#set-backup-retain).


## Сентябрь 2024 {#sep-2024}

В настройках кластера стала доступна опция **Доступ из Yandex Query** — она разрешает выполнять YQL-запросы из сервиса [Yandex Query](../query/concepts/index.md) к базе данных Yandex MPP Analytics for PostgreSQL.


## Май 2024 {#may-2024}

* Доступны новые версии MySQL® [5.7.44](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/news-5-7-44.html) и [8.0.35](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-35.html).

## IV квартал 2023 {#q4-2023}

* Доступна новая версия MySQL® [8.0.31](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-31.html).

## II квартал 2023 {#q2-2023}

* Доступны новые версии MySQL® [5.7.39](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/news-5-7-39.html) и [8.0.30](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-30.html).
* В версии MySQL® 5.7 добавлена возможность анализа запросов при помощи `query_response_time_stats`. Подробнее в [документации Percona](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html).
* Добавлены новые глобальные разрешения для пользователей `FLUSH_OPTIMIZER_COSTS` и `SHOW_ROUTINE`.

## IV квартал 2022 {#q4-2022}

* Состояние хоста на странице **Хосты** в консоли управления теперь меняется на `READ-ONLY`, если хост недоступен для записи.
* Добавлена возможность [переместить кластер](operations/update.md#move-cluster) в другой каталог с помощью Terraform.
* Добавлены новые настройки СУБД:

  * `Backup retain period days`;
  * [Lock wait timeout](concepts/settings-list.md#setting-lock-wait-timeout);
  * [Max prepared stmt count](concepts/settings-list.md#setting-max-prepared-stmt-count);
  * [Optimizer search depth](concepts/settings-list.md#setting-optimizer-search-depth);
  * [Optimizer switch](concepts/settings-list.md#setting-optimizer-switch).

## III квартал 2022 {#q3-2022}

* Добавлены графики `Free space` на вкладке [мониторинга кластера](operations/monitoring.md#monitoring-cluster) и `Inode usage` на странице [мониторинга хостов](operations/monitoring.md#monitoring-hosts).
* Добавлена настройка [Binlog transaction dependency tracking](concepts/settings-list.md#setting-binlog-transaction-dependency-tracking).

## II квартал 2022 {#q2-2022}

* В конфигурационных файлах Terraform упразднены секции `database` и `user`, добавлены новые ресурсы `yandex_mdb_mysql_database` и `yandex_mdb_mysql_user`.
* Добавлена настройка [Innodb compression level](concepts/settings-list.md#setting-innodb-compression-level).
* Ускорен процесс восстановления реплики из резервной копии за счет использования инструмента WAL-G с последующей синхронизацией данных с мастера.
* Исправлено отображение длинных запросов на вкладке **Диагностика производительности**.

## I квартал 2022 {#q1-2022}

* Добавлена возможность изменения настроек [Innodb strict mode](concepts/settings-list.md#setting-strict-mode), [Max digest length](concepts/settings-list.md#setting-max-digest-length) и [Max sp recursion depth](concepts/settings-list.md#setting-max-sp-recursion-depth).
* Добавлена секция диагностики производительности кластера MySQL® в Terraform.
* Добавлено управление настройками сервиса диагностики производительности.
* Доработан механизм переключения мастера: теперь переключение невозможно на значительно отставшую реплику или в случае отсутствия кворума. Максимальное отставание реплики задается настройкой [Mdb priority choice max lag](concepts/settings-list.md#setting-mdb-priority-choice-max-lag).
* Добавлена возможность задавать приоритет выбора мастер-хоста в случае смены мастера.