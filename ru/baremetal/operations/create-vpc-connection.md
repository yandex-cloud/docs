---
title: Как создать приватное соединение с облачными сетями
description: Следуя данной инструкции, вы сможете создать приватное соединение между VRF {{ baremetal-full-name }} и облачными сетями {{ vpc-full-name }}.
---

# Создать приватное соединение с облачными сетями

С помощью [{{ interconnect-full-name }}](../../interconnect/index.yaml) вы можете создать [приватное соединение](../concepts/network.md#private-connection-to-vpc) между [подсетями](../concepts/network.md#private-subnet) {{ baremetal-name }} и [подсетями](../../vpc/concepts/network.md#subnet) {{ vpc-full-name }}.

{% note info %}

Прежде чем создавать приватное соединение, убедитесь, что в вашем каталоге есть [VRF](../../baremetal/concepts/network.md#vrf-segment) c одной или более маршрутизируемыми подсетями в {{ baremetal-name }}, а также Routing Instance, в составе которого [анонсированы](../../interconnect/concepts/priv-con.md#prc-announce) один или несколько префиксов приватных подсетей {{ vpc-short-name }}. [Заказать](../tutorials/bm-vrf-and-vpc-interconnect.md#request-ri) Routing Instance вы можете через [обращение]({{ link-console-support }}/tickets/create) в службу технической поддержки.

{% endnote %}

Чтобы создать приватное соединение:

{% include [create-private-connection](../../_includes/baremetal/create-private-connection.md) %}