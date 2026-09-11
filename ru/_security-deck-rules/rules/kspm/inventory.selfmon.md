### Инвентаризация самомониторинга агента osquery {#selfmon}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.selfmon ||
|#

#### Описание

Это правило инвентаризации собирает метрики использования ресурсов агентом osquery на рабочих узлах с помощью агента инвентаризации.

Запросы:

resource_usage. Использование CPU демоном osquery в секундах, RAM в MiB и размер БД в MiB.

```SELECT SUM(resident_size)/1024/1024 AS mem, ((SUM(user_time) + SUM(system_time)) / 1000) AS cpu, db.db_size_mb AS db_size FROM processes, (SELECT (SUM(size) / 1024) / 1024 AS db_size_mb FROM (SELECT value FROM osquery_flags WHERE name = 'database_path' LIMIT 1) flags, file WHERE path LIKE flags.value || '%%' AND type = 'regular') db WHERE name = 'osqueryd' OR name = 'osqueryd.exe';```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
