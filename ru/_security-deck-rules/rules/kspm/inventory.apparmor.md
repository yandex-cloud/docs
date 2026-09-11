### Инвентаризация AppArmor ОС {#apparmor}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.apparmor ||
|#

#### Описание

Это правило инвентаризации собирает события и профили AppArmor на рабочих узлах с помощью агента инвентаризации.

Запросы:

apparmor_events. События AppArmor.

```SELECT * FROM apparmor_events;```

profiles. Изменения профилей AppArmor.

```SELECT * FROM apparmor_profiles;```

profiles_s. Снимок профилей AppArmor.

```SELECT * FROM apparmor_profiles;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
