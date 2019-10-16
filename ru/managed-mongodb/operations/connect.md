# Подключение к базе данных в кластере {{ MG }}

К хостам кластера {{ mmg-short-name }} можно подключиться:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

Для подключения к хостам кластеров {{ mmg-name }} указывайте порт 27018.

{% note info %}

Если публичный доступ в вашем кластере настроен только для некоторых хостов, автоматическая смена основной реплики может привести к тому, что вы не сможете подключиться к основной реплике из интернета.

{% endnote %}

## Настройка SSL-сертификата

{{ MG }}-хосты с публичным доступом поддерживают только соединения с SSL-сертификатом. Подготовить сертификат можно так:

{% if audience != "internal" %}

```bash
$ mkdir ~/.mongodb
$ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mongodb/CA.pem
$ chmod 0600 ~/.mongodb/CA.pem
```

{% else %}

```bash
$ mkdir ~/.mongodb
$ wget "{{ pem-path }}" -O ~/.mongodb/CA.pem
$ chmod 0600 ~/.mongodb/CA.pem
```

{% endif %}

## Строка подключения

Подключиться к БД можно с помощью команды `mongo`, перечислив все хосты кластера в значении параметра `host`.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% list tabs %}

- SSL для mongo 4.2

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}

  ```bash
  $ mongo --norc \
          --tls \
          --tlsCAFile ~/.mongodb/CA.pem \
          --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
          -u <имя пользователя> \
          -p <пароль пользователя> \
          <имя БД>
  ```

- SSL для mongo старых версий

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}

  ```bash
  $ mongo --norc \
          --ssl \
          --sslCAFile ~/.mongodb/CA.pem \
          --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
          -u <имя пользователя> \
          -p <пароль пользователя> \
          <имя БД>
  ```
  

- Без SSL

  Если вам не нужно шифровать трафик внутри виртуальной сети при подключении к БД, то вы можете подключаться с виртуальной машины Яндекс.Облака без SSL-соединения. Передайте параметр `sslmode` со значением `disable`:
  
  ```bash
  $ mongo --norc \
          --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
          -u <имя пользователя> \
          -p <пароль пользователя> \
          <имя БД>
  ```

{% endlist%}

Запросы на запись будут автоматически направлены к основной реплике кластера.
