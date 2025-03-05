На этом этапе вы подготовите окружение на виртуальной машине для запуска и настройки Joomla.

1. Экспортируйте TLS-сертификат `joomla-cert` на локальный компьютер:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
        1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}** и выберите сертификат `joomla-cert`.
        1. На панели сверху нажмите ![ArrowUpFromLine](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_export }}**, выберите вариант `{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_no_private_key }}` и нажмите **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_download }}**. На ваш компьютер будет скачан файл с сертификатом `certificate.pem`.
        1. Повторите предыдущее действие и скачайте закрытый ключ, выбрав вариант `{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_private_key_only }}`. Переименуйте скачанный файл с закрытым ключом в `private_key.pem`.
        1. Сохраните скачанные файлы `certificate.pem` и `private_key.pem` — они понадобятся при настройке веб-сервера.

    {% endlist %}

1. Скопируйте на ВМ полученные сертификат и закрытый ключ:

    ```bash
    scp ./certificate.pem yc-user@<IP-адрес_ВМ>:certificate.pem \
      && scp ./private_key.pem yc-user@<IP-адрес_ВМ>:private_key.pem
    ```

    Где `<IP-адрес_ВМ>` — публичный IP-адрес созданной ранее ВМ `joomla-web-server`.

    Узнать IP-адрес ВМ можно в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.

    При первом подключении к ВМ появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '51.250.**.*** (51.250.**.***)' can't be established.
    ED25519 key fingerprint is SHA256:PpcKdcT09gjU045pkEIwIU8lAXXLpwJ6bKC********.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH:

    ```bash
    ssh yc-user@<IP-адрес_ВМ>
    ```
1. Создайте директорию для сертификата и перенесите в нее скопированные файлы:

    ```bash
    sudo mkdir /etc/ssl-certificates
    sudo mv certificate.pem /etc/ssl-certificates/
    sudo mv private_key.pem /etc/ssl-certificates/
    ```
1. Обновите версии пакетов, установленные на ВМ:

    ```bash
    sudo apt update && sudo apt upgrade -y
    ```
1. Установите и запустите [Apache HTTP-сервер](https://ru.wikipedia.org/wiki/Apache_HTTP_Server):

    ```bash
    sudo apt install apache2
    sudo systemctl start apache2 && sudo systemctl enable apache2
    ```
1. Установите [PHP](https://ru.wikipedia.org/wiki/PHP) c необходимыми библиотеками:

    ```bash
    sudo apt install php libapache2-mod-php php-common php-pgsql php-xml php-mbstring php-curl php-zip php-intl php-json unzip
    ```
1. Скачайте и распакуйте пакет Joomla:

    {% note info %}

    В примере приведена ссылка на скачивание версии Joomla `5.2.4`, актуальной на момент написания данного руководства. Уточнить наличие более новой версии и получить ссылку на скачивание вы можете на [сайте](https://downloads.joomla.org/) проекта.

    {% endnote %}

    ```bash
    wget https://downloads.joomla.org/cms/joomla5/5-2-4/Joomla_5-2-4-Stable-Full_Package.zip -O Joomla.zip
    sudo rm /var/www/html/index.html
    sudo unzip Joomla.zip -d /var/www/html
    rm Joomla.zip
    ```
1. Настройте разрешения на доступ к директории с сайтом:

    ```
    sudo chown -R www-data:www-data /var/www/html
    sudo chmod -R 755 /var/www/html
    ```
1. Измените номер порта по умолчанию, использующийся Joomla для доступа к базам данных {{ PG }}: в {{ mpg-full-name }} используется порт `6432`.

    1. Откройте файл настроек драйверов доступа к базам данных Joomla:

        ```bash
        sudo nano /var/www/html/libraries/vendor/joomla/database/src/Pdo/PdoDriver.php
        ```
    1. Найдите в файле раздел с настройками баз данных {{ PG }} и замените номер порта c `5432` на `6432`:

        ```php
        ...
        case 'pgsql':
        $this->options['port'] = $this->options['port'] ?? 6432;
        ...
        ```

        Не забудьте сохранить внесенные изменения.
1. Настройте виртуальный хост для вашего сайта:

    1. Создайте файл конфигурации виртуального хоста:

        ```bash
        sudo nano /etc/apache2/sites-available/joomla.conf
        ```

    1. Поместите в созданный файл следующую конфигурацию:

        ```text
        <VirtualHost *:80>
            ServerAdmin admin@localhost
            DocumentRoot /var/www/html
            ServerName <имя_домена>

            <Directory /var/www/html>
                Options FollowSymLinks
                AllowOverride All
                Require all granted
            </Directory>

            ErrorLog ${APACHE_LOG_DIR}/joomla_http_error.log
            CustomLog ${APACHE_LOG_DIR}/joomla_http_access.log combined
        </VirtualHost>

        <VirtualHost *:443>
            ServerAdmin admin@localhost
            DocumentRoot /var/www/html
            ServerName <имя_домена>

            ErrorLog ${APACHE_LOG_DIR}/joomla_ssl_error.log
            CustomLog ${APACHE_LOG_DIR}/joomla_ssl_access.log combined

            SSLEngine on
            SSLCertificateFile /etc/ssl-certificates/certificate.pem
            SSLCertificateChainFile /etc/ssl-certificates/certificate.pem
            SSLCertificateKeyFile /etc/ssl-certificates/private_key.pem
        </VirtualHost>
        ```

        Где `<имя_домена>` — доменное имя вашего сайта. Например: `example.com`.
1. Активируйте созданный виртуальный хост и перезапустите веб-сервер:

    ```bash
    sudo a2ensite joomla.conf
    sudo a2enmod rewrite
    sudo a2enmod ssl
    sudo systemctl restart apache2
    ```