# Сайт на базе Joomla с БД PostgreSQL

Чтобы настроить статический веб-сайт на Joomla:
* [Создайте виртуальную машину для Joomla](#create-vm)
* [Создайте кластер БД PostgreSQL](#create-cluster)
* [Установите Joomla и дополнительные компоненты](#install)
* [Настройте веб-сервер Apache2](#configure-apache2)
* [Настройте Joomla](#configure-joomla)
* [Загрузите файлы веб-сайта](#upload-files)
* [Настройте DNS](#configure-dns)


## Подготовка к работе {#before-begin}

Перед тем, как создавать виртуальную машину и кластер БД:

1. Перейдите в [консоль управления](https://console.cloud.yandex.ru) Яндекс.Облака и выберите каталог, в котором будете выполнять операции.
1. Убедитесь, что в выбранном каталоге есть сеть с подсетями в зонах доступности `ru-cental1-a`, `ru-central1-b` и `ru-central1-c`. Для этого на странице каталога нажмите плитку **Yandex Virtual Private Cloud**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../vpc/quickstart.md). 


## Создать виртуальную машину для Joomla {#create-vm}

Чтобы создать виртуальную машину:

1. На странице каталога в [консоли управления](https://console.cloud.yandex.ru) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины — `joomla-pg-tutorial-web`.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
1. Выберите публичный образ **Ubuntu** или **Centos**.
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

Создание виртуальной машины может занять несколько минут. 

При создании виртуальной машине назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.


## Создать кластер баз данных PostgreSQL {#create-cluster}

1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Кластер PostgreSQL**.
1. В поле **Имя** введите имя кластера — `joomla-pg-tutorial-db-cluster`.
1. В разделе **Класс БД** выберите **s1.nano**.
1. В разделе **Размер хранилища** укажите 10 ГБ.
1. В разделе **База данных**:
  1. В поле **Имя БД** введите `joomla-pg-tutorial-db`.
  1. В поле **Имя пользователя** введите `joomla`.
  1. В поле **Пароль** введите пароль, который вы будете использовать для доступа к базе.
1. В списке **Сеть** выберите сеть, к которой подключена ваша виртуальная машина.
1. В разделе **Хосты** добавьте еще два хоста в других зонах доступности. При создании хостов не включайте для них **Публичный доступ**.
1. Нажмите кнопку **Создать кластер**.

Создание кластера БД может занять несколько минут.


## Установить Joomla и дополнительные компоненты {#install}

После того как виртуальная машина `joomla-pg-tutorial-web` перейдет в статус `RUNNING`, выполните:
1. В блоке **Сеть** на странице виртуальной машины в [консоли управления](https://console.cloud.yandex.ru) найдите публичный IP-адрес виртуальной машины.
1. [Подключитесь](../../compute/operations/vm-control/vm-connect-ssh.md) к виртуальной машине по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTy](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows. 
    
      Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей.  Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на виртуальную машину.
1. Скачайте и распакуйте архив с Joomla:

    ```bash
    $ sudo mkdir -p /var/www/html/
    $ curl https://downloads.joomla.org/cms/joomla3/3-8-7/Joomla_3-8-7-Stable-Full_Package.tar.gz?format=gz -o Joomla_3-8-7-Stable-Full_Package.tar.gz -L
    $ sudo mv Joomla_3-8-7-Stable-Full_Package.tar.gz /var/www/html/
    $ (cd /var/www/html/ && sudo tar -zxvf Joomla_3-8-7-Stable-Full_Package.tar.gz)
    $ sudo rm /var/www/html/Joomla_3-8-7-Stable-Full_Package.tar.gz
    $ sudo mv /var/www/html/htaccess.txt /var/www/html/.htaccess
    ```
1. Установите дополнительные компоненты:

    ---
    
    **[!TAB Ubuntu 14]**
    
    ```bash
    $ echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
    $ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    $ sudo apt-get update
    $ sudo apt-get -q -y install php5-pgsql php5-curl php5-json php5-cgi php5 libapache2-mod-php5 php5-mcrypt apache2 php5-common cron debconf-utils sendmail unzip iptables postgresql-client-10
    $ sudo mkdir ~apache/.postgresql
    $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
    $ sudo chmod 0600 ~apache/.postgresql/root.crt
    $ sudo chown -R apache:apache ~apache/.postgresql
    ```
    
    **[!TAB Ubuntu 16]**
    
    ```bash
    $ echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
    $ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    $ sudo apt-get update
    $ sudo apt-get -q -y install php7.0-pgsql php7.0-curl php7.0-json php7.0-cgi php7.0 libapache2-mod-php7.0 php7.0-mcrypt apache2 php-mail php7.0-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
    $ sudo mkdir ~apache/.postgresql
    $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
    $ sudo chmod 0600 ~apache/.postgresql/root.crt
    $ sudo chown -R apache:apache ~apache/.postgresql
    ```
    
    **[!TAB Ubuntu 18]**
    
    ```bash
    $ echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
    $ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    $ sudo apt-get update
    $ sudo apt-get -q -y install php7.2-pgsql php7.2-curl php7.2-json php7.2-cgi php7.2 libapache2-mod-php7.2 apache2 php-mail php7.2-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
    $ sudo mkdir ~apache/.postgresql
    $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
    $ sudo chmod 0600 ~apache/.postgresql/root.crt
    $ sudo chown -R apache:apache ~apache/.postgresql
    ```
    
    **[!TAB CentOS 6]**
    
    ```bash
    $ sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-6-x86_64/pgdg-centos10-10-2.noarch.rpm
    $ sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    $ sudo yum check-update
    $ sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
    $ sudo mkdir ~apache/.postgresql
    $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
    $ sudo chmod 0600 ~apache/.postgresql/root.crt
    $ sudo chown -R apache:apache ~apache/.postgresql
    ```
    
    **[!TAB CentOS 7]**
    
    ```bash
    $ sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
    $ sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    $ sudo yum check-update
    $ sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
    $ sudo mkdir ~apache/.postgresql
    $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
    $ sudo chmod 0600 ~apache/.postgresql/root.crt
    $ sudo chown -R apache:apache ~apache/.postgresql
    ```
    
    ---

## Настроить веб-сервер Apache2 {#configure-apache2}

1. Выполните базовую настройку Apache2:

   ---

   **[!TAB Ubuntu 14]**

   ```bash
   $ sudo a2enmod php5
   $ sudo a2dismod mpm_event
   $ sudo a2enmod mpm_prefork
   $ sudo a2enmod rewrite
   $ sudo chown -R www-data /var/www/html/
   ```

   **[!TAB Ubuntu 16]**

   ```bash
   $ sudo a2enmod php7.0
   $ sudo a2dismod mpm_event
   $ sudo a2enmod mpm_prefork
   $ sudo a2enmod rewrite
   $ sudo chown -R www-data /var/www/html/
   ```

   **[!TAB Ubuntu 18]**

   ```bash
   $ sudo a2enmod php7.2
   $ sudo a2dismod mpm_event
   $ sudo a2enmod mpm_prefork
   $ sudo a2enmod rewrite
   $ sudo chown -R www-data /var/www/html/
   ```

   **[!TAB CentOS]**

   ```bash
   $ sudo chown -R apache /var/www/html/
   ```

   ---

1. Задайте настройки виртуального хоста в конфигурационном файле Apache2. Вы можете отредактировать файл с помощью утилиты `nano`:

   ---

   **[!TAB Ubuntu]**

   ```bash
   $ sudo nano /etc/apache2/sites-enabled/000-default.conf
   ```

   **[!TAB CentOS]**

   ```bash
   $ sudo nano /etc/httpd/conf.d/joomla.conf
   ```

   ---

   Приведите файл к виду:

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

   **[!TAB Ubuntu]**

   ```bash
   $ sudo service apache2 restart
   ```

   **[!TAB CentOS]**

   ```bash
   $ sudo service httpd restart
   ```

   ---

1. Этот шаг нужно выполнять только на виртуальной машине с ОС CentOS 6.

   Откройте сетевые порты 80 и 443 с помощью утилиты `iptables`:
   ```bash
   $ sudo iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
   $ sudo iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
   $ sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```


## Настроить Joomla {#configure-joomla}

Настройте Joomla по [инструкции](https://docs.joomla.org/J3.x:Installing_Joomla/ru) на сайте проекта. 
В процессе настройки вам потребуются параметры подключения к базе данных. Чтобы узнать и правильно прописать параметры, выполните:

 1. Получите адреса хостов кластера БД в консоли управления:
 
    1. Откройте каталог, в котором создан кластер БД.
    1. Нажмите плитку **[!KEYREF mpg-name]**.
    1. Выберите кластер `joomla-pg-tutorial-db-cluster`.
    1. Откройте вкладку **Хосты**.
    1. В колонке **Адрес (доменное имя)** найдите адреса хостов.
1. На шаге **Database** в веб-установщике Joomla заполните поля:
   * **Тип базы данных**: `PostgreSQL`.
   * **Имя сервера базы данных**: 
     ```
     host=<адрес хоста 1>,<адрес хоста 2>,<адрес хоста 3> \
     port=6432 \
     sslmode=verify-full \
     target_session_attrs=read-write
     ```
   * **Имя пользователя**:`joomla`.
   * **Пароль**: укажите пароль пользователя БД.
   * **Имя базы данных**: `joomla-pg-tutorial-db`.


## Загрузить файлы веб-сайта {#upload-files}

[!INCLUDE [upload-files](../_solutions_includes/upload-web-site-files.md)]

## Настроить DNS {#configure-dns}

Доменное имя, которое вы хотите использовать для веб-сайта, нужно связать с созданной виртуальной машиной `joomla-pg-tutorial-web`.

[!INCLUDE [configure-a-record-and-cname](../_solutions_includes/configure-a-record-and-cname.md)]
