# Настройка аутентификации {{ TF }}-провайдера {{ yandex-cloud }}

Для аутентификации и управления инфраструктурой {{ yandex-cloud }} вы можете использовать {{ TF }} от имени:
* [сервисного аккаунта](../iam/concepts/users/service-accounts.md) с помощью [IAM-токена](#service-account) или [авторизованного ключа](#service-account-key);
* [пользовательского аккаунта](#users):
    * [аккаунта на Яндексе](../iam/concepts/users/accounts.md#passport);
    * [федеративного аккаунта](../iam/concepts/users/accounts.md#saml-federation);
    * [локального пользователя](../iam/concepts/users/accounts.md#local).


## Аутентификация от имени сервисного аккаунта с помощью IAM-токена {#service-account}

{% include [authentication-intro](../_includes/terraform/authentication-intro.md) %}

{% include [authentication-sa](../_includes/terraform/authentication-sa.md) %}


## Аутентификация от имени сервисного аккаунта с помощью авторизованного ключа {#service-account-key}

Позволяет постоянно аутентифицироваться с помощью однажды созданного авторизованного ключа. Использование долгоживущего ключа менее безопасно, чем использование [имперсонации и IAM-токена](#service-account).

Для аутентификации от имени сервисного аккаунта с помощью авторизованного ключа:
1. Если у вас еще нет сервисного аккаунта, [создайте](../iam/operations/sa/create.md) его.
1. [Назначьте](../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли, необходимые для управления ресурсами {{ yandex-cloud }}.
1. [Создайте](../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) авторизованный ключ для сервисного аккаунта и сохраните его в файл `key.json`.
1. Запишите чувствительные данные: путь к файлу авторизационного ключа, идентификатор облака и каталога — в переменные окружения:

    {% list tabs group=programming_language %}

    - Bash {#bash}

      ```bash
      export YC_SERVICE_ACCOUNT_KEY_FILE="<путь_к_файлу_ключа>"
      export YC_CLOUD_ID="<идентификатор_облака>"
      export YC_FOLDER_ID="<идентификатор_каталога>"
      ```

    - PowerShell {#powershell}

      ```powershell
      $Env:YC_SERVICE_ACCOUNT_KEY_FILE="<путь_к_файлу_ключа>"
      $Env:YC_CLOUD_ID="<идентификатор_облака>"
      $Env:YC_FOLDER_ID="<идентификатор_каталога>"
      ```

    {% endlist %}

    Где:

    * `YC_SERVICE_ACCOUNT_KEY_FILE` — путь к файлу `key.json` с авторизированным ключом.
    * `YC_CLOUD_ID` — идентификатор облака.
    * `YC_FOLDER_ID` — идентификатор каталога.

    {% note info %}

    При запуске команд plan или apply можно передать значения напрямую в аргументах командной строки, не указывая их в конфигурации:

    ```bash
    terraform apply -var="cloud_id=<идентификатор_облака>" -var="folder_id=<идентификатор_каталога>"
    ```

    {% endnote %}

{% include [provider-config-example](../_includes/terraform/provider-config-example.md) %}


## Аутентификация от имени пользовательского аккаунта {#user}

{% include [authentication-intro](../_includes/terraform/authentication-intro.md) %}

{% include [authentication-users](../_includes/terraform/authentication-users.md) %}
