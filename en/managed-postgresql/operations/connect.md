# Connecting to a database in a cluster {{ PG }}

You can connect to {{ mpg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note info %}

If public access is only configured for certain hosts in your cluster, automatic master change may make the master unavailable over the internet.

{% endnote %}

## Configuring an SSL certificate {#configuring-an-ssl-certificate}

{{ PG }} hosts with public access only support connections with an SSL certificate. You can prepare a certificate as follows:


```bash
$ mkdir ~/.postgresql
$ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.postgresql/root.crt
$ chmod 0600 ~/.postgresql/root.crt
```

## Connection string {#connection-string}

Connect to the database using the command `psql`.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% list tabs %}

- SSL

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}

  ```bash
  $ psql "host=<DB host FQDN> \
          port=6432 \
          sslmode=verify-full \
          dbname=<DB name> \
          user=<DB user name>"
  ```

- Without SSL

  If you don't need to encrypt traffic within the virtual network when connecting to the database, you can connect to the database without an SSL connection. Pass the `sslmode` parameter with the `disable` value:

  ```bash
  $ psql "host=<DB host FQDN> \
          port=6432 \
          sslmode=disable \
          dbname=<DB name> \
          user=<DB user name>"
  ```

{% endlist %}

## Automatic master host selection {#automatic-master-host-selection}

### Using libpq {#using-libpq}

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

### With a driver that supports only one host {#with-a-driver-that-supports-only-one-host}

If your database connection driver doesn't support passing multiple hosts in the connection string , you can connect to a special host like `c-<cluster ID>.rw.{{ dns-zone }}`.


This domain name always indicates the current master in the cluster. For example, you can connect to the master of the cluster with the `c9qash3nb1v9ulc8j9nm` ID as follows:

```bash
$ psql "host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<DB user name>"
```

