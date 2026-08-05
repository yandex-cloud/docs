[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > [Концепции](index.md) > DNS-резолвер

# DNS-резолвер

_DNS-резолвер_ — это DNS-сервер в инфраструктуре Yandex Cloud, который отвечает за обработку DNS-запросов от ресурсов, подключенных к [подсетям](../../vpc/concepts/network.md#subnet) в [облачных сетях](../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud, и за разрешение доменных имен во [внутренних DNS-зонах](dns-zone.md#private-zones) в Yandex Cloud.

За DNS-резолвером всегда резервируется второй (с начала) IP-адрес диапазона адресов подсети (условно `x.x.x.2`).

При подключении [виртуальной машины](../../compute/concepts/vm.md) к подсети IP-адрес DNS-резолвера отправляется на ВМ по протоколу DHCP вместе с другими параметрами сетевого интерфейса. Внутри ВМ этот IP-адрес используется в качестве адреса DNS-сервера.

IP-связность между виртуальной машиной и DNS-резолвером обеспечивается с помощью специального компонента [VRouter-agent](../../vpc/concepts/network-overview.md#vrouter-agent), который доступен только изнутри ВМ и недоступен извне.

## Интеграция с корпоративными DNS-сервисами {#on-premise-integration}

{% note info %}

Чтобы [настроить интеграцию](../tutorials/dns-integration.md) корпоративных DNS-сервисов с DNS-сервисами внутри Yandex Cloud, ваша корпоративная сеть должна быть связана с облачной сетью при помощи ресурсов сервиса [Yandex Cloud Interconnect](../../interconnect/index.md).

{% endnote %}

Вы можете настроить интеграцию ваших корпоративных DNS-сервисов с внутренними DNS-зонами в Yandex Cloud.

Перенаправление DNS-запросов от ресурсов Yandex Cloud к ресурсам в корпоративных сетях можно настроить, создав в подсетях Virtual Private Cloud отдельные DNS-форвардеры (DNS forwarders). DNS-запросы от ресурсов в корпоративных сетях к ресурсам в подсетях Virtual Private Cloud обрабатываются [входящими DNS-подключениями](dns-connection.md#dns-inbound).

Подробнее о настройке интеграции корпоративных DNS-сервисов с DNS-сервисами внутри Yandex Cloud читайте в разделе [Разрешение облачных DNS-имен в корпоративной сети](../tutorials/dns-integration.md).

#### Полезные ссылки {#see-also}

* [DNS-подключения](dns-connection.md)
* [Зоны DNS](dns-zone.md)
* [Обзор Cloud Interconnect](../../interconnect/concepts/index.md)
* [Разрешение облачных DNS-имен в корпоративной сети](../tutorials/dns-integration.md)