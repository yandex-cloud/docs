# Preparing for connecting

Available connection methods depend on whether [sharding](../../concepts/sharding.md):

* [Connecting to a non-sharded cluster](./non-sharded.md).
* [Connecting to a sharded cluster](./sharded.md).

## Encryption support {#tls-support}

Encrypted SSL connections are supported for {{ mrd-short-name }} clusters. To use SSL, enable **TLS support** when [creating a cluster](../cluster-create.md).

When using SSL to connect to a cluster with encryption support, disable application FQDN matching and certificate verification. Otherwise, you will not be able to connect to the cluster since {{ RD }} returns the host IP instead of the host FQDN, which produces an error when verifying the host name.

## Accessing cluster hosts {#connect}

You can connect to {{ mrd-name }} cluster hosts:

* Via the internet if the following conditions are met:

   * [Public access to hosts](../hosts.md#public-access) is configured.
   * SSL connection is used.
   * Your cluster was created with TLS support.

* From {{ yandex-cloud }} virtual machines located in the same cloud network.

   {% if audience != "internal" %}

   1. [Create a virtual machine](../../../compute/operations/vm-create/create-linux-vm.md) with a public IP in the same virtual network as the cluster.
   1. Connect to the created VM [via SSH](../../../compute/operations/vm-connect/ssh.md).
   1. From this VM, connect to {{ RD }} using one of the sample connection strings.

   {% else %}

   1. Create a virtual machine with a public IP in the same virtual network as the cluster.
   1. Connect to the created VM via SSH.
   1. From this VM, connect to {{ RD }} using one of the sample connection strings.

   {% endif %}

## Configuring security groups {#configuring-security-groups}

{% include [Security groups notice](../../../_includes/mdb/sg-rules-connect.md) %}

{% include [Security groups rules for VM](../../../_includes/mdb/mrd/connect/sg-rules-for-vm.md) %}

Security group settings for sharded and non-sharded clusters differ.

{% list tabs %}

* Cluster with no sharding
   {% if audience != "internal" %}

   [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic from the security group where the VM is located on port `{{ port-mrd }}` for direct connections to the master host or `{{ port-mrd-sentinel }}` for connections via Sentinel. If you created your cluster with SSL encryption support, specify port `{{ port-mrd-tls }}` for direct encrypted connections to the master or `{{ port-mrd-sentinel }}` for unencrypted connections using Sentinel.

   {% else %}

   Configure all security groups in the cluster to allow incoming traffic from the security group where the VM is located on port `{{ port-mrd }}` for direct connections to the master host or `{{ port-mrd-sentinel }}` for connections via Sentinel. If you created your cluster with SSL encryption support, specify port `{{ port-mrd-tls }}` for direct encrypted connections to the master or `{{ port-mrd-sentinel }}` for unencrypted connections using Sentinel.

   {% endif %}

   {% note warning %}

   Connecting to port `{{ port-mrd-sentinel }}` enables you to request cluster information without authenticating. To restrict unauthorized cluster access with host public access enabled, do not specify this port in your security group settings.

   {% endnote %}

   To do this, create the following rule for incoming traffic:

   * Port range: create a separate rule for each port:

      * `{{ port-mrd }}`: For direct unencrypted host connections.
      * `{{ port-mrd-tls }}`: For direct host connections using SSL encryption.
      * `{{ port-mrd-sentinel }}`: For cluster communication via Sentinel.

         To connect to a cluster using Sentinel, you must also create a rule enabling connections via port `{{ port-mrd }}` or `{{ port-mrd-tls }}`.

   * Protocol: `TCP`.
   * Source: `Security group`.
   * Security group: Security group where the VM is located. If it is the same as the group being configured, specify **Self** (`Self`).

* Sharded cluster
   {% if audience != "internal" %}

   [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic from the security group where the VM is located on port `{{ port-mrd }}`. If a cluster is created with SSL encryption support, you should only specify port `{{ port-mrd-tls }}`.

   {% else %}

   Configure all security groups in the cluster to allow incoming traffic from the security group where the VM is located on port `{{ port-mrd }}`. If a cluster is created with SSL encryption support, you should only specify port `{{ port-mrd-tls }}`.

   {% endif %}

   To do this, create the following rule for incoming traffic:

   * Port range: `{{ port-mrd }}` or only `{{ port-mrd-tls }}` for clusters with SSL encryption support.
   * Protocol: `TCP`.
   * Source: `Security group`.
   * Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If security group settings are incomplete or incorrect, you may lose access to the cluster if the master is switched [manually](../failover.md) or [automatically](../../concepts/replication.md#availability).

{% endnote %}

For more information about security groups, see [{#T}](../../concepts/network.md#security-groups).

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted SSL connection, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mrd/install-certificate.md) %}
