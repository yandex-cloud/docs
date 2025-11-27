Add your domain to the array of trusted addresses and Nextcloud domains:

1. In the VM terminal, open the Nextcloud configuration file:

    ```bash
    sudo nano /var/www/nextcloud/config/config.php
    ```
1. In the `trusted_domains` array, replace the host IP address with your domain name.

    Here is an example:

    ```php
    'trusted_domains' =>
    array (
      0 => 'example.com',
    ),
    ```

    The `trusted_domains` array allows you to restrict the range of IP addresses and/or domains you can use to access Nextcloud and ensures additional protection from unauthorized access. You can specify multiple addresses and/or domains, and you can also reduce or remove this restriction using wildcard characters:

    {% list tabs %}

    - Example 1

      ```php
      'trusted_domains' =>
      array (
        0 => '*.example.com',
        1 => '198.168.*.*',
      ),
      ```

      In this example, access is allowed from any subdomains of the `example.com` domain and the IP addresses of the `192.168.0.0` - `192.168.255.255` range.

    - Example 2

      ```php
      'trusted_domains' =>
      array (
        0 => '*',
      ),
      ```

      In this example, access is allowed from any domains and IP addresses.

    {% endlist %}
1. Delete the `'overwrite.cli.url' => 'http://<VM_IP_address>',` line.
1. Save the changes and close the `nano` editor.