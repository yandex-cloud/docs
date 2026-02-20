---
title: Сеть в {{ baremetal-full-name }}
description: Из статьи вы узнаете про сетевую инфраструктуру {{ baremetal-full-name }}, включая публичные и приватные сети.
---

# Сеть

Сетевая инфраструктура {{ baremetal-full-name }} включает публичные и приватные сети, которые обеспечивают связность серверов с интернетом и между собой.

![baremetal-network](../../_assets/baremetal/baremetal-network.svg)

## Публичная сеть {#public-network}

[Публичная сеть](./public-network.md) — это сеть с доступом в интернет, к которой физически подключены все серверы. В публичной сети доступны [эфемерные](./public-network.md#ephemeral-public-subnet) и [выделенные](./public-network.md#public-subnet) публичные подсети.

Подробнее о публичной сети читайте в разделе [{#T}](./public-network.md).

## Приватная сеть {#private-network}

[Приватная сеть](./private-network.md) — это локальная сеть, к которой подключены все серверы одного [пула](./servers.md#server-pools). В приватной сети доступны [приватные подсети](./private-network.md#private-subnet), [виртуальные сегменты сети (VRF)](./private-network.md#vrf-segment) и [приватные соединения с облачными сетями](./private-network.md#private-connection-to-vpc).

Подробнее о приватной сети читайте в разделе [{#T}](./private-network.md).

## MAC-адреса сетевых интерфейсов {#mac-addresses}

MAC-адреса сетевых интерфейсов сервера {{ baremetal-name }} вы можете [посмотреть](../operations/servers/get-info.md) на странице с информацией о сервере в блоках **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** и **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}**.

## Таблица маршрутизации сервера {#routing-table}

В операционной системе сервера {{ baremetal-name }} должна быть настроена [таблица маршрутизации](https://ru.wikipedia.org/wiki/Таблица_маршрутизации), устанавливающая маршруты для трафика одновременно в [публичной](#public-network) и [приватной](#private-network) сетях.

Особенности настройки таблицы маршрутизации зависят от используемой операционной системы, но основываться таблица маршрутизации сервера должна на следующем примере:

```text
0.0.0.0/0 via <сетевой_интерфейс_в_публичной_сети>
10.0.0.0/8 via <сетевой_интерфейс_в_приватной_сети>
172.16.0.0/12 via <сетевой_интерфейс_в_приватной_сети>
192.168.0.0/16 via <сетевой_интерфейс_в_приватной_сети>
```

## Особенности тарификации сетевого трафика в {{ baremetal-full-name }} при взаимодействии с другими сервисами {{ yandex-cloud }} {#traffic-pricing-pecs}

### {{ vpc-full-name }} {#vpc-traffic}

{% include [bms-vpc-traffic](../../_includes/baremetal/bms-vpc-traffic.md) %}

### {{ objstorage-full-name }} {#storage-traffic}

{% include [bms-s3-free-traffic](../../_includes/baremetal/bms-s3-free-traffic.md) %}

### {{ backup-full-name }} {#backup-traffic}

{% include [bms-backup-free-traffic](../../_includes/baremetal/bms-backup-free-traffic.md) %}

#### См. также {#see-also}

* [{#T}](./public-network.md)
* [{#T}](./private-network.md)
* [{#T}](./dhcp.md)
* [{#T}](./mc-lag.md)
* [{#T}](./network-restrictions.md)