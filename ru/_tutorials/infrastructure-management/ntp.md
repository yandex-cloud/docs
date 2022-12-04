---
description: "Network Time Protocol Servers (NTP) – позволяет выполнять настройку синхронизации с общедоступными NTP серверами времени на виртуальных машинах Yandex Cloud под управлением Windows Server и Linux. Описан порядок настройки серверов для синхронизации."
keywords:
  - ntp
  - ntp server
  - sntp
  - синхронизация времени
  - нтп сервер
  - ntp сервер
---

# Настройка синхронизации часов с помощью NTP

На виртуальных машинах {{ yandex-cloud }} можно настроить синхронизацию с общедоступными серверами времени по протоколу [NTPv4](https://tools.ietf.org/html/rfc5905):
* Для ВМ с ОС Windows Server нужно указать 3 рекомендуемых сервера в настройках синхронизации времени.
* На ВМ с операционной системой на основе Linux должен быть включен DHCP-клиент с опцией 42, `Network Time Protocol Servers` (опция позволяет автоматически применять список серверов синхронизации, отправляемый сервером DHCP). В образах, предоставляемых {{ yandex-cloud }}, ОС уже настроены нужным образом.

  На случай неработоспособности или недоступности DHCP-сервера укажите запасные серверы синхронизации в настройках системы. Чтобы сделать это, следуйте [инструкциям](#setup).

Рекомендуемые серверы синхронизации:
* `ntp0.NL.net`
{% if product == "yandex-cloud" %}
* `ntp2.vniiftri.ru`
* `ntp.ix.ru`
{% endif %}
{% if product == "cloud-il" %}
* `timeserver.iix.net.il`
{% endif %}
* `ntps1-1.cs.tu-berlin.de`

Список рекомендуемых серверов может меняться. О том, что вам нужно внести изменения в конфигурацию ВМ, {{ yandex-cloud }} сообщит за 72 часа.

## Порядок настройки {#setup}

{% list tabs %}

- Linux (systemd)

  {% note alert %}

  Сервис `systemd-timesyncd` может конфликтовать с сервисом `ntpd`, если они запущены одновременно. Вы можете либо удалить сервис `ntpd`, либо настроить синхронизацию времени с его помощью (на соседней вкладке).

  {% endnote %}

  Укажите запасные серверы в настройках системы:

  1. Перечислите запасные серверы в файле `/etc/systemd/timesyncd.conf`, в секции `[Time]` в параметре `FallbackNTP=`, например:
     
     {% if product == "yandex-cloud" %}

     ```bash
     FallbackNTP=ntp0.NL.net ntp2.vniiftri.ru ntp.ix.ru ntps1-0.eecsit.tu-berlin.de
     ```

     {% endif %}

     {% if product == "cloud-il" %}

     ```
     FallbackNTP=ntp0.NL.net timeserver.iix.net.il ntps1-0.eecsit.tu-berlin.de
     ```
     
     {% endif %}

  1. Установите параметр `UseNTP=true` в конфигурационном файле сервиса `systemd.network`, обычно расположенном в каталоге `/etc/systemd/network` или `/var/lib/systemd/network`.

  1. Перезапустите сервис синхронизации:

     ```bash
     sudo systemctl restart systemd-timesyncd
     ```

- Linux (ntpd)

  Укажите адреса нужных серверов в конфигурации `ntpd`:

  1. Укажите адреса рекомендуемых серверов в файле `/etc/ntp.conf`. Адреса серверов по умолчанию закомментируйте символом <q>#</q> в начале строки, например:
     
     {% if product == "yandex-cloud" %}

     ```text
     # Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
     # on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
     # more information.
     # server 0.ubuntu.pool.ntp.org
     # server 1.ubuntu.pool.ntp.org
     # server 2.ubuntu.pool.ntp.org
     # server 3.ubuntu.pool.ntp.org
     server ntp0.NL.net
     server ntp2.vniiftri.ru
     server ntp.ix.ru
     server ntps1-0.eecsit.tu-berlin.de
     ```

     {% endif %}

     {% if product == "cloud-il" %}

     ```text
     # Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
     # on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
     # more information.
     # server 0.ubuntu.pool.ntp.org
     # server 1.ubuntu.pool.ntp.org
     # server 2.ubuntu.pool.ntp.org
     # server 3.ubuntu.pool.ntp.org
     server ntp0.NL.net
     server timeserver.iix.net.il
     server ntps1-0.eecsit.tu-berlin.de
     ```

     {% endif %}

  2. Перезапустите сервис:

     ```bash
     sudo service ntp restart
     ```

- Windows Server

  Укажите рекомендуемые серверы в настройках сервиса Windows Time, последовательно выполнив следующие команды в PowerShell или `cmd`:
  
  {% if product == "yandex-cloud" %}

  ```
  net stop w32time
  w32tm /config /syncfromflags:manual /manualpeerlist:"ntp0.NL.net ntp2.vniiftri.ru ntp.ix.ru ntps1-0.eecsit.tu-berlin.de"
  w32tm /config /reliable:yes
  net start w32time
  ```

  {% endif %}

  {% if product == "cloud-il" %}

  ```
  net stop w32time
  w32tm /config /syncfromflags:manual /manualpeerlist:"ntp0.NL.net timeserver.iix.net.il ntps1-0.eecsit.tu-berlin.de"
  w32tm /config /reliable:yes
  net start w32time
  ```

  {% endif %}

{% endlist %}
