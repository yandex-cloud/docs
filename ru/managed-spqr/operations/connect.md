---
title: Подключение к кластеру {{ SPQR }}
description: Следуя данной инструкции, вы сможете подключиться к кластеру {{ SPQR }}.
---

# Подключение к кластеру {{ SPQR }}

К хостам кластера {{ mspqr-name }} можно подключиться:

* Через интернет, если вы настроили публичный доступ для нужного хоста. К таким хостам подключиться можно только с использованием SSL-соединения.

* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [облачной сети](../../vpc/concepts/network.md). Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.

Подключение возможно ко всем [типам хостов](../concepts/index.md): `INFRA`, `ROUTER`, `COORDINATOR`, хосты {{ PG }}-кластера. Подключение выполняется через порт {{ port-mpg }}. К хостам типа `COORDINATOR`, а также к консоли администратора {{ SPQR }} необходимо подключаться от имени пользователя `spqr-console` к базе данных `spqr-console`. Консоль администратора позволяет настроить правила шардирования. Подробнее см. в [документации SPQR](https://pg-sharding.tech/welcome/get_started).


## Настройка групп безопасности {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

    [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт {{ port-mpg }}. Для этого создайте следующее правило для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mpg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт {{ port-mpg }}. Для этого в этих группах создайте следующее правило для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mpg }}`.
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

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера.

{% endnote %}


## Получение SSL-сертификата {#get-ssl-cert}

Хосты {{ SPQR }} с публичным доступом поддерживают только шифрованные соединения. Чтобы использовать их, получите SSL-сертификат:

{% include [install-certificate](../../_includes/mdb/mpg/install-certificate.md) %}

## FQDN хоста {{ SPQR }} {#fqdn}

Для подключения к хосту потребуется его [FQDN](../../glossary/fqdn.md) — доменное имя.

FQDN можно посмотреть в консоли управления:

1. Перейдите на страницу кластера.
1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

## Подключение с помощью Bash {#bash}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    1. Подключитесь к базе данных:

        ```bash
        psql "host=<FQDN_хоста> \
              port={{ port-mpg }} \
              sslmode=disable \
              dbname=<имя_БД> \
              user=<имя_пользователя> \
              target_session_attrs=read-write"
        ```

        Где `target_session_attrs` определяет тип запроса к хосту. Например, значение `read-write` дает возможность чтения и записи. Подробнее см. в [документации SPQR](https://pg-sharding.tech/routing/hints#spqr-target-session-attrs).

        После выполнения команды введите пароль пользователя для завершения процедуры подключения.

    1. Для проверки успешности подключения выполните запрос:

        ```bash
        SELECT version();
        ```

- Подключение с SSL {#with-ssl}

    1. Подключитесь к базе данных:

        ```bash
        psql "host=<FQDN_хоста> \
              port={{ port-mpg }} \
              sslmode=verify-full \
              dbname=<имя_БД> \
              user=<имя_пользователя> \
              target_session_attrs=read-write"
        ```

        Где `target_session_attrs` определяет тип запроса к хосту. Например, значение `read-write` дает возможность чтения и записи. Подробнее см. в [документации SPQR](https://pg-sharding.tech/routing/hints#spqr-target-session-attrs).

        После выполнения команды введите пароль пользователя для завершения процедуры подключения.

    1. Для проверки успешности подключения выполните запрос:

        ```bash
        SELECT version();
        ```

{% endlist %}

## Подключение из {{ pgadmin }} {#connection-pgadmin}

Подключение проверялось для [{{ pgadmin }}](https://www.pgadmin.org) версии 9.1 в Windows 10.

Подключаться из {{ pgadmin }} можно только к хостам кластера в публичном доступе с [использованием SSL-сертификата](#get-ssl-cert).

Создайте новое подключение к серверу:

1. Выберите в меню **Object** → **Register** → **Server...**
1. На вкладке **General** в поле **Name** укажите имя, под которым кластер будет отображаться в интерфейсе {{ pgadmin }}. Имя может быть любым.
1. На вкладке **Connection** укажите параметры подключения:

    * **Host name/address** — [FQDN хоста](#fqdn);
    * **Port** — `{{ port-mpg }}`;
    * **Maintenance database** — имя БД для подключения;
    * **Username** — имя пользователя, от имени которого выполняется подключение;
    * **Password** — пароль пользователя.

1. На вкладке **Parameters**:

    * Установите параметр **SSL mode** в значение `verify-full`.
    * Добавьте новый параметр **Root certificate** и укажите в нем путь к сохраненному файлу SSL-сертификата.

1. Нажмите кнопку **Save**, чтобы сохранить настройки подключения к серверу.

Кластер появится в списке серверов в навигационном меню.
