# Подключение к базе данных в кластере {{ MY }}

К хостам кластера {{ mmy-short-name }} можно подключиться:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note info %}

Если публичный доступ в вашем кластере настроен только для некоторых хостов, автоматическая смена мастера может привести к тому, что вы не сможете подключиться к мастеру из интернета.

{% endnote %}


## Настройка SSL-сертификата {#Configuring-an-SSL-certificate}

{{ MY }}-хосты с публичным доступом поддерживают только соединения с SSL-сертификатом. Подготовить сертификат можно так:


```bash
$ mkdir ~/.mysql
$ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.mysql/root.crt
$ chmod 0600 ~/.mysql/root.crt
```



## Строка подключения {#Connection-string}

Подключиться к БД с помощью команды `mysql`.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% list tabs %}

- SSL

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}

  ```bash
  $ mysql --host=<FQDN хоста>
          --port=3306
          --ssl-ca=~/.mysql/root.crt
          --ssl-mode=REQUIRED
          --user=<имя пользователя базы данных>
          --password <имя базы данных>
  ```

- Без SSL

  Если вам не нужно шифровать трафик внутри виртуальной сети при подключении к БД, то можно подключаться к базе без SSL-соединения. Передайте параметр `--ssl-mode` со значением `DISABLED`:

  ```bash
  $ mysql --host=<FQDN хоста>
          --port=3306
          --ssl-mode=DISABLED
          --user=<имя пользователя базы данных>
          --password <имя базы данных>
  ```

{% endlist%}


## Подключение к мастеру {#Connecting-to-master}

На текущий мастер в кластере всегда указывает хост вида `c-<идентификатор кластера>.rw.{{ dns-zone }}`. Например, для кластера с идентификатором `c9qash3nb1v9ulc8j9nm` к мастеру можно подключиться так:

```bash
$ mysql --host=c-c9qash3nb1v9ulc8j9nm.rw.mdb.yandexcloud.net
        --port=3306
        --ssl-ca=~/.mysql/root.crt
        --ssl-mode=REQUIRED
        --user=<имя пользователя базы данных>
        --password <имя базы данных>
```
