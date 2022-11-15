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

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Убедитесь, что в выбранном каталоге есть сеть с подсетями в зонах доступности `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-c`. Для этого на странице каталога выберите сервис **{{ vpc-name }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если нужных подсетей или сети нет, [создайте их](../../vpc/quickstart.md).

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки сайта на Joomla входит:
* плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* плата за кластер БД {{ PG }} (см. [тарифы {{ mpg-full-name }}](../../managed-postgresql/pricing.md));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

{% endif %}

## Создайте виртуальную машину для Joomla {#create-vm}

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя ВМ — `joomla-pg-tutorial-web`.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите публичный образ [CentOS Stream](/marketplace/products/yc/centos-stream-8).
1. В блоке **Вычислительные ресурсы**:
   * Выберите [платформу](../../compute/concepts/vm-platforms.md).
   * Укажите необходимое количество vCPU и объем RAM.

   Для функционального тестирования хватит минимальной конфигурации:
   * **Платформа** — Intel Ice Lake.
   * **Гарантированная доля vCPU** — 20%.
   * **vCPU** — 2.
   * **RAM** — 1 ГБ.
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить ВМ при создании.
1. Укажите данные для доступа на ВМ:
   * В поле **Логин** введите имя пользователя.
   * В поле **SSH ключ** вставьте содержимое файла открытого ключа.
     Пару ключей для подключения по {% if lang == "ru" and audience != "internal" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %} необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
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

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo mkdir -p /var/www/html/
     curl https://downloads.joomla.org/cms/joomla3/3-8-7/Joomla_3-8-7-Stable-Full_Package.tar.gz?format=gz -o Joomla_3-8-7-Stable-Full_Package.tar.gz -L
     sudo mv Joomla_3-8-7-Stable-Full_Package.tar.gz /var/www/html/
     (cd /var/www/html/ && sudo tar -zxvf Joomla_3-8-7-Stable-Full_Package.tar.gz)
     sudo rm /var/www/html/Joomla_3-8-7-Stable-Full_Package.tar.gz
     sudo mv /var/www/html/htaccess.txt /var/www/html/.htaccess
     ```

   {% endlist %}

1. Установите дополнительные компоненты:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo dnf install epel-release
     sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
     sudo yum -y install --enablerepo remi-modular httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget php-json
     sudo dnf module enable postgresql:13
     sudo dnf install postgresql-server
     ```
   {% endlist %}

1. Получите и настройте использование SSL-сертификата:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo mkdir ~apache/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
     sudo chmod 0600 ~apache/.postgresql/root.crt
     sudo chown -R apache:apache ~apache/.postgresql
     ```

   {% endlist %}

## Настройте веб-сервер Apache2 {#configure-apache2}

1. Выполните базовую настройку Apache2:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo chown -R apache /var/www/html/
     ```

   {% endlist %}

1. Задайте настройки виртуального хоста в конфигурационном файле Apache2. Вы можете отредактировать файл с помощью редактора `nano`:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo nano /etc/httpd/conf.d/joomla.conf
     ```

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

   {% endlist %}

1. Перезапустите веб-сервер:

   {% list tabs %}
   
   - CentOS Stream

     ```bash
     sudo service httpd restart
     ```

   {% endlist %}

1. Измените настройки:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo restorecon -R /var/www/html
     sudo setsebool -P httpd_can_network_connect 1
     ```

   {% endlist %}

## Настройте Joomla {#configure-joomla}

Настройте Joomla по [инструкции]{% if lang == "ru" %}(https://docs.joomla.org/J3.x:Installing_Joomla/ru){% endif %}{% if lang == "en" %}(https://docs.joomla.org/J3.x:Installing_Joomla){% endif %} на сайте проекта. В процессе настройки вам потребуются параметры подключения к БД.

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

1. Для проверки безопасности Joomla! может потребовать создать или удалить специальный тестовый файл. На ВМ перейдите в каталог `/var/www/html/installation` и создайте или удалите там указанный файл.
1. Создайте пустой файл `configuration.php` для сохранения конфигурации и настройте права для записи в каталог:
    
    ```
    sudo touch /var/www/html/configuration.php
    sudo chmod 655 /var/www/html/configuration.php
    sudo chown -R apache:apache /var/www/html/
    sudo restorecon -R /var/www/html
    ```

1. После завершения установки удалите директорию `Installation`. Это требование безопасности Joomla!:
    ```bash
    sudo rm -rf /var/www/html/Installation
    ```

## Загрузите файлы веб-сайта {#upload-files}

1. В блоке **Сеть** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`: 

     ```bash
     sudo chown -R "$USER":apache /var/www/html
     ```

1. Загрузите на ВМ файлы веб-сайта с помощью [протокола SCP]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/SCP){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Secure_copy_protocol){% endif %}.

   {% list tabs %}

   - Linux/macOS

     Используйте утилиту командной строки `scp`:

     ```bash
     scp -r <путь до директории с файлами> <имя пользователя ВМ>@<IP-адрес виртуальной машины>:/var/www/html
     ```

   - Windows

     С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

   {% endlist %}

## Настройте DNS {#configure-dns}

Доменное имя, которое вы хотите использовать для веб-сайта, нужно связать с IP-адресом созданной ВМ `joomla-pg-tutorial-web`. Для управления доменом можно использовать сервис {{ dns-name }}.

{% include [configure-a-record-and-cname](../../_tutorials/web/configure-a-record-and-cname.md) %}

## Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, введите в браузере его IP-адрес или доменное имя:
* `http://<публичный IP-адрес виртуальной машины>`.
* `http://www.example.com`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутый сервер и БД, достаточно удалить [созданную ВМ](../../compute/operations/vm-control/vm-delete.md) `joomla-pg-tutorial-web` и [кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md) `joomla-pg-tutorial-db-cluster`.

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:
1. Выберите сервис **{{ vpc-name }}** в вашем каталоге.
1. Перейдите на вкладку **IP-адреса**.
1. Найдите нужный адрес, нажмите значок ![ellipsis](../../_assets/options.svg) и выберите пункт **Удалить**.
