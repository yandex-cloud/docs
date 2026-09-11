### OS-level network settings inventory {#network}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.network ||
|#

#### Description

This inventory rule collects data on network settings across worker nodes using an inventory agent.

Queries:

check_external_fqdn. Check external connectivity with google.

```SELECT url, response_code FROM curl WHERE url = 'https://google.ru' AND user_agent='Mozilla/5.0';```

check_external_ip. Check external connectivity with google.

```SELECT url, response_code FROM curl WHERE url = 'https://8.8.8.8' AND user_agent='Mozilla/5.0';```

iptables. Iptables.

```SELECT * FROM iptables;```

iptables_s. Iptables snapshot.

```SELECT * FROM iptables;```

dns_resolvers. Dns_resolvers.

```SELECT * FROM dns_resolvers;```

dns_resolvers_s. Dns_resolvers snapshot.

```SELECT * FROM dns_resolvers;```

etc_hosts. Etc_hosts.

```SELECT * FROM etc_hosts;```

etc_hosts_s. Etc_hosts snapshot.

```SELECT * FROM etc_hosts;```

processes_binding_to_ports. Listening ports binded to processes.

```SELECT DISTINCT ps.name name, ln.port port, ln.protocol protocol, ln.family family, ln.address address, ps.pid pid, ps.path path, ps.on_disk on_disk, ps.parent parent, u.username username FROM processes ps JOIN listening_ports ln USING(pid) JOIN users u USING(uid) WHERE ps.path NOT IN ('/usr/local/bin/netmon-agent', '/bin/ping', '/usr/bin/ping', '/bin/ping6', '/usr/bin/ping6');```

processes_binding_to_ports_s. Listening ports binded to processes snapshot.

```SELECT DISTINCT ps.name name, ln.port port, ln.protocol protocol, ln.family family, ln.address address, ps.pid pid, ps.path path, ps.on_disk on_disk, ps.parent parent, u.username username FROM processes ps JOIN listening_ports ln USING(pid) JOIN users u USING(uid) WHERE ps.path NOT IN ('/usr/local/bin/netmon-agent', '/bin/ping', '/usr/bin/ping', '/bin/ping6', '/usr/bin/ping6');```

interface_addresses. Interface_addresses.

```SELECT * FROM interface_addresses;```

interface_addresses_s. Interface_addresses snapshot.

```SELECT * FROM interface_addresses;```

process_open_sockets. Processes which have open network sockets on the system.

```SELECT * FROM process_open_sockets WHERE NOT (local_address=remote_address) AND NOT (remote_address IN ('', '169.254.169.254', '0.0.0.0', '::', '2a02:6b8::1d9', '::1')) AND (protocol IN (6, 17)) AND NOT (fd=-1) AND NOT (remote_port IN (0, 30080));```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
