---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Connecting to a database in a {{ CH }} cluster

You can connect to {{ mch-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

Using encryption via ports `9440` for [clickhouse-client](https://clickhouse.tech/docs/ru/interfaces/cli/) and `8443` for the [HTTP interface](https://clickhouse.tech/docs/ru/interfaces/http/) or without encryption via ports `9000` and `8123`, respectively.

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, you should prepare an SSL certificate, for example, like this:


```bash
sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
sudo chmod 655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```

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

