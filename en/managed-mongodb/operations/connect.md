# Connecting to a database in a cluster {{ MG }}

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

To connect to {{ mmg-name }} cluster hosts, specify port 27018.

## Authentication

{{ MG }} clusters in {{ mmg-short-name }} only support encrypted connections, which is why an SSL certificate is required to connect to them. You can prepare all the necessary authentication data as follows:

```bash
$ mkdir ~/.mongodb
$ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.mongodb/CA.pem
$ chmod 0600 ~/.mongodb/CA.pem
```

## Connection string

Now you can connect to the database using the `mongo` command by listing all the cluster hosts in the `host` parameter value:

```bash
$ mongo --norc \
        --ssl \
        --sslCAFile ~/.mongodb/CA.pem \
        --host 'rs01/<host 1 FQDN>:27018,<host 2 FQDN>:27018,<host N FQDN>:27018' \
        -u <username> \
        -p <user password> \
        <DB name>
```

Write requests will be automatically sent to the cluster's primary host.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

