* `security-group-ids` — идентификаторы [групп безопасности](../../managed-kubernetes/operations/connect/security-groups.md).
* `subnets` — имена подсетей, в которых будут размещаться узлы.
* `ipv4-address` — способ назначения IPv4-адресов.
* `ipv6-address` — способ назначения IPv6-адресов.

Параметры `ipv4-address` и `ipv6-address` отвечают за способ назначения IP-адресов:
* `auto` — узлам будут присвоены только внутренние IP-адреса.
* `nat` — узлам будут присвоены публичные и внутренние IP-адреса.

{% include [public-ip](public-ip.md) %}
