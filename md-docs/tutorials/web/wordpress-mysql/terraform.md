[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Прикладные решения > Создание сайта > Сайт на WordPress > [Сайт на WordPress с БД MySQL®](index.md) > Terraform

# Создание сайта на WordPress с кластером базы данных MySQL® с помощью Terraform

Чтобы создать инфраструктуру для [сайта на WordPress с кластером базы данных MySQL®](index.md) c помощью Terraform:

Чтобы настроить сайт на WordPress с кластером MySQL®:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте веб-сервер Nginx](#configure-nginx).
1. [Установите WordPress и дополнительные компоненты](#install-wordpress).
1. [Завершите настройку WordPress](#configure-wordpress).
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

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры c помощью Terraform:
1. [Установите Terraform](../../infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файлов.
     1. Скачайте [архив](https://storage.yandexcloud.net/doc-files/wordpress-mysql.zip) (1 КБ).
     1. Разархивируйте архив в папку. В результате в ней должен появиться конфигурационный файл `wordpress-mysql.tf`.

   - Вручную {#manual}

     1. Создайте папку для файлов.
     1. Создайте в папке конфигурационный файл `wordpress-mysql.tf`:

        {% cut "wordpress-mysql.tf" %}

        ```hcl
        terraform {
          required_providers {
            yandex = {
              source  = "yandex-cloud/yandex"
              version = ">= 0.47.0"
            }
          }
        }
        
        provider "yandex" {
          zone = "ru-central1-a"
        }
        
        resource "yandex_compute_disk" "boot-disk" {
          name     = "bootvmdisk"
          type     = "network-hdd"
          zone     = "ru-central1-a"
          size     = "20"
          image_id = "<идентификатор_образа>"
        }
        
        resource "yandex_compute_instance" "vm-wordpress-mysql" {
          name        = "wp-mysql-tutorial-web"
          platform_id = "standard-v3"
          zone        = "ru-central1-a"
        
          resources {
            core_fraction = 20
            cores         = 2
            memory        = 2
          }
        
          boot_disk {
            disk_id = yandex_compute_disk.boot-disk.id
          }
        
          network_interface {
            subnet_id          = yandex_vpc_subnet.subnet-1.id
            security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]
            nat                = true
          }
        
          metadata = {
            ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
          }
        }
        
        resource "yandex_mdb_mysql_cluster" "wp-cluster" {
          name                = "wp-mysql-tutorial-db-cluster"
          environment         = "PRESTABLE"
          network_id          = yandex_vpc_network.network-1.id
          version             = "8.0"
          security_group_ids  = ["${yandex_vpc_security_group.sg-1.id}"]
        
          resources {
            resource_preset_id = "s2.small"
            disk_type_id       = "network-ssd"
            disk_size          = "10"
          }
        
          host {
            zone             = "ru-central1-a"
            subnet_id        = yandex_vpc_subnet.subnet-1.id
            assign_public_ip = false
          }
        
          host {
            zone             = "ru-central1-b"
            subnet_id        = yandex_vpc_subnet.subnet-2.id
            assign_public_ip = false
          }
        
          host {
            zone             = "ru-central1-d"
            subnet_id        = yandex_vpc_subnet.subnet-3.id
            assign_public_ip = false
          }
        }
        
        resource "yandex_mdb_mysql_database" "wp-db" {
          cluster_id = yandex_mdb_mysql_cluster.wp-cluster.id
          name       = "wp-mysql-tutorial-db"
        }
        
        resource "yandex_mdb_mysql_user" "wp-user" {
          cluster_id            = yandex_mdb_mysql_cluster.wp-cluster.id
          name                  = "wordpress"
          password              = "password"
          authentication_plugin = "MYSQL_NATIVE_PASSWORD"
          permission {
            database_name = yandex_mdb_mysql_database.wp-db.name
            roles         = ["ALL"]
          }
        }
        
        resource "yandex_vpc_security_group" "sg-1" {
          name        = "wordpress"
          description = "Description for security group"
          network_id  = yandex_vpc_network.network-1.id
        
          ingress {
            protocol       = "TCP"
            description    = "ext-http"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 80
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ext-ssh"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 22
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ext-msql"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 3306
          }
        
          ingress {
            protocol       = "TCP"
            description    = "ext-https"
            v4_cidr_blocks = ["0.0.0.0/0"]
            port           = 443
          }
        
          egress {
            protocol       = "ANY"
            description    = "any"
            v4_cidr_blocks = ["0.0.0.0/0"]
          }
        }
        
        resource "yandex_vpc_network" "network-1" {
          name = "network1"
        }
        
        resource "yandex_vpc_subnet" "subnet-1" {
          name           = "subnet1"
          zone           = "ru-central1-a"
          network_id     = yandex_vpc_network.network-1.id
          v4_cidr_blocks = ["192.168.1.0/24"]
        }
        
        resource "yandex_vpc_subnet" "subnet-2" {
          name           = "subnet2"
          zone           = "ru-central1-b"
          network_id     = yandex_vpc_network.network-1.id
          v4_cidr_blocks = ["192.168.2.0/24"]
        }
        
        resource "yandex_vpc_subnet" "subnet-3" {
          name           = "subnet3"
          zone           = "ru-central1-d"
          network_id     = yandex_vpc_network.network-1.id
          v4_cidr_blocks = ["192.168.3.0/24"]
        }
        
        resource "yandex_dns_zone" "zone-1" {
          name        = "example-zone-1"
          description = "Public zone"
          zone        = "example.com."
          public      = true
        }
        
        resource "yandex_dns_recordset" "rs-1" {
          zone_id = yandex_dns_zone.zone-1.id
          name    = "example.com."
          ttl     = 600
          type    = "A"
          data    = ["${yandex_compute_instance.vm-wordpress-mysql.network_interface.0.nat_ip_address}"]
        }
        
        resource "yandex_dns_recordset" "rs-2" {
          zone_id = yandex_dns_zone.zone-1.id
          name    = "www"
          ttl     = 600
          type    = "CNAME"
          data    = ["example.com"]
        }
        ```

        {% endcut %}

   {% endlist %}

   Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:

    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
    * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
    * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md).
    * [Кластер MySQL®](../../../managed-mysql/concepts/index.md) — [yandex_mdb_mysql_cluster](../../../terraform/resources/mdb_mysql_cluster.md).
    * [БД PostgreSQL](../../../managed-mysql/index.md) — [yandex_mdb_mysql_database](../../../terraform/resources/mdb_mysql_database.md).
    * [Пользователь БД](../../../managed-mysql/concepts/user-rights.md) — [yandex_mdb_mysql_user](../../../terraform/resources/mdb_mysql_user.md).
    * [Зона DNS](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md).
    * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md).

1. В блоке `metadata` укажите [метаданные](../../../compute/concepts/vm-metadata.md) для создания ВМ `<имя_пользователя>:<содержимое_SSH-ключа>`. Указанное имя пользователя не играет роли, ключ будет присвоен пользователю, который задан в конфигурации образа. В разных образах это разные пользователи. Подробнее в разделе [Ключи, обрабатываемые в публичных образах Yandex Cloud](../../../compute/concepts/metadata/public-image-keys.md).
1. В блоке `boot_disk` укажите идентификатор одного из [образов](../../../compute/operations/images-with-pre-installed-software/get-list.md) ВМ с нужным набором компонентов:
   * [Debian 11](https://yandex.cloud/ru/marketplace/products/yc/debian-11).
   * [Ubuntu 20.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts).
   * [CentOS 7](https://yandex.cloud/ru/marketplace/products/yc/centos-7).
1. Создайте ресурсы:

   1. В терминале перейдите в директорию с конфигурационным файлом.
   1. Проверьте корректность конфигурации с помощью команды:
   
      ```bash
      terraform validate
      ```
   
      Если конфигурация является корректной, появится сообщение:
   
      ```bash
      Success! The configuration is valid.
      ```
   
   1. Выполните команду:
   
      ```bash
      terraform plan
      ```
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

После создания инфраструктуры, [настройте веб-сервер Nginx](#configure-nginx).
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

       [Получите список хостов](../../../managed-mysql/operations/hosts.md#list) и скопируйте `NAME` хоста с ролью `MASTER`:

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

## Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, введите в браузере его IP-адрес или доменное имя:
* `http://<публичный_IP-адрес_ВМ>`.
* `http://www.example.com`.

Для входа в панель управления WordPress используйте адрес `http://www.example.com/wp-admin/`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `single-node-file-server.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

#### Полезные ссылки {#see-also}

* [Создание сайта на WordPress с кластером базы данных MySQL® с помощью консоли управления](console.md)