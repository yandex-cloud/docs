# Подключение к базе данных в кластере {{ MG }}

К хостам кластера {{ mmg-short-name }} можно подключиться:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

Для подключения к хостам кластеров {{ mmg-name }} указывайте порт 27018.

{% note info %}

Если публичный доступ в вашем кластере настроен только для некоторых хостов, автоматическая смена основной реплики может привести к тому, что вы не сможете подключиться к основной реплике из интернета.

{% endnote %}

## Ограничения на количество подключений {#connection-limits}

Максимальное доступное количество одновременных подключений к отдельному хосту кластера {{ mmg-name }} зависит от объема оперативной памяти этого хоста:

| Объем оперативной памяти | Максимальное количество подключений |
| ------------------------ | ------------------------------------|
| 2 ГБ | 2048 |
| 4 ГБ | 4096 |
| 8 ГБ | 8192 |
| 16 ГБ и выше | 16384 |

Доступный хосту объем оперативной памяти определяется классом этого хоста. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). 

## Настройка SSL-сертификата {#Configuring-an-SSL-certificate}

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

## Строка подключения {#Connection-string}

Подключиться к БД можно с помощью команды `mongo`, перечислив все хосты кластера в значении параметра `host`.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% list tabs %}

- SSL для mongo версий 4.2 и выше

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}
    
  {% if audience != "internal" %}

  ```bash
  $ mongo --norc \
          --tls \
          --tlsCAFile ~/.mongodb/CA.pem \
          --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
          -u <имя пользователя> \
          -p <пароль пользователя> \
          <имя БД>
  ```
 
  {% else %}

  ```bash
  $ mongo --norc \
          --tls \
          --tlsCAFile ~/.mongodb/CA.pem \
          --ipv6 \
          --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
          -u <имя пользователя> \
          -p <пароль пользователя> \
          <имя БД>
  ```

  {% endif %}




- SSL для mongo старых версий

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}

  {% if audience != "internal" %}

  ```bash
  $ mongo --norc \
          --ssl \
          --sslCAFile ~/.mongodb/CA.pem \
          --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
          -u <имя пользователя> \
          -p <пароль пользователя> \
          <имя БД>
  ```
 
  {% else %}

  ```bash
  $ mongo --norc \
          --ssl \
          --sslCAFile ~/.mongodb/CA.pem \
          --ipv6 \
          --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
          -u <имя пользователя> \
          -p <пароль пользователя> \
          <имя БД>
  ```

  {% endif %}




- Без SSL

  Если вам не нужно шифровать трафик внутри виртуальной сети при подключении к БД, то вы можете подключаться с виртуальной машины {{ yandex-cloud }} без SSL-соединения. Передайте параметр `sslmode` со значением `disable`:

  {% if audience != "internal" %}

  ```bash
  $ mongo --norc \
          --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
          -u <имя пользователя> \
          -p <пароль пользователя> \
          <имя БД>
  ```
 
  {% else %}

  ```bash
  $ mongo --norc \
          --ipv6 \
          --host 'rs01/<FQDN хоста 1>:27018,<FQDN хоста 2>:27018,<FQDN хоста N>:27018' \
          -u <имя пользователя> \
          -p <пароль пользователя> \
          <имя БД>
  ```

  {% endif %}



{% endlist%}

Запросы на запись будут автоматически направлены к основной реплике кластера.
