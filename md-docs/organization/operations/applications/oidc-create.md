# Создать OIDC-приложение в Yandex Identity Hub


Чтобы пользователи вашей [организации](../../concepts/organization.md) могли аутентифицироваться во внешних приложениях с помощью технологии единого входа по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC), создайте [OIDC-приложение](../../concepts/applications.md#oidc) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне поставщика услуг.

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

{% note info %}

В настоящее время создавать OIDC-приложения [типов](../../concepts/applications.md#oidc-application-types) `Single-Page Application` и `Native Application`, а также управлять такими приложениями можно только в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

{% endnote %}

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
      1. Выберите метод единого входа **OIDC (OpenID Connect)**.
      1. В поле **Тип приложения** выберите [тип](*oidc_app_type) создаваемого приложения:

          * [Web Application](../../concepts/applications.md#oidc-web) — оптимально для аутентификации пользователей во внешних веб-приложениях, имеющих серверную часть (бэкенд);
          * [Single-Page Application](../../concepts/applications.md#oidc-single-page) — оптимально для аутентификации пользователей во внешних приложениях, построенных по технологии [SPA](https://ru.wikipedia.org/wiki/Одностраничное_приложение);
          * [Native Application](../../concepts/applications.md#oidc-native) — оптимально для аутентификации пользователей во внешних мобильных или настольных приложениях, установленных на устройствах пользователей.
      1. В поле **Имя** задайте имя создаваемого приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          * длина — от 1 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. В поле **Каталог** выберите каталог, в котором будет создан OAuth-клиент для приложения.

          OAuth-клиент является необходимым компонентом при создании OIDC-приложения, создается и удаляется одновременно с OIDC-приложением и неразрывно с ним связан.
      1. (Опционально) В поле **Описание** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

          1. Нажмите **Добавить метку**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.
      1. Нажмите кнопку **Создать приложение**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application create --help
     ```

  1. Создайте OAuth-клиент:

     ```bash
     yc iam oauth-client create \
       --name <имя_OAuth-клиента> \
       --scopes <атрибут>[,<атрибут>]
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов через запятую в формате `<атрибут1>,<атрибут2>`. Возможные атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `email` — адрес электронной почты пользователя.
       * `address` — место жительства пользователя.
       * `phone` — номер телефона пользователя.
       * `groups` — [группы пользователей](../../concepts/groups.md) в организации.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: test-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

     Сохраните значение поля `id`, оно понадобится для создания и настройки приложения.

  1. Создайте секрет для OAuth-клиента:

     ```bash
     yc iam oauth-client-secret create --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: ajeq9jfrmc5t********
       oauth_client_id: ajeqqip130i1********
       masked_secret: yccs__939233b8ac****
       created_at: "2025-10-21T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Сохраните значение поля `secret_value`, оно понадобится для [настроек приложения](#setup-application) на стороне поставщика услуг.
  
  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name <имя_приложения> \
       --description <описание_приложения> \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes <атрибут>[,<атрибут>] \
       --group-distribution-type all-groups \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `--name` — имя OIDC-приложения. Обязательный параметр. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       * длина — от 1 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `--description` — описание OIDC-приложения. Необязательный параметр.
     * `--client-id` — идентификатор OAuth-клиента, полученный на втором шаге. Обязательный параметр.
     * `--authorized-scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `--group-distribution-type` — если при создании OAuth-клиента вы указали атрибут `groups`, укажите, какие группы пользователей будут переданы поставщику услуг. Возможные значения:
       * `all-groups` — поставщику услуг будут переданы все группы, в которые входит пользователь.

          Максимальное количество передаваемых групп — 1 000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп.
       * `assigned-groups` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые будут явно [заданы](#users-and-groups).
       * `none` — поставщику услуг не будут переданы группы, в которые входит пользователь.
     * `--labels` — список [меток](../../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

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

  1. Опишите в конфигурационном файле Terraform параметры [OAuth-клиента](../../concepts/applications.md):

     ```hcl
     resource "yandex_iam_oauth_client" "example_oauth_client" {
       name      = "<имя_OAuth-клиента>"
       folder_id = "<идентификатор_каталога>"
       scopes    = ["<атрибут1>", "<атрибут2>"]
     }
     ```

     Где:

     * `name` — имя OAuth-клиента.
     * `folder_id` — идентификатор каталога, в котором будет создан OAuth-клиент.
     * `scopes` — набор атрибутов пользователей, которые будут доступны поставщику услуг. Укажите один или несколько атрибутов в квадратных скобках. Возможные атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `email` — адрес электронной почты пользователя.
       * `address` — место жительства пользователя.
       * `phone` — номер телефона пользователя.
       * `groups` — группы пользователей в организации.

     Подробнее о параметрах ресурса `yandex_iam_oauth_client` читайте в [документации провайдера](../../../terraform/resources/iam_oauth_client.md).

  1. Опишите в конфигурационном файле Terraform параметры [секрета](../../concepts/applications.md#oidc-secret) OAuth-клиента:

     ```hcl
     resource "yandex_iam_oauth_client_secret" "example_oauth_client_secret" {
       oauth_client_id = "<идентификатор_OAuth-клиента>"
     }
     ```

     Где:

     * `oauth_client_id` — идентификатор OAuth-клиента, для которого создается секрет.

     Подробнее о параметрах ресурса `yandex_iam_oauth_client_secret` читайте в [документации провайдера](../../../terraform/resources/iam_oauth_client_secret.md).

  1. Опишите в конфигурационном файле Terraform параметры [OIDC-приложения](../../concepts/applications.md#oidc):

     ```hcl
     resource "yandex_organizationmanager_idp_application_oauth_application" "example_oidc_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<имя_приложения>"
       description     = "<описание_приложения>"
       
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

     * `organization_id` — [идентификатор организации](../organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `name` — имя OIDC-приложения. Обязательный параметр. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       * длина — от 1 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `description` — описание OIDC-приложения. Необязательный параметр.
     * `client_grant` — параметры подключения к OAuth-клиенту:
       * `client_id` — идентификатор OAuth-клиента. Обязательный параметр.
       * `authorized_scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `group_claims_settings` — настройки передачи групп пользователей поставщику услуг:
       * `group_distribution_type` — если при создании OAuth-клиента вы указали атрибут `groups`, укажите, какие группы пользователей будут переданы поставщику услуг. Возможные значения:
         * `ALL_GROUPS` — поставщику услуг будут переданы все группы, в которые входит пользователь.
         * `ASSIGNED_GROUPS` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые будут явно заданы.
         * `NONE` — поставщику услуг не будут переданы группы, в которые входит пользователь.
     * `labels` — список [меток](../../../resource-manager/concepts/labels.md). Необязательный параметр.

     Подробнее о параметрах ресурса `yandex_organizationmanager_idp_application_oauth_application` читайте в [документации провайдера](../../../terraform/resources/organizationmanager_idp_application_oauth_application.md).

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
     yc organization-manager idp application oauth application list --organization-id <идентификатор_организации>
     ```

- API {#api}

  1. Воспользуйтесь методом REST API [OAuthClient.Create](../../../iam/api-ref/OAuthClient/create.md) для ресурса [OAuthClient](../../../iam/api-ref/grpc/OAuthClient/index.md) или вызовом gRPC API [OAuthClientService/Create](../../../iam/api-ref/grpc/OAuthClient/create.md).
  1. Воспользуйтесь методом REST API [OAuthClientSecret.Create](../../../iam/api-ref/OAuthClientSecret/create.md) для ресурса [OAuthClientSecret](../../../iam/api-ref/OAuthClientSecret/index.md) или вызовом gRPC API [OAuthClientSecretService/Create](../../../iam/api-ref/grpc/OAuthClientSecret/create.md).
  1. Воспользуйтесь методом REST API [Application.Create](../../idp/application/oauth/api-ref/Application/create.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Create](../../idp/application/oauth/api-ref/grpc/Application/create.md).  

{% endlist %}

## Настройте приложение {#setup-application}

Чтобы настроить интеграцию внешнего приложения с созданным OIDC-приложением в Yandex Identity Hub, выполните настройки на стороне поставщика услуг и на стороне Yandex Identity Hub.

### Задайте настройки интеграции на стороне поставщика услуг {#setup-sp}

Значения настроек интеграции, которые нужно задать на стороне поставщика услуг, доступны на странице с информацией о приложении в [интерфейсе Cloud Center](https://center.yandex.cloud/organization/apps).

В зависимости от возможностей вашего поставщика услуг вы можете выполнить необходимые настройки вручную или автоматически, указав URL с конфигурацией:

{% list tabs %}

- Настройка вручную

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** разверните секцию **Дополнительные атрибуты** и скопируйте значения параметров, которые необходимо задать на стороне поставщика услуг:

      * `ClientID` — уникальный идентификатор приложения.
      * `Authorization endpoint` — адрес в Yandex Cloud, на который поставщик услуг будет перенаправлять пользователя для прохождения аутентификации.
      * `Token endpoint` — адрес, на который от внешнего приложения поступает запрос на получение ID-токена и токена доступа.
      * `Userinfo endpoint` — адрес, по которому внешнее приложение может получить атрибуты пользователя.

  1. Создайте секрет приложения (действие доступно только для приложений [типа](../../concepts/applications.md#oidc-application-types) `Web Application`):
     
     1. В блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
     
         1. (Опционально) Добавьте произвольное описание создаваемого секрета.
         1. Нажмите **Создать**.
     
     В окне отобразится сгенерированный [секрет приложения](../../concepts/applications.md#oidc-secret). Сохраните полученное значение.
     
     {% note warning %}
     
     После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
     
     {% endnote %}
     
     Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
     
     Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. На стороне поставщика услуг настройте интеграцию с OIDC-приложением Yandex Identity Hub, указав скопированные параметры и сгенерированный секрет (для приложений типа `Web Application`). При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- URL с конфигурацией

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте значение поля **OpenID Configuration**.

      По ссылке доступны значения всех настроек, которые необходимо задать на стороне поставщика услуг (за исключением секрета).
  1. Создайте секрет приложения (действие доступно только для приложений [типа](../../concepts/applications.md#oidc-application-types) `Web Application`):
     
     1. В блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
     
         1. (Опционально) Добавьте произвольное описание создаваемого секрета.
         1. Нажмите **Создать**.
     
     В окне отобразится сгенерированный [секрет приложения](../../concepts/applications.md#oidc-secret). Сохраните полученное значение.
     
     {% note warning %}
     
     После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
     
     {% endnote %}
     
     Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
     
     Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Если ваш поставщик услуг поддерживает конфигурирование приложения с помощью URL с конфигурацией, на стороне поставщика услуг настройте интеграцию с OIDC-приложением Yandex Identity Hub, указав скопированные ссылку и секрет (для приложений типа `Web Application`). При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

{% endlist %}

### Настройте OIDC-приложение на стороне Yandex Identity Hub {#setup-idp}

{% note info %}

В настоящее время создавать OIDC-приложения [типов](../../concepts/applications.md#oidc-application-types) `Single-Page Application` и `Native Application`, а также управлять такими приложениями можно только в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

{% endnote %}

Прежде чем настраивать OIDC-приложение на стороне Yandex Identity Hub, получите адрес (адреса) Redirect URI у вашего поставщика услуг. Затем перейдите к настройкам OIDC-приложения в Yandex Identity Hub:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:
     
     1. В блоке **Конфигурация поставщика услуг (SP)** в поле **Redirect URI** укажите полученный у поставщика услуг адрес.
     
         Используйте кнопку **Добавить URI**, чтобы указать одновременно несколько адресов Redirect URI.
     1. Настройте параметры безопасности OIDC-приложения (действие доступно только для приложений [типа](../../concepts/applications.md#oidc-application-types) `Web Application`):
        
        В блоке **Безопасность OAuth/OIDC**:
        
        * В поле **Authentication methods** выберите нужные [способы](../../concepts/applications.md#secret-delivery) передачи секрета приложения:
        
            * `Client secret basic` — чтобы секрет приложения передавался в HTTP-заголовке `Authorization: Basic`.
            * `Client secret post` — чтобы секрет приложения передавался в теле POST-запроса.
        
            Вы можете выбрать один или одновременно оба способа передачи секрета.
        * Включите опцию **Требовать PKCE**, чтобы приложение Yandex Identity Hub при обмене данными требовало от внешнего приложения использовать расширение безопасности [PKCE](*pkce_info).
        
            Чтобы отказаться от использования этого расширения, отключите опцию **Требовать PKCE**.
     1. В поле **Scopes** выберите набор атрибутов пользователей, которые будут доступны поставщику услуг:
     
         * `openid (идентификатор пользователя)` — идентификатор пользователя. Обязательный параметр.
         * `email (адрес электронной почты)` — адрес электронной почты пользователя.
         * `profile (полное имя, имя, фамилия, аватар и др.)` — дополнительная информация о пользователе.
         * `groups (группы пользователя в организации)` — [группы пользователей](../../concepts/groups.md) организации, участником которых является аутентифицирующийся пользователь. Возможные значения:
         
             * `Все группы` — поставщику услуг будут переданы все группы, в которые входит пользователь.
         
                 Максимальное количество передаваемых групп — 1&nbsp;000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп. 
             * `Только назначенные группы` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые явно заданы на вкладке **Пользователи и группы** OIDC-приложения.
     
     1. Нажмите кнопку **Сохранить**.
     
     [*pkce_info]: PKCE — это расширение безопасности, применяемое в стандарте OAuth 2.0 с целью минимизировать риски перехвата аутентификационных данных. Подробнее читайте в разделе [PKCE](../../concepts/applications.md#pkce).

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
       --redirect-uris <адрес>[,<адрес>]
     ```

     Где:

     * `--id` — идентификатор OAuth-клиента.
     * `--redirect-uris` — укажите полученный у поставщика услуг адрес или несколько адресов в формате `<адрес1>,<адрес2>`.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: test-oauth-client
     redirect_uris:
       - https://example.com
       - https://example.ru
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле Terraform для ресурса `yandex_iam_oauth_client` укажите параметр `redirect_uris`:

     ```hcl
     resource "yandex_iam_oauth_client" "example_oauth_client" {
       name          = "<имя_OAuth-клиента>"
       folder_id     = "<идентификатор_каталога>"

       ...

       redirect_uris = ["<адрес1>", "<адрес2>"]
     }
     ```

     Где:

     * `name` — имя OAuth-клиента.
     * `folder_id` — идентификатор каталога, в котором будет создан OAuth-клиент.
     * `redirect_uris` — укажите полученный у поставщика услуг адрес или несколько адресов в квадратных скобках.

     Подробнее о параметрах ресурса `yandex_iam_oauth_client` читайте в [документации провайдера](../../../terraform/resources/iam_oauth_client.md).

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

### Настройте пользователей и группы {#users-and-groups}

Чтобы пользователи вашей организации могли аутентифицироваться во внешнем приложении с помощью OIDC-приложения Yandex Identity Hub, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../concepts/groups.md):

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../security/index.md#organization-manager-oauthApplications-userAdmin) `organization-manager.oauthApplications.userAdmin` или выше.

{% endnote %}

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

      Подробнее о параметрах ресурса `yandex_organizationmanager_idp_application_oauth_application_assignment` читайте в [документации провайдера](../../../terraform/resources/organizationmanager_idp_application_oauth_application_assignment.md).

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

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с поставщиком услуг, выполните аутентификацию во внешнем приложении от имени одного из добавленных в приложение пользователей.

#### Полезные ссылки {#see-also}

* [Изменить OIDC-приложение в Yandex Identity Hub](oidc-update.md)
* [Деактивировать и удалить OIDC-приложение в Yandex Identity Hub](oidc-deactivate-remove.md)
* [Добавить пользователя](../add-account.md)
* [OIDC-приложения](../../concepts/applications.md#oidc)
* [Управление группами пользователей](../manage-groups.md)

[*oidc_app_type]: Тип OIDC-приложения в Yandex Identity Hub (`Web Application`, `Single-Page Application` и `Native Application`) определяет возможность использования секретов приложения и ряда других настроек. Подробнее читайте в разделе [Типы OIDC-приложений в Yandex Identity Hub](../../concepts/applications.md#oidc-application-types).