# Connecting to a database in a {{ MS }} cluster

You can connect to {{ mms-short-name }} cluster hosts:

* Over the internet, if you configured public access for the appropriate host. You can only connect to such clusters over an [SSL connection](#get-ssl-cert).
* From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md). If the cluster isn't publicly available, you don't need to use an SSL connection to connect to such VMs.

If the cluster consists of multiple hosts, you can connect:

* To the primary replica for read and write operations.
* To secondary replicas for read operations if [readable replicas](../concepts/replication.md#readable-and-non-readable-replicas) were enabled when [creating the cluster](./cluster-create.md) or [afterwards in its additional settings](./update.md#change-additional-settings) 

You can connect to a cluster from a single host both for reading and writing.

For more information, see [{#T}](../concepts/replication.md).

{% note info %}

If your cluster has public access set up only for certain hosts, automatically switching the primary replica may make it inaccessible over the internet.

{% endnote %}

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet
    
    [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port {{ port-mms }} from any IP address. To do this, create the following rule for incoming traffic:

    * Protocol: `TCP`.
    * Port range: `{{ port-mms }}`.
    * Source type: `CIDR`.
    * Source: `0.0.0.0/0`.

- With a VM in Yandex.Cloud
    
    1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port {{ port-mms }} from the security group assigned to the VM. To do this, create the following rule for incoming traffic in these groups:


        * Protocol: `TCP`.
        * Port range: `{{ port-mms }}`.
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

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% list tabs %}

- Ubuntu 20.04

  {% include [install-certificate](../../_includes/mdb/mms/install-certificate.md) %}

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to publicly accessible cluster hosts. Before connecting with DataGrip, [generate a certificate](#get-ssl-cert).

{% list tabs %}

- DataGrip

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **Microsoft SQL Server**.
     1. On the **General** tab:
        1. Specify the connection parameters:
           * **Host**: FQDN of the primary replica or a [special FQDN](#special-fqdns).
           * **Port**: `{{ port-mms }}`.
           * **User**, **Password**: DB user's name and password.
           * **Database**: Name of the DB to connect to.
        1. Click **Download** to download the connection driver.
     1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
  1. Click **Test Connection** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver

  1. Create a new DB connection:
     1. In the **Database** menu, select **New connection**.
     1. Select the **{{ MS }}** database from the list.
     1. Click **Next**.
     1. Specify the connection parameters on the **Main** tab:
        * **Host**: FQDN of the primary replica or a [special FQDN](#special-fqdns).
        * **Port**: `{{ port-mms }}`.
        * **DB/Schema**: Name of the DB to connect to.
        * **User**, **Password**: DB user's name and password.
     1. On the **SSL** tab, enable the **Use SSL** and **Always trust the server certificate** settings.
  1. Click **Test Connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the connection settings.

- SQL Server Management Studio

  1. Create a new connection:
      1. Specify the connection parameters in the **Connect to server** window:
          * **Server type**: Database Engine.
          * **Server name**: `<host FQDN>,1433`. Specify the FQDN of the primary replica or a [special FQDN](#special-fqdns).
          * **Authentication**: SQL Server authentication.
          * **Login**, **Password**: User's login and password.
      1. Click **Options**.
      1. Click the **Connection Properties** tab.
      1. Select **Encrypt connection** and **Trust server certificate**.
  1. Click **Connect** to connect to the {{ MS }} host.

  For more information about the connection, see the developer's [documentation]({{ ms.docs }}/sql/linux/sql-server-linux-manage-ssms?view=sql-server-ver15#connect-to-sql-server-on-linux).

  If the connection is successful, **Object Explorer** will display information about all {{ MS }} objects.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mms-conn-strings-env.md) %}

{% include [see-sqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mms-connection-strings](../../_includes/mdb/mms-conn-strings.md) %}

## Special FQDNs {#special-fqdns}

Just like usual FQDNs, which can be requested with a [list of cluster hosts](hosts.md#list), {{ mms-name }} provides a number of special FQDNs, which can also be used when connecting to a cluster.

### Current primary replica {#fqdn-primary-replica}

An FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` always points to the primary replica in the cluster. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

When connecting to this FQDN, both read and write operations are allowed.

Example connection to a primary replica for a cluster with the ID `c9qash3nb1v9ulc8j9nm`:

```bash
mssql-cli --username <username> \
          --database <DB name> \
          --server c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }},1433
```
