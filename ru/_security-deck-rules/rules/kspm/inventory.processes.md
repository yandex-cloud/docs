### Инвентаризация процессов ОС {#processes}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.processes ||
|#

#### Описание

Данное правило инвентаризации собирает информацию о запущенных процессах на рабочих узлах с помощью агента инвентаризации.

Запросы:

executions_lite. Все процессы в системе (без дерева).

```SELECT ps.pid pid, ps.path path, ps.cmdline cmdline, ps.cwd cwd, ps.parent parent, ps.time time, ps.uid uid, ps.auid auid FROM process_events ps WHERE ps.syscall IN ('execve', 'execveat');```

running. Изменения в запущенных процессах.

```SELECT pid, parent, uid, euid, path, cmdline, on_disk FROM processes;```

running_s. Снимок запущенных процессов.

```SELECT pid, parent, uid, euid, path, cmdline, on_disk FROM processes;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
