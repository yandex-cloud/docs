# Перенос WordPress сайта с хостинга в {{ yandex-cloud }}

[WordPress](https://wordpress.com) — система управления контентом с открытым исходным кодом.

С помощью WordPress вы можете создавать новостные сайты, личные или корпоративные блоги, сайты организаций, онлайн-магазины и другие сервисы.

Система позволяет с минимальными усилиями развернуть сайт, используя один из множества шаблонов или собственный дизайн. Готовые плагины помогают легко добавить к созданному сервису новые блоки или функциональности.

В {{ yandex-cloud }} вы можете быстро [создать сайт на WordPress](../../tutorials/web/wordpress/index.md) или перенести с другого хостинга.

Для переноса сайта на CMS WordPress в {{ yandex-cloud }}:
1. [Сделайте бэкап сайта](#create-backup).
1. [Подготовьте облако к работе](#before-begin).
1. [Создайте виртуальную машину для WordPress](#create-vm).
1. [Подключитесь к ВМ](#connect-vm).
1. [Установите и настройте дополнительные компоненты](#additional-components).
1. [Импортируйте базу данных](#import-db).
1. [Перенесите файлы сайта](#transfer-files).
1. [Настройте DNS](#configure-dns).
1. [Создайте SSL-сертификат](#setting-ssl).
1. [Проверьте работу сайта](#check-site).

## Сделайте бэкап сайта {#create-backup}

Сделайте [бэкап](../../glossary/backup.md) файлов сайта и БД одним из способов:
* С помощью различных плагинов для WordPress (например, [BackWPup](https://ru.wordpress.org/plugins/backwpup) или [Updraft Plus](https://ru.wordpress.org/plugins/updraftplus)).
* С помощью встроенных средств в панели управления хостингом, на котором располагается ваш сайт.
* Скопировать все файлы на свой жесткий диск через FTP-клиент, а БД экспортировать через панель [phpMyAdmin](https://www.phpmyadmin.net/).

  Этот вариант дольше и займет от 5 до 20 минут — придется копировать много небольших файлов, из которых состоит сайт.

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Убедитесь, что в выбранном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) есть [облачная сеть](../../vpc/concepts/network.md#network) с [подсетью](../../vpc/concepts/network.md#subnet) хотя бы в одной [зоне доступности](../../overview/concepts/geo-scope.md). Для этого на странице каталога выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../vpc/quickstart.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки сайта на WordPress входит:
* Плата за постоянно запущенную [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за публичные DNS-запросы и [зоны](../../dns/concepts/dns-zone.md) (см. [тарифы {{ dns-full-name }}](../../dns/pricing.md)).

## Создайте ВМ для WordPress {#create-vm}

Чтобы создать ВМ:
1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `LAMP` и выберите публичный образ [LAMP](/marketplace/products/yc/lamp), который содержит необходимый набор компонентов: операционную систему семейства Linux, веб-сервер Apache, СУБД {{ MY }} и интерпретатор PHP.
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** выберите [тип диска](../../compute/concepts/disk.md#disks_types) и задайте нужный размер.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

   * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
   * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

   * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
   * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `wordpress-vm`.

    {% note alert %}

    IP-адрес и [имя хоста (FQDN)](../../compute/concepts/network.md#hostname) для подключения к ВМ назначается ей при создании. Если вы выбрали вариант `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` в поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, вы не сможете обращаться к ВМ из интернета.

    {% endnote %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.field_access-advanced }}** выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) или создайте новый.
1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   Создание ВМ может занять несколько минут. Когда ВМ перейдет в [статус](../../compute/concepts/vm-statuses.md) `RUNNING`, вы можете [загрузить на нее файлы сайта](#upload-files).

## Подключитесь к ВМ {#connect-vm}

Вы можете подключиться к ВМ по протоколу SSH, когда она будет запущена (в статусе `RUNNING`). Для этого можно использовать утилиту `ssh` в Linux/macOS/Windows 10 и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows 7/8.

Для подключения к ВМ необходимо указать ее публичный IP-адрес.

Чтобы скопировать публичный IP-адрес ВМ:
1. Откройте страницу каталога в [консоли управления]({{ link-console-main }}).
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Найдите созданную ВМ и нажмите на ее имя.
1. В разделе **{{ ui-key.yacloud.compute.instance.overview.section_network }}** скопируйте IP-адрес из поля **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}**.

Выполните [подключение к ВМ](../../compute/operations/vm-connect/ssh.md).

## Установите и настройте дополнительные компоненты {#additional-components}

Перед тем, как перейти к переносу файлов, необходимо:
* Установить текстовый редактор `nano` — он потребуется нам для внесения правок в некоторые файлы конфигурации.
* Установить и настроить `phpMyAdmin` для работы с БД сайта.

### Установите редактор nano {#install-nano}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  Выполните команду:

  ```bash
  sudo apt install nano
  ```

  Дождитесь установки редактора.

{% endlist %}

### Установите phpMyAdmin {#install-phpmyadmin}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Выполните команды:

     ```bash
	 sudo apt-get update
	 sudo apt-get install phpmyadmin php-mbstring php-gettext
	 ```

  1. В процессе установки выберите сервер, на который будет установлен `phpMyAdmin`. Выберите `Apache2` и нажмите **пробел** на клавиатуре — напротив `Apache2` появится значок `*`. Нажмите **Enter**.
  1. Настройте доступ `phpMyAdmin` к БД. Для этого на вопрос `Configure database for phpmyadmin with dbconfig-common?` выберите `<yes>`. Ввод пароля можно пропустить, система автоматически сгенерирует его. Чтобы скопировать сгенерированный пароль, выполните команду:

     ```bash
	 sudo cat /root/default_passwords.txt
	 ```

	 Текст файла должен содержать данные:

	 ```text
	 MYSQL_ROOT_PASS=KjZKrQV7efFGk
	 ```

	 Скопируйте и сохраните пароль `MYSQL_ROOT_PASS`. Он понадобится далее.
  1. Включите расширение `mbstring` для PHP:

     ```bash
	 sudo phpenmod mbstring
	 ```

  1. Чтобы принять все изменения, перезапустите Apache:

     ```bash
	 sudo systemctl restart apache2
	 ```

  1. Откройте `phpMyAdmin` через браузер. В адресной строке введите `http://<публичный_IP-адрес_ВМ>/phpmyadmin`.

	 Для входа в `phpMyAdmin` используйте следующие данные:

	 ```text
	 Пользователь: root
	 Пароль: сгенерированный системой (MYSQL_ROOT_PASS из файла default_passwords.txt)
	 ```

{% endlist %}

### Настройте phpMyAdmin {#setting-phpmyadmin}

Настройте дополнительный пароль для входа в панель `phpMyAdmin`. Чтобы включить возможность использования настроек доступа в `.htaccess`, отредактируйте файл `phpmyadmin.conf`.

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Выполните команду:

     ```bash
	 sudo nano /etc/apache2/conf-available/phpmyadmin.conf
	 ```

  1. Добавьте в файл `phpmyadmin.conf` строку `AllowOverride All`:

     ```text
	 <Directory /usr/share/phpmyadmin>
	 Options SymLinksIfOwnerMatch
	 DirectoryIndex index.php
	 AllowOverride All
	 ```

  1. Сохраните изменения в файле `phpmyadmin.conf`. Для этого нажмите **Ctrl** + **O** и **Enter**. Для выхода из файла нажмите **Ctrl** + **X**.
  1. Перезапустите Apache:

     ```bash
	 sudo systemctl restart apache2
	 ```

  1. Создайте `.htaccess`:

     ```bash
	 sudo nano /usr/share/phpmyadmin/.htaccess
	 ```

  1. Скопируйте строки в `.htaccess`:

     ```text
	 AuthType Basic
	 AuthName "Restricted Files"
	 AuthUserFile /etc/phpmyadmin/.htpasswd
	 Require valid-user
	 ```

  1. Сохраните изменения в файле.
  1. Создайте `.htpasswd`:

     ```bash
	 sudo htpasswd -c /etc/phpmyadmin/.htpasswd <имя_пользователя>
	 ```

	 Введите желаемый пароль и повторите его.
  1. Перезапустите Apache:

     ```bash
	 sudo systemctl restart apache2
	 ```

  Теперь при входе в phpMyAdmin нужно будет ввести дополнительный логин и пароль, указанный в файле `.htpasswd`.

{% endlist %}

## Импортируйте БД {#import-db}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Откройте файл конфигурации WordPress вашего сайта. Для этого распакуйте архив и в корневой папке откройте файл `wp-config.php`. Найдите значения параметров `DB_USER`, `DB_NAME`, `DB_PASSWORD`:

     ```bash
	 define('DB_USER', 'UsernameTEST');
	 define('DB_NAME', 'database_wordpress');
	 define('DB_PASSWORD', 'MySecretPassword');
	 ```

  1. Зайдите в phpMyAdmin — введите в адресной строке браузера:

     ```http request
     http://<публичный_IP-адрес_ВМ>/phpmyadmin`
     ```

  1. Перейдите в раздел **Учетные записи пользователей** и добавьте учетную запись пользователя с параметрами:
     * **Имя пользователя** — вставьте значение для `DB_USER` из `wp-config.php`.
     * **Имя хоста** — оставьте по умолчанию `%`.
     * **Пароль** — вставьте значение для `DB_PASSWORD` из `wp-config.php`.
     * **Глобальные привилегии** — включите опцию **Отметить все**.

     Все остальные параметры при создании пользователя оставьте по умолчанию. Внизу экрана нажмите **Вперед**.
  1. Перейдите в раздел **Базы данных**. Заполните поле **Имя базы данных** — вставьте значение для `DB_NAME` из `wp-config.php`. Выберите кодировку `utf8_general_ci`. Нажмите **Создать**.
  1. Импортируйте БД из бэкапа:
     * В левой колонке выберите созданную БД.
     * Нажмите **Импорт** и выберите сохраненный бэкап БД. Если бэкап БД превышает установленный по умолчанию лимит 2 МБ, отредактируйте файл конфигурации `php.ini`, где задано данное ограничение.
     1. Выполните команду:

	    ```bash
	    sudo nano /etc/php/X.X/apache2/php.ini
	    ```

	    `X.X`— версия PHP. Возможные значения `5.6`,`7.0`,`7.1`,`7.2`,`7.3`,`7.4`,`8.0`,`8.1`.
	 1. Отредактируйте параметры:
	    * `upload_max_filesize` — максимальный размер загружаемого файла.
	    * `post_max_size` — максимальный размер сообщения методом `POST`.

	    ```bash
	    upload_max_filesize = 80M
	    post_max_size = 80M
	    ```

	 1. Сохраните изменения — нажмите **Ctrl** + **O** и **Enter**. Для выхода из файла нажмите **Ctrl** + **X**.
	 1. Перезапустите Apache:

	    ```bash
	    sudo systemctl restart apache2
	    ```

	 1. Повторите операцию импорта БД.

{% endlist %}

### Отключите phpMyAdmin {#disable-phpmyadmin}

Все основные действия по переносу БД выполнены. Чтобы не подвергать `phpMyAdmin` атакам извне, отключите утилиту:

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  ```bash
  sudo a2disconf phpmyadmin.conf && sudo /etc/init.d/apache2 restart
  ```

{% endlist %}

Для работы с БД вы можете использовать терминал.

## Перенесите файлы сайта {#transfer-files}

Чтобы перенести файлы бэкапа на ВМ, воспользуйтесь FTP-клиентом [FileZilla](https://filezilla-project.org/):
1. Откройте FileZilla.
1. Перейдите в раздел **Файл** → **Менеджер сайтов** и добавьте новый сайт.
1. Выберите протокол SFTP, введите публичный IP-адрес ВМ. В разделе **Тип входа** выберите **Файл с ключом**.
1. Укажите пользователя, созданного при настройке ВМ, и выберите файл ключа — ключ находится в папке `/Users/<имя_пользователя>/.ssh/`.

   FTP-клиент не видит скрытую папку по умолчанию. Нажмите сочетание клавиш **Cmd** + **Shift** + **G** и выберите файл `id_ed25519` без расширения `pub`. Будет выведено сообщение, что файл не поддерживается. FTP-клиент предложит переконвертировать его в нужный формат. Нажмите **Да**. Сохраните переконвертированный файл в удобном вам месте.
1. Нажмите **Подключиться** и введите кодовую фразу, которую сформировали в начале работы. Вы подключитесь к ВМ.
1. Найдите папку `/var/www/html` на ВМ и скопируйте в нее файл бэкапа. Файл index.html копировать не нужно.

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     По умолчанию для этой папки заданы права 755. Чтобы скопировать файл архива сайта с жесткого диска в папку `html`, измените права на папку:

     ```bash
     sudo chmod 777 /var/www/html
     ```

     Распакуйте бэкап:

     ```bash
     cd /var/www/html
     tar -xvf FILENAME.tar.gz
     ```

     Вместо `FILENAME` укажите название файла с архивом сайта.

     {% note alert %}

     Все файлы должны распаковываться в корневую директорию `html`, а не в поддиректорию `/var/www/html/wordpress`.

     {% endnote %}

	 Удалите файл бэкапа, чтобы он не занимал места:

     ```bash
     rm FILENAME.tar.gz
     ```

     Верните права на папки:
     * `html` и вложенных папок — `755`.
     * Для всех файлов внутри `html` — `644`.
     * Для `wp-config.php` отдельно уровень доступа — `600`.

     ```bash
     cd var/www/
     sudo find ./ -type d -exec chmod 0755 {} \;
     sudo find ./ -type f -exec chmod 0644 {} \;
     sudo chmod 600 wp-config.php
     ```

     Параметр `f` — ищет все файлы внутри директорий. Параметр `d` — ищет все директории внутри `html`.

   {% endlist %}

## Настройте DNS {#configure-dns}

Воспользуйтесь сервисом {{ dns-name }} для управления доменом.

{% include [configure-a-record-and-cname](../_tutorials_includes/configure-a-record-and-cname.md) %}

### Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, введите в браузере его IP-адрес или доменное имя:
* `http://<публичный_IP-адрес_ВМ>`.
* `http://www.example.com`.

## Установите SSL-сертификат c помощью Let’s Encrypt® {#setting-ssl}

Для установки [сертификата](../../certificate-manager/concepts/managed-certificate.md) используйте [Let’s Encrypt](https://letsencrypt.org/). Let’s Encrypt — это центр сертификации, предоставляющий бесплатные [SSL-сертификаты](https://ru.wikipedia.org/wiki/SSL).

### Установите клиент Let’s Encrypt {#install-client}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Введите в терминал команду:

     ```bash
	 sudo apt-get update && sudo apt-get install software-properties-common
	 ```

  1. Добавьте репозитории `universe` and `certbot`:

     ```bash
     sudo add-apt-repository universe && sudo add-apt-repository ppa:certbot/certbot
     ```

     Нажмите **Enter**.
  1. Установите клиент Let’s Encrypt:

     ```bash
     sudo apt-get update && sudo apt-get install certbot python-certbot-apache
     ```

  1. Нажмите **Y** и **Enter**.

{% endlist %}

### Получите SSL-сертификат {#get-ssl}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Введите команду:

     ```bash
     sudo certbot --apache
     ```

  1. В интерфейсе введите название вашего домена `example.com` или `www.example.com`.
  1. Определите, нужно ли перенаправлять все страницы с `http` на `https` при открытии сайта. Выберите `2` — перенаправить на https.
  1. Протестируйте ваш сайт — введите в адресную строку браузера `https://www.ssllabs.com/ssltest/analyze.html?d=example.com`.

{% endlist %}

### Выполните автообновление {#self-update}

Сертификат выдается на 90 дней. Необходимо регулярно обновлять его. Настройте расписание обновления с помощью `cron`:

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Введите в терминале команду:

     ```bash
	 sudo crontab -e
	 ```

  1. В диалоге выберите первый пункт из списка.
  1. Добавьте в самый конец файла строчку кода:

     ```bash
	 30 2 * * 1 /usr/bin/certbot renew >> /var/log/le-renew.log
	 ```

     В итоге будет запланировано обновление SSL-сертификата с выполнением каждый понедельник в 2:30 ночи. Результат выполнения будет записан в лог-файл.

{% endlist %}

## Проверьте работу сайта {#check-site}

У сайтов на WordPress иногда возникает проблема открытия внутренних ссылок при переходе от одного хостинга к другому. Проверьте, существует ли файл `.htaccess` в корневой папке вашего сайта — `var/www/html/.htaccess`.

Если файла нет, создайте его.

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Введите в терминале команду:

     ```bash
	 sudo nano /var/www/html/.htaccess
	 ```

  1. Добавьте код:

     ```html
	 <IfModule mod_rewrite.c>
	   RewriteEngine On
	   RewriteBase /
	   RewriteRule ^index\.php$ - [L]
	   RewriteCond %{REQUEST_FILENAME} !-f
	   RewriteCond %{REQUEST_FILENAME} !-d
	   RewriteRule . /index.php [L]
	 </IfModule>
	 ```

  1. Сохраните изменения — **Ctrl** + **O** и **Enter**. Для выхода нажмите **Ctrl** + **X**.

{% endlist %}

Проверьте сайт. Если ссылки не открываются, значит в `Apache` отключена поддержка `.htaccess` файла.

Чтобы включить поддержку `.htaccess`:

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Введите команду:

     ```bash
	 sudo nano /etc/apache2/sites-available/000-default.conf
	 ```

  1. Добавьте код:

     ```text
	 <Directory /var/www/html>
	   AllowOverride All
	   Order allow,deny
	   allow from all
	 </Directory>
	 ```

  1. В результате:

     ```html
	 <VirtualHost *:80 [::]:80>
	   ServerAdmin webmaster@localhost
	   DocumentRoot /var/www/html
	   <Directory /var/www/html>
	     AllowOverride All
		 Order allow,deny
		 allow from all
	   </Directory>
	   ErrorLog ${APACHE_LOG_DIR}/error.log
	   CustomLog ${APACHE_LOG_DIR}/access.log combined
	 </VirtualHost>
	 ```

  1. Перезапустите Apache:

     ```bash
	 sudo systemctl restart apache2
	 ```

{% endlist %}