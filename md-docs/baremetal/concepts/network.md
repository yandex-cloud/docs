# Сеть

Сетевая инфраструктура {{ baremetal-full-name }} включает публичные и приватные сети, которые обеспечивают связность серверов с интернетом и между собой.

![baremetal-network](../../_assets/baremetal/baremetal-network.svg)

## Публичная сеть {#public-network}

[Публичная сеть](public-network.md) — это сеть с доступом в интернет, к которой физически подключены все серверы. В публичной сети доступны [эфемерные](public-network.md#ephemeral-public-subnet) и [выделенные](public-network.md#public-subnet) публичные подсети.

Подробнее о публичной сети читайте в разделе [{#T}](public-network.md).

## Приватная сеть {#private-network}

[Приватная сеть](private-network.md) — это локальная сеть, к которой подключены все серверы одного [пула](servers.md#server-pools). В приватной сети доступны [приватные подсети](private-network.md#private-subnet), [виртуальные сегменты сети (VRF)](private-network.md#vrf-segment) и [приватные соединения с облачными сетями](private-network.md#private-connection-to-vpc).

Подробнее о приватной сети читайте в разделе [{#T}](private-network.md).

## MAC-адреса сетевых интерфейсов {#mac-addresses}

MAC-адреса сетевых интерфейсов сервера {{ baremetal-name }} вы можете [посмотреть](../operations/servers/get-info.md) на странице с информацией о сервере в блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}**.

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

Трафик, передаваемый из {{ vpc-full-name }} на публичные адреса сервиса {{ baremetal-full-name }}, классифицируется как исходящий трафик, и к нему применяются [правила тарификации {{ vpc-short-name }}](../../vpc/pricing.md#prices-traffic).

{% note info %}

Если вам необходимо передавать большие объемы данных между {{ vpc-full-name }} и {{ baremetal-full-name }}, используйте сервис [{{ interconnect-full-name }}](../../interconnect/index.md).

Трафик между приватными адресами {{ baremetal-full-name }} и {{ vpc-full-name }}, передаваемый в обоих направлениях через {{ interconnect-full-name }}, не тарифицируется.

{% endnote %}

### {{ objstorage-full-name }} {#storage-traffic}

Трафик, передаваемый между {{ baremetal-full-name }} и сервисом {{ objstorage-full-name }}, не тарифицируется независимо от направления, в соответствии с [правилами тарификации {{ objstorage-name }}](../../storage/pricing.md#prices-traffic).

### {{ backup-full-name }} {#backup-traffic}

Трафик, передаваемый между {{ baremetal-full-name }} и сервисом [{{ backup-full-name }}](../../backup/index.md), не тарифицируется.

#### См. также {#see-also}

* [{#T}](public-network.md)
* [{#T}](private-network.md)
* [{#T}](dhcp.md)
* [{#T}](mc-lag.md)
* [{#T}](network-restrictions.md)