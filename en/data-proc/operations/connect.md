# Connecting to {{ dataproc-name }} clusters

After creating a {{ dataproc-name }} cluster, you can connect to the host of the main subcluster.

Cluster hosts cannot be assigned a public IP address, so you need to use a VM from the same {{ yandex-cloud }} network to connect to them.

1. [Create a new VM](../../compute/operations/vm-create/create-linux-vm.md) if necessary.
1. Connect to the VM via [SSH](../../compute/operations/vm-connect/ssh.md).
1. You should also use SSH to connect to the host of the main subcluster from your VM.

{% note alert %}

When you [configure security groups](../../vpc/operations/security-group-update.md), don't change the [rules for service traffic](./cluster-create.md#change-security-groups). This may cause the cluster to fail.

{% endnote %}

{% list tabs %}

- SSH

    1. Add the rules to the intermediate VM security groups:

        * For incoming traffic:
            
            * Protocol: `TCP`.
            * Port range: `{{ port-ssh }}`.
            * Source type: `CIDR`.
            * Destination: `0.0.0.0/0`.

        * For outgoing traffic:
            
            * Protocol: `TCP`.
            * Port range: `{{ port-ssh }}`.
            * Source type: `CIDR`.
            * Purpose: the address range of the subnet where the hosts of the main subcluster are located.

    1. To connect to main subcluster hosts with an intermediate VM, add rules to the main subcluster host security groups that allow incoming traffic via port `{{ port-ssh }}`:
        
		* Protocol: `TCP`.
        * Port range: `{{ port-ssh }}`.
        * Source type: `CIDR`.
        * Purpose: the address range of the subnet where the hosts of the main subcluster are located.

- UI Proxy

    To use [**UI Proxy**](../concepts/ui-proxy.md), add rules to the main subcluster host security group that allow incoming traffic via port `{{ port-https }}`:
    
	* Protocol: `TCP`.
    * Port range: `{{ port-https }}`.
    * Source type: `CIDR`.
    * Destination: `0.0.0.0/0`.

    If the connection is performed via an intermediate VM, add rules to the main subcluster host security group that allow the appropriate connections:

    * For incoming traffic:
        
        * Protocol: `TCP`.
        * Port range: `{{ port-https }}`.
        * Source type: `CIDR`.
        * Destination: `0.0.0.0/0`.

    * For outgoing traffic:
        
		* Protocol: `TCP`.
        * Port range: `{{ port-https }}`.
        * Source type: `CIDR`.
        * Purpose: the address range of the subnet where the hosts of the main subcluster are located.

- Connecting with port forwarding

    When using [port forwarding](../concepts/interfaces.md#routing), add rules to the intermediate VM security group that allow incoming and outgoing traffic via the required components' ports:

    * Protocol: `TCP`.
    * Port range: `<component_port>`.

        Port numbers for {{ dataproc-name }} components are shown in the table:

        {% include [ports-table](../../_includes/data-proc/ports-table.md) %}

    * Source type: `CIDR`.
    * Destination: `0.0.0.0/0`.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets where cluster hosts will be located.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Connecting to a {{ dataproc-name }} host via SSH {#data-proc-ssh}

To connect to a {{ dataproc-name }} host from your VM, make sure the SSH key that you specified when creating the {{ dataproc-name }} cluster is accessible on it. You can copy the key to the VM or connect to it with an SSH agent.

1. Run the SSH agent locally:

    ```bash
    $ eval `ssh-agent -s`
    ```

1. Add the required key to the list of those available to the agent:

   ```bash
   $ ssh-add ~/.ssh/example-key
   ```

1. Open an SSH connection to the {{ dataproc-name }} host for the `root` user, for example:

   ```bash
   $ ssh root@rc1b-dataproc-m-fh4y4nur0i0uqqkz.mdb.yandexcloud.net
   
   root@rc1b-dataproc-m-fh4y4nur0i0uqqkz:~#
   ```

1. Make sure that Hadoop commands are executed, for example:

    ```bash
    ~# hadoop version
    
    Hadoop 2.8.5
    Subversion https://github.yandex-team.ru/mdb/bigtop.git -r 78508f2a4b4f3dc8b3d295ccb50a45a4d24e81b5
    Compiled by robot-pgaas-ci on 2019-04-16T10:35Z
    Compiled with protoc 2.5.0
    From source with checksum 9942ca5c745417c14e318835f420733
    This command was run using /usr/lib/hadoop/hadoop-common-2.8.5.jar
    ```

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to cluster hosts through an SSL tunnel using an intermediate VM.

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

{% list tabs %}

- DataGrip

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **Apache Hive**.

        {% note info %}

        Select the data source depending on the {{ dataproc-name }} component you're connecting to:

         * Hive: Select **Apache Hive**.
         * HBase: Select **Apache Phoenix**.
         * Spark: Select **Apache Spark**.

        The list of settings doesn't change.

        {% endnote %}

     1. Specify the connection parameters on the **General** tab:
        * **Host**: FQDN of the cluster master host.
        * Click **Download** to download the connection driver.
     1. On the **SSH/SSL** tab:
        1. Configure the parameters of the SSH tunnel and SSL connection to the VM:
           * Select **Use SSH tunnel**, create an SSH configuration, and specify the parameters:
              * **Host**: IP address of the VM.
              * **User name**: VM user's name.
              * **Private key file**, **Passphrase**: File with the private key required to connect to the VM and its password.
        1. Click **Test Connection** to test the connection to the VM from DataGrip.
        1. Click **OK** to save the configuration.
        1. Enable the **Use SSL** setting and specify the SSL connection parameters:
           * **CA file**: Downloaded SSL certificate for the connection.
           * **Client key file**, **Client key password**: File with the private key required to connect to the {{ dataproc-name }} cluster and its password.
  1. Click **Test Connection** to test the connection. If the connection is successful, you'll see the **OK** connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver

  1. [Download the SSH key](#data-proc-ssh) to the VM to connect to the {{ dataproc-name }} cluster.
  1. Create a new DB connection:
     1. In the **Database** menu, select **New connection**.
     1. Select the **Apache Hive** database from the list.

        {% note info %}

        Depending on the {{ dataproc-name }} service you're connecting to, you may need to select **Apache Phoenix** (for HBase) or  **Apache Spark** instead of **Apache Hive**. The list of settings doesn't change.

        {% endnote %}

     1. Click **Next**.
     1. Specify the connection parameters on the **Main** tab:
        * **Host**: FQDN of the cluster master host.
     1. On the **SSH** tab:
        1. Enable the **Use SSL tunnel** setting.
        1. Specify the SSH tunnel configuration parameters:
           * **Host/IP**: Public IP address of the VM to connect to.
           * **Username**: Username for connecting to the VM.
           * **Authentication method**: `Public key`.
           * **Secret key**: Path to the file with the private key used for connecting to the VM.
           * **Passphrase**: Password of the private key.
  1. Click **Test Connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the database connection settings.

{% endlist %}
