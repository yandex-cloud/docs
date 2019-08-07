# Connecting to a database in a cluster {{ MG }}

In Yandex.Cloud, you can connect to a DB cluster only from a VM that has an address in the the Yandex.Cloud subnet.

## Authentication

{{ MG }} clusters in {{ mmg-short-name }} only support encrypted connections, which is why an SSL certificate is required to connect to them. You can prepare all the necessary authentication data as follows:

```bash
$ mkdir ~/.mongodb
$ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mongodb/CA.pem
$ chmod 0600 ~/.mongodb/CA.pem
```

## Connection string

Now you can connect to the database using the `mongo` command by listing all the cluster hosts in the `host` parameter value:

```bash
$ mongo --norc \
        --ssl \
        --sslCAFile ~/.mongodb/CA.pem \
        --host 'rs01/<address of host 1>:27018,<address of host 2>:27018,<address of host N>:27018' \
        -u <username> \
        -p <user password> \
        <DB name>
```

Write requests will be automatically sent to the cluster's primary host.

You can find the addresses of all the hosts in the DB cluster on the appropriate cluster page in the management console.

