### Public IP addresses are not assigned to virtual machines {#compute-public-ip}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.compute-public-ip ||
|#

#### Description

{% note warning "**Manual verification**" %}

Make sure that the found virtual machines actually require a public IP address. Manually mark the control as completed.

{% endnote %}

Virtual machines with public IP addresses are accessible from the internet. It is recommended to use public IP addresses only for resources that require direct access from the internet (e.g., NAT instances or bastion hosts). For other resources, it is recommended to use private IP addresses and organize access through VPN or bastion hosts.

#### Guides and solutions

* Make sure that virtual machines with public IP addresses actually require direct internet access.
* For resources that do not require direct internet access, use private IP addresses.
* Organize access to resources with private IP addresses through VPN or bastion hosts.