---
title: Начало работы с {{ mpg-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ PG }} и подключаться к нему.
---

# Как начать работать с {{ mpg-name }}

Сервис {{ mpg-name }} помогает создавать и поддерживать кластеры {{ PG }} в инфраструктуре {{ yandex-cloud }}.

Чтобы начать работу с сервисом:


1. [Создайте кластер БД](#cluster-create).
1. [Подключитесь к БД](#connect).
1. [Отправьте запросы к БД](#query-db).



## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и [{{ roles.mpg.editor }}](security/index.md#managed-postgresql-editor) на каталог. Эти роли позволяют создать кластер.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. Подключаться к [кластерам](../glossary/cluster.md) БД можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же облачной сети, что и кластер БД.

   * Чтобы подключиться к кластеру из интернета, запросите публичный доступ к хостам при [создании кластера](#cluster-create).

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру производится с ВМ. Если вы собираетесь подключаться к кластеру из интернета, переходите к [созданию кластера](#cluster-create).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).


## Создайте кластер {#cluster-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя кластера.
1. Выберите окружение `PRODUCTION`.
1. Выберите версию {{ PG }}.
1. Выберите [класс хостов](concepts/instance-types.md). Он определяет технические характеристики [виртуальных машин](../compute/concepts/vm.md), на которых будут развернуты [хосты](concepts/index.md) кластера.
1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

    1. Выберите [тип диска](concepts/storage.md#storage-type-selection).
    1. Задайте размер [хранилища](concepts/storage.md).

1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}**:

    1. Укажите имя БД. Оно должно быть уникальным в рамках каталога.
    1. Укажите имя пользователя — владельца БД.
    1. Введите пароль или сгенерируйте его с помощью [{{ connection-manager-name }}](../metadata-hub/concepts/connection-manager.md).

1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}**:

    1. Выберите [созданную перед началом работы](#before-you-begin) облачную сеть.
    1. Выберите группу безопасности по умолчанию или создайте новую.

1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** укажите зоны доступности и подсети для хостов, которые будут созданы вместе с кластером.

   Если вы собираетесь подключаться к кластеру из интернета, включите для хостов опцию **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}**.

1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

1. Дождитесь, когда кластер будет готов к работе: его статус сменится на **Running**, а состояние — на **Alive**. Чтобы проверить состояние, наведите курсор на статус кластера в столбце **{{ ui-key.yacloud.common.availability }}**.


## Подключитесь к БД {#connect}

{% note warning %}

Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

{% endnote %}

Чтобы подключиться к БД:

{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

    1. Получите SSL-сертификат:

        ```bash
        mkdir -p ~/.postgresql && \
        wget "{{ crt-web-path }}" \
                --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
        ```

        Сертификат будет сохранен в файле `~/.postgresql/root.crt`.

    1. Установите необходимые зависимости и клиент {{ PG }}:

        ```bash
        sudo apt update && sudo apt install -y postgresql-client
        ```

    1. Подключитесь к БД:

        {% include [default-connstring](../_includes/mdb/mpg/default-connstring.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](operations/cluster-list.md#list-clusters).

- Windows (PowerShell) {#windows}

    1. Установите [{{ PG }} для Windows](https://www.postgresql.org/download/windows/) той же версии, которая используется в кластере. Выберите только установку _Command Line Tools_.

    1. Получите SSL-сертификат:

        ```powershell
        mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt {{ crt-web-path }}
        ```

        Сертификат будет сохранен в файле `$HOME\.postgresql\root.crt`.

    1. Установите переменные окружения для подключения:

        ```powershell
        $Env:PGSSLMODE="verify-full"; $Env:PGTARGETSESSIONATTRS="read-write"
        ```

    1. Подключитесь к БД:

        ```powershell
        & "C:\Program Files\PostgreSQL\<мажорная_версия_{{ PG }}>\bin\psql.exe" `
            --host=c-<идентификатор_кластера>.rw.{{ dns-zone }} `
            --port={{ port-mpg }} `
            --username=<имя_пользователя> `
            <имя_БД>
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](operations/cluster-list.md#list-clusters).

{% endlist %}

## Отправьте запросы к БД {#query-db}

{% include [query-db](../_includes/mdb/pg-spqr-query-db.md) %}


## Что дальше {#whats-next}

* [Перенесите данные](../data-transfer/tutorials/managed-postgresql.md#quick-transfer) в БД кластера.
* Изучите [концепции сервиса](concepts/index.md).
* Узнайте больше о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect.md).
* Ознакомьтесь с [практическими руководствами](tutorials/index.md) по работе с сервисом.
* Ознакомьтесь с [вопросами и ответами](qa/general.md).
