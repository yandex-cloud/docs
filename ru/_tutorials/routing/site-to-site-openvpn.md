# Создание туннеля между двумя подсетями при помощи OpenVPN Access Server

При размещении вычислительных ресурсов в публичном облаке часто возникает потребность в безопасном соединении между двумя различными подсетями, например офисной сетью и тестовой фермой в облаке {{ yandex-cloud }}. Основным решением для подобных задач выступает [VPN](../../glossary/vpn.md), чтобы:

* объединить территориально удаленные сети;
* подключить внештатных сотрудников к офисной сети;
* организовать соединение с шифрованием поверх открытой сети Wi-Fi.

На этой странице рассказано, как организовать VPN-туннель с использованием технологии OpenVPN.

ПО [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) совместимо с [открытой версией](https://github.com/OpenVPN) OpenVPN и построено на ее основе. Продукт предоставляет клиенты для Windows, Mac, Android и iOS, а также позволяет управлять подключениями с помощью веб-интерфейса.

В примере туннель, объединяющий в одну сеть две разные подсети, организуется между двумя VPN-шлюзами, в качестве одного из которых выступает OpenVPN Access Server, а в качестве другого — машина с клиентом OpenVPN. Для тестирования работы VPN-туннеля необходимо настроить шлюзы на обеих сторонах туннеля. В примере рассмотрим случай, когда одна подсеть находится в облаке {{ yandex-cloud }}. Другая подсеть может находиться как в {{ yandex-cloud }}, так и во внешней сети.

Чтобы создать туннель между двумя различными подсетями:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте подсети и тестовые ВМ](#create-environment).
1. [Запустите сервер VPN](#create-vpn-server).
1. [Создайте пользователя OpenVPN для туннеля](#configure-openvpn).
1. [Настройте шлюз второй подсети для доступа к серверу OpenVPN](#configure-second-end-of-the-tunnel).
1. [Проверьте работу туннеля](#test-vpn-tunnel).

Если сервер VPN больше не нужен, [удалите созданные ВМ](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры OpenVPN входят:

* плата за диски и постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за лицензию OpenVPN Access Server (при использовании более двух подключений).


## Создайте подсети и тестовые ВМ {#create-environment}

Для связи облачных ресурсов с интернетом необходимо иметь созданные [сети](../../vpc/operations/network-create.md) и [подсети](../../vpc/operations/subnet-create.md). 

1. Создайте подсеть `ovpn-left` с диапазоном адресов `10.128.0.0/24`.
1. Создайте тестовую [виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) без публичного IP-адреса и подключите ее к подсети. При создании укажите имя `ao-openvpn-test` и внутренний IPv4-адрес `10.128.0.4`.
1. Создайте подсеть `ovpn-right` с диапазоном адресов `10.253.11.0/24`, с которой вы будете налаживать туннель. Также создайте машину `vm-ovpn-gw` и адресом `10.253.11.19` — она будет служить шлюзом туннеля. Создайте тестовую машину с именем `vm-ovpn-host` и внутренним адресом `10.253.11.110`, без публичного адреса.

## Запустите сервер VPN {#create-vpn-server}

В подсети `ovpn-left`:

1. [Создайте ВМ, которая будет шлюзом VPN-подключений](openvpn.md#create-vpn-server), с именем и адресом, например, `vpn-server` и `10.128.0.3`.
1. [Настройте разрешения сетевого трафика](openvpn.md#network-settings).
1. [Получите пароль администратора](openvpn.md#get-admin-password).

## Создайте пользователя OpenVPN для туннеля {#configure-openvpn}

OpenVPN Access Server предоставляет два веб-интерфейса:

1. Client Web UI по адресу `https://<публичный IP-адрес ВМ>:943/`. Интерфейс предназначен для входа обычных пользователей, скачивания клиентских программ и профилей конфигурации.
1. Admin Web UI по адресу `https://<публичный IP-адрес ВМ>:943/admin/`. Интерфейс предназначен для настройки сервера.

{% note info %}

По умолчанию на сервер установлен самоподписанный сертификат. Если вам необходимо поменять сертификат, воспользуйтесь [инструкцией](https://openvpn.net/vpn-server-resources/installing-a-valid-ssl-web-certificate-in-access-server/).

{% endnote %}

После того, как на виртуальной машине в облаке {{ yandex-cloud }}, которая будет выполнять функцию шлюза, будет развернут OpenVPN Access Server, у вас будут конкретные адреса и учетные записи следующего вида (ваши IP-адреса могут быть другими):

1. Внутренний IP шлюза `vpn-server`: `10.128.0.3`
1. Публичный IP машины `vpn-server`: `<публичный IP-адрес ВМ>`
1. Admin Web UI: `https://<публичный IP-адрес ВМ>:943/admin`
1. учетная запись для доступа в Admin UI: `openvpn/<пароль администратора>`
1. Client Web UI: `https://<публичный IP-адрес ВМ>:943`

Создайте на сервере OpenVPN пользователя, от имени которого шлюз второй подсети будет осуществлять доступ к серверу OpenVPN для работы туннеля. Чтобы создать пользователя, войдите в административную панель Admin Web UI:

1. Откройте в браузере адрес `https://<публичный IP-адрес ВМ>:943/admin`.
1. Введите имя пользователя `openvpn` и пароль (см. раздел [про получение пароля администратора](#get-admin-password)).
1. Нажмите кнопку **Agree**. Откроется главный экран административной панели OpenVPN.
1. Разверните вкладку **User management** и выберите пункт **User permissions**.
1. В списке пользователей введите имя нового пользователя в поле **New Username**, например `as-gw-user`.
1. Нажмите значок карандаша в столбце **More Settings** и в поле **Local Password** введите пароль нового пользователя.
1. В поле **Access Control** выберите **User Routing** и укажите текущую локальную подсеть, в которой установлен сервер OpenVPN Access Server, например `10.128.0.0/24`.
1. В поле **VPN Gateway** выберите **Yes** и укажите другую локальную подсеть, к которой нужно прокинуть туннель, например `10.253.11.0/24`.
1. Нажмите кнопку **Save settings**.
1. Нажмите кнопку **Update running server**.
1. Зайдите в панель пользователя под новым аккаунтом `as-gw-user`, сохраните профиль подключения в файле `as-gw-user.conf` и перенесите этот файл на виртуальную машину, которая будет служить шлюзом для туннеля OpenVPN в другой подсети.

## Настройте шлюз второй подсети для доступа к серверу OpenVPN {#configure-second-end-of-the-tunnel}

В консоли машины `vm-ovpn-gw` выполните следующие команды:

```
sudo apt update
sudo apt install openvpn
cp as-gw-user.conf /etc/openvpn/client/
echo -e "as-gw-user\n<пароль>" > /etc/openvpn/client/param.txt
```

После этого в папке `/etc/openvpn/client/`должен появиться файл `param.txt`, и туда же скопируйте созданный ранее файл конфигурации `as-gw-user.conf` пользователя OpenVPN, созданного для организации туннеля:

```
ls -lh /etc/openvpn/client/
```

Результат:

```
total 16K
-rw-rw-r-- 1 root root 9.7K Nov 10 14:37 as-gw-user.conf
-rw-r--r-- 1 root root 24 Nov 10 14:31 param.txt    
```

В файле `/etc/openvpn/as-gw-user.conf` в строке с `auth-user-pass` укажите имя файла `param.txt`:

```
dev tun
dev-type tun
remote-version-min 1.2
reneg-seq 604800
auth-user-pass param.txt
verb 3
push-peer-info
```

Выполните команды:

```
sudo systemctl enable openvpn-client@as-gw-user
sudo systemctl start openvpn-client@as-gw-user
sudo systemctl status openvpn-client@as-gw-user
```

Результат должен выглядеть примерно так:

```
● openvpn-client@as-gw-user.service - OpenVPN tunnel for as/gw/user
    Loaded: loaded (/lib/systemd/system/openvpn-client@.service; enabled; vendor preset:
enabled)
    Active: active (running) since Fri 2022-11-11 20:12:49 UTC; 1h 6min ago
        Docs: man:openvpn(8)
            https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
            https://community.openvpn.net/openvpn/wiki/HOWTO
    Main PID: 2626 (openvpn)
    Status: "Initialization Sequence Completed"
        Tasks: 1 (limit: 2237)
    Memory: 2.0M
        CPU: 157ms
    CGroup: /system.slice/system-openvpn\x2dclient.slice/openvpn-client@as-gw-user.service
            └─2626 /usr/sbin/openvpn --suppress-timestamps --nobind --config as-gw-user.conf
```

Для включения пересылки пакетов от других хостов выполните команды:

```
vm-ovpn-gw:~$ sudo bash -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
vm-ovpn-gw:~$ sudo sysctl -p
```

Проверьте на шлюзе `vpn-server`, что есть маршрут до `10.253.11.0/24` :
    
```
vpn-server:~$ sudo ip route
```

Результат:
    
```
default via 10.128.0.1 dev eth0 proto dhcp src 10.128.0.3 metric 100
10.128.0.0/24 dev eth0 proto kernel scope link src 10.128.0.3
10.128.0.1 dev eth0 proto dhcp scope link src 10.128.0.3 metric 100
10.253.11.0/24 dev as0t2 proto static
172.27.224.0/22 dev as0t0 proto kernel scope link src 172.27.224.1
172.27.228.0/22 dev as0t1 proto kernel scope link src 172.27.228.1
172.27.232.0/22 dev as0t2 proto kernel scope link src 172.27.232.1
172.27.236.0/22 dev as0t3 proto kernel scope link src 172.27.236.1
```

Проверьте на машине `vm-ovpn-gw` маршрут до `10.128.0.0/24`:

```
sudo ip route
```

Результат:

```
default via 10.253.11.1 dev ens18 proto dhcp src 10.253.11.19 metric 100
10.128.0.0/24 via 172.27.232.1 dev tun0 metric 101
10.253.11.0/24 dev ens18 proto kernel scope link src 10.253.11.19 metric 100
10.253.11.1 dev ens18 proto dhcp scope link src 10.253.11.19 metric 100
172.27.224.0/20 via 172.27.232.1 dev tun0 metric 101
172.27.232.0/22 dev tun0 proto kernel scope link src 172.27.232.5
178.154.226.72 via 10.253.11.1 dev ens18
```

## Проверьте работу туннеля {#test-vpn-tunnel}

Для проверки работы туннеля вам потребуются описанные ранее тестовые машины, которые находятся в обеих подсетях и отличны от шлюзов туннеля.

Чтобы эти две машины могли передавать между собой данные, обе они должны видеть статические маршруты до другой подсети. На `ao-openvpn-test` — до `10.253.11.0/24`, а на `vm-ovpn-host` до `10.128.0.0/24`.

На `vm-ovpn-host` выполните команду:

```
sudo ip route add 10.128.0.0./24 via 10.253.11.19
```

На тестовой машине в облаке {{ yandex-cloud }} добавление статического маршрута внутри виртуальной машины не поможет. В облаке {{ yandex-cloud }} статические маршруты для виртуальных машин нужно указывать [иначе](../../vpc/concepts/static-routes.md).

В облаке {{ yandex-cloud }} виртуальные машины `ao-openvpn-as` (сервер OpenVPN) и `ao-openvpn-test` находятся в одной подсети `default`. В настройках этой подсети добавьте статический маршрут с такими параметрами:
    
```
Name: office-net
Prefix: 10.253.11.0/24
Next hop: 10.128.0.3
```

Чтобы этот статический маршрут применился к виртуальной машине `ao-openvpn-test`, выключите и включите ее.

Теперь с машины `vm-ovpn-host` проверьте туннель командой `ping` до другой тестовой машины:
    
```
ping 10.128.0.4
```

Результат:
    
```
PING 10.128.0.4 (10.128.0.4) 56(84) bytes of data.
64 bytes from 10.128.0.4: icmp_seq=1 ttl=61 time=7.45 ms
64 bytes from 10.128.0.4: icmp_seq=2 ttl=61 time=5.61 ms
64 bytes from 10.128.0.4: icmp_seq=3 ttl=61 time=5.65 ms
^C
--- 10.128.0.4 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 5.613/6.235/7.446/0.855 ms
```

И с другой стороны туннеля, с тестовой машины `ao-openvpn-test`:

```
ping 10.253.11.110
```

Результат:
    
```
PING 10.253.11.110 (10.253.11.110) 56(84) bytes of data.
64 bytes from 10.253.11.110: icmp_seq=1 ttl=61 time=6.23 ms
64 bytes from 10.253.11.110: icmp_seq=2 ttl=61 time=5.90 ms
64 bytes from 10.253.11.110: icmp_seq=3 ttl=61 time=6.09 ms
64 bytes from 10.253.11.110: icmp_seq=4 ttl=61 time=5.69 ms
^C
--- 10.253.11.110 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 5.688/5.976/6.229/0.203 ms
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы освободить ресурсы в каталоге, [удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `vpn-server` и тестовую ВМ.

Если вы зарезервировали публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).

#### См. также {#see-also}

* [OpenVPN Project Wiki](https://community.openvpn.net/openvpn/wiki)
* [{#T}](../../certificate-manager/operations/managed/cert-get-content.md)
* [Connecting to Access Server](https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-linux/#openvpn-open-source-openvpn-cli-program)
