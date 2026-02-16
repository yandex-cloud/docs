### Connection timed out error

The error occurs if the service is unable to establish a connection to the host within the specified timeout. The error may indicate network availability problems: the host is not responding or cannot be reached over the network.

**Possible solutions**:

1. Check host availability using the `ping` command (if ICMP is allowed) or `telnet <host> <port>` from a VM residing on the same network as the managed database cluster.

1. If you are connecting to {{ yandex-cloud }} resources, make sure your security group settings allow such a connection.

1. If you are connecting to a managed database cluster residing in another {{ yandex-cloud }}'s cloud, make sure the cluster allows public access.

1. If you are connecting to a host outside of {{ yandex-cloud }}, make sure it is publicly accessible or has a VPN/Interconnect configured.

1. If you are connecting to a custom installation, make sure that traffic is not blocked by network firewalls (on routers, in the cloud network) or local firewalls on the host.

1. Check the routing. If the source or target resides in a different subnet or cloud, make sure correct route tables are configured.
