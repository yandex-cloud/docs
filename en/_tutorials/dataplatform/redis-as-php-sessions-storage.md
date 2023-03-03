# Using {{ mrd-name }} clusters as PHP session storage

You can use {{ mrd-name }} clusters for storing PHP session data.

To configure a {{ mrd-name }} cluster as PHP session storage:

1. [Configure PHP to use the {{ mrd-name }} cluster as storage for sessions](#settings-php).
1. [Check whether PHP session data is saved to the {{ mrd-name }} cluster](#test-settings).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

   
   1. [Configure the {{ vpc-name }} security group](../../vpc/operations/security-group-add-rule.md). Add TCP settings to the security group to allow the following:

      * Incoming traffic through port `22` from any IP addresses for SSH.
      * Outgoing and incoming traffic through ports `80` and `443` to and from any IP address for HTTP/HTTPS.
      * Outgoing and incoming traffic through port `6379` to and from internal network IP addresses for {{ RD }}.

      For details, see [{#T}](../../vpc/concepts/security-groups.md).


   1. [Create a virtual machine with LAMP/LEMP](../../tutorials/web/lamp-lemp.md#create-vm) in {{ compute-full-name }} of any suitable configuration.

      
      When creating a VM, select the security group that you set up earlier. To check the security settings, enter the VM's public IP address in the browser address bar: the default page of the web server should be displayed.


   1. [Create a {{ mrd-name }}cluster](../../managed-redis/operations/cluster-create.md) with any suitable configuration.  When creating a {{ mrd-name }} cluster, specify the same network and security groups as those of the VM hosting the web server. 

- Using {{ TF }}

   1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the configuration file for the appropriate cluster type to the same working directory:

      * [redis-cluster-non-sharded-and-vm.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-as-php-session-storage/redis-cluster-non-sharded-and-vm-for-php.tf): For a non-sharded cluster.
      * [redis-cluster-sharded-and-vm.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-as-php-session-storage/redis-cluster-sharded-and-vm-for-php.tf): For a [sharded](../../managed-redis/concepts/sharding.md) cluster.

      Each file describes:

      * Network.
      * Subnet.
      * Default security group and rules required to connect to the cluster and VM from the internet.
      * {{ mrd-name }} cluster.
      * Virtual machine.

   1. Specify the following in the configuration file:

      * Password to access the {{ mrd-name }} cluster.
      * ID of the public LAMP/LEMP [image](../../compute/operations/images-with-pre-installed-software/get-list.md). For example, `fd832gltdaeepe0m2hi8` for LAMP.
      * Username and path to the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file to use to access to the virtual machine. By default, the specified username is ignored in the image used. Instead, a user with the `ubuntu` username is created. Use it to connect to the instance.

   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the providers specified in the configuration files and lets you work with the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Configure additional settings {#additional-settings}

1. [Connect to the VM with the web server via SSH and configure it](../../compute/operations/vm-connect/ssh.md):

   * Install certificates:

      ```bash
      sudo mkdir --parents {{ crt-local-dir }} && \
      sudo wget "{{ crt-web-path }}" \
          --output-document {{ crt-local-dir }}{{ crt-local-file }}
      ```

   * Prepare the environment and install the [phpredis](https://github.com/phpredis/phpredis) library using `pecl`:

      ```bash
      sudo apt update && \
      sudo apt install php-dev pkg-php-tools redis-tools --yes && \
      sudo pecl channel-update pecl.php.net && \
      sudo pecl install redis
      ```

   * Become the owner of the `/var/www/html/` directory and delete all its contents:

      ```bash
      sudo chown <username> /var/www/html/ --recursive && \
      rm /var/www/html/*
      ```

## Configure PHP to use the {{ mrd-name }} cluster as storage for sessions {#settings-php}

1. Make changes to the `php.ini` configuration file for your web server.

   The `php.ini` file is usually located in the following directory:

   * `/etc/php/7.2/apache2/` for Apache.
   * `/etc/php/7.2/fpm/` for NGINX.

   To find out the location of `php.ini`, run the command `sudo find /etc/ -name php.ini`.

   {% note info %}

   There is no need to make any changes to `php.ini` for the PHP CLI.

   {% endnote %}

   {% list tabs %}

   - {{ RD }} cluster with no sharding

      ```ini
      [PHP]
      ...
      extension = redis
      ...
      [Session]
      session.save_handler = redis
      session.save_path = "tcp://<FQDN of Redis master host>:6379?auth=<password>"
      ```

   - {{ RD }} cluster with sharding

      ```ini
      [PHP]
      ...
      extension = redis
      ...
      [Session]
      session.save_handler = rediscluster
      session.save_path = "seed[]=<FQDN1>:6379&seed[]=<FQDN2>:6379&seed[]=<FQDN3>:6379&auth=<password>"
      ```

      Where `<FQDN1>`, `<FQDN2>`, and `<FQDN3>` are fully qualified domain names of [cluster master hosts](../../managed-redis/operations/hosts.md#list). For example, for a cluster with 3 shards and the password `password`, the `session.save_path` parameter value looks like this:

      ```ini
      session.save_path = "seed[]=rc1a-t9h8gxqor5v6lcc3.{{ dns-zone }}:6379&seed[]=rc1b-7qxk0h3b8pupxsj9.{{ dns-zone }}:6379&seed[]=rc1c-spy1c1i4vwvj0n8z.{{ dns-zone }}:6379&auth=password"
      ```

   {% endlist %}

   For more information about how to connect to clusters, see [{#T}](../../managed-redis/operations/connect/index.md).

1. Restart the web server:

   * `sudo systemctl restart apache2` for Apache.
   * `sudo systemctl restart php7.2-fpm` for NGINX.

## Check whether PHP session data is saved to the {{ mrd-name }} cluster {#test-settings}

1. In the `/var/www/html/` directory, create a file `index.php` that will output powers of `2`:

   ```php
   <?php
   session_start();
   
   $count = isset($_SESSION['count']) ? $_SESSION['count'] : 1;
   
   echo $count;
   
   $_SESSION['count'] = $count * 2;
   ```

   Each time the page is refreshed, the output value will increase. The `$count` variable value will be saved in the session data. A unique key will be created for each session in {{ RD }}.

1. Connect to the {{ RD }} cluster from the VM via `redis-cli`:

   ```bash
   redis-cli -c -h <FQDN of master host> -a <password>
   ```

   Enter the following command to see what keys are stored in {{ RD }}:

   ```text
   KEYS *
   ```

   ```text
   (empty list or set)
   ```

   The returned result shows that no data is currently stored in {{ RD }}.

1. Check whether user sessions are saved when connecting to the web server:

   1. Enter the public IP of the VM hosting the web server in the browser address bar. The first time you open the page, `1` is output.
   1. Refresh the page several times: the output value will increase.
   1. Open the page from a different browser: the count will start with `1`.
   1. Refresh the page several times: the output value will increase, too.

   The fact that the value of the `$count` variable is saved between browser page updates shows that the configured PHP session storage mechanism in the {{ mrd-name }} cluster works properly.

1. Repeat the query to view the keys stored in {{ RD }}:

   ```text
   KEYS *
   ```

   ```text
   1) "PHPREDIS_SESSION:keb02haicgi0ijeju3ngqqnucq"
   2) "PHPREDIS_SESSION:c5r0mbe1v84pn2b5kj1umun1sp"
   ```

   The returned result shows that, for each session in {{ RD }}, its own key is created.

## Delete the resources you created {#clear-out}

{% list tabs %}

- Manually

   If you no longer need these resources, delete them:

   * [Delete the {{ mrd-full-name }} cluster](../../managed-redis/operations/cluster-delete.md).
   * [Delete the virtual machine](../../compute/operations/vm-control/vm-delete.md).
   * If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

- Using {{ TF }}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the configuration file (`redis-cluster-non-sharded-and-vm.tf` or `redis-cluster-sharded-and-vm.tf`).
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All resources described in the configuration file will be deleted.

{% endlist %}
