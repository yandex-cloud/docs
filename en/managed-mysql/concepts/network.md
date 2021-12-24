# DB network and clusters

{% if audience != "internal" %}

When creating a cluster, you can:

* Set the network for the cluster itself.
* Set the subnets for each host in the cluster.
* Request a public IP address to access the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

{% else %}

All clusters are created inside our network, which is [already accessible](../../mdb/access.md#network-access) from most networks and most employees. If you don't have access, request access to the macro `_PGAASINTERNALNETS_` in [Puncher](https://puncher.yandex-team.ru/). To connect to {{ MY }}, specify port 3306 in your request.

{% endif %}

## Hostname and FQDN {#hostname}

{{ mmy-short-name }} generates a name for each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network. Read more in the [{{ vpc-full-name }} documentation](../../vpc/).

### Special FQDNs {#special-fqdns}

Just like usual FQDNs that can be requested with a [list of cluster hosts](../operations/hosts.md#list), {{ mmy-name }} provides a number of special FQDNs that can also be used when connecting to a cluster.

#### Current master {#fqdn-master}

An FQDN in the format `c-<cluster ID>.rw.{{ dns-zone }}` always points to the current master host in the cluster.

{% include [Getting the Cluster ID](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

When connecting to this FQDN, both read and write operations are allowed.

An example of connecting to a master host for a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
mysql --host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      --port=3306 \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<username> \
      --password \
      <DB name>
```

#### The least lagging replica {#fqdn-replica}

An FQDN like `c-<cluster ID>.ro.{{ dns-zone }}` points to the [replica](../concepts/replication.md) that is least lagging from the master host. The cluster name can be requested with a [list of clusters in the folder](../operations/cluster-list.md#list-clusters).

**Specifics:**

* When connecting to this FQDN, only read operations are allowed.
* If there are no active replicas in the cluster, you can't connect to this FQDN: the corresponding CNAME record in the DNS will point to <q>nowhere</q> (`null`).

An example of connecting to the least lagging replica for a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
mysql --host=c-c9qash3nb1v9ulc8j9nm.ro.{{ dns-zone }} \
      --port=3306 \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<username> \
      --password \
      <DB name>
```

## Public access to a host {#public-access-to-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating the host. To connect to this kind of host, use its FQDN.

It is not possible to request a public address after creating a host, but you can replace one of the existing hosts with a new host that has a public address.

When deleting a host with a public FQDN, the assigned IP address is revoked.

{% endif %}

## Connecting to cluster hosts {#cluster-connect}

[You can connect to {{ mmy-short-name }} cluster hosts](../operations/connect.md):

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

The maximum number of connections is defined by the [max_connections](./settings-list.md#setting-max-connections) setting, which [depends on the host class](./settings-list.md#settings-instance-dependent).

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, be sure to [configure](../operations/connect.md#configure-security-groups) security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}
