# Using {{ mrd-name }} clusters as PHP session storage

You can use {{ mrd-name }} clusters for storing PHP session data.

To configure a {{ mrd-name }} cluster as PHP session storage:

1. [{#T}](#settings-php).
1. [{#T}](#test-settings).

## Before you start {#before-you-begin}

1. [Set up the {{ vpc-name }}](../../vpc/operations/security-group-update.md#add-rule) security group. Add TCP settings to the security group to allow the following:
      * Incoming traffic through port `22` from any IP addresses for SSH.
      * Outgoing and incoming traffic through ports `80` and `443` to and from any IP address for HTTP/HTTPS.
      * Outgoing and incoming traffic through port `6379` to and from internal network IP addresses for {{ RD }}.

    For more information, see [{#T}](../../vpc/concepts/security-groups.md).

1. [Create a VM with LAMP/LEMP](../../tutorials/web/lamp-lemp.md#create-vm) in {{ compute-full-name }} with any suitable configuration.

    When creating a VM, select the security group that you set up earlier. To check the security settings, enter the VM's public IP address in the browser address bar: the default page of the web server should be displayed.

1. [Connect to the VM with the web server via SSH and configure it](../../compute/operations/vm-connect/ssh.md):

    * Install certificates:

        ```bash
        mkdir --parents {{ crt-local-dir }} && \
        wget "{{ s3-storage-host }}{{ pem-path }}" \
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

2. [Create a {{ mrd-name }} cluster](../operations/cluster-create.md) with any suitable configuration. When creating a {{ mrd-name }} cluster, under **Network settings**, specify the same network and security groups as those of the VM hosting the web server.

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

        Where `<FQDN1>`, `<FQDN2>`, and `<FQDN3>` are fully qualified domain names of [cluster master hosts](../operations/hosts.md#list). For example, for a cluster with 3 shards and the `password` password, the `session.save_path` parameter value looks like this:

        ```ini
        session.save_path = "seed[]=rc1a-t9h8gxqor5v6lcc3.{{ dns-zone }}:6379&seed[]=rc1b-7qxk0h3b8pupxsj9.{{ dns-zone }}:6379&seed[]=rc1c-spy1c1i4vwvj0n8z.{{ dns-zone }}:6379&auth=password"
        ```

    {% endlist %}

    For more information about how to connect to clusters, see [{#T}](../operations/connect/index.md).

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
    1) "PHPREDIS_SESSION:keb02haicgi0ijeju3ngqqnucq"
    2) "PHPREDIS_SESSION:c5r0mbe1v84pn2b5kj1umun1sp"
    ```

    The returned result shows that, for each session in {{ RD }}, its own key is created.

