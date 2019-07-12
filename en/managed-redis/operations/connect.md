# Connecting to a database in a cluster Redis

Redis cluster hosts cannot be assigned public IPs. You can only connect to a Redis host from a VM located in the same subnet as the host.

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
   $ mkdir -p /usr/local/share/ca-certificates/Yandex
   $ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
   ```

1. Create a variable with the host address and port and master DB name.

   ```
   $ host=$(redis-cli -h <host address> -p 26379 sentinel get-master-addr-by-name <cluster name> | head -n 1)
   ```

1. Check the connection to the host:

   ```
   $ redis-cli -h $host -a <DB password> ping
   ```

   If the response is `PONG`, the connection is established successfully.

