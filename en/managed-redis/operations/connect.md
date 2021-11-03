# Connecting to a database in a {{ RD }} cluster

You can connect to a Redis database host:

* Without using encryption (for clusters running any {{ RD }} version):

    * Directly through port `6379`.

    * Using [{{ RD }} Sentinel](https://redis.io/topics/sentinel) through port `26379`. This is a {{ RD }} host management system that provides monitoring, notification, automatic failover, and reporting of up-to-date host addresses to the clients.

        Some {{ RD }} client applications do not support Sentinel connections but you can connect to the host directly. Note that you will need to track the roles of all the hosts yourself. If there is no need for a direct connection, use Sentinel for more reliable cluster host management.

* Using encryption (for clusters running {{ RD }} version 6 and higher [with SSL encryption enabled](cluster-create.md#create-cluster)).

   With connection encryption enabled, you can only connect directly to the {{ RD }} host through port `6380`. To connect to a non-sharded write cluster, we recommend using [special FQDNs](#special-fqdns).

## Connecting to clusters {#connect}

{{ RD }} cluster hosts can't be assigned public IPs. You can only access such hosts from within the same [cloud network](../../vpc/concepts/network.md) where the host is located.

To connect to the host of a {{ RD }} cluster:

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) with a public IP in the same virtual network as the host.
1. Connect to the created VM [via SSH](../../compute/operations/vm-connect/ssh.md) and then, from this VM, connect to {{ RD }} using one of the [sample connection strings](#connection-string).

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic from the VM's security group on port `6379` for direct connections or port `26379` for connections via Sentinel. If a cluster is created with SSL encryption support, you should only specify port `6380` (connections via Sentinel to this type of cluster are not supported). To do this, create the following rule for incoming traffic in these groups:
    * Protocol: `TCP`.
    * Port range: `6379` (`26379` for Sentinel) or only `6380` for a cluster with SSL encryption support.
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

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mrd-ide-envs.md) %}

You can only use graphical IDEs to connect to cluster hosts through an SSL tunnel using a [created VM](#connect). Before connecting, [prepare a certificate](#get-ssl-cert).

{% list tabs %}

- DBeaver

  Connections to {{ RD }} clusters are only available in [commercial versions of DBeaver](https://dbeaver.com/buy/).

  To connect to a cluster:
  1. Create a new DB connection:
     1. In the **Database** menu, select **New connection**.
     1. Select the **{{ RD }}** database from the list.
     1. Click **Next**.
     1. Specify the connection parameters on the **Main** tab:
        * **Host**: FQDN of the master host or a [special FQDN](#special-fqdns).
        * **Port**: `{{ port-mrd }}` for a conventional cluster, or `{{ port-mrd-tls }}` for a cluster with SSL encryption enabled.
        * Under **Authentication**, specify the cluster password.
     1. On the **SSH** tab:
        1. Enable the **Use SSL tunnel** setting.
        1. Specify the SSH tunnel parameters:
           * **Host/IP**: Public IP address of the [VM to connect to](#connect).
           * **Username**: Username for connecting to the VM.
           * **Authentication method**: `Public key`.
           * **Secret key**: Path to the file with the private key used for connecting to the VM.
           * **Passphrase**: Password of the private key.
     1. On the **SSL** tab:
        1. Enable the **Use SSL** and **Skip hostname validation** settings.
        1. Under **Method**:
           1. Enable the **Set of certificates** setting.
           1. In the **Root certificate** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
  1. Click **Test Connection ...** to test the DB connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the database connection settings.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mrd-connection-strings](../../_includes/mdb/mrd-conn-strings.md) %}

## Special FQDNs {#special-fqdns}

Just like usual FQDNs that can be requested with a [list of cluster hosts](hosts.md#list), {{ mrd-name }} provides special FQDNs that can only be used when connecting to a non-sharded cluster.

### Current master {#fqdn-master}

An FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` in a non-sharded cluster always points to the current master host. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

When connecting to this FQDN, both read and write operations are allowed.

An example an SSL-encrypted connection to a master host for a cluster with `c9qash3nb1v9ulc8j9nm` as the ID:

```bash
redis-cli -h c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      -p 6380 \
      --tls \
      --cacert ~/.redis/YandexInternalRootCA.crt \
      -a <{{ RD }} password>
```

