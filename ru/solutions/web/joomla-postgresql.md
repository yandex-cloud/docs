---
title: Сайт на базе CMS Joomla c БД PostgreSQL – Установка и настройка
description: Joomla — это система управления содержимым веб-сайтов написанная на языках PHP и JavaScript. С помощью этой инструкции вы научитесь разворачивать сайт на базе CMS Joomla с базой данных PostgreSQL.
keywords:
  - joomla
  - CMS Joomla
  - postresql
  - установка joomla
  - настройка joomla
  - хостинг сайта joomla

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Сайт на базе Joomla с БД PostgreSQL

С помощью этой инструкции вы научитесь разворачивать сайт на базе CMS Joomla с базой данных под управлением СУБД {{ PG }} в инфраструктуре {{ yandex-cloud }}.

Чтобы настроить статический веб-сайт на Joomla:
1. [Создайте виртуальную машину для Joomla](#create-vm).
1. [Создайте кластер БД PostgreSQL](#create-cluster).
1. [Установите Joomla и дополнительные компоненты](#install).
1. [Настройте веб-сервер Apache2](#configure-apache2).
1. [Настройте Joomla](#configure-joomla).
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Настройте DNS](#configure-dns).
1. [Проверьте работу сайта](#test-site).

Если сайт вам больше не нужен, [удалите все используемые им ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Перед тем, как разворачивать сервер, нужно зарегистрироваться в {{ yandex-cloud }} и создать платежный аккаунт:

{% include [prepare-register-billing](../../_includes/solutions/_common/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша ВМ, на [странице облака](https://console.cloud.yandex.ru/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

Убедитесь, что в выбранном каталоге есть сеть с подсетями в зонах доступности `ru-cental1-a`, `ru-central1-b` и `ru-central1-c`. Для этого на странице каталога выберите сервис **{{ vpc-name }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../vpc/quickstart.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки сайта на Joomla входит:
* плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* плата за кластер БД {{ PG }} (см. [тарифы {{ mpg-full-name }}](../../managed-postgresql/pricing.md));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

## Создайте виртуальную машину для Joomla {#create-vm}

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя ВМ — `joomla-pg-tutorial-web`.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. Выберите публичный образ **Ubuntu** или **Centos**.
1. В блоке **Вычислительные ресурсы**:
   * Выберите [платформу](../../compute/concepts/vm-platforms.md).
   * Укажите необходимое количество vCPU и объем RAM.

   Для функционального тестирования хватит минимальной конфигурации:
   * **Платформа** — Intel Cascade Lake.
   * **Гарантированная доля vCPU** — 5%.
   * **vCPU** — 2.
   * **RAM** — 1 ГБ.
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить ВМ при создании.
1. Укажите данные для доступа на ВМ:
   * В поле **Логин** введите имя пользователя.
   * В поле **SSH ключ** вставьте содержимое файла открытого ключа.
     Пару ключей для подключения по SSH необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
1. Нажмите кнопку **Создать ВМ**.

Создание ВМ может занять несколько минут.

При создании ВМ назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.

## Создайте кластер баз данных PostgreSQL {#create-cluster}

1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Кластер {{ PG }}**.
1. В поле **Имя** введите имя кластера — `joomla-pg-tutorial-db-cluster`.
1. В разделе **Класс БД** выберите **b2.medium**.
1. В разделе **Размер хранилища** укажите 10 ГБ.
1. В разделе **База данных** укажите:
   * **Имя БД** — `joomla-pg-tutorial-db`.
   * **Имя пользователя** — `joomla`.
   * **Пароль** — пароль, который вы будете использовать для доступа к БД.
1. В списке **Сеть** выберите сеть, к которой подключена ваша ВМ.
1. В разделе **Хосты** добавьте еще два хоста в других зонах доступности. При создании хостов не включайте для них **Публичный доступ**.
1. Нажмите кнопку **Создать кластер**.

Создание кластера БД может занять несколько минут.

## Установите Joomla и дополнительные компоненты {#install}

После того как ВМ `joomla-pg-tutorial-web` перейдет в статус `RUNNING`, выполните:
1. В блоке **Сеть** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

   Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на ВМ.
1. Скачайте и распакуйте архив с Joomla:

   ```bash
   sudo mkdir -p /var/www/html/
   curl https://downloads.joomla.org/cms/joomla3/3-8-7/Joomla_3-8-7-Stable-Full_Package.tar.gz?format=gz -o Joomla_3-8-7-Stable-Full_Package.tar.gz -L
   sudo mv Joomla_3-8-7-Stable-Full_Package.tar.gz /var/www/html/
   (cd /var/www/html/ && sudo tar -zxvf Joomla_3-8-7-Stable-Full_Package.tar.gz)
   sudo rm /var/www/html/Joomla_3-8-7-Stable-Full_Package.tar.gz
   sudo mv /var/www/html/htaccess.txt /var/www/html/.htaccess
   ```

1. Установите дополнительные компоненты:

   {% list tabs %}

   - Ubuntu 14

     ```bash
     echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
     wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
     sudo apt-get update
     sudo apt-get -q -y install php5-pgsql php5-curl php5-json php5-cgi php5 libapache2-mod-php5 php5-mcrypt apache2 php5-common cron debconf-utils sendmail unzip iptables postgresql-client-10
     sudo mkdir ~www-data/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~www-data/.postgresql/root.crt
     sudo chmod 0600 ~www-data/.postgresql/root.crt
     sudo chown -R www-data:www-data ~www-data/.postgresql
     ```

   - Ubuntu 16

     ```bash
     echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
     wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
     sudo apt-get update
     sudo apt-get -q -y install php7.0-pgsql php7.0-curl php7.0-json php7.0-cgi php7.0 libapache2-mod-php7.0 php7.0-mcrypt apache2 php-mail php7.0-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
     sudo mkdir ~www-data/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~www-data/.postgresql/root.crt
     sudo chmod 0600 ~www-data/.postgresql/root.crt
     sudo chown -R www-data:www-data ~www-data/.postgresql
     ```

   - Ubuntu 18

     ```bash
     echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
     wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
     sudo apt-get update
     sudo apt-get -q -y install php7.2-pgsql php7.2-curl php7.2-json php7.2-cgi php7.2 libapache2-mod-php7.2 apache2 php-mail php7.2-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
     sudo mkdir ~www-data/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~www-data/.postgresql/root.crt
     sudo chmod 0600 ~www-data/.postgresql/root.crt
     sudo chown -R www-data:www-data ~www-data/.postgresql
     ```

   - CentOS 6

     ```bash
     sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-6-x86_64/pgdg-centos10-10-2.noarch.rpm
     sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
     sudo yum check-update
     sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
     sudo mkdir ~apache/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
     sudo chmod 0600 ~apache/.postgresql/root.crt
     sudo chown -R apache:apache ~apache/.postgresql
     ```

   - CentOS 7

     ```bash
     sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
     sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
     sudo yum check-update
     sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
     sudo mkdir ~apache/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
     sudo chmod 0600 ~apache/.postgresql/root.crt
     sudo chown -R apache:apache ~apache/.postgresql
     ```

    {% endlist %}

## Настройте веб-сервер Apache2 {#configure-apache2}

1. Выполните базовую настройку Apache2:

   {% list tabs %}

   - Ubuntu 14

     ```bash
     sudo a2enmod php5
     sudo a2dismod mpm_event
     sudo a2enmod mpm_prefork
     sudo a2enmod rewrite
     sudo chown -R www-data /var/www/html/
     ```

   - Ubuntu 16

     ```bash
     sudo a2enmod php7.0
     sudo a2dismod mpm_event
     sudo a2enmod mpm_prefork
     sudo a2enmod rewrite
     sudo chown -R www-data /var/www/html/
     ```

   - Ubuntu 18

     ```bash
     sudo a2enmod php7.2
     sudo a2dismod mpm_event
     sudo a2enmod mpm_prefork
     sudo a2enmod rewrite
     sudo chown -R www-data /var/www/html/
     ```

   - CentOS

     ```bash
     sudo chown -R apache /var/www/html/
     ```

   {% endlist %}

1. Задайте настройки виртуального хоста в конфигурационном файле Apache2. Вы можете отредактировать файл с помощью редактора `nano`:

   {% list tabs %}

   - Ubuntu

     ```bash
     sudo nano /etc/apache2/sites-enabled/000-default.conf
     ```

   - CentOS

     ```bash
     sudo nano /etc/httpd/conf.d/joomla.conf
     ```

   {% endlist %}

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

   {% list tabs %}

   - Ubuntu

     ```bash
     sudo service apache2 restart
     ```

   - CentOS

     ```bash
     sudo service httpd restart
     ```

   {% endlist %}

1. Этот шаг нужно выполнять только на ВМ с CentOS.

   Измените настройки SELinux:

   ```bash
   sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/html(/.*)?"
   sudo semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html(/.*)?"
   sudo restorecon -R /var/www/html
   setsebool -P httpd_can_network_connect 1
   ```

1. Этот шаг нужно выполнять только на ВМ с CentOS 6.

   Откройте сетевые порты 80 и 443 с помощью утилиты `iptables`:

   ```bash
   sudo iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
   sudo iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
   sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```

## Настройте Joomla {#configure-joomla}

Настройте Joomla по [инструкции](https://docs.joomla.org/J3.x:Installing_Joomla/ru) на сайте проекта. В процессе настройки вам потребуются параметры подключения к БД.

1. Получите адреса хостов кластера БД в консоли управления:
   1. Откройте каталог, в котором создан кластер БД.
   1. Выберите сервис **{{ mpg-name }}**.
   1. Выберите кластер `joomla-pg-tutorial-db-cluster`.
   1. Откройте вкладку **Хосты**.
   1. В колонке **Адрес (доменное имя)** найдите адреса хостов.
1. На шаге **Database** в веб-установщике Joomla заполните поля:
   * **Тип базы данных**: `{{ PG }}`.
   * **Имя сервера базы данных**:

     ```bash
     <адрес хоста 1>,<адрес хоста 2>,<адрес хоста 3> port=6432 sslmode=verify-full target_session_attrs=read-write
     ```

   * **Имя пользователя**: `joomla`.
   * **Пароль**: укажите пароль пользователя БД.
   * **Имя базы данных**: `joomla-pg-tutorial-db`.

Для проверки безопасности Joomla может потребовать удалить специальный тестовый файл. На ВМ перейдите в каталог `/var/www/html/installation` и удалите оттуда указанный файл.

## Загрузите файлы веб-сайта {#upload-files}

{% include [upload-files](../../_includes/solutions/_common/upload-web-site-files.md) %}

## Настройте DNS {#configure-dns}

Доменное имя, которое вы хотите использовать для веб-сайта, нужно связать с созданной ВМ `joomla-pg-tutorial-web`.

{% include [configure-a-record-and-cname](../../_includes/solutions/web/configure-a-record-and-cname.md) %}

## Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, откройте его адрес в браузере: `http://<публичный IP-адрес ВМ>`.

Проверить работу доменного имени аналогичным образом можно будет только через 15-20 минут после того, как вы изменили DNS-записи.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутый сервер и БД, достаточно удалить [созданную ВМ](../../compute/operations/vm-control/vm-delete.md) `joomla-pg-tutorial-web` и [кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md) `joomla-pg-tutorial-db-cluster`.

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:
1. Откройте сервис **{{ vpc-name }}** в вашем каталоге.
1. Перейдите на вкладку **IP-адреса**.
1. Найдите нужный адрес, нажмите значок ![ellipsis](../../_assets/options.svg) и выберите пункт **Удалить**.