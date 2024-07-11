1. Загрузите и распакуйте последнюю версию WordPress:

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

     Измените настройки SELinux:

     ```bash
     sudo semanage fcontext -a -t httpd_sys_content_t "/usr/share/nginx/wordpress(/.*)?"
     sudo semanage fcontext -a -t httpd_sys_rw_content_t "/usr/share/nginx/wordpress(/.*)?"
     sudo restorecon -R /usr/share/nginx/wordpress
     sudo setsebool -P httpd_can_network_connect 1
     ```

   {% endlist %}

1. Получите ключи безопасности WordPress:

   ```bash
   curl -s https://api.wordpress.org/secret-key/1.1/salt/
   ```

   Сохраните вывод команды — полученные ключи будут нужны на следующем шаге.
1. Добавьте ключи безопасности в конфигурационный файл WordPress `wp-config.php`. Вы можете отредактировать файл с помощью редактора `nano`:

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

   Замените блок конфигурации на значения, полученные на предыдущем шаге:

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

1. Перейдите к блоку конфигурации подключения к кластеру `wp-mysql-tutorial-db-cluster`:

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

   Укажите в файле вместо:
   * `<DB_NAME>` — имя БД `wp-mysql-tutorial-db`.
   * `<DB_USER>` — имя пользователя `wordpress`.
   * `<DB_PASSWORD>` — пароль, заданный при создании кластера БД.
   * `<DB_HOST>` — имя хоста {{ MY }} вида `XXXX-XXXXXXXXXX.{{ dns-zone }}`.

     Чтобы узнать FQDN хоста {{ MY }}:

	 {% list tabs group=instructions %}

	 - Консоль управления {#console}

	   1. Перейдите на страницу кластера {{ MY }} в [консоли управления]({{ link-console-main }}).
       1. На вкладке **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** рядом с БД нажмите значок ![image](../../../_assets/options.svg) → **{{ ui-key.yacloud.mdb.cluster.databases.button_action-connect }}**.
       1. Найдите строчку `mysql --host=ХХХХ-ХХХХХХХХХХ.{{ dns-zone }}`, где `ХХХХ-ХХХХХХХХХХ.{{ dns-zone }}` — это FQDN хоста с ролью `MASTER`.

     - CLI {#cli}

       [Получите список хостов](../../../managed-mysql/operations/hosts.md#list) и скопируйте `NAME` хоста с ролью `MASTER`:

       ```bash
       yc managed-mysql host list --cluster-name <имя_кластера_{{ MY }}>
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

1. Перезапустите Nginx и PHP-FPM:

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