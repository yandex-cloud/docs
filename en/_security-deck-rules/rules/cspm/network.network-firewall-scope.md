### Security groups have no access rule that is too broad {#network-firewall-scope}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | network.network-firewall-scope ||
|#

#### Description

A security group lets you grant network access to absolutely any IP address on the internet as well as across all port ranges. A dangerous rule looks as follows:

* Port range: 0 to 65535 or empty.
* Protocol: Any or TCP/UDP.
* Source: CIDR.
* CIDR blocks: 0.0.0.0/0 (access from any IP address) or ::/0 (ipv6).

{% note warning %}

If no port range is set, it is considered that access is granted across all ports (0-65535).

{% endnote %}

Make sure to only allow access through the ports that your application requires to run and from the IPs to connect to your objects from.

#### Guides and solutions

* Delete the dangerous rule in each security group or edit it by specifying trusted IPs: <https://yandex.cloud/en/docs/vpc/operations/security-group-create>