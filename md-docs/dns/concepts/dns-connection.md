[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > [Концепции](index.md) > DNS-подключения

# DNS-подключения

Для разрешения [FQDN](../../glossary/fqdn.md) в [облачных сетях](../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud обычно используется облачный [DNS-резолвер](dns-resolver.md), который обрабатывает DNS-запросы, поступающие от облачных ресурсов. DNS-резолвер доступен для использования только изнутри виртуальных машин и его нельзя использовать за пределами ВМ.

При этом вы можете настроить интеграцию ваших корпоративных DNS-сервисов с [внутренними DNS-зонами](dns-zone.md#private-zones) в Yandex Cloud с помощью DNS-подключений. В настоящее время доступен только один тип DNS-подключений — [входящие DNS-подключения](#dns-inbound) (Inbound DNS endpoints).

{% note info %}

Чтобы [настроить интеграцию](../tutorials/dns-integration.md) корпоративных DNS-сервисов с DNS-сервисами внутри Yandex Cloud, ваша корпоративная сеть должна быть связана с облачной сетью при помощи ресурсов сервиса [Yandex Cloud Interconnect](../../interconnect/index.md).

{% endnote %}

## Входящее DNS-подключение {#dns-inbound}

_Входящее DNS-подключение_ — это специальный ресурс Yandex Cloud DNS, создаваемый в облачной сети и позволяющий использовать облачный DNS-резолвер для разрешения доменных имен в облачной сети и ее подсетях извне Yandex Cloud. Для этого корпоративные DNS-серверы должны отправлять DNS-запросы к [внутренним DNS-зонам](dns-zone.md#private-zones) Yandex Cloud на IP-адрес входящего DNS-подключения.

Для приема DNS-запросов входящее подключение использует [внутренний](../../vpc/concepts/address.md#internal-addresses) IP-адрес, [зарезервированный](../../vpc/operations/private-ip-reserve.md) в любой из подсетей облачной сети.

{% note info %}

В каждой облачной сети Virtual Private Cloud можно создать только одно входящее DNS-подключение.

{% endnote %}

#### Полезные ссылки {#see-also}

* [DNS-резолвер](dns-resolver.md)
* [Зоны DNS](dns-zone.md)
* [Создать входящее DNS-подключение](../operations/connection-inbound-create.md)
* [Обзор Cloud Interconnect](../../interconnect/concepts/index.md)
* [Разрешение облачных DNS-имен в корпоративной сети](../tutorials/dns-integration.md)
* [Запустили Yandex Cloud Router, обновили Yandex Virtual Private Cloud и Yandex Cloud DNS](https://yandex.cloud/ru/blog/yandex-cloud-router)