---
title: DHCP settings
description: DHCP settings allow you to assign a domain name or DNS suffix, which will be allowed by the specified DNS server. If you specify DHCP settings for an existing subnet, they will be applied to VMs in this subnet after you reboot them. By using DHCP settings, you can use the same DNS and NTP servers in the subnet.
keywords:
  - dhcp
  - dhcp settings
---

# DHCP settings

Using DHCP settings, you can configure the same DNS and NTP servers in your [subnet](../../vpc/concepts/network.md#subnet) used in your corporate network infrastructure which is accessible via a VPN or [{{ interconnect-full-name }}](../../interconnect/concepts/index.md). DHCP settings also allow you to assign a domain name or DNS suffix, which will be allowed by the specified DNS server.

You can set the following parameters:
* DNS domain to search for unqualified names. It is commonly used with the DNS server address to simplify access to resources in an enterprise infrastructure. This option does not affect the name assigned to the VM in {{ yandex-cloud }}.
* DNS server addresses.
* NTP server addresses.

Changing DHCP settings may prevent VMs from accessing managed database services. To avoid that, you can:
* In DHCP settings, specify the second address from the dedicated subnet (`x.x.x.2`) as the default DNS server.
* Specify the default DNS server address as the DNS forwarder for the `*.{{ dns-zone }}` zone on your [network](../concepts/network.md#network)'s DNS server.

If you specify DHCP settings for an existing subnet with running {{ k8s }} [virtual machines](../../compute/concepts/vm.md) or nodes, they will apply to these {{ k8s }} VMs or nodes after you reboot them.

To avoid rebooting the {{ k8s }} VM and node after changing DHCP settings in the subnet, request a new DHCP lease. To do this, run the following command in the {{ k8s }} VM or node OS:

```bash
sudo netplan apply
```

Check the settings update. For example, to view the current list of DNS servers, run the following command:

```bash
sudo netplan ip leases eth0 | grep -i dns
```