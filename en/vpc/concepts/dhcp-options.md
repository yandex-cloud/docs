---
title: DHCP settings
description: DHCP settings also allow you to assign a domain name or DNS suffix. If you specify DHCP settings for an existing subnet, they are applied to VMs in this subnet after you reboot the VMs. Using DHCP settings, in a subnet, you can use the same DNS and NTP servers that are used in your corporate network infrastructure.
keywords:
  - dhcp
  - dhcp settings
---

# DHCP settings

Using DHCP settings, in a subnet, you can use the same DNS and NTP servers that are used in your corporate network infrastructure, which is accessible via VPN{% if product == "yandex-cloud" %} or [{{ interconnect-name }}](../../interconnect/concepts/index.md){% endif %}. DHCP settings also allow you to assign a domain name or DNS suffix, which will be allowed by the specified DNS server. If you specify DHCP settings for an existing subnet, they are applied to VMs in this subnet after you reboot the VMs.

You can set the following parameters:
* DNS domain for searching unqualified names. Commonly used together with the DNS server address to simplify access to resources in the corporate infrastructure. This option doesn't affect the name assigned to an instance in {{ yandex-cloud }}.
* DNS server addresses.
* NTP server addresses.

Changing DHCP settings may prevent VMs from accessing managed database services. To avoid that, you can:
* In DHCP settings, specify the second address from the dedicated subnet (`x.x.x.2`) as the default DNS server.
* Specify the default DNS server address as the DNS forwarder for the `*.{{ dns-zone }}` zone on the DNS server in your network.


{% if product == "yandex-cloud" %}

## NTP settings in Windows {#ntp-windows}

By default, Windows doesn't use NTP settings pushed over DHCP and uses either its own time synchronization servers or those specified by the administrator if the VM is added to the domain. [You can manually change settings](https://docs.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings) using the W32Time service.

{% endif %}
