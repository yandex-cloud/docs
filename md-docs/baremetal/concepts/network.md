# Сеть

Сетевая инфраструктура Yandex BareMetal включает публичные и приватные сети, которые обеспечивают связность серверов с интернетом и между собой.

![baremetal-network](../../_assets/baremetal/baremetal-network.svg)

## Публичная сеть {#public-network}

[Публичная сеть](public-network.md) — это сеть с доступом в интернет, к которой физически подключены все серверы. В публичной сети доступны [эфемерные](public-network.md#ephemeral-public-subnet) и [выделенные](public-network.md#public-subnet) публичные подсети.

Подробнее о публичной сети читайте в разделе [Публичная сеть](public-network.md).

## Приватная сеть {#private-network}

[Приватная сеть](private-network.md) — это локальная сеть, к которой подключены все серверы одного [пула](servers.md#server-pools). В приватной сети доступны [приватные подсети](private-network.md#private-subnet), [виртуальные сегменты сети (VRF)](private-network.md#vrf-segment) и [приватные соединения с облачными сетями](private-network.md#private-connection-to-vpc).

Подробнее о приватной сети читайте в разделе [Приватная сеть](private-network.md).

## MAC-адреса сетевых интерфейсов {#mac-addresses}

MAC-адреса сетевых интерфейсов сервера BareMetal вы можете [посмотреть](../operations/servers/get-info.md) на странице с информацией о сервере в блоках **Публичная сеть** и **Приватная сеть**.

## Таблица маршрутизации сервера {#routing-table}

В операционной системе сервера BareMetal должна быть настроена [таблица маршрутизации](https://ru.wikipedia.org/wiki/Таблица_маршрутизации), устанавливающая маршруты для трафика одновременно в [публичной](#public-network) и [приватной](#private-network) сетях.

Особенности настройки таблицы маршрутизации зависят от используемой операционной системы, но основываться таблица маршрутизации сервера должна на следующем примере:

```text
0.0.0.0/0 via <сетевой_интерфейс_в_публичной_сети>
10.0.0.0/8 via <сетевой_интерфейс_в_приватной_сети>
172.16.0.0/12 via <сетевой_интерфейс_в_приватной_сети>
192.168.0.0/16 via <сетевой_интерфейс_в_приватной_сети>
```

## Особенности тарификации сетевого трафика в Yandex BareMetal при взаимодействии с другими сервисами Yandex Cloud {#traffic-pricing-pecs}

### Yandex Virtual Private Cloud {#vpc-traffic}

Трафик, передаваемый из Yandex Virtual Private Cloud на публичные адреса сервиса Yandex BareMetal, классифицируется как исходящий трафик, и к нему применяются [правила тарификации VPC](../../vpc/pricing.md#prices-traffic).

{% note info %}

Если вам необходимо передавать большие объемы данных между Yandex Virtual Private Cloud и Yandex BareMetal, используйте сервис [Yandex Cloud Interconnect](../../interconnect/index.md).

Трафик между приватными адресами Yandex BareMetal и Yandex Virtual Private Cloud, передаваемый в обоих направлениях через Yandex Cloud Interconnect, не тарифицируется.

{% endnote %}

### Yandex Object Storage {#storage-traffic}

Трафик, передаваемый между Yandex BareMetal и сервисом Yandex Object Storage, не тарифицируется независимо от направления, в соответствии с [правилами тарификации Object Storage](../../storage/pricing.md#prices-traffic).

### Yandex Cloud Backup {#backup-traffic}

Трафик, передаваемый между Yandex BareMetal и сервисом [Yandex Cloud Backup](../../backup/index.md), не тарифицируется.

#### См. также {#see-also}

* [Публичная сеть](public-network.md)
* [Приватная сеть](private-network.md)
* [Сервис DHCP в сети Yandex BareMetal](dhcp.md)
* [Резервирование сетевого подключения BareMetal с помощью технологии MC-LAG](mc-lag.md)
* [Ограничения в сетях BareMetal](network-restrictions.md)