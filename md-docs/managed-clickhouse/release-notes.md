<!-- Changelog begin -->

{% changelog %}
```
date: 2025-11
index: 1
```

### ClickHouse Keeper

![image](../_assets/managed-clickhouse/changelogs/clickhouse-keeper.png)

Встречайте ClickHouse® Keeper! Он поможет координировать и распределять запросы между хостами ваших кластеров ClickHouse®. Клиент-серверный протокол ClickHouse® Keeper совместим с ZooKeeper, поэтому для взаимодействия с ним можно использовать любой стандартный клиент ZooKeeper.

{% endchangelog %}

<!-- Changelog end -->


# История изменений в Yandex Managed Service for ClickHouse®

## Май 2026 {#may-2026}

* Добавлена возможность [создавать и восстанавливать](operations/cluster-backups.md) из резервной копии кластеры с шифрованными локальными дисками. Шифрование осуществляется пользовательским KMS-ключом.
* Максимальный размер локальных дисков на одном хосте увеличен до 36 ТБ. Диски такого размера доступны для конфигураций с 16 и более ядрами на платформе Intel Ice Lake (`standard-v3`). Для создания кластеров особо большого размера может потребоваться обращение в [техническую поддержку](https://center.yandex.cloud/support) для резервирования необходимых ресурсов.
* Добавлена возможность включения [диагностики производительности](operations/performance-diagnostics.md) в версии Terraform 0.202.0 и в версии CLI 1.8.0. <code><b><small>Terraform</small></b></code> <code><b><small>CLI</small></b></code>
* Добавлена возможность [восстанавливать кластер](operations/cluster-backups.md) с помощью Terraform. <code><b><small>Terraform</small></b></code>
* Добавлена поддержка привилегии `SET DEFINER`. Для кластеров с управлением пользователями через SQL пользователю `admin` выдается привилегия `SET DEFINER` для всех пользователей. Для кластеров с управлением через API каждому пользователю выдается привилегия `SET DEFINER` только для самого себя.
* Максимальная длина имени пользователя увеличена до 64 символов.
* Добавлена возможность использования пользовательских CA (Certificate Authority).
* Доступны новые версии ClickHouse®: [26.3 LTS](https://clickhouse.com/blog/clickhouse-release-26-03) и [26.4](https://clickhouse.com/blog/clickhouse-release-26-04).

## Апрель 2026 {#apr-2026}

* В конфигурацию кластера добавлен объект `performance_diagnostics` для настройки сбора диагностических данных.
* Исправлено критическое несоответствие в перечислении [классов хостов](concepts/instance-types.md).

## Март 2026 {#mar-2026}

* Добавлена возможность использования самоподписанных сертификатов. Для включения функции обратитесь в техническую поддержку.
* При создании [резервной копии](concepts/backup.md) через консоль управления теперь требуется дополнительное подтверждение во всплывающем окне.
* Добавлена возможность изменения [типа диска](concepts/storage.md#storage-type-selection). Данные сохраняются для реплицируемых таблиц и для кластеров, конфигурация которых соответствует [Соглашению об уровне обслуживания (SLA)](https://yandex.ru/legal/cloud_sla_mdb/). При изменении типа диска в YC CLI добавлен предупреждающий флаг `allow host recreation`, а в консоли управления теперь выводится предупреждающий дашборд со списком нереплицированных таблиц.
* Добавлено частичное восстановление баз данных или отдельных таблиц из резервной копии в новый кластер. Функциональность позволяет быстро восстановить только необходимые данные.
* Добавлены отдельные [роли](security.md) для просмотра и редактирования (переноса) [технического обслуживания](concepts/maintenance.md) без доступа к кластеру.

## Февраль 2026 {#feb-2026}

* Добавлен инструмент **Диагностика производительности** для анализа производительности кластера через GUI в реальном времени. Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md). Для участия в тестировании обратитесь в [техническую поддержку](https://center.yandex.cloud/support).
* Добавлена возможность включить `mysql_protocol` через Terraform. <code><b><small>Terraform</small></b></code>
* Доступна новая версия ClickHouse® 26.1. Добавлена поддержка операций `DELETE` для Delta Lake.
* В консоли управления теперь отображается полная версия СУБД, что позволяет отслеживать минорные обновления. <code><b><small>Консоль управления</small></b></code>

## Январь 2026 {#jan-2026}

* Максимальное количество [шардов](concepts/sharding.md) в кластере увеличено до 100. Это позволяет более гибко масштабировать кластер горизонтально.
* Доступна новая версия ClickHouse® [25.12](https://clickhouse.com/blog/clickhouse-release-25-12). В ней, например, стали быстрее алгоритмы `INNER JOIN`.
* На странице кластеров в списке всех резервных копий теперь отображается идентификатор кластера-источника. Это позволяет быстрее узнать происхождение резервной копии.

## Декабрь 2025 {#dec-2025}

* Добавлены [детальные метрики](operations/monitoring.md#hosts) использования дисков в хостах кластера.
* Улучшена реализация методов `stats` и `Persistent Watches` в [ClickHouse® Keeper](concepts/replication.md#ck) для поддержки протокола совместимого с ZooKeeper.
* Оптимизирован механизм восстановления [реплик](concepts/replication.md). Процесс восстановления больших (от 2 ТБ и более) нереплицируемых дисков стал быстрее.
* Сервис координации ClickHouse® Keeper при использовании на отдельных хостах [тарифицируется](pricing.md#prices-keeper). Он работает быстрее ZooKeeper и использует алгоритм консенсуса [Raft](https://ru.wikipedia.org/wiki/Raft_(алгоритм)). Такая конфигурация рекомендуется для production-среды.
* Доступна новая версия ClickHouse® [25.11](https://clickhouse.com/blog/clickhouse-release-25-11).

## Ноябрь 2025 {#nov-2025}

* Сервис координации ClickHouse® Keeper теперь доступен всем пользователям Managed Service for ClickHouse® и используется по умолчанию в новых кластерах. Также добавлена возможность создавать в кластере отдельные хосты с ClickHouse® Keeper. Подробнее о ClickHouse® Keeper в разделе [Репликация](concepts/replication.md#ck).
* Добавлена роль `managed-clickhouse.restorer`, позволяющая восстанавливать кластеры из резервных копий. Подробнее в разделе [Управление доступом](security.md#managed-clickhouse-restorer).
* Удалена настройка СУБД **Kafka topics**, позволявшая задавать параметры аутентификации на уровне топиков для [интеграции с Apache Kafka®](https://clickhouse.com/docs/ru/engines/table-engines/integrations/kafka).
* Доступны новые версии ClickHouse®: [25.8](https://clickhouse.com/blog/clickhouse-release-25-08), [25.9](https://clickhouse.com/blog/clickhouse-release-25-09) и [25.10](https://clickhouse.com/blog/clickhouse-release-25-10).

## Октябрь 2025 {#oct-2025}

Добавлены новые [классы хостов](concepts/instance-types.md) на платформах AMD Zen 4 и AMD Zen 4 HighFreq.

## Июль 2025 {#jul-2025}

* Доступны новые версии ClickHouse®: [25.3](https://clickhouse.com/blog/clickhouse-release-25-03), [25.4](https://clickhouse.com/blog/clickhouse-release-25-04), [25.5](https://clickhouse.com/blog/clickhouse-release-25-05) и [25.6](https://clickhouse.com/blog/clickhouse-release-25-06).
* Процесс создания резервных копий теперь проходит до 6 раз быстрее.
* Добавлена поддержка управления расширениями с помощью [Yandex Cloud CLI](../cli/quickstart.md) и API.


## Июль 2025 {#jul-2025}

Добавлена возможность [шифрования дисков хранилища](concepts/storage.md#disk-encryption) пользовательским ключом KMS при создании кластера и восстановлении его из резервной копии.


## Апрель 2025 {#apr-2025}

Добавлена [интеграция с Connection Manager](operations/update.md#conn-man). Подключение в Connection Manager теперь автоматически создается для всех новых кластеров.

## Март 2025 {#mar-2025}

Доступна новая версия ClickHouse® [25.2](https://clickhouse.com/blog/clickhouse-release-25-02).

## Февраль 2025 {#feb-2025}

* Доступна новая версия ClickHouse® [25.1](https://clickhouse.com/blog/clickhouse-release-25-01).
* Появилась возможность [восстанавливать из резервной копии](operations/cluster-backups.md#restore) кластер с включенным шардированием.

## Январь 2025 {#jan-2025}

Доступна новая версия ClickHouse® [24.12](https://clickhouse.com/blog/clickhouse-release-24-12).

## Ноябрь 2024 {#nov-2024}

Доступна новая версия ClickHouse® [24.10](https://clickhouse.com/blog/clickhouse-release-24-10).

## Октябрь 2024 {#oct-2024}

* Доступна новая версия ClickHouse® [24.9](https://clickhouse.com/blog/clickhouse-release-24-09).
* Добавлена возможность [задавать срок хранения автоматических резервных копий](operations/cluster-backups.md#set-backup-retain).

## Сентябрь 2024 {#sep-2024}

Доступна новая версия ClickHouse® [24.8 LTS](https://clickhouse.com/blog/clickhouse-release-24-08).

## Июль 2024 {#jul-2024}

* Доступна новая версия ClickHouse® [24.6](https://clickhouse.com/docs/ru/whats-new/changelog#-clickhouse-release-246-2024-07-01).
* Добавлена возможность автоматического преобразования нереплицируемых таблиц в [реплицируемые](concepts/replication.md#replicated-tables) при [добавлении хостов ZooKeeper](operations/zk-hosts.md). Функциональность значительно упрощает процесс перехода к отказоустойчивой конфигурации для однохостовых кластеров.
* Добавлена возможность ручного удаления [резервных копий](concepts/backup.md).

## Июнь 2024 {#jun-2024}

Доступна новая версия ClickHouse® [24.5](https://clickhouse.com/docs/ru/whats-new/changelog#-clickhouse-release-245-2024-05-30).

## Май 2024 {#may-2024}

Доступна новая версия ClickHouse® [24.4](https://clickhouse.com/docs/ru/whats-new/changelog#-clickhouse-release-244-2024-04-30).

## Апрель 2024 {#apr-2024}

Доступна новая версия ClickHouse® [24.3 LTS](https://clickhouse.com/docs/ru/whats-new/changelog#-clickhouse-release-243-lts-2024-03-27).

## Март 2024 {#mar-2024}

* Доступна новая версия ClickHouse® [24.2](https://clickhouse.com/docs/ru/whats-new/changelog#-clickhouse-release-242-2024-02-29).
* Добавлена возможность создавать или удалять несколько хостов в рамках одной операции. Это поможет ускорить процесс добавления или удаления большого количества хостов в кластере.
* [Лимит](concepts/limits.md#mch-limits) на размер сетевых дисков `network-ssd-nonreplicated` увеличен в 2 раза — с 8 до 16 ТБ. Это позволит расширять кластер без добавления дополнительных шардов.

## Февраль 2024 {#feb-2024}

* Доступны новые версии ClickHouse®: [23.9](https://clickhouse.com/docs/ru/whats-new/changelog/2023#239), [23.10](https://clickhouse.com/docs/ru/whats-new/changelog/2023#2310), [23.11](https://clickhouse.com/docs/ru/whats-new/changelog/2023#2311), [23.12](https://clickhouse.com/docs/ru/whats-new/changelog/2023#2312) и [24.1](https://clickhouse.com/docs/ru/whats-new/changelog#-clickhouse-release-241-2024-01-30).
* Добавлена возможность [перезапускать хосты](operations/hosts.md#restart) кластера. В большинстве случаев пользователям не нужно перезапускать хосты — это инструмент экстренного устранения проблем, связанных с утечками памяти или зависанием внутренних процессов СУБД.

## II квартал 2023 {#q2-2023}

Доступны новые версии ClickHouse®: [23.4](https://clickhouse.com/docs/ru/whats-new/changelog#-clickhouse-release-234-2023-04-26) и [23.5](https://clickhouse.com/docs/ru/whats-new/changelog#-clickhouse-release-235-2023-06-08).

## I квартал 2023 {#q1-2023}

Доступна новая версия ClickHouse® [23.3](https://clickhouse.com/docs/ru/whats-new/changelog#-clickhouse-release-233-lts-2023-03-30).

## IV квартал 2022 {#q4-2022}

* Доступны новые версии ClickHouse®: [22.10](https://clickhouse.com/docs/ru/whats-new/changelog/2022#-clickhouse-release-2210-2022-10-25) и [22.11](https://clickhouse.com/docs/ru/whats-new/changelog/2022#-clickhouse-release-2211-2022-11-17).
* Добавлена возможность создавать хосты ZooKeeper с хранилищем на [нереплицируемых SSD-дисках](concepts/storage.md).
* Добавлена возможность настроить хосты ZooKeeper при восстановлении кластера из резервной копии.
* Добавлена возможность настроить гибридное хранилище при восстановлении кластера из резервной копии.
* Добавлена возможность выполнения SQL-запросов из браузера с помощью [встроенного SQL-редактора](operations/connect/clients.md#inline-editor).
* На странице [мониторинга кластера](operations/monitoring.md#monitoring-cluster) добавлены графики **Data parts**, **Databases**, **Inode usage**, **Rows of MergeTree tables** и **Tables**.
* Графики **Failed insert queries per host**, **Failed queries per host** и **Failed select queries per host** теперь показывают процент неуспешных запросов, а не их количество.
* График **Max replication queue across tables** теперь показывает суммарную очередь репликации всех таблиц и называется **Replication queue**.
* Переименованы следующие графики:
    * **CPU** → **CPU usage**.
    * **Disk bytes** → **Disk read/write bytes**.
    * **Memory** → **Memory usage**.
    * **Read parts per host** → **Read rows per host**.

## III квартал 2022 {#q3-2022}

* В команде `yc managed-clickhouse cluster restore` следующие параметры сделаны опциональными:

    * `--name`;
    * `--description`;
    * `--host`;
    * `--user`.

    Если значения этих параметров не указаны, их значения будут взяты из исходного кластера. При этом хосты ClickHouse® и ZooKeeper будут восстановлены с той же конфигурацией, что и в исходном кластере. Хосты ClickHouse® будут восстановлены только для тех шардов, чьи резервные копии указаны для восстановления.

* Добавлены настойки гибридного хранилища: `data_cache_enabled`, `data_cache_max_size` и `move_factor`.

## II квартал 2022 {#q2-2022}

* Доступна новая версия ClickHouse® 22.5 ([список изменений](https://clickhouse.com/docs/ru/whats-new/changelog/2022#-clickhouse-release-225-2022-05-19)).
* Добавлена поддержка запроса `SYSTEM UNFREEZE`. Запрос полностью удаляет резервную копию кластера из облачного хранилища, включая данные таблиц, которые могут занимать место в хранилище после удаления. Подробнее на [GitHub](https://github.com/ClickHouse/ClickHouse/pull/36424).
* Сокращено время восстановления кластера из резервной копии.
* Исправлена ошибка, в результате которой при редактировании списка подключений к топикам Apache Kafka® могли удаляться уже настроенные пароли доступа к топикам.
* Добавлена возможность выдавать пользователям права на системные таблицы (`_system`).
* Включена настройка [force_remove_data_recursively_on_drop](https://github.com/ClickHouse/ClickHouse/pull/30054) для предотвращения ошибок `Directory not empty` при удалении баз данных.

## I квартал 2022 {#q1-2022}

* Доступна новая версия ClickHouse® 22.3 LTS ([список изменений](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md)).
* Добавлена возможность восстановления шардированного кластера из резервной копии целиком.
* Добавлена возможность изменения настройки публичного доступа для хоста.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._