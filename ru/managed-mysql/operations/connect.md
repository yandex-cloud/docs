# Подключение к базе данных в кластере {{ MY }}

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

## Аутентификация

{{ MY }}-кластеры {{ mmy-short-name }} с публичным доступом поддерживают только шифрованные соединения. Поэтому для подключения к такому кластеру необходим SSL-сертификат. Подготовить все нужные аутентификационные данные можно так:

{% if audience != "internal" %}

```bash
$ mkdir ~/.mysql
$ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mysql/root.crt
$ chmod 0600 ~/.mysql/root.crt
```

{% else %}

```bash
$ mkdir ~/.mysql
$ wget "{{ pem-path }}" -O ~/.mysql/root.crt
$ chmod 0600 ~/.mysql/root.crt
```

{% endif %}

## Строка подключения

Теперь вы можете подключиться к БД с помощью команды `mysql`:

```bash
$ mysql --host=<FQDN хоста>
        --port=3306
        --ssl-ca=~/.mysql/root.crt
        --ssl-mode=REQUIRED
        --user=<имя пользователя базы данных>
        --password <имя базы данных>
```

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

Если вам не нужно шифровать трафик внутри виртуальной сети при подключении к БД, то можно подключаться к базе без SSL-соединения. Это возможно только если к хосту нет публичного доступа: в противном случае, сервер всегда будет требовать SSL-соединение. Если вы подключаетесь к БД без публичного доступа с виртуальной машины {{ compute-name }}, то передайте параметр `--ssl-mode` со значением `DISABLED`:

```bash
$ mysql --host=<FQDN хоста>
        --port=3306
        --ssl-mode=DISABLED
        --user=<имя пользователя базы данных>
        --password <имя базы данных>
```

## Подключение к мастеру

На текущий мастер в кластере всегда указывает хост вида `c-<идентификатор кластера>.rw.{{ dns-zone }}`.

Например, для кластера с идентификатором `c9qash3nb1v9ulc8j9nm` к мастеру можно подключиться так:

```bash
$ mysql --host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }}
        --port=3306
        --ssl-ca=~/.mysql/root.crt
        --ssl-mode=REQUIRED
        --user=<имя пользователя базы данных>
        --password <имя базы данных>
```
