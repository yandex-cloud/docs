# Аутентификация от имени пользователя


Для работы с {{ yandex-cloud }} необходим [аккаунт на Яндексе](../../../iam/concepts/index.md#passport).

Вы можете аутентифицироваться в процессе [интерактивного создания профиля](../profile/profile-create.md#interactive-create) с помощью команды `yc init` или выполнив следующие шаги:

1. Получите [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md).


1. [Создайте профиль](../profile/profile-create.md#create).
1. Укажите в параметре `token` ваш OAuth-токен:
    ```
    yc config set token <OAuth-токен>
    ```

OAuth-токен будет сохранен в конфигурации профиля и аутентификация будет происходить автоматически.


