---
title: Как начать работать с {{ mkf-full-name }}
description: Следуя данной инструкции, вы сможете создать и настроить кластер {{ KF }}.
---

# Как начать работать с {{ mkf-name }}

Чтобы начать работу с сервисом:
1. [Создайте кластер](#cluster-create).
1. [Создайте топик](#topic-create).
1. [Создайте пользователя](#account-create).
1. [Подключитесь к кластеру](#connect).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Убедитесь](../iam/operations/roles/get-assigned-roles.md), что для создания кластера у вашего аккаунта есть роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mkf.editor }} или выше](security/index.md#roles-list).
1. Подключаться к кластеру {{ KF }} можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же сети, что и кластер.

   * Чтобы подключиться к кластеру из интернета, включите публичный доступ к кластеру при его [создании](operations/cluster-create.md).

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).

   {% note info %}

   Предполагается, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. Установите утилиту `kafkacat` — приложение с открытым исходным кодом, которое может работать как универсальный производитель или потребитель данных:

   ```bash
   sudo apt-get install kafkacat
   ```


## Создайте кластер {#cluster-create}

Чтобы создать кластер:
1. В консоли управления выберите каталог, в котором нужно создать кластер.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте параметры кластера и нажмите кнопку **{{ ui-key.yacloud.common.create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mkf-name }} сменится на `Running`, а состояние — на `Alive`. Это может занять некоторое время.

Затем создайте топик в кластере.

## Создайте топик {#topic-create}

[Топик](concepts/topics.md) — это способ группировки потоков сообщений по категориям. [Производители](concepts/producers-consumers.md) пишут сообщения в топик, а [потребители](concepts/producers-consumers.md) читают сообщения из него.

Чтобы создать топик:
1. В консоли управления выберите каталог, в котором находится кластер.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Нажмите на имя созданного ранее кластера, затем выберите вкладку **{{ ui-key.yacloud.kafka.label_topics }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.kafka.button_create-topic }}**.
1. Задайте настройки топика и нажмите кнопку **{{ ui-key.yacloud.common.create }}**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-topics.md).

Затем создайте пользователей для производителей и потребителей.

## Создайте пользователя {#account-create}

Настройки пользователей разграничивают права доступа [производителей и потребителей](./concepts/producers-consumers.md) к топикам в кластере.

Чтобы создать пользователя:
1. В консоли управления выберите каталог, в котором находится кластер.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Нажмите на имя созданного ранее кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_users }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
1. Введите имя пользователя и пароль (от 8 до 128 символов).
1. Нажмите кнопку **![image](../_assets/console-icons/plus.svg) {{ ui-key.yacloud.kafka.button_add-topic }}** и выберите созданный ранее топик из выпадающего списка.
1. Добавьте права на доступ к этому топику для производителя и потребителя. Процесс подробно рассмотрен в разделе [Управление пользователями](operations/cluster-accounts.md).
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

Затем подключитесь к кластеру, используя это имя пользователя.

## Подключитесь к кластеру {#connect}

Вы можете подключить производителя и потребителя к кластеру от имени одного пользователя. И производитель и потребитель смогут работать только с теми топиками, доступ к которым разрешен для данного пользователя.

Чтобы подключиться к кластеру:


1. Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.


1. Установите на ВМ SSL-сертификат:

   {% include [install-certificate](../_includes/mdb/mkf/install-certificate.md) %}

1. Чтобы отправить сообщение в топик, выполните команду:

   {% include [default-get-string](../_includes/mdb/mkf/default-send-string.md) %}

   В команде укажите FQDN брокера, имя топика, логин и пароль пользователя {{ KF }}, созданного ранее.

   {% include [fqdn](../_includes/mdb/mkf/fqdn-host.md) %}

1. Чтобы получить сообщения из топика, выполните команду:

   {% include [default-get-string](../_includes/mdb/mkf/default-get-string.md) %}

   В команде укажите FQDN брокера, имя топика, логин и пароль пользователя {{ KF }}, созданного ранее.

   {% include [fqdn](../_includes/mdb/mkf/fqdn-host.md) %}

Подробно процесс подключения к кластеру {{ mkf-name }} рассмотрен в разделе [Подключение к топикам в кластере](operations/connect/clients.md).

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect/index.md).
