# Connecting to a database in a {{ MY }} cluster

You can connect to a DB cluster from a Yandex.Cloud VM only if this VM belongs to the same cloud network.

## Authentication

{{ mmy-short-name }} clusters with public access only support encrypted connections, which is why an SSL certificate is required to connect to them. You can prepare all the necessary authentication data as follows:

```bash
$ mkdir ~/.mysql
$ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.mysql/root.crt
$ chmod 0600 ~/.mysql/root.crt
```

## Connection string

Now you can connect to the database using the `mysql` command:

```bash
$ mysql --host=<host address>
        --port=3306
        --ssl-ca=~/.mysql/root.crt
        --ssl-mode=REQUIRED
        --user=<name of the database user>
        --password <DB name>
```

You can find the addresses of all the hosts in the DB cluster on the appropriate cluster page in the management console.

If you don't need to encrypt traffic within the virtual network when connecting to the database, you can connect to the database without an SSL connection. This is only possible if the host is not publicly accessible. Otherwise, the server always requires an SSL connection. If you connect to the database without public access from a  {{ compute-name }} virtual machine, then pass parameter `-- ssl-mode` with the `DISABLED` value:

```bash
$ mysql --host=<host address>
        --port=3306
        --ssl-mode=DISABLED
        --user=<name of the database user>
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
        --user=<name of the database user>
        --password <DB name>
```

