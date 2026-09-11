### Инвентаризация ядра ОС {#kernel}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.kernel ||
|#

#### Описание

Это правило инвентаризации собирает информацию о версии ядра, загруженных модулях и списках ненадёжных адресов на рабочих узлах с помощью агента инвентаризации.

Запросы:

kernel. Версия ядра и cmdline.

```SELECT * FROM kernel_info;```

kernel_s. Версия ядра и cmdline.

```SELECT * FROM kernel_info;```

kernel_modules. Загруженные модули и изменения.

```SELECT name, status, size, used_by FROM kernel_modules;```

kernel_modules_s. Снимок загруженных модулей.

```SELECT name, status, size, used_by FROM kernel_modules;```

algif_aead_disable. Проверка blacklist для CVE-2026-31431.

```SELECT node, label, value FROM augeas WHERE path='/etc/modprobe.d/disable-algif.conf' AND label != 'disable-algif.conf';```

modules_lpe_check. Проверка модулей на уязвимости LPE.

```SELECT node, label, value FROM augeas WHERE path='/etc/modprobe.d/blacklist-lpe.conf' AND label != 'blacklist-lpe.conf';```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
