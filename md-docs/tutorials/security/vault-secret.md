# Auto Unseal в HashiCorp Vault

Сборка [HashiCorp Vault](https://www.vaultproject.io/) с поддержкой Yandex Key Management Service доступна в виде [образа ВМ](https://yandex.cloud/ru/marketplace/products/yc/vault-yckms) в Cloud Marketplace и docker-образа. Она отличается от [основной](https://hub.docker.com/_/vault) только одним из бинарных файлов Vault, в который добавлена поддержка Key Management Service.

Даная сборка позволяет использовать Key Management Service в качестве доверенного сервиса для шифрования секретов. Реализуется это через механизм [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal#auto-unseal).

Из этого руководства вы узнаете как настроить механизм Auto Unseal для работы с KMS.

Чтобы настроить Auto Unseal:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте Auto Unseal](#setup).

## Подготовьте облако к работе {#before-you-begin}

1. Скачайте последнюю версию docker-образа, используйте команду:

      ```bash
   docker pull cr.yandex/yc/vault
   ```

1. Выберите один из способов аутентификации запросов Vault к KMS. Аутентифицироваться можно через:

    {% list tabs group=authentication %}

    - Сервисный аккаунт, привязанный к ВМ {#service-account-vm}

        Для аутентификации будет использоваться [IAM-токен](../../iam/concepts/authorization/iam-token.md), автоматически извлекаемый из [метаданных ВМ](../../compute/concepts/vm-metadata.md). Подробнее об этом читайте в разделе [Работа с Yandex Cloud изнутри виртуальной машины](../../compute/operations/vm-connect/auth-inside-vm.md).

        {% note tip %}

        Этот вариант наиболее предпочтительный с точки зрения безопасности. При настройке с использованием [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), привязанного к ВМ, указание учетных данных не требуется.

        {% endnote %}

    - Произвольный сервисный аккаунт {#service-account}

        Для аутентификации будет использован авторизованный ключ. Подробнее о том, как работать с авторизованным ключом читайте в разделе [Получить IAM-токен с помощью CLI](../../iam/operations/iam-token/create-for-sa.md#via-cli).

    - Федеративный, локальный или аккаунт на Яндексе {#yandex-account}

        Для аутентификации будет использован [IAM-токен](../../iam/concepts/authorization/iam-token.md).

        {% note tip %}

        Этот вариант самый нежелательный с точки зрения безопасности. Рекомендуется использовать только для тестирования.

        {% endnote %}

    {% endlist %}

1. [Создайте](../../kms/operations/key.md#create) отдельный [Key Management Service-ключ](../../kms/concepts/key.md) для Vault (рекомендуется).
1. [Предоставьте доступ](../../iam/operations/roles/grant.md) к ключу только пользователю или сервисному аккаунту, который будет использоваться для аутентификации запросов Vault в KMS. Vault при взаимодействии с KMS выполняет только операции [шифрования и расшифрования](../../kms/concepts/symmetric-encryption.md), поэтому [роли](../../iam/concepts/access-control/roles.md) `kms.keys.encrypterDecrypter` будет достаточно.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* плата за постоянно запущенную ВМ (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование динамического или статического [внешнего IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md));
* плата за количество активных версий KMS-ключа и число выполненных криптографических операций (см. [тарифы Yandex Virtual Private Cloud](../../kms/pricing.md)).

## Настройте Auto Unseal {#setup}

Для настройки Auto Unseal внесите изменения в [конфигурационный файл](https://www.vaultproject.io/docs/configuration) Vault:

{% note warning %}

Если Vault уже проинициализирован, изменять конфигурацию необходимо в рамках [процедуры миграции](https://www.vaultproject.io/docs/concepts/seal#seal-migration).

{% endnote %}

1. В блоке [seal](https://www.vaultproject.io/docs/configuration/seal#seal-stanza) укажите значение `"yandexcloudkms"`.
1. Добавьте параметр `kms_key_id` с идентификатором KMS-ключа для шифрования.
1. Аутентифицируйтесь одним из способов:

    {% list tabs group=authentication %}

    - Сервисный аккаунт, привязанный к ВМ {#service-account-vm}

      Привяжите сервисный аккаунт к ВМ в соответствии с [инструкцией](../../compute/operations/vm-connect/auth-inside-vm.md).

    - Произвольный сервисный аккаунт {#service-account}

      В значении параметра `service_account_key_file` укажите путь к файлу с авторизованным ключом сервисного аккаунта.

    - Федеративный, локальный или аккаунт на Яндексе {#yandex-account}

      Укажите IAM-токен.

    {% endlist %}

1. Измените конфигурацию в рамках [процедуры миграции](https://www.vaultproject.io/docs/concepts/seal#seal-migration), соответствующей используемой версии Vault.

{% note info %}

Для задания значений параметров вместо конфигурационного файла можно использовать переменные окружения:
* переменной `YANDEXCLOUD_KMS_KEY_ID` соответствует параметр `kms_key_id` файла конфигурации;
* переменной `YANDEXCLOUD_SERVICE_ACCOUNT_KEY_FILE` — параметр `service_account_key_file`.

Значения из переменных окружения имеют приоритет над значениями из конфигурационного файла.

{% endnote %}

## Примеры конфигурации {#examples}

{% list tabs group=authentication %}

- Сервисный аккаунт, привязанный к ВМ {#service-account-vm}

    ```json
    ...
    seal "yandexcloudkms" {
      kms_key_id = "<идентификатор_KMS-ключа>"
    }
    ...
    ```

- Произвольный сервисный аккаунт {#service-account}

    ```json
    ...
    seal "yandexcloudkms" {
      kms_key_id               = "<идентификатор_KMS-ключа>"
      service_account_key_file = "<путь_к_JSON-файлу>"
    }
    ...
    ```

    Где `service_account_key_file` — путь к JSON-файлу с авторизованным ключом.

- Федеративный, локальный или аккаунт на Яндексе {#yandex-account}

    ```json
    ...
    seal "yandexcloudkms" {
      kms_key_id  = "<идентификатор_KMS-ключа>"
      iam_token = "<токен_пользователя>"
    }
    ...
    ```

{% endlist %}

## Ротация ключей {#rotation}

При шифровании master-ключа Vault KMS-ключом Vault дополнительно сохраняет [версию ключа](../../kms/concepts/version.md), которой он был зашифрован.

При расшифровании master-ключа Vault (при рестарте Vault) сохраненная версия KMS-ключа, на которой зашифрован master-ключ Vault, сравнивается с primary-версией KMS-ключа. Если версии различаются, происходит перешифрование master-ключа Vault новой primary-версией KMS-ключа.

Таким образом перешифрование master-ключа Vault можно осуществлять [ротацией ключа в KMS](../../kms/concepts/version.md#rotate-key). Ротация ключа в Key Management Service приведет к автоматическому перешифрованию master-ключа Vault во время следующего рестарта Vault.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [удалите ВМ](../../compute/operations/vm-control/vm-delete.md), если вы создавали ее для запуска Vault;
* [удалите статический публичный IP-адрес](../../vpc/operations/address-delete.md), если вы его зарезервировали;
* [удалите Key Management Service-ключ](../../kms/operations/key.md#delete).

## См. также {#see-also}
* [HashiCorp Vault](https://www.vaultproject.io/)
* [Seal/Unseal в Vault](https://www.vaultproject.io/docs/concepts/seal)
* [Seal-конфигурация в Vault](https://www.vaultproject.io/docs/configuration/seal)