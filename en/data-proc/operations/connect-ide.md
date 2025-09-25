---
title: How to connect to a {{ dataproc-full-name }} cluster host from graphical IDEs
description: Follow this guide to connect to a {{ dataproc-name }} host from graphical IDEs.
---

# Connecting to a {{ dataproc-name }} host from graphical IDEs

You can connect to a {{ dataproc-name }} cluster using graphical IDEs.

Before connecting:

1. [Configure security groups](security-groups.md).
1. [Get the host FQDN](fqdn.md).

## Connect using graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **Apache Hive**.

        {% note info %}

        Select the data source depending on the {{ dataproc-name }} component you are connecting to:

        * Hive: Select **Apache Hive**.
        * Spark: Select **Apache Spark**.

        The list of settings does not change.

        {% endnote %}

     1. Specify the connection settings on the **General** tab:
        * **Host**: [FQDN of the cluster master host](fqdn.md) or its public IP address.
        * If connecting for the first time, click **Download** to download the connection driver.
     1. On the **SSH/SSL** tab:
        1. Enable the **Use SSL** setting and specify the SSL connection settings:
           * **CA file**: Downloaded SSL certificate for the connection.
           * **Client key file**, **Client key password**: File with the private key required to connect to the {{ dataproc-name }} cluster and its password.
        1. Optionally, to connect via a jump host VM, configure the SSH tunnel settings:
           1. Select **Use SSH tunnel**, create an SSH configuration, and specify these settings:
              * **Host**: VM IP address.
              * **User name**: VM username.
              * **Private key file**, **Passphrase**: Private key file required to connect to the VM and its password.
           1. Click **Test Connection** to test the connection to the VM from DataGrip.
           1. Click **OK** to save the configuration.
  1. Click **Test Connection**. If the connection is successful, you will get the **OK** connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

  1. [Download the SSH key](#data-proc-ssh) to the local machine or VM to connect to a {{ dataproc-name }} cluster.
  1. Create a new DB connection:
     1. From the **Database** menu, select **New connection**.
     1. Select a data source from the DB list depending on the configuration of the {{ dataproc-name }} cluster you are connecting to:

         * If the cluster uses Hive, select **Apache Hive**.
         * If only Spark is enabled in the cluster and the [Thrift server is enabled](../concepts/settings-list.md#spark-thrift-server), select **Apache Spark**.

         The list of connection settings remains the same regardless of the selected data source.

     1. Click **Next**.
     1. On the **SSH** tab, enable the **Use SSH tunnel** setting and specify these settings:
        * **Host/IP**: [FQDN](fqdn.md) (to connect via a jump host VM) or public IP address of the master host.
        * **Username**: Enter the username:
          * For version 2.0: `ubuntu`.
          * For version 1.4: `root`.
        * **Authentication method**: `Public key`.
        * **Secret key**: Path to the cluster’s private key file.
        * **Passphrase**: Private key password.
        * Optionally, to connect via a jump host VM, enable the **Use jump server** setting and specify the settings:
            * **Host/IP**: Public IP address of the VM for connection.
            * **Username**: Username for connecting to the VM.
            * **Authentication method**: `Public key`.
            * **Secret key**: Path to the VM’s private key file.
            * **Passphrase**: Private key password.
  1. Click **Test Connection ...**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **Ready** to save the database connection settings.

{% endlist %}