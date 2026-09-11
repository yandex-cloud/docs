### Инвентаризация событий seccomp ОС {#seccomp}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.seccomp ||
|#

#### Описание

Это правило инвентаризации собирает события seccomp на рабочих узлах с помощью агента инвентаризации.

Запросы:

seccomp_events. События seccomp.

```SELECT * FROM seccomp_events;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
