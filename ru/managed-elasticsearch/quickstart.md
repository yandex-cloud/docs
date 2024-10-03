---
title: Как начать работать с {{ mes-name }}
description: Следуя данной инструкции, вы сможете начать работать с {{ mes-name }}.
---

# Как начать работать с {{ mes-name }}

{% include [Elasticsearch-end-of-service](../_includes/mdb/mes/note-end-of-service.md) %}

Чтобы начать работу с сервисом:

1. [{#T}](#cluster-create).


1. [{#T}](#configuring-security-groups).


1. [{#T}](#connect).

1. [{#T}](#connect-kibana).


## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. Подключаться к [кластеру](../glossary/cluster.md) {{ ES }} можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же сети, что и кластер.

   * Чтобы подключиться к кластеру из интернета, [запросите публичный доступ](operations/cluster-create.md#change-data-node-settings) к хостам с [ролью _Data node_](concepts/hosts-roles.md#data-node) при создании кластера.

{% note info %}

Эта инструкция предполагает, что подключение к кластеру производится из интернета.

{% endnote %}


## Создайте кластер {#cluster-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Задайте параметры кластера.

   Чтобы получить доступ к веб-интерфейсу Kibana, запросите публичный доступ:
   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** измените настройки хоста с ролью _Data node_, нажав значок ![image](../_assets/console-icons/pencil.svg) для хоста.
   1. Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

   Публичный доступ можно запросить для одного или нескольких хостов с ролью _Data node_. После создания кластера станет доступно [подключение к Kibana](#connect-kibana), расположенной на этих хостах.  Может потребоваться дополнительная [настройка групп безопасности](operations/cluster-connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру. 

   {% include [mes-tip-public-kibana](../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mes-name }} сменится на **Creating** и далее — на **Alive**. Это может занять некоторое время.


## Настройте группы безопасности {#configuring-security-groups}

[Настройте группы безопасности](operations/cluster-connect.md#configuring-security-groups) для облачной сети так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.


## Подключитесь к кластеру {#connect}

Предполагается, что все перечисленные ниже шаги выполняются на Linux.

Чтобы подключиться к кластеру:

1. Установите SSL-сертификат:

   {% include [install-certificate](../_includes/mdb/mes/install-certificate.md) %}

1. Подключитесь к кластеру с помощью утилиты [cURL](https://curl.haxx.se/):

   {% include [default-connstring](../_includes/mdb/mes/default-connstring.md) %}

   Для подключения нужно использовать имя пользователя и пароль, которые были заданы при [создании кластера](#cluster-create).

   При успешном подключении будет выведено похожее сообщение:

   ```bash
   {
     "name" : "....{{ dns-zone }}",
     "cluster_name" : "...",
     "cluster_uuid" : "...",
     ...
     "tagline" : "You Know, for Search"
   }
   ```

## Подключитесь к Kibana {#connect-kibana}

1. Подключитесь с помощью браузера к веб-интерфейсу [Kibana](https://www.elastic.co/kibana/features).

   Для подключения:
   1. Установите [SSL-сертификат]({{ crt-web-path }}) в хранилище доверенных корневых сертификатов браузера ([инструкция](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) для Mozilla Firefox).
   1. Перейдите в браузере по адресу `https://<FQDN_публично_доступного_хоста_{{ ES }}_с_ролью_Data_node>`.

      {% include [see-fqdn](../_includes/mdb/mes/fqdn-host.md) %}

   1. Введите имя пользователя и пароль, которые были заданы при [создании кластера](#cluster-create).
1. Загрузите в {{ ES }} один или несколько наборов тестовых данных с помощью Kibana:
   1. На приветственном экране Kibana нажмите кнопку **Try our sample data**.
   1. Добавьте данные из одного или нескольких наборов данных, нажав кнопку **Add data** для нужного набора.
1. Исследуйте данные с помощью Kibana и {{ ES }}, нажав кнопку **View data** для интересующего набора данных.

Подробнее о работе с Kibana см. в [документации {{ ES }}](https://www.elastic.co/guide/en/kibana/current/connect-to-elasticsearch.html).

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/cluster-connect.md).
