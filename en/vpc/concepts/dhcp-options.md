---
title: "DHCP settings"
description: "DHCP settings allow you to assign a domain name or DNS suffix, which will be allowed by the specified DNS server. If you specify DHCP settings for an existing subnet, they will be applied to VMs in this subnet after you reboot them. By using DHCP settings, you can use the same DNS and NTP servers in the subnet."
keywords:
  - dhcp
  - dhcp settings
---

# DHCP settings

Using DHCP settings, you can configure the same DNS and NTP servers in your [subnet](../../vpc/concepts/network.md#subnet) used in your corporate network infrastructure which is accessible via a VPN or [{{ interconnect-full-name }}](../../interconnect/concepts/index.md). DHCP settings also allow you to assign a domain name or DNS suffix, which will be allowed by the specified DNS server. If you specify DHCP settings for an existing subnet, they will apply to [VMs](../../compute/concepts/vm.md) in this subnet after you reboot the VMs.

You can set the following parameters:
* DNS domain for searching unqualified names. It is commonly used with the DNS server address to simplify access to resources in an enterprise infrastructure. This option does not affect the name assigned to a VM in {{ yandex-cloud }}.
* DNS server addresses.
* NTP server addresses.

Changing DHCP settings may prevent VMs from accessing managed database services. To avoid that, you can:
* In DHCP settings, specify the second address from the dedicated subnet (`x.x.x.2`) as the default DNS server.
* Specify the default DNS server address as the DNS forwarder for the `*.{{ dns-zone }}` zone on the DNS server in your [network](../concepts/network.md#network).

