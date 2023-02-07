# Practical guidelines {{ vpc-name }}

* [Architecture and protection of a basic internet service](web-service.md)
{% if product == "cloud-il" %}* [DHCP settings for working with a corporate DNS server](dhcp-options.md){% endif %}
* [Routing through a NAT instance](nat-instance.md)
* [Creating an IPSec VPN tunnel](ipsec-vpn.md)
{% if product == "yandex-cloud" %}* [Installing a Cisco CSR 1000v virtual router](cisco.md){% endif %}
* [Installing a Mikrotik CHR virtual router](mikrotik.md)
* [Connecting to a cloud network using OpenVPN](openvpn.md)
* [Creating and configuring a UserGate gateway in proxy server mode](usergate-proxy.md)
{% if product == "yandex-cloud" %}* [Configuring networks for {{ dataproc-full-name }}](dataproc-nat-instance.md){% endif %}
