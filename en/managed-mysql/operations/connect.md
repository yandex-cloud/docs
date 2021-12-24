# Connecting to a database in a {{ MY }} cluster

You can connect to {{ mmy-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note info %}

If a cluster has public access set up for certain hosts only, an automatic master switch may make the master inaccessible over the internet.

{% endnote %}

The maximum number of simultaneous connections to a {{ mmy-name }} cluster host depends on `max_connections` and is `<amount of RAM per host, MB> / 32`. The minimum value is `100` by default.

For a [s1.micro class](../concepts/instance-types.md) host, for instance, with 8 GB of RAM, the default value of `max_connections` is `256`: `8 × 1024 / 32`.

## Configuring security groups {#configure-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

    [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port {{ port-mmy }} from any IP address. To do this, create the following rule for incoming traffic:
    * Protocol: `TCP`.
    * Port range: `{{ port-mmy }}`.
    * Source type: `CIDR`.
    * Source: `0.0.0.0/0`.

- With a VM in {{ yandex-cloud }}

    1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port {{ port-mmy }} from the security group assigned to the VM. To do this, create the following rule for incoming traffic in these groups:
        * Protocol: `TCP`.
        * Port range: `{{ port-mmy }}`.
        * Source type: `Security group`.
        * Source: Security group assigned to the VM. If it is the same as the configured group, specify **Current**.

    1. [Set up the security group](../../vpc/operations/security-group-update.md#add-rule) assigned to the VM to allow connections to the VM and traffic between the VM and the cluster hosts.

        Example of rules for a VM:

        * For incoming traffic:
           * Protocol: `TCP`.
           * Port range: `{{ port-ssh }}`.
           * Source type: `CIDR`.
           * Source: `0.0.0.0/0`.

            This rule lets you connect to the VM over SSH.

        * For outgoing traffic:
            * Protocol: `Any`.
            * Port range: `{{ port-any }}`.
            * Destination type: `CIDR`.
            * Destination: `0.0.0.0/0`.

            This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

{% endlist %}

## Getting an SSL certificate {#get-ssl-cert}

{{ MY }} hosts with public access only support encrypted connections. To use them, get an SSL certificate:

{% list tabs %}

- Linux (Bash)

  {% if audience != "internal" %}

  ```bash
  mkdir ~/.mysql && \
  wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mysql/root.crt && \
  chmod 0600 ~/.mysql/root.crt
  ```

  {% else %}

  ```bash
  mkdir ~/.mysql && \
  wget "{{ pem-path }}" -O ~/.mysql/root.crt && \
  chmod 0600 ~/.mysql/root.crt
  ```

  {% endif %}

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

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates. Before connecting, [prepare a certificate](#get-ssl-cert).

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
     1. Select the **{{ MY }}** database from the list.
     1. Click **Next**.
     1. Specify the connection parameters on the **Main** tab:
        - **Server**: FQDN of the host or a [special FQDN](#special-fqdns).
        - **Port**: `{{ port-mmy }}`.
        - **Database**: Name of the DB to connect to.
        - **User**, **Password**: DB user's name and password.
     1. On the **SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **Root certificate** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
         1. Under **Additional**:
            1. Enable the **SSL only** setting.
            1. Select **Check the server certificate**.
  1. Click **Test Connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the database connection settings.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can only connect to public {{ MY }} hosts using an SSL certificate. Before connecting to this type of host, [get a certificate ready](#get-ssl-cert).

These examples assume that the `root.crt` certificate is located in the ` /home/<home directory>/.mysql/` folder.

Connecting without an SSL certificate is only supported for hosts that are not publicly accessible. DB connection traffic internal to the cloud network will not be encrypted.

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

* When connecting to this FQDN, only read operations are allowed.
* If there are no active replicas in the cluster, you can't connect to this FQDN: the corresponding CNAME entry in the DNS will read `"null"`.

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

