# Connecting to a database in a {{ GP }} cluster

Because the {{ GP }} DBMS is based on {{ PG }}, the same tools are used to connect to both DBMSs.

You can connect to a {{ mgp-short-name }} cluster only via the [primary master host](../concepts/index.md). To identify host roles, get a [list of hosts in the cluster](cluster-hosts.md#list).

You can connect to a cluster:

{% include [cluster-connect-note-monolithic](../../_includes/mdb/cluster-connect-note.md) %}

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

  Configure all security groups in the cluster to allow incoming traffic on port {{ port-mgp }} from any IP address. To do this, [create a rule](../../vpc/operations/security-group-update.md#add-rule) for incoming traffic:

  * Protocol: `TCP`.
  * Port range: `{{ port-mgp }}`.
  * Source type: `CIDR`.
  * Source: `0.0.0.0/0`.

- With a VM in {{ yandex-cloud }}

  1. Configure all security groups in the cluster to allow incoming traffic from those security groups that contain the virtual machine, on port {{ port-mgp }}. To do this, [create a rule](../../vpc/operations/security-group-update.md#add-rule) for incoming traffic:

     * Protocol: `TCP`.
     * Port range: `{{ port-mgp }}`.
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

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

If the security group settings are incomplete or incorrect, you might lose access to the cluster if the primary master host is changed.

{% endnote %}

For more information, see [{#T}](../concepts/network.md#security-groups).

## Automatic primary master host selection {#automatic-master-host-selection}

For connection to a cluster with automatic host selection, use a [special primary master FQDN](#fqdn-master).

## Getting an SSL certificate {#get-ssl-cert}

To use an SSL connection, get a certificate:

{% list tabs %}

- Linux (Bash)

  {% if audience != "internal" %}

  ```bash
  mkdir ~/.postgresql && \
  wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.postgresql/root.crt && \
  chmod 0600 ~/.postgresql/root.crt
  ```

  {% else %}

  ```bash
  mkdir ~/.postgresql && \
  wget "{{ pem-path }}" -O ~/.postgresql/root.crt && \
  chmod 0600 ~/.postgresql/root.crt
  ```

  {% endif %}

- Windows (PowerShell)

  {% if audience != "internal" %}

  ```powershell
  mkdir $HOME\AppData\Roaming\postgresql
  curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt https://{{ s3-storage-host }}{{ pem-path }}
  ```

  {% else %}

  ```powershell
  mkdir $HOME\AppData\Roaming\postgresql
  curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt {{ pem-path }}
  ```

  {% endif %}

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to a publicly accessible cluster. Before connecting, [prepare a certificate](#get-ssl-cert).

{% list tabs %}

- DataGrip

  1. Create a data source:
      1. Select **File** → **New** → **Data Source** → **{{ GP }}**.
      1. Specify the connection parameters on the **General** tab:
          * **User**, **Password**: DB user's name and password.
          * **URL**: Connection string:
            In the connection string, use a [special primary master FQDN](#fqdn-master):
            ```http
            jdbc:postgresql://c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mgp }}/<db name>
            ```
          * Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
          1. Enable the **Use SSL** setting.
          1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
  1. Click **Test Connection** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver

  1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select the **{{ GP }}** database from the list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
          * **Host**: [Special primary master FQDN](#fqdn-master): `c-<cluster ID>.rw.{{ dns-zone }}`;
          * **Port**: `{{ port-mgp }}`.
          * **Database**: Name of the DB to connect to.
          * Under **Authentication**, specify the DB user's name and password.
      1. On the **SSL** tab:
          1. Enable the **Use SSL** setting.
          1. In the **Root certificate** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
  1. Click **Test Connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **Ready** to save the database connection settings.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mgp/conn-strings-env.md) %}

When creating a {{ GP }} cluster, the user database is not created. To test the connection, use the `postgres` service database.

To connect to a publicly accessible cluster, [prepare an SSL certificate](#get-ssl-cert).

The examples assume that the `root.crt` SSL certificate is located in the directory:

* `/home/<home directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

You can connect to a cluster using both a regular primary master FQDN or its [special FQDN](#fqdn-master).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mgp-connection-strings](../../_includes/mdb/mgp/conn-strings.md) %}

If the connection and the test query are successful, the cluster outputs the current {{ PG }} and {{ GP }} versions.

## Special primary master FQDN {#fqdn-master}

Just like usual FQDNs, which can be requested with a list of cluster hosts, {{ mgp-name }} provides a special FQDN, which can also be used when connecting to a cluster.

An FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` always points to the primary master host. Connection to this FQDN is permitted and both read and write operations are allowed.

An example of connecting to a primary master host in a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
psql "host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<username>"
```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
