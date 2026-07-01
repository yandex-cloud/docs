# Создание сайта на WordPress с кластером базы данных MySQL® с помощью консоли управления

Чтобы создать инфраструктуру для [сайта на WordPress с кластером базы данных MySQL®](index.md) с помощью консоли управления Yandex Cloud:

Чтобы настроить сайт на WordPress с кластером MySQL®:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте ВМ для WordPress](#create-vm).
1. [Создайте кластер БД MySQL®](#create-cluster).
1. [Настройте веб-сервер Nginx](#configure-nginx).
1. [Установите WordPress и дополнительные компоненты](#install-wordpress).
1. [Завершите настройку WordPress](#configure-wordpress).
1. [Настройте DNS](#configure-dns).
1. [Проверьте работу сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Compute Cloud](../../../compute/pricing.md)).

* Кластер Managed Service for MySQL®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for MySQL®](../../../managed-mysql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../../vpc/pricing.md)).
* Публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md) ([тарифы Cloud DNS](../../../dns/pricing.md)).

## Создайте ВМ для WordPress {#create-vm}

Чтобы создать виртуальную машину для WordPress:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска** выберите один из публичных образов: [Debian 11](https://yandex.cloud/ru/marketplace/products/yc/debian-11), [Ubuntu 20.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts) или [CentOS 7](https://yandex.cloud/ru/marketplace/products/yc/centos-7).
  1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `2`.
      * **Гарантированная доля vCPU** — `20%`.
      * **RAM** — `2 ГБ`.
  
  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../../vpc/concepts/network.md#network) или [подсети](../../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../../vpc/operations/subnet-create.md).
      * В поле **Публичный IP-адрес** оставьте значение `Автоматически`, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

      * В поле **Логин** введите имя пользователя, например: `yc-user`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `wp-mysql-tutorial-web`.

      { % note alert %}

      IP-адрес и [имя хоста (FQDN)](../../../compute/concepts/network.md#hostname) для подключения к ВМ назначается ей при создании. Если вы выбрали вариант `Без адреса` в поле **Публичный IP-адрес**, вы не сможете обращаться к ВМ из интернета.

      {% endnote %}

  1. Нажмите **Создать ВМ**.

{% endlist %}

Создание ВМ может занять несколько минут. Когда ВМ перейдет в [статус](../../../compute/concepts/vm-statuses.md) `RUNNING`, вы можете переходить к следующему шагу.

При создании ВМ назначается публичный IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.

## Создайте кластер БД MySQL® {#create-cluster}

Чтобы создать кластер БД MySQL®:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления](https://console.yandex.cloud) нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **Создать ресурс** и выберите **Кластер MySQL**.
  1. В поле **Имя кластера** введите имя: `wp-mysql-tutorial-db-cluster`.
  1. В блоке **Класс хоста** выберите `s3-c2-m8`.
  1. В блоке **Размер хранилища** укажите `10 ГБ`.
  1. В блоке **База данных**:
     * В поле **Имя БД** введите `wp-mysql-tutorial-db`.
     * В поле **Имя пользователя** введите `wordpress`.
     * В поле **Пароль** введите пароль, который вы будете использовать для доступа к БД.
  1. В блоке **Сетевые настройки** выберите сеть, к которой будет подключен кластер.


  1. В блоке **Хосты** добавьте еще два [хоста](../../concepts/instance-types.md) в других зонах доступности. При создании хостов не включайте для них **Публичный доступ**.


  1. В блоке **Настройки СУБД** нажмите кнопку **Настроить**.

     В поле **default_authentication_plugin** выберите пункт `mysql_native_password` и нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Создать кластер**.

{% endlist %}

Создание кластера БД может занять несколько минут.

## Настройте веб-сервер Nginx {#configure-nginx}

После того как ВМ `wp-mysql-tutorial-web` перейдет в статус `RUNNING`:
1. В блоке **Сеть** на странице ВМ в [консоли управления](https://console.yandex.cloud) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

   Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на ВМ.
1. Установите Nginx, менеджер процессов PHP-FPM и дополнительные пакеты:

   {% list tabs group=operating_system %}

   - Debian/Ubuntu {#ubuntu}

     ```bash
     sudo apt-get update
     sudo apt-get install -y nginx-full php-fpm php-mysql
     sudo systemctl enable nginx
     ```

   - CentOS {#centos}

     ```bash
     sudo yum -y install epel-release
     sudo yum -y install nginx
     sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
     sudo yum -y --enablerepo=remi-php74 install php php-mysql php-xml php-soap php-xmlrpc php-mbstring php-json php-gd php-mcrypt
     sudo yum -y --enablerepo=remi-php74 install php-fpm
     sudo systemctl enable nginx
     sudo systemctl enable php-fpm
     ```

   {% endlist %}

1. Задайте настройки веб-сервера в конфигурационных файлах Nginx:

   {% list tabs group=operating_system %}

   - Debian/Ubuntu {#ubuntu}

     1. Вы можете отредактировать файл с помощью редактора `nano`:

        ```bash
        sudo nano /etc/nginx/sites-available/wordpress
        ```

     1. Приведите файл к виду:

        ```nginx
        server {
          listen 80 default_server;

          root /var/www/wordpress;
          index index.php;

          server_name <DNS-имя_сервера>;

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
            fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include fastcgi_params;
          }
        }
        ```

     1. Разрешите запуск вашего сайта:

        ```bash
        sudo rm /etc/nginx/sites-enabled/default
        sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
        ```

   - CentOS {#centos}

     Вы можете отредактировать файлы `nginx.conf` и `wordpress.conf` с помощью редактора `nano`:
     1. Откройте файл `nginx.conf`:

        ```bash
        sudo nano /etc/nginx/nginx.conf
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

          access_log  /var/log/nginx/access.log main;

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
        sudo nano /etc/nginx/conf.d/wordpress.conf
        ```

     1. Приведите файл к виду:

        ```nginx
        server {
          listen 80 default_server;

          root /usr/share/nginx/wordpress/;
          index index.php;

          server_name <DNS-имя_сервера>;

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
   curl --silent https://api.wordpress.org/secret-key/1.1/salt/
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
   // ** MySQL® settings - You can get this info from your web host. ** //
   /** The name of the database for WordPress. */

   define( 'DB_NAME', '<DB_NAME>' );
   /** MySQL® database username. */
   define( 'DB_USER', '<DB_USER>' );

   /** MySQL® database password. */
   define( 'DB_PASSWORD', '<DB_PASSWORD>' );

   /** MySQL® hostname. */
   define( 'DB_HOST', '<DB_HOST>' );
   ```

   Укажите в файле вместо:
   * `<DB_NAME>` — имя БД `wp-mysql-tutorial-db`.
   * `<DB_USER>` — имя пользователя `wordpress`.
   * `<DB_PASSWORD>` — пароль, заданный при создании кластера БД.
   * `<DB_HOST>` — имя хоста MySQL® вида `XXXX-XXXXXXXXXX.mdb.yandexcloud.net`.

     Чтобы узнать FQDN хоста MySQL®:

	 {% list tabs group=instructions %}

	 - Консоль управления {#console}

	   1. Перейдите на страницу кластера MySQL® в [консоли управления](https://console.yandex.cloud).
       1. На вкладке **Базы данных** рядом с БД нажмите значок ![image](../../../_assets/options.svg) → **Подключиться**.
       1. Найдите строчку `mysql --host=ХХХХ-ХХХХХХХХХХ.mdb.yandexcloud.net`, где `ХХХХ-ХХХХХХХХХХ.mdb.yandexcloud.net` — это FQDN хоста с ролью `MASTER`.

     - CLI {#cli}

       [Получите список хостов](../../operations/hosts.md#list) и скопируйте `NAME` хоста с ролью `MASTER`:

       ```bash
       yc managed-mysql host list --cluster-name <имя_кластера_MySQL®>
       ```

       
       ```text
       +------------------------+----------------------+---------+--------+-------------------+-----------+
       |           NAME         |      CLUSTER ID      |  ROLE   | HEALTH |      ZONE ID      | PUBLIC IP |
       +------------------------+----------------------+---------+--------+-------------------+-----------+
       | rc1a-...mdb.yandexcloud.net | c9quhb1l32unm1sdn0in | MASTER  | ALIVE  | ru-central1-a | false     |
       | rc1b-...mdb.yandexcloud.net | c9quhb1l32unm1sdn0in | REPLICA | ALIVE  | ru-central1-b | false     |
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

## Завершите настройку WordPress {#configure-wordpress}

1. В блоке **Сеть** на странице ВМ в [консоли управления](https://console.yandex.cloud) найдите публичный IP-адрес ВМ.
1. Перейдите по адресу ВМ в браузере.
1. Выберите язык и нажмите кнопку **Продолжить**.
1. Заполните информацию для доступа к сайту:
   * Укажите любое название сайта, например, `wp-your-project`.
   * Укажите имя пользователя, которое будет использоваться для входа в административную панель, например, `admin`.
   * Укажите пароль, который будет использоваться для входа в административную панель.
   * Укажите вашу электронную почту.
1. Нажмите кнопку **Установить WordPress**.
1. Если установка прошла успешно, нажмите кнопку **Войти**.
1. Войдите на сайт, используя указанные на прошлых шагах имя пользователя и пароль. После этого откроется административная панель, в которой можно приступать к работе с вашим сайтом.

## Настройте DNS {#configure-dns}

Если у вас есть зарегистрированное доменное имя, воспользуйтесь сервисом Cloud DNS для управления доменом.

В инструкции ниже описана настройка DNS для доменного имени `example.com`.

### Добавьте зону DNS {#create-dns-zone}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы добавить [публичную зону DNS](../../../dns/concepts/dns-zone.md#public-zones):
   1. Перейдите в сервис **Cloud DNS** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется создать [зону DNS](../../../dns/concepts/dns-zone.md).
   1. Нажмите кнопку **Создать зону**.
   1. Задайте настройки зоны DNS:
      * **Зона** — `example.com.`. Или укажите ваш зарегистрированный домен.
      * **Тип** — `Публичная`.
      * **Имя** — `example-zone-1`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Добавьте ресурсные записи {#create-dns-records}

Создайте в публичной зоне записи DNS:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В блоке **Сеть** на странице [виртуальной машины](../../../compute/concepts/vm.md) в [консоли управления](https://console.yandex.cloud) найдите [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ.
   1. Создайте запись [типа А](../../../dns/concepts/resource-record.md#a):
      * Откройте раздел **Cloud DNS** в каталоге, где находится зона DNS `example.com`.
      * Выберите зону DNS `example.com` из списка.
      * Нажмите кнопку **Создать запись**.
      * Задайте параметры записи:
         * **Имя** — оставьте пустым.
         * **Тип** — оставьте значение `А`.
         * **Значение** — введите публичный адрес вашей ВМ.
         * **TTL (в секундах)** (время кеширования записи) — оставьте значение по умолчанию.
      * Нажмите кнопку **Создать**.
   1. Создайте запись [типа CNAME](../../../dns/concepts/resource-record.md#cname):
      * Выберите зону DNS `example.com` из списка.
      * Нажмите кнопку **Создать запись**.
      * Задайте параметры записи:
         * **Имя** — `www`.
         * **Тип** — выберите значение `CNAME`.
         * **Значение** — введите `example.com`.
         * **TTL (в секундах)** (время кеширования записи) — оставьте значение по умолчанию.
      * Нажмите кнопку **Создать**.

{% endlist %}

### Делегируйте доменное имя {#delegate-domain}

Делегирование — это перенос ответственности с серверов регистратора на ваши серверы. Для домена создаются ресурсные записи [типа NS](../../../dns/concepts/resource-record.md#ns) (`ns1.yandexcloud.net` и `ns2.yandexcloud.net`).

Чтобы делегировать домен, укажите для него DNS-серверы в личном кабинете регистратора.

Делегирование происходит не сразу. Серверы интернет-провайдеров обычно обновляют записи в течение 24 часов (86 400 секунд). Это обусловлено значением TTL, в течение которого кешируются записи для доменов.

Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

```bash
dig +short NS example.com
```

Результат:

```text
ns2.yandexcloud.net.
ns1.yandexcloud.net.
```

## Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, введите в браузере его IP-адрес или доменное имя:
* `http://<публичный_IP-адрес_ВМ>`.
* `http://www.example.com`.

Для входа в панель управления WordPress используйте адрес `http://www.example.com/wp-admin/`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../../dns/operations/zone-delete.md) зону DNS.
1. [Удалите](../../operations/cluster-delete.md) кластер MySQL®.
1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ.

Если вы зарезервировали для ВМ статический публичный IP-адрес, [удалите его](../../../vpc/operations/address-delete.md).

#### Полезные ссылки {#see-also}

* [Создание сайта на WordPress с кластером базы данных MySQL® с помощью Terraform](terraform.md)