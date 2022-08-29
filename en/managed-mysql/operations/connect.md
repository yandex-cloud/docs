# Connecting to a database in a {{ MY }} cluster

You can connect to {{ mmy-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note warning %}

If only some of a cluster's hosts have public access configured, automatically changing the master may result in the master not being accessible from the internet.

{% endnote %}

The maximum number of connections is defined by the [max_connections](../concepts/settings-list.md#setting-max-connections) setting, which [depends on the host class](../concepts/settings-list.md#settings-instance-dependent).

For more information, see [{#T}](../concepts/network.md).

## Configuring security groups {#configure-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet
   {% if audience != "internal" %}

   [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic on port {{ port-mmy }} from any IP address. To do this, create the following rule for incoming traffic:

   {% else %}

   Configure all security groups in the cluster to allow incoming traffic on port {{ port-mmy }} from any IP address. To do this, create the following rule for incoming traffic:

   {% endif %}
   * Port range: `{{ port-mmy }}`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

- With a VM in {{ yandex-cloud }} 
   {% if audience != "internal" %}

   1. [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic from the security group where your VM is located on port {{ port-mmy }}. To do this, create the following rule for incoming traffic in these groups:

   {% else %}

   1. Configure all security groups in the cluster to allow incoming traffic from the security group where the VM is located, on port {{ port-mmy }}. To do this, create the following rule for incoming traffic in these groups:

   {% endif %}

         * Port range: `{{ port-mmy }}`.
         * Protocol: `TCP`.
         * Source: `Security group`.
         * Security group: If your cluster and VM are in the same security group, select `Self` as the value. Otherwise, specify the VM security group.
   {% if audience != "internal" %}

   1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

   {% else %}

   1. Configure the security group where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

   {% endif %}

         Example VM rule:

         * Incoming traffic:
            * Port range: `{{ port-ssh }}`.
            * Protocol: `TCP`.
            * Source: `CIDR`.
            * CIDR blocks: `0.0.0.0/0`.

             This rule lets you connect to the VM over SSH.

         * Outgoing traffic:
             * Port range: `{{ port-any }}`.
             * Protocol: `Any`.
             * Destination name: `CIDR`.
             * CIDR blocks: `0.0.0.0/0`.

             This rule allows all outgoing traffic, which lets you both connect to the cluster and install the certificates and utilities that the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

{% endlist %}

## Getting an SSL certificate {#get-ssl-cert}

{{ MY }} hosts with public access only support encrypted connections. To use them, get an SSL certificate:

{% list tabs %}

- Linux (Bash)

  {% include [install-certificate](../../_includes/mdb/mmy/install-certificate.md) %}

   The certificate will be saved in the `$HOME/.mysql/root.crt` directory.

- Windows (PowerShell)

   {% if audience != "internal" %}

   ```PowerShell
   mkdir ~/.mysql; curl -o ~/.mysql/root.crt https://{{ s3-storage-host }}{{ pem-path }}
   ```

   {% else %}

   ```PowerShell
   mkdir ~/.mysql; curl -o ~/.mysql/root.crt {{ pem-path }}
   ```

   {% endif %}

   The certificate will be saved in the `$HOME\.mysql\root.crt` directory.

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates. Before connecting [prepare a certificate](#get-ssl-cert).

{% list tabs %}

- DataGrip

   1. Create a data source:
      1. Select **File** → **New** → **Data Source** → **{{ MY }}**.
      1. On the **General** tab:
         1. Specify the connection parameters:
            * **Host**: FQDN of the host or a [special FQDN](#special-fqdns).
            * **Port**: `{{ port-mmy }}`.
            * **User**, **Password**: DB user's name and password.
            * **Database**: Name of the DB to connect to.
         1. Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
   1. To test the connection, click **Test Connection**. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

- DBeaver

   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select **{{ MY }}** from the DB list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         * **Host**: FQDN of the host or a [special FQDN](#special-fqdns).
         * **Port**: `{{ port-mmy }}`.
         * **Database**: Name of the DB to connect to.
         * **Username**, **Password**: DB username and password.
      1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **CA certificate** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
         1. Under **Advanced**:
            1. Enable **Require SSL**.
            1. Enable **Verify server certificate**.
   1. Click **Test connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can only connect to publicly accessible {{ MY }} hosts using an SSL certificate. Prior to connecting to such hosts, [generate a certificate](#get-ssl-cert).

These examples assume that the `root.crt` certificate is located in the ` /home/<home directory>/.mysql/` folder.

Connecting without an SSL certificate is only supported for hosts that are not publicly accessible. If this is the case, internal cloud network traffic will not be encrypted for connecting to a database.

You can connect to a cluster using both regular host FQDNs and [special FQDNs](#special-fqdns).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mmy-connection-strings](../../_includes/mdb/mmy-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the {{ MY }} version is output.

## Special FQDNs {#special-fqdns}

Just like usual FQDNs, which can be requested with a [list of cluster hosts](./hosts.md#list), {{ mmy-name }} provides a number of special FQDNs, which can also be used when connecting to a cluster.

### Current master {#fqdn-master}

A FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` always points to the current cluster master host. You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

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

FQDN like `c-<cluster ID>.ro.{{ dns-zone }}` points to the least lagging [replica](../concepts/replication.md). The cluster ID can be requested with a [list of clusters in the folder](./cluster-list.md#list-clusters).

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
