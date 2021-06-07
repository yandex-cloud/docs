# Connecting to a database in a {{ MY }} cluster

You can connect to {{ mmy-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note info %}

If public access is only configured for certain hosts in your cluster, automatic master change may make the master unavailable over the internet.

{% endnote %}

The maximum number of simultaneous connections to a {{ mmy-name }} cluster host is set by the `max_connections` parameter and by default is equal to `100 × <number of vCPU on the host> × <vCPU share on the host>`, but no less than `100`.

For example, for a [s1.micro](../concepts/instance-types.md) host with 2 vCPUs and a 100% share, the default value of the `max_connections` parameter is `200`: `100×2×1`.

## Configuring security groups {#configure-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

    [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port {{ port-mmy }} from any IP address. To do this, create the following rule for incoming traffic:
    - Protocol: `TCP`.
    - Port range: `{{ port-mmy }}`.
    - Source type: `CIDR`.
    - Source: `0.0.0.0/0`.

- With a VM in Yandex.Cloud

    1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port {{ port-mmy }} from the security group assigned to the VM. To do this, create the following rule for incoming traffic in these groups:
        - Protocol: `TCP`.
        - Port range: `{{ port-mmy }}`.
        - Source type: `Security group`.
        - Source: Security group assigned to the VM. If it is the same as the configured group, specify **Current**.

    1. [Set up the security group](../../vpc/operations/security-group-update.md#add-rule) assigned to the VM to allow connections to the VM and traffic between the VM and the cluster hosts.

        Example of rules for a VM:

        - For incoming traffic:
           - Protocol: `TCP`.
           - Port range: `{{ port-ssh }}`.
           - Source type: `CIDR`.
           - Source: `0.0.0.0/0`.

            This rule lets you connect to the VM over SSH.

        - For outgoing traffic:
            - Protocol: `Any`.
            - Port range: `{{ port-any }}`.
            - Destination type: `CIDR`.
            - Destination: `0.0.0.0/0`.

            This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

{% endlist %}

## Configuring an SSL certificate {#configuring-an-ssl-certificate}

{{ MY }} hosts with public access only support connections with an SSL certificate. You can prepare a certificate as follows:


```bash
mkdir ~/.mysql && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mysql/root.crt && \
chmod 0600 ~/.mysql/root.crt
```

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can connect to public {{ MY }} hosts only if you use an SSL certificate. Before connecting to such hosts, [prepare the certificate](#configuring-an-ssl-certificate).

These examples assume that the `root.crt` certificate is located in the ` /home/<home directory>/.mysql/` folder.

Connecting without an SSL certificate is only supported for hosts that are not publicly accessible. For connections to the database, traffic inside the virtual network isn't encrypted in this case.

You can connect to a cluster using both regular FQDN hosts and [special FQDNs](#special-fqdns).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mmy-connection-strings](../../_includes/mdb/mmy-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the {{ MY }} version is output.

## Special FQDNs {#special-fqdns}

Just like usual FQDNs, which can be requested with a [list of cluster hosts](hosts.md#list), {{ mmy-name }} provides a number of special FQDNs, which can also be used when connecting to a cluster.

### Current master {#fqdn-master}

An FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` always points to the current master host in the cluster. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

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

### The least lagging replica {#fqdn-replica}

An FQDN like `c-<cluster ID>.ro.{{ dns-zone }}` points to the [replica](../concepts/replication.md) that is least lagging from the master host. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

**Specifics:**

- When connecting to this FQDN, only read operations are allowed.
- If there are no active replicas in the cluster, you can't connect to this FQDN: the corresponding CNAME entry in the DNS will read `"null"`.

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

