### Security groups have no access rule that is too broad {#network-firewall-scope}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | network.network-firewall-scope ||
|#

#### Description

A security group lets you grant network access to absolutely any IP address on the internet as well as across all port ranges. A dangerous rule looks as follows:

* Port range: 0 to 65535 or empty.
* Protocol: Any or TCP/UDP.
* Source: CIDR.
* CIDR blocks: 0.0.0.0/0 (access from any IP address) or ::/0 (ipv6).

{% note alert "**Warning**" %}

If no port range is set, it is considered that access is granted across all ports (0-65535).

{% endnote %}

Make sure to only allow access through the ports that your application requires to run and from the IPs to connect to your objects from.

**Risks if the rule is not followed:** An overly broad security group rule exposes all services running on the VM or resource to the entire internet. Attackers can scan and exploit any open port — including administrative interfaces, databases, or internal APIs — without needing to bypass any network-level control. This is one of the most common causes of cloud security incidents.

#### Instructions and solutions

* Delete the dangerous rule in each security group or [edit](https://yandex.cloud/en/docs/vpc/operations/security-group-create) it by specifying trusted IPs.
