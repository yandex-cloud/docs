---
title: DNS-резолверы в сетях {{ yandex-cloud }}
description: DNS-резолвер отвечает за обработку DNS-запросов от ресурсов, подключенных к подсетям в облачных сетях {{ vpc-full-name }}.
---

# DNS-резолвер

_DNS-резолвер_ — это DNS-сервер в инфраструктуре {{ yandex-cloud }}, который отвечает за обработку DNS-запросов от ресурсов, подключенных к [подсетям](../../vpc/concepts/network.md#subnet) в [облачных сетях](../../vpc/concepts/network.md#network) {{ vpc-full-name }}, и за разрешение доменных имен во [внутренних DNS-зонах](./dns-zone.md#private-zones) в {{ yandex-cloud }}.

За DNS-резолвером всегда резервируется второй (с начала) IP-адрес диапазона адресов подсети (условно `x.x.x.2`).

При подключении [виртуальной машины](../../compute/concepts/vm.md) к подсети IP-адрес DNS-резолвера отправляется на ВМ по протоколу DHCP вместе с другими параметрами сетевого интерфейса. Внутри ВМ этот IP-адрес используется в качестве адреса DNS-сервера.

IP-связность между виртуальной машиной и DNS-резолвером обеспечивается с помощью специального компонента [VRouter-agent](../../vpc/concepts/network-overview.md#vrouter-agent), который доступен только изнутри ВМ и недоступен извне.

## Интеграция с корпоративными DNS-сервисами {#on-premise-integration}

{% include [on-premise-integration-cic-notice](../../_includes/dns/on-premise-integration-cic-notice.md) %}

Вы можете настроить интеграцию ваших корпоративных DNS-сервисов с внутренними DNS-зонами в {{ yandex-cloud }}.

Перенаправление DNS-запросов от ресурсов {{ yandex-cloud }} к ресурсам в корпоративных сетях можно настроить, создав в подсетях {{ vpc-name }} отдельные DNS-форвардеры (DNS forwarders). DNS-запросы от ресурсов в корпоративных сетях к ресурсам в подсетях {{ vpc-name }} обрабатываются [входящими DNS-подключениями](./dns-connection.md#dns-inbound).

Подробнее о настройке интеграции корпоративных DNS-сервисов с DNS-сервисами внутри {{ yandex-cloud }} читайте в разделе [{#T}](../tutorials/dns-integration.md).

#### Полезные ссылки {#see-also}

* [{#T}](./dns-connection.md)
* [{#T}](./dns-zone.md)
* [{#T}](../../interconnect/concepts/index.md)
* [{#T}](../tutorials/dns-integration.md)
