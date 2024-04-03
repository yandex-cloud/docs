---
title: "Подключение к кластеру {{ PG }} в {{ mpg-full-name }}"
description: "К хостам кластера {{ PG }} можно подключиться через интернет, если вы настроили публичный доступ для нужного хоста, и с виртуальных машин {{ yandex-cloud }}, расположенных в той же виртуальной сети."
---

# Подключение к базе данных в кластере {{ PG }}

К хостам кластера {{ mpg-short-name }} можно подключиться:

{% include [cluster-connect-note](../../_includes/mdb/mpg/cluster-connect-note.md) %}

{% note warning %}

Если публичный доступ в кластере настроен только для некоторых хостов, [автоматическая смена мастера](../concepts/replication.md#replication-auto) может привести к невозможности подключиться к мастеру из интернета.

{% endnote %}


## Настройка групп безопасности {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

  [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт 6432. Для этого создайте следующее правило для входящего трафика:

  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `6432`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- С ВМ в {{ yandex-cloud }} {#cloud}

  1. [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт 6432. Для этого в этих группах создайте следующее правило для входящего трафика:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `6432`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

  1. [Настройте группу безопасности](../../vpc/operations/security-group-add-rule.md), в которой находится ВМ так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

     Пример правил для ВМ:

     * Для входящего трафика:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

       Это правило позволяет [подключаться](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу [SSH](../../glossary/ssh-keygen.md).

     * Для исходящего трафика:
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

       Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру, если произойдет [ручная](hosts.md#update) или [автоматическая](../concepts/replication.md#replication-auto) смена мастера.

{% endnote %}

Подробнее о группах безопасности см. в разделе [{#T}](../concepts/network.md#security-groups).


## Получение SSL-сертификата {#get-ssl-cert}

{{ PG }}-хосты с публичным доступом поддерживают только шифрованные соединения. Чтобы использовать их, получите SSL-сертификат:

{% include [install-certificate](../../_includes/mdb/mpg/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## FQDN хоста {{ PG }} {#fqdn}

Для подключения к хосту потребуется его [FQDN](../concepts/network.md#hostname) — доменное имя. Его можно получить несколькими способами:

* [Запросите список хостов в кластере](../operations/hosts.md#list-hosts).
* Скопируйте команду для подключения к кластеру в [консоли управления]({{ link-console-main }}). Команда содержит заполненный FQDN хоста. Чтобы получить команду, перейдите на страницу кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-connect }}**.
* Посмотрите FQDN в консоли управления:

   1. Перейдите на страницу кластера.
   1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

Для хостов кластера также используются [особые FQDN](#special-fqdns).

## Особые FQDN {#special-fqdns}

Наравне с [обычными FQDN](#fqdn), {{ mpg-name }} предоставляет несколько особых FQDN, которые также можно использовать при подключении к кластеру.

{% note warning %}

Если при [автоматической смене мастера](../concepts/replication.md#replication-auto) новым мастером или наименее отстающей репликой станет хост без публичного доступа, подключиться к ним из интернета будет невозможно. Чтобы этого избежать, [включите публичный доступ](hosts.md#update) для всех хостов кластера.

{% endnote %}

### Текущий мастер {#fqdn-master}

FQDN вида `c-<идентификатор_кластера>.rw.{{ dns-zone }}` всегда указывает на текущий хост-мастер в кластере. Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

При подключении к этому FQDN разрешено выполнять операции чтения и записи.

{% note info %}

Используйте подключение с помощью особых FQDN хоста-мастера, чтобы обеспечить доступность вашего кластера даже после смены мастера.

{% endnote %}

Пример подключения к хосту-мастеру для кластера с идентификатором `c9qash3nb1v9********`:

```bash
psql "host=c-c9qash3nb1v9********.rw.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<имя_БД> \
      user=<имя_пользователя> \
      target_session_attrs=read-write"
```

### Наименее отстающая реплика {#fqdn-replica}

FQDN вида `c-<идентификатор_кластера>.ro.{{ dns-zone }}` указывает на наименее отстающую от мастера [реплику](../concepts/replication.md). Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

**Особенности:**

* При подключении к этому FQDN разрешено выполнять только операции чтения.
* Если в кластере нет активных реплик, то этот FQDN укажет на текущий хост-мастер.

Пример подключения к наименее отстающей реплике для кластера с идентификатором `c9qash3nb1v9********`:

```bash
psql "host=c-c9qash3nb1v9********.ro.{{ dns-zone }} \
      port=6432 \
      sslmode=verify-full \
      dbname=<имя_БД> \
      user=<имя_пользователя> \
      target_session_attrs=any"
```

## Автоматический выбор хоста-мастера {#automatic-master-host-selection}

Чтобы гарантированно подключиться к хосту-мастеру:

1. Укажите в аргументе `host` на выбор:

    * или [особый FQDN хоста-мастера](#fqdn-master), как сделано [в примерах ниже](#connection-string);
    * или [FQDN](#fqdn) всех хостов кластера.

1. Передайте параметр `target_session_attrs=read-write`. Этот параметр поддерживается библиотекой `libpq` начиная с [версии 10](https://www.postgresql.org/docs/10/static/libpq-connect.html).

Чтобы обновить версию библиотеки, которую использует утилита `psql`:

* Для дистрибутивов Linux на основе Debian — установите пакет `postgresql-client-10` или новее (например, через [apt-репозиторий](https://www.postgresql.org/download/linux/ubuntu/)).
* Для ОС, использующих RPM-пакеты — воспользуйтесь дистрибутивом {{ PG }}, доступным в [yum-репозитории](https://yum.postgresql.org/).

## Подключение из графических IDE {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием SSL-сертификата.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Создайте источник данных:
     1. Выберите в меню **File** → **New** → **Data Source** → **{{ PG }}**.
     1. Укажите параметры подключения на вкладке **General**:
        * **User**, **Password** — имя и пароль пользователя БД;
        * **URL** — строка подключения:

          ```http
          jdbc:postgresql://<особый_FQDN>:{{ port-mpg }}>/<имя_БД>
          ```

          Также в строке подключения можно использовать список [FQDN](#fqdn) всех хостов кластера:

          ```http
          jdbc:postgresql://<хост_1_{{ PG }}:{{ port-mpg }}>,...,<хост_N_{{ PG }}:{{ port-mpg }}>/<имя_БД>
          ```

        * Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
     1. На вкладке **SSH/SSL**:
         1. Включите настройку **Use SSL**.
         1. В поле **CA file** укажите путь к файлу [SSL-сертификата для подключения](#get-ssl-cert).
  1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver {#dbeaver}

  1. Создайте новое соединение с БД:
     1. Выберите в меню **База данных** пункт **Новое соединение**.
     1. Выберите из списка БД **{{ PG }}**.
     1. Нажмите кнопку **Далее**.
     1. Укажите параметры подключения на вкладке **Главное**:
        * **Хост** — [особый FQDN хоста-мастера](#fqdn-master) или [обычный FQDN хоста](#fqdn);
        * **Порт** — `{{ port-mpg }}`;
        * **База данных** — имя БД для подключения;
        * В блоке **Аутентификация** укажите имя и пароль пользователя БД.
     1. На вкладке **SSL**:
         1. Включите настройку **Использовать SSL**.
         1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](#get-ssl-cert).
  1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}


## Подключение из браузера {#browser}

Используйте сервис [{{ websql-full-name }}](../../websql) для соединения с кластерами {{ PG }} в {{ yandex-cloud }}.

{% include notitle [preview](../../_includes/note-preview.md) %}

{% include notitle [connect-to-cluster](../../_includes/websql/connect-to-cluster.md) %}

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}


## Подключение из {{ pgadmin }} {#connection-pgadmin}

Подключение проверялось для [{{ pgadmin }}](https://www.pgadmin.org) версии 7.0 в Ubuntu 20.04.

Подключаться из {{ pgadmin }} можно только к хостам кластера в публичном доступе с [использованием SSL-сертификата](#get-ssl-cert).

Создайте новое подключение к серверу:

1. Выберите в меню **Object** → **Register** → **Server...**
1. На вкладке **General** в поле **Name** укажите имя, под которым кластер будет отображаться в интерфейсе {{ pgadmin }}. Имя может быть любым.
1. На вкладке **Connection** укажите параметры подключения:

    * **Host name/address** — [особый FQDN хоста-мастера](#fqdn-master) или обычный [FQDN](../concepts/network.md#hostname) хоста;
    * **Port** — `{{ port-mpg }}`;
    * **Maintenance database** — имя БД для подключения;
    * **Username** — имя пользователя, от имени которого выполняется подключение;
    * **Password** — пароль пользователя.

1. На вкладке **Parameters**:

    * Установите параметр **SSL mode** в значение `verify-full`.
    * Добавьте новый параметр **Root certificate** и укажите в нем путь к сохраненному файлу SSL-сертификата.

1. Нажмите кнопку **Save**, чтобы сохранить настройки подключения к серверу.

Кластер появится в списке серверов в навигационном меню.

## Подключение из {{ google-looker }} {#connection-google-looker}

Подключаться из [{{ google-looker }}](https://lookerstudio.google.com/overview) можно только к хостам кластера в публичном доступе.

1. Сохраните [сертификат сервера]({{ crt-web-path }}) `CA.pem` в локальную папку.
1. В той же папке сгенерируйте сертификат клиента с приватным ключом:

    ```bash
    openssl req -newkey rsa:2048 -nodes -keyout private.pem -out cert.pem
    ```

    При создании сертификата программа предложит изменить ряд настроек. Нажмите **Enter**, чтобы использовать для них значения по умолчанию.

    В локальной папке появятся два файла: `cert.pem` и `private.pem`.

1. На [странице навигации {{ google-looker }}](https://lookerstudio.google.com/navigation/reporting) выберите **Создать** → **Источник данных**.
1. Выберите {{ PG }}.
1. Заполните поля:

    * **Имя хоста или IP-адрес** — [особый FQDN хоста-мастера](#fqdn-master) или обычный [FQDN](../concepts/network.md#hostname) хоста;
    * **Порт** — `{{ port-mpg }}`;
    * **База данных** — имя БД для подключения;
    * **Имя пользователя** — имя пользователя, от имени которого выполняется подключение;
    * **Пароль** — пароль пользователя.

1. Выберите опции **Включить SSL** и **Включить аутентификацию клиента**.
1. Укажите файлы сертификатов и приватный ключ клиента в соответствующих полях:

    * **Server certificate** — выберите файл `CA.pem`.
    * **Client certificate** — выберите файл `cert.pem`.
    * **Client private key** — выберите файл `private.pem`.

1. Нажмите **Выполнить аутентификацию**.

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mpg-name }} из Docker-контейнера, добавьте в Dockerfile строки:


{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install postgresql-client --yes
    ```

    Пример подключения из {{ serverless-containers-full-name }} см. в [практическом руководстве](../../serverless-containers/tutorials/pg-connect.md).

- Подключение с SSL {#with-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install wget postgresql-client --yes && \
        mkdir --parents ~/.postgresql && \
        wget "{{ crt-web-path }}" \
             --output-document ~/.postgresql/root.crt && \
        chmod 0600 ~/.postgresql/root.crt
    ```

{% endlist %}


## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mpg-conn-strings-env.md) %}

Подключиться к {{ PG }}-хостам в публичном доступе можно только с использованием SSL-сертификата. Перед подключением к таким хостам [подготовьте сертификат](#get-ssl-cert).

В примерах ниже предполагается, что SSL-сертификат `root.crt` расположен в директории:

* `/home/<домашняя_директория>/.postgresql/` для Ubuntu;
* `$HOME\AppData\Roaming\postgresql` для Windows.

Подключение без использования SSL-сертификата поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри облачной сети при подключении к БД шифроваться не будет.

Подключиться к кластеру возможно как с использованием обычных [FQDN](../concepts/network.md#hostname) хостов (можно передавать список из нескольких таких FQDN, разделенных запятой), так и [особых FQDN](#special-fqdns). В примерах используется особый FQDN текущего хоста-мастера.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mpg-connection-strings](../../_includes/mdb/mpg-conn-strings.md) %}

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ PG }}.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
