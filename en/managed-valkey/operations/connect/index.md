---
title: Setting up a connection in {{ mrd-full-name }}
description: Follow this guide to connect to a {{ VLK }} cluster.
---

# Setting up a connection

You can connect in different ways depending on whether the cluster is [sharded](../../concepts/sharding.md):

* [Connecting to a non-sharded cluster](./non-sharded.md).
* [Connecting to a sharded cluster](./sharded.md).

## Accessing cluster hosts {#connect}

You can connect to {{ mrd-name }} cluster hosts:

* Over the internet if the following conditions are met:

    * The hosts have [public access enabled](../hosts.md#public-access).
    * SSL is used.
    * The cluster supports TLS.

* From {{ yandex-cloud }} virtual machines located in the same cloud network:

    
    1. [Create a virtual machine](../../../compute/operations/vm-create/create-linux-vm.md) with a public IP address in the same virtual network as the cluster.
    1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the created VM over SSH.
    1. From this VM, connect to {{ VLK }} using any of the connection string examples.



## Encryption support {#tls-support}

{{ mrd-short-name }} clusters support encrypted SSL connections. To use SSL, enable **{{ ui-key.yacloud.redis.field_tls-support }}** when [creating the cluster](../cluster-create.md).

By default, {{ VLK }} uses host IP addresses rather than [FQDNs](../../concepts/network.md#hostname). This may [prevent connection to {{ VLK }} hosts](../../concepts/network.md#fqdn-ip-setting) in clusters with TLS support. To enable host connections, do one of the following:

* Enable the setting that allows FQDNs to replace IP addresses. You can enable it when [creating](../cluster-create.md) or [updating](../update.md#configure-fqdn-ip-behavior) the cluster.

    This will allow [{{ VLK }} clients](../../concepts/supported-clients.md) to connect to {{ VLK }} hosts both from {{ yandex-cloud }} VMs and over the internet, as well as request verification of the host FQDN against the certificate, if required.

    {% include [fqdn-option-compatibility-note](../../../_includes/mdb/mvk/connect/fqdn-option-compatibility-note.md) %}

* Disable verification of the host FQDN against the certificate on the {{ VLK }} client side.

    This will enable you to connect to {{ VLK }} hosts from {{ yandex-cloud }} VMs.


## Configuring security groups {#configuring-security-groups}

{% include [Security groups notice](../../../_includes/mdb/sg-rules-connect.md) %}

{% include [Security groups rules for VM](../../../_includes/mdb/mvk/connect/sg-rules-for-vm.md) %}

Security group configurations differ for sharded and non-sharded clusters.

{% list tabs group=cluster %}

- Non-sharded cluster {#non-sharded}

    [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic from the VM security group on port `{{ port-mrd }}` for direct connections to the master host, or on port `{{ port-mrd-sentinel }}` for connections via Sentinel. If your cluster supports SSL encryption, use port `{{ port-mrd-tls }}` for an encrypted direct connection to the master, or port `{{ port-mrd-sentinel }}` for an unencrypted Sentinel connection.

    {% note warning %}

    Port `{{ port-mrd-sentinel }}` provides unauthenticated access to cluster information. To restrict unauthorized cluster access when public access to cluster hosts is enabled, do not expose this port in your security groups.

    {% endnote %}

    To do this, create the following inbound rule:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: Create a separate rule for each port:

        * `{{ port-mrd }}`: For direct unencrypted host connections.
        * `{{ port-mrd-tls }}`: For direct host connections with SSL encryption.
        * `{{ port-mrd-sentinel }}`: For accessing the cluster via Sentinel.

            To connect to a cluster using Sentinel, you also need to create a rule allowing connections on port `{{ port-mrd }}` or `{{ port-mrd-tls }}`.

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: VM security group. If it is the same as the one being configured, specify **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}**.

- Sharded cluster {#sharded}

    [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port `{{ port-mrd }}` from your VM’s security group. For clusters with SSL encryption enabled, specify port `{{ port-mrd-tls }}` only.

    To do this, create the following inbound rule:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mrd }}`, or `{{ port-mrd-tls }}` only for clusters with SSL encryption.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM share the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`. Otherwise, specify the VM security group.

{% endlist %}

{% note info %}

You can specify more granular rules for your security groups, such as only allowing traffic within specific subnets.

Make sure to configure the security groups correctly for all subnets where the cluster hosts will reside. With incomplete or incorrect security group settings, you may lose access to the cluster if a [manual](../failover.md) or [automatic](../../concepts/replication.md#availability) master failover occurs.

{% endnote %}

For more information about security groups, see [{#T}](../../concepts/network.md#security-groups).


## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted SSL connection, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mvk/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## {{ VLK }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name ([FQDN](../../concepts/network.md#hostname)). You can get it using one of the following methods:

* [Request a list of cluster hosts](../hosts.md#list-hosts).
* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
* Look up the FQDN in the management console:

   1. Navigate to the cluster page.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.
