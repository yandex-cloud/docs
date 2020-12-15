# DHCP settings

Using DHCP settings, in a subnet, you can use the same DNS and NTP servers that are used in your corporate network infrastructure, which is accessible via VPN or [{{ interconnect-name }}](../interconnect/index.md). DHCP settings also allow you to assign a domain name or DNS suffix, which will be added to VM names in the subnet. If you specify DHCP settings for an existing subnet, they are applied to VMs in this subnet after you reboot the VMs.

You can set the following parameters:

* The domain name to be added to the VM name.
* DNS server addresses.
* NTP server addresses.

Changing DHCP settings may prevent VMs from accessing managed database services. To avoid that, you can:

* In DHCP settings, specify the second address from the subnet (`x.x.x.2`) as the default DNS server.
* Specify the default DNS server address as the DNS forwarder for the `*.mdb.yandexcloud.net` zone on the DNS server in your network.

## NTP settings in Windows {#ntp-windows}

By default, Windows doesn't use NTP settings pushed over DHCP and uses either its own time synchronization servers or those specified by the administrator if the VM is added to the domain. [You can manually change settings](https://docs.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings) using the W32Time service.