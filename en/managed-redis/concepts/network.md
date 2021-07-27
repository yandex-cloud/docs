---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# {{ mrd-short-name }} network and DB clusters


When creating a cluster, you can:

- Set the network for the cluster itself.
- Set the subnets for each host in the cluster.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

## Network access to a {{ mrd-short-name }} cluster {#network-access-to-a-cluster}

You can only connect to a {{ RD }} cluster from a {{ yandex-cloud }} VM instance that's in the same network as the cluster. You cannot get a public IP address for a host in this type of cluster.

## Hostname and FQDN {#hostname}

{{ mrd-short-name }} generates a name for each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.


You can use the FQDN to access the host within a single cloud network.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, be sure to [configure](../operations/connect.md#configuring-security-groups) security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

