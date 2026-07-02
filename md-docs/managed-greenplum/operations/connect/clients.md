[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > [Пошаговые инструкции](../index.md) > [Подключение](index.md) > Подключение из приложений

# Подключение к кластеру Yandex MPP Analytics for PostgreSQL из приложений

В этом разделе представлены настройки для подключения к хостам кластера Yandex MPP Analytics for PostgreSQL с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#connection-ide), [pgAdmin 4](#connection-pgadmin) и [Docker-контейнера](#connection-docker). О подключении из кода вашего приложения читайте в разделе [Примеры кода](code-examples.md).

При создании кластера Yandex MPP Analytics for PostgreSQL пользовательская база данных не создается. Для проверки подключения используйте служебную базу `postgres`.

Для подключения к кластеру с публичным доступом [подготовьте SSL-сертификат](index.md#get-ssl-cert). В примерах предполагается, что SSL-сертификат `root.crt` расположен в директории:

* `/home/<домашняя_директория>/.postgresql/` для Ubuntu;
* `$HOME\AppData\Roaming\postgresql` для Windows.

Подключиться к кластеру можно как с использованием обычного FQDN хоста-мастера, так и [особого FQDN](fqdn.md#fqdn-master) первичного хоста-мастера. При подключении через psql или с помощью JDBC-коннектора вы можете указать сразу два хоста-мастера. О том, как получить FQDN хоста, читайте в [инструкции](fqdn.md).


## Инструменты командной строки {#command-line-tools}

Примеры кода с заполненным FQDN хоста доступны в [консоли управления](https://console.yandex.cloud) по нажатию кнопки **Подключиться** на странице кластера.

### Linux (Bash) {#bash}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Подключитесь к базе данных:

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  ```bash
  psql "host=<FQDN_первичного_хоста-мастера>,<FQDN_резервного_хоста-мастера> \
        port=6432 \
        sslmode=disable \
        dbname=postgres \
        user=<имя_пользователя> \
        target_session_attrs=read-write"
  ```

- Подключение с SSL {#with-ssl}

  ```bash
  psql "host=<FQDN_первичного_хоста-мастера>,<FQDN_резервного_хоста-мастера> \
        port=6432 \
        sslmode=verify-full \
        dbname=postgres \
        user=<имя_пользователя> \
        target_session_attrs=read-write"
  ```

{% endlist %}

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

Для проверки успешности подключения выполните запрос:

```sql
SELECT version();
```

### Windows (PowerShell) {#powershell}

Перед подключением установите [PostgreSQL для Windows](https://www.postgresql.org/download/windows/) актуальной версии. Выберите только установку *Command Line Tools*.

Подключитесь к базе данных:

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  ```powershell
  & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" "`
      host=<FQDN_первичного_хоста-мастера>,<FQDN_резервного_хоста-мастера> `
      port=6432 `
      sslmode=disable `
      dbname=postgres `
      user=<имя_пользователя>"
  ```

- Подключение с SSL {#with-ssl}

  ```powershell
  & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" "`
      host=<FQDN_первичного_хоста-мастера>,<FQDN_резервного_хоста-мастера> `
      port=6432 `
      sslmode=verify-full `
      dbname=postgres `
      user=<имя_пользователя>"
  ```

{% endlist %}

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

Для проверки успешности подключения выполните запрос:

```sql
SELECT version();
```


### Подключение с авторизацией через IAM {#iam}

К базе данных в кластере Yandex MPP Analytics for PostgreSQL можно подключиться с помощью [интерфейса командной строки Yandex Cloud (CLI)](../../../cli/quickstart.md#install), используя авторизацию через IAM. Для этого нужно привязать к пользователю Yandex MPP Analytics for PostgreSQL [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport) или [федеративный аккаунт](../../../iam/concepts/users/accounts.md#saml-federation). Подключаться с авторизацией через IAM можно только к кластеру в публичном доступе, при этом использование SSL-сертификата не требуется.

Перед подключением установите клиент PostgreSQL:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Подготовьте кластер Yandex MPP Analytics for PostgreSQL к подключению:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.

  1. Нажмите на имя нужного кластера.

  1. [Включите публичный доступ к кластеру](../update.md#change-public-access).
 
  1. Назначьте роль аккаунту пользователя, который будет подключаться к БД:
     1. Выберите вкладку **Права доступа** и нажмите кнопку **Назначить роли**.
     1. Введите электронную почту пользователя, к которой привязан аккаунт.
     1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `managed-greenplum.clusters.connector`.
     1. Нажмите кнопку **Сохранить**.

  1. Создайте пользователя в кластере Yandex MPP Analytics for PostgreSQL и предоставьте ему доступ к нужной БД:
     1. Подключитесь к кластеру Yandex MPP Analytics for PostgreSQL любым удобным методом.
     1. Создайте пользователя, указав в качестве его имени электронную почту, к которой привязан аккаунт:

        ```sql
        CREATE ROLE "<электронная_почта_аккаунта>"
            LOGIN
            ENCRYPTED PASSWORD '<пароль>';
        ```
     1. При необходимости [настройте привилегии](../roles-and-users.md#privileges) и атрибуты созданного пользователя.

  1. Добавьте правило аутентификации созданного пользователя:
     1. Выберите вкладку **Аутентификация пользователей**.
     1. Нажмите кнопку **Редактировать правила**.
     1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить правило** и задайте его параметры:

        * **Тип** — тип соединения.
        * **База данных** — имя БД.
        * **Пользователь** — электронная почта пользователя, к которой привязан аккаунт.
        * **Адрес (CIDR/FQDN)** — диапазон IP-адресов, с которых будет выполняться подключение к базе данных.
        * **Метод** — `iam`.

     1. Нажмите кнопку **Сохранить**.

{% endlist %}

Чтобы подключиться к БД в кластере Yandex MPP Analytics for PostgreSQL, выполните команду:

```bash
yc managed-greenplum connect <имя_или_идентификатор_кластера> --db <имя_БД>
```


## Подключение из графических IDE {#connection-ide}

**Подключения проверялись в следующем окружении:**

* Ubuntu 20.04, DBeaver: `22.2.4`;
* MacOS Monterey 12.7:
  * JetBrains DataGrip: `2023.3.4`;
  * DBeaver Community: `24.0.0`.


Подключаться из графических IDE можно только к кластеру в публичном доступе с использованием SSL-сертификата.


Чтобы избежать ошибок при подключении, [сохраните сертификат](https://storage.yandexcloud.net/cloud-certs/RootCA.pem) в локальную папку, для доступа к которой не требуются права администратора.

{% list tabs group=ide %}

- DataGrip {#datagrip}

    1. Создайте источник данных:

        1. Выберите в меню **File** → **New** → **Data Source** → **Greenplum®**.
        1. На вкладке **General**:

            1. Укажите параметры подключения:

                * **User**, **Password** — имя и пароль пользователя БД;
                * **URL** — строка подключения:

                    ```http
                    jdbc:postgresql://<FQDN_первичного_хоста-мастера>:6432,<FQDN_резервного_хоста-мастера>:6432/<имя_БД>
                    ```

            1. Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
        1. На вкладке **SSH/SSL**:
            1. Включите настройку **Use SSL**.
            1. В поле **CA file** укажите путь к файлу [SSL-сертификата для подключения](#get-ssl-cert).
    1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
    1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver {#dbeaver}

    1. Создайте новое соединение с БД:
        1. Выберите в меню **База данных** пункт **Новое соединение**.
        1. Выберите из списка БД **Greenplum®**.
        1. Нажмите кнопку **Далее**.
        1. Укажите параметры подключения на вкладке **Главное**:
            * **Хост** — [особый FQDN первичного мастера](fqdn.md#fqdn-master): `c-<идентификатор_кластера>.rw.mdb.yandexcloud.net`;
            * **Порт** — `6432`;
            * **База данных** — имя БД для подключения;
            * В блоке **Аутентификация** укажите имя и пароль пользователя БД.
        1. На вкладке **SSL**:
            1. Включите настройку **Использовать SSL**.
            1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](#get-ssl-cert).
    1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
    1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

## Подключение из pgAdmin 4 {#connection-pgadmin}

Подключение проверялось для [pgAdmin 4](https://www.pgadmin.org) версии 7.1 в macOS Ventura 13.0 и Microsoft Windows 10 Pro 21H1.


Подключаться из pgAdmin 4 можно только к хостам кластера в публичном доступе с [использованием SSL-сертификата](#get-ssl-cert).


Создайте новое подключение к серверу:

1. Выберите в меню **Object** → **Register** → **Server...**
1. На вкладке **General** в поле **Name** укажите имя, под которым кластер будет отображаться в интерфейсе pgAdmin 4. Имя может быть любым.
1. На вкладке **Connection** укажите параметры подключения:

    * **Host name/address** — [особый FQDN хоста-мастера](fqdn.md#fqdn-master) или обычный FQDN хоста;
    * **Port** — `6432`;
    * **Maintenance database** — имя служебной базы данных `postgres`;
    * **Username** — имя пользователя, от имени которого выполняется подключение;
    * **Password** — пароль пользователя.

1. На вкладке **Parameters**:

    * Установите параметр **SSL mode** в значение `verify-full`.
    * Добавьте новый параметр **Root certificate** и укажите в нем путь к сохраненному файлу SSL-сертификата.

1. Нажмите кнопку **Save**, чтобы сохранить настройки подключения к серверу.

Кластер появится в списке серверов в навигационном меню.

Для наблюдения за состоянием кластера рекомендуется использовать сервис [Yandex Monitoring](../monitoring.md) вместо вкладки **Dashboard** в pgAdmin 4, потому что в ней может возникать ошибка:

```text
column "wait_event_type" does not exist LINE 10: wait_event_type || ': ' || wait_event AS wait_event, ^
```

При работе с другими вкладками в pgAdmin 4 эта ошибка не возникает.

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру Yandex MPP Analytics for PostgreSQL из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install postgresql-client --yes
    ```


- Подключение с SSL {#with-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install wget postgresql-client --yes && \
        mkdir --parents ~/.postgresql && \
        wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
             --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
    ```

{% endlist %}

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._