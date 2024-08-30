# Подключение к базе данных

Благодаря тому, что СУБД {{ GP }} основана на {{ PG }}, для подключения к обеим СУБД используются одни и те же инструменты.

Подключение к кластеру {{ mgp-short-name }} производится только через [первичный хост-мастер](../concepts/index.md). Чтобы определить роли хостов, получите [список хостов в кластере](./hosts/cluster-hosts.md).

К кластеру можно подключиться:

{% include [cluster-connect-note-monolithic](../../_includes/mdb/cluster-connect-note-monolithic.md) %}


## Настройка групп безопасности {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Для обеспечения работоспособности кластера {{ mgp-name }} и сетевой связности между его хостами необходимо, чтобы хотя бы в одной из его групп безопасности были правила, разрешающие любой входящий и исходящий трафик по любому протоколу с любых IP-адресов.

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

    {% include [Cluster security group rules](../../_includes/mdb/mgp/cluster-sg-rules.md) %}

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. {% include [Cluster security group rules](../../_includes/mdb/mgp/cluster-sg-rules.md) %}

    1. [Настройте группу безопасности](../../vpc/operations/security-group-add-rule.md), в которой находится ВМ так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

        Пример правил для ВМ:

        * Для входящего трафика:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило позволяет подключаться к ВМ по протоколу [SSH](../../glossary/ssh-keygen.md).

        * Для исходящего трафика:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}



## Автоматический выбор первичного мастера {#automatic-master-host-selection}

Чтобы выбирать хост для подключения к кластеру автоматически, используйте [особый FQDN первичного мастера](#fqdn-master).

## Получение SSL-сертификата {#get-ssl-cert}

Чтобы использовать SSL-соединение, получите сертификат:

{% include [install-certificate](../../_includes/mdb/mgp/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## FQDN хоста {{ GP }} {#fqdn}

Для подключения к хосту-мастеру потребуется его [FQDN](../concepts/network.md#hostname) — доменное имя. Его можно получить несколькими способами:

* [Запросите список хостов в кластере](hosts/cluster-hosts.md).
* Скопируйте команду для подключения к кластеру в [консоли управления]({{ link-console-main }}). Команда содержит список FQDN хостов-мастеров. Чтобы получить команду, перейдите на страницу кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
* Посмотрите FQDN в консоли управления:

   1. Перейдите на страницу кластера.
   1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

Для первичного хоста-мастера также используется [особый FQDN](#fqdn-master).

## Особый FQDN первичного мастера {#fqdn-master}

Чтобы вручную не подключаться к другому хосту-мастеру, если текущий станет недоступен, можно использовать особый FQDN вида `c-<идентификатор_кластера>.rw.{{ dns-zone }}`. Он всегда указывает на первичный хост-мастер. К этому FQDN разрешено подключаться и выполнять операции чтения и записи.

Пример подключения к первичному хосту-мастеру в кластере с идентификатором `c9qash3nb1v9********`:

```bash
psql "host=c-c9qash3nb1v9********.rw.{{ dns-zone }} \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=<имя_БД> \
      user=<имя_пользователя>"
```

## Подключение из графических IDE {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

Подключаться из графических IDE можно только к кластеру в публичном доступе с использованием SSL-сертификата.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

    1. Создайте источник данных:

        1. Выберите в меню **File** → **New** → **Data Source** → **{{ GP }}**.
        1. На вкладке **General**:

            1. Укажите параметры подключения:

                * **User**, **Password** — имя и пароль пользователя БД;
                * **URL** — строка подключения. Используйте [особый FQDN первичного мастера](#fqdn-master):

                    ```http
                    jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mgp }}/<имя_БД>
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
        1. Выберите из списка БД **{{ GP }}**.
        1. Нажмите кнопку **Далее**.
        1. Укажите параметры подключения на вкладке **Главное**:
            * **Хост** — [особый FQDN первичного мастера](#fqdn-master): `c-<идентификатор_кластера>.rw.{{ dns-zone }}`;
            * **Порт** — `{{ port-mgp }}`;
            * **База данных** — имя БД для подключения;
            * В блоке **Аутентификация** укажите имя и пароль пользователя БД.
        1. На вкладке **SSL**:
            1. Включите настройку **Использовать SSL**.
            1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](#get-ssl-cert).
    1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
    1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

## Подключение из {{ pgadmin }} {#connection-pgadmin}

Подключение проверялось для [{{ pgadmin }}](https://www.pgadmin.org) версии 7.1 в macOS Ventura 13.0 и Microsoft Windows 10 Pro 21H1.

Подключаться из {{ pgadmin }} можно только к хостам кластера в публичном доступе с [использованием SSL-сертификата](#get-ssl-cert).

Создайте новое подключение к серверу:

1. Выберите в меню **Object** → **Register** → **Server...**
1. На вкладке **General** в поле **Name** укажите имя, под которым кластер будет отображаться в интерфейсе {{ pgadmin }}. Имя может быть любым.
1. На вкладке **Connection** укажите параметры подключения:

    * **Host name/address** — [особый FQDN хоста-мастера](#fqdn-master) или обычный FQDN хоста;
    * **Port** — `{{ port-mgp }}`;
    * **Maintenance database** — имя служебной базы данных `postgres`;
    * **Username** — имя пользователя, от имени которого выполняется подключение;
    * **Password** — пароль пользователя.

1. На вкладке **Parameters**:

    * Установите параметр **SSL mode** в значение `verify-full`.
    * Добавьте новый параметр **Root certificate** и укажите в нем путь к сохраненному файлу SSL-сертификата.

1. Нажмите кнопку **Save**, чтобы сохранить настройки подключения к серверу.

Кластер появится в списке серверов в навигационном меню.

Для наблюдения за состоянием кластера рекомендуется использовать сервис [{{ monitoring-full-name }}](monitoring.md) вместо вкладки **Dashboard** в {{ pgadmin }}, потому что в ней может возникать ошибка:

```text
column "wait_event_type" does not exist LINE 10: wait_event_type || ': ' || wait_event AS wait_event, ^
```

При работе с другими вкладками в {{ pgadmin }} эта ошибка не возникает.

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mgp-name }} из Docker-контейнера, добавьте в Dockerfile строки:

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
        wget "{{ crt-web-path }}" \
             --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
    ```

{% endlist %}

## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mgp/conn-strings-env.md) %}

При создании кластера {{ GP }} пользовательская база данных не создается. Для проверки подключения используйте служебную базу `postgres`.

Для подключения к кластеру с публичным доступом [подготовьте SSL-сертификат](#get-ssl-cert). В примерах предполагается, что SSL-сертификат `root.crt` расположен в директории:

* `/home/<домашняя_директория>/.postgresql/` для Ubuntu;
* `$HOME\AppData\Roaming\postgresql` для Windows.

Подключиться к кластеру можно как с использованием обычного FQDN хоста-мастера, так и [особого FQDN](#fqdn-master) первичного хоста-мастера. О том, как получить FQDN хоста, см. [инструкцию](#fqdn).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mgp-connection-strings](../../_includes/mdb/mgp/conn-strings.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
