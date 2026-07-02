[Документация Yandex Cloud](../index.md) > [Terraform в Yandex Cloud](index.md) > Настройка аутентификации Terraform-провайдера Yandex Cloud

# Настройка аутентификации Terraform-провайдера Yandex Cloud

Для аутентификации и управления инфраструктурой Yandex Cloud вы можете использовать Terraform от имени:
* [сервисного аккаунта](../iam/concepts/users/service-accounts.md) с помощью [IAM-токена](#service-account) или [авторизованного ключа](#service-account-key);
* [пользовательского аккаунта](#users):
    * [аккаунта на Яндексе](../iam/concepts/users/accounts.md#passport);
    * [федеративного аккаунта](../iam/concepts/users/accounts.md#saml-federation);
    * [локального пользователя](../iam/concepts/users/accounts.md#local).


## Аутентификация от имени сервисного аккаунта с помощью IAM-токена {#service-account}

Процесс аутентификации строится на получении временного IAM-токена с помощью Yandex CLI и передаче его в Terraform. Это делает конфигурацию Terraform универсальной и безопасной, так как IAM-токен не сохраняется в файлах конфигурации, а в коде описана только логика создания ресурсов, без привязки к конкретному облаку или каталогу.

Использование сервисного аккаунта с помощью [имперсонации](../iam/concepts/access-control/impersonation.md) является рекомендованным и наиболее безопасным способом аутентификации.

При создании IAM-токена используйте имперсонацию для созданного сервисного аккаунта, указав его идентификатор в параметре `--impersonate-service-account-id`. В результате Terraform будет от имени сервисного аккаунта управлять ресурсами в каталоге и использовать IAM-токен сервисного аккаунта.

{% note info %}

Для использования имперсонации пользователю должна быть назначена [роль](../iam/security/index.md#iam-serviceAccounts-tokenCreator) `iam.serviceAccounts.tokenCreator` на соответствующий сервисный аккаунт.

{% endnote %}

Для аутентификации от имени сервисного аккаунта:

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите](../cli/operations/install-cli.md).

1. В Yandex Cloud CLI [создайте](../cli/operations/profile/profile-create.md) новый профиль или [активируйте](../cli/operations/profile/profile-activate.md) созданный ранее.

1. Аутентифицируйтесь от имени [аккаунта на Яндексе](../cli/operations/authentication/user.md), [федеративного](../cli/operations/authentication/federated-user.md) или [локального](../cli/operations/authentication/local-user.md) пользователя.

1. Если у вас еще нет сервисного аккаунта, [создайте](../iam/operations/sa/create.md) его.

1. [Назначьте](../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли, необходимые для управления ресурсами Yandex Cloud.

1. Запишите аутентификационные данные в переменные окружения, используя имперсонацию:

    - Bash {#bash}

      ```bash
      export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <идентификатор_сервисного_аккаунта>)
      export YC_CLOUD_ID=$(yc config get cloud-id)
      export YC_FOLDER_ID=$(yc config get folder-id)
      ```

    - PowerShell {#powershell}

      ```powershell
      $Env:YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <идентификатор_сервисного_аккаунта>)
      $Env:YC_CLOUD_ID=$(yc config get cloud-id)
      $Env:YC_FOLDER_ID=$(yc config get folder-id)
      ```

    {% endlist %}

    Где `<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта.

В результате в переменных окружения сохранятся IAM-токен сервисного аккаунта, а также идентификатор облака и идентификатор каталога.

{% note info %}

При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого снова потребуется пройти аутентификацию. Для автоматического перевыпуска IAM-токена можно использовать скрипт или другие способы автоматизации. 

Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.

{% endnote %}

Настройки провайдера в конфигурационном файле Terraform без указания чувствительных параметров указываются следующим образом:


```hcl
provider "yandex" {
  # Параметры cloud_id, folder_id и token не указываются, так как
  # провайдер автоматически подхватит их из переменных окружения

  zone = "<зона_доступности>"
}
```



Где `zone` — [зона доступности](../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.

С такой конфигурацией используйте Terraform без дополнительных флагов, так как провайдер автоматически подхватит их из переменных окружения.


## Аутентификация от имени сервисного аккаунта с помощью авторизованного ключа {#service-account-key}

Позволяет постоянно аутентифицироваться с помощью однажды созданного авторизованного ключа. Использование долгоживущего ключа менее безопасно, чем использование [имперсонации и IAM-токена](#service-account).

Для аутентификации от имени сервисного аккаунта с помощью авторизованного ключа:
1. Если у вас еще нет сервисного аккаунта, [создайте](../iam/operations/sa/create.md) его.
1. [Назначьте](../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли, необходимые для управления ресурсами Yandex Cloud.
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

Настройки провайдера в конфигурационном файле Terraform без указания чувствительных параметров указываются следующим образом:


```hcl
provider "yandex" {
  # Параметры cloud_id, folder_id и token не указываются, так как
  # провайдер автоматически подхватит их из переменных окружения

  zone = "<зона_доступности>"
}
```



Где `zone` — [зона доступности](../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.

С такой конфигурацией используйте Terraform без дополнительных флагов, так как провайдер автоматически подхватит их из переменных окружения.


## Аутентификация от имени пользовательского аккаунта {#user}

Процесс аутентификации строится на получении временного IAM-токена с помощью Yandex CLI и передаче его в Terraform. Это делает конфигурацию Terraform универсальной и безопасной, так как IAM-токен не сохраняется в файлах конфигурации, а в коде описана только логика создания ресурсов, без привязки к конкретному облаку или каталогу.

{% note warning %}

Управление ресурсами от имени пользовательского аккаунта является менее безопасным, чем использование сервисного аккаунта.

{% endnote %}

Для аутентификации от имени пользовательского аккаунта:

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите](../cli/operations/install-cli.md).

1. В Yandex Cloud CLI [создайте](../cli/operations/profile/profile-create.md) новый профиль или [активируйте](../cli/operations/profile/profile-activate.md) созданный ранее.

1. Аутентифицируйтесь в зависимости от типа используемого аккаунта: [аккаунта на Яндексе](../cli/operations/authentication/user.md), [федеративного](../cli/operations/authentication/federated-user.md) или [локального](../cli/operations/authentication/local-user.md) пользователя.

1. Запишите чувствительные данные профиля: IAM-токен, идентификатор облака и каталога в переменные окружения:
   
   {% list tabs group=programming_language %}
   
   - Bash {#bash}
   
     ```bash
     export YC_TOKEN=$(yc iam create-token)
     export YC_CLOUD_ID=$(yc config get cloud-id)
     export YC_FOLDER_ID=$(yc config get folder-id)
     ```
   
   - PowerShell {#powershell}
   
     ```powershell
     $Env:YC_TOKEN=$(yc iam create-token)
     $Env:YC_CLOUD_ID=$(yc config get cloud-id)
     $Env:YC_FOLDER_ID=$(yc config get folder-id)
     ```
   
   {% endlist %}
   
   Где:
   
   `yc iam create-token` — получение IAM-токена для текущей сессии.
   `yc config get cloud-id` — получение идентификатора облака из текущего профиля CLI.
   `yc config get folder-id` — получение идентификатора каталога из текущего профиля CLI.
   
   
   В результате в переменных окружения сохранятся IAM-токен, а также идентификатор облака и идентификатор каталога.

{% note info %}

При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого снова потребуется пройти аутентификацию. Для автоматического перевыпуска IAM-токена можно использовать скрипт или другие способы автоматизации. 

Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.

{% endnote %}

Настройки провайдера в конфигурационном файле Terraform без указания чувствительных параметров указываются следующим образом:


```hcl
provider "yandex" {
  # Параметры cloud_id, folder_id и token не указываются, так как
  # провайдер автоматически подхватит их из переменных окружения

  zone = "<зона_доступности>"
}
```



Где `zone` — [зона доступности](../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.

С такой конфигурацией используйте Terraform без дополнительных флагов, так как провайдер автоматически подхватит их из переменных окружения.