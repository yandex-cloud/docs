# Аутентификация от имени пользователя

{% if product == "yandex-cloud" %}

Вы можете аутентифицироваться в процессе [интерактивного создания профиля](../profile/profile-create.md#interactive-create) с помощью команды `yc init` или выполнив следующие шаги:
{% if audience != "internal" %}

1. Получите [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md).

{% else %}

1. Получите OAuth-токен.

{% endif %}

1. [Создайте профиль](../profile/profile-create.md#create).
1. Укажите в параметре `token` ваш OAuth-токен:
    ```
    yc config set token <OAuth-токен>
    ```

OAuth-токен будет сохранен в конфигурации профиля и аутентификация будет происходить автоматически.

{% endif %}

{% if product == "cloud-il" %}

Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](../install-cli.md).

Чтобы аутентифицироваться с помощью аккаунта Google:

1. Запустите интерактивное создание профиля:

   ```
   yc init --endpoint {{ api-host }}:443 --federation-id google
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
   You are going to be authenticated via federation-id 'google'.
   Your federation authentication web site will be opened.
   After your successful authentication, you will be redirected to '{{ link-console-main }}'.

   Press 'enter' to continue...
   ```

   {% include [include](../../../_includes/cli/success-auth-via-federation.md) %}

1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.

1. Выберите одно из предложенных облаков, в которых у вас есть права доступа:

   {% include [include](../../../_includes/cli/choose-cloud.md) %}

   Если вам доступно только одно облако, оно будет выбрано автоматически.

1. Выберите каталог по умолчанию:

   {% include [include](../../../_includes/cli/choose-folder.md) %}

1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

   ```
   Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
   Which zone do you want to use as a profile default?
   [1] {{ region-id }}-a
   [2] Don't set default zone
   Please enter your numeric choice: 1 
   ```

1. Проверьте настройки вашего профиля CLI:
   ```
   yc config list
   endpoint: {{ api-host }}:443
   federation-id: google
   ...
   ```

{% endif %}