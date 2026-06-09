# Как включить логирование SQL-запросов


## Описание сценария {#case-description}

Необходимо включить логирование SQL-запросов.

## Решение {#case-resolution}

Чтобы включить логирование запросов, необходимо проверить, что установлено расширение `pg_stat_statements` — оно добавляет возможность отслеживания планирования и сбора статистики выполнения всех SQL-запросов, запущенных в кластере. Для использования расширения [нужна роль `mdb_monitor`](../../../managed-postgresql/operations/extensions/cluster-extensions.md)

Дополнительно проверьте настройку `Auto explain sample rate=1` и `Auto explain log analyze`, как указано в [инструкции](../../../managed-postgresql/concepts/settings-list.md#dbms-cluster-settings) и включите параметр `Log min duration statement`. Значение `1 ms` желательно не устанавливать, так как в этом случае кластер будет занят только записью логов.

Этот параметр можно включить через [Консоль управления]({{ link-console-main }}), выбрав **{{ ui-key.yacloud.mdb.cluster.overview.label_advanced-settings }}**, или с помощью YC CLI командой: 

```
yc managed-postgresql cluster update-config <имя кластера> --set log_min_duration_statement=100
```

Затем можно посмотреть записи в логах, например через YC CLI: 

```
yc managed-postgresql cluster list-logs --service-type postgresql --since '2h' --until '1s' --id=YOUR-CLUSTER-ID
```