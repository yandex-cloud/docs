Next, you will create and publish on your web server a website that will generate signed links to content hosted on the secure CDN resource. For data transfer security, you will copy the previously created TLS certificate to the same web server and enable SSL encryption.


### Download the certificate from {{ certificate-manager-name }} {#export-certificate}

To use the TLS certificate created in {{ certificate-manager-name }} in your web server configuration, download the certificate chain and private key to the current directory:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  1. Learn the ID of the previously created TLS certificate:

      ```bash
      yc certificate-manager certificate list
      ```

      Result:

      ```text
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      |          ID          |     NAME      |           DOMAINS           |      NOT AFTER      |  TYPE   | STATUS |
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      | fpq90lobsh0l******** | mymanagedcert | cdn.example.com,example.com | 2024-03-22 16:42:53 | MANAGED | ISSUED |
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      ```

      For more information about the `yc certificate-manager certificate list` command, see the [CLI reference](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/list.md).

  1. Download the key and certificate by specifying the ID you got in the previous step:

      ```bash
      yc certificate-manager certificate content \
        --id <certificate_ID> \
        --chain ./certificate_full_chain.pem \
        --key ./private_key.pem
      ```

      For more information about the `yc certificate-manager certificate content` command, see the [CLI reference](../../../cli/cli-ref/certificate-manager/cli-ref/certificate/content.md).

{% endlist %}


### Configure the web server {#setup-web-server}

1. Copy the certificates and private key thus obtained to the VM hosting the web server:

    ```bash
    scp ./certificate_full_chain.pem yc-user@<VM_IP_address>:certificate_full_chain.pem \
      && scp ./private_key.pem yc-user@<VM_IP_address>:private_key.pem
    ```

    Where `<VM_IP_address>` is the public IP address of the previously created VM with a web server.

    You can find the VM IP address in the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the VM page using the [management console]({{ link-console-main }}) or this CLI command: `yc compute instance get mywebserver`.

    If this is your first time connecting to the VM, you will see an unknown host warning:

    ```text
    The authenticity of host '51.250.**.*** (51.250.**.***)' can't be established.
    ED25519 key fingerprint is SHA256:PpcKdcT09gjU045pkEIwIU8lAXXLpwJ6bKC********.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

    Type `yes` in the terminal and press **Enter**.

1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM with the web server:

    ```bash
    ssh yc-user@<VM_IP_address>
    ```

1. Create a directory for the certificate and move the copied files there:

    ```bash
    sudo mkdir /etc/ssl-certificates
    sudo mv certificate_full_chain.pem /etc/ssl-certificates/
    sudo mv private_key.pem /etc/ssl-certificates/
    ```

1. Create a directory for your website files and grant the required permissions for it to the `www-data` user:

    ```bash
    sudo mkdir -p /var/www/<domain_name>/public_html
    sudo chown www-data:www-data /var/www/<domain_name>/public_html
    ```

    Where `<domain_name>` is the domain name of your website, e.g., `example.com`.

1. Configure a virtual host for your website:

    1. Create a virtual host configuration file:

        ```bash
        sudo nano /etc/apache2/sites-available/mywebsite.conf
        ```

    1. Add the following configuration into the file:

        ```text
        <VirtualHost *:443>
        ServerName <domain_name>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/<domain_name>/public_html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        SSLEngine on
        SSLCertificateFile /etc/ssl-certificates/certificate_full_chain.pem
        SSLCertificateChainFile /etc/ssl-certificates/certificate_full_chain.pem
        SSLCertificateKeyFile /etc/ssl-certificates/private_key.pem
        </VirtualHost>
        ```

        Where `<domain_name>` is the domain name of your website, e.g., `example.com`.

    1. Activate the virtual host you created:

        ```bash
        sudo a2ensite mywebsite
        ```

        Result:

        ```text
        Enabling site mywebsite.
        To activate the new configuration, you need to run:
          systemctl reload apache2
        ```

    1. Enable `ssl` for the web server:

        ```bash
        sudo a2enmod ssl
        ```

        Result:

        ```text
        Considering dependency setenvif for ssl:
        Module setenvif already enabled
        Considering dependency mime for ssl:
        Module mime already enabled
        Considering dependency socache_shmcb for ssl:
        Enabling module socache_shmcb.
        Enabling module ssl.
        See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
        To activate the new configuration, you need to run:
          systemctl restart apache2
        ```

    1. Restart the web server:

        ```bash
        sudo systemctl reload apache2
        ```


### Create a website {#create-website}

1. Create the home page file for the website:

    ```bash
    sudo nano /var/www/<domain_name>/public_html/index.php
    ```

    Where `<domain_name>` is the domain name of your website, e.g., `example.com`.

1. Add the following code into the `index.php` file you created:

    ```php
    <!DOCTYPE html>
    <html>
    <head>
      <title>Secure token generator website</title>
      <meta charset="utf-8" />
    </head>
    <body>

      <h2>Secure link generator</h2>
      <p>Below, a signed link to the secure CDN resource has been generated. The link is valid for five minutes. The content at this link is available only to the user the link was generated for by the website (verified by IP address).</p>
      <br>

      <?php

        $secret = '<secret_key>';
        $ip = trim(getUserIpAddr());
        $domain_name = '<domain_name>';
        $path = '<object_key>';
        $expires = time() + 300;
        $link = "$expires$path$ip $secret";
        $md5 = md5($link, true);
        $md5 = base64_encode($md5);
        $md5 = strtr($md5, '+/', '-_');
        $md5 = str_replace('=', '', $md5);
        $url = '<a href="https://'.$domain_name.$path.'?md5='.$md5.'&expires='.$expires.'" target="_blank">Signed link to file</a>';
    
        echo "<p>Your IP address: <b>".$ip."</b></p><p>If you are using a VPN, you link may not work. For the signed link generator to work properly, disable your VPN.</p>";
        echo "<br><br>";
        echo $url;
    
        function getUserIpAddr() {

            if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
               $addr = $_SERVER['HTTP_CLIENT_IP'];
            } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
               $addr = $_SERVER['HTTP_X_FORWARDED_FOR'];
            } else {
               $addr = $_SERVER['REMOTE_ADDR'];
            }
            return $addr;
        }
      ?>

    </body>
    </html>
    ```

    Where:
    * `$secret`: Secret key created when configuring the CDN resource.
    * `$domain_name`: Domain name of the created CDN resource. For example, `cdn.example.com`.
    * `$path`: [Key of the object](../../../storage/concepts/object.md#key) in the [source](../../../cdn/concepts/origins.md) bucket, e.g., `/content.jpg`. It must contain `/`.
       The website will generate a signed link to access this object via the CDN resource.