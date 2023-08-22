# Настройка локального кеширующего DNS-резолвера

**Не** используйте {{ dns-full-name }} напрямую для запроса внешних доменных имён.

Вместо этого, установите и настройте локальный кеширующий DNS-резолвер, например, `systemd-resolved`, `dnsmasq` или `unbound`. Это ускорит выполнение публичных DNS-запросов, уменьшит их количество и [ваши расходы](../../dns/pricing.md#public-dns-requests).

Если на виртуальной машине установлена операционная система Ubuntu версии 18.04 LTS или выше, то в ней по умолчанию уже используется кеширующий резолвер `systemd-resolved`, и дополнительных действий по установке и настройке не требуется. Подробнее см. в разделе [systemd-resolved](#systemd-resolved).

Если на виртуальной машине используется более старая версия Ubuntu, например, [16.04 LTS](/marketplace/products/yc/ubuntu-16-04-lts) — кеширующий DNS-резолвер нужно установить самостоятельно. Мы рекомендуем использовать `dnsmasq` или `unbound`. Подробнее см. в разделе [Альтернативные резолверы](#alternate-resolvers).

## systemd-resolved в Ubuntu 18.04+ {#systemd-resolved}

### Проверка работоспособности {#test-resolver}

Состояние кеширующего DNS-резолвера `systemd-resolved` в Ubuntu 18.04+ можно узнать, выполнив команду:

```
systemd-resolve --status
```

Так как утилита `systemd-resolved` была переименована в `resolvectl`, для Ubuntu 22.04+ команда будет отличаться:

```
resolvectl status
```

Результат:

```
<...>
Link 2 (eth0)
  <...>
  Current DNS Server: 192.168.6.2         
         DNS Servers: 192.168.6.2         
          DNS Domain: {{ region-id }}.internal
                      auto.internal 
```

При корректной конфигурации, в выводе команды в строке `Current DNS Server:` будет указан адрес сервера {{ dns-full-name }} — второй адрес в виртуальной сети. Например, `192.168.6.2` для ВМ в подсети `192.168.6.0/24`.

С помощью утилиты `dig` вы можете убедиться, что внешние DNS-имена успешно резолвятся DNS-сервером `127.0.0.53#53`.
При этом все резолвы внешнего DNS-имени, кроме самого первого, выполняются практически мгновенно:

```
dig example.com
<...>
;; Query time: 69 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
<...>
   
dig example.com
<...>
;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
<...>
```

### Замена на альтернативный резолвер {#change-resolver}

Если требуется заменить `systemd-resolved` на другой локальный кеширующий DNS-резолвер:

1. Установите альтернативный резолвер по инструкции из раздела [Альтернативные резолверы](#alternate-resolvers).

1. Отредактируйте конфигурационный файл `/etc/systemd/resolved.conf`, чтобы выключить stub-резолвер и указать `127.0.0.1` в качестве адреса DNS-сервера:

   ```
   [Resolve]
   <...>
   DNS=127.0.0.1
   DNSStubListener=no
   ```

1. Перезапустите сервис `systemd-resolved`:

   ```
   systemctl restart systemd-resolved
   ```

1. Проверьте, что `dig` теперь использует сервер `127.0.0.1#53`, а не `127.0.0.53#53`:

   ```
   dig example.com
   ```

   Результат:

   ```
   <...>
   ;; Query time: 0 msec
   ;; SERVER: 127.0.0.1#53(127.0.0.1)
   <...>
   ```

## Альтернативные резолверы {#alternate-resolvers}

{% note warning %}

Параметры конфигурации приведены для примера. Как настроить кеширующий резолвер с учетом нагрузки на ВМ и ваших потребностей см. в документации выбранного резолвера.

{% endnote %}

{% list tabs %}

- dnsmasq

  [dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html ) — легковесный и нетребовательный к ресурсам кеширующий DNS-резолвер.

  1. Установите пакеты `dnsmasq` и `dnsutils`:

     ```
     sudo apt-get update -y

     sudo apt-get install dnsmasq dnsutils -y
     ```

  1. Отредактируйте конфигурационный файл `/etc/dnsmasq.conf`, увеличив размер кэша до 1000 и ограничив локальной машиной адреса, которые слушает кеширующий резолвер:

     ```
     cache-size=1000
     listen-address=127.0.0.1
     interface=lo
     bind-interfaces
     ```

  1. Перезапустите сервис `dnsmasq`, чтобы применить новые настройки. Проверьте, что статус сервиса `dnsmasq` сменился на `active (running)`, а в конце лога сервиса присутствует строка `Started dnsmasq.service`:

     ```
     sudo systemctl restart dnsmasq.service
     
     sudo systemctl status dnsmasq.service
     ● dnsmasq.service - dnsmasq - A lightweight DHCP and caching DNS server
     Loaded: loaded (/lib/systemd/system/dnsmasq.service; enabled; vendor preset: enabled)
     Active: active (running) <...>
     <...>
     Oct 28 22:39:57 <...> systemd[1]: Starting dnsmasq - A lightweight DHCP and caching DNS server...
     Oct 28 22:39:57 <...> dnsmasq[<...>]: dnsmasq: syntax check OK.
     Oct 28 22:39:57 <...> dnsmasq[<...>]: started, version 2.75 cachesize 150
     <...>
     Oct 28 22:39:58 <...> dnsmasq[<...>]: using nameserver 192.168.6.2#53
     Oct 28 22:39:58 <...> systemd[1]: Started dnsmasq - A lightweight DHCP and caching DNS server.
     ```

     Также обратите внимание на адрес в строке `using nameserver <...>`. Там должен находиться адрес сервера {{ dns-full-name }} — второй адрес в виртуальной сети. Например, `192.168.6.2` для ВМ в подсети `192.168.6.0/24`.
	 
  1. С помощью утилиты `dig` проверьте, что внешние DNS-имена успешно резолвятся:

     ```
     dig example.com @127.0.0.1 | grep -B3 Query
     ;; ANSWER SECTION:
     example.com.		65420	IN	A	93.184.216.34
     ;; Query time: 3 msec

     dig example.com @127.0.0.1 | grep -B3 Query
     ;; ANSWER SECTION:
     example.com.		65420	IN	A	93.184.216.34
     ;; Query time: 0 msec
     ```
     
- unbound

  [unbound](https://unbound.docs.nlnetlabs.nl/en/latest/) — валидирующий рекурсивный кеширующий DNS-резолвер с акцентом на производительности, экономном потреблении ресурсов и соответствии современным открытым стандартам.

  1. Установите пакеты `unbound` и `dnsutils`:
     
     ```
     sudo apt-get update -y
     
     sudo apt-get install unbound dnsutils -y
     ```

  1. Укажите настройки сервера в конце глобального конфигурационного файла `/etc/unbound/unbound.conf` или в отдельном конфигурационном файле с именем `/etc/unbound/unbound.conf.d/<имя файла>.conf`:

     ```
     server:
         port: 53
         interface: 127.0.0.1
         access-control: 127.0.0.0/8 allow
         do-ip4: yes
         do-ip6: no
         do-udp: yes
         do-tcp: yes
         num-threads: 2
         num-queries-per-thread: 1024
         hide-identity: yes
         hide-version: yes
         prefetch: yes
         verbosity: 1
     ```

  1. Запустите сервис `unbound`, чтобы применить новые настройки. Проверьте, что статус сервиса `unbound` стал `active (running)`, а в конце лога сервиса присутствует строка `Started unbound.service`:

     ```
     sudo systemctl start unbound.service
       
     sudo systemctl status unbound.service
     ● unbound.service - Unbound DNS server
     Loaded: loaded (/lib/systemd/system/unbound.service; enabled; vendor preset: enabled)
     Active: active (running) <...>
     <...>
     Oct 29 00:21:06 <...> unbound[<...>]:  * Starting DNS server unbound
     Oct 29 00:21:06 <...> unbound[<...>]: [<...>:0] info: start of service (unbound 1.5.8).
     Oct 29 00:21:06 <...> unbound[<...>]:    ...done.
     Oct 29 00:23:21 <...> systemd[1]: Started unbound.service.
     ```
  
  1. С помощью утилиты `dig` проверьте, что внешние DNS-имена успешно резолвятся:

     ```
     dig example.com @127.0.0.1 | grep -B3 Query
     ;; ANSWER SECTION:
     example.com.		86400	IN	A	93.184.216.34
     ;; Query time: 611 msec
  
     dig example.com @127.0.0.1 | grep -B3 Query
     ;; ANSWER SECTION:
     example.com.		86397	IN	A	93.184.216.34
     ;; Query time: 0 msec
     ```

{% endlist %}
