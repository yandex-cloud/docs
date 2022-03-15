# Overview of database connection methods

Available connection methods depend on whether [sharding](../../concepts/sharding.md) is enabled in the cluster:

* [Connecting to a non-sharded cluster](./non-sharded.md).
* [Connecting to a sharded cluster](./sharded.md).

## Accessing cluster hosts {#connect}

{{ mrd-name }} cluster hosts can't be assigned public IPs. You can only access a cluster from within the same [cloud network](../../../vpc/concepts/network.md), in which its hosts are hosted.

To connect to a cluster:

1. [Create a VM](../../../compute/operations/vm-create/create-linux-vm.md) with a public IP in the same virtual network as the cluster.
1. Connect to the created VM [via SSH](../../../compute/operations/vm-connect/ssh.md) and then, from this VM, connect to {{ RD }} using one of the sample connection strings.

{% include [How to use TLS](../../../_includes/mdb/mrd/connect/how-to-use-tls.md) %}

## Configuring security groups {#configuring-security-groups}

{% include [Security groups notice](../../../_includes/mdb/sg-rules-connect.md) %}

{% include [Security groups rules for VM](../../../_includes/mdb/mrd/connect/sg-rules-for-vm.md) %}

Security group settings for sharded and non-sharded clusters differ.

{% list tabs %}

-  Clusters without sharding

    [Configure all the security groups](../../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic from the VM's security group on port `{{ port-mrd }}` for direct connections to the master host or `{{ port-mrd-sentinel }}` for connections via Sentinel. If a cluster is created with SSL encryption support, you should only specify port `{{ port-mrd-tls }}` (connections via Sentinel to this cluster type are not supported).

    To do this, create the following rule for incoming traffic in these groups:
    * Protocol: `TCP`.
    * Port range: `{{ port-mrd }}` (`{{ port-mrd-sentinel }}` for Sentinel) or only `{{ port-mrd-tls }}` for clusters with SSL encryption support.
    * Source type: `Security group`.
    * Source: Security group assigned to the VM. If it is the same as the group being configured, specify **Self** (`Self`).

- Sharded clusters

    [Configure all the security groups](../../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port `{{ port-mrd }}` from the security group assigned to the VM. If a cluster is created with SSL encryption support, you should only specify port `{{ port-mrd-tls }}`.

    To do this, create the following rule for incoming traffic in these groups:
    * Protocol: `TCP`.
    * Port range: `{{ port-mrd }}` or only `{{ port-mrd-tls }}` for clusters with SSL encryption support.
    * Source type: `Security group`.
    * Source: Security group assigned to the VM. If it is the same as the group being configured, specify **Self** (`Self`).

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts.

{% endnote %}

For more information about security groups, see [{#T}](../../concepts/network.md#security-groups).

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted SSL connection, get an SSL certificate:

```bash
sudo mkdir ~/.redis && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.redis/YandexInternalRootCA.crt && \
sudo chmod 655 ~/.redis/YandexInternalRootCA.crt
```

To use graphical IDEs, [download sertificate](https://{{ s3-storage-host }}{{ pem-path }}) and specify the path to it in the connection settings.

