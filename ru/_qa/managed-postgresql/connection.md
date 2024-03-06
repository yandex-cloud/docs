# Подключение к кластеру {{ PG }}

#### Возможен ли доступ к кластеру изнутри {{ yandex-cloud }}? {#conn-from-yc}

К хостам кластера {{ mpg-short-name }} можно подключиться:
* Через интернет, если вы настроили публичный доступ для нужного хоста. К таким хостам подключиться можно только используя SSL-соединение.
* С виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети. Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.
* Из контейнера в сервисе [{{ serverless-containers-full-name }}](../../serverless-containers/concepts/index.md). Если к хосту нет публичного доступа, контейнер должен располагаться в той же облачной сети.

Подробнее см. в [документации сервиса](../../managed-postgresql/operations/connect.md).

#### Можно ли подключиться к кластеру из Docker-контейнера? {#conn-from-docker}

Да, для этого [настройте Dockerfile](../../managed-postgresql/operations/connect.md#connection-docker).

Пример подключения из контейнера в сервисе {{ serverless-containers-full-name }} см. в [практическом руководстве](../../serverless-containers/tutorials/pg-connect.md).

#### Как получить SSL-сертификат для подключения к {{ mpg-name }} на Windows? {#get-ssl}

SSL-сертификат можно получить с помощью PowerShell:

```powershell
mkdir $HOME\AppData\Roaming\postgresql; `
curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt {{ crt-web-path }}
```

Сертификат будет доступен по пути `$HOME\AppData\Roaming\postgresql\root.crt`.

Подробнее о получении сертификата и подключении к базе данных см. в [документации сервиса](../../managed-postgresql/operations/connect.md).

#### Как установить SSL-сертификат для подключения Power BI к {{ mpg-name }} через psql? {#power-bi}

1. Установите [Windows Subsystem for Linux]({{ ms.docs }}/windows/wsl/) (WSL) и выполните в терминале команду:

   ```bash
   mkdir /mnt/c/temp && \
   curl "{{ crt-web-path }}" -o /mnt/c/temp/CA.pem && \
   openssl pkcs12 -export -out /mnt/c/temp/CA.pfx -nokeys -in /mnt/c/temp/CA.pem
   ```

   Сертификат будет доступен по пути `C:\temp\CA.pfx`.

1. [Разместите полученный сертификат в хранилище сертификатов Windows](https://docs.microsoft.com/en-us/skype-sdk/sdn/articles/installing-the-trusted-root-certificate).

#### Что делать, если при подключении я получаю ошибку SSL is required? {#ssl-req}

Ошибка означает, что вы пытаетесь подключиться к кластеру с [хостом в публичном доступе](../../managed-postgresql/concepts/network.md#public-access-to-a-host). Такие хосты поддерживают только соединения с SSL-сертификатом. Вы можете:

* [Получить SSL-сертификат](../../managed-postgresql/operations/connect.md#get-ssl-cert) и добавить его в приложение, которое вы используете для подключения.
* [Отключить публичный доступ для хостов](../../managed-postgresql/operations/hosts.md#update) и подключаться к кластеру с виртуальной машины, расположенной в той же облачной сети.

#### Сколько одновременных подключений к одному хосту доступно в {{ mpg-name }}? {#host-conn}

Количество одновременных подключений задается на уровне кластера в [настройке **Max connections**](../../managed-postgresql/concepts/settings-list.md#setting-max-connections). По умолчанию установлено максимальное значение, которое задается формулой:

```text
200 × <количество_vCPU_на_одном_хосте>
```

О том, как изменить настройки {{ PG }} на уровне кластера читайте в [документации](../../managed-postgresql/operations/update.md#change-postgresql-config).

#### Сколько подключений доступно одному пользователю? {#user-conn}

По умолчанию кластер резервирует для каждого пользователя 50 подключений к каждому хосту. Вы можете изменить это количество в [настройке **Conn limit**](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit).

Если лимит подключений для пользователя будет исчерпан, то попытка открыть новое подключение завершится ошибкой:

```text
too many active clients for user (pool_size for user <имя_пользователя> reached <значение_лимита>)
```

О том, как изменить настройки {{ PG }} на уровне пользователя читайте в [документации](../../managed-postgresql/operations/cluster-users.md#update-settings).

#### Почему при попытке подключиться к базе данных возникает ошибка? {#database-error}

Подключение к базе данных может завершиться ошибкой вида:

```text
ERROR: odyssey: ce3ea075f4ffa: route for 'dbname.username' is not found
```

Ошибка означает, что в параметрах подключения указано неверное имя базы данных.

#### Почему при попытке подключиться к базе данных из {{ google-looker }} возникает ошибка? {#google-looker}

Для подключения из {{ google-looker }} необходимо сгенерировать и указать в настройках подключения файл сертификата клиента и приватный ключ. О том, как это сделать, см. в разделе [Подключение из {{ google-looker }}](../../managed-postgresql/operations/connect.md#connection-google-looker).

#### Почему соединение завершается ошибкой? {#connection-error}

Соединение с кластером {{ mpg-name }} может завершаться сообщением:

```text
FATAL: terminating connection due to administrator command
```

Такое сообщение не является ошибкой, а означает, что длительность сессии/транзакции превысила значение настройки [Session duration timeout](../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout) (по умолчанию — 12 часов).
