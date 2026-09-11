### Инвентаризация информации о сетевых параметрах ОС {#network}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.network ||
|#

#### Описание

Это правило инвентаризации собирает информацию о сетевых параметрах на рабочих узлах с помощью агента инвентаризации.

Запросы:

check_external_fqdn. Проверка внешней связности через google.

```SELECT url, response_code FROM curl WHERE url = 'https://google.ru' AND user_agent='Mozilla/5.0';```

check_external_ip. Проверка внешней связности через google.

```SELECT url, response_code FROM curl WHERE url = 'https://8.8.8.8' AND user_agent='Mozilla/5.0';```

iptables. Iptables.

```SELECT * FROM iptables;```

iptables_s. Снимок iptables.

```SELECT * FROM iptables;```

dns_resolvers. Dns_resolvers.

```SELECT * FROM dns_resolvers;```

dns_resolvers_s. Снимок dns_resolvers.

```SELECT * FROM dns_resolvers;```

etc_hosts. Etc_hosts.

```SELECT * FROM etc_hosts;```

etc_hosts_s. Снимок etc_hosts.

```SELECT * FROM etc_hosts;```

processes_binding_to_ports. Порты прослушивания, привязанные к процессам.

```SELECT DISTINCT ps.name name, ln.port port, ln.protocol protocol, ln.family family, ln.address address, ps.pid pid, ps.path path, ps.on_disk on_disk, ps.parent parent, u.username username FROM processes ps JOIN listening_ports ln USING(pid) JOIN users u USING(uid) WHERE ps.path NOT IN ('/usr/local/bin/netmon-agent', '/bin/ping', '/usr/bin/ping', '/bin/ping6', '/usr/bin/ping6');```

processes_binding_to_ports_s. Снимок портов прослушивания, привязанных к процессам.

```SELECT DISTINCT ps.name name, ln.port port, ln.protocol protocol, ln.family family, ln.address address, ps.pid pid, ps.path path, ps.on_disk on_disk, ps.parent parent, u.username username FROM processes ps JOIN listening_ports ln USING(pid) JOIN users u USING(uid) WHERE ps.path NOT IN ('/usr/local/bin/netmon-agent', '/bin/ping', '/usr/bin/ping', '/bin/ping6', '/usr/bin/ping6');```

interface_addresses. Interface_addresses.

```SELECT * FROM interface_addresses;```

interface_addresses_s. Снимок interface_addresses.

```SELECT * FROM interface_addresses;```

process_open_sockets. Процессы с открытыми сетевыми сокетами в системе.

```SELECT * FROM process_open_sockets WHERE NOT (local_address=remote_address) AND NOT (remote_address IN ('', '169.254.169.254', '0.0.0.0', '::', '2a02:6b8::1d9', '::1')) AND (protocol IN (6, 17)) AND NOT (fd=-1) AND NOT (remote_port IN (0, 30080));```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
