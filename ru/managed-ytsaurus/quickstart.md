---
title: Начало работы с {{ myt-full-name }}
description: Чтобы начать работать с {{ myt-full-name }}, создайте кластер сервиса и откройте веб-интерфейс {{ ytsaurus-name }}.
---

# Как начать работать с {{ myt-full-name }}

{% include notitle [preview](../_includes/note-preview.md) %}

Чтобы начать работу с сервисом {{ myt-name }}:

1. [Создайте demo-кластер](#cluster-create).
1. [Откройте веб-интерфейс {{ ytsaurus-name }}](#web-gui).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:

    * [managed-ytsaurus.editor](security/index.md#managed-ytsaurus-editor) — чтобы создать кластер;
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера.

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

1. В [консоли управления]({{ link-console-main }}) откройте страницу кластера.
1. Перейдите на страницу веб-интерфейса {{ ytsaurus-name }}.

## Что дальше {#whats-next}

* Узнайте подробнее о [создании кластера](operations/cluster-create.md) {{ ytsaurus-name }}.