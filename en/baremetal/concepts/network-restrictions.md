# Restrictions in {{ baremetal-name }} networks

There is a number of restrictions in {{ baremetal-name }} networks.

## MAC addresses {#mac-addresses}

If you need more MAC addresses per port, contact [support]({{ link-console-support }}) and describe the tasks that require the change.

Type of limit | Amount
--- | ---
MAC addresses per port | 5

## MTU and MSS {#mtu-mss}

The following MTU and MSS limits apply to the service:

Type of limit | Value, bytes
--- | ---
MTU in public network | 1,500
MSS in public network | 1,460
MTU in private network | 8,910
MSS in private network | 8,870

## Bandwidth {#bandwidth}

Public networks have a 1 Gbps bandwidth limit for all servers, including those with 10 Gbps NICs.

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