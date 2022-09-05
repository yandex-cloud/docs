Чтобы аутентифицироваться с помощью [SAML-совместимой федерации удостоверений](../../organization/add-federation.md):
1. Узнайте идентификатор федерации у вашего администратора.
1. Запустите интерактивное создание профиля:

      
    ```bash
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
    After your successful authentication, you will be redirected to '{{ link-console-main }}'.

    Press 'enter' to continue...
    ```

    {% include [include](success-auth-via-federation.md) %}

1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.

1. Выберите одно из предложенных облаков, в которых у вас есть права доступа:

    {% include [include](choose-cloud.md) %}

   Если вам доступно только одно облако, оно будет выбрано автоматически.

1. Выберите каталог по умолчанию:

    {% include [include](choose-folder.md) %}

1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

    {% include [include](choose-zone.md) %}

1. Проверьте настройки вашего профиля CLI:
   
      
   ```bash
   yc config list
   ```

   Результат:

   ```bash
   federation-id: aje1f0hs6ojais2f6ai2
   ...
   ```
   

   
