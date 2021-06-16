---
title: Connecting to an Elasticsearch cluster
description: 'You can connect to Elasticsearch cluster hosts with the Data node role over the Internet if you have configured public access for the required host. From Yandex.Cloud virtual machines located in the same virtual network.'
keywords:
  - connecting the Elasticsearch cluster
  - Elasticsearch cluster
  - Elasticsearch
---

# Connecting to clusters

You can connect to {{ mes-name }} cluster hosts with the [_Data node_](../concepts/hosts-roles.md#data-node) role:

- Over the internet, if you configured public access for the appropriate host.
- From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md).

Regardless of the connection method, {{ mes-name }} only supports connections to cluster hosts with an [SSL certificate](#configuring-an-ssl-certificate).

## Configuring an SSL certificate {#configuring-an-ssl-certificate}

To prepare an SSL certificate:

{% if audience == "internal" %}

```bash
mkdir ~/.elasticsearch && \
wget "https://crls.yandex.net/allCAs.pem" -O ~/.elasticsearch/root.crt && \
chmod 0600 ~/.elasticsearch/root.crt
```

{% else %}

```bash
mkdir ~/.elasticsearch && \
wget  "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.elasticsearch/root.crt && \
chmod 0600 ~/.elasticsearch/root.crt
```

{% endif %}

## Automatically selecting the host to connect to {#automatic-host-selection}

When connecting to an {{ ES }} cluster, you can:

- In the connection strings, explicitly specify the names of the hosts with the _Data node_ role.

  This approach is suitable for any connection method. For example, you can use it to connect over the internet if only a few hosts are assigned a public IP address.

- Use a special FQDN like: `c-<cluster ID {{ ES }}>.rw.mdb.yandexcloud.net` (for example, `https://c-e4ut2....rw.mdb.yandexcloud.net`).

  This approach is only suitable if all of the hosts with the _Data node_ role have a public IP address or connections are only made from {{ yandex-cloud }} virtual machines. This is because the host for the connection, which this FQDN is pointing to, is selected randomly from all the hosts with the _Data node_ role.

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mes-conn-strings-env.md) %}

Before connecting, [prepare your certificate](#configuring-an-ssl-certificate). These examples assume that the certificate ` root.crt` is located in the `/home/<home directory>/.elasticsearch/` folder.

To connect, enter the username and password used when [creating a cluster](cluster-create.md#create-cluster).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mes-connection-strings](../../_includes/mdb/mes-conn-strings.md) %}

If the connection is successful, general information about the {{ ES }} cluster will be displayed.

