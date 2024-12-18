---
title: Публичные группы
description: Из статьи вы узнаете, что такое публичные группы и каких они бывают типов.
---

# Публичные группы


_Публичная группа_ — группа пользователей (субъектов), на которую можно назначать [роли](./roles.md). В {{ yandex-cloud }} существует два типа публичных групп: `All authenticated users` и `All users`. Эти группы позволяют предоставить публичный доступ к вашим ресурсам, но только на те операции, которые позволяет выполнять назначенная роль.

Небезопасно назначать публичным группам роли с широким набором разрешений, такие как `editor` или `admin`.

### All authenticated users {#allAuthenticatedUsers}

Публичная группа `All authenticated users` — все пользователи, прошедшие [аутентификацию](../authorization/index.md). Это все зарегистрированные пользователи или сервисные аккаунты {{ yandex-cloud }}: как из ваших облаков, так и из облаков других пользователей. Использовать эту группу небезопасно: вместо нее рекомендуется использовать [системные группы](./system-group.md) `All users in organization X` и `All users in federation N` или самостоятельно созданные группы.

> Например, у вас есть образ диска с операционной системой и вы хотите поделиться им со всеми пользователями {{ yandex-cloud }}. Для этого назначьте субъекту `All authenticated users` роль `compute.images.user` на каталог с образом.

При назначении роли публичной группе `All authenticated users` с помощью [CLI](../../../cli/quickstart.md), [{{ TF }}]({{ tf-provider-link }}) и [API](../../../api-design-guide/concepts/general.md) используйте идентификатор [субъекта](./index.md#subject) `allAuthenticatedUsers`.

{% note alert %}

Назначение роли системной группе `All authenticated users` открывает публичный доступ к вашим ресурсам. Данная роль дает права на ваши ресурсы **всем** пользователям, прошедшим аутентификацию в {{ yandex-cloud }}, а **не только пользователям из вашего облака**.

{% endnote %}

### All users {#allUsers}

Публичная группа `All users` — это любой пользователь, прохождение аутентификации от пользователя не требуется. 

> Например, при запросе через [API](../../../glossary/rest-api.md) к вашему ресурсу пользователю не надо будет указывать IAM-токен. Использовать эту группу небезопасно: вместо нее рекомендуется использовать системные группы `All users in organization X` и `All users in federation N` или самостоятельно созданные [группы](../../../organization/concepts/groups.md) пользователей организации.

При назначении роли публичной группе `All users` с помощью [CLI](../../../cli/quickstart.md), [{{ TF }}]({{ tf-provider-link }}) и [API](../../../api-design-guide/concepts/general.md) используйте идентификатор [субъекта](./index.md#subject) `allUsers`.

{% note info %}

Сейчас группа `All users` поддерживается только в сервисе {{ objstorage-name }} при [управлении доступом с помощью ACL](../../../storage/concepts/acl.md), а также в сервисах {{ container-registry-name }} и {{ sf-name }}.

В остальных сервисах назначение роли для группы `All users` эквивалентно назначению роли для `All authenticated users`.

{% endnote %}
