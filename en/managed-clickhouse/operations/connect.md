# Connecting to a database in a cluster {{ CH }}

{% if audience != "internal" %}

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% endif %}

A {{ CH }} cluster can be accessed using the [command-line client](https://clickhouse.yandex/docs/ru/interfaces/cli/) (port 9440) or [HTTP interface](https://clickhouse.yandex/docs/ru/interfaces/http_interface/) (port 8443). All connections to DB clusters are encrypted.

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, you should get an SSL certificate:

{% if audience != "internal" %}

```bash
wget "https://{{ s3-storage-host }}{{ pem-path }}"
```

{% else %}

```bash
wget "{{ pem-path }}"
```

{% endif %}

## How to connect via {{ CH }} CLI {#cli}

To connect to a cluster using the command-line client, specify the path to the SSL certificate in the [configuration file](https://clickhouse.yandex/docs/ru/interfaces/cli/#interfaces_cli_configuration) in the `<caConfig>` element:

```xml
<config>
  <openSSL>
    <client>
      <loadDefaultCAFile>true</loadDefaultCAFile>
      <caConfig>[path to the SSL certificate]</caConfig>
      <cacheSessions>true</cacheSessions>
      <disableProtocols>sslv2,sslv3</disableProtocols>
      <preferServerCiphers>true</preferServerCiphers>
      <invalidCertificateHandler>
        <name>RejectCertificateHandler</name>
      </invalidCertificateHandler>
    </client>
  </openSSL>
</config>
```

Then run the ClickHouse CLI with the following parameters:

```bash
clickhouse-client --host <host FQDN> \
                  -s \
                  --user <DB user name> \
                  --password <DB user password> \
                  -q "<DB query>"
                  --port 9440
```

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

## How to connect via HTTP {#http}

Send a request specifying the path to the received SSL certificate, database attributes, and the request text in urlencoded format:

```bash
curl --cacert <path to the SSL certificate> \
     -H "X-ClickHouse-User: <DB user name>" \
     -H "X-ClickHouse-Key: <DB user password>" \
     'https://<host FQDN>:8443/?database=<DB name>&query=SELECT%20now ()'
```

When using the HTTP GET method, only read operations are allowed. A GET request for a write operation will always cause an error, like when using the`readonly=1` connection parameter.
Always use the POST method for write operations:

```bash
curl -X POST \
     --cacert <path to the SSL certificate> \
     -H "X-ClickHouse-User: <DB user name>" \
     -H "X-ClickHouse-Key: <DB user password>" \
     'https://<host FQDN>:8443/?database=<DB name>&query=INSERT%20INTO%20Customers%20%28CustomerName%2C%20Address%29%20VALUES%20%28%27Example%20Exampleson%27%2C%20%27Moscow%2C%20Lva%20Tolstogo%2C%2016%27%29%3B'
```

