# Docker-контейнер для монтирования бакета {{ objstorage-name }} к (S)FTP(S)-серверу

Для доступа к бакету по протоколу FTP, [FTPS](https://{{ lang }}.wikipedia.org/wiki/FTPS) или [SFTP]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/SFTP){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol){% endif %} можно развернуть сервер с помощью публичного Docker-контейнера, предоставляемого {{ objstorage-name }}.

В контейнере реализованы связки FUSE-клиента {{ objstorage-name }} [GeeseFS](geesefs.md) и серверов: для FTP и FTPS — [vsftpd](https://security.appspot.com/vsftpd.html), для SFTP — sftp-server (входит в состав [OpenSSH](https://www.openssh.com/)).

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Установка {#install}

1. [Установите Docker](https://docs.docker.com/get-docker/).
1. [Аутентифицируйтесь в {{ container-registry-name }}](https://cloud.yandex.ru/docs/container-registry/operations/authentication).
1. Скачайте контейнер:

   ```bash
   docker pull {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
   ```
   
1. Создайте папку `secrets` для хранения данных пользователей FTP-сервера и настроек монтирования бакета:

   ```bash
   mkdir secrets
   ```
   
1. В папке `secrets`:
   
   * Создайте файл `credentials`:

     ```
     [default]
         aws_access_key_id = <идентификатор ключа>
         aws_secret_access_key = <содержимое ключа>
     ```

     Где:

     * `aws_access_key_id` – идентификатор статического ключа доступа, полученного [перед началом работы](#before-you-begin).
     * `aws_secret_access_key` – содержимое статического ключа доступа.

   * Если вы будете использовать SFTP, создайте файл `authorized_keys` с открытым SSH-ключом:

     ```
     ssh-ed25519 AAAAB3Nz.....BdZoeQ==
     ```

     {% if audience != "internal" %}Инструкцию по созданию пары SSH-ключей см. в [документации {{ compute-name }}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).{% endif %}

   * Если вы будете использовать FTPS, добавьте в папку TLS-сертификат `ftp.pem` и его ключ `ftp.key`. Например, для тестирования вы можете выпустить самоподписанный сертификат:

     ```bash
     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
       -keyout secrets/ftp.key -out secrets/ftp.pem
     ```
     
1. Создайте файл `env.list` с переменными окружения для контейнера:

   ```
   <имя переменной>=<значение переменной>
   ...
   ```
   
   Поддерживаемые переменные:
   
   * `S3_BUCKET` — имя бакета или указание на его [папку](../concepts/object.md#folder), которую нужно монтировать к FTP-серверу, в формате `<имя бакета>/<путь к папке>`. Обязательная переменная.
   * `SFTP` — включает использование SFTP. Значение по умолчанию — `YES`.
   * `FTP` — включает использование FTP. Значение по умолчанию — `NO`.
   * `FTP_USER` — имя пользователя для подключения к серверу. Значение по умолчанию — `s3`.
   * `FTP_PASS` — пароль пользователя для подключения к серверу. По умолчанию сгенерируется случайный пароль, который отобразится в логах контейнера.
   * `FTP_PASV_ENABLE` — включает пассивный режим FTP-соединений. Значение по умолчанию — `YES`.
   * `FTP_PASV_MIN_PORT` — начало диапазона портов для пассивного режима. Значение по умолчанию — `21100`.
   * `FTP_PASV_MAX_PORT` — конец диапазона портов для пассивного режима. Значение по умолчанию — `21100`.
   * `FTP_PASV_ADDRESS` — IP-адрес сервера или его доменное имя (если включена опция `FTP_PASV_ADDR_RESOLVE`) для пассивного режима. По умолчанию используется IP-адрес, указанный в таблице маршрутизации контейнера (команда `ip route show`) как адрес назначения маршрута по умолчанию (ему соответствует строка вида `default via <IP-адрес> ...`).
   * `FTP_PASV_ADDR_RESOLVE` — разрешает указывать в переменной `FTP_PASV_ADDRESS` доменное имя сервера вместо его IP-адреса. Значение по умолчанию — `YES`.
   * `FTP_PASV_PROMISCUOUS` — отключает для пассивного режима сверку клиентских IP-адресов: управляющее соединение может быть открыто с одного клиентского адреса, а соединение для обмена данными — с другого. Значение по умолчанию — `NO`. Отключать проверку не рекомендуется.
   * `FTP_PORT_PROMISCUOUS` — отключает для активного режима сверку клиентских IP-адресов: при установке управляющего соединения клиент может указать в команде `PORT` чужой адрес. Значение по умолчанию — `NO`. Отключать проверку не рекомендуется.
   * `FTP_SSL_ENABLE` — настраивает использование FTPS (через TLS 1.x) вместо FTP:
     
     * `YES` (значение по умолчанию) — FTPS включен, но необязателен. Клиенты могут устанавливать с сервером незащищенные FTP-соединения.
     * `FORCE` — FTPS включен и обязателен. Клиенты должны устанавливать с сервером только FTPS-соединения.
     * `NO` — FTPS выключен.
    
   * `FTP_RSA_CERT_FILE` — путь к TLS-сертификату внутри контейнера. Значение по умолчанию — `/secrets/ftp.pem`.
   * `FTP_RSA_PRIVATE_KEY_FILE` — путь к закрытому ключу TLS-сертификата внутри контейнера. Значение по умолчанию — `/secrets/ftp.key`.
   
1. Запустите контейнер:

   {% list tabs %}

   - SFTP

     ```bash
     docker run -d -it \
       --cap-add SYS_ADMIN \
       --device /dev/fuse \
       --security-opt apparmor:unconfined \
       --env-file env.list \
       -v <полный путь к папке secrets>:/secrets \
       -p 1022:22 \
       --name ftp \
       {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
     ```
     
     Сервер будет принимать соединения на порте 1022.
 
   - FTP(S)

     ```bash
     docker run -d -it \
       --cap-add SYS_ADMIN \
       --device /dev/fuse \
       --security-opt apparmor:unconfined \
       --env-file env.list \
       -v <полный путь к папке secrets>:/secrets \
       --expose 21 \
       -p 1021:21 \
       --expose 21100 \ 
       -p 21100:21100 \
       --name ftp \
       {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
     ```

     Сервер будет принимать соединения на порте 1021. Также для пассивного режима (переменная `FTP_PASV_ENABLE`) открыт порт 21100 — если вы не используете этот режим, опции `--expose 21100` и `-p 21100:21100` можно не использовать.

   {% endlist %}

## Особенности загрузки файлов в бакет {#uploading-files}

Клиент GeeseFS, входящий в состав Docker-контейнера, работает с файлами асинхронно. Новые файлы кешируются клиентом и через некоторое время загружаются в бакет. При отключении FTP-сервера между этими двумя моментами загруженные файлы могут быть частично или полностью утеряны.

Чтобы обеспечить сохранность данных при SFTP-соединениях, используйте расширение `fsync@openssh.com`, чтобы загрузка файла считалась успешной только после системного вызова `fsync`. Например, для клиента sftp, входящего в состав OpenSSH, расширение включается с помощью флага `-f`: `sftp -f <адрес сервера>`. Ожидание вызовов `fsync` замедляет работу с файлами.