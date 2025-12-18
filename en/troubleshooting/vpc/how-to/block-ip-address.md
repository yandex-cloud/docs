# How to block an IP address


## Case description {#case-description}

You need to block external IP addresses or subnets so that they cannot access a specific {{ yandex-cloud }} resource, e.g., an MDB cluster or a single VM.

## Solution {#case-resolution}

You cannot block a single specific IP address from the {{ yandex-cloud }} side. Security groups operate based on the _what is not explicitly allowed is forbidden_ principle. This happens because the list of security group rules always implicitly ends with the _prohibit all_ rule.

You can allow trusted IP addresses, others will be considered untrusted. For more details about the security group structure, see [this article](../../../vpc/concepts/security-groups.md#security-groups-structure).

{% note tip %}

Alternatively, you can block an unwanted IP address using the UFW firewall or `iptables` inside your VM.

{% endnote %}