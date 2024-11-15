Далее вы создадите и опубликуете на вашем веб-сервере сайт, который будет генерировать подписанные ссылки на контент, расположенный на защищенном CDN-ресурсе. Чтобы обеспечить безопасность передаваемых данных, вы скопируете на веб-сервер созданный ранее TLS-сертификат и включите SSL-шифрование.


### Выгрузите сертификат из {{ certificate-manager-name }} {#export-certificate}

Чтобы использовать созданный в {{ certificate-manager-name }} TLS-сертификат в конфигурации вашего веб-сервера, выгрузите цепочку сертификатов и закрытый ключ в текущую директорию:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  1. Узнайте идентификатор созданного ранее TLS-сертификата:

      ```bash
      yc certificate-manager certificate list
      ```

      Результат:

      ```text
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      |          ID          |     NAME      |           DOMAINS           |      NOT AFTER      |  TYPE   | STATUS |
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      | fpq90lobsh0l******** | mymanagedcert | cdn.example.com,example.com | 2024-03-22 16:42:53 | MANAGED | ISSUED |
      +----------------------+---------------+-----------------------------+---------------------+---------+--------+
      ```

      Подробнее о команде `yc certificate-manager certificate list` читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/certificate-manager/certificate/list.md).

  1. Выгрузите ключ и сертификат, указав полученный на предыдущем шаге идентификатор:

      ```bash
      yc certificate-manager certificate content \
        --id <идентификатор_сертификата> \
        --chain ./certificate_full_chain.pem \
        --key ./private_key.pem
      ```

      Подробнее о команде `yc certificate-manager certificate content` читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/certificate-manager/certificate/content.md).

{% endlist %}


### Настройте веб-сервер {#setup-web-server}

1. Скопируйте на ВМ с веб-сервером полученные сертификаты и закрытый ключ:

    ```bash
    scp ./certificate_full_chain.pem yc-user@<IP-адрес_ВМ>:certificate_full_chain.pem \
      && scp ./private_key.pem yc-user@<IP-адрес_ВМ>:private_key.pem
    ```

    Где `<IP-адрес_ВМ>` — публичный IP-адрес созданной ранее ВМ с веб-сервером.

    Узнать IP-адрес ВМ можно в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** или с помощью команды CLI `yc compute instance get mywebserver`.

    При первом подключении к ВМ появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '51.250.**.*** (51.250.**.***)' can't be established.
    ED25519 key fingerprint is SHA256:PpcKdcT09gjU045pkEIwIU8lAXXLpwJ6bKC********.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ с веб-сервером:

    ```bash
    ssh yc-user@<IP-адрес_ВМ>
    ```

1. Создайте директорию для сертификата и перенесите в нее скопированные файлы:

    ```bash
    sudo mkdir /etc/ssl-certificates
    sudo mv certificate_full_chain.pem /etc/ssl-certificates/
    sudo mv private_key.pem /etc/ssl-certificates/
    ```

1. Создайте директорию для файлов вашего сайта и предоставьте необходимые права на нее пользователю `www-data`:

    ```bash
    sudo mkdir -p /var/www/<имя_домена>/public_html
    sudo chown www-data:www-data /var/www/<имя_домена>/public_html
    ```

    Где `<имя_домена>` — доменное имя вашего сайта, например `example.com`.

1. Настройте виртуальный хост для вашего сайта:

    1. Создайте файл конфигурации виртуального хоста:

        ```bash
        sudo nano /etc/apache2/sites-available/mywebsite.conf
        ```

    1. Поместите в созданный файл следующую конфигурацию:

        ```text
        <VirtualHost *:443>
        ServerName <имя_домена>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/<имя_домена>/public_html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        SSLEngine on
        SSLCertificateFile /etc/ssl-certificates/certificate_full_chain.pem
        SSLCertificateChainFile /etc/ssl-certificates/certificate_full_chain.pem
        SSLCertificateKeyFile /etc/ssl-certificates/private_key.pem
        </VirtualHost>
        ```

        Где `<имя_домена>` — доменное имя вашего сайта, например `example.com`.

    1. Активируйте созданный виртуальный хост:

        ```bash
        sudo a2ensite mywebsite
        ```

        Результат:

        ```text
        Enabling site mywebsite.
        To activate the new configuration, you need to run:
          systemctl reload apache2
        ```

    1. Включите для веб-сервера поддержку `ssl`:

        ```bash
        sudo a2enmod ssl
        ```

        Результат:

        ```text
        Considering dependency setenvif for ssl:
        Module setenvif already enabled
        Considering dependency mime for ssl:
        Module mime already enabled
        Considering dependency socache_shmcb for ssl:
        Enabling module socache_shmcb.
        Enabling module ssl.
        See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
        To activate the new configuration, you need to run:
          systemctl restart apache2
        ```

    1. Перезапустите веб-сервер:

        ```bash
        sudo systemctl reload apache2
        ```


### Создайте сайт {#create-website}

1. Создайте файл главной страницы сайта:

    ```bash
    sudo nano /var/www/<имя_домена>/public_html/index.php
    ```

    Где `<имя_домена>` — доменное имя вашего сайта, например `example.com`.

1. Поместите в созданный файл `index.php` следующий код:

    ```php
    <!DOCTYPE html>
    <html>
    <head>
      <title>Secure token generator website</title>
      <meta charset="utf-8" />
    </head>
    <body>

      <h2>Генератор защищенных ссылок</h2>
      <p>Ниже сгенерирована подписанная ссылка на защищенный CDN-ресурс. Срок жизни ссылки — 5 минут. Контент по ссылке доступен лишь тому пользователю, для которого сайт эту ссылку сгенерировал (проверяется по IP-адресу).</p>
      <br>

      <?php

        $secret = '<секретный_ключ>';
        $ip = trim(getUserIpAddr());
        $domain_name = '<доменное_имя>';
        $path = '<ключ_объекта>';
        $expires = time() + 300;
        $link = "$expires$path$ip $secret";
        $md5 = md5($link, true);
        $md5 = base64_encode($md5);
        $md5 = strtr($md5, '+/', '-_');
        $md5 = str_replace('=', '', $md5);
        $url = '<a href="https://'.$domain_name.$path.'?md5='.$md5.'&expires='.$expires.'" target="_blank">Подписанная ссылка на файл</a>';
    
        echo "<p>Ваш IP-адрес: <b>".$ip."</b></p><p>Если вы используете VPN, ссылка может не сработать. Для корректной работы генератора подписанных ссылок отключите VPN.</p>";
        echo "<br><br>";
        echo $url;
    
        function getUserIpAddr() {

            if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
               $addr = $_SERVER['HTTP_CLIENT_IP'];
            } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
               $addr = $_SERVER['HTTP_X_FORWARDED_FOR'];
            } else {
               $addr = $_SERVER['REMOTE_ADDR'];
            }
            return $addr;
        }
      ?>

    </body>
    </html>
    ```

    Где:
    * `$secret` — созданный при настройке CDN-ресурса секретный ключ.
    * `$domain_name` — доменное имя созданного CDN-ресурса. Например: `cdn.example.com`.
    * `$path` — [ключ объекта](../../../storage/concepts/object.md#key) в бакете-[источнике](../../../cdn/concepts/origins.md), например `/content.jpg`. Обязательно со знаком `/`.
       Сайт будет генерировать подписанную ссылку для доступа к этому объекту через CDN-ресурс.