# Connecting to a database in a cluster {{ MY }}

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

## Authentication

{{ MY }} clusters in {{ mmy-short-name }} with public access only support encrypted connections, which is why an SSL certificate is required to connect to them. You can prepare all the necessary authentication data as follows:

```bash
$ mkdir ~/.mysql
$ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.mysql/root.crt
$ chmod 0600 ~/.mysql/root.crt
```

## Connection string

Now you can connect to the database using the `mysql` command:

```bash
$ mysql --host=<host FQDN>
        --port=3306
        --ssl-ca=~/.mysql/root.crt
        --ssl-mode=REQUIRED
        --user=<name of database user>
        --password <DB name>
```

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

If you don't need to encrypt traffic within the virtual network when connecting to the database, you can connect to the database without an SSL connection. This is only possible if the host is not publicly accessible. Otherwise, the server always requires an SSL connection. If you connect to the database without public access from a  {{ compute-name }} virtual machine, then pass parameter `--ssl-mode` with the `DISABLED` value:

```bash
$ mysql --host=<host FQDN>
        --port=3306
        --ssl-mode=DISABLED
        --user=<name of database user>
        --password <DB name>
```

## Connecting to the master

Hosts will always identify the current master as `c-<cluster ID>.rw.{{ dns-zone }}`.

For example, you can connect to the master of the cluster with the `c9qash3nb1v9ulc8j9nm` ID as follows:

```bash
$ mysql --host=c-c9qash3nb1v9ulc8j9nm.rw.mdb.yandexcloud.net
        --port=3306
        --ssl-ca=~/.mysql/root.crt
        --ssl-mode=REQUIRED
        --user=<name of database user>
        --password <DB name>
```

