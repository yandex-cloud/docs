[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Практические руководства](../index.md) > [Настройка единого входа в приложения (SSO)](index.md) > Warpgate

# Создать OIDC-приложение в Yandex Identity Hub для интеграции с Warpgate


[Warpgate](https://warpgate.null.page/) — это [бастион-хост](*bastion-host) с открытым исходным кодом для безопасного доступа к внутренним сервисам по протоколам SSH, HTTP, MySQL, PostgreSQL, Kubernetes, RDP и VNC. Warpgate поддерживает аутентификацию пользователей по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) через внешних поставщиков удостоверений.

Чтобы пользователи вашей [организации](*organization) могли входить в Warpgate через OIDC, создайте [OIDC-приложение](../../concepts/applications/oidc.md) и настройте интеграцию с Warpgate. В этом руководстве вы также настроите передачу [групп пользователей](*users-groups) в Warpgate и сопоставите их с ролями доступа.

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

Чтобы дать пользователям вашей организации доступ в Warpgate:

1. [Создайте OIDC-приложение](#create-app).
1. [Создайте группу пользователей и добавьте в нее пользователей](#create-group).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Создайте OIDC-приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. Нажмите кнопку ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
      1. Выберите метод единого входа (SSO) **OIDC (OpenID Connect)**.
      1. В поле **Тип приложения** выберите тип [Web Application](*web_app_type).
         
         [*web_app_type]: OIDC-приложения типа `Web Application` оптимально подходят для аутентификации пользователей во внешних веб-приложениях, имеющих серверную часть (бэкенд), в которой может безопасно храниться секрет приложения. Подробнее о типах OIDC-приложений читайте в разделе [Типы OIDC-приложений в Yandex Identity Hub](../../concepts/applications/oidc.md#oidc-application-types).
      1. В поле **Имя** укажите `warpgate-oidc-app`.
      1. В поле **Каталог** выберите каталог, в котором будет создан OAuth-клиент для приложения.
      1. (Опционально) В поле **Описание** укажите описание, например `OIDC-приложение для интеграции с Warpgate`.
      1. Нажмите **Создать приложение**.
  1. В созданном приложении справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В поле **Scopes** отметьте атрибут `groups (группы пользователя в организации)` и выберите значение `Только назначенные группы`. По умолчанию в новом OIDC-приложении этот атрибут отключен.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте OAuth-клиент:

     ```bash
     yc iam oauth-client create \
       --name warpgate-oauth-client \
       --scopes openid,email,profile,groups \
       --profile-id web
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны Warpgate. Указаны атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `email` — адрес электронной почты пользователя.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `groups` — [группы пользователей](../../concepts/groups.md) в организации. Понадобятся для сопоставления групп с ролями доступа Warpgate.
     * `--profile-id` — [тип](../../concepts/applications/oidc.md#oidc-application-types) OAuth-клиента (OIDC-приложения). В руководстве создается OAuth-клиент типа `Web Application`.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: warpgate-oauth-client
     folder_id: b1g500m2195v********
     authentication_methods:
       - client_secret_basic
       - client_secret_post
     status: ACTIVE
     profile_id: web
     pkce_required: true
     ```

     Сохраните значение поля `id`, оно понадобится для создания и настройки приложения.

  1. Создайте секрет для OAuth-клиента:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: ajeq9jfrmc5t********
       oauth_client_id: ajeqqip130i1********
       masked_secret: yccs__939233b8ac****
       created_at: "2026-09-12T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Сохраните значение поля `secret_value`, оно понадобится для настройки Warpgate.

  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name warpgate-oidc-app \
       --description "OIDC-приложение для интеграции с Warpgate" \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes openid,email,profile,groups \
       --group-distribution-type assigned-groups
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../../operations/organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `--name` — имя OIDC-приложения. Обязательный параметр.
     * `--description` — описание OIDC-приложения. Необязательный параметр.
     * `--client-id` — идентификатор OAuth-клиента, полученный на предыдущем шаге. Обязательный параметр.
     * `--authorized-scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `--group-distribution-type` — укажите `assigned-groups`, чтобы передавать в Warpgate только группы, добавленные в приложение.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: warpgate-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: ASSIGNED_GROUPS
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
         - groups
     status: ACTIVE
     created_at: "2026-09-12T10:51:28.790866Z"
     updated_at: "2026-09-12T12:37:19.274522Z"
     ```

     Сохраните идентификатор созданного OIDC-приложения.

{% endlist %}

## Создайте группу пользователей и добавьте в нее пользователей {#create-group}

Объедините пользователей, которым нужен одинаковый уровень доступа в Warpgate, в [группу](../../concepts/groups.md) в организации. Затем сопоставьте название группы с ролью доступа Warpgate.

### Создайте группу {#create-group-step}

Создайте группу с названием `warpgate-users`.

Чтобы создать [группу](../../concepts/groups.md), у вас должна быть _минимальная_ [роль](../../security/index.md#organization-manager-editor) `organization-manager.groups.editor` на [организацию](../../concepts/organization.md).

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. На панели слева выберите ![groups](../../../_assets/console-icons/persons.svg) **Группы**.

  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать группу**.

  1. Задайте название и описание [группы](../../concepts/groups.md).

      Название должно быть уникальным в организации и соответствовать требованиям:

      * длина — от 1 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

     1. Нажмите **Добавить метку**.
     1. Введите метку в формате `ключ: значение`.
     1. Нажмите **Enter**.

  1. Нажмите кнопку **Создать группу**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды создания группы пользователей Yandex Identity Hub:

      ```bash
      yc organization-manager group create --help
      ```
  
  1. Чтобы создать группу пользователей в Yandex Identity Hub, выполните команду:

      ```bash
      yc organization-manager group create \
        --name <имя_группы> \
        --organization-id <идентификатор_организации> \
        --description <описание_группы> \
        --labels <ключ>=<значение>
      ```

      Где:

      * `--name` — имя группы пользователей. Обязательный параметр. Название должно быть уникальным в организации и соответствовать требованиям:

        * длина — от 1 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

      * `--organization-id` — [идентификатор](../../operations/organization-get-id.md) организации. Необязательный параметр.
      * `--description` — текстовое описание группы пользователей. Необязательный параметр.
      * `--labels` — список [меток](../../../resource-manager/concepts/labels.md) в формате `<ключ>=<значение>`. Можно указать одну или несколько меток через запятую. Необязательный параметр.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры [группы](../../concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_group" "my-group" {
       name            = "<название_группы>"
       description     = "<описание_группы>"
       organization_id = "<идентификатор_организации>"
     }
     ```

     Где:

     * `name` — название группы. Название должно быть уникальным в организации и соответствовать требованиям:

        * длина — от 1 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

     * `description` — описание группы. Необязательный параметр.
     * `organization_id` — [идентификатор](../../operations/organization-get-id.md) организации, к которой нужно присоединить группу.

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
     yc organization-manager group list \
       --organization-id <идентификатор_организации>
     ```

- API {#api}

    Воспользуйтесь методом REST API [Group.create](../../api-ref/Group/create.md) для ресурса [Group](../../api-ref/Group/index.md) или вызовом gRPC API [GroupService/Create](../../api-ref/grpc/Group/create.md).

{% endlist %}

### Добавьте пользователей в группу {#add-users-to-group}

По [инструкции](../../operations/add-member-group.md) добавьте всех пользователей, которым нужен доступ в Warpgate, в группу `warpgate-users`.

### Добавьте группу в OIDC-приложение {#add-group-to-app}

Чтобы пользователи из группы `warpgate-users` могли входить в Warpgate через созданное OIDC-приложение, а сама группа передавалась в атрибуте `groups`, явно добавьте эту группу в приложение.

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../security/index.md#organization-manager-oauthApplications-userAdmin) `organization-manager.oauthApplications.userAdmin` или выше.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите приложение `warpgate-oidc-app`.
  1. Перейдите на вкладку **Пользователи и группы**.
  1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
  1. В открывшемся окне выберите группу `warpgate-users`.
  1. Нажмите **Добавить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. [Получите идентификатор](../../operations/group-get-id.md) группы `warpgate-users`.
  1. Добавьте группу в приложение:

     ```bash
     yc organization-manager idp application oauth application add-assignments \
       --id <идентификатор_приложения> \
       --subject-id <идентификатор_группы>
     ```

     Где:

     * `--id` — идентификатор OIDC-приложения.
     * `--subject-id` — идентификатор группы `warpgate-users`.

{% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../concepts/authentication-policy.md).

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Warpgate с созданным OIDC-приложением, выполните настройки на стороне Yandex Identity Hub и на стороне Warpgate.

### Получите параметры подключения OIDC-приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите приложение `warpgate-oidc-app`.
  1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** разверните секцию **Дополнительные атрибуты** и сохраните значение параметра **ClientID** — Client ID.
  1. Создайте секрет приложения (действие доступно только для приложений [типа](../../concepts/applications/oidc.md#oidc-application-types) `Web Application`).
     
     Для этого в блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
     
     1. (Опционально) Добавьте произвольное описание создаваемого секрета.
     1. Нажмите **Создать**.
     
         В окне отобразится сгенерированный [секрет приложения](../../concepts/applications/oidc.md#oidc-secret). Сохраните полученное значение.
     
         {% note warning %}
     
         После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
     
         {% endnote %}
     
     Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
     
     Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите информацию о созданном OIDC-приложении:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения>
     ```

     Сохраните значение `client_id` из блока `client_grant` — это Client ID для настройки Warpgate.

  1. Используйте секрет OAuth-клиента, который был сохранен при создании приложения. Если вы не сохранили секрет, создайте новый:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Сохраните значение `secret_value` — это Client Secret для настройки Warpgate.

{% endlist %}

Для Yandex Identity Hub issuer URL имеет вид `https://auth.yandex.cloud`. Он потребуется для настройки Warpgate.

### Настройте Redirect URI {#setup-redirect}

Warpgate использует адрес вида `https://<домен_warpgate>/_warpgate/api/sso/return`, где `<домен_warpgate>` — [внешний домен](https://warpgate.null.page/sso/#external-host) вашего экземпляра Warpgate, заданный в параметре `external_host` конфигурационного файла.

Например, если `external_host: warpgate.example.com`, Redirect URI будет иметь вид:

```text
https://warpgate.example.com/_warpgate/api/sso/return
```

{% note info %}

По умолчанию Warpgate формирует Redirect URI с символом `@` (`/@warpgate/api/sso/return`). Yandex Identity Hub не поддерживает этот символ. Чтобы Warpgate заменил префикс `@warpgate` на `_warpgate`, укажите в конфигурации SSO-провайдера Warpgate параметр `return_url_prefix: _`.

{% endnote %}

Укажите полученный адрес в настройках OAuth-клиента:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите приложение `warpgate-oidc-app`.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В поле **Redirect URI** укажите:

     ```text
     https://<домен_warpgate>/_warpgate/api/sso/return
     ```

  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Обновите OAuth-клиент, указав Redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <идентификатор_OAuth-клиента> \
    --redirect-uris "https://<домен_warpgate>/_warpgate/api/sso/return"
  ```

{% endlist %}

{% note warning %}

Redirect URI в Yandex Identity Hub и Warpgate должны полностью совпадать, включая схему, домен и путь.

{% endnote %}

### Создайте роль доступа в Warpgate {#setup-warpgate-role}

На стороне Warpgate создайте [роль доступа](https://warpgate.null.page/roles/#access-roles), которая будет назначаться пользователям после успешной аутентификации через Yandex Identity Hub:

1. Войдите в Warpgate под учетной записью администратора.
1. В меню перейдите в раздел **Config** → **Access roles**.
1. Нажмите **Add a role**.
1. Задайте имя роли, например `user`, и сохраните изменения.

На следующем шаге укажите название этой роли в параметре `role_mappings` конфигурационного файла Warpgate.

### Настройте SSO-провайдер в конфигурационном файле Warpgate {#setup-warpgate-sso}

{% note info %}

Подробнее о настройке единого входа в Warpgate читайте в [официальной документации Warpgate](https://warpgate.null.page/sso/).

{% endnote %}

Откройте конфигурационный файл Warpgate (`warpgate.yaml`) и добавьте в него провайдер единого входа с типом `custom`:

```yaml
sso_providers:
- name: idh
  auto_create_users: true
  return_url_prefix: _
  return_url_domain: external_host
  label: SSO with Identity Hub
  provider:
    type: custom
    client_id: <client_id_OIDC-приложения>
    client_secret: <секрет_OIDC-приложения>
    issuer_url: https://auth.yandex.cloud
    scopes: ["openid", "profile", "email", "groups"]
    roles_claim: groups
    role_mappings:
      'warpgate-users': 'user'
external_host: <домен_warpgate>
```

Где:

* `name` — идентификатор провайдера.
* `auto_create_users: true` — Warpgate автоматически создает учетные записи для пользователей, впервые авторизованных через Yandex Identity Hub. Имя пользователя берется из атрибута `preferred_username`, а при его отсутствии — из атрибута `email`.
* `return_url_prefix: _` — заменяет символ `@` на `_` в Redirect URI, так как Yandex Identity Hub не поддерживает `@` в этом адресе.
* `return_url_domain: external_host` — Warpgate формирует Redirect URI на основе домена из параметра `external_host`.
* `label` — название кнопки входа на странице аутентификации Warpgate.
* `provider` — параметры OIDC-провайдера:
  * `type: custom` — тип интеграции с произвольным OIDC-совместимым поставщиком удостоверений, в данном случае — с Yandex Identity Hub.
  * `client_id` и `client_secret` — Client ID и секрет OIDC-приложения, полученные [ранее](#get-credentials).
  * `issuer_url` — Issuer URL Yandex Identity Hub: `https://auth.yandex.cloud`.
  * `scopes` — атрибуты пользователя, которые Warpgate запрашивает у Yandex Identity Hub. Должны совпадать с атрибутами, указанными при настройке OIDC-приложения.
  * `roles_claim: groups` — атрибут ID-токена с группами пользователя. Значение `groups` соответствует стандартному атрибуту групп Yandex Identity Hub.
  * `role_mappings` — соответствие между группами Yandex Identity Hub и ролями доступа Warpgate. В примере группа `warpgate-users` сопоставлена с ролью `user`, [созданной ранее](#setup-warpgate-role). Warpgate синхронизирует только роли, указанные в этом параметре, не затрагивая остальные роли пользователя.
* `external_host` — внешний домен экземпляра Warpgate, например `warpgate.example.com`. Должен совпадать с доменом, указанным в Redirect URI OIDC-приложения.

Сохраните файл конфигурации и перезапустите Warpgate, чтобы применить изменения.

## Убедитесь в корректной работе приложения {#validate}

1. Выйдите из Warpgate, если вы уже авторизованы.
1. Откройте страницу входа Warpgate по адресу вашего экземпляра, например `https://warpgate.example.com`.
1. Нажмите кнопку входа с названием из параметра `label`.
1. На странице аутентификации Yandex Cloud войдите под пользователем, который состоит в группе `warpgate-users`.
1. Убедитесь, что после успешной аутентификации браузер возвращается в Warpgate, а пользователь получает доступ к интерфейсу с ролью `user`.
1. При необходимости откройте раздел **Users** в Warpgate и проверьте, что созданному пользователю назначена ожидаемая роль.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы Yandex Identity Hub, [удалите](../../operations/applications/oidc-deactivate-remove.md#delete) OIDC-приложение.

При необходимости также [удалите](../../operations/delete-group.md) созданную группу пользователей `warpgate-users`.

[*bastion-host]: _Бастионный хост_ — отдельная виртуальная машина с публичным IP-адресом в защищаемой инфраструктуре. Она позволяет устанавливать защищенные соединения с другими ресурсами этой инфраструктуры, у которых нет публичных IP-адресов. Подробнее о настройке бастионного хоста читайте в разделе [Создание бастионного хоста](../../../tutorials/routing/bastion.md).

[*organization]: _Организация_ — это высший ресурс в иерархии ресурсной модели Yandex Cloud, который объединяет ресурсы всех остальных сервисов, а также используется для управления пользователями и параметрами их аутентификации и авторизации. Подробнее читайте в разделе [Организация](../../concepts/organization.md).

[*users-groups]: Пользователей Yandex Identity Hub можно объединять в группы, что упрощает управление доступом в Yandex Cloud. Подробнее читайте в разделе [Группы пользователей](../../concepts/groups.md).