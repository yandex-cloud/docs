# Изменить OIDC-приложение в Yandex Identity Hub


Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

## Измените базовые настройки приложения {#update-basic-settings}

Чтобы изменить базовые настройки [OIDC-приложения](../../concepts/applications.md#oidc):

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:

      1. В поле **Имя** измените имя приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          * длина — от 1 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. В поле **Описание** измените описание приложения.
      1. В поле **Метки** добавьте новые [метки](../../../resource-manager/concepts/labels.md) с помощью кнопки **Добавить метку**. Чтобы удалить существующую метку, используйте значок ![xmark](../../../_assets/console-icons/xmark.svg).
      1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application update --help
     ```
  
  1. Выполните команду:

     ```bash
     yc iam organization-manager idp application oauth application update \
       --id <идентификатор_приложения> \
       --new-name <имя_приложения> \
       --description <описание_приложения> \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes <атрибут>[,<атрибут>] \
       --group-distribution-type all-groups \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:

     * `--id` — идентификатор OIDC-приложения. Обязательный параметр.
     * `--new-name` — новое имя OIDC-приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       * длина — от 1 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `--description` — новое описание OIDC-приложения.
     * `--client-id` — идентификатор нового OAuth-клиента.
     * `--authorized-scopes` — новый набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов через запятую в формате `<атрибут1>,<атрибут2>`. Возможные атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `email` — адрес электронной почты пользователя.
       * `address` — адрес жительства пользователя.
       * `phone` — номер телефона пользователя.
       * `groups` — [группы пользователей](../../concepts/groups.md) в организации.

         {% note warning %}
         
         Новый набор атрибутов пользователей сначала необходимо указать в [конфигурации поставщика услуг](#update-sp) с помощью параметра `--scopes`.
         
         {% endnote %}

     * `--group-distribution-type` — если при создании или изменении OAuth-клиента вы указали атрибут `groups`, измените группы пользователей, которые будут переданы поставщику услуг. Возможные значения:
       * `all-groups` — поставщику услуг будут переданы все группы, в которые входит пользователь.

          Максимальное количество передаваемых групп — 1 000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп.
       * `assigned-groups` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые [явно заданы](#users-and-groups).
       * `none` — поставщику услуг не будут переданы группы, в которые входит пользователь.
     * `--labels` — новый список [меток](../../../resource-manager/concepts/labels.md). Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле Terraform измените параметры [OIDC-приложения](../../concepts/applications.md#oidc):

    ```hcl
    resource "yandex_organizationmanager_idp_application_oauth_application" "example_oidc_app" {
      application_id   = "<идентификатор_приложения>"
      organization_id = "<идентификатор_организации>"
      name            = "<новое_имя_приложения>"
      description     = "<новое_описание_приложения>"
      
      client_grant = {
        client_id         = "<идентификатор_OAuth-клиента>"
        authorized_scopes = ["<атрибут1>", "<атрибут2>"]
      }
      
      group_claims_settings = {
        group_distribution_type = "ALL_GROUPS"
      }
      
      labels = {
        "<ключ1>" = "<значение1>"
        "<ключ2>" = "<значение2>"
      }
    }
    ```

    Где:

    * `application_id` — идентификатор OIDC-приложения. Обязательный параметр.
    * `organization_id` — [идентификатор организации](../organization-get-id.md), в которой находится OIDC-приложение. Обязательный параметр.
    * `name` — новое имя OIDC-приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

      * длина — от 1 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

    * `description` — новое описание OIDC-приложения. Необязательный параметр.
    * `client_grant` — параметры подключения к OAuth-клиенту:
      * `client_id` — идентификатор OAuth-клиента. Обязательный параметр.
      * `authorized_scopes` — новый набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов в квадратных скобках. Возможные атрибуты:
        * `openid` — идентификатор пользователя. Обязательный атрибут.
        * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
        * `email` — адрес электронной почты пользователя.
        * `address` — место жительства пользователя.
        * `phone` — номер телефона пользователя.
        * `groups` — группы пользователей в организации.
    * `group_claims_settings` — настройки передачи групп пользователей поставщику услуг:
      * `group_distribution_type` — если при создании OAuth-клиента вы указали атрибут `groups`, укажите, какие группы пользователей будут переданы поставщику услуг. Возможные значения:
        * `ALL_GROUPS` — поставщику услуг будут переданы все группы, в которые входит пользователь.
        * `ASSIGNED_GROUPS` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые будут явно заданы.
        * `NONE` — поставщику услуг не будут переданы группы, в которые входит пользователь.
    * `labels` — список [меток](../../../resource-manager/concepts/labels.md). Необязательный параметр.

    Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_oauth_application` см. в [документации провайдера](../../../terraform/resources/organizationmanager_idp_application_oauth_application.md).

  1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    Проверить изменения ресурсов и их настройки можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../../cli/index.md):

    ```bash
    yc organization-manager idp application oauth application get <идентификатор_приложения>
    ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Update](../../idp/application/oauth/api-ref/Application/update.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Update](../../idp/application/oauth/api-ref/grpc/Application/update.md).

{% endlist %}

## Измените конфигурацию поставщика услуг {#update-sp}

Чтобы изменить конфигурацию поставщика услуг в OIDC-приложении:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:
     
     1. В поле **Redirect URI** укажите полученный у поставщика услуг адрес.
     
         Используйте кнопку **Добавить URI**, чтобы указать одновременно несколько адресов Redirect URI.
     1. В поле **Scopes** выберите набор атрибутов пользователей, которые будут доступны поставщику услуг:
     
         * `openid (идентификатор пользователя)` — идентификатор пользователя. Обязательный параметр.
         * `email (адрес электронной почты)` — адрес электронной почты пользователя.
         * `profile (полное имя, имя, фамилия, аватар и др.)` — дополнительная информация о пользователе.
         * `groups (группы пользователя в организации)` — [группы пользователей](../../concepts/groups.md) организации, участником которых является аутентифицирующийся пользователь. Возможные значения:
         
             * `Все группы` — поставщику услуг будут переданы все группы, в которые входит пользователь.
         
                 Максимальное количество передаваемых групп — 1&nbsp;000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп. 
             * `Только назначенные группы` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые явно заданы на вкладке **Пользователи и группы** OIDC-приложения.
     
     1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для настройки OAuth-клиента:

     ```bash
     yc iam oauth-client update --help
     ```

  1. Выполните команду:

     ```bash
     yc iam oauth-client update \
       --id <идентификатор_OAuth-клиента> \
       --new-name <новое_имя_OAuth-клиента> \
       --redirect-uris <адрес>[,<адрес>] \
       --scopes <атрибут>[,<атрибут>]
     ```

     Где:

     * `--id` — идентификатор OAuth-клиента.
     * `--new-name` — новое имя OAuth-клиента.
     * `--scopes` — новый набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов через запятую в формате `<атрибут1>,<атрибут2>`. Возможные атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `email` — адрес электронной почты пользователя.
       * `address` — место жительства пользователя.
       * `phone` — номер телефона пользователя.
       * `groups` — [группы пользователей](../../concepts/groups.md) в организации.

         {% note warning %}
         
         Новый набор атрибутов пользователей также необходимо указать в [базовых настройках приложения](#update-basic-settings) с помощью параметра `--authorized-scopes`.
         
         {% endnote %}

     * `--redirect-uris` — укажите новые полученные у поставщика услуг адрес или несколько адресов в формате `<адрес1>,<адрес2>`.

     Результат:

     ```text
     id: ajejklv8g9kh********
     name: my-oauth-client
     redirect_uris:
       - https://example2.com
       - https://example2.ru
     scopes:
       - openid
       - profile
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле Terraform измените параметры OAuth-клиента:

    ```hcl
    resource "yandex_iam_oauth_client" "example_oauth_client" {
      oauth_client_id = "<идентификатор_OAuth-клиента>"
      name           = "<новое_имя_OAuth-клиента>"
      redirect_uris  = ["<адрес1>", "<адрес2>"]
      scopes         = ["<атрибут1>", "<атрибут2>"]
    }
    ```

    Где:

    * `oauth_client_id` — идентификатор OAuth-клиента. Обязательный параметр.
    * `name` — новое имя OAuth-клиента. Необязательный параметр.
    * `redirect_uris` — новый список адресов Redirect URI. Укажите один или несколько адресов в квадратных скобках. Необязательный параметр.
    * `scopes` — новый набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов в квадратных скобках. Возможные атрибуты:
      * `openid` — идентификатор пользователя. Обязательный атрибут.
      * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
      * `email` — адрес электронной почты пользователя.
      * `address` — место жительства пользователя.
      * `phone` — номер телефона пользователя.
      * `groups` — группы пользователей в организации.

    Более подробную информацию о параметрах ресурса `yandex_iam_oauth_client` см. в [документации провайдера](../../../terraform/resources/iam_oauth_client.md).

  1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    Проверить изменения ресурсов и их настройки можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../../cli/index.md):

    ```bash
    yc iam oauth-client get <идентификатор_OAuth-клиента>
    ```

- API {#api}

  Воспользуйтесь методом REST API [OAuthClient.Update](../../../iam/api-ref/OAuthClient/update.md) для ресурса [OAuthClient](../../../iam/api-ref/grpc/OAuthClient/index.md) или вызовом gRPC API [OAuthClientService/Update](../../../iam/api-ref/grpc/OAuthClient/update.md).


{% endlist %}

## Измените секрет приложения {#update-secret}

Посмотреть или изменить имеющийся в приложении [секрет](../../concepts/applications.md#oidc-secret) невозможно. Вместо этого вы можете сгенерировать новый секрет:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. В блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
     
     1. (Опционально) Добавьте произвольное описание создаваемого секрета.
     1. Нажмите **Создать**.
     
     В окне отобразится сгенерированный [секрет приложения](../../concepts/applications.md#oidc-secret). Сохраните полученное значение.
     
     {% note warning %}
     
     После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
     
     {% endnote %}
     
     Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
     
     Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Не забудьте указать новый секрет в настройках на стороне поставщика услуг. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания нового секрета OIDC-приложения:

     ```bash
     yc iam oauth-client-secret create --help
     ```

  1. Выполните команду:

     ```bash
     yc iam oauth-client-secret create --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: aje0hjqp68u6********
       oauth_client_id: ajejklv8g9kh********
       masked_secret: yccs__9e1d5f6d5c****
       created_at: "2025-10-23T11:44:50.739768533Z"
     secret_value: yccs__9e1d5f6d5c********
     ```

     Не забудьте указать новый секрет в настройках на стороне поставщика услуг. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле Terraform создайте новый секрет OAuth-клиента:

    ```hcl
    resource "yandex_iam_oauth_client_secret" "example_oauth_client_secret" {
      oauth_client_id = "<идентификатор_OAuth-клиента>"
    }
    ```

    Где:

    * `oauth_client_id` — идентификатор OAuth-клиента, для которого создается новый секрет. Обязательный параметр.

    Более подробную информацию о параметрах ресурса `yandex_iam_oauth_client_secret` см. в [документации провайдера](../../../terraform/resources/iam_oauth_client_secret.md).

  1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    Проверить изменения ресурсов и их настройки можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../../cli/index.md):

    ```bash
    yc iam oauth-client-secret list --oauth-client-id <идентификатор_OAuth-клиента>
    ```


- API {#api}

  Воспользуйтесь методом REST API [OAuthClientSecret.Create](../../../iam/api-ref/OAuthClientSecret/create.md) для ресурса [OAuthClientSecret](../../../iam/api-ref/OAuthClientSecret/index.md) или вызовом gRPC API [OAuthClientSecretService/Create](../../../iam/api-ref/grpc/OAuthClientSecret/create.md).

{% endlist %}

## Измените список пользователей и групп приложения {#users-and-groups}

Измените список пользователей вашей [организации](../../concepts/organization.md), которые могут аутентифицироваться во внешнем приложении с помощью OIDC-приложения:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. Перейдите на вкладку **Пользователи и группы**.
  1. Чтобы добавить в приложение пользователя или группу пользователей:

      1. Нажмите кнопку ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
      1. В открывшемся окне выберите нужного пользователя или группу пользователей.
      1. Нажмите кнопку **Добавить**.
  1. Чтобы удалить пользователя или группу пользователей из приложения:

      1. В списке пользователей и групп в строке с нужным пользователем или группой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
      1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите [идентификатор пользователя](../users-get.md) или [группы пользователей](../group-get-id.md).

  1. Чтобы добавить в приложение пользователя или группу пользователей:
  
     1. Посмотрите описание команды CLI для добавления пользователей в приложение:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments --help
        ```
   
     1. Выполните команду:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments \
          --id <идентификатор_приложения> \
          --subject-id ek0omvvcb9vv********
        ```
   
        Где:
   
        * `--id` — идентификатор приложения.
        * `--subject-id` — идентификатор нужного пользователя или группы пользователей.
   
        Результат:
   
        ```text
        assignment_deltas:
          - action: ADD
            assignment:
              subject_id: ajetvnq2mil8********
        ```

  1. Чтобы удалить пользователя или группу пользователей из приложения:

     1. Посмотрите описание команды CLI для удаления пользователей из приложения:
   
        ```bash
        yc organization-manager idp application oauth application remove-assignments --help
        ```
   
     1. Выполните команду:
   
        ```bash
        yc organization-manager idp application oauth application remove-assignments \
          --id <идентификатор_приложения> \
          --subject-id <идентификатор_пользователя>
        ```
   
        Где:
   
        * `--id` — идентификатор OIDC-приложения.
        * `--subject-id` — идентификатор нужного пользователя или группы пользователей.
   
        Результат:
   
        ```text
        assignment_deltas:
          - action: REMOVE
            assignment:
              subject_id: ajetvnq2mil8********
        ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры назначения пользователей и групп приложению:

      ```hcl
      resource "yandex_organizationmanager_idp_application_oauth_application_assignment" "example_assignment" {
        application_id = "<идентификатор_приложения>"
        subject_id     = "<идентификатор_пользователя_или_группы>"
      }
      ```

      Где:

      * `application_id` — идентификатор OIDC-приложения.
      * `subject_id` — идентификатор нужного пользователя или группы пользователей.

      Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_oauth_application_assignment` смотрите в [документации провайдера](../../../terraform/resources/organizationmanager_idp_application_oauth_application_assignment.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../../cli/index.md):

      ```bash
      yc organization-manager idp application oauth application list-assignments <идентификатор_приложения>
      ```

- API {#api}

  Воспользуйтесь методом REST API [Application.UpdateAssignments](../../idp/application/oauth/api-ref/Application/updateAssignments.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/UpdateAssignments](../../idp/application/oauth/api-ref/grpc/Application/updateAssignments.md).

{% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../concepts/authentication-policy.md).

#### Полезные ссылки {#see-also}

* [Создать OIDC-приложение в Yandex Identity Hub](oidc-create.md)
* [Деактивировать и удалить OIDC-приложение в Yandex Identity Hub](oidc-deactivate-remove.md)
* [Добавить пользователя](../add-account.md)
* [OIDC-приложения](../../concepts/applications.md#oidc)
* [Управление группами пользователей](../manage-groups.md)