### Инвентаризация параметров sysctl ОС {#sysctl}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.sysctl ||
|#

#### Описание

Это правило инвентаризации собирает информацию о параметрах sysctl ядра на рабочих узлах с помощью агента инвентаризации.

Запросы:

options. Список всех параметров system controls.

```SELECT * FROM system_controls;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
