Чтобы управлять инфраструктурой {{ yandex-cloud }} с помощью {{ TF }}, используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Это позволит гибко настраивать права доступа к ресурсам.

Также вы можете использовать {{ TF }} от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport) или [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation), однако этот способ является менее безопасным. Подробности см. в конце раздела.
1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите](../../cli/quickstart.md#install) его.
1. Если у вас еще нет сервисного аккаунта, создайте его:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать сервисный аккаунт.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Введите имя сервисного аккаунта.

        Требования к формату имени:

        {% include [name-format](../../_includes/name-format.md) %}

     1. Нажмите кнопку **Создать**.

   - CLI {#cli}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Выполните команду для создания сервисного аккаунта:

     ```bash
     yc iam service-account create --name <имя_сервисного_аккаунта>
     ```

     Где `name` — имя сервисного аккаунта в формате:

     {% include [name-format](../../_includes/name-format.md) %}

     Результат:

     ```text
     id: ajehr0to1g8b********
     folder_id: b1gv87ssvu49********
     created_at: "2022-09-14T09:03:11.665153755Z"
     name: sa-terraform
     ```

   - API {#api}

     Чтобы создать сервисный аккаунт, воспользуйтесь вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) или методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount` REST API.

    {% endlist %}

1. Назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md), необходимые для управления ресурсами {{ yandex-cloud }}:

   {% include [sa-assign-role-note](../../_includes/sa-assign-role-note.md) %}

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     Чтобы назначить сервисному аккаунту роль на каталог:

     {% include [grant-role-console-sa](../../_includes/grant-role-console-sa.md) %}

   - CLI {#cli}

     1. Узнайте идентификатор сервисного аккаунта (столбец `ID`), которому нужно назначить роль:

        ```bash
        yc iam service-account list
        ```

        Результат:

        ```text
        +----------------------+--------------+--------+---------------------+-----------------------+
        |          ID          |     NAME     | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
        +----------------------+--------------+--------+---------------------+-----------------------+
        | ajeg2b2et02f******** | terraform-sa |        | 2024-09-08 18:59:45 | 2025-08-21 06:40:00   |
        | ajegtlf2q28a******** | default-sa   |        | 2023-06-27 16:18:18 | 2025-08-21 06:30:00   |
        +----------------------+--------------+--------+---------------------+-----------------------+
        ```

     1. Назначьте сервисному аккаунту роль на ресурс:

        ```bash
        yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
          --role <role-id> \
          --subject serviceAccount:<service-account-id>
        ```

        Где:
        * `<service-name>` — название [сервиса](../../cli/cli-ref/index.md#service-manage), на чей ресурс назначается роль, например `resource-manager`.
        * `<resource>` — категория ресурса, например `cloud` — для назначения роли на все [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или `folder` — для назначения роли на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
        * `<resource-name>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору (имя облака или каталога).
        * `<resource-id>` — идентификатор ресурса (идентификатор облака или каталога).
        * `<role-id>` — назначаемая роль, например `{{ roles-cloud-owner }}`.
        * `<service-account-id>` — идентификатор сервисного аккаунта, которому назначается роль.

        >Пример:
        > 
        >```bash
        >yc resource-manager folder add-access-binding **********9n9hi2qu --role editor --subject serviceAccount:**********qhi2qu
        >```
        >
        >Результат:
        >
        >```text
        >done (1s)
        >```

   - API {#api}

     {% include [grant-role-for-sa-to-folder-via-api](../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

   {% endlist %}

1. Добавьте аутентификационные данные в переменные окружения. При создании [IAM-токен](../../iam/concepts/authorization/iam-token.md) используйте [имперсонацию](../../iam/concepts/access-control/index.md#impersonation) созданного ранее сервисного аккаунта, указав его идентификатор в параметре `--impersonate-service-account-id`:

    {% include [impersonation-role-notice](../../_includes/cli/impersonation-role-notice.md) %}

    {% list tabs group=programming_language %}

    - Bash {#bash}

      ```bash
      export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <идентификатор_сервисного_аккаунта>)
      export YC_CLOUD_ID=$(yc config get cloud-id)
      export YC_FOLDER_ID=$(yc config get folder-id)
      ```

      Где:
      * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта.
      * `YC_CLOUD_ID` — идентификатор облака.
      * `YC_FOLDER_ID` — идентификатор каталога.

    - PowerShell {#powershell}

      ```powershell
      $Env:YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <идентификатор_сервисного_аккаунта>)
      $Env:YC_CLOUD_ID=$(yc config get cloud-id)
      $Env:YC_FOLDER_ID=$(yc config get folder-id)
      ```

      Где:
      * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта.
      * `YC_CLOUD_ID` — идентификатор облака.
      * `YC_FOLDER_ID` — идентификатор каталога.

    {% endlist %}

    {% note info %}

    {% include [iam-token-lifetime](../../_includes/iam-token-lifetime.md) %}

    {% endnote %}
