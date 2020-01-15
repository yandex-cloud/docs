# Настройка синхронизации часов с помощью NTP

На виртуальных машинах Яндекс.Облака можно настроить синхронизацию с общедоступными серверами времени по протоколу [NTPv4](https://tools.ietf.org/html/rfc5905):

 * Для ВМ с ОС Windows Server нужно указать 3 рекомендуемых сервера в настройках синхронизации времени.
 * На ВМ с операционной системой на основе Linux должен быть включен DHCP-клиент с опцией 42, `Network Time Protocol Servers` (опция позволяет автоматически применять список серверов синхронизации, отправляемый сервером DHCP). В образах, предоставляемых Яндекс.Облаком, ОС уже настроены нужным образом.

   На случай неработоспособности или недоступности DHCP-сервера укажите запасные серверы синхронизации в настройках системы. Чтобы сделать это, следуйте [инструкциям](#setup).

Рекомендуемые серверы синхронизации:

 - [ntp0.NL.net](http://support.ntp.org/bin/view/Servers/PublicTimeServer000233)
 - [clock.isc.org](https://support.ntp.org/bin/view/Servers/PublicTimeServer000262)
 - [ntp2.vniiftri.ru](http://support.ntp.org/bin/view/Servers/PublicTimeServer000352)
 - [ntps1-1.cs.tu-berlin.de](http://support.ntp.org/bin/view/Servers/PublicTimeServer000213)
 - [ntp.ix.ru](http://support.ntp.org/bin/view/Servers/PublicTimeServer000766)

Список рекомендуемых серверов может меняться. О том, что вам нужно внести изменения в конфигурацию ВМ, Яндекс.Облако сообщит за 72 часа.

## Порядок настройки {#setup}

{% list tabs %}

- Linux (systemd)

  {% note alert %}

  Сервис `systemd-timesyncd` может конфликтовать с сервисом `ntpd`, если они запущены одновременно. Вы можете либо удалить сервис `ntpd`, либо настроить синхронизацию времени с его помощью (на соседней вкладке).

  {% endnote %}

  Укажите запасные серверы в настройках системы:

  1. Перечислите запасные серверы в файле `/etc/systemd/timesyncd.conf`, в секции `[Time]` в параметре `FallbackNTP=`, например:
     ```
     FallbackNTP=ntp0.NL.net clock.isc.org ntp2.vniiftri.ru ntps1-0.eecsit.tu-berlin.de ntp.ix.ru
     ```
  1. Установите параметр `UseNTP=true` в конфигурационном файле сервиса `systemd.network`, обычно расположенном в каталоге `/etc/systemd/network` или `/var/lib/systemd/network`.
  1. Перезапустите сервис синхронизации:
     ```
     $ sudo systemctl restart systemd-timesyncd
     ```

- Linux (ntpd)

  Укажите адреса нужных серверов в конфигурации `ntpd`:

  1. Укажите адреса рекомендуемых серверов в файле `/etc/ntp.conf`. Адреса серверов по умолчанию закомментируйте символом <q>#</q> в начале строки, например:
     ```
     # Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
     # on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
     # more information.
     # server 0.ubuntu.pool.ntp.org
     # server 1.ubuntu.pool.ntp.org
     # server 2.ubuntu.pool.ntp.org
     # server 3.ubuntu.pool.ntp.org
     server ntp0.NL.net
     server clock.isc.org
     server ntp2.vniiftri.ru
     server ntps1-0.eecsit.tu-berlin.de
     server ntp.ix.ru
     ```
  2. Перезапустите сервис:

     ```
     $ sudo service ntp restart
     ```

- Windows Server

  Укажите рекомендуемые серверы в настройках сервиса Windows Time, последовательно выполнив следующие команды в PowerShell или `cmd`:

  ```
  net stop w32time
  w32tm /config /syncfromflags:manual /manualpeerlist:"ntp0.NL.net clock.isc.org ntp2.vniiftri.ru ntps1-0.eecsit.tu-berlin.de ntp.ix.ru"
  w32tm /config /reliable:yes
  net start w32time
  ```

{% endlist%}

