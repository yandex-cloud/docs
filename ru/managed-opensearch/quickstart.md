---
title: Начало работы с {{ mos-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ OS }} и подключаться к нему.
---

# Как начать работать с {{ mos-name }}

Чтобы начать работу с сервисом:
1. [Создайте кластер](#create-cluster).
1. [Настройте группы безопасности](#configure-security-groups).
1. [Подключитесь к кластеру](#connect).
1. [Подключитесь к {{ OS }} Dashboards](#dashboards-connect).


## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

1. [Убедитесь](../iam/operations/roles/get-assigned-roles.md), что для создания кластера у вашего аккаунта есть роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.mos.editor }} или выше](security/index.md#roles-list).

    Для привязки сервисного аккаунта к кластеру (например, для [работы с {{ objstorage-full-name }}](operations/s3-access.md)) вашему аккаунту дополнительно нужна роль [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) или выше.

1. Подключаться к [кластеру](../glossary/cluster.md) {{ OS }} можно как изнутри {{ yandex-cloud }}, так и из интернета:

    * Чтобы подключиться изнутри {{ yandex-cloud }}, [создайте виртуальную машину](../compute/quickstart/quick-create-linux.md) на основе Linux в той же сети, что и кластер.

    * Чтобы подключиться к кластеру из интернета, [запросите публичный доступ](operations/cluster-create.md) к хостам с [ролью](concepts/host-roles.md#data) `DATA` при создании кластера.

{% note info %}

Эта инструкция предполагает, что подключение к кластеру производится из интернета.

{% endnote %}


## Создайте кластер {#create-cluster}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Задайте параметры кластера.


    Чтобы получить доступ к веб-интерфейсу {{ OS }} Dashboards, запросите публичный доступ — для этого в блоке **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }}** с типом группы **Dashboards** выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

    {% include [mos-tip-public-dashboards](../_includes/mdb/mos/public-dashboards.md) %}


1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mos-name }} сменится на **Creating** и далее — на **Alive**. Это может занять некоторое время.


## Настройте группы безопасности {#configure-security-groups}

{% include notitle [Configuring security groups](../_includes/mdb/mos/configuring-security-groups.md) %}


## Подключитесь к кластеру {#connect}

Предполагается, что все перечисленные ниже шаги выполняются на Linux.

Чтобы подключиться к кластеру:

1. Установите SSL-сертификат:

   {% include [install-certificate](../_includes/mdb/mos/install-certificate.md) %}

1. Подключитесь к кластеру с помощью утилиты [cURL](https://curl.haxx.se/):

   {% include [default-connstring](../_includes/mdb/mos/default-connstring.md) %}

   Для подключения нужно использовать имя пользователя `admin` и пароль, который был задан при [создании кластера](#create-cluster).

   При успешном подключении будет выведено похожее сообщение:

   ```bash
   {
     "name" : "....{{ dns-zone }}",
     "cluster_name" : "...",
     "cluster_uuid" : "...",
     "version" : {
     "distribution" : "opensearch",
     ...
     },
     "tagline" : "The OpenSearch Project: https://opensearch.org/"
   }
   ```

## Подключитесь к {{ OS }} Dashboards {#dashboards-connect}

1. Подключитесь с помощью браузера к веб-интерфейсу [{{ OS }} Dashboards]({{ os.docs }}/dashboards/index/):


   1. Убедитесь, что к хостам с ролью `DASHBOARDS` есть публичный доступ.


   1. Установите [SSL-сертификат]({{ crt-web-path }}) в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).
   1. На странице кластера в консоли управления нажмите кнопку **{{ ui-key.yacloud.opensearch.title_opensearch-dashboards-section }}** или перейдите в браузере по адресу `https://c-<идентификатор_кластера_{{ OS }}>.rw.{{ dns-zone }}>`.
   1. Введите имя пользователя `admin` и пароль, который был задан при [создании кластера](#create-cluster).

1. Исследуйте набор тестовых данных:

   1. На приветственном экране {{ OS }} Dashboards нажмите кнопку **Add sample data**.
   1. Нажмите кнопку **View data** для интересующего набора данных.

Подробнее о работе с {{ OS }} Dashboards см. в [документации {{ OS }}]({{ os.docs }}/dashboards/index/).

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect.md).
