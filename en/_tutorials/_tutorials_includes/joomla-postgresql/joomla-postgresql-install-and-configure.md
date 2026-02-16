At this step, you will prepare the VM environment to deploy and set up Joomla.

1. Export the `joomla-cert` TLS certificate to your local computer:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
        1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}** and choose `joomla-cert`.
        1. In the top panel, click ![ArrowUpFromLine](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_export }}**, select `{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_no_private_key }}`, and click **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_download }}**. A file with the `certificate.pem` certificate will be saved to your computer.
        1. Repeat the previous step and download the private key by selecting `{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_private_key_only }}`. Rename the downloaded private key file to `private_key.pem`.
        1. Save the downloaded `certificate.pem` and `private_key.pem` files: you will need them to configure the web server.

    {% endlist %}

1. Copy the certificate and private key to the VM:

    ```bash
    scp ./certificate.pem yc-user@<VM_IP_address>:certificate.pem \
      && scp ./private_key.pem yc-user@<VM_IP_address>:private_key.pem
    ```

    Where `<VM_IP_address>` is the public IP address of the previously created `joomla-web-server` VM.

    You can find the VM IP address in the [management console]({{ link-console-main }}) on the VM page under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.

    If this is your first time connecting to the VM, you will get this unknown host warning:

    ```text
    The authenticity of host '51.250.**.*** (51.250.**.***)' can't be established.
    ED25519 key fingerprint is SHA256:PpcKdcT09gjU045pkEIwIU8lAXXLpwJ6bKC********.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

    Type `yes` into the terminal and press **Enter**.

1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM over SSH:

    ```bash
    ssh yc-user@<VM_IP_address>
    ```
1. Create a directory for the certificate and move the copied files there:

    ```bash
    sudo mkdir /etc/ssl-certificates
    sudo mv certificate.pem /etc/ssl-certificates/
    sudo mv private_key.pem /etc/ssl-certificates/
    ```
1. Upgrade the versions of the packages installed on the VM:

    ```bash
    sudo apt update && sudo apt upgrade -y
    ```
1. Install and run the [Apache HTTP server](https://en.wikipedia.org/wiki/Apache_HTTP_Server):

    ```bash
    sudo apt install apache2
    sudo systemctl start apache2 && sudo systemctl enable apache2
    ```
1. Install [PHP](https://en.wikipedia.org/wiki/PHP) with the required libraries:

    ```bash
    sudo apt install php libapache2-mod-php php-common php-pgsql php-xml php-mbstring php-curl php-zip php-intl php-json unzip
    ```
1. Download and unpack the Joomla package:

    {% note info %}

    This example uses a link to Joomla `5.2.4`, the latest version at the time of writing this guide. To check for a newer version and get the download link, visit the project [website](https://downloads.joomla.org/).

    {% endnote %}

    ```bash
    wget https://downloads.joomla.org/cms/joomla5/5-2-4/Joomla_5-2-4-Stable-Full_Package.zip -O Joomla.zip
    sudo rm /var/www/html/index.html
    sudo unzip Joomla.zip -d /var/www/html
    rm Joomla.zip
    ```
1. Set up access permissions for the website directory:

    ```
    sudo chown -R www-data:www-data /var/www/html
    sudo chmod -R 755 /var/www/html
    ```
1. Change the number of the default port used by Joomla to access {{ PG }} databases: {{ mpg-full-name }} uses port `6432`.

    1. Open the Joomla database access driver configuration file:

        ```bash
        sudo nano /var/www/html/libraries/vendor/joomla/database/src/Pdo/PdoDriver.php
        ```
    1. In the file, find the section with {{ PG }} database settings and change the port number from `5432` to `6432`:

        ```php
        ...
        case 'pgsql':
        $this->options['port'] = $this->options['port'] ?? 6432;
        ...
        ```

        Make sure to save your changes.
1. Configure a virtual host for your website:

    1. Create a virtual host configuration file:

        ```bash
        sudo nano /etc/apache2/sites-available/joomla.conf
        ```

    1. Add the following configuration into the file:

        ```text
        <VirtualHost *:80>
            ServerAdmin admin@localhost
            DocumentRoot /var/www/html
            ServerName <domain_name>

            <Directory /var/www/html>
                Options FollowSymLinks
                AllowOverride All
                Require all granted
            </Directory>

            ErrorLog ${APACHE_LOG_DIR}/joomla_http_error.log
            CustomLog ${APACHE_LOG_DIR}/joomla_http_access.log combined
        </VirtualHost>

        <VirtualHost *:443>
            ServerAdmin admin@localhost
            DocumentRoot /var/www/html
            ServerName <domain_name>

            ErrorLog ${APACHE_LOG_DIR}/joomla_ssl_error.log
            CustomLog ${APACHE_LOG_DIR}/joomla_ssl_access.log combined

            SSLEngine on
            SSLCertificateFile /etc/ssl-certificates/certificate.pem
            SSLCertificateChainFile /etc/ssl-certificates/certificate.pem
            SSLCertificateKeyFile /etc/ssl-certificates/private_key.pem
        </VirtualHost>
        ```

        Where `<domain_name>` is the domain name of your website, e.g., `example.com`.
1. Activate the virtual host and restart the web server:

    ```bash
    sudo a2ensite joomla.conf
    sudo a2enmod rewrite
    sudo a2enmod ssl
    sudo systemctl restart apache2
    ```