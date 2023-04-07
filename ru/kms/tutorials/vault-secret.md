# Auto Unseal в Hashicorp Vault

Сборка [Hashicorp Vault](https://www.vaultproject.io/) с поддержкой {{ kms-name }} доступна в виде [образа виртуальной машины](/marketplace/products/yc/vault-yckms) в {{ marketplace-full-name }} и [Docker-образа](../../container-registry/concepts/docker-image.md). Она отличается от [основной](https://hub.docker.com/_/vault) только одним из бинарных файлов Vault, в который добавлена поддержка {{ kms-name }}.

Даная сборка позволяет использовать {{ kms-name }} в качестве доверенного сервиса для шифрования секретов. Реализуется это через механизм [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal#auto-unseal).

Из этого руководства вы узнаете как настроить механизм Auto Unseal для работы с {{ kms-name }}.

Чтобы настроить Auto Unseal:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте Auto Unseal](#setup).

## Подготовьте облако к работе {#before-you-begin}

1. Скачайте последнюю версию Docker-образа:

   ```bash
   docker pull {{ registry }}/yc/vault
   ```

1. Выберите один из способов аутентификации запросов Vault к {{ kms-name }}. Аутентифицироваться можно через:

   {% list tabs %}

   - Сервисный аккаунт, привязанный к ВМ

     Для аутентификации будет использоваться [{{ iam-full-name }}-токен](../../iam/concepts/authorization/iam-token.md), автоматически извлекаемый из [метаданных ВМ](../../compute/concepts/vm-metadata.md). Подробнее об этом читайте в разделе [{#T}](../../compute/operations/vm-connect/auth-inside-vm.md).

     {% note tip %}

     Этот вариант наиболее предпочтительный с точки зрения безопасности. При настройке с использованием [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), привязанного к [ВМ](../../compute/concepts/vm.md), указание учетных данных не требуется.

     {% endnote %}

   - Произвольный сервисный аккаунт

     Для аутентификации будет использован авторизованный ключ. Подробнее о том, как работать с авторизованным ключом читайте в разделе [{#T}](../../iam/operations/iam-token/create-for-sa.md#via-cli).

   - Аккаунт на Яндексе или федеративный аккаунт

     Для аутентификации будет использован [OAuth-токен](../../iam/concepts/authorization/oauth-token.md) или {{ iam-name }}-токен.

     {% note tip %}

     Этот вариант самый нежелательный с точки зрения безопасности. Рекомендуется использовать только для тестирования.

     {% endnote %}

   {% endlist %}

1. [Создайте](../operations/key.md#create) отдельный [{{ kms-name}}-ключ](../concepts/key.md) для Vault (рекомендуется).
1. [Предоставьте доступ](../../iam/operations/roles/grant.md) к ключу только пользователю или сервисному аккаунту, который будет использоваться для аутентификации запросов Vault в {{ kms-name }}. Vault при взаимодействии с {{ kms-name }} выполняет только операции [шифрования и расшифрования](../concepts/encryption.md), поэтому [роли](../../iam/concepts/access-control/roles.md) `kms.keys.encrypterDecrypter` будет достаточно.



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* Плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического [внешнего IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за количество активных версий {{ kms-name }}-ключа и число выполненных криптографических операций (см. [тарифы {{ vpc-name }}](../../kms/pricing.md)).


## Настройте Auto Unseal {#setup}

Для настройки Auto Unseal внесите изменения в [конфигурационный файл](https://www.vaultproject.io/docs/configuration) Vault:

{% note warning %}

Если Vault уже проинициализирован, изменять конфигурацию необходимо в рамках [процедуры миграции](https://www.vaultproject.io/docs/concepts/seal#seal-migration).

{% endnote %}

1. В блоке [seal](https://www.vaultproject.io/docs/configuration/seal#seal-stanza) укажите значение `"yandexcloudkms"`.
1. Добавьте параметр `kms_key_id` с идентификатором {{ kms-name }}-ключа для шифрования.
1. Аутентифицируйтесь одним из способов:

   {% list tabs %}

   - Сервисный аккаунт, привязанный к ВМ

     [Привяжите сервисный аккаунт к ВМ](../../compute/operations/vm-connect/auth-inside-vm.md).

   - Произвольный сервисный аккаунт

     В значении параметра `service_account_key_file` укажите путь к файлу с авторизованным ключом сервисного аккаунта.

   - Аккаунт на Яндексе или федеративный аккаунт

     В значении параметра `oauth_token` укажите OAuth-токен.

  {% endlist %}

1. В блоке [seal](https://www.vaultproject.io/docs/configuration/seal#seal-stanza) укажите значение `"yandexcloudkms"`.
1. Добавьте параметр `kms_key_id` с идентификатором {{ kms-name }}-ключа для шифрования.
1. Аутентифицируйтесь одним из способов:

   {% list tabs %}

   - Сервисный аккаунт, привязанный к ВМ

     [Привяжите сервисный аккаунт к ВМ](../../compute/operations/vm-connect/auth-inside-vm.md).

   - Произвольный сервисный аккаунт

     В значении параметра `service_account_key_file` укажите путь к файлу с авторизованным ключом сервисного аккаунта.

   - Аккаунт на Яндексе или федеративный аккаунт

     В значении параметра `oauth_token` укажите OAuth-токен.

    {% endlist %}

{% note info %}

Для задания значений параметров вместо конфигурационного файла можно использовать переменные окружения:
* Переменной `YANDEXCLOUD_KMS_KEY_ID` соответствует параметр `kms_key_id` файла конфигурации.
* Переменной `YANDEXCLOUD_SERVICE_ACCOUNT_KEY_FILE` — параметр `service_account_key_file`.
* Переменной `YANDEXCLOUD_OAUTH_TOKEN` — параметр `oauth_token`.

Значения из переменных окружения имеют приоритет над значениями из конфигурационного файла.

{% endnote %}

## Примеры конфигурации {#examples}

{% list tabs %}

- Сервисный аккаунт, привязанный к ВМ

  ```json
  ...
  seal "yandexcloudkms" {
    kms_key_id = "<идентификатор_KMS-ключа>"
  }
  ```

- Произвольный сервисный аккаунт с ключом

  ```json
  ...
  seal "yandexcloudkms" {
    kms_key_id               = "<идентификатор_KMS-ключа>"
    service_account_key_file = "<путь_к_JSON-файлу_с_авторизованным_ключом>"
  }
  ```

- Аккаунт на Яндексе или федеративный аккаунт

  ```json
  ...
  seal "yandexcloudkms" {
    kms_key_id  = "<идентификатор_KMS-ключа>"
    oauth_token = "<токен_пользователя>"
  }
  ```

{% endlist %}

## Ротация ключей {#rotation}

При шифровании мастер-ключа Vault {{ kms-name }}-ключом Vault дополнительно сохраняет [версию ключа](../concepts/version.md), которой он был зашифрован.

При расшифровании мастер-ключа Vault (при рестарте Vault) сохраненная версия {{ kms-name }}-ключа, на которой зашифрован master-ключ Vault, сравнивается с primary-версией {{ kms-name }}-ключа. Если версии различаются, происходит перешифрование мастер-ключа Vault новой primary-версией {{ kms-name }}-ключа.

Таким образом перешифрование мастер-ключа Vault можно осуществлять [ротацией ключа в {{ kms-name }}](../concepts/version.md#rotate-key). Ротация ключа в {{ kms-name }} приведет к автоматическому перешифрованию мастер-ключа Vault во время следующего рестарта Vault.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md), если вы создавали ее для запуска Vault.
* [Удалите статический публичный IP-адрес](../../vpc/operations/address-delete.md), если вы его зарезервировали.
* [Удалите {{ kms-name }}-ключ](../../kms/operations/key.md#delete).

## См. также {#see-also}
* [Hashicorp Vault](https://www.vaultproject.io/).
* [Seal/Unseal в Vault](https://www.vaultproject.io/docs/concepts/seal).
* [Seal-конфигурация в Vault](https://www.vaultproject.io/docs/configuration/seal).