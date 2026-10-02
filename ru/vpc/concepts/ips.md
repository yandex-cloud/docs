---
title: Диапазоны публичных IP-адресов {{ yandex-cloud }}
description: Диапазоны публичных IPv4-адресов ресурсов {{ yandex-cloud }}, подключенных к {{ vpc-name }}.
---

# Диапазоны публичных IP-адресов

Ниже приведены диапазоны публичных IPv4-адресов ресурсов {{ yandex-cloud }}, подключенных к {{ vpc-name }}. Эти диапазоны используются ресурсами разных сервисов и клиентов облака и не выделены под конкретный NAT-шлюз.


{% include [vpc-ip-ru](../../_includes/public-ip/ru/vpc-ipv4.md) %}



Примеры ресурсов, которым назначаются вышеуказанные диапазоны адресов:

* [Виртуальные машины {{ compute-name }}](../../compute/concepts/vm.md);
* [Хосты баз данных](../../managed-greenplum/qa/cluster-hosts.md#what-is-cluster);
* [NAT-инстансы](../tutorials/nat-instance/index.md);
* [NAT-шлюзы](./gateways.md);
* [Балансировщики нагрузки {{ network-load-balancer-name }}](../../network-load-balancer/concepts/index.md) и [{{ alb-name }}](../../application-load-balancer/concepts/application-load-balancer.md).

Полный список диапазонов публичных IP-адресов в {{ yandex-cloud }} находится на странице [{#T}](../../overview/concepts/public-ips.md) раздела **Обзор платформы**.

#### Полезные ссылки {#see-also}

* [Особенности публичных IP-адресов NAT-шлюзов](./gateways.md#nat-gateway)
