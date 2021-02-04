# Connecting to a database in a cluster {{ MY }}

You can connect to {{ mmy-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note info %}

If public access is only configured for certain hosts in your cluster, automatic master change may make the master unavailable over the internet.

{% endnote %}

## Configuring an SSL certificate {#Configuring-an-SSL-certificate}

{{ MY }}hosts with public access only support connections with an SSL certificate. You can prepare a certificate as follows:


```bash
$ mkdir ~/.mysql
$ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mysql/root.crt
$ chmod 0600 ~/.mysql/root.crt
```

## Connection string {#Connection-string}

Connect to the database using the command `mysql`.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% list tabs %}

- SSL

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}

  ```bash
  $ mysql --host=<host FQDN>
          --port=3306
          --ssl-ca=~/.mysql/root.crt
          --ssl-mode=REQUIRED
          --user=<name of database user>
          --password <DB name>
  ```

- Without SSL

  If you don't need to encrypt traffic within the virtual network when connecting to the database, you can connect to the database without an SSL connection. Pass the `--ssl-mode` parameter with the `DISABLED` value:

  ```bash
  $ mysql --host=<host FQDN>
          --port=3306
          --ssl-mode=DISABLED
          --user=<name of database user>
          --password <DB name>
  ```

{% endlist%}

## Connecting to the master {#Connecting-to-master}

Hosts will always identify the current master as `c-<cluster ID>.rw.{{ dns-zone }}`. For example, you can connect to the master of the cluster with the ID `c9qash3nb1v9ulc8j9nm` as follows:

```bash
$ mysql --host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }}
        --port=3306
        --ssl-ca=~/.mysql/root.crt
        --ssl-mode=REQUIRED
        --user=<name of database user>
        --password <DB name>
```

