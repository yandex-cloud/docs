# Подключение к базе данных в кластере {{ PG }}

К хостам кластера {{ mpg-short-name }} можно подключиться:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

{% note info %}

Если публичный доступ в вашем кластере настроен только для некоторых хостов, автоматическая смена мастера может привести к тому, что вы не сможете подключиться к мастеру из интернета.

{% endnote %}


## Настройка SSL-сертификата {#configuring-an-ssl-certificate}

{{ PG }}-хосты с публичным доступом поддерживают только соединения с SSL-сертификатом. Подготовить сертификат можно так:

{% if audience != "internal" %}

```bash
$ mkdir ~/.postgresql
$ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.postgresql/root.crt
$ chmod 0600 ~/.postgresql/root.crt
```

{% else %}

```bash
$ mkdir ~/.postgresql
$ wget "{{ pem-path }}" -O ~/.postgresql/root.crt
$ chmod 0600 ~/.postgresql/root.crt
```

{% endif %}


## Строка подключения {#connection-string}

Подключиться к БД с помощью команды `psql`.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% list tabs %}

- SSL

  {% include [public-connect-ssl](../../_includes/mdb/public-connect-ssl.md) %}

  ```bash
  $ psql "host=<FQDN хоста БД> \
          port=6432 \
          sslmode=verify-full \
          dbname=<имя базы данных> \
          user=<имя пользователя базы данных>"
  ```

- Без SSL

  Если вам не нужно шифровать трафик внутри виртуальной сети при подключении к БД, то можно подключаться к базе без SSL-соединения. Передайте параметр `sslmode` со значением `disable`:

  ```bash
  $ psql "host=<FQDN хоста БД> \
          port=6432 \
          sslmode=disable \
          dbname=<имя базы данных> \
          user=<имя пользователя базы данных>"
  ```

{% endlist%}


## Автоматический выбор хоста-мастера {#automatic-master-host-selection}

### С библиотекой libpq {#using-libpq}

Чтобы гарантированно подключиться к хосту-мастеру, укажите FQDN всех хостов кластера в аргументе `host` и передайте параметр `target_session_attrs=read-write`. Этот параметр поддерживается библиотекой `libpq` начиная с [версии 10](https://www.postgresql.org/docs/10/static/libpq-connect.html):

```bash
psql "host=<FQDN хоста 1>,<FQDN хоста 2>,<FQDN хоста 3> \
      port=6432 \
      sslmode=verify-full \
      dbname=<имя базы данных> \
      user=<имя пользователя базы данных> \
      target_session_attrs=read-write"
```

Чтобы обновить версию библиотеки, которую использует утилита `psql`:

* Для дистрибутивов Linux на основе Debian — установите пакет `postgresql-client-10` (например, через [apt-репозиторий](https://www.postgresql.org/download/linux/ubuntu/)).

* Для ОС, использующих RPM-пакеты, дистрибутив {{ PG }} доступен в [yum-репозитории](https://yum.postgresql.org/).


Адреса всех хостов в кластере БД можно найти на странице нужного кластера в консоли управления.


### С драйвером, поддерживающим только один хост {#with-a-driver-that-supports-only-one-host}

Если ваш драйвер для подключения к базе данных не позволяет передавать несколько хостов в строке подключения (например,
[pgx в Go](https://github.com/jackc/pgx)), вы можете подключаться на специальный хост вида `c-<идентификатор кластера>.rw.{{ dns-zone }}`.

{% if audience == "internal" %}
{% note info %}

Также есть специальный хост для наименее отставшей рабочей реплики: `c-<идентификатор кластера>.ro.{{ dns-zone }}`.

{% endnote %}

{% endif %}

Это доменное имя всегда указывает на текущий мастер в кластере. Например, для кластера с идентификатором `c9qash3nb1v9ulc8j9nm` к мастеру можно подключиться так:

```bash
$ psql "host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<имя базы данных> \
      user=<имя пользователя базы данных>"
```
