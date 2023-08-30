# Connecting to {{ dataproc-name }} clusters

After creating a {{ dataproc-name }} cluster, you can connect to hosts of subclusters:

* Over the internet, if you have public access configured for your subcluster.
* From a {{ yandex-cloud }} [virtual machine](../../compute/operations/vm-create/create-linux-vm.md) located on the same cloud network.

## Configuring security groups {#configuring-security-groups}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

Security groups might block cluster connections. If this happens, edit the group rules.

{% note alert %}

When setting up security groups, don't change the [rules for service traffic](./cluster-create.md#change-security-groups). This may cause the cluster to fail.

{% endnote %}

Rule settings depend on the connection method you select:

{% list tabs %}

- SSH

   * To connect to your subcluster hosts from cloud networks and the internet, [set up security groups](../../vpc/operations/security-group-add-rule.md) for your cluster to allow incoming traffic from any IP address on port `{{ port-ssh }}`. To do this, create the following rule for incoming traffic:

      * Port range: `{{ port-ssh }}`.
      * Protocol: `TCP`.
      * Source: `CIDR`.
      * CIDR blocks: `0.0.0.0/0`.

   * To connect to a cluster from an intermediate VM:

      1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and subcluster hosts. To do this, create the following rules:

         * For incoming traffic:

            * Port range: `{{ port-ssh }}`.
            * Protocol: `TCP`.
            * Source: `CIDR`.
            * CIDR blocks: `0.0.0.0/0`.

         * For outgoing traffic:

            * Port range: `{{ port-ssh }}`.
            * Protocol: `TCP`.
            * Destination type: `CIDR`.
            * CIDR blocks: Address range of the subnet where the hosts of the cluster are located. If subclusters are in different subnets, create this rule for each subnet.

      1. [Configure security groups](../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic from the security group where the VM is located on port `{{ port-ssh }}`. To do this, create the following rule for incoming traffic:

         * Port range: `{{ port-ssh }}`.
         * Protocol: `TCP`.
         * Source: `CIDR`.
         * CIDR blocks: Address range of the subnet where the hosts of the cluster are located.

- UI Proxy

   To use [**UI Proxy**](../concepts/interfaces.md), [add](../../vpc/operations/security-group-add-rule.md) rules to the subcluster host's security group to allow incoming traffic via port `{{ port-https }}`:

   * Port range: `{{ port-https }}`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

   If the connection is established via an intermediate VM, [add](../../vpc/operations/security-group-add-rule.md) rules to the subcluster host's security group to allow connections via this VM:

   * For incoming traffic:

      * Port range: `{{ port-https }}`.
      * Protocol: `TCP`.
      * Source: `CIDR`.
      * CIDR blocks: `0.0.0.0/0`.

   * For outgoing traffic:

      * Port range: `{{ port-https }}`.
      * Protocol: `TCP`.
      * Destination type: `CIDR`.
      * CIDR blocks: Address range of the subnet where the host of the subcluster is located.

- Connecting with port forwarding

   When using [port forwarding](../operations/connect-interfaces.md#routing), [add](../../vpc/operations/security-group-add-rule.md) rules to the intermediate VM security group that allow incoming and outgoing traffic via the required components' ports:

   * Port range: `<component port>`.

      Port numbers for {{ dataproc-name }} components are shown in the table:

      {% include [ports-table](../../_includes/data-proc/ports-table.md) %}

   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets where cluster hosts will be located.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Connecting to a {{ dataproc-name }} host via SSH {#data-proc-ssh}

To connect to a {{ dataproc-name }} host, make sure the SSH key that you specified when creating the {{ dataproc-name }} cluster is accessible on the local machine or the VM. You can copy the key to the machine from which the connection is performed to the cluster, or connect to it with an SSH agent.

1. (Optional) [Connect](../../compute/operations/vm-connect/ssh.md) to the intermediate virtual machine via SSH.

1. Launch the SSH agent:

   ```bash
   eval `ssh-agent -s`
   ```

1. Add the required key to the list of those available to the agent:

   ```bash
   ssh-add ~/.ssh/example-key
   ```

1. Open an SSH connection to the {{ dataproc-name }} host by specifying its FQDN or IP address if public access is enabled for the host.  For image 2.0, specify the `ubuntu` user, for image 1.4 — `root`. For example:  

   ```bash
   ssh ubuntu@rc1b-dataproc-m-fh4y4nur0i0uqqkz.{{ dns-zone }}
   ```

   Result:

   ```text
   ubuntu@rc1b-dataproc-m-fh4y4nur0i0uqqkz:~#
   ```

1. Make sure that Hadoop commands are executed, for example:

   ```bash
   hadoop version
   ```

   Result:

   ```text
   Hadoop 2.8.5
   Subversion https://github.yandex-team.ru/mdb/bigtop.git -r 78508f2a4b4f3dc8b3d295ccb50a45a4d24e81b5
   Compiled by robot-pgaas-ci on 2019-04-16T10:35Z
   Compiled with protoc 2.5.0
   From source with checksum 9942ca5c745417c14e318835f420733
   This command was run using /usr/lib/hadoop/hadoop-common-2.8.5.jar
   ```

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

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
         * **Host**: FQDN of the cluster master host or its public IP address.
         * Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting and specify the SSL connection parameters:
            * **CA file**: Downloaded SSL certificate for the connection.
            * **Client key file**, **Client key password**: File with the private key required to connect to the {{ dataproc-name }} cluster and its password.
         1. (Optional) To connect via an intermediate VM, configure the parameters of the SSH tunnel:
            1. Select **Use SSH tunnel**, create an SSH configuration, and specify the parameters:
               * **Host**: IP address of the VM.
               * **User name**: VM user's name.
               * **Private key file**, **Passphrase**: File with the private key required to connect to the VM and its password.
            1. Click **Test Connection** to test the connection to the VM from DataGrip.
            1. Click **OK** to save the configuration.
   1. Click **Test Connection** to test the connection. If the connection is successful, you'll see the **OK** connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

- DBeaver

   1. [Download the SSH key](#data-proc-ssh) to the local machine or VM to connect to a {{ dataproc-name }} cluster.
   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select the **Apache Hive** database from the list.

         {% note info %}

         Depending on the {{ dataproc-name }} service you're connecting to, you may need to select **Apache Phoenix** (for HBase) or **Apache Spark** instead of **Apache Hive**. The list of settings doesn't change.

         {% endnote %}

      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         * **Host**: FQDN of the cluster master host or its public IP address.
      1. On the **SSH** tab, specify:
         * **Authentication method**: `Public key`.
         * **Secret key**: Path to the private key file.
         * **Passphrase**: Password of the private key.
         * (Optional) To connect via an intermediate VM, enable the **Use SSH tunnel** setting and specify the following parameters to configure it:
            * **Host/IP**: Public IP address of the VM to connect to.
            * **Username**: Username for connecting to the VM.
   1. Click **Test connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}
