# Аутентификация от имени федеративного пользователя

Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](../install-cli.md).

Чтобы аутентифицироваться с помощью [SAML-совместимой федерации удостоверений](../../../iam/concepts/users/identity-federations.md):
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

    {% include [include](../../../_includes/cli/success-auth-via-federation.md) %}
1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
1. Выберите каталог по умолчанию:
   ```
   Please choose a folder to use:
    [1] folder1 (id = cvatao4faoe2bmdrg22b)
    [2] folder2 (id = tao4faoe2cvabmdrg22b)
    [3] Create a new folder
   Please enter your numeric choice: 1
   ```
1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:
   ```
   Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
   Which zone do you want to use as a profile default?
    [1] ru-central1-a
    [2] ru-central1-b
    [3] ru-central1-c
    [4] Don't set default zone
   Please enter your numeric choice: 2
   ```
1. Проверьте настройки вашего профиля CLI:
   ```
   $ yc config list
   federation-id: aje1f0hs6ojais2f6ai2
   ...
   ```