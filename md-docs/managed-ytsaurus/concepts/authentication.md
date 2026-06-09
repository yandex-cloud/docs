# Аутентификация в YTsaurus

Доступ к ресурсам сервиса Managed Service for YTsaurus возможен:
* [через веб-интерфейс YTsaurus](#users) — для пользователей;
* [с помощью IAM-токена или API-ключа](#service-accounts) — для сервисных аккаунтов.

Доступ к ресурсам Managed Service for YTsaurus контролируется сервисом Yandex Identity and Access Management, подробнее в разделе [Управление доступом](../security/index.md).

## Аутентификация пользователей в YTsaurus {#users}

Для доступа в веб-интерфейс YTsaurus пользователь должен иметь роль не ниже [managed-ytsaurus.user](../security/index.md#managed-ytsaurus-user) на каталог с кластером Managed Service for YTsaurus.

При первой успешной аутентификации автоматически создается новый пользователь YTsaurus с именем, совпадающим с идентификатором пользователя в Yandex Cloud. Изменить имя пользователя YTsaurus нельзя. Создать нового пользователя YTsaurus средствами самого сервиса невозможно.

### Группы пользователей YTsaurus {#user-groups}

В YTsaurus есть две группы пользователей: `users` и `managers`. 

В группу `users` автоматически добавляются все пользователи после первой авторизации в веб-интерфейсе YTsaurus.

В группу `managers` автоматически добавляются пользователи из группы `users`, имеющие роль не ниже `managed-ytsaurus.editor`. Обновление списка пользователей в группе может занимать до 15 минут.

Редактировать группы пользователей YTsaurus средствами самого сервиса невозможно.

## Аутентификация сервисных аккаунтов в Managed Service for YTsaurus {#service-accounts}

Для доступа к YTsaurus сервисный аккаунт должен иметь роль не ниже [managed-ytsaurus.user](../security/index.md#managed-ytsaurus-user) на каталог с кластером Managed Service for YTsaurus. 

[Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) могут использовать для доступа к YTsaurus:
* [IAM-токен](../../iam/concepts/authorization/iam-token.md) — подходит для выполнения краткосрочных операций; время жизни IAM-токена составляет 12 часов.
* [API-ключ](../../iam/concepts/authorization/api-key.md) — подходит для выполнения длительных операций, если автоматически запрашивать новый IAM-токен невозможно.

При первой успешной аутентификации сервисного аккаунта автоматически создается новый пользователь YTsaurus с именем, совпадающим с идентификатором сервисного аккаунта. Изменить имя пользователя YTsaurus невозможно.

### Особенности использования API-ключей в Managed Service for YTsaurus {#api-key}

API-ключ нужно [передавать вместо IAM-токена](../../iam/concepts/authorization/iam-token.md#use).

При [создании API-ключа](../../iam/operations/authentication/manage-api-keys.md#create-api-key) укажите [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.managed-ytsaurus.cluster.use`.

Пример команды создания API-ключа для доступа к YTsaurus:

```bash
yc iam api-key create \
   --service-account-name <имя_сервисного_аккаунта> \
   --scopes yc.managed-ytsaurus.cluster.use \
   --expires-at <дата_и_время> \
   > api_key.yaml
```