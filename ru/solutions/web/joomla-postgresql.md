# Сайт на базе Joomla с БД PostgreSQL

Чтобы настроить статический веб-сайт на Joomla:
* [Создайте виртуальную машину](#create-vm)
* [Создайте базу данных](#create-database)
* [Установите Joomla](#install-joomla)
* [Установите зависимости](#install-dependencies)
* [Настройте веб-сервер](#config-apache2)
* [Настройте Joomla](#config-joomla)
* [Загрузите файлы веб-сайта](#upload-files)
* [Настройте DNS](#configure-dns)


## Создать виртуальную машину {#create-vm}

Перед тем, как создавать виртуальную машину:

1. Перейдите в [консоль управления](https://console.cloud.yandex.ru) Яндекс.Облака и выберите каталог, в котором будете выполнять операции.
1. Убедитесь, что в выбранном каталоге есть сеть с подсетью, к которой можно подключить виртуальную машину. Для этого на странице каталога нажмите плитку **Yandex Virtual Private Cloud**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если ни одной подсети или сети нет, [создайте их](../../vpc/quickstart.md).

Чтобы создать виртуальную машину:

1. На странице каталога в [консоли управления](https://console.cloud.yandex.ru) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины, например, `joomla`.

    [!INCLUDE [name-format](../../_includes/name-format.md)]

1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
1. В блоке **Публичные образы** выберите Ubuntu 18.04, 16.04 или 14.04 или Centos 6 или 7.
1. В блоке **Вычислительные ресурсы** выберите [тип использования ядра](../../compute/concepts/vm-types.md) (частичное или полное), укажите необходимое количество vCPU и объем RAM.

   Для функционального тестирования хватит минимальной конфигурации:
   * **Гарантированная доля vCPU** — 5%.
   * **vCPU** — 1.
   * **RAM** — 1 ГБ.

1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить виртуальную машину при создании.
1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH ключ** вставьте содержимое файла открытого ключа.
        Пару ключей для подключения по SSH необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
1. Нажмите кнопку **Создать ВМ**.

Создание виртуальной машины может занять несколько минут. Когда виртуальная машина перейдет в статус `RUNNING`, вы можете [загрузить на нее файлы веб-сайта](#upload-files).

При создании виртуальной машине назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.

## Создать базу данных PostgreSQL в MDB {#create-database}

1. Перейдите в [консоль управления](https://console.cloud.yandex.ru) Яндекс.Облака и выберите каталог, в котором будете выполнять операции.
1. Нажмите плитку **Yandex Managed PostgreSQL**.
1. Нажмите кнопку **Создать клаcтер**.
1. В поле **Имя** введите имя кластера.
1. В разделе **Класс БД** выберите **s1.nano**.
1. В разделе **Размер хранилища** укажите 10 ГБ.
1. В разделе **База данных**:
  1. В поле **Имя БД** введите `joomla`.
  1. В поле **Имя пользователя** введите `joomla`.
  1. В поле **Пароль** введите любой пароль, который вы будете использовать для доступа к базе.
1. В списке **Сеть** выберите сеть, к которой подключена ваша виртуальная машина.
1. В разделе **Хосты** добавьте еще два хоста в других зонах доступности.
1. Нажмите кнопку **Создать кластер**. Кластер БД запустится и станет доступен через несколько секунд.

## Установить Joomla {#install-joomla}

1. После того как машина `joomla` перейдет в состояние `running`, подключитесь к ней по [протоколу SSH](../../compute/operations/vm-control/vm-connect-ssh.md).
1. Скачайте и распакуйте архив с Joomla:

```
sudo mkdir -p /var/www/html/
curl https://downloads.joomla.org/cms/joomla3/3-8-7/Joomla_3-8-7-Stable-Full_Package.tar.gz?format=gz -o Joomla_3-8-7-Stable-Full_Package.tar.gz -L
sudo mv Joomla_3-8-7-Stable-Full_Package.tar.gz /var/www/html/
(cd /var/www/html/ && sudo tar -zxvf Joomla_3-8-7-Stable-Full_Package.tar.gz)
sudo rm /var/www/html/Joomla_3-8-7-Stable-Full_Package.tar.gz
sudo mv /var/www/html/htaccess.txt /var/www/html/.htaccess
```
## Установить зависимости {#install-dependencies}

Для работы Joomla требуется установить набор дополнительных компонентов.

---

**[!TAB CentOS 7]**

```
sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo yum check-update
sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
sudo mkdir ~apache/.postgresql
sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
sudo chmod 0600 ~apache/.postgresql/root.crt
sudo chown -R apache:apache ~apache/.postgresql
```

**[!TAB CentOS 6]**

```
sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-6-x86_64/pgdg-centos10-10-2.noarch.rpm
sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo yum check-update
sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
sudo mkdir ~apache/.postgresql
sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
sudo chmod 0600 ~apache/.postgresql/root.crt
sudo chown -R apache:apache ~apache/.postgresql
```

**[!TAB Ubuntu 18]**

```
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -q -y install php7.2-pgsql php7.2-curl php7.2-json php7.2-cgi php7.2 libapache2-mod-php7.2 apache2 php-mail php7.2-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
sudo mkdir ~apache/.postgresql
sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
sudo chmod 0600 ~apache/.postgresql/root.crt
sudo chown -R apache:apache ~apache/.postgresql
```

**[!TAB Ubuntu 16]**

```
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -q -y install php7.0-pgsql php7.0-curl php7.0-json php7.0-cgi php7.0 libapache2-mod-php7.0 php7.0-mcrypt apache2 php-mail php7.0-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
sudo mkdir ~apache/.postgresql
sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
sudo chmod 0600 ~apache/.postgresql/root.crt
sudo chown -R apache:apache ~apache/.postgresql
```

**[!TAB Ubuntu 14]**

```
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -q -y install php5-pgsql php5-curl php5-json php5-cgi php5 libapache2-mod-php5 php5-mcrypt apache2 php5-common cron debconf-utils sendmail unzip iptables postgresql-client-10
sudo mkdir ~apache/.postgresql
sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
sudo chmod 0600 ~apache/.postgresql/root.crt
sudo chown -R apache:apache ~apache/.postgresql
```

---

## Настроить Apache2 {#config-apache2}

1. Настройте Apache2 на работу с определенной версией PHP:

   ---

   **[!TAB Ubuntu 18]**

   ```
   sudo a2enmod php7.2
   sudo a2dismod mpm_event
   sudo a2enmod mpm_prefork
   sudo a2enmod rewrite
   sudo chown -R www-data /var/www/html/
   sudo nano /etc/apache2/sites-enabled/000-default.conf
   ```

   **[!TAB Ubuntu 16]**

   ```
   sudo a2enmod php7.0
   sudo a2dismod mpm_event
   sudo a2enmod mpm_prefork
   sudo a2enmod rewrite
   sudo chown -R www-data /var/www/html/
   sudo nano /etc/apache2/sites-enabled/000-default.conf
   ```

   **[!TAB Ubuntu 14]**

   ```
   sudo a2enmod php5
   sudo a2dismod mpm_event
   sudo a2enmod mpm_prefork
   sudo a2enmod rewrite
   sudo chown -R www-data /var/www/html/
   sudo nano /etc/apache2/sites-enabled/000-default.conf
   ```

   **[!TAB CentOS 6/7]**

   ```
   sudo chown -R apache /var/www/html/
   sudo nano /etc/httpd/conf.d/joomla.conf
   ```

   ---

1. Задайте настройки виртуального хоста в файле `/etc/httpd/conf.d/joomla.conf`:

   ```
   <VirtualHost *:80 [::]:80>
           ServerAdmin webmaster@localhost
           DocumentRoot /var/www/html/

           <Directory /var/www/html/>
                   DirectoryIndex index.php index.html
                   DirectorySlash off
                   RewriteEngine on
                   RewriteBase /
                   AllowOverride all
           </Directory>
   </VirtualHost>
   ```

1. Перезапустите веб-сервер:

   ---

   **[!TAB Ubuntu 14/16/18]**

   ```
   sudo service apache2 restart
   ```

   **[!TAB CentOS 6/7]**

   ```
   sudo service httpd restart
   ```

   ---

1. Если вы используете CentOS 6, настройте фаерволл:

   --- 

   **[!TAB CentOS 6]**

   ```
   sudo iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
   sudo iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
   sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```

   ---

## Настроить Joomla {#config-joomla}

1. Настройте Joomla по [инструкции](https://docs.joomla.org/J3.x:Installing_Joomla/ru) на сайте проекта.
1. Получите адреса хостов БД в консоли управления:
   * Откройте каталог, в котором создана база данных.
   * Нажмите плитку ***Yandex Managed PostgreSQL***.
   * Выберите кластер, который требуется использовать.
   * Откройте страницу **Хосты**.
   * В колонке **Адрес** будут находиться адреса хостов.
1. На странице **Конфигурация базы данных** заполните поля:
   * Тип базы данных: `PostgreSQL`.
   * В поле **Имя сервера базы данных** укажите: 
     ```
     host=<адрес хоста 1>,<адрес хоста 2>,<адрес хоста 3> \
     port=6432 \
     sslmode=verify-full \
     target_session_attrs=read-write
     ```
   * В поле **Имя пользователя** укажите: `joomla`.
   * Вполе **Пароль** укажите пароль пользователя БД.
   * Имя базы данных: joomla.

## Загрузить файлы веб-сайта {#upload-files}

[!INCLUDE [upload-files](../_solutions_includes/upload-web-site-files.md)]

## Настроить DNS {#configure-dns}

Доменное имя, которое вы хотите использовать для веб-сайта, нужно связать с созданной виртуальной машиной.

В инструкции ниже описана настройка внешнего DNS-сервиса на примере [reg.ru](https://www.reg.ru/) для доменных имен `www.example.com` и `example.com`:
  * Запись типа A позволяет сопоставить доменному имени `example.com` его IP-адрес.
  * Запись типа CNAME (Canonical Name — каноническое имя) для `www` позволит получить доступ к вашему веб-сайту через адрес `www.example.ru`.

Чтобы настроить внешний DNS-сервер, выполните:

1. В блоке **Сеть** на странице виртуальной машины в [консоли управления](https://console.cloud.yandex.ru) найдите публичный IP-адрес виртуальной машины.
1. Войдите в панель управления внешнего DNS-сервиса. Перейдите в [список ваших доменов](https://www.reg.ru/user/domain_list) и нажмите на имя нужного домена.
1. Перейдите по ссылке **Управление зоной** в блоке **Управление доменом**.
1. Создайте или отредактируйте A-запись:
   * **IP Address** — публичный IP-адрес вашей виртуальной машины.
   * **Subdomain** — `@` (указывает на основной домен).
1. Создайте CNAME-запись со значениями полей:
   * **Subdomain** — `www`.
   * **Canonical name** — `@` или домен с точкой на конце`example.com.`.
1. Подождите 15-20 минут, пока изменения DNS-записей вводятся в действие. Время ожидания может отличаться для вашего DNS-сервиса.
