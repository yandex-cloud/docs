# Пошаговые инструкции для Identity and Access Management

## Секреты в открытом доступе {#credentials}

- [Обработка секретов, попавших в открытый доступ](compromised-credentials.md)

## Пользователи {#users}

Инструкции по управлению пользователями см. в [документации Yandex Identity Hub](../../organization/operations/manage-users.md).

## Группы пользователей {#users-groups}

Инструкции по управлению группами пользователей см. в [документации Yandex Identity Hub](../../organization/operations/manage-groups.md).

## Сервисные аккаунты {#sa}

- [Создание сервисного аккаунта](sa/create.md)
- [Получение списка сервисных аккаунтов каталога](sa/list-get.md)
- [Изменение сервисного аккаунта](sa/update.md)
- [Назначение роли сервисному аккаунту](sa/assign-role-for-sa.md)
- [Настройка прав доступа к сервисному аккаунту](sa/set-access-bindings.md)
- [Использование имперсонации](sa/impersonate-sa.md)
- [Получение информации о сервисном аккаунте](sa/get-id.md)
- [Удаление сервисного аккаунта](sa/delete.md)
- [Получение ID-токена сервисного аккаунта](sa/get-id-token.md)

## Федерации удостоверений {#federations}

Инструкции по управлению федерациями удостоверений теперь в [документации](../../organization/index.md) сервиса Yandex Identity Hub.

## Политики авторизации {#access-policies}

- [Получение списка поддерживаемых шаблонов политик авторизации](access-policies/list.md)
- [Создание политики авторизации для ресурса](access-policies/assign.md)
- [Просмотр политик авторизации, созданных для ресурса](access-policies/view-assigned.md)
- [Удаление политики авторизации](access-policies/revoke.md)

## Роли {#roles}

- [Назначение роли](roles/grant.md)
- [Просмотр назначенных ролей](roles/get-assigned-roles.md)
- [Отзыв роли на ресурс](roles/revoke.md)

## Аутентификация {#authentication}

- [Получение IAM-токена для аккаунта на Яндексе](iam-token/create.md)
- [Получение IAM-токена для сервисного аккаунта](iam-token/create-for-sa.md)
- [Получение IAM-токена для федеративного аккаунта](iam-token/create-for-federation.md)
- [Получение IAM-токена для аккаунта локального пользователя](iam-token/create-for-local.md)
- [Перевыпуск IAM-токена](compromised-credentials.md#iam-reissue)
- [Получение списка refresh-токенов](refresh-token/list.md)
- [Отзыв refresh-токена](refresh-token/revoke.md)
- [Управление статическими ключами доступа](authentication/manage-access-keys.md)
- [Управление API-ключами](authentication/manage-api-keys.md)
- [Управление авторизованными ключами](authentication/manage-authorized-keys.md)
- [Создать временный ключ доступа с помощью Security Token Service](sa/create-sts-key.md)

## Доступ сервисов {#service-control}

{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

- [Получение статусов сервисов](service-control/list-get.md)
- [Включение и выключение сервиса](service-control/enable-disable.md)

## Федерации сервисных аккаунтов {#wlif}

- [Настройка федерации сервисных аккаунтов](wlif/setup-wlif.md)