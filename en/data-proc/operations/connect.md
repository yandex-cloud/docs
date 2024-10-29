---
title: How to connect to a {{ dataproc-full-name }} cluster
description: Follow this guide to connect to a {{ dataproc-name }} cluster.
---

# Connecting to a {{ dataproc-name }} cluster

After creating a {{ dataproc-name }} cluster, you can connect to hosts of subclusters:

* Over the internet, if you have public access configured for your subcluster.
* From a {{ yandex-cloud }} [virtual machine](../../compute/operations/vm-create/create-linux-vm.md) located on the same cloud network.

## Configuring security groups {#configuring-security-groups}

Security groups might block cluster connections. If this happens, edit the group rules.

{% note alert %}

When setting up security groups, do not change the [rules for service traffic](./cluster-create.md#change-security-groups). This may cause the cluster to fail.

{% endnote %}

Rule settings depend on the connection method you select:

{% list tabs %}

- SSH

   * To connect to the subcluster hosts with public access from cloud networks and the internet, [configure cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic from any IP address on port `{{ port-ssh }}`. To do this, create the following rule for incoming traffic:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   * To connect to a cluster from an intermediate VM:

      1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and subcluster hosts. To do this, create the following rules:

         * For incoming traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         * For outgoing traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Address range of the subnet in which the cluster hosts are located. If subclusters are in different subnets, create this rule for each subnet.

      1. [Configure the cluster security](../../vpc/operations/security-group-add-rule.md) groups to allow incoming traffic from the security group where the VM is located on port `{{ port-ssh }}`. To do this, create the following rule for incoming traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Address range of the subnet in which the cluster hosts are located.

- UI Proxy

   To use [**UI Proxy**](../concepts/interfaces.md), [add](../../vpc/operations/security-group-add-rule.md) rules to the subcluster host's security group to allow incoming traffic via port `{{ port-https }}`:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   If the connection is established via an intermediate VM, [add](../../vpc/operations/security-group-add-rule.md) rules to the subcluster host's security group to allow connections via this VM:

   * For incoming traffic:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   * For outgoing traffic:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Address range of the subnet in which the subcluster host is located.

- Connecting with port forwarding

   When using [port forwarding](../operations/connect-interfaces.md#routing), [add](../../vpc/operations/security-group-add-rule.md) rules to the intermediate VM security group that allow incoming and outgoing traffic via the required components' ports:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `<component_port>`.

      Port numbers for {{ dataproc-name }} components are shown in the table:

      {% include [ports-table](../../_includes/data-proc/ports-table.md) %}

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

{% endlist %}

{% note info %}

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific subnets.

Security groups must be configured correctly for all subnets where cluster hosts will be located.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## {{ dataproc-name }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name ([FQDN](../concepts/network.md#hostname)). You can view it in the management console:

1. Go to the cluster page.
1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

## Connecting to a {{ dataproc-name }} host via SSH {#data-proc-ssh}

To connect to a {{ dataproc-name }} host, make sure the SSH key you specified when creating the {{ dataproc-name }} cluster is accessible on the local machine or intermediate VM. You can copy the key to the machine from which the connection is performed to the cluster, or connect to it with an SSH agent.

1. If you do not have public access configured for your subcluster, [connect](../../compute/operations/vm-connect/ssh.md) to the intermediate VM via SSH.

1. Launch the SSH agent:

   ```bash
   eval `ssh-agent -s`
   ```

1. Add the required key to the list of those available to the agent:

   ```bash
   ssh-add ~/.ssh/example-key
   ```

1. Open an SSH connection to the {{ dataproc-name }} host by specifying its FQDN or IP address if public access is enabled for the host.  For image 2.0, specify the `ubuntu` user, for image 1.4, `root`, e.g.:  

   ```bash
   ssh ubuntu@rc1b-dataproc-m-fh4y4nur********.{{ dns-zone }}
   ```

   Result:

   ```text
   ubuntu@rc1b-dataproc-m-fh4y4nur********:~#
   ```

1. Make sure that Hadoop commands are executed, for example:

   ```bash
   hadoop version
   ```

   Result:

   ```text
   Hadoop 2.8.5
   Subversion https://github.yandex-team.ru/mdb/bigtop.git -r 78508f2a4b4f3dc8b3d295ccb50a45a4********
   Compiled by robot-pgaas-ci on 2019-04-16T10:35Z
   Compiled with protoc 2.5.0
   From source with checksum 9942ca5c745417c14e31883********
   This command was run using /usr/lib/hadoop/hadoop-common-2.8.5.jar
   ```

## Connecting from graphical IDEs {#connection-ide}

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

      1. Specify the connection parameters on the **General** tab:
         * **Host**: FQDN of the cluster master host or its public IP address.
         * If connecting for the first time, click **Download** to download the connection driver.
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
   1. Click **Test Connection** to test the connection. If the connection is successful, you will get the **OK** connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

   1. [Download the SSH key](#data-proc-ssh) to the local machine or VM to connect to a {{ dataproc-name }} cluster.
   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select a data source from the DB list depending on the configuration of the {{ dataproc-name }} cluster you are connecting to:

         * If the cluster uses Hive, select **Apache Hive**.
         * If only Spark is enabled in the cluster and the [Thrift server is enabled](../concepts/settings-list.md#spark-thrift-server), select **Apache Spark**.

      1. Click **Next**.
      1. On the **SSH** tab, enable the **Use SSH tunnel** setting and specify the parameters:
         * **Host/IP**: FQDN (to connect via an intermediate VM) or public IP address of the master host.
         * **Username**: Enter the username:
            * For version 2.0: `ubuntu`
            * For version 1.4: `root`
         * **Authentication method**: `Public key`.
         * **Secret key**: Path to the cluster private key file.
         * **Passphrase**: Private key password.
         * (Optional) To connect via an intermediate VM, enable the **Use jump server** setting and specify the parameters:
            * **Host/IP**: Public IP address of the VM to connect to.
            * **Username**: Username for connecting to the VM.
            * **Authentication method**: `Public key`.
            * **Secret key**: Path to the VM private key file.
            * **Passphrase**: Private key password.
   1. Click **Test connection ...** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}
