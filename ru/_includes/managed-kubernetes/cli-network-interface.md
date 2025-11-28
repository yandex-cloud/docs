* `security-group-ids` — идентификаторы [групп безопасности](../../managed-kubernetes/operations/connect/security-groups.md).
* `subnets` — имена подсетей, в которых будут размещаться узлы.
* `ipv4-address` — способ назначения IPv4-адреса.
* `ipv6-address` — способ назначения IPv6-адреса.

Параметры `ipv4-address` и `ipv6-address` отвечают за способ назначения IP-адреса:
* `auto` — узлу будет присвоен только внутренний IP-адрес.
* `nat` — узлу будут присвоены публичный и внутренний IP-адреса.

{% note info %}

{% include [nodes-internet-access](nodes-internet-access.md) %}

{% include [nodes-internet-access-additional](nodes-internet-access-additional.md) %}

{% endnote %}