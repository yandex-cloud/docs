# Connecting to a database in a {{ CH }} cluster

You can connect to {{ mch-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

Using encryption via ports `9440` for [clickhouse-client](https://clickhouse.tech/docs/en/interfaces/cli/) and `8443` for the [HTTP interface](https://clickhouse.tech/docs/en/interfaces/http/) or without encryption via ports `9000` and `8123`, respectively.

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the Internet

  [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on ports 8443 and 9440 from any IP addresses. To do this, create the following rules for incoming traffic:
  * Protocol: `TCP`.
  * Port range: `8443`, `9440`.
  * Source type: `CIDR`.
  * Source: `0.0.0.0/0`.

  A separate rule is created for each port.

- With a VM in Yandex.Cloud

  1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on ports 8123, 8443, 9000, and 9440 from the security group assigned to the VM. To do this, create the following rules for incoming traffic in these security groups:
     * Protocol: `TCP`.
     * Port range: `8123` (or any other port listed above).
     * Source type: `Security group`.
     * Source: Security group assigned to the VM. If it is the same as the configured group, specify **Current**.

     A separate rule is created for each port.

  1. [Set up the security group](../../vpc/operations/security-group-update.md#add-rule) assigned to the VM to allow connections to the VM and traffic between the VM and the cluster hosts.

     Example of rules for a VM:

     * For incoming traffic:
       * Protocol: `TCP`.
       * Port range: `22`.
       * Source type: `CIDR`.
       * Source: `0.0.0.0/0`.

       This rule lets you connect to the VM over SSH.

     * For outgoing traffic:
        * Protocol: `Any`.
        * Port range: `0-65535`.
        * Destination type: `CIDR`.
        * Destination: `0.0.0.0/0`.

       This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, e.g., to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might fail to access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, you should prepare an SSL certificate, for example, like this:

{% if audience != "internal" %}

```bash
sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
sudo chmod 655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```

{% else %}

```bash
wget "{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```

{% endif %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can connect to public {{ CH }} cluster hosts only if you use an SSL certificate. Before connecting, [prepare a certificate](#get-ssl-cert).

In the examples below, it is assumed that the `YandexInternalRootCA.crt` certificate is located in the `/usr/local/share/ca-certificates/Yandex/` directory.

Connecting without an SSL certificate is only supported for hosts that are not publicly accessible. For connections to the database, traffic inside the virtual network isn't encrypted in this case.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mch-connection-strings](../../_includes/mdb/mch-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the {{ CH }} version is output.

## Selecting an available host automatically {#auto}

If you don't want to manually connect to another host in case the current one becomes unavailable, use an address like this:

* `c-<cluster ID>.rw.mdb.yandexcloud.net` to connect to the cluster master host.

* `<shard name>.c-<cluster ID>.rw.mdb.yandexcloud.net` to connect to the [shard](../concepts/sharding.md) master host.

If the host that this address points to becomes unavailable, there may be a slight delay before the address starts pointing to another available host.
