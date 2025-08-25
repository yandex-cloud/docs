# Restrictions in {{ baremetal-name }} networks

There is a number of restrictions in {{ baremetal-name }} networks.

## MAC addresses {#mac-addresses}

If you need more MAC addresses per port, contact [support]({{ link-console-support }}) and describe the tasks that require the change.

Type of limit | Quantity
--- | ---
MAC addresses per port | 5

## MTU and MSS {#mtu-mss}

The following MTU and MSS limits apply to the service:

Type of limit | Value, bytes
--- | ---
MTU in public network | 1500
MSS in public network | 1460
MTU in private network | 8910
MSS in private network | 8870

## Bandwidth {#bandwidth}

Public networks have a 1 Gbps bandwidth limit for all servers, including those with 1 Gbps NICs and servers with [MC-LAG](./mc-lag.md) aggregation groups.

Type of limit | Value, Gbps
--- | ---
Bandwidth in public network | 1 

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