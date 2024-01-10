Чтобы управлять инфраструктурой {{ yandex-cloud }} с помощью {{ TF }}, используйте [сервисный аккаунт](../iam/concepts/users/service-accounts.md). Это позволит гибко настраивать права доступа к ресурсам.

Также вы можете использовать {{ TF }} от имени [аккаунта на Яндексе](../iam/concepts/index.md#passport) или [федеративного аккаунта](../iam/concepts/index.md#saml-federation), однако этот способ является менее безопасным. Подробности см. в конце раздела.

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите](../cli/quickstart.md#install) его.
1. Если у вас еще нет сервисного аккаунта, создайте его:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. На вкладке **Сервисные аккаунты** нажмите кнопку **Создать сервисный аккаунт**.
      1. Введите имя сервисного аккаунта.

          Требования к формату имени:

          {% include [name-format](../_includes/name-format.md) %}

      1. Нажмите кнопку **Создать**.

    - CLI {#cli}

      {% include [default-catalogue](../_includes/default-catalogue.md) %}

      Выполните команду для создания сервисного аккаунта:

      ```bash
      yc iam service-account create --name <имя_сервисного_аккаунта>
      ```

      Где `name` — имя сервисного аккаунта в формате:

      {% include [name-format](../_includes/name-format.md) %}

      Результат:

      ```yaml
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2022-09-14T09:03:11.665153755Z"
      name: sa-terraform
      ```

    - API {#api}

      Чтобы создать сервисный аккаунт, воспользуйтесь методом [ServiceAccountService/Create](../iam/api-ref/grpc/service_account_service.md#Create) gRPC API или методом [create](../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount` REST API.

    {% endlist %}

1. Назначьте сервисному аккаунту [роли](../iam/concepts/access-control/roles.md), необходимые для управления ресурсами {{ yandex-cloud }}: 

    {% include [sa-assign-role-note](../_includes/sa-assign-role-note.md) %}

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      Чтобы назначить сервисному аккаунту роль на каталог:

      {% include [grant-role-console-sa](../_includes/grant-role-console-sa.md) %}

    - CLI {#cli}

      1. Узнайте идентификатор сервисного аккаунта (столбец `ID`), которому нужно назначить роль:

          ```bash
          yc iam service-account list
          ```

          Результат:

          ```text
          +----------------------+--------------+
          |          ID          |     NAME     |
          +----------------------+--------------+
          | aje6ij7qvdhb******** | sa-terraform |
          +----------------------+--------------+
          ```
          
      1. Назначьте сервисному аккаунту роль на ресурс:

          ```bash
          yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
            --role <role-id> \
            --subject serviceAccount:<service-account-id>
          ```

          Где:
          * `<service-name>` — название [сервиса](../cli/cli-ref/index.md#service-manage), на чей ресурс назначается роль, например `resource-manager`.
          * `<resource>` — категория ресурса, например `cloud`.
          * `<resource-name>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
          * `<resource-id>` — идентификатор ресурса.
          * `<role-id>` — назначаемая [роль](../iam/concepts/access-control/roles.md), например `{{ roles-cloud-owner }}`.
          * `<service-account-id>` — идентификатор сервисного аккаунта, которому назначается роль.

          Результат:

          ```text
          done (1s)
          ```

    - API {#api}

      {% include [grant-role-for-sa-to-folder-via-api](../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

    {% endlist %}

1. Настройте профиль CLI для выполнения операций от имени сервисного аккаунта:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Создайте [авторизованный ключ](../iam/concepts/authorization/key.md) для сервисного аккаунта и запишите его файл:

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

          ```yaml
          id: aje8nn871qo4********
          service_account_id: ajehr0to1g8********
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
          * `cloud-id` — [идентификатор облака](../resource-manager/operations/cloud/get-id.md).
          * `folder-id` — [идентификатор каталога](../resource-manager/operations/folder/get-id.md).

    {% endlist %}

1. Добавьте аутентификационные данные в переменные окружения:

    {% include [terraform-token-variables](../_includes/terraform-token-variables.md) %}
