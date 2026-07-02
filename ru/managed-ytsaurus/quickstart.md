---
title: Начало работы с {{ myt-full-name }}
description: Чтобы начать работать с {{ myt-full-name }}, создайте кластер сервиса и откройте веб-интерфейс {{ ytsaurus-name }}.
---

# Как начать работать с {{ myt-full-name }}

Чтобы начать работу с сервисом {{ myt-name }}:

1. [Создайте demo-кластер](#cluster-create).
1. [Откройте веб-интерфейс {{ ytsaurus-name }}](#web-gui).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:

    * {% include [roles-ytsaurus-editor](../_includes/managed-ytsaurus/roles-ytsaurus-editor.md) %}
    * {% include [roles-vpc-user](../_includes/mdb/roles-vpc-user.md) %}
    * {% include [roles-mdb-viewer](../_includes/mdb/roles-mdb-viewer-create-cluster.md) %}

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

## Создайте demo-кластер {#cluster-create}

{% note info %}

Создание кластера {{ ytsaurus-name }} занимает длительное время.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include notitle [demo-cluster-create](../_includes/managed-ytsaurus/demo-cluster-create.md) %}

{% endlist %}

## Откройте веб-интерфейс {{ ytsaurus-name }} {#web-gui}

Для управления {{ ytsaurus-name }} можно использовать веб-интерфейс. Работать с ним могут только пользователи с ролью не ниже [managed-ytsaurus.user](security/index.md#managed-ytsaurus-user). Чтобы начать работу в веб-интерфейсе {{ ytsaurus-name }}:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен кластер.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
1. Перейдите на страницу [веб-интерфейса {{ ytsaurus-name }}](concepts/authentication.md#users).

## Что дальше {#whats-next}

* Узнайте подробнее о [создании кластера](operations/cluster-create.md) {{ ytsaurus-name }}.