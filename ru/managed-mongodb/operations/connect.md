# Подключение к базе данных в кластере {{ MG }}

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

Для подключения к хостам кластеров {{ mmg-name }} указывайте порт 27018.

## Аутентификация

{{ MG }}-кластеры {{ mmg-short-name }} поддерживают только шифрованные соединения. Поэтому для подключения к такому кластеру необходим SSL-сертификат. Подготовить все нужные аутентификационные данные можно так:

```bash
$ mkdir ~/.mongodb
$ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.mongodb/CA.pem
$ chmod 0600 ~/.mongodb/CA.pem
```

## Строка подключения

Теперь вы можете подключиться к БД с помощью команды `mongo`, перечислив все хосты кластера в значении параметра `host`:

```bash
$ mongo --norc \
        --ssl \
        --sslCAFile ~/.mongodb/CA.pem \
        --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
        -u <имя пользователя> \
        -p <пароль пользователя> \
        <имя БД>
```

Запросы на запись будут автоматически направлены в первичный хост кластера.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

