# Network and DB clusters {{ mrd-short-name }}

When creating a cluster, you can:

- Set the network for the cluster itself.
- Set the subnets for each host in the cluster.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

{% if audience != "internal" %}

## Network access to a cluster {{ mrd-short-name }} {#network-access-to-a-cluster}

You can only connect to a {{ RD }} cluster from a Yandex.Cloud virtual machine instance that's in the same network as the cluster. You cannot get a public IP address for a host in this type of cluster.

{% endif %}

## Hostname and FQDN {#hostname}

{{ mrd-short-name }} generates a name for each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network.

{% endif %}

