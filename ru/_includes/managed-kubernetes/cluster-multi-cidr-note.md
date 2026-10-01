{% note info %}

Для кластеров в [релизном канале](../../managed-kubernetes/concepts/release-channels-and-updates.md) `RAPID` можно использовать [несколько диапазонов IP-адресов подов](../../managed-kubernetes/concepts/cluster-multi-cidr.md). Добавьте CIDR в соответствии с [требованиями](../../managed-kubernetes/concepts/cluster-multi-cidr.md#requirements), а после [настройте маскарадинг IP-адресов](../../managed-kubernetes/operations/network/manage-ip-masq-agent.md).

Можно только добавлять новые диапазоны CIDR. Изменять или удалять существующие диапазоны нельзя.

{% endnote %}
