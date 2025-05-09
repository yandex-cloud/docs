# Docker-контейнер для монтирования бакета {{ objstorage-name }} к (S)FTP(S)-серверу

Для доступа к [бакету](../concepts/bucket.md) по протоколу FTP, [FTPS](https://{{ lang }}.wikipedia.org/wiki/FTPS) или [SFTP](https://ru.wikipedia.org/wiki/SFTP) можно развернуть сервер с помощью публичного [Docker-контейнера](/blog/posts/2022/03/docker-containers), предоставляемого {{ objstorage-name }}.

В Docker-контейнере реализованы связки FUSE-клиента {{ objstorage-name }} [GeeseFS](geesefs.md) и серверов: для FTP и FTPS — [vsftpd](https://security.appspot.com/vsftpd.html), для SFTP — sftp-server (входит в состав [OpenSSH](https://www.openssh.com/)).

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#install}

1. [Установите Docker](https://docs.docker.com/get-docker/).
1. [Аутентифицируйтесь в {{ container-registry-full-name }}](../../container-registry/operations/authentication.md).
1. Скачайте Docker-контейнер:

   ```bash
   docker pull {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
   ```

1. Создайте [папку](../concepts/object.md#folder) `secrets` для хранения данных пользователей FTP-сервера и настроек монтирования бакета:

   ```bash
   mkdir secrets
   ```

1. В папке `secrets`:
   * Создайте файл `credentials`:

     ```text
     [default]
     aws_access_key_id = <идентификатор_ключа>
     aws_secret_access_key = <содержимое_ключа>
     ```

     Где:
     * `aws_access_key_id` – идентификатор статического ключа доступа, [полученный ранее](#before-you-begin);
     * `aws_secret_access_key` – содержимое статического ключа доступа, [полученное ранее](#before-you-begin).
   * Если вы будете использовать SFTP, создайте файл `authorized_keys` с открытым [SSH-ключом](../../glossary/ssh-keygen.md):

     ```text
     ssh-ed25519 AAAAB3Nz.....BdZoeQ==
     ```

     
     Инструкцию по созданию пары SSH-ключей см. в [документации {{ compute-name }}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).


   * Если вы будете использовать FTPS, добавьте в папку TLS-сертификат `ftp.pem` и его ключ `ftp.key`. Например, для тестирования вы можете выпустить самоподписанный сертификат:

     ```bash
     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
       -keyout secrets/ftp.key -out secrets/ftp.pem
     ```
    
    
    {% include [tls-support-alert](../../_includes/storage/tls-support-alert.md) %}


1. Создайте файл `env.list` с переменными окружения для Docker-контейнера:

   ```text
   <имя_переменной>=<значение_переменной>
   ...
   ```

   Поддерживаемые переменные:
   * `S3_BUCKET` — имя бакета или указание на его папку, которую нужно монтировать к FTP-серверу, в формате `<имя_бакета>:<путь_к_папке>`. Обязательная переменная.
   * `SFTP` — включает использование SFTP. Значение по умолчанию — `YES`.
   * `FTP` — включает использование FTP. Значение по умолчанию — `NO`.
   * `FTP_USER` — имя пользователя для подключения к серверу. Значение по умолчанию — `s3`.
   * `FTP_PASS` — пароль пользователя для подключения к серверу. По умолчанию сгенерируется случайный пароль, который отобразится в логах Docker-контейнера.
   * `FTP_PASV_ENABLE` — включает пассивный режим FTP-соединений. Значение по умолчанию — `YES`.
   * `FTP_PASV_MIN_PORT` — начало диапазона портов для пассивного режима. Значение по умолчанию — `21100`.
   * `FTP_PASV_MAX_PORT` — конец диапазона портов для пассивного режима. Значение по умолчанию — `21100`.
   * `FTP_PASV_ADDRESS` — IP-адрес сервера или его доменное имя (если включена опция `FTP_PASV_ADDR_RESOLVE`) для пассивного режима. По умолчанию используется IP-адрес, указанный в таблице маршрутизации Docker-контейнера (команда `ip route show`) как IP-адрес назначения маршрута по умолчанию (ему соответствует строка вида `default via <IP-адрес> ...`).
   * `FTP_PASV_ADDR_RESOLVE` — разрешает указывать в переменной `FTP_PASV_ADDRESS` доменное имя сервера вместо его IP-адреса. Значение по умолчанию — `YES`.
   * `FTP_PASV_PROMISCUOUS` — отключает для пассивного режима сверку клиентских IP-адресов: управляющее соединение может быть открыто с одного клиентского адреса, а соединение для обмена данными — с другого. Значение по умолчанию — `NO`. Отключать проверку не рекомендуется.
   * `FTP_PORT_PROMISCUOUS` — отключает для активного режима сверку клиентских IP-адресов: при установке управляющего соединения клиент может указать в команде `PORT` чужой адрес. Значение по умолчанию — `NO`. Отключать проверку не рекомендуется.
   * `FTP_SSL_ENABLE` — настраивает использование FTPS (через TLS 1.x) вместо FTP:
     * `YES` (значение по умолчанию) — FTPS включен, но необязателен. Клиенты могут устанавливать с сервером незащищенные FTP-соединения.
     * `FORCE` — FTPS включен и обязателен. Клиенты должны устанавливать с сервером только FTPS-соединения.
     * `NO` — FTPS выключен.
   * `FTP_RSA_CERT_FILE` — путь к TLS-сертификату внутри Docker-контейнера. Значение по умолчанию — `/secrets/ftp.pem`.
   * `FTP_RSA_PRIVATE_KEY_FILE` — путь к закрытому ключу TLS-сертификата внутри Docker-контейнера. Значение по умолчанию — `/secrets/ftp.key`.
1. Запустите Docker-контейнер:

   {% list tabs group=protocols %}

   - SFTP {#sftp}
    
      ```bash
      docker run -d -it \
        --cap-add SYS_ADMIN \
        --device /dev/fuse \
        --security-opt apparmor:unconfined \
        --env-file env.list \
        -v <полный_путь_к_папке_secrets>:/secrets \
        -p 1022:22 \
        --name ftp \
        {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
      ```

     Сервер будет принимать соединения на порте 1022.

   - FTP(S) {#ftp}

     ```bash
     docker run -d -it \
       --cap-add SYS_ADMIN \
       --device /dev/fuse \
       --security-opt apparmor:unconfined \
       --env-file env.list \
       -v <полный_путь_к_папке_secrets>:/secrets \
       --expose 21 \
       -p 1021:21 \
       --expose 21100 \
       -p 21100:21100 \
       --name ftp \
       {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
     ```

     Сервер будет принимать соединения на порте 1021. Также для пассивного режима (переменная `FTP_PASV_ENABLE`) открыт порт 21100 — если вы не используете этот режим, опции `--expose 21100` и `-p 21100:21100` можно не использовать.

   {% endlist %}

1. Подключитесь к серверу:

   {% list tabs group=protocols %}

   - SFTP {#sftp}
    
      ```bash
      sudo sftp -i <путь_к_приватному_SSH-ключу> -P 1022 s3@localhost
      ```

      После успешного подключения вам будет доступна консоль для взаимодействия с SFTP-сервером.

   - FTP {#ftp}

     ```bash
     ftp -P 1021 s3@localhost
     ```

     После успешного подключения вам будет доступна консоль для взаимодействия с FTP-сервером.

   {% endlist %}

## Особенности загрузки файлов в бакет {#uploading-files}

Клиент GeeseFS, входящий в состав Docker-контейнера, работает с файлами асинхронно. Новые файлы кешируются клиентом и через некоторое время загружаются в бакет. При отключении FTP-сервера между этими двумя моментами загруженные файлы могут быть частично или полностью утеряны.

Чтобы обеспечить сохранность данных при SFTP-соединениях, используйте расширение `fsync@openssh.com`, чтобы загрузка файла считалась успешной только после системного вызова `fsync`. Например, для клиента sftp, входящего в состав OpenSSH, расширение включается с помощью флага `-f`: `sftp -f <адрес_сервера>`. Ожидание вызовов `fsync` замедляет работу с файлами.
