{% note info %}

For clusters in the `RAPID` [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md), you can use [multiple pod IP address ranges](../../managed-kubernetes/concepts/cluster-multi-cidr.md). Add the CIDRs according to the [requirements](../../managed-kubernetes/concepts/cluster-multi-cidr.md#requirements) and then [configure IP address masquerading](../../managed-kubernetes/operations/network/manage-ip-masq-agent.md).

You can only add new CIDR ranges. You cannot edit or delete the existing ranges.

{% endnote %}
