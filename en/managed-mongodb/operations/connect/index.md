# Overview of database connection methods

Available connection methods depend on whether [sharding](../../concepts/sharding.md):

* [Connecting to a non-sharded cluster](./non-sharded.md).
* [Connecting to a sharded cluster](./sharded.md).

## Accessing cluster hosts {#connect}

You can connect to {{ mmg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../../_includes/mdb/mmg/cluster-connect-note.md) %}

To connect to cluster hosts, use port:

* `{{ port-mmg }}` for a non-sharded cluster.
* `{{ port-mmg-sharded }}` for a sharded cluster.

Write requests will be automatically routed to the primary cluster replica.

{% note info %}

If public access is only configured for certain hosts, [automatic primary replica change](../../concepts/replication.md) may make the cluster unavailable over the internet.

{% endnote %}

{% if audience == "internal" %}

{% include notitle [Internal access](../../../_includes/mdb/internal-access.md) %}

{% endif %}

## Getting an SSL certificate {#get-ssl-cert}

To connect to {{ MG }} hosts with public access, get an SSL certificate:

{% list tabs %}

- Linux (Bash)

   {% include [install-certificate](../../../_includes/mdb/mmg/install-certificate.md) %}

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.mongodb; curl.exe -o $HOME\.mongodb\root.crt {{ crt-web-path }}
   ```

{% endlist %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

{% if audience != "internal" %}

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

   [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic from any IP on port `{{ port-mmg }}` for an unsharded cluster or on port `{{ port-mmg-sharded }}` for a [sharded](../shards.md) one. To do this, create the following rule for incoming traffic:

   * **Port range**: 
      * `{{ port-mmg }}` for a non-sharded cluster.
      * `{{ port-mmg-sharded }}` for a sharded cluster.
   * **Protocol**: `TCP`.
   * **Source**: `CIDR`.
   * **CIDR blocks**: `0.0.0.0/0`.

- With a VM in Yandex.Cloud

   1. [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in your cluster to allow incoming traffic from the security group the VM belongs to on port `{{ port-mmg }}` for an unsharded cluster or on port `{{ port-mmg-sharded }}` for a [sharded](../shards.md) one. To do this, create the following rule for incoming traffic in these groups:

      * **Port range**: 
         * `{{ port-mmg }}` for a non-sharded cluster.
         * `{{ port-mmg-sharded }}` for a sharded cluster.
      * **Protocol**: `TCP`.
      * **Source**: `Security group`.
      * **Security group**: Security group where the VM is located. If it is the same as the group being configured, specify **Self** (`Self`).

   1. [Configure the security group](../../../vpc/operations/security-group-add-rule.md) the VM belongs to enable connections to the VM and to allow traffic between the VM and the cluster hosts.

      Example of rules for a VM:

      * For incoming traffic:

         * **Port range**: `{{ port-ssh }}`.
         * **Protocol**: `TCP`.
         * **Source**: `CIDR`.
         * **CIDR blocks**: `0.0.0.0/0`.

         This rule lets you connect to the VM over SSH.

      * For outgoing traffic:

         * **Port range**: `{{ port-any }}`.
         * **Protocol**: `Any`(`Any`).
         * **Source**: `CIDR`.
         * **CIDR blocks**: `0.0.0.0/0`.

         This rule allows all outgoing traffic, which lets you both connect to the cluster and install the certificates and utilities that the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If security group settings are incomplete or incorrect, you may lose access to the cluster if the [primary replica fails over automatically](../../concepts/replication.md).

{% endnote %}

For more information, see [{#T}](../../concepts/network.md#security-groups).

{% endif %}

## Connection limits {#connection-limits}

{% include [mmg-conn-limits](../../../_includes/mdb/mmg/conn-limits.md) %}

A host's RAM amount depends on its class. All available options are listed in [{#T}](../../concepts/instance-types.md).
