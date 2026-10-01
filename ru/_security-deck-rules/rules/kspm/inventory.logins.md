### Инвентаризация информации о логинах пользователей ОС {#logins}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.logins ||
|#

#### Описание

Это правило инвентаризации собирает информацию о логинах пользователей на рабочих узлах с помощью агента инвентаризации.

Запросы:

serial. Логины через последовательную консоль в системе.

```SELECT ue.auid AS auid, ue.message AS message, ue.type AS event_type, ue.path AS logon_path, ue.terminal AS terminal, ue.pid AS logon_pid, pe.cmdline AS logon_cmdline, u.username AS user, regex_match(pe.cmdline, '/bin/login -p -- (\w+)', 1) AS serial_user, datetime(ue.time, 'unixepoch') AS dt FROM user_events ue LEFT JOIN users u ON ue.auid=u.uid LEFT JOIN process_events pe ON ue.pid=pe.pid WHERE terminal LIKE '/dev/tty%' AND ue.type IN (1112,1105);```

root. Root-логины и повышения привилегий в системе.

```SELECT ue.uid, ue.auid, u.username AS audit_user, u.shell AS shell, ue.pid, ue.message, ue.type, ue.path, ue.address, ue.terminal, pe.cmdline, pe.time, datetime(ue.time, 'unixepoch') AS dt FROM user_events ue LEFT JOIN users u ON ue.auid=u.uid LEFT JOIN process_events pe ON ue.pid=pe.pid WHERE ue.uid=0 AND ue.type=1105 AND ue.auid NOT IN (-1,4294967295) AND (terminal='ssh' OR terminal LIKE '/dev/pts%');```

failed. Множественные неудачные логины с одного IP-адреса.

```SELECT type, message, address, terminal, count() AS count, datetime(min(time), 'unixepoch') AS earliest, datetime(max(time), 'unixepoch') AS latest, count()*60.0/(max(time)-min(time)) AS speed FROM user_events WHERE type=1109 AND time>unixepoch('now', '-30 minutes') GROUP BY address, terminal, message HAVING count >= 5;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
