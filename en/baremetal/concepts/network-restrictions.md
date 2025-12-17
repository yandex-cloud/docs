# Restrictions in {{ baremetal-name }} networks

There is a number of restrictions in {{ baremetal-name }} networks.

## MAC addresses {#mac-addresses}

Type of limit | Quantity
--- | ---
MAC addresses per port | 5

The limit on the number of MAC addresses is set separately for network interface of each server. If you need a larger number of MAC addresses, create a request to [support]({{ link-console-support }}), specifying the servers for which you need to increase the limit.

{% cut "Request template" %}

```text
Subject: [BareMetal] Changing limits on the number of MAC addresses

Request text:
Please change the limits on the number of MAC addresses for the following servers.

servers:
  - id: "ly5ckajdi38d********"
    mac_addresses: ["aa:bb:cc:dd:ee:ff"]
  - id: "ly5fy37fir9s********"
    mac_addresses: ["aa:bb:cc:dd:ee:fd", "aa:bb:cc:dd:ee:fc"]
mac_limit: 10
```

{% endcut %}

{% note info %}

Network ports with the connection speed of 1 Gbps do not support increasing the number of MAC addresses beyond the set limit.

{% endnote %}

## MTU and MSS {#mtu-mss}

The following MTU and MSS limits apply to the service:

Type of limit | Value, bytes
--- | ---
MTU in public network | 1500
MSS in public network | 1460
MTU in private network | 8910
MSS in private network | 8870

## Bandwidth {#bandwidth}

### Bandwidth model in a public network {#bandwidth-for-pubic-network}

{% include [public-net-bandwidth-restrictions](../../_includes/baremetal/public-net-bandwidth-restrictions.md) %}

To increase bandwidth, [update](../operations/servers/server-update.md) the server configuration by activating a bandwidth package with daily billing:

Data amount, TB per day | Connection capacity, Gbps | Note
--- | --- | ---
100 | 10 | You can use this package only for servers with 10 and 25 Gbps NICs.

[Billing for increased bandwidth](../../baremetal/pricing.md#bandwidth-package).

### Bandwidth between Baremetal and VPC {#bandwidth-bm-vpc}

You can [set up a connection between {{ baremetal-name }} and {{ vpc-name }}](../tutorials/bm-vrf-and-vpc-interconnect.md) within the same region.

This connection has a default bandwidth limit of 10 Gbps for each user, regardless of the number of servers and their network card types. To request for a higher bandwidth, contact [support]({{ link-console-support }}).

## Storm Control {#storm-control}

The service is subject to the following broadcast traffic limits:

Type of limit | Value,</br>packets per second (pps)
--- | ---
Broadcast | 100
UnknownUnicast | 100
Multicast | 100

## Blocked network ports {#blocked-ports}

The routers connecting {{ baremetal-name }} servers to the internet limit the incoming internet traffic to public server addresses on some TCP and UDP ports as well as the outgoing SMTP traffic. By blocking these ports you can protect the {{ baremetal-full-name }} infrastructure against malicious networking traffic.

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

- Outgoing traffic

  **Port** | **Application layer protocol** | **Transport protocol**
  --- | --- | ---
  `25` | SMTP^1^ | TCP

  ^1^ SMTP traffic is blocked to avoid unauthorized newsletters. We recommend using [{{ postbox-full-name }}](../../postbox/concepts/index.md) as an alternative for newsletters.

{% endlist %}
