# Подключение к {{ PG }}-кластеру

#### Возможен ли доступ к кластеру изнутри {{ yandex-cloud }}? {#conn-from-yc}

К хостам кластера {{ mpg-short-name }} можно подключиться:
* Через интернет, если вы настроили публичный доступ для нужного хоста. К таким хостам подключиться можно только используя SSL-соединение.
* С виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети. Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.

Подробнее см. в [документации сервиса](../../managed-postgresql/operations/connect.md).

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

2. [Разместите полученный сертификат в хранилище сертификатов Windows](https://docs.microsoft.com/en-us/skype-sdk/sdn/articles/installing-the-trusted-root-certificate).

#### Что делать, если при подключении я получаю ошибку SSL is required? {#ssl-req}

Ошибка означает, что вы пытаетесь подключиться к кластеру с [хостом в публичном доступе](../../managed-postgresql/concepts/network.md#public-access-to-a-host). Такие хосты поддерживают только соединения с SSL-сертификатом. Вы можете:

* [Получить SSL-сертификат](../../managed-postgresql/operations/connect.md#get-ssl-cert) и добавить его в приложение, которое вы используете для подключения.
* [Отключить публичный доступ для хостов](../../managed-postgresql/operations/hosts.md#update) и подключаться к кластеру с виртуальной машины, расположенной в той же облачной сети.

#### Сколько одновременных подключений к одному хосту доступно в {{ mpg-name }}? {#host-conn}

Количество одновременных подключений задается на уровне кластера в [настройке **Max connections**](../../managed-postgresql/concepts/settings-list.md#setting-max-connections). По умолчанию установлено максимальное значение, которое задается формулой:

```text
200 × <количество vCPU на одном хосте>
```

О том, как изменить настройки {{ PG }} на уровне кластера читайте в [документации](../../managed-postgresql/operations/update.md#change-postgresql-config).

#### Сколько подключений доступно одному пользователю? {#user-conn}

По умолчанию кластер резервирует для каждого пользователя 50 подключений к каждому хосту. Вы можете изменить это количество в [настройке **Conn limit**](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit).

Если лимит подключений для пользователя будет исчерпан, то попытка открыть новое подключение завершится ошибкой:

```text
too many active clients for user (pool_size for user <имя пользователя> reached <значение лимита>)
```

О том, как изменить настройки {{ PG }} на уровне пользователя читайте в [документации](../../managed-postgresql/operations/cluster-users.md#update-settings).
