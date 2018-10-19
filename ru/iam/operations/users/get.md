# Получить идентификатор или почту пользователя

Вы можете получить следующую информацию о любом зарегистрированном пользователе Яндекс.Облака:
* идентификатор;
* логин;
* почта.

---

**[!TAB CLI]**

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

**[!TAB API]**

Чтобы получить идентификатор пользователя, воспользуйтесь методом [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) для ресурса [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md).

---

## Примеры

