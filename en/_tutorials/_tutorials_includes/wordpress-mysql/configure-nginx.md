After the `wp-mysql-tutorial-web` VM's status changes to `RUNNING`:
1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}** on the VM page in the [management console]({{ link-console-main }}), find the VM's public IP address.
1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM via SSH. You can use the `ssh` utility in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

   The recommended authentication method when connecting over SSH is using a key pair. Make sure to configure the generated key pair so that the private key matches the public key sent to the VM.
1. Install Nginx, PHP-FPM process manager, and additional packages:

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

1. Use the Nginx configuration files to configure the web server:

   {% list tabs group=operating_system %}

   - Debian/Ubuntu {#ubuntu}

      1. You can edit files in the `nano` editor:

         ```bash
         sudo nano /etc/nginx/sites-available/wordpress
         ```

      1. Edit the file as follows:

         ```nginx
         server {
             listen 80 default_server;

             root /var/www/wordpress;
             index index.php;

             server_name <DNS-server_name>;

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

      1. Allow launching your site:

         ```bash
         sudo rm /etc/nginx/sites-enabled/default
         sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
         ```

   - CentOS {#centos}

      You can edit the files `nginx.conf` and `wordpress.conf` in the `nano` editor:
      1. Open `nginx.conf`:

         ```bash
         sudo nano /etc/nginx/nginx.conf
         ```

      1. Edit the file as follows:

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

      1. Open `wordpress.conf`:

         ```bash
         sudo nano /etc/nginx/conf.d/wordpress.conf
         ```

      1. Edit the file as follows:

         ```nginx
         server {
             listen 80 default_server;

             root /usr/share/nginx/wordpress/;
             index index.php;

             server_name <DNS-server_name>;

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