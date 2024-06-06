Для настройки сервера для работы с «1С-Битрикс» выполните следующие шаги:
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по SSH (используйте имя пользователя ubuntu, которое вы задали при [создании ВМ](#create-vm)):

   ```bash
   ssh ubuntu@<публичный_IP-адрес_ВМ>
   ```

   Чтобы узнать публичный IP-адрес вашей ВМ на странице каталога в [консоли управления]({{ link-console-main }}):
   1. Выберите блок **{{ compute-name }}**.
   1. Нажмите на имя вашей ВМ (в данном примере — **bitrixwebsite**).
   1. Откроется окно с общей информацией о вашей ВМ. Публичный IP-адрес вы можете найти в блоке **Сеть**, в поле **Публичный IPv4**.
1. Установите необходимое программное обеспечение:

   ```bash
   sudo apt-get update
   sudo apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Перейдите в рабочий каталог проекта и скачайте дистрибутив «1С-Битрикс: Управление сайтом»:

   ```bash
   cd /var/www/html/
   sudo wget https://www.1c-bitrix.ru/download/standard_encode.tar.gz
   ```

1. Распакуйте полученный архив и после этого удалите ненужные файлы:

   ```bash
   sudo tar -zxf standard_encode.tar.gz
   sudo rm -f index.html standard_encode.tar.gz
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

   1. Добавьте после строки `DocumentRoot /var/www/html` следующий блок:

      ```html
      <Directory /var/www/html>
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
      </Directory>
      ```

   1. Перезапустите веб-сервер, чтобы все измененные настройки применились.

      ```bash
      sudo service apache2 restart
      ```

После выполнения этих команд серверная часть будет сконфигурирована для корректной работы 1С-Битрикс.