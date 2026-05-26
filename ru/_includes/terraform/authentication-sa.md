Использование сервисного аккаунта с помощью [имперсонации](../../iam/concepts/access-control/impersonation.md) является рекомендованным и наиболее безопасным способом аутентификации.

При создании IAM-токена используйте имперсонацию для созданного сервисного аккаунта, указав его идентификатор в параметре `--impersonate-service-account-id`. В результате {{ TF }} будет от имени сервисного аккаунта управлять ресурсами в каталоге и использовать IAM-токен сервисного аккаунта.

{% include [impersonation-role-notice](../cli/impersonation-role-notice.md) %}

Для аутентификации от имени сервисного аккаунта:

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите](../../cli/operations/install-cli.md).

1. В {{ yandex-cloud }} CLI [создайте](../../cli/operations/profile/profile-create.md) новый профиль или [активируйте](../../cli/operations/profile/profile-activate.md) созданный ранее.

1. Аутентифицируйтесь от имени [аккаунта на Яндексе](../../cli/operations/authentication/user.md), [федеративного](../../cli/operations/authentication/federated-user.md) или [локального](../../cli/operations/authentication/local-user.md) пользователя.

1. Если у вас еще нет сервисного аккаунта, [создайте](../../iam/operations/sa/create.md) его.

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли, необходимые для управления ресурсами {{ yandex-cloud }}.

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

{% include [iam-refresh](iam-refresh.md) %}

{% include [provider-config-example](provider-config-example.md) %}
