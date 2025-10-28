# Restrictions in {{ baremetal-name }} networks

There is a number of restrictions in {{ baremetal-name }} networks.

## MAC addresses {#mac-addresses}

If you need more MAC addresses per port, contact [support]({{ link-console-support }}) and describe the tasks that require the change.

Type of limit | Quantity
--- | ---
MAC addresses per port | 5

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

Data amount, TB per day | Connection capacity, Gbps
--- | ---
10 | 1 

{% note info %}

To request a bandwidth package of 100 TB, contact [support]({{ link-console-support }}).

{% endnote %}

To increase this amount, you can use a package with daily billing:

Data amount, TB per day | Connection capacity, Gbps | Note
--- | --- | ---
100 | 10 | You can use this package only for servers with 10 and 25 Gbps NICs.

[Billing for increased bandwidth](../../baremetal/pricing#bandwidth-package).

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
