# DB network and clusters

When creating a cluster, you can:

- Set the network for the cluster itself.
- Set the subnets for each host in the cluster.
- Request a public IP address to access the cluster from outside the Cloud.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

## Host name and FQDN {#hostname}

The name of each host in the cluster [!KEYREF mdb-short-name] is generated when it is being created. This name will be the host's fully qualified domain name (FQDN).

You can use the FQDN to access the host within a single cloud subnet. Read more in the [documentation on Yandex [!KEYREF vpc-short-name]](../../vpc/).

The host name and, consequently, the FQDN cannot be changed: to get a DB host with a different name, delete the old host from the cluster and create a new one.

## Host public IP address

Any host in the cluster can be accessed from outside Yandex.Cloud by its public IP address. You can request a public address only when creating a host. To make a host web-accessible, add a new host to the cluster.

When a host is deleted, the assigned public IP address is revoked.

