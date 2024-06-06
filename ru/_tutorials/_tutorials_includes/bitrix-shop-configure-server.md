Чтобы настроить ВМ для работы с «1С-Битрикс»:
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по SSH (используйте имя пользователя `ubuntu`, которое вы задали при [создании ВМ](#create-vm)):

   ```bash
   ssh ubuntu@<публичный_IP_адрес_ВМ>
   ```

   Чтобы узнать публичный IP-адрес вашей ВМ:
   1. Выберите каталог, в котором создана ВМ, в [консоли управления]({{ link-console-main }}).
   1. Выберите сервис **{{ compute-name }}**.
   1. Нажмите на имя вашей ВМ (в примере — `bitrix`).
   1. В открывшемся окне с общей информацией о ВМ публичный IP-адрес вы можете найти в блоке **Сеть**, в поле **Публичный IPv4**.
1. Перейдите в режим администратора:

   ```bash
   ubuntu@bitrix:~$ sudo -i
   root@bitrix:~#
   ```

1. Установите необходимое программное обеспечение:

   ```bash
   root@bitrix:~# apt-get update
   root@bitrix:~# apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Перейдите в рабочий каталог проекта:

   ```bash
   root@bitrix:~# cd /var/www/html/
   ```

1. Скачайте дистрибутив «1С-Битрикс: Управление сайтом»:

   ```bash
   root@bitrix:/var/www/html# wget https://www.1c-bitrix.ru/download/business_encode.tar.gz
   ```

1. Распакуйте полученный архив и удалите ненужные файлы:

   ```bash
   root@bitrix:/var/www/html# tar -zxf business_encode.tar.gz
   root@bitrix:/var/www/html# rm -f index.html business_encode.tar.gz
   ```

1. Назначьте пользователя `www-data` владельцем рабочего каталога проекта:

   ```bash
   root@bitrix:/var/www/html# chown -R www-data:www-data /var/www/html
   ```

   Проверьте, что предыдущая команда сработала:
   
   ```bash
   root@bitrix:/var/www/html# ls -l
   ```

   Результат:

   ```text
   total 76
   drwxrwxr-x 6 www-data www-data  4096 May 15 13:50 bitrix
   -rwxrwxr-x 1 www-data www-data  1378 May 15 13:50 index.php
   -rwxrwxr-x 1 www-data www-data   150 Mar 11  2013 install.config
   -rwxrwxr-x 1 www-data www-data 30741 Apr 10 14:36 license.html
   -rwxrwxr-x 1 www-data www-data   113 Nov 20  2012 license.php
   -rwxrwxr-x 1 www-data www-data 14054 Feb  6  2017 readme.html
   -rwxrwxr-x 1 www-data www-data   112 Mar 27  2013 readme.php
   drwxrwxr-x 2 www-data www-data  4096 May 15 13:50 upload
   -rwxrwxr-x 1 www-data www-data   691 Oct 27  2009 web.config
   ...
   ```

1. Откройте файл конфигурации `/etc/php/7.4/apache2/php.ini` и укажите необходимые параметры PHP.

   {% note info %}

   В зависимости от версии «1С-Битрикс» путь к файлу конфигурации может отличаться. Укажите путь до актуальной версии PHP на ВМ.

   {% endnote %}

   Было | Стало
   :--- | :---
   `short_open_tag = Off`        | `short_open_tag = On`
   `display_errors = Off`        | `display_errors = On`
   `memory_limit = 128M`         | `memory_limit = 256M`
   `;date.timezone =`            | `date.timezone = Europe/Moscow`
   `;opcache.revalidate_freq=2`  | `opcache.revalidate_freq = 0`
   `;mbstring.func_overload = 0` | `mbstring.func_overload = 2`

1. Настройте сервер Apache с помощью файла конфигурации `/etc/apache2/sites-enabled/000-default.conf`. Для этого добавьте после строки `DocumentRoot /var/www/html` следующий блок:

   ```xml
   <Directory /var/www/html>
     Options Indexes FollowSymLinks
     AllowOverride All
     Require all granted
   </Directory>
   ```

1. Перезапустите сервер Apache, чтобы все измененные настройки были применены:

   ```bash
   root@bitrix:/var/www/html# service apache2 restart
   ```

Сервер сконфигурирован для корректной работы «1С-Битрикс». Теперь нужно настроить саму систему «1С-Битрикс».