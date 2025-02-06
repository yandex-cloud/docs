## Установите и настройте {{ TF }} {#prepare-terraform}

### Установите {{ TF }} {#install-terraform}

{% include [terraform-install.md](../_tutorials_includes/terraform-install-os.md) %}

### Получите данные для аутентификации {#get-credentials}

Чтобы управлять инфраструктурой {{ yandex-cloud }} с помощью {{ TF }}, используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Это позволит гибко настраивать права доступа к ресурсам.

Также вы можете использовать {{ TF }} от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport) или [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation), однако этот способ является менее безопасным. Подробности см. в конце раздела.

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите](../../cli/quickstart.md#install) его.

1. Настройте профиль CLI для выполнения операций от имени сервисного аккаунта:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта и запишите его файл:

          ```bash
          yc iam key create \
            --service-account-id <идентификатор_сервисного_аккаунта> \
            --folder-name <имя_каталога_с_сервисным_аккаунтом> \
            --output key.json
          ```

          Где:
          * `service-account-id` — идентификатор сервисного аккаунта.
          * `folder-name` — имя каталога, в котором создан сервисный аккаунт.
          * `output` — имя файла с авторизованным ключом.

          Результат:

          ```text
          id: aje8nn871qo4********
          service_account_id: ajehr0to1g8b********
          created_at: "2022-09-14T09:11:43.479156798Z"
          key_algorithm: RSA_2048
          ```

      1. Создайте профиль CLI для выполнения операций от имени сервисного аккаунта. Укажите имя профиля:

          ```bash
          yc config profile create <имя_профиля>
          ```

          Результат:

          ```text
          Profile 'sa-terraform' created and activated
          ```

      1. Задайте конфигурацию профиля:

          ```bash
          yc config set service-account-key key.json
          yc config set cloud-id <идентификатор_облака>
          yc config set folder-id <идентификатор_каталога>
          ```

          Где:
          * `service-account-key` — файл с авторизованным ключом сервисного аккаунта.
          * `cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
          * `folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

    {% endlist %}

1. Добавьте аутентификационные данные в переменные окружения:

    {% include [terraform-token-variables](../../_includes/terraform-token-variables.md) %}

{% cut "Управление ресурсами от имени аккаунта на Яндексе или федеративного аккаунта" %}

{% include [terraform-credentials-user](../_tutorials_includes/terraform-credentials-user.md) %}

{% endcut %}

### Создайте файл конфигурации {{ TF }} {#configure-terraform}

{% include [configure-terraform](../_tutorials_includes/configure-terraform.md) %}

### Настройте провайдер {#configure-provider}

{% include [terraform-configure-provider](../_tutorials_includes//terraform-configure-provider.md) %}
