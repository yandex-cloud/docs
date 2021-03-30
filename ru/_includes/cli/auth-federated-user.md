Чтобы аутентифицироваться с помощью [SAML-совместимой федерации удостоверений](../../iam/concepts/users/identity-federations.md):
1. Узнайте идентификатор федерации у вашего администратора.
1. Запустите интерактивное создание профиля:

    ```
    yc init --federation-id=<ID федерации>
    ```
1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.
    ```
    Welcome! This command will take you through the configuration process.
    Pick desired action:
    [1] Re-initialize this profile 'default' with new settings
    [2] Create a new profile
    ```
1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.

    ```
    You are going to be authenticated via federation-id 'aje1f0hsgds3aas2f6ai2'.
    Your federation authentication web site will be opened.
    After your successful authentication, you will be redirected to 'https://console.cloud.yandex.ru'.

    Press 'enter' to continue...
    ```

    {% include [include](success-auth-via-federation.md) %}
1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
1. Выберите каталог по умолчанию:
    
    {% include [include](choose-folder.md) %}

1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

    {% include [include](choose-zone.md) %}

1. Проверьте настройки вашего профиля CLI:
   ```
   $ yc config list
   federation-id: aje1f0hs6ojais2f6ai2
   ...
   ```