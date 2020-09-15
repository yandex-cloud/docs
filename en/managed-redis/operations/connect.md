# Connecting to a database in a cluster {{ RD }}

## Connection methods {#connection-methods}

You can connect to the  {{ RD }} database in two ways: directly or using Redis Sentinel.

[Redis Sentinel](https://redis.io/topics/sentinel) is a {{ RD }} host management system that provides monitoring, notification, automatic failover, and reporting of up-to-date host addresses to the clients.

Not every {{ RD }} client supports connecting via Sentinel. In such cases, you can connect to the host  directly. Note that you will need to track the roles of all the hosts yourself. If there is no need for a direct connection, use Sentinel for more reliable host management.

{% note info %}

Use port `26379` for host connections via Sentinel and port `6379` for direct connections.

{% endnote %}

Redis cluster hosts cannot be assigned public IPs. You can only access hosts from within their subnet.

## Connecting to databases {#connect-to-db}

In this example, we connect to the {{ RD }} host from a virtual machine connected to the same subnet as the host.

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) with a public IP in the same subnet as the Redis host.

1. Connect to the VM [via SSH](../../compute/operations/vm-connect/ssh.md).

   ```
   $ ssh <login>@<VM public IP>
   ```

1. Install Redis tools on the VM using a package manager:

   {% list tabs %}

   - Ubuntu

     ```
     $ sudo apt update
     $ sudo apt-get install redis
     ```

   - CentOS

     ```
     $ sudo yum update
     $ sudo yum install redis
     ```

   {% endlist %}

1. Install a certificate for accessing the database:

   ```
   $ sudo mkdir -p /usr/local/share/ca-certificates/Yandex
   $ sudo wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
   ```

1. Create a variable with the host name and port and master DB name.

   ```
   $ host=$(redis-cli -h <host address> -p 26379 sentinel get-master-addr-by-name <cluster name> | head -n 1)
   ```

1. Check the connection to the host:

   ```
   $ redis-cli -h $host -a <DB password> ping
   ```

   If the response is `PONG`, the connection is established successfully.

