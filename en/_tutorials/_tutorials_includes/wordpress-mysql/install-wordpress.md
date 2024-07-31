1. Download and unpack the latest WordPress version:

   {% list tabs group=operating_system %}

   - Debian/Ubuntu {#ubuntu}

      ```bash
      wget https://wordpress.org/latest.tar.gz
      tar -xzf latest.tar.gz
      mv wordpress/wp-config-sample.php wordpress/wp-config.php
      sudo mv wordpress /var/www/wordpress
      sudo chown -R www-data:www-data /var/www/wordpress
      ```

   - CentOS {#centos}

      ```bash
      curl https://wordpress.org/latest.tar.gz --output latest.tar.gz
      tar -xzf latest.tar.gz
      mv wordpress/wp-config-sample.php wordpress/wp-config.php
      sudo mv wordpress /usr/share/nginx/wordpress
      sudo chown -R nginx:nginx /usr/share/nginx/wordpress/
      ```

      Change the SELinux settings:

      ```bash
      sudo semanage fcontext -a -t httpd_sys_content_t "/usr/share/nginx/wordpress(/.*)?"
      sudo semanage fcontext -a -t httpd_sys_rw_content_t "/usr/share/nginx/wordpress(/.*)?"
      sudo restorecon -R /usr/share/nginx/wordpress
      sudo setsebool -P httpd_can_network_connect 1
      ```

   {% endlist %}

1. Get WordPress security keys:

   ```bash
   curl -s https://api.wordpress.org/secret-key/1.1/salt/
   ```

   Save the command output. You will need the keys in the next step.
1. Add the security keys to the WordPress configuration file `wp-config.php`. You can edit files in the `nano` editor:

   {% list tabs group=operating_system %}

   - Debian/Ubuntu {#ubuntu}

      ```bash
      sudo nano /var/www/wordpress/wp-config.php
      ```

   - CentOS {#centos}

      ```bash
      sudo nano /usr/share/nginx/wordpress/wp-config.php
      ```

   {% endlist %}

   Replace the configuration section for the values from the previous step:

   ```php
   define('AUTH_KEY',         't vz,|............R lZ5]');
   define('SECURE_AUTH_KEY',  '@r&pPD............dK-A%=');
   define('LOGGED_IN_KEY',    '%6TuLl............9>/dNE');
   define('NONCE_KEY',        'DO(u.H............$?ja-e');
   define('AUTH_SALT',        '|G Vo<............Xeb.~y');
   define('SECURE_AUTH_SALT', 'Y5tIYA............7Lxf8J');
   define('LOGGED_IN_SALT',   'gR]>WZ............<>|;YY');
   define('NONCE_SALT',       '=]nQIb............HLT2:9');
   ```

1. Go to the cluster connection configuration section `wp-mysql-tutorial-db-cluster`:

   ```php
   // ** {{ MY }} settings - You can get this info from your web host. ** //
   /** The name of the database for WordPress. */

   define( 'DB_NAME', '<DB_NAME>' );
   /** {{ MY }} database username. */
   define( 'DB_USER', '<DB_USER>' );

   /** {{ MY }} database password. */
   define( 'DB_PASSWORD', '<DB_PASSWORD>' );

   /** {{ MY }} hostname. */
   define( 'DB_HOST', '<DB_HOST>' );
   ```

   Replace the placeholders in the file:
   * `<DB_NAME>`: DB name, `wp-mysql-tutorial-db`.
   * `<DB_USER>`: `wordpress` username.
   * `<DB_PASSWORD>`: Password you set when creating a database cluster.
   * `<DB_HOST>`: {{ MY }} host name in `XXXX-XXXXXXXXXX.{{ dns-zone }}` format.

      To find out the FQDN of your {{ MY }} host:

      {% list tabs group=instructions %}

      - Management console {#console}

         1. Go to the {{ MY }} cluster page in the [management console]({{ link-console-main }}).
         1. On the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab next to the DB, click ![image](../../../_assets/options.svg) → **{{ ui-key.yacloud.mdb.cluster.databases.button_action-connect }}**.
         1. Locate the `mysql --host=ХХХХ-ХХХХХХХХХХ.{{ dns-zone }}` line, where `ХХХХ-ХХХХХХХХХХ.{{ dns-zone }}` is the FQDN of the `MASTER` host.

      - CLI {#cli}

         [Get a host list](../../../managed-mysql/operations/hosts.md#list) and copy the `NAME` of the `MASTER` host:

         ```bash
         yc managed-mysql host list --cluster-name <{{ MY }}_cluster_name>
         ```

         
         ```text
         +------------------------+----------------------+---------+--------+-------------------+-----------+
         |           NAME         |      CLUSTER ID      |  ROLE   | HEALTH |      ZONE ID      | PUBLIC IP |
         +------------------------+----------------------+---------+--------+-------------------+-----------+
         | rc1a-...{{ dns-zone }} | c9quhb1l32unm1sdn0in | MASTER  | ALIVE  | {{ region-id }}-a | false     |
         | rc1b-...{{ dns-zone }} | c9quhb1l32unm1sdn0in | REPLICA | ALIVE  | {{ region-id }}-b | false     |
         +------------------------+----------------------+---------+--------+-------------------+-----------+
         ```


      {% endlist %}

1. Restart Nginx and PHP-FPM:

   {% list tabs group=operating_system %}

   - Debian/Ubuntu {#ubuntu}

      ```bash
      sudo systemctl restart nginx.service
      sudo systemctl restart php7.4-fpm.service
      ```

   - CentOS {#centos}

      ```bash
      sudo systemctl restart nginx.service
      sudo systemctl restart php-fpm.service
      ```

   {% endlist %}