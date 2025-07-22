---
title: How to connect to a {{ dataproc-full-name }} cluster
description: Follow this guide to connect to a {{ dataproc-name }} cluster.
---

# Connecting to a {{ dataproc-name }} cluster

After creating a {{ dataproc-name }} cluster, you can connect to subcluster hosts:

* Over the internet, if you have public access configured for your subcluster.
* From a {{ yandex-cloud }} [virtual machine](../../compute/operations/vm-create/create-linux-vm.md) located on the same cloud network.

## Configuring security groups {#configuring-security-groups}

Security groups might block cluster connections. If this happens, edit the group rules.

{% note alert %}

When setting up security groups, do not change the [rules for control plane traffic](./cluster-create.md#change-security-groups). This may cause the cluster to fail.

{% endnote %}

Rule settings depend on the connection method you select:

{% list tabs %}

- SSH

    * To connect to the subcluster hosts with public access from cloud networks and the internet, [configure cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow inbound traffic from any IP address on port `{{ port-ssh }}`. To do this, create the following rule for inbound traffic:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

    * To connect to a cluster from a jump host VM:

      1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and subcluster hosts. To do this, create the following rules:

          * For inbound traffic:

              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

          * For outbound traffic:

              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
              * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Address range of the subnet in which the cluster hosts are located. If subclusters are in different subnets, create this rule for each subnet.

      1. [Configure the cluster security](../../vpc/operations/security-group-add-rule.md) groups to allow inbound traffic from the security group where the VM is located on port `{{ port-ssh }}`. To do this, create the following rule for inbound traffic:

          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
          * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Security group assigned to the VM.

- UI Proxy

    To use [**UI Proxy**](../concepts/interfaces.md), [add](../../vpc/operations/security-group-add-rule.md) rules to the subcluster host's security group that allow inbound traffic via port `{{ port-https }}`:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

    If the connection is established via a jump host VM, [add](../../vpc/operations/security-group-add-rule.md) rules to the subcluster host's security group that allow connections via this VM:

    * For inbound traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

    * For outbound traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Address range of the subnet in which the subcluster host is located.

- Connecting with port forwarding

    When using [port forwarding](../operations/connect-interfaces.md#routing), [add](../../vpc/operations/security-group-add-rule.md) rules to the intermediate VM security group that allow inbound and outbound traffic via the ports of the required components:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `<component_port>`.

        Port numbers for {{ dataproc-name }} components are shown in the table:

        {% include [ports-table](../../_includes/data-processing/ports-table.md) %}

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

{% endlist %}

{% note info %}

You can specify more granular rules for your security groups, such as only allowing traffic within specific subnets.

Security groups must have correct configurations for all subnets where cluster hosts will be located.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## {{ dataproc-name }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name ([FQDN](../concepts/network.md#hostname)). You can view it in the management console:

1. Navigate to the cluster page.
1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

## Connecting to a {{ dataproc-name }} host over SSH {#data-proc-ssh}

To connect to a {{ dataproc-name }} host, make sure the SSH key you specified when creating the {{ dataproc-name }} cluster is accessible on the local machine or jump host VM. You can copy the key to the machine that will connect to the cluster, or connect to it with an SSH agent.

1. If you do not have public access configured for your subcluster, [connect](../../compute/operations/vm-connect/ssh.md) to the interim VM over SSH.

1. Start the SSH agent:

    ```bash
    eval `ssh-agent -s`
    ```

1. Add the required key to the list of those available to the agent:
 
   ```bash
   ssh-add ~/.ssh/example-key
   ```

1. Open an SSH connection to the {{ dataproc-name }} host by specifying its FQDN or IP address if public access is enabled for the host. For image version 2.0, specify the `ubuntu` user; for image version 1.4, `root`, e.g.:

   ```bash
   ssh ubuntu@rc1b-dataproc-m-fh4y4nur********.{{ dns-zone }}
   ```

   Result:

   ```text
   ubuntu@rc1b-dataproc-m-fh4y4nur********:~#
   ```

1. Make sure Hadoop commands are executed, e.g.:

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

## Connecting via {{ oslogin }} {#os-login}

[{{ oslogin }}](../../organization/concepts/os-login.md) is used instead of SSH keys to access {{ yandex-cloud }} virtual machines via SSH. With {{ oslogin }}, you can connect to {{ dataproc-name }} cluster nodes.

{% note info %}

Access via {{ oslogin }} must be [enabled at the organization level](../../organization/operations/os-login-access.md).

{% endnote %}

You can enable {{ oslogin }} access to hosts only when [creating a cluster](cluster-create.md).

You can connect to a host via {{ oslogin }} using a standard SSH client or the {{ yandex-cloud }} CLI. The user or [service account](../../iam/concepts/users/service-accounts.md) used for connection must have either the `compute.osLogin` or `compute.osAdminLogin` role assigned. When connecting using the {{ yandex-cloud }} CLI, you additionally need the `compute.operator` role.

Before connecting, [install and initialize the {{ yandex-cloud }} CLI](../../cli/quickstart.md#install).

### Connecting via SSH {#os-login-ssh}

1. [Export the {{ oslogin }} certificate](../../compute/operations/vm-connect/os-login-export-certificate.md).

   {% note info %}

   The certificate is valid for one hour. After this time, export a new certificate.

   {% endnote %}

1. Learn the {{ dataproc-name }} host IP:

    1. Get a list of hosts:

       ```bash
       {{ yc-dp }} cluster list-hosts <cluster_name_or_ID>
       ```

       You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list).

       Result:

       ```bash
       +------------------------------------------------------+----------------------+------------+----------------------+--------+
       |                         NAME                         | COMPUTE INSTANCE ID  |    ROLE    |    SUBCLUSTER ID     | HEALTH |
       +------------------------------------------------------+----------------------+------------+----------------------+--------+
       | rc1a-dataproc-d-q8659net********.mdb.yandexcloud.net | fhmr7sd33fl8******** | DATANODE   | c9qaps7qjj2d******** | ALIVE  |
       | rc1a-dataproc-m-hhhifdgl********.mdb.yandexcloud.net | fhmg686pspri******** | MASTERNODE | c9q7aen26lid******** | ALIVE  |
       +------------------------------------------------------+----------------------+------------+----------------------+--------+
       ```

       Save the ID of the VM corresponding to the host you will be connecting to.

   1. Get the VM info:

      ```bash
      yc compute instance get <VM_ID>
      ```

      Result:

      ```yml
      ...
      primary_v4_address:
        address: <internal_IP_address>
        one_to_one_nat:
          address: <external_IP_address>
          ip_version: IPV4
      ...
      ```

      If you are connecting to the host from the internet, save the external IP address; for connections from an intermediate VM, save the internal IP address.

1. Connect to the host:

    ```bash
    ssh -i <certificate_file_path> <user_login>@<host_IP_address>
    ```

    Where:

    * `<path_to_certificate_file>`: Path to the certificate's `Identity` file you saved earlier, e.g., `/home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername`.
    * `<user_login>`: User login as set in their [{{ oslogin }}](../../organization/concepts/os-login.md#os-login-profiles) profile. This login is also specified at the end of the name of the exported {{ oslogin }} certificate. In the example above, it is `orgusername`.
    * `<host_IP_address>`: Host IP address you got earlier.

    When connecting to the host for the first time, you will get an unknown host warning:

    ```text
    The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
    ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
    Are you sure you want to continue connecting (yes/no)?
    ```

    Type `yes` into the terminal and press **Enter**.  

### Connecting via the CLI {#os-login-cli}

1. Get a list of {{ dataproc-name }} hosts:

   ```bash
   {{ yc-dp }} cluster list-hosts <cluster_name_or_ID>
   ```

   You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list).

   Result:

   ```bash
   +------------------------------------------------------+----------------------+------------+----------------------+--------+
   |                         NAME                         | COMPUTE INSTANCE ID  |    ROLE    |    SUBCLUSTER ID     | HEALTH |
   +------------------------------------------------------+----------------------+------------+----------------------+--------+
   | rc1a-dataproc-d-q8659net********.mdb.yandexcloud.net | fhmr7sd33fl8******** | DATANODE   | c9qaps7qjj2d******** | ALIVE  |
   | rc1a-dataproc-m-hhhifdgl********.mdb.yandexcloud.net | fhmg686pspri******** | MASTERNODE | c9q7aen26lid******** | ALIVE  |
   +------------------------------------------------------+----------------------+------------+----------------------+--------+
   ```

   Save the ID of the VM corresponding to the host you will be connecting to.

1. Connect to the host:

    ```bash
    yc compute ssh --id <VM_ID>
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

     1. Specify the connection settings on the **General** tab:
        * **Host**: FQDN of the cluster master host or its public IP address.
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
     1. In the **Database** menu, select **New connection**.
     1. Select a data source from the DB list depending on the configuration of the {{ dataproc-name }} cluster you are connecting to:

         * If the cluster uses Hive, select **Apache Hive**.
         * If only Spark is enabled in the cluster and the [Thrift server is enabled](../concepts/settings-list.md#spark-thrift-server), select **Apache Spark**.

     1. Click **Next**.
     1. On the **SSH** tab, enable the **Use SSH tunnel** setting and specify these settings:
        * **Host/IP**: FQDN (to connect via a jumo host VM) or public IP address of the master host.
        * **Username**: Enter the username:
          * For version 2.0: `ubuntu`
          * For version 1.4: `root`
        * **Authentication method**: `Public key`.
        * **Secret key**: Path to the cluster’s private key file.
        * **Passphrase**: Private key password.
        * Optionally, to connect via a jump host VM, enable the **Use jump server** setting and specify the settings:
            * **Host/IP**: Public IP address of the VM for connection.
            * **Username**: Username for connecting to the VM.
            * **Authentication method**: `Public key`.
            * **Secret key**: Path to the VM’s private key file.
            * **Passphrase**: Private key password.
  1. Click **Test connection ...**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **Ready** to save the database connection settings.

{% endlist %}
