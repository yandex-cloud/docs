---
title: "Создание сайта на WordPress c БД MySQL - Инструкция"
description: "Пошаговая инструкция, с помощью которой вы научитесь быстро создавать сайт на Wordpress на базе данных MySQL в облаке. 3 простых шага, чтобы развернуть Wordpress сайт: создайте виртуальную машин, задайте настройки CMS Wordpress и настройте DNS."
keywords:
  - создание сайта wordpress
  - сайт wordpress
  - cms wordpress
  - настройка wordpress сайта
  - wordpress mysql
  - wordpress сайт на mysql
---

# Сайт на WordPress с кластером БД MySQL

С помощью этой инструкции вы научитесь разворачивать сайт на базе CMS WordPress с кластером баз данных под управлением СУБД MySQL в инфраструктуре {{ yandex-cloud }}.

Чтобы настроить веб-сайт на WordPress с MySQL-кластером:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину для WordPress](#create-vm).
1. [Создайте кластер БД MySQL](#create-clusters).
1. [Настройте веб-сервер Nginx](#configure-nginx).
1. [Установите WordPress и дополнительные компоненты](#install-wordpress).
1. [Настройте WordPress](#configure-wordpress).
1. [Проверьте работу веб-сайта](#test-site).
1. [Настройте DNS](#configure-dns).

Если сайт вам больше не нужен, [удалите все используемые им ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [prepare-register-billing](../_solutions_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки веб-сайта на WordPress с MySQL-кластером входит:

* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за кластер базы данных MySQL (см. [тарифы {{ mmy-full-name }}](../../managed-mysql/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте виртуальную машину для WordPress {#create-vm}

Чтобы создать виртуальную машину:

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.

2. В поле **Имя** введите имя виртуальной машины: `wp-mysql-tutorial-web`.

3. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.

4. В блоке **Образы из {{ marketplace-name }}** нажмите кнопку **Выбрать**. Выберите публичный образ **Debian 10**, **Ubuntu 18.04** или **CentOS 7**.

5. В блоке **Вычислительные ресурсы**:
    - Выберите [платформу](../../compute/concepts/vm-platforms.md).
    - Укажите необходимое количество vCPU и объем RAM:
       * **vCPU** — 2.
       * **Гарантированная доля vCPU** — 5%.
       * **RAM** — 1 ГБ.

6. В блоке **Сетевые настройки** выберите сеть и подсеть, к которым нужно подключить виртуальную машину. Если нужной сети или подсети еще нет, вы можете создать их прямо на странице создания ВМ.

7. В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

8. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH-ключ** вставьте содержимое файла открытого ключа.
      
      Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [раздел о подключении к виртуальным машинам по SSH](../../compute/operations/vm-connect/ssh.md).
      
    {% note alert %}
    
     IP-адрес и имя хоста (FQDN) для подключения к машине назначатся ей при создании. Если вы выбрали вариант **Без адреса** в поле **Публичный адрес**, вы не сможете обращаться к ВМ из интернета.
    
    {% endnote %}

9. Нажмите кнопку **Создать ВМ**.

Создание виртуальной машины может занять несколько минут. Когда виртуальная машина перейдет в статус `RUNNING`, вы можете переходить к следующему шагу.

При создании виртуальной машине назначается публичный IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.

## Создайте кластер БД MySQL {#create-cluster}

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Кластер MySQL**.

1. В поле **Имя** введите имя кластера: `wp-mysql-tutorial-db-cluster`.

1. В блоке **Класс хоста** выберите **s2.small**.

1. В блоке **Размер хранилища** укажите 10 ГБ.

1. В блоке **База данных**:
    - В поле **Имя БД** введите `wp-mysql-tutorial-db`.
    - В поле **Имя пользователя** введите `wordpress`.
    - В поле **Пароль** введите пароль, который вы будете использовать для доступа к базе.
    - В списке **Сеть** выберите сеть, к которой будет подключена ваша виртуальная машина.

1. В блоке **Хосты** добавьте еще два хоста в других зонах доступности. При создании хостов не включайте для них **Публичный доступ**.

1. В блоке **Настройки СУБД** нажмите кнопку **Настроить**. 

   В поле **Default authentication plugin** выберите пункт **mysql_native_password** и нажмите кнопку **Сохранить**.

1. Нажмите кнопку **Создать кластер**.

Создание кластера БД может занять несколько минут.

## Настройте веб-сервер Nginx {#configure-nginx}

После того как виртуальная машина `wp-mysql-tutorial-web` перейдет в статус `RUNNING`:

1. В блоке **Сеть** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес виртуальной машины.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

   Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на виртуальную машину.

1. Установите Nginx, менеджер процессов PHP-FPM и дополнительные пакеты:

   {% list tabs %}

   - Debian/Ubuntu

     ```bash
     $ sudo apt-get update -qq
     $ sudo apt-get install -y nginx-full php-fpm php-mysql
     $ sudo systemctl enable nginx
     ```

   - CentOS

     ```bash
     $ sudo yum -y install epel-release
     $ sudo yum -y install nginx
     $ sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
     $ sudo yum -y --enablerepo=remi-php72 install php php-mysql php-xml php-soap php-xmlrpc php-mbstring php-json php-gd php-mcrypt
     $ sudo yum -y --enablerepo=remi-php72 install php-fpm
     $ sudo systemctl enable nginx
     $ sudo systemctl enable php-fpm
     ```

   {% endlist %}

1. Задайте настройки веб-сервера в конфигурационных файлах Nginx:

   {% list tabs %}

   - Debian

     1. Вы можете отредактировать файл с помощью редактора `nano`:

         ```bash
         $ sudo nano /etc/nginx/sites-available/wordpress
         ```

     1. Приведите файл к виду:

         ```nginx
         server {
             listen 80 default_server;

             root /var/www/wordpress;
             index index.php;

             server_name <DNS-имя севера>;

             location / {
                 try_files $uri $uri/ =404;
             }

             error_page 404 /404.html;
             error_page 500 502 503 504 /50x.html;
             location = /50x.html {
                 root /usr/share/nginx/html;
             }

             location ~ \.php$ {
                 try_files $uri =404;
                 fastcgi_split_path_info ^(.+\.php)(/.+)$;
                 fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
                 fastcgi_index index.php;
                 fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                 include fastcgi_params;
             }
         }
         ```

     1. Разрешите запуск вашего сайта:

         ```bash
         $ sudo rm /etc/nginx/sites-enabled/default
         $ sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
         ```


   - Ubuntu

     1. Вы можете отредактировать файл с помощью редактора `nano`:
         ```bash
         $ sudo nano /etc/nginx/sites-available/wordpress
         ```

     1. Приведите файл к виду:

         ```nginx
         server {
             listen 80 default_server;

             root /var/www/wordpress;
             index index.php;

             server_name <DNS-имя севера>;

             location / {
                 try_files $uri $uri/ =404;
             }

             error_page 404 /404.html;
             error_page 500 502 503 504 /50x.html;
             location = /50x.html {
                 root /usr/share/nginx/html;
             }

             location ~ \.php$ {
                 try_files $uri =404;
                 fastcgi_split_path_info ^(.+\.php)(/.+)$;
                 fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
                 fastcgi_index index.php;
                 fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                 include fastcgi_params;
             }
         }
         ```

     1. Разрешите запуск вашего сайта:

         ```bash
         $ sudo rm /etc/nginx/sites-enabled/default
         $ sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
         ```


   - CentOS

     Вы можете отредактировать файлы `nginx.conf` и `wordpress.conf` с помощью редактора `nano`:

     1. Откройте файл `nginx.conf`:

         ```bash
         $ sudo nano /etc/nginx/nginx.conf
         ```

     1. Приведите файл к виду:

         ```nginx
         user nginx;
         worker_processes auto;
         error_log /var/log/nginx/error.log;
         pid /run/nginx.pid;
         include /usr/share/nginx/modules/*.conf;

         events {
             worker_connections 1024;
         }

         http {
             log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                               '$status $body_bytes_sent "$http_referer" '
                               '"$http_user_agent" "$http_x_forwarded_for"';

             access_log  /var/log/nginx/access.log  main;

             sendfile            on;
             tcp_nopush          on;
             tcp_nodelay         on;
             keepalive_timeout   65;
             types_hash_max_size 2048;

             include             /etc/nginx/mime.types;
             default_type        application/octet-stream;

             include /etc/nginx/conf.d/*.conf;
         }
         ```

     1. Откройте файл `wordpress.conf`:

         ```bash
         $ sudo nano /etc/nginx/wordpress.conf
         ```

     1. Приведите файл к виду:

         ```nginx
         server {
             listen 80 default_server;

             root /usr/share/nginx/wordpress/;
             index index.php;

             server_name <DNS-имя севера>;

             location / {
                 try_files $uri $uri/ =404;
             }

             error_page 404 /404.html;
             error_page 500 502 503 504 /50x.html;
             location = /50x.html {
                 root /usr/share/nginx/html;
             }

             location ~ \.php$ {
                 try_files $uri =404;
                 fastcgi_split_path_info ^(.+\.php)(/.+)$;
                 fastcgi_pass 127.0.0.1:9000;
                 fastcgi_index index.php;
                 fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                 include fastcgi_params;
             }
         }
         ```

   {% endlist %}

## Установите WordPress и дополнительные компоненты {#install-wordpress}

1. Загрузите и распакуйте последнюю версию WordPress:

   {% list tabs %}

   - Debian/Ubuntu

     ```bash
     $ wget https://wordpress.org/latest.tar.gz
     $ tar -xzf latest.tar.gz
     $ mv wordpress/wp-config-sample.php wordpress/wp-config.php
     $ sudo mv wordpress /var/www/wordpress
     $ sudo chown -R www-data:www-data /var/www/wordpress
     ```

   - CentOS

     ```bash
     $ curl https://wordpress.org/latest.tar.gz --output latest.tar.gz
     $ tar -xzf latest.tar.gz
     $ mv wordpress/wp-config-sample.php wordpress/wp-config.php
     $ sudo mv wordpress /usr/share/nginx/wordpress
     $ sudo chown -R nginx:nginx /usr/share/nginx/wordpress/
     ```
     Измените настройки SELinux:

     ```bash
     $ sudo semanage fcontext -a -t httpd_sys_content_t "/usr/share/nginx/wordpress(/.*)?"
     $ sudo semanage fcontext -a -t httpd_sys_rw_content_t "/usr/share/nginx/wordpress(/.*)?"
     $ sudo restorecon -R /usr/share/nginx/wordpress
     $ sudo setsebool -P httpd_can_network_connect 1
     ```

   {% endlist %}

1. Получите ключи безопасности WordPress:

   ```bash
   $ curl -s https://api.wordpress.org/secret-key/1.1/salt/
   ```

   Сохраните вывод команды — полученные ключи будут нужны на следующем шаге.

1. Добавьте ключи безопасности в конфигурационный файл WordPress `wp-config.php`. Вы можете отредактировать файл с помощью редактора `nano`:

   {% list tabs %}
   
   - Debian/Ubuntu

     ```bash
     $ sudo nano /var/www/wordpress/wp-config.php
     ```

   - CentOS

     ```bash
     $ sudo nano /usr/share/nginx/wordpress/wp-config.php
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

2. Перейдите к блоку конфигурации подключения к кластеру `wp-mysql-tutorial-db-cluster`:

   ```php
   // ** MySQL settings - You can get this info from your web host ** //
   /** The name of the database for WordPress */
       
   define( 'DB_NAME', '<DB_NAME>' );
   /** MySQL database username */
   define( 'DB_USER', '<DB_USER>' );

   /** MySQL database password */
   define( 'DB_PASSWORD', '<DB_PASSWORD>' );

   /** MySQL hostname */
   define( 'DB_HOST', '<DB_HOST>' );
   ```

   Укажите в файле вместо:
   - `<DB_NAME>` — имя БД `wp-mysql-tutorial-db`.
   - `<DB_USER>` — имя пользователя `wordpress`.
   - `<DB_PASSWORD>` — пароль, заданный при [создании кластера БД](#create-cluster).
   - `<DB_HOST>` — хост вида `c-<идентификатор мастера>.rw.mdb.yandexcloud.net`. Чтобы узнать идентификатор мастера, [получите список хостов](../../managed-mysql/operations/hosts.md#list) через CLI и скопируйте `CLUSTER ID` с ролью `MASTER`. 

3. Перезапустите Nginx и PHP-FPM:

   {% list tabs %}

   - Debian

     ```bash
     $ sudo systemctl restart nginx.service 
     $ sudo systemctl restart php7.3-fpm.service
     ```

   - Ubuntu

     ```bash
     $ sudo systemctl restart nginx.service 
     $ sudo systemctl restart php7.2-fpm.service
     ```

   - CentOS

     ```bash
     $ sudo systemctl restart nginx.service 
     $ sudo systemctl restart php-fpm.service
     ```

   {% endlist %}

## Настройте WordPress {#configure-wordpress}

1. В блоке **Сеть** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес виртуальной машины.

1. Перейдите по адресу виртуальной машины в браузере.

1. Выберите язык и нажмите кнопку **Продолжить**.

1. Заполните информацию для доступа к сайту:

   - Укажите любое название сайта, например, `yc-wordpress`.

   - Укажите имя пользователя, которое будет использоваться для входа в административную панель, например, `yc-user`.

   - Укажите пароль, который будет использоваться для входа в административную панель.

   - Укажите вашу электронную почту.

1. Нажмите кнопку **Установить WordPress**.

1. Если установка прошла успешно, нажмите кнопку **Войти**.

1. Войдите на сайт, используя указанные на прошлых шагах имя пользователя и пароль. После этого откроется административная панель, в которой можно приступать к работе с вашим сайтом.

## Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, перейдите по публичному IP-адресу виртуальной машины в браузере.

## Настройте DNS (если есть доменное имя) {#configure-dns}

Чтобы привязать сайт к домену, настройте DNS у вашего регистратора следующим образом:

* A-запись: поддомен `@`, в качестве адреса используйте публичный IP-адрес виртуальной машины.
* CNAME-запись: поддомен `www`, в качестве канонического имени используйте домен с точкой на конце, например: `example.com.`

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутый сайт, достаточно удалить [виртуальную машину](../../compute/operations/vm-control/vm-delete.md) `wp-mysql-tutorial-web` и [кластер MySQL](../../managed-mysql/operations/cluster-delete.md) `wp-mysql-tutorial-db-cluster`.

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:

1. Откройте сервис **Virtual Private Cloud** в вашем каталоге.
1. Перейдите на вкладку **IP-адреса**.
1. Найдите нужный адрес, нажмите значок ![ellipsis](../../_assets/options.svg) и выберите пункт **Удалить**. 
