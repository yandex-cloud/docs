# Connecting to a database in a cluster {{ PG }}

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

## Authentication

{{ PG }}clusters in {{ mpg-short-name }} only support encrypted connections, which is why an SSL certificate is required to connect to them. You can prepare all the necessary authentication data as follows:

```bash
$ mkdir ~/.postgresql
$ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.postgresql/root.crt
$ chmod 0600 ~/.postgresql/root.crt
```

Read about using certificates with `libpq` in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/static/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

## Connection string

Now you can connect to the database using the `psql` command:

```bash
psql "host=<DB host FQDN> \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<DB user name>"
```

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

## Automatic master host selection

### Using libpq

To guarantee a connection to the master host, specify the FQDNs of all the cluster hosts in the `host` argument and pass the `target_session_attrs=read-write` parameter. This parameter is supported by the `libpq` library starting from [version 10](https://www.postgresql.org/docs/10/static/libpq-connect.html):

```bash
psql "host=<host 1 FQDN>,<host 2 FQDN>,<host 3 FQDN> \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user= \
      target_session_attrs=read-write"
```

To upgrade the library version used by the `psql` utility:

* For Debian-based Linux distributions, install the `postgresql-client-10` package (for example, using an [APT repository](https://www.postgresql.org/download/linux/ubuntu/)).

* For operating systems that use RPM packages, a {{ PG }} distribution is available from a [YUM repository](https://yum.postgresql.org/).

You can find the addresses of all the hosts in the DB cluster on the appropriate cluster page in the management console.

### With a driver that supports only one host

If your database connection driver doesn't allow passing multiple hosts in the connection string (for example, [pgx in Go](https://github.com/jackc/pgx)), you can connect to a special host like `c-<cluster ID>.rw.{{ dns-zone }}`.


This domain name always indicates the current master in the cluster. For example, you can connect to the master of the cluster with the `c9qash3nb1v9ulc8j9nm` ID as follows:

```bash
$ psql "host=c-c9qash3nb1v9ulc8j9nm.rw.mdb.yandexcloud.net \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<DB user name>"
```

