# Connecting to a database in a cluster {{ MG }}

You can connect to {{ mmg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

To connect to {{ mmg-name }} cluster hosts, specify port 27018.

{% note info %}

If public access is only configured for certain hosts in your cluster, automatic primary replica change may make the primary replica unavailable over the internet.

{% endnote %}

## Configuring an SSL certificate {#Configuring-an-SSL-certificate}

{{ MG }}hosts with public access only support connections with an SSL certificate. You can prepare a certificate as follows:


```bash
$ mkdir ~/.mongodb
$ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mongodb/CA.pem
$ chmod 0600 ~/.mongodb/CA.pem
```

## Connection string {#Connection-string}

You can connect to the database using the command `mongo` by listing all the cluster hosts in the `host` parameter value.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% list tabs %}

- SSL for mongo 4.2

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}


  ```bash
  $ mongo --norc \
          --tls \
          --tlsCAFile ~/.mongodb/CA.pem \
          --host 'rs01/<host 1 FQDN>:27018,<host 2 FQDN>:27018,<host N FQDN>:27018' \
          -u <user name> \
          -p <user password> \
          <DB name>
  ```

- SSL for older versions of MongoDB

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}


  ```bash
  $ mongo --norc \
          --ssl \
          --sslCAFile ~/.mongodb/CA.pem \
          --host 'rs01/<host 1 FQDN>:27018,<host 2 FQDN>:27018,<host N FQDN>:27018' \
          -u <user name> \
          -p <user password> \
          <DB name>
  ```

- Without SSL

  If you don't need to encrypt traffic within the virtual network when connecting to the database, you can connect from a Yandex.Cloud VM without SSL. Pass the `sslmode` parameter with the `disable` value:


  ```bash
  $ mongo --norc \
          --host 'rs01/<host 1 FQDN>:27018,<host 2 FQDN>:27018,<host N FQDN>:27018' \
          -u <user name> \
          -p <user password> \
          <DB name>
  ```

{% endlist%}

Write requests will be automatically routed to the primary cluster replica.

