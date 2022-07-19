# Connecting to a database in a {{ MG }} cluster

You can connect to {{ mmg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

To connect to {{ mmg-name }} cluster hosts, specify port {{ port-mmg }}. For a sharded {{ mmg-name }} cluster, specify port {{ port-mmg-sharded }}.

{% note info %}

If public access is only configured for certain hosts in your cluster, [automatic primary replica change](../concepts/replication.md) may make the primary replica unavailable over the internet.

{% endnote %}

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

    [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) in the cluster to allow incoming traffic from any IP address on port {{ port-mmg }} for a non-sharded cluster or on port {{ port-mmg-sharded }} for a [sharded](shards.md) cluster. To do this, create the following rule for incoming traffic:
    * Protocol: `TCP`.
    * Port range: `{{ port-mmg }}` for a non-sharded cluster or `{{ port-mmg-sharded }}` for a sharded cluster.
    * Source type: `CIDR`.
    * Source: `0.0.0.0/0`.

- With a VM in {{ yandex-cloud }}

    1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) in a cluster so that they allow incoming traffic from the security group assigned to the VM on port {{ port-mmg }} for a non-sharded cluster or on port {{ port-mmg-sharded }} for a [sharded](shards.md) cluster. To do this, create the following rule for incoming traffic in these groups:
        * Protocol: `TCP`.
        * Port range: `{{ port-mmg }}` for a non-sharded cluster or `{{ port-mmg-sharded }}` for a sharded cluster.
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

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If security group settings are incomplete or incorrect, you may lose access to the cluster if the [primary replica is changed automatically](../concepts/replication.md).

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Connection limits {#connection-limits}

{% include [mmg-conn-limits](../../_includes/mdb/mmg-conn-limits.md) %}

Amount of RAM available to the host is determined by the host class. All available options are listed in [{#T}](../concepts/instance-types.md).

## Getting an SSL certificate {#get-ssl-cert}

{{ MG }} hosts with public access only support encrypted connections. To use them, get an SSL certificate:

{% list tabs %}

    {% include [install-certificate](../../_includes/mdb/mmg/install-certificate.md) %}

- Windows (PowerShell)

    {% if audience != "internal" %}

    ```powershell
    mkdir $HOME\.mongodb; curl.exe -o $HOME\.mongodb\root.crt https://{{ s3-storage-host }}{{ pem-path }}
    ```

    {% else %}

    ```powershell
    mkdir $HOME\.mongodb; curl.exe -o $HOME\.mongodb\root.crt {{ pem-path }}
    ```

    {% endif %}

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mmg-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates. Before connecting, [prepare a certificate](#get-ssl-cert).

{% list tabs %}

- DataGrip
  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **{{ MG }}**.
     1. On the **General** tab:
        1. Specify the connection parameters:
           * **User**, **Password**: DB user's name and password.
           * **URL**: Connection string:
              * For a cluster with no sharding:

                ```http
                mongodb://<FQDN of {{ MG }} host 1>:{{ port-mmg }},..,<FQDN of {{ MG }} host N>:{{ port-mmg }}/<DB name>
                ```

              * For a cluster with sharding:

                ```http
                mongodb://<FQDN of MONGOINFRA or MONGOS host 1>:{{ port-mmg-sharded }},...<FQDN of MONGOINFRA or MONGOS host N>:{{ port-mmg-sharded }}/<DB name>
                ```

        1. Click **Download** to download the connection driver.
     1. On the **SSH/SSL** tab:
        1. Enable the **Use SSL** setting.
        1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
  1. Click **Test Connection** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver

  Connections to {{ MG }} clusters are only available in [commercial versions of DBeaver](https://dbeaver.com/buy/).

  To connect to a cluster:
  1. Create a new DB connection:
     1. In the **Database** menu, select **New connection**.
     1. Select the **{{ MG }}** database from the list.
     1. Click **Next**.
     1. Specify the connection parameters on the **Main** tab:
        1. Under **Address**, change the **Type** value to `URL` and specify the connection string:

           * For a cluster with no sharding:

             ```http
             mongo://<FQDN of {{ MG }} host 1>:{{ port-mmg }},..,<FQDN of {{ MG }} host N>:{{ port-mmg }}/<DB name>
             ```

           * For a cluster with sharding:

             ```http
             mongo://<FQDN of MONGOINFRA or MONGOS host 1>:{{ port-mmg-sharded }},...<FQDN of MONGOINFRA or MONGOS host N>:{{ port-mmg-sharded }}/<DB name>
             ```

        1. In the **Device** list, select `SCRAM-SHA-256` (type of password encryption when connecting to the DB).

        1. Under **Authentication**, specify the DB user's name and password.
     1. On the **SSL** tab:
        1. Enable the **Use SSL** setting.
        1. Under **Parameters**, in the **Root certificate** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
        1. Under **Settings**, select **Skip hostname validation**.
  1. Click **Test Connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the database connection settings.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can only connect to public {{ MG }} hosts using an SSL certificate. Before connecting to this type of host, [get a certificate ready](#get-ssl-cert).

The examples below assume that the `root.crt` SSL certificate is located in the directory:

* `/home/<home directory>/.mongodb/` for Ubuntu.
* `$HOME\.mongodb` for Windows.

Connecting without an SSL certificate is only supported for hosts that are not publicly accessible. DB connection traffic internal to the cloud network will not be encrypted.

Write requests will be automatically routed to the primary cluster replica.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

### Connecting to a non-sharded cluster {#cluster-connect}

{% include [mmg-connection-strings](../../_includes/mdb/mmg-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the following data is output:

1. For PHP examples, the `ping` command result.
1. For other examples, the name of the database the connection was established to.

### Connecting to a sharded cluster {#shard-connect}

{% include [mmg-connection-strings](../../_includes/mdb/mmg-shard-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the following data is output:

1. For PHP examples, the `ping` command result.
1. For other examples, the name of the database the connection was established to.
