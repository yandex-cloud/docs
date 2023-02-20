# Auto Unseal в Hashicorp Vault

Сборка [Hashicorp Vault](https://www.vaultproject.io/) с поддержкой [{{ kms-name }}](../) доступна в виде [образа ВМ](/marketplace/products/yc/vault-yckms) в {{ marketplace-name }} и docker-образа.

Сборка  позволяет использовать {{ kms-name }} в качестве доверенного сервиса для шифрования секретов. Реализуется это через механизм [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal#auto-unseal).

Сборка отличается от [официальной](https://hub.docker.com/_/vault) только одним из бинарных файлов Vault, в нашей сборке в него добавлена поддержка {{ kms-name }}.

Чтобы скачать последнюю версию docker-образа, используйте команду:

```bash
docker pull {{ registry }}/yc/vault
```

## Перед началом работы { #before-you-begin }

1. Выберите один из способов аутентификации запросов Vault к {{ kms-short-name }}. Аутентифицироваться можно через:

    {% list tabs %}

    - Сервисный аккаунт, привязанный к ВМ

        Для аутентификации будет использоваться IAM-токен, автоматически извлекаемый из метаданных виртуальной машины. Подробнее об этом читайте в разделе [{#T}](../../compute/operations/vm-connect/auth-inside-vm.md).

        {% note tip %}

        Этот вариант наиболее предпочтительный с точки зрения безопасности. При настройке с использованием сервисного аккаунта, привязанного к виртуальной машине, указание учетных данных не требуется.

        {% endnote %}

    - Произвольный сервисный аккаунт

        Для аутентификации будет использован авторизованный ключ. Подробнее о том, как работать с авторизованным ключом читайте в разделе [{#T}](../../iam/operations/iam-token/create-for-sa.md#via-cli).

    - Аккаунт на Яндексе

        Для аутентификации будет использован [OAuth-токен](../../iam/concepts/authorization/oauth-token.md).

    {% endlist %}

1. [Создайте](../operations/key.md#create) отдельный KMS-ключ для Vault (рекомендуется).
1. [Предоставьте доступ](../../iam/operations/roles/grant.md) к ключу только пользователю или сервисному аккаунту, который будет использоваться для аутентификации запросов Vault в {{ kms-short-name }}. Vault при взаимодействии с {{ kms-short-name }} выполняет только операции шифрования и расшифрования, поэтому роли `kms.keys.encrypterDecrypter` будет достаточно.

## Настройка Auto Unseal {#setup}

Для настройки Auto Unseal внесите изменения в конфигурационный файл Vault:

   1. В блоке [seal](https://www.vaultproject.io/docs/configuration/seal#seal-stanza) укажите значение `"yandexcloudkms"`.
   1. Добавьте параметр `kms_key_id` с идентификатором KMS-ключа для шифрования.
   1. Аутентифицируйтесь одним из способов:

      {% list tabs %}

        - Сервисный аккаунт, привязанный к ВМ

            Привяжите сервисный аккаунт к ВМ в соответствии с [инструкцией](../../compute/operations/vm-connect/auth-inside-vm.md).

        - Произвольный сервисный аккаунт

            В значении параметра `service_account_key_file` укажите путь к файлу с авторизованным ключом сервисного аккаунта.

        - Аккаунт на Яндексе или федеративный аккаунт

            В значении параметра `oauth_token` укажите OAuth-токен Яндекс ID.

      {% endlist %}

{% note warning %}

Если Vault уже проинициализирован, изменять конфигурацию необходимо в рамках [процедуры миграции](https://www.vaultproject.io/docs/concepts/seal#seal-migration).

{% endnote %}

Для задания значений параметров вместо конфигурационного файла можно использовать переменные окружения:
   * `YANDEXCLOUD_KMS_KEY_ID` соответствует параметр `kms_key_id` из файла конфигурации Vault;
   * `YANDEXCLOUD_SERVICE_ACCOUNT_KEY_FILE` — параметру `service_account_key_file`;
   * `YANDEXCLOUD_OAUTH_TOKEN` — параметру `oauth_token`.

Значения из переменных окружение имеют приоритет над значениями из конфигурационного файла.

## Примеры конфигурации {#examples} 

{% list tabs %}

- Сервисный аккаунт, привязанный к ВМ

    ```json
    ...
    seal "yandexcloudkms" {
      kms_key_id = "<идентификатор KMS-ключа>"
    }
    ...
    ```

- Произвольный сервисный аккаунт

    ```json
    ...
    seal "yandexcloudkms" {
      kms_key_id = "<идентификатор KMS-ключа>"
      service_account_key_file = "<путь к JSON файлу с авторизованным ключом>"
    }
    ...
    ```

- Аккаунт на Яндексе

    ```json
    ...
    seal "yandexcloudkms" {
      kms_key_id = "<идентификатор KMS-ключа>"
      oauth_token = "<OAuth-токен пользователя>"  
    }
    ...
    ```

{% endlist %}

## Ротация ключей {#rotation}

При шифровании master-ключа Vault KMS-ключом Vault дополнительно сохраняет версию ключа, которой он был зашифрован.  

При расшифровании master-ключа Vault (при рестарте Vault) сохранённая версия KMS-ключа, на которой зашифрован master-ключ Vault, сравнивается с primary-версией KMS-ключа и, если версии различаются, происходит перешифрование master-ключа Vault новой primary-версией KMS-ключа. 

Таким образом перешифрование master-ключа Vault можно осуществлять [ротацией ключа в {{ kms-short-name }}](../concepts/version.md#rotate-key). Ротация ключа в KMS приведет к автоматическому перешифрованию master-ключа Vault во время следующего рестарта Vault.

## См. также {#see-also}
* [Hashicorp Vault](https://www.vaultproject.io/)
* [Seal/Unseal в Vault](https://www.vaultproject.io/docs/concepts/seal)
* [Seal-конфигурация в Vault](https://www.vaultproject.io/docs/configuration/seal)