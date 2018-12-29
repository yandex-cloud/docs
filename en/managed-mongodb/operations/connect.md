# Connecting to a database in a cluster [!KEYREF MG]

Inside Yandex.Cloud, you can connect to a DB cluster only from a VM whose address is in the same Cloud subnet.

## Authentication

[!KEYREF MG] clusters in [!KEYREF mmg-short-name] support only encrypted connections. Therefore, an SSL certificate is required to connect to such a cluster. You can prepare all the necessary authentication data as follows:

```bash
$ mkdir ~/.mongodb
$ wget "https://[!KEYREF s3-storage-host][!KEYREF pem-path]" -O ~/.mongodb/CA.pem
$ chmod 0600 ~/.mongodb/CA.pem
```

## Connection string

Now you can connect to the database using the `mongo` command by listing all the cluster hosts in the `host` parameter value:

```bash
$ mongo --norc \
        --ssl \
        --sslCAFile ~/.mongodb/CA.pem \
        --host 'rs01/<address of host 1>:27018,<address of host 2>:27018,<address of host N>:27018' \
        -u <user name> \
        -p <user password> \
        <DB name>
```

Write requests will be automatically sent to the cluster's primary host.

You can find the addresses of all the hosts in the DB cluster on the appropriate cluster page in the management console.

