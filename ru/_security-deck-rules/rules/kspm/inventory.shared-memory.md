### Инвентаризация разделяемой памяти ОС {#shared-memory}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.shared-memory ||
|#

#### Описание

Это правило инвентаризации собирает информацию о сегментах разделяемой памяти на рабочих узлах с помощью агента инвентаризации.

Запросы:

shm_s. Снимок событий разделяемой памяти.

```SELECT sm.shmid, sm.owner_uid, o.username AS owner_username, sm.size, sm.permissions, sm.atime, sm.attached, sm.creator_pid, pe_c.path AS creator_path_bin, pe_c.cmdline AS creator_cmdline, sm.creator_uid, c.username AS creator_username, sm.ctime, sm.dtime, sm.locked, sm.pid, pe.path AS path_bin, pe.cmdline, sm.status FROM shared_memory sm LEFT JOIN users o ON sm.owner_uid = o.uid LEFT JOIN users c ON sm.creator_uid = c.uid LEFT JOIN process_events pe_c ON sm.creator_pid = pe_c.pid LEFT JOIN process_events pe ON sm.pid = pe.pid;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
