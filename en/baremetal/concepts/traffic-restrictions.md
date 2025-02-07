---
title: Blocked network ports in {{ baremetal-full-name }}
description: The article provides a list of TCP and UDP ports. The network traffic is blocked on these ports when routing data between private {{ baremetal-full-name }} networks and the internet.
---

# Blocked network ports

The routers the {{ baremetal-name }} servers use to access the internet limit the incoming internet traffic to public server addresses on some TCP and UDP ports, as well as the outgoing SMTP traffic. By blocking these ports you can protect the {{ baremetal-full-name }} infrastructure against malicious networking traffic.

{% list tabs %}

- Incoming traffic

  **Port** | **Application layer protocol** | **Transport protocol**
  --- | --- | ---
  `17` | QOTD | TCP, UDP
  `23` | Telnet | TCP
  `67–68` | DHCP | UDP
  `111` | SUNRPC | UDP
  `135–139` | NetBIOS | TCP, UDP
  `389` | LDAP | TCP, UDP
  `427` | SLP | TCP, UDP
  `445` | SMB | TCP, UDP
  `513` | rlogin | TCP
  `520` | RIP | UDP
  `631` | IPP | TCP, UDP
  `646` | LDP | TCP, UDP
  `750` | Kerberos-IV | UDP
  `1900` | SSDP | UDP
  `3702` | WSD | UDP
  `11211` | memcached | UDP

  If the port you need is not in the table, use the [Nmap](https://en.wikipedia.org/wiki/Nmap) utility to check if it is available on the {{ baremetal-name }} server OS side.

- Egress

  **Port** | **Application layer protocol** | **Transport protocol**
  --- | --- | ---
  `25` | SMTP^1^ | TCP

  ^1^ SMTP traffic is blocked to avoid unauthorized newsletters. We recommend using [{{ postbox-full-name }}](../../postbox/concepts/index.md) as an alternative for newsletters.

{% endlist %}

#### See also {#see-also}

* [{#T}](./network.md)