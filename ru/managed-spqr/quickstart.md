---
title: Начало работы с {{ mspqr-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ SPQR }} и подключаться к нему.
---

# Как начать работать с {{ mspqr-name }}

{% include [preview](../_includes/note-service-preview.md) %}

Сервис {{ mspqr-name }} позволяет создавать и поддерживать кластеры шардированного {{ PG }} ([SPQR](https://pg-sharding.tech/welcome)) в инфраструктуре {{ yandex-cloud }}.

Чтобы начать работу с сервисом:

1. [Создайте кластер {{ SPQR }}](#cluster-create).
1. [Создайте шард в кластере {{ SPQR }}](#shard-create).
1. [Подключитесь к БД](#connect).
1. [Отправьте запросы к БД](#query-db).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}


1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и `managed-spqr.editor` на каталог. Эти роли позволяют создать кластер.


   {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. Подключаться к [кластерам](../glossary/cluster.md) БД можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же облачной сети, что и кластер БД.

   * Чтобы подключиться к кластеру из интернета, включите публичный доступ к хостам при [создании кластера](#cluster-create).

   {% note info %}

    Следующий шаг предполагает, что подключение к кластеру производится с ВМ. Если вы собираетесь подключаться к кластеру из интернета, переходите к [созданию кластера](#cluster-create).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).

## Создайте кластер {#cluster-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ SPQR }}.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя кластера.
1. Выберите окружение `PRODUCTION`.

1. Выберите тип шардирования:

    * **{{ ui-key.yacloud.spqr.section_sharding-type-standard }}** — кластер будет состоять только из инфраструктурных хостов.
    * **{{ ui-key.yacloud.spqr.section_sharding-type-advanced }}** — кластер будет состоять только из хостов-роутеров и (опционально) хостов-координаторов.

1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}**:

    * Выберите [созданную перед началом работы](#before-you-begin) облачную сеть.
    * Выберите группу безопасности по умолчанию или создайте новую.

1. Задайте конфигурацию вычислительных ресурсов:

    * Для стандартного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_infra }}** конфигурацию инфраструктурных хостов.
    * Для расширенного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_router }}** конфигурацию хостов-роутеров.

    Чтобы задать конфигурацию вычислительных ресурсов:

      1. Выберите [класс хостов](concepts/instance-types.md). Он определяет технические характеристики [виртуальных машин](../compute/concepts/vm.md), на которых будут развернуты [хосты](concepts/index.md) кластера.
      1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

          1. Выберите [тип диска](concepts/storage.md#storage-type-selection).
          1. Задайте размер [хранилища](concepts/storage.md).

      1. В блоке **{{ ui-key.yacloud.spqr.section_hosts }}** укажите зоны доступности и подсети для хостов, которые будут созданы вместе с кластером.

         Если вы собираетесь подключаться к кластеру из интернета, включите для хостов опцию **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}**.

1. (Опционально) В блоке **{{ ui-key.yacloud.spqr.section_coordinator }}** включите опцию **{{ ui-key.yacloud.spqr.field_coordinator }}** и задайте конфигурацию хостов-координаторов.

1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите:

    * Имя БД. Оно должно быть уникальным в рамках каталога.
    * Имя пользователя — владельца БД.
    * Пароль.

1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** укажите пароль для консоли {{ SPQR }}.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Дождитесь, когда кластер будет готов к работе: его статус сменится на **Running**, а состояние — на **Alive**. Чтобы проверить состояние, наведите курсор на статус кластера в столбце **{{ ui-key.yacloud.common.availability }}**.

## Создайте шард в кластере {#shard-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором [создан](#cluster-create) кластер {{ SPQR }}.
1. [Cоздайте кластер](../managed-postgresql/operations/cluster-create.md#create-cluster) {{ mpg-name }} в той же облачной сети, что и кластер {{ SPQR }}.
1. Откройте ваш кластер {{ SPQR }} и перейдите на вкладку ![image](../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**.
1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
1. В открывшемся окне:

   1. Задайте **{{ ui-key.yacloud.common.name }}** шарда.
   1. В поле **Кластер Managed Service for PostgreSQL** выберите созданный ранее кластер {{ PG }}.

      Кластер {{ mpg-name }} должен находиться в том же каталоге и в той же облачной сети, что и кластер {{ mspqr-name }}.

## Подключитесь к БД {#connect}


{% note warning %}

Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

{% endnote %}


Чтобы подключиться к БД кластера {{ SPQR }}:

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

        ```bash
        psql "host=<FQDN_хоста> \
              port={{ port-mpg }} \
              sslmode=verify-full \
              dbname=<имя_БД> \
              user=<имя_пользователя> \
              target_session_attrs=read-write"
        ```

        [Подробнее о получении FQDN хоста](operations/connect.md#fqdn).

- Windows (PowerShell) {#windows}

    1. Установите [{{ PG }} для Windows](https://www.postgresql.org/download/windows/) последней версии. Выберите только установку _Command Line Tools_.

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
            --host=<FQDN_хоста>.{{ dns-zone }} `
            --port={{ port-mpg }} `
            --username=<имя_пользователя> `
            <имя_БД>
        ```

        [Подробнее о получении FQDN хоста](operations/connect.md#fqdn).

{% endlist %}

## Отправьте запросы к БД {#query-db}

{% include [query-db](../_includes/mdb/pg-spqr-query-db.md) %}

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect.md).
