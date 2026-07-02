---
title: Начало работы с {{ maf-full-name }}
description: Чтобы начать работать с {{ maf-full-name }}, создайте кластер сервиса и откройте веб-интерфейс {{ AF }}.
keywords:
  - keyword: airflow
  - keyword: кластер airflow
  - keyword: кластер {{ AF }}
  - keyword: кластер Apache Airflow
  - keyword: '{{ AF }}'
  - keyword: Apache Airflow
  - keyword: создание кластера {{ AF }}
  - keyword: создание кластера airflow
  - keyword: работа с {{ AF }}
  - keyword: начало работы с {{ AF }}
  - keyword: начало работы с {{ maf-name }}
  - keyword: веб-интерфейс {{ AF }}
  - keyword: открыть веб-интерфейс {{ AF }}
  - keyword: открыть веб-интерфейс airflow
---

# Как начать работать с {{ maf-name }}

Чтобы начать работу с сервисом {{ maf-name }}:

1. [Создайте кластер](#cluster-create).
1. [Откройте веб-интерфейс {{ AF }}](#web-gui).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

   {% include [sg-ui-access](../_includes/mdb/maf/note-sg-ui-access.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:

    * {% include [roles-maf-editor](../_includes/mdb/maf/roles-maf-editor.md) %}
    * {% include [roles-vpc-user](../_includes/mdb/roles-vpc-user.md) %}
    * {% include [roles-sa-user](../_includes/mdb/roles-sa-user.md) %}
    * {% include [roles-mdb-viewer](../_includes/mdb/roles-mdb-viewer-create-cluster.md) %}

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. [Создайте бакет {{ objstorage-full-name }}](../storage/operations/buckets/create.md) для хранения [DAG-файлов](concepts/index.md#about-the-service) {{ maf-name }}.
1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роль](../iam/operations/sa/assign-role-for-sa.md) `{{ roles.maf.integrationProvider }}` на каталог или бакет.
1. [Предоставьте разрешение](../storage/operations/buckets/edit-acl.md) `READ` сервисному аккаунту на бакет.

## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать [кластер](../glossary/cluster.md) {{ maf-name }}.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
1. Задайте параметры кластера и нажмите кнопку **{{ ui-key.yacloud.common.create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время. Чтобы проверить состояние, наведите курсор на статус кластера в столбце **{{ ui-key.yacloud.common.availability }}**.

## Откройте веб-интерфейс {{ AF }} {#web-gui}

Для управления {{ AF }} можно использовать веб-интерфейс. Работать с ним могут только пользователи с ролью не ниже [{{ roles.maf.user }}](security/index.md#managed-airflow-user). Чтобы начать работу в веб-интерфейсе {{ AF }}:

{% include [web interface](../_includes/mdb/maf/web-interface.md) %}

Помимо веб-интерфейса можно также использовать [API {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html). Подробнее о нем читайте в разделе [{#T}](operations/af-interfaces.md).

## Что дальше {#whats-next}

* Изучите [концепции сервиса {{ maf-name }}](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) {{ maf-name }} и [работе с интерфейсами](operations/af-interfaces.md) {{ AF }}.
* Создайте DAG-файлы и [загрузите их](operations/upload-dags.md) в кластер {{ maf-name }}. Пример DAG-файла в [документации {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html).
