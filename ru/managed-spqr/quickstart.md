---
title: Начало работы с {{ mspqr-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ SPQR }} и подключаться к нему.
---

# Как начать работать с {{ mspqr-name }}

{% include [preview](../_includes/note-service-preview.md) %}

Чтобы начать работу с сервисом:
* [Создайте кластер {{ SPQR }}](#cluster-create).
* [Создайте шард в кластере {{ SPQR }}](#shard-create).
* [Подключитесь к БД](#connect).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}


1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль `managed-spqr.editor` на каталог. Эти роли позволяют создать кластер.


   {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. Подключаться к [кластерам](../glossary/cluster.md) БД можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же облачной сети, что и кластер БД.

   * Чтобы подключиться к кластеру из интернета, включите публичный доступ к хостам при создании кластера.

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру {{ SPQR }} производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).

1. Установите необходимые зависимости и клиент {{ PG }}:

   ```bash
   sudo apt update && sudo apt install -y postgresql-client
   ```

## Создайте кластер {#cluster-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ SPQR }}.
1. Выберите сервис **{{ mspqr-name }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте параметры кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

   Подробнее о параметрах кластера см. в разделе [Создание кластера](operations/cluster-create.md).

1. Дождитесь, когда кластер будет готов к работе: его доступность на панели {{ mspqr-short-name }} сменится на **Alive**. Это может занять некоторое время.

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

1. Если вы используете группы безопасности для облачной сети, настройте их так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

1. Для подключения к серверу БД получите SSL-сертификат:

    {% include [install-certificate](../_includes/mdb/mpg/install-certificate.md) %}

1. Используйте для подключения команду `psql`:

    {% include [default-connstring](../_includes/mdb/mpg/default-connstring.md) %}

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect.md).
