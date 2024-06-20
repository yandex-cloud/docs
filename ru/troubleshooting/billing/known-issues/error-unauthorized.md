# Устранение ошибки `message: Unauthorized; description: Unauthorized`


## Описание проблемы {#issue-description}

При регистрации платежного аккаунта появляется ошибка:

```
url: {{ link-console-billing }}; 
message: Unauthorized; 
description: Unauthorized;
```

## Решение {#issue-resolution}

Для создания платежного аккаунта нужно быть владельцем организации, то есть иметь роль `{{ roles-organization-owner }}`.

{% list tabs %}

- Если у вас нет такой роли

    Вы можете попросить владельца организации выдать вам роль `{{ roles-organization-owner }}` по [инструкции](../../../iam/operations/roles/grant.md) или [создать новую организацию](../../../organization/operations/enable-org.md), [перейти в нее](../../../organization/operations/manage-organizations.md#switch-to-another-org) и [создать платежный аккаунт](../../../billing/operations/create-new-account.md) уже там.

- Если у вас есть роль

    Обновите страницу.

{% endlist %}

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса приложите [HAR-файл](../../../support/create-har.md) — он поможет нам разобраться в возникшей проблеме.
