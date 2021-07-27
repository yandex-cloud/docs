---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Добавление пользователя в облако

Чтобы добавлять пользователей в облако, необходима роль [`admin`](../../concepts/access-control/roles.md#admin) или [`resource-manager.clouds.owner`](../../concepts/access-control/roles.md#owner) на это облако.

Добавлять можно [пользователей с аккаунтом на Яндексе](#passport-user) и [федеративных пользователей](#federated-user).

## Добавить пользователя с аккаунтом на Яндексе {#passport-user}

1. {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}
2. На странице **Пользователи и роли** в правом верхнем углу нажмите **Добавить пользователя**.
3. Введите электронную почту пользователя на Яндексе.
4. Нажмите кнопку **Добавить**.

{% note info %}

{% include [yandex-account-2fa-warning.md](../../../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}

## Добавить федеративных пользователей {#federated-user}

{% include [include](../../../_includes/iam/add-federated-users-before-begin.md) %}

{% include [include](../../../_includes/iam/add-federated-users-instruction.md) %}

#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../roles/grant.md).