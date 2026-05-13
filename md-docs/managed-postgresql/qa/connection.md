# Подключение к кластеру PostgreSQL

* [Возможен ли доступ к кластеру изнутри Yandex Cloud?](#conn-from-yc)

* [Можно ли подключиться к кластеру из Docker-контейнера?](#conn-from-docker)

* [Как получить SSL-сертификат для подключения к Managed Service for PostgreSQL на Windows?](#get-ssl)

* [Как установить SSL-сертификат для подключения Power BI к Managed Service for PostgreSQL через psql?](#power-bi)

* [Можно ли подключиться к хостам кластера по SSH?](#connect-ssh)

* [Сколько одновременных подключений к одному хосту доступно в Managed Service for PostgreSQL?](#host-conn)

* [Сколько подключений доступно одному пользователю?](#user-conn)

* [Почему при попытке подключиться к базе данных из Looker Studio возникает ошибка?](#google-looker)

* [Как всегда подключаться к хосту-мастеру?](#connect-to-master)

* [Как всегда подключаться к наименее отстающей от мастера реплике?](#connect-to-replica)

* [Как подключиться к базе данных `postgres`?](#postgres-db)

* [Как получить пароль пользователя `postgres`?](#postgres-user)

#### Возможен ли доступ к кластеру изнутри Yandex Cloud? {#conn-from-yc}

К хостам кластера Managed Service for PostgreSQL можно подключиться:
* Через интернет, если вы настроили публичный доступ для нужного хоста. К таким хостам подключиться можно только используя [SSL-соединение](../../glossary/ssl-certificate.md).
* С виртуальных машин Yandex Cloud, расположенных в той же облачной сети. Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.
* Из контейнера в сервисе [Yandex Serverless Containers](../../serverless-containers/concepts/index.md). Если к хосту нет публичного доступа, контейнер должен располагаться в той же облачной сети.

Подробнее см. в [документации сервиса](../operations/connect/index.md).

#### Можно ли подключиться к кластеру из Docker-контейнера? {#conn-from-docker}

Да, для этого [настройте Dockerfile](../operations/connect/clients.md#connection-docker).

Пример подключения из контейнера в сервисе Yandex Serverless Containers см. в [практическом руководстве](../../serverless-containers/tutorials/pg-connect.md).

#### Как получить SSL-сертификат для подключения к Managed Service for PostgreSQL на Windows? {#get-ssl}

SSL-сертификат можно получить с помощью PowerShell:

```powershell
mkdir $HOME\.postgresql; curl.exe --output $HOME\.postgresql\root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
```

Сертификат будет сохранен в файле `$HOME\.postgresql\root.crt`.

Подробнее о получении сертификата и подключении к базе данных см. в [документации сервиса](../operations/connect/index.md).

#### Как установить SSL-сертификат для подключения Power BI к Managed Service for PostgreSQL через psql? {#power-bi}

1. Установите [Windows Subsystem for Linux](https://docs.microsoft.com/ru-ru/windows/wsl/) (WSL) и выполните в терминале команду:

   ```bash
   mkdir /mnt/c/temp && \
   curl "https://storage.yandexcloud.net/cloud-certs/CA.pem" --output /mnt/c/temp/CA.pem && \
   openssl pkcs12 -export -out /mnt/c/temp/CA.pfx -nokeys -in /mnt/c/temp/CA.pem
   ```

   Сертификат будет доступен по пути `C:\temp\CA.pfx`.

1. [Разместите полученный сертификат в хранилище сертификатов Windows](https://docs.microsoft.com/en-us/skype-sdk/sdn/articles/installing-the-trusted-root-certificate).

#### Можно ли подключиться к хостам кластера по SSH? {#connect-ssh}

Подключиться к хостам через SSH не получится. Это сделано в целях безопасности и отказоустойчивости пользовательских кластеров, так как прямые изменения внутри хоста могут привести к его полной неработоспособности.

#### Сколько одновременных подключений к одному хосту доступно в Managed Service for PostgreSQL? {#host-conn}

Количество одновременных подключений задается на уровне кластера в [настройке **Max connections**](../concepts/settings-list.md#setting-max-connections). По умолчанию установлено максимальное значение, которое задается формулой:

```text
200 × <количество_vCPU_на_одном_хосте>
```

О том, как изменить настройки PostgreSQL на уровне кластера читайте в [документации](../operations/update.md#change-postgresql-config).

#### Сколько подключений доступно одному пользователю? {#user-conn}

По умолчанию кластер резервирует для каждого пользователя 50 подключений к каждому хосту. Вы можете изменить это количество в [настройке **Conn limit**](../concepts/settings-list.md#setting-conn-limit).

Если лимит подключений для пользователя будет исчерпан, то попытка открыть новое подключение завершится ошибкой:

```text
too many active clients for user (pool_size for user <имя_пользователя> reached <значение_лимита>)
```

О том, как изменить настройки PostgreSQL на уровне пользователя, читайте в [документации](../operations/cluster-users.md#update-settings).

#### Почему при попытке подключиться к базе данных из Looker Studio возникает ошибка? {#google-looker}

Для подключения из Looker Studio необходимо сгенерировать и указать в настройках подключения файл сертификата клиента и приватный ключ. О том, как это сделать, см. в разделе [Подключение из Looker Studio](../operations/connect/clients.md#connection-google-looker).

#### Как всегда подключаться к хосту-мастеру? {#connect-to-master}

Чтобы подключиться к текущему хосту-мастеру, используйте [особый FQDN](../operations/connect/fqdn.md#special-fqdns). Он имеет вид `c-<идентификатор_кластера>.rw.mdb.yandexcloud.net`. При подключении к этому FQDN вы сможете выполнять операции чтения и записи.

{% cut "Пример команды для подключения к мастеру" %}

  ```bash
  psql "host=c-<идентификатор_кластера>.rw.mdb.yandexcloud.net \
        port=6432 \
        sslmode=verify-full \
        dbname=<имя_БД> \
        user=<имя_пользователя>"
  ```

{% endcut %}

#### Как всегда подключаться к наименее отстающей от мастера реплике? {#connect-to-replica}

Чтобы подключиться к наименее отстающей от мастера реплике, используйте [особый FQDN](../operations/connect/fqdn.md#special-fqdns). Он имеет вид `c-<идентификатор_кластера>.ro.mdb.yandexcloud.net`. При подключении к этому FQDN вы сможете выполнять только операции чтения. 

{% cut "Пример команды для подключения к реплике" %}

```bash
psql "host=c-<идентификатор_кластера>.ro.mdb.yandexcloud.net \
      port=6432 \
      sslmode=verify-full \
      dbname=<имя_БД> \
      user=<имя_пользователя>"
```

{% endcut %}

Если в кластере нет активных реплик, то этот FQDN укажет на текущий хост-мастер.

#### Как подключиться к базе данных `postgres`? {#postgres-db}

`postgres` — системная БД. По соображениям безопасности подключаться к системным БД нельзя.

#### Как получить пароль пользователя `postgres`? {#postgres-user}

По соображениям безопасности получить пароль пользователя `postgres` и подключиться к БД от его имени нельзя.