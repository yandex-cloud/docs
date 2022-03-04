# Получение идентификатора или почты пользователя

Вы можете получить следующую информацию о любом зарегистрированном пользователе {{ yandex-cloud }}:
* идентификатор;
* логин;
* почта (только через CLI и API).

{% list tabs %}

- Консоль управления

    1. Войдите в [консоль управления]({{ link-console-main }}).
    1. [Выберите облако](../../../resource-manager/operations/cloud/switch-cloud.md).
    1. Перейдите в раздел [Права доступа в облаке](https://console.cloud.yandex.ru/cloud?section=resource-acl)  (кнопка **Права доступа** на панели слева).

- CLI

    1. Посмотрите описание команды получения информации о пользователе:

        ```
        $ yc iam user-account get --help
        ```

    2. Получите информацию о пользователе, указав его логин:

        ```
        $ yc iam user-account get just.mad.hatter
        id: ajei8n5ahmfhuk5fog0g
        yandex_passport_user_account:
            login: just.mad.hatter
            default_email: just.mad.hatter@yandex.ru
        ```

- API

    Получите информацию о пользователе (ресурс [UserAccount](../../api-ref/UserAccount/index.md)):
    * Если вы знаете логин пользователя, используйте метод [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) для ресурса [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md).
    * Если вы знаете идентификатор пользователя, используйте метод [get](../../api-ref/UserAccount/get.md) для ресурса [UserAccount](../../api-ref/UserAccount/index.md).

{% endlist %}
