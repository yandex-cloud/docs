---
title: Аутентификация в {{ ytsaurus-name }}
description: Доступ к ресурсам {{ ytsaurus-name }} возможен через веб-интерфейс (для пользователей) или с помощью API-ключа (для сервисных аккаунтов).
---

# Аутентификация в {{ ytsaurus-name }}

Доступ к ресурсам сервиса {{ myt-name }} возможен:
* [через веб-интерфейс {{ ytsaurus-name }}](#users) — для пользователей;
* [с помощью IAM-токена или API-ключа](#service-accounts) — для сервисных аккаунтов.

Доступ к ресурсам {{ myt-name }} контролируется сервисом {{ iam-full-name }}, подробнее см. в разделе [Управление доступом](../security/index.md).

## Аутентификация пользователей в {{ ytsaurus-name }} {#users}

Для доступа в веб-интерфейс {{ ytsaurus-name }} пользователь должен иметь роль не ниже [managed-ytsaurus.user](../security/index.md#managed-ytsaurus-user) на каталог с кластером {{ myt-name }}.

При первой успешной аутентификации автоматически создается новый пользователь {{ ytsaurus-name }} с именем, совпадающим с идентификатором пользователя в {{ yandex-cloud }}. Изменить имя пользователя {{ ytsaurus-name }} нельзя. Создать нового пользователя {{ ytsaurus-name }} средствами самого сервиса невозможно.

### Группы пользователей {{ ytsaurus-name }} {#user-groups}

В {{ ytsaurus-name }} есть две группы пользователей: `users` и `managers`. 

В группу `users` автоматически добавляются все пользователи после первой авторизации в веб-интерфейсе {{ ytsaurus-name }}.

В группу `managers` автоматически добавляются пользователи из группы `users`, имеющие роль не ниже `managed-ytsaurus.editor`. Обновление списка пользователей в группе может занимать до 15 минут.

Редактировать группы пользователей {{ ytsaurus-name }} средствами самого сервиса невозможно.

## Аутентификация сервисных аккаунтов в {{ myt-name }} {#service-accounts}

Для доступа к {{ ytsaurus-name }} сервисный аккаунт должен иметь роль не ниже [managed-ytsaurus.user](../security/index.md#managed-ytsaurus-user) на каталог с кластером {{ myt-name }}. 

[Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) могут использовать для доступа к {{ ytsaurus-name }}:
* [IAM-токен](../../iam/concepts/authorization/iam-token.md) — подходит для выполнения краткосрочных операций; время жизни IAM-токена составляет 12 часов.
* [API-ключ](../../iam/concepts/authorization/api-key.md) — подходит для выполнения длительных операций, если автоматически запрашивать новый IAM-токен невозможно.

При первой успешной аутентификации сервисного аккаунта автоматически создается новый пользователь {{ ytsaurus-name }} с именем, совпадающим с идентификатором сервисного аккаунта. Изменить имя пользователя {{ ytsaurus-name }} невозможно.

### Особенности использования API-ключей в {{ myt-name }} {#api-key}

API-ключ нужно [передавать вместо IAM-токена](../../iam/concepts/authorization/iam-token.md#use).

При [создании API-ключа](../../iam/operations/authentication/manage-api-keys.md#create-api-key) укажите [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.managed-ytsaurus.cluster.use`.

Пример команды создания API-ключа для доступа к {{ ytsaurus-name }}:

```bash
yc iam api-key create \
   --service-account-name <имя_сервисного_аккаунта> \
   --scopes yc.managed-ytsaurus.cluster.use \
   --expires-at <дата_и_время> \
   > api_key.yaml
```
