# Создание туннеля IPSec VPN

В сценарии рассматривается настройка IPSec-инстанса для передачи трафика от виртуальных машин {{ yandex-cloud }} в туннель IPSec VPN с использованием демона [strongSwan](https://www.strongswan.org/). 

В примере туннель настраивается между двумя VPN-шлюзами. Для тестирования работы VPN-туннеля вам потребуется настроить шлюзы на обеих сторонах туннеля. Для этого можно воспользоваться другой сетью в {{ yandex-cloud }} или вашей локальной сетью.

Чтобы настроить VPN-туннель:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте IPSec-инстанс](#create-ipsec-instance).
1. [Настройте IPSec](#create-ipsec-instance).
1. [Настройте статическую маршрутизацию в облачной сети](#configure-static-route).
1. [Настройте IPSec на втором шлюзе](#configure-another-gateway).
1. [Проверьте работу IPSec-туннеля](#test-vpn). 

Если IPSec-инстанс больше не нужен, [удалите его](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры IPSec VPN входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

{% endif %}

## Создайте сети и подсети {#before-you-begin}

Для связи облачных ресурсов с интернетом необходимо иметь созданные [сети](../../vpc/operations/network-create.md) и [подсети](../../vpc/operations/subnet-create.md).

## Создайте IPSec-инстанс {#create-ipsec-instance}

Создайте в {{ yandex-cloud }} виртуальную машину, которая будет служить шлюзом для IPSec-туннеля. 

1. Откройте ваш каталог и нажмите кнопку **Создать ресурс**. Выберите пункт **Виртуальная машина**.
1. Укажите имя виртуальной машины, например `ipsec-instance`.
1. Выберите зону доступности, где находится подсеть, к которой будет подключен IPSec-инстанс, и где уже находится тестовая ВМ.
1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите образ [IPSec-инстанс](/marketplace/products/yc/ipsec-instance-ubuntu).
1. В блоке **Сетевые настройки** выберите требуемую сеть, подсеть и назначьте ВМ публичный IP-адрес из списка или автоматически. 

   Используйте только статические публичные IP-адреса [из списка](https://cloud.yandex.ru/docs/vpc/operations/get-static-ip), или [сделайте](https://cloud.yandex.ru/docs/vpc/operations/set-static-ip) IP-адрес созданной машины статическим. Динамический IP-адрес может измениться после перезагрузки ВМ и туннель перестанет работать.
1. В поле **Доступ** укажите логин и SSH-ключ для доступа к ВМ.
1. Нажмите кнопку **Создать ВМ**.

## Настройте IPSec {#configure-ipsec}

Настройте шлюз с публичным IP-адресом и подсетью, который будет устанавливать IPSec-соединение с удаленным шлюзом. 

В примере ниже публичный IP-адрес шлюза будет `130.193.32.25`. За шлюзом будет находиться подсеть `10.128.0.0/24`. Этот шлюз будет устанавливать IPSec-соединение с удаленным шлюзом с IP-адресом `1.1.1.1`, за которым находится подсеть `192.168.0.0/24`.

1. Подключитесь к виртуальной машине по SSH:

   ```
   ssh 130.193.32.25
   ```

1. Откройте конфигурацию IPSec:

   ```
   sudo nano /etc/ipsec.conf
   ```

1. Приведите раздел `config setup` к следующему виду:

   ```
   config setup
           charondebug="all"
           uniqueids=yes
           strictcrlpolicy=no
   ```

1. Задайте следующие параметры тестового соединения: 

   * `leftid` — публичный IP-адрес IPSec-инстанса.
   * `leftsubnet` — CIDR подсети, к которой подключен IPSec-инстанс.
   * `right` — укажите публичный IP-адрес шлюза на другом конце VPN-туннеля.
   * `rightsubnet` — укажите CIDR подсети, к которой подключен VPN-шлюз на другом конце VPN-туннеля.
   * В параметрах `ike` и `esp` укажите алгоритмы шифрования, которые поддерживаются на удаленном шлюзе. Списки поддерживаемых алгоритмов шифрования см. на сайте strongSwan: [IKEv1](https://wiki.strongswan.org/projects/strongswan/wiki/IKEv1CipherSuites) и [IKEv2](https://wiki.strongswan.org/projects/strongswan/wiki/IKEv2CipherSuites). 
   * Остальные настройки укажите, консультируясь с [документацией strongSwan](https://wiki.strongswan.org/projects/strongswan/wiki) и учитывая настройки удаленного шлюза.
   
   Сохраните изменения и закройте файл.

   Должна получиться конфигурация вида:

   ```
   conn cloud-to-hq
         authby=secret
         left=%defaultroute
         leftid=130.193.32.25
         leftsubnet=10.128.0.0/24
         right=1.1.1.1
         rightsubnet=192.168.0.0/24
         ike=aes256-sha2_256-modp1024!
         esp=aes256-sha2_256!
         keyingtries=0
         ikelifetime=1h
         lifetime=8h
         dpddelay=30
         dpdtimeout=120
         dpdaction=restart
         auto=start
   ```

   {% note info %}

   Для повышения скорости передачи данных в туннеле можно использовать оптимизированные алгоритмы шифрования. Для этого добавьте в код выше следующие строки:

   ```
      keyexchange=ikev2
      ike=aes128gcm16-prfsha256-ecp256,aes256gcm16-prfsha384-ecp384!
      esp=aes128gcm16-ecp256,aes256gcm16-ecp384!
   ```

   Возможность использования оптимизированных алгоритмов шифрования зависит от реализации стека IPSEC на используемой вами платформе.

   {% endnote %}

1. Откройте файл `/etc/ipsec.secrets` и укажите в нем пароль для установки соединения:

   ```
   130.193.32.25 1.1.1.1 : PSK "<пароль>"
   ```

1. Перезапустите strongSwan:

   ```
   systemctl restart strongswan-starter
   ```

## Настройте статическую маршрутизацию {#configure-static-route}

Настройте маршрутизацию между IPSec-инстансом и заранее созданной виртуальной машиной без публичного IP-адреса.

Создайте таблицу маршрутизации и добавьте в нее [статические маршруты](../../vpc/concepts/static-routes.md): 

1. Откройте раздел **{{ vpc-name }}** в каталоге, где требуется создать статический маршрут.
1. Выберите сеть, в которой требуется создать таблицу маршрутизации.
1. Нажмите кнопку ![image](../../_assets/plus.svg)**Создать таблицу маршрутизации**.
1. Задайте имя таблицы маршрутизации.

   {% include [name-format](../../_includes/name-format.md) %}

1. Нажмите кнопку **Добавить маршрут**.
1. В открывшемся окне введите префикс подсети назначения на удаленной стороне, в примере это `192.168.0.0/24`.
1. В поле **Next hop** укажите внутренний IP-адрес IPSec-шлюза. Нажмите кнопку **Добавить**.
1. Нажмите кнопку **Создать таблицу маршрутизации**.

Чтобы использовать статические маршруты, необходимо привязать таблицу маршрутизации к подсети. Для этого:

1. В строке нужной подсети нажмите кнопку ![image](../../_assets/options.svg).
1. В открывшемся меню выберите пункт **Привязать таблицу маршрутизации**.
1. В открывшемся окне выберите созданную таблицу в списке.
1. Нажмите кнопку **Привязать**.

Созданный маршрут можно применять и к другим подсетям в той же сети.

## Настройте IPSec на другом шлюзе {#configure-another-gateway}

Для работы VPN-туннеля требуется настроить еще один шлюз IPSec VPN. Вы можете создать в своем каталоге еще одну облачную сеть с подсетью и создать в ней IPSec-инстанс из образа, либо используйте в качестве шлюза машину в вашей локальной сети. 

1. Настройте strongSwan аналогично первому IPSec-шлюзу, но с зеркальными настройками IP-адресов и подсетей в файле `/etc/ipsec.conf`:

   ```
   conn hq-to-cloud
         authby=secret
         left=%defaultroute
         leftid=1.1.1.1
         leftsubnet=192.168.0.0/24
         right=130.193.32.25
         rightsubnet=10.128.0.0/24
         ike=aes256-sha2_256-modp1024!
         esp=aes256-sha2_256!
         keyingtries=0
         ikelifetime=1h
         lifetime=8h
         dpddelay=30
         dpdtimeout=120
         dpdaction=restart
         auto=start
    ```

   {% note info %}

   Для повышения скорости передачи данных в туннеле можно использовать оптимизированные алгоритмы шифрования. Для этого добавьте в код выше следующие строки:

   ```
      keyexchange=ikev2
      ike=aes128gcm16-prfsha256-ecp256,aes256gcm16-prfsha384-ecp384!
      esp=aes128gcm16-ecp256,aes256gcm16-ecp384!
   ```

   Возможность использования оптимизированных алгоритмов шифрования зависит от реализации стека IPSEC на используемой вами платформе.

   {% endnote %}

1. Укажите пароль для соединения в `/etc/ipsec.secrets`, указав IP-адреса шлюзов в обратном порядке:

   ```
   1.1.1.1 130.193.32.25 : PSK "<пароль>"
   ```

1. Перезапустите strongSwan:

   ```
   systemctl restart strongswan-starter
   ```

## Проверьте работу IPSec-туннеля {#test-vpn}

Чтобы убедиться, что туннель между шлюзами установлен, выполните на любом из шлюзов команду:

```
sudo ipsec status
Security Associations (1 up, 0 connecting):
 hq-to-cloud[3]: ESTABLISHED 29 minutes ago, 10.128.0.26[130.193.33.12]...192.168.0.23[1.1.1.1]
 hq-to-cloud{3}:  INSTALLED, TUNNEL, reqid 3, ESP in UDP SPIs: c7fa371d_i ce8b91ad_o
 hq-to-cloud{3}:   10.128.0.0/24 === 192.168.0.0/24
```

Статус `ESTABLISHED` означает, что туннель между шлюзами создан.

Проверить статус демона strongSwan можно командой `systemctl status strongswan-starter`:

```
systemctl status strongswan-starter
● strongswan.service - strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf
   Loaded: loaded (/lib/systemd/system/strongswan-starter.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2019-06-20 14:54:07 UTC; 3 days ago
 Main PID: 481 (starter)
    Tasks: 18 (limit: 1117)
   CGroup: /system.slice/strongswan-starter.service
           ├─481 /usr/lib/ipsec/starter --daemon charon --nofork
           └─527 /usr/lib/ipsec/charon
```           

Посмотреть логи strongSwan можно с помощью команды `journalctl -u strongswan-starter`. В логах находятся сведения об установке и работе соединения.

## Удалите созданные ресурсы {#clear-out}

Если вам больше не нужен IPSec-инстанс, [удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `ipsec-instance`.
