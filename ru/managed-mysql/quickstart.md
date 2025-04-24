---
title: Начало работы с {{ mmy-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ MY }} и подключаться к нему.
---

# Как начать работать с {{ mmy-name }}®

Чтобы начать работу с сервисом:
* [Создайте кластер базы данных](#cluster-create).
* [Подключитесь к БД](#connect).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mmy.editor }} или выше](security/index.md#roles-list). Эти роли позволяют создать кластер.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. Подключаться к [кластерам](concepts/index.md) БД можно изнутри и извне {{ yandex-cloud }}:
   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте [виртуальную машину](../compute/concepts/vm.md) в той же [облачной сети](../vpc/concepts/network.md#network), что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md)).
   * Чтобы подключиться к кластеру {{ mmy-name }} из интернета, запросите публичный доступ к хостам при создании кластера.

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру {{ mmy-name }} производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).
1. Установите необходимые зависимости и клиент {{ MY }}:

   ```bash
   sudo apt update && sudo apt install -y mysql-client
   ```


## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте параметры кластера {{ mmy-name }} и нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер {{ mmy-name }} будет готов к работе: его статус на панели {{ mmy-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

## Подключитесь к БД {#connect}


1. Если вы используете [группы безопасности](../vpc/concepts/security-groups.md) для облачной сети, [настройте их](operations/connect.md#configuring-security-groups), чтобы был разрешен весь необходимый трафик между кластером {{ mmy-name }} и хостом, с которого выполняется подключение.


1. Для подключения к серверу БД получите SSL-сертификат:

   {% include [install-certificate](../_includes/mdb/mmy/install-certificate.md) %}

1. Используйте для подключения команду `mysql`:

   {% include [default-connstring](../_includes/mdb/mmy/default-connstring.md) %}


## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера {{ mmy-name }}](operations/cluster-create.md) и [подключении к БД](operations/connect.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).