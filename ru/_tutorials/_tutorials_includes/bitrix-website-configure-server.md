Для настройки сервера для работы с «1С-Битрикс» выполните следующие шаги:
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по SSH от имени пользователя, заданного при [создании ВМ](#create-vm) (например, `ubuntu`):

   ```bash
   ssh ubuntu@<публичный_IP-адрес_ВМ>
   ```

   Публичный IP-адрес ВМ можно узнать в [консоли управления]({{ link-console-main }}) в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ.

1. Установите необходимое программное обеспечение:

   {% note info %}

   Следующие команды установки предназначены для Ubuntu. Для других дистрибутивов используйте команды вашего менеджера пакетов.

   {% endnote %}

   ```bash
   sudo apt-get update
   sudo apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Перейдите в рабочий каталог проекта и скачайте дистрибутив «1С-Битрикс: Управление сайтом»:

   ```bash
   cd /var/www/html/
   sudo wget https://www.1c-bitrix.ru/download/business_encode.tar.gz
   ```

1. Распакуйте полученный архив и после этого удалите ненужные файлы:

   ```bash
   sudo tar -zxf business_encode.tar.gz
   sudo rm -f index.html business_encode.tar.gz
   ```

1. Назначьте пользователя `www-data` владельцем рабочего каталога проекта:

   ```bash
   sudo chown -R www-data:www-data /var/www/html
   ```

   Проверьте права и владельцев рабочего каталога:

   ```bash
   ls -l
   ```

   Результат:

   ```text
   total 40
   drwxrwxr-x 7 www-data www-data  4096 Jun  8  2023 bitrix
   -rwxrwxr-x 1 www-data www-data  1150 Nov 30  2020 favicon.ico
   -rwxrwxr-x 1 www-data www-data  1353 Jun  8  2023 index.php
   -rwxrwxr-x 1 www-data www-data   268 Apr 17  2023 install.config
   -rwxrwxr-x 1 www-data www-data 12821 Mar 18  2022 readme.html
   -rwxrwxr-x 1 www-data www-data   112 Mar 27  2013 readme.php
   drwxrwxr-x 2 www-data www-data  4096 Jun  8  2023 upload
   ```

1. Для корректной работы 1С настройте параметры PHP. Для этого воспользуйтесь встроенным редактором `nano` и отредактируйте следующие переменные в файле конфигурации `php.ini`:

   ```bash
   sudo nano /etc/php/8.1/apache2/php.ini
   ```

   Было | Стало
   :--- | :---
   `short_open_tag = Off` | `short_open_tag = On`
   `memory_limit = 128M` | `memory_limit = 256M`
   `;date.timezone =` | `date.timezone = Europe/Moscow`
   `;opcache.revalidate_freq =2` | `opcache.revalidate_freq =0`
   `;session.save_path = "/var/lib/php/sessions"` | `session.save_path = "/var/lib/php/sessions"`

   Путь к файлу `php.ini` зависит от установленной версии PHP. В примере приведен путь для версии `8.1`. Для версии `8.0` введите `/etc/php/8.0/apache2/php.ini`, для версии `8.2` — `/etc/php/8.2/apache2/php.ini` и т. д.

   {% note tip %}

   Чтобы найти нужный параметр в редакторе `nano` нажмите сочетание клавиш **Ctrl** + **W**. Найдите требуемый параметр из таблицы выше, далее сохраните изменения при помощи сочетания клавиш **Ctrl** + **O**. Выход из редактора **Ctrl** + **X**.

   {% endnote %}

1. Настройте веб-сервер Apache. Для этого отредактируйте файл конфигурации `/etc/apache2/sites-enabled/000-default.conf`.
   1. Откройте файл в текстовом редакторе:

      ```bash
      sudo nano /etc/apache2/sites-enabled/000-default.conf
      ```

   1. После строки `DocumentRoot /var/www/html` добавьте следующий блок и сохраните изменения:

      ```html
      <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
      </Directory>
      ```

   1. Перезапустите веб-сервер, чтобы все измененные настройки применились:

      ```bash
      sudo systemctl restart apache2
      ```

После выполнения этих команд серверная часть будет сконфигурирована для корректной работы 1С-Битрикс.