Increase the amount of RAM available to the PHP interpreter for processing requests to Nextcloud to `512 MB`.

1. Open the `.htaccess` file in the Nextcloud installation directory:

    ```bash
    sudo nano /var/www/nextcloud/.htaccess
    ```
1. Add the following line to the end of the file:

    ```bash
    php_value memory_limit 512M
    ```

    Make sure to save your changes.