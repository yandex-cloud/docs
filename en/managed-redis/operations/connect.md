# Connecting to a database in a {{ RD }} cluster

## Connection methods {#connection-methods}

{{ RD }} cluster hosts can't be assigned public IPs. You can only access hosts from within the [virtual network](../../vpc/concepts/network.md) where the host is located.

Available connection options:

* Without using encryption (for clusters running any {{ RD }} version):

    * Using Sentinel through port `26379`.

        {{ RD }} Sentinel is a {{ RD }} host management system that provides monitoring, notification, automatic failover, and reporting of up-to-date host addresses to the clients. If a client application does not support connecting via Sentinel, connect directly to the {{ RD }} host.

    * Directly to the {{ RD }} host through port `6379`.

        If you always need to connect to the master host, you can either track the roles of all the cluster hosts yourself, or use a [special FQDN](#special-fqdns) that always points to the master host.

* Using encryption (for clusters running {{ RD }} version 6 and higher [with SSL encryption enabled](cluster-create.md#create-cluster)).

   With connection encryption enabled, you can only connect directly to the {{ RD }} host through port `6380`. To connect to a non-sharded write cluster, we recommend using [special FQDNs](#special-fqdns).

## Connecting to clusters {#connect}

To connect to the host of a {{ RD }} cluster:

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) with a public IP in the same virtual network as the host.
1. Connect to the created VM [via SSH](../../compute/operations/vm-connect/ssh.md) and then, from this VM, connect to {{ RD }} using one of the [sample connection strings](#connection-string).

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic from the VM's security group on port `6379` for direct connections or port `26379` for connections via Sentinel. If a cluster is created with SSL encryption enabled, you should only specify port `6380` (connections via Sentinel are not supported for these clusters). To do this, create the following rule for incoming traffic in these groups:
    * Protocol: `TCP`.
    * Port range: `6379` (`26379` for Sentinel) or only `6380` for a cluster that supports SSL encryption.
    * Source type: `Security group`.
    * Source: Security group assigned to the VM. If it is the same as the configured group, specify **Current**.

1. [Set up the security group](../../vpc/operations/security-group-update.md#add-rule) assigned to the VM to allow connections to the VM and traffic between the VM and the cluster hosts.

    Example of rules for a VM:

    * For incoming traffic:
        * Protocol: `TCP`.
        * Port range: `22`.
        * Source type: `CIDR`.
        * Source: `0.0.0.0/0`.

        This rule lets you connect to the VM over SSH.

    * For outgoing traffic:
        * Protocol: `Any`.
        * Port range: `0-65535`.
        * Destination type: `CIDR`.
        * Destination: `0.0.0.0/0`.

        This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% note info %}

You can set more detailed rules for security groups, such as to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If security group settings are incomplete or incorrect, you may lose access to the cluster if the master is switched [manually](failover.md) or [automatically](../concepts/replication.md).

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted SSL connection, get an SSL certificate:


```bash
sudo mkdir ~/.redis && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.redis/YandexInternalRootCA.crt && \
sudo chmod 655 ~/.redis/YandexInternalRootCA.crt
```

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mrd-connection-strings](../../_includes/mdb/mrd-conn-strings.md) %}

## Special FQDNs {#special-fqdns}

Just like usual FQDNs that can be requested with a [list of cluster hosts](hosts.md#list), {{ mrd-name }} provides special FQDNs that can only be used when connecting to a non-sharded cluster.

### Current master {#fqdn-master}

An FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` in a non-sharded cluster always points to the current master host. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

When connecting to this FQDN, both read and write operations are allowed.

An example of connecting to a master host with SSL encryption for a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
redis-cli -h c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      -p 6380 \
      --tls \
      --cacert ~/.redis/YandexInternalRootCA.crt \
      -a <{{ RD }} password>
```

