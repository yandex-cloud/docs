# Connecting to a database in a {{ CH }} cluster


In {{ yandex-cloud }}, you can only connect to a DB cluster from a VM that is in the same subnet as the cluster.

A {{ CH }} cluster can be accessed using the [command-line client](https://clickhouse.yandex/docs/en/interfaces/cli/) (port 9440) or [HTTP interface](https://clickhouse.yandex/docs/en/interfaces/http_interface/) (port 8443). All connections to DB clusters are encrypted.

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, you should prepare an SSL certificate, for example, like this:


```bash
sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
sudo chmod 655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can only connect to a {{ CH }} cluster using an SSL certificate. Before connecting to clusters, [prepare a certificate](#get-ssl-cert).

In the examples below, it is assumed that the `YandexInternalRootCA.crt` certificate is located in the `/usr/local/share/ca-certificates/Yandex/` directory.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mch-connection-strings](../../_includes/mdb/mch-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the {{ CH }} version is output.

## Selecting an available host automatically {#auto}

If you don't want to manually connect to another host in case the current one becomes unavailable, use an address like this:

* `c-<cluster ID>.rw.mdb.yandexcloud.net` to connect to the cluster master host.
* `<shard name>.c-<cluster ID>.rw.mdb.yandexcloud.net` to connect to the [shard](../concepts/sharding.md) master host.

If the host that this address points to becomes unavailable, there may be a slight delay before the address starts pointing to another available host.
