# Connecting to a database in a cluster {{ MY }}

You can connect to a DB cluster from a Yandex.Cloud VM only if this VM belongs to the same cloud network.

## Authentication

{{ MY }}-clusters in {{ mmy-short-name }} support only encrypted connections. Therefore, an SSL certificate is required to connect to such a cluster. You can prepare all the necessary authentication data as follows:

```bash
$ mkdir ~/.mysql
$ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mysql/root.crt
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

