[Документация Yandex Cloud](../../index.md) > [Yandex Security Deck](../index.md) > [Справочник правил](index.md) > KSPM

## KSPM Kubernetes® Security Posture Management

Правила для проверки конфигурации кластеров Kubernetes.

### Установлены строгие разрешения для файла службы Kubelet {#host-security.kubelet-service-file-perm-600}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-service-file-perm-600 ||
|#

#### Описание

Файл службы kubelet управляет различными параметрами, которые определяют поведение службы kubelet на рабочем узле. 
Вы должны ограничить разрешения на файл для поддержания целостности. 
Файл должен быть доступен для записи только администраторам системы.

#### Рекомендации

**Для выполнения аудита вручную:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
stat -c %a /etc/systemd/system/kubelet.service.d/kubeadm.conf
```
Убедитесь, что разрешения равны значению `600` или более строгие.

**Исправление:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
chmod 600 /etc/systemd/system/kubelet.service.d/kubeadm.conf
```

### Владелец файла службы Kubelet указан как root:root {#host-security.kubelet-service-file-owner-root}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-service-file-owner-root ||
|#

#### Описание

Файл службы kubelet управляет различными параметрами, которые определяют поведение службы kubelet на рабочем узле. 
Вы должны установить владельца файла для поддержания целостности. 
Файл должен принадлежать владельцу, указанному как `root:root`.

#### Рекомендации

**Для выполнения аудита вручную:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
stat -c %U:%G /etc/systemd/system/kubelet.service.d/kubeadm.conf
```
Убедитесь, что владелец указан как `root:root`.

**Исправление:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
chown root:root /etc/systemd/system/kubelet.service.d/kubeadm.conf
```

### Установлены строгие разрешения для файла конфигурации kubeconfig {#host-security.kubelet-conf-600}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-conf-600 ||
|#

#### Описание

Файл `kubelet.conf` является файлом kubeconfig для узла. Файл управляет различными параметрами, которые определяют поведение и идентификацию рабочего узла. 
Вы должны ограничить разрешения на файл для поддержания целостности. 
Файл должен быть доступен для записи только администраторам системы.

#### Рекомендации

**Для выполнения аудита вручную:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
stat -c %a /etc/kubernetes/kubelet.conf
```
Убедитесь, что разрешения установлены в значение `600` или более строгие.

**Исправление:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
chmod 600 /etc/kubernetes/kubelet.conf
```

### Владелец файла конфигурации kubeconfig указан как root:root {#host-security.kubelet-conf-owner-root}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-conf-owner-root ||
|#

#### Описание

Файл `kubelet.conf` является файлом kubeconfig для узла. Файл управляет различными параметрами, которые определяют поведение и идентификацию рабочего узла. 
Вы должны установить владельца файла для поддержания целостности. 
Файл должен принадлежать владельцу, указанному как `root:root`.

#### Рекомендации

**Для выполнения аудита вручную:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
stat -c %U:%G /etc/kubernetes/kubelet.conf
```
Убедитесь, что владелец указан как `root:root`.

**Исправление:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
chown root:root /etc/kubernetes/kubelet.conf
```

### Установлены строгие разрешения для файла конфигурации Kubelet {#host-security.kubelet-config-permissions-600}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-config-permissions-600 ||
|#

#### Описание

Если kubelet ссылается на файл конфигурации с аргументом `--config`, убедитесь, что этот файл имеет разрешения со значением `600` или более строгие.
Kubelet считывает различные параметры, включая настройки безопасности, из файла конфигурации, указанного аргументом `--config`. 
Если этот файл указан, вы должны ограничить его разрешения для поддержания целостности файла. 
Файл должен быть доступен для записи только администраторам системы.

#### Рекомендации

**Для выполнения аудита вручную:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
stat -c %a /var/lib/kubelet/config.yaml
```
Убедитесь, что разрешения равны значению `600` или более строгие.

**Исправление:**

Выполните следующую команду (используя расположение файла конфигурации, определенное на этапе аудита):
```
chmod 600 /var/lib/kubelet/config.yaml
```

### Владелец файла конфигурации kubelet указан как root:root {#host-security.kubelet-config-owner-root}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-config-owner-root ||
|#

#### Описание

Если kubelet ссылается на файл конфигурации с аргументом `--config`, убедитесь, что этот файл принадлежит `root:root`.
Kubelet считывает различные параметры, включая настройки безопасности, из файла конфигурации, указанного аргументом `--config`. 
Если этот файл указан, вы должны ограничить его разрешения для поддержания целостности файла. 
Файл должен принадлежать владельцу, указанному как `root:root`.

#### Рекомендации

**Для выполнения аудита вручную:**

Выполните приведенную ниже команду (в зависимости от расположения файла в вашей системе) на каждом рабочем узле. 
Например:
```
stat -c %U:%G /var/lib/kubelet/config.yaml
```
Убедитесь, что владелец указан как `root:root`.

**Исправление:**

Выполните следующую команду (используя расположение файла конфигурации, определенное на этапе аудита):
```
chown root:root /etc/kubernetes/kubelet.conf
```

### Отключены запросы от анонимных пользователей к серверу Kubelet {#host-security.anonymous-auth-false}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.anonymous-auth-false ||
|#

#### Описание

Отключите анонимные запросы к серверу Kubelet.
Когда включено, запросы, которые не отклонены другими настроенными методами аутентификации, обрабатываются как анонимные запросы. 
Эти запросы затем обслуживаются сервером Kubelet. 
Вы должны полагаться на аутентификацию для авторизации доступа и запретить анонимные запросы.

#### Рекомендации

**Для проведения аудита вручную:**

Если используется файл конфигурации Kubelet, проверьте, что есть запись для `authentication: anonymous: enabled`, установленная в *false*.
Выполните следующую команду на каждом узле:
```
ps -ef | grep kubelet
```
Убедитесь, что аргумент `--anonymous-auth` установлен в значение *false*.
Этот аргумент исполняемого файла может быть опущен при условии, что есть соответствующая запись, установленная в значение *false* в файле конфигурации Kubelet.

**Исправление:**

Если используется файл конфигурации Kubelet, отредактируйте файл, чтобы установить `authentication: anonymous: enabled` в значение *false*.
Если используются аргументы исполняемого файла, отредактируйте файл службы kubelet `/etc/kubernetes/kubelet.conf` на каждом рабочем узле и установите приведенный ниже параметр в переменной `KUBELET_SYSTEM_PODS_ARGS`:
`--anonymous-auth=false`
В зависимости от вашей системы перезапустите службу kubelet. 
Например:
```
systemctl daemon-reload
systemctl restart kubelet.service
```

### Разрешены только явно авторизованные запросы к серверу Kubelet {#host-security.auth-mode-not-always-allow}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.auth-mode-not-always-allow ||
|#

#### Описание

Не разрешайте все запросы. Включите явную авторизацию.
Агенты Kubelet по умолчанию разрешают все аутентифицированные запросы (даже анонимные) без необходимости явных проверок авторизации с сервера apiserver. 
Вы должны ограничить это поведение и разрешить только явно авторизованные запросы.

#### Рекомендации

**Для проведения аудита вручную:**

Выполните следующую команду на каждом узле:
```
ps -ef | grep kubelet
```
Если аргумент `--authorization-mode` существует, убедитесь, что он не установлен в *AlwaysAllow*. 
Если он отсутствует, убедитесь, что есть файл конфигурации Kubelet, указанный параметром `--config`, и этот файл устанавливает `authorization: mode` в значение, отличающееся от *AlwaysAllow*.
Также можно просмотреть текущую конфигурацию Kubelet через конечную точку `/configz` на порту API Kubelet (обычно 10250/TCP). 
Доступ к ним с соответствующими учетными данными предоставит детали конфигурации Kubelet.

**Исправление:**

Если используется файл конфигурации Kubelet, отредактируйте файл, чтобы установить `authorization: mode` в *Webhook*.
Если используются аргументы исполняемого файла, отредактируйте файл службы kubelet `/etc/kubernetes/kubelet.conf` на каждом рабочем узле и установите приведенный ниже параметр в переменной `KUBELET_AUTHZ_ARGS`:
`--authorization-mode=Webhook`
В зависимости от вашей системы, перезапустите службу kubelet. 
Например:
```
systemctl daemon-reload
systemctl restart kubelet.service
```

### Включена аутентификация Kubelet с использованием сертификатов {#host-security.client-ca-file-set}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.client-ca-file-set ||
|#

#### Описание

Включите аутентификацию Kubelet с использованием сертификатов.
Соединения от apiserver к kubelet используются для получения логов для подов, подключения (через kubectl) к запущенным подам и использования функциональности перенаправления портов kubelet. 
Эти соединения завершаются на конечной точке HTTPS kubelet. 
По умолчанию apiserver не проверяет сертификат обслуживания kubelet, что делает соединение уязвимым для атак типа «человек посередине» и небезопасным для работы через ненадежные и/или публичные сети. 
Включение аутентификации сертификатов Kubelet гарантирует, что apiserver может аутентифицировать Kubelet перед отправкой любых запросов.

#### Рекомендации

**Для проведения аудита вручную:**

Выполните следующую команду на каждом узле:
```
ps -ef | grep kubelet
```
Убедитесь, что аргумент `--client-ca-file` существует и установлен в расположение файла центра сертификации клиента.
Если аргумент `--client-ca-file` отсутствует, проверьте, что есть файл конфигурации Kubelet, указанный параметром --config, и что файл устанавливает `authentication: x509: clientCAFile` в расположение файла центра сертификации клиента.

**Исправление:**

Если используется файл конфигурации Kubelet, отредактируйте файл, чтобы установить `authentication: x509: clientCAFile` в расположение файла CA клиента.
Если используются аргументы командной строки, отредактируйте файл службы kubelet `/etc/kubernetes/kubelet.conf` на каждом рабочем узле и установите приведенный ниже параметр в переменной `KUBELET_AUTHZ_ARGS`:
`--client-ca-file=<path/to/client-ca-file>`
В зависимости от вашей системы, перезапустите службу kubelet. 
Например:
```
systemctl daemon-reload
systemctl restart kubelet.service
```

### Kubelet разрешено управлять iptables {#host-security.make-iptables-util-chains-true}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.make-iptables-util-chains-true ||
|#

#### Описание

Разрешите Kubelet управлять iptables.
Kubelet может автоматически управлять необходимыми изменениями в iptables в зависимости от того, как вы выбираете сетевые параметры для подов. 
Рекомендуется разрешить kubelet управлять изменениями в iptables. 
Это гарантирует, что конфигурация iptables остается синхронизированной с конфигурацией сети подов. 
Ручная настройка iptables с динамическими изменениями конфигурации сети подов может помешать связи между подами/контейнерами и внешним миром. 
Ваши правила iptables могут быть слишком ограничительными или слишком открытыми.

#### Рекомендации

**Для проведения аудита вручную:**

Выполните следующую команду на каждом узле:
```
ps -ef | grep kubelet
```
Если аргумент `--make-iptables-util-chains` существует, убедитесь, что он установлен в значение *true*.
Если аргумент `--make-iptables-util-chains` не существует и есть файл конфигурации Kubelet, указанный параметром `--config`, убедитесь, что файл не устанавливает `makeIPTablesUtilChains` в значение *false*.

**Исправление:**

Если используется файл конфигурации Kubelet, отредактируйте файл, чтобы установить `makeIPTablesUtilChains: true`.
Если используются аргументы командной строки, отредактируйте файл службы kubelet `/etc/kubernetes/kubelet.conf` на каждом рабочем узле и удалите аргумент `--make-iptables-util-chains` из переменной `KUBELET_SYSTEM_PODS_ARGS`.
В зависимости от вашей системы перезапустите службу kubelet. 
Например:
```
systemctl daemon-reload
systemctl restart kubelet.service
```

### Включена ротация клиентских сертификатов Kubelet {#host-security.rotate-certs-not-false}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.rotate-certs-not-false ||
|#

#### Описание

Включите ротацию клиентских сертификатов kubelet.
Параметр `--rotate-certificates` запускает ротацию клиентских сертификатов kubelet, создавая новые CSR по мере истечения срока действия существующих учетных данных. 
Эта автоматическая периодическая ротация гарантирует отсутствие простоев из-за просроченных сертификатов и, таким образом, решает проблему доступности в триаде безопасности CIA. 
**Примечание:** Эта рекомендация применяется только в том случае, если вы разрешаете kubelet получать сертификаты с сервера API. 
Если сертификаты kubelet поступают от внешнего инструмента (например, Vault), вам необходимо настроить ротацию самостоятельно. 
**Примечание:** Эта функция также требует, чтобы шлюз `RotateKubeletClientCertificate` был включен (включен по умолчанию начиная с Kubernetes v1.7)

#### Рекомендации

**Для проведения аудита вручную:**

Выполните следующую команду на каждом узле:
```
ps -ef | grep kubelet
```
Убедитесь, что аргумент `RotateKubeletServerCertificate` отсутствует или установлен в значение true.
Если аргумент `RotateKubeletServerCertificate` отсутствует, убедитесь, что есть файл конфигурации Kubelet, указанный параметром `--config`, и этот файл не содержит `RotateKubeletServerCertificate: false`.

**Исправление:**

Если используется файл конфигурации Kubelet, отредактируйте файл, чтобы добавить строку `rotateCertificates: true` или удалите ее полностью, чтобы использовать значение по умолчанию.
Если используются аргументы командной строки, отредактируйте файл службы kubelet `/etc/kubernetes/kubelet.conf` на каждом рабочем узле и удалите аргумент `--rotate-certificates=false` из переменной `KUBELET_CERTIFICATE_ARGS` или установите `--rotate-certificates=true`.
В зависимости от вашей системы перезапустите службу kubelet. 
Например:
```
systemctl daemon-reload
systemctl restart kubelet.service
```

Правила для сбора данных об инвентаризации узлов Kubernetes.

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

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
```

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

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
```

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

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
```

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

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
```

### Инвентаризация о базовых параметрах ОС {#general}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.general ||
|#

#### Описание

Это правило инвентаризации собирает информацию о базовых параметрах на рабочих узлах с помощью агента инвентаризации.

Запросы:

os_version_s. Информация о версии ОС, ядре и CPU.

```SELECT os_name, os_version, major, minor, patch, build, platform, platform_like, codename, version AS kernel_version, phys_cpu, log_cpu, cpu_microcode FROM kernel_info, (SELECT cpu_physical_cores AS phys_cpu, cpu_logical_cores AS log_cpu, cpu_microcode FROM system_info), (SELECT name AS os_name, version AS os_version, major, minor, patch, build, platform, platform_like, codename FROM os_version);```

authorized_keys_s. Снимок файла authorized_keys.

```WITH homes AS MATERIALIZED (SELECT substr(path, 7, length(path)-7) AS uname FROM file WHERE path LIKE '/home/%' UNION SELECT 'root'), uids AS MATERIALIZED (SELECT username, uid, gid, directory FROM users WHERE username IN homes) SELECT u.username, u.uid, u.gid, k.key_file, k.key FROM authorized_keys AS k JOIN uids AS u ON k.uid = u.uid WHERE k.key IS NOT NULL;```

authorized_keys. Файл authorized_keys.

```WITH homes AS MATERIALIZED (SELECT substr(path, 7, length(path)-7) AS uname FROM file WHERE path LIKE '/home/%' UNION SELECT 'root'), uids AS MATERIALIZED (SELECT username, uid, gid, directory FROM users WHERE username IN homes) SELECT u.username, u.uid, u.gid, k.key_file, k.key FROM authorized_keys AS k JOIN uids AS u ON k.uid = u.uid WHERE k.key IS NOT NULL;```

sudoers_rules_s. Снимок правил sudoers.

```SELECT * FROM sudoers;```

known_hosts_s. Снимок known_hosts.

```SELECT * FROM known_hosts;```

crontab. Строки системного и пользовательского cron/tab.

```SELECT * FROM crontab;```

crontab_s. Строки системного и пользовательского cron/tab.

```SELECT * FROM crontab;```

disk_encryption_s. Статус и информация о шифровании дисков.

```SELECT * FROM disk_encryption;```

disk_encryption_mounts_s. Статус и информация о шифровании дисков.

```SELECT * FROM mounts m, disk_encryption d WHERE m.device_alias = d.name AND m.path = '/' AND d.encrypted = 0;```

sshd_config_s. Критические опции в sshd_config.

```SELECT DISTINCT SUBSTRING(node, 8 + LENGTH(path)) AS node, LOWER(label) AS label, value FROM augeas WHERE path = '/etc/ssh/sshd_config' AND label != '#comment' AND (node LIKE '%/PasswordAuthentication' OR node LIKE '%/PermitRootLogin' OR node LIKE '%/LogLevel' OR node LIKE '%/AuthorizedKeysCommand' OR node LIKE '%/PermitEmptyPasswords');```

nss_s. Конфигурация NSS для passwd/shadow/hosts. Следует сортировать GROUP_CONCAT через OVER(ORDER BY), но это работает плохо.

```WITH dta AS MATERIALIZED (SELECT * FROM augeas WHERE path = '/etc/nsswitch.conf'), dbs AS (SELECT node, value AS name FROM dta WHERE label = 'database' AND value IN ('passwd', 'shadow', 'hosts')) SELECT dbs.name AS db, GROUP_CONCAT(dta.value, ' ') AS services FROM dta JOIN dbs ON dta.node LIKE dbs.node || '/%' WHERE label = 'service' GROUP BY dbs.name;```

oslogin_present_s. Возвращает true, если oslogin присутствует, иначе false.

```WITH dta AS MATERIALIZED (SELECT * FROM augeas WHERE path = '/etc/nsswitch.conf'), dbs AS (SELECT node, value AS name FROM dta WHERE label = 'database' AND value IN ('passwd', 'shadow', 'hosts')) SELECT CASE WHEN EXISTS(SELECT dbs.name, GROUP_CONCAT(dta.value, ' ') AS services FROM dta JOIN dbs ON dta.node LIKE dbs.node || '/%' AND dta.value LIKE '%oslogin%') THEN 'true' ELSE 'false' END AS oslogin_present;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.

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

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
```

### Инвентаризация информации об установленных пакетах ОС {#apps}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.apps ||
|#

#### Описание

Это правило инвентаризации собирает информацию об установленных пакетах на рабочих узлах с помощью агента инвентаризации.

Запросы:

installed. Показывает изменения в установленных пакетах.

```SELECT os_version.name AS os_name, os_version.version AS os_version, os_version.major AS os_major, os_version.minor AS os_minor, os_version.platform AS os_platform, os_version.codename AS os_codename, deb_packages.name AS pkg_name, deb_packages.source AS pkg_source, deb_packages.version AS pkg_version, deb_packages.arch AS pkg_arch, deb_packages.status AS pkg_status FROM os_version JOIN deb_packages;```

installed_s. Показывает все установленные пакеты.

```SELECT os_version.name AS os_name, os_version.version AS os_version, os_version.major AS os_major, os_version.minor AS os_minor, os_version.platform AS os_platform, os_version.codename AS os_codename, deb_packages.name AS pkg_name, deb_packages.source AS pkg_source, deb_packages.version AS pkg_version, deb_packages.arch AS pkg_arch, deb_packages.status AS pkg_status FROM os_version JOIN deb_packages;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.

### Инвентаризация пользователей ОС {#users}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.users ||
|#

#### Описание

Данное правило инвентаризации собирает информацию о пользователях на рабочих узлах с помощью агента инвентаризации.

Запросы:

logged. Список вошедших пользователей с SSH-ключами.

```SELECT lu.user, lu.tty, lu.host, lu.time, u.directory, u.shell, u.uid, au.key, au.key_file FROM (SELECT * FROM logged_in_users WHERE type='user') lu JOIN users u ON u.username = lu.user JOIN authorized_keys au USING (uid);```

groups. Пользователи и группы из etc_passwd.

```SELECT users.uid, users.gid, groups.groupname, users.directory, users.username, users.shell FROM users LEFT JOIN groups ON groups.gid = users.gid;```

groups_s. Снимок пользователей и групп из etc_passwd.

```SELECT users.uid, users.gid, groups.groupname, users.directory, users.username, users.shell FROM users LEFT JOIN groups ON groups.gid = users.gid;```

empty_passwd. Список пользователей с пустыми паролями.

```SELECT * FROM shadow WHERE (password_status = 'empty') OR (hash_alg='' AND password_status='active');```

password_expires. Предупреждение о скором истечении пароля.

```SELECT * FROM shadow WHERE (expire < 7) AND (expire > 0);```

list. Изменения в списке пользователей.

```SELECT * FROM users;```

list_s. Список пользователей.

```SELECT * FROM users;```

list_groups. Изменения в списке групп.

```SELECT * FROM groups;```

list_groups_s. Список групп.

```SELECT * FROM groups;```

ipmi. Обнаружение IPMI-логина.

```SELECT type, user, tty, pid FROM logged_in_users WHERE type != 'dead' AND tty LIKE 'tty%';```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.

### Инвентаризация APT-репозиториев ОС {#apt-sources}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.apt-sources ||
|#

#### Описание

Это правило инвентаризации собирает информацию о настроенных APT-репозиториях на рабочих узлах с помощью агента инвентаризации.

Запросы:

all. Изменения всех apt-источников.

```SELECT name, release, source, base_uri, maintainer, components, architectures FROM apt_sources;```

all_s. Снимок всех apt-источников.

```SELECT name, release, source, base_uri, maintainer, components, architectures FROM apt_sources;```

external. Изменения внешних apt-источников (не Yandex или не secure Yandex).

```SELECT name, release, source, base_uri FROM apt_sources WHERE base_uri NOT IN ('http://common-secure.dist.yandex.ru/common','http://dist.yandex.ru/mdb-bionic-secure','http://dist.yandex.ru/mdb-jammy-secure','http://dist.yandex.ru/yandex-cloud-common-secure','http://dist.yandex.ru/yandex-cloud-secure','http://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','http://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','http://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','http://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','http://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','http://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','http://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','http://yandex-xenial-secure.dist.yandex.ru/yandex-xenial','https://common-secure.dist.yandex.ru/common','https://dist.yandex.ru/mdb-bionic-secure','https://dist.yandex.ru/mdb-jammy-secure','https://dist.yandex.ru/yandex-cloud-common-secure','https://dist.yandex.ru/yandex-cloud-secure','https://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','https://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','https://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','https://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','https://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','https://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','https://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','https://yandex-xenial-secure.dist.yandex.ru/yandex-xenial');```

external_s. Снимок внешних apt-источников (не Yandex или не secure Yandex).

```SELECT name, release, source, base_uri FROM apt_sources WHERE base_uri NOT IN ('http://common-secure.dist.yandex.ru/common','http://dist.yandex.ru/mdb-bionic-secure','http://dist.yandex.ru/mdb-jammy-secure','http://dist.yandex.ru/yandex-cloud-common-secure','http://dist.yandex.ru/yandex-cloud-secure','http://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','http://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','http://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','http://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','http://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','http://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','http://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','http://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','http://yandex-xenial-secure.dist.yandex.ru/yandex-xenial','https://common-secure.dist.yandex.ru/common','https://dist.yandex.ru/mdb-bionic-secure','https://dist.yandex.ru/mdb-jammy-secure','https://dist.yandex.ru/yandex-cloud-common-secure','https://dist.yandex.ru/yandex-cloud-secure','https://dist.yandex.ru/yandex-cloud-upstream-bionic-secure','https://yandex-cloud-common-focal-secure.dist.yandex.ru/yandex-cloud-common-focal-secure','https://yandex-cloud-common-secure.dist.yandex.ru/yandex-cloud-common-secure','https://yandex-cloud-focal-secure.dist.yandex.ru/yandex-cloud-focal-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud-secure','https://yandex-cloud-secure.dist.yandex.ru/yandex-cloud','https://yandex-cloud-upstream-focal-secure.dist.yandex.ru/yandex-cloud-upstream-focal-secure','https://yandex-cloud-upstream-xenial-secure.dist.yandex.ru/yandex-cloud-upstream-xenial-secure','https://yandex-cloud-xenial-esm-secure.dist.yandex.ru/yandex-cloud-xenial-esm-secure','https://yandex-xenial-secure.dist.yandex.ru/yandex-xenial');```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.

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

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
```

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

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
```

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

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
```

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

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](../at-ref.md) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](../at-ref.md) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.