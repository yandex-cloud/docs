# Auto Unseal в Hashicorp Vault

[Vault](https://www.vaultproject.io/) позволяет использовать {{ kms-name }} в качестве доверенного сервиса для шифрования секретов. Реализуется это через механизм [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal#auto-unseal).

## Перед началом работы { #before-you-begin }

1. Выберите один из способов аутентификации. Аутентифицироваться можно через: 

    {% list tabs %}
    
    - Сервисный аккаунт, привязанный к ВМ
        
        Для аутентификации будет использоваться IAM-токен, автоматически извлекаемый из метаданных виртуальной машины. Подробнее об этом читайте в разделе [{#T}](../../compute/operations/vm-connect/auth-inside-vm.md).
        
        {% note tip %}
        
        Этот вариант наиболее предпочтительный с точки зрения безопасности. При настройке с использованием сервисного аккаунта, привязанного к виртуальной машине, указание учетных данных не требуется.
        
        {% endnote %}

    - Произвольный сервисный аккаунт
    
        Для аутентификации будет использован авторизованный ключ. Подробнее о том, как работать с авторизованным ключом читайте в разделе [{#T}](../../iam/operations/iam-token/create-for-sa.md#via-cli).
        
    - Аккаунт на Яндексе
    
        Для аутентификации будет использован [OAuth-токен](https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token.md).

    {% endlist %}
    

1. [Создайте](../operations/key.md#create) отдельный KMS-ключ для Vault (рекомендуется).
1. [Предоставьте доступ](../../iam/operations/roles/grant.md) к ключу только пользователю или сервисному аккаунту, который будет использоваться для аутентификации запросов Vault в {{ kms-short-name }}. Vault при взаимодействии с {{ kms-short-name }} выполняет только операции шифрования и расшифрования, поэтому роли `kms.keys.encrypterDecrypter` будет достаточно.

## Настройка Auto Unseal {#setup}

Для настройки Auto Unseal внесите изменения в конфигурационный файл Vault:
    
   1. В блоке [seal](https://www.vaultproject.io/docs/configuration/seal#seal-stanza) укажите значение `"yandexcloudkms"`.
   1. Добавьте параметр `kms_key_id` с идентификатором KMS-ключа для шифрования.
   1. Если для аутентификации вы используете произвольный сервисный аккаунт или Яндекс ID, укажите соответствующие учетные данные:
      * в значении параметра `service_account_key_file` путь к файлу с авторизованным ключом сервисного аккаунта;
      * в значении параметра `oauth_token` OAuth-токен Яндекс ID.

{% note warning %}

Если Vault уже проинициализирован, изменять конфигурацию необходимо в рамках [процедуры миграции](https://www.vaultproject.io/docs/concepts/seal#seal-migration).

{% endnote %}

Для задания значений параметров вместо конфигурационного файла можно использовать переменные окружения:
   * переменной `YANDEXCLOUD_KMS_KEY_ID` соответствует параметр `kms_key_id` файла конфигурации;
   * переменной `YANDEXCLOUD_SERVICE_ACCOUNT_KEY_FILE` — параметр `service_account_key_file`;
   * переменной `YANDEXCLOUD_OAUTH_TOKEN` — параметр `oauth_token`.

   Значения из переменных окружение имеют приоритет над значениями из конфигурационного файла.

## Примеры конфигурации {#examples} 

#### Аутентификация через сервисный аккаунт, привязанный к виртуальной машине {#example-1}

```json
...
seal "yandexcloudkms" {
  kms_key_id = "<ID ключа>"
}
...
```

#### Аутентификация через произвольный сервисный аккаунт {#example-2}
```json
...
seal "yandexcloudkms" {
  kms_key_id = "<ID ключа>"
  service_account_key_file = "<путь к JSON файлу с авторизованным ключом>"
}
...
```

#### Аутентификация через Яндекс ID {#example-3}
```json
...
seal "yandexcloudkms" {
  kms_key_id = "<ID ключа>"
  oauth_token = "<OAuth-токен пользователя>"  
}
...
```

## Ротация ключей {#rotation}

При шифровании master-ключа KMS-ключом Vault дополнительно сохраняет версию, которой он был зашифрован. 

При расшифровании master-ключа (при рестарте Vault) сохраненная версия сравнивается с основной версией ключа {{ kms-short-name }} и, если они различаются, перешифровывает его основной версией. 

Таким образом ротацию master-ключа Vault можно осуществлять [ротацией ключа в {{ kms-short-name }}](../concepts/version.md#rotate-key). Ротация ключа в KMS приведет к автоматической ротации master-ключа во время следующего рестарта Vault.

## См. также {#see-also}
* [Hashicorp Vault](https://www.vaultproject.io/)
* [Seal/Unseal в Vault](https://www.vaultproject.io/docs/concepts/seal)
* [Seal-конфигурация в Vault](https://www.vaultproject.io/docs/configuration/seal)