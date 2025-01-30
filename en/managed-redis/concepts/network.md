---
title: Network and DB clusters in {{ mrd-full-name }}
description: In this tutorial, you will learn about the basic network interface settings for a {{ VLK }} cluster.
---

# {{ mrd-short-name }} network and DB clusters


When creating a cluster, you can:

* Specify a network for the entire cluster.
* Specify subnets for each host in the cluster.
* Enable TLS support to connect to the cluster from outside {{ yandex-cloud }}.


## Host name and FQDN {#hostname}

{{ mrd-short-name }} generates a name for each cluster host when it is created. This name will be the host's fully qualified domain name (FQDN). The host name and, consequently, FQDN cannot be changed.

{% include [see-fqdn](../../_includes/mdb/mrd/fqdn-host.md) %}


You can use the FQDN to connect to the host from the cloud network or over the internet.

## Public access to {#public-access-to-host} cluster hosts

If you create a {{ mrd-short-name }} cluster with TLS support, you can connect to it both from a {{ yandex-cloud }} VM and from the internet.

If you created a cluster without TLS support, you can only connect to it from a {{ yandex-cloud }} VM on the same cloud network. You cannot enable public access to a host in this type of cluster.

Any host in a cluster with TLS support enabled can be accessible from outside {{ yandex-cloud }} if you requested public access when [creating](../operations/hosts.md#add) or [modifying](../operations/hosts.md#update) the host.

You cannot update a public IP address after creating a host; however, you can replace an existing host with a new one that has a public IP address.

When deleting a publicly accessible host, the assigned IP address is revoked.

## Using FQDNs instead of IP addresses {#fqdn-ip-setting}

{{ VLK }} uses host IP addresses, not their [FQDNs](#hostname). If a {{ mrd-short-name }} cluster supports TLS, this prevents connection to {{ VLK }} hosts in the following situations:

* The [{{ VLK }} client](./supported-clients.md) connects to a host via SSL and requests to verify the host's FQDN against the certificate.

    The certificate contains the host's FQDN, not its IP address, so this verification will fail.

* Public access is enabled for the host.

    {{ VLK }} returns the host's internal IP address, even if public access is enabled for that host. Such an IP address is not accessible from the internet.

Enable the use of FQDNs instead of IP addresses to replace a host's IP address with its FQDN. You can do this when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#configure-fqdn-ip-behavior) any {{ mrd-short-name }} cluster; however, this setting is typically used in clusters with TLS support to bypass the above limitations.

{% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

> **Example of how this works**
>
> In non-sharded {{ mrd-short-name }} clusters, Sentinel is often used to get the address of the {{ VLK }} master host. Since Sentinel gets the address from {{ VLK }} itself, the result will vary depending on whether the **{{ ui-key.yacloud.redis.field_announce-hostnames }}** option is enabled.
>
> Let's assume a cluster has a {{ VLK }} master host with `{{ host-name }}.{{ dns-zone }}` for FQDN and `10.0.0.222` for internal IP address. The host address returned by Sentinel will look like this:
>
> * Option disabled: `10.0.0.222:6379`
> * Option enabled: `{{ host-name }}.{{ dns-zone }}:6379`

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

For information on how to configure security groups, see [{#T}](../operations/connect/index.md#configuring-security-groups).

{% note tip %}

When connecting to a cluster from the same cloud network, configure security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

