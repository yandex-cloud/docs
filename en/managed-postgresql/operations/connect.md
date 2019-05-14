# Connecting to a database in a cluster [!KEYREF PG]

Inside Yandex.Cloud, you can connect to a DB cluster only from a VM whose address is in the same Cloud subnet.

## Authentication

[!KEYREF PG]-clusters in [!KEYREF mpg-short-name] support only encrypted connections. Therefore, an SSL certificate is required to connect to such a cluster. You can prepare all the necessary authentication data as follows:

[!INCLUDE [get-cert](../../_includes/mdb/get-cert.md)]

For information about how to use a certificate via `libpq`, read the [documentation on [!KEYREF PG]](https://www.postgresql.org/docs/current/static/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

## Connection string

Now you can connect to the database using the `psql` command:

```bash
psql "host=<DB host address> \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<DB user name>"
```

## Automatic master host selection

### Using libpq

To guarantee a connection to the master host, specify the addresses of all the cluster hosts in the `host` argument and pass the `target_session_attrs=read-write` parameter. This parameter is supported by the `libpq` library starting from [version 10](https://www.postgresql.org/docs/10/static/libpq-connect.html):

```bash
psql " host=<address of host 1>,<address of host 2>,<address of host 3> \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user= \
      target_session_attrs=read-write"
```

To upgrade the library version used by the `psql` utility:

* For Debian-based Linux distributions, install the `postgresql-client-10` package (for example, using an [APT repository](https://www.postgresql.org/download/linux/ubuntu/)).

* For operating systems that use RPM packages, a [!KEYREF PG] distribution is available from a [YUM repository](https://yum.postgresql.org/).

You can find the addresses of all the hosts in the DB cluster on the appropriate cluster page in the management console.

### With a driver that supports only one host

If your database connection driver does not allow passing multiple hosts in the connection string (for example,
[pgx in Go](https://github.com/jackc/pgx)), you can connect to a special host like `c-<cluster ID>.rw.[!KEYREF dns-zone]`.

This domain name always indicates the current master in the cluster. For example, you can connect to the master of the cluster with the `c9qash3nb1v9ulc8j9nm` ID as follows:

```bash
$ psql "host=c-c9qash3nb1v9ulc8j9nm.rw.[!KEYREF dns-zone] \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<DB user name>"
```

