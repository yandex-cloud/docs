# Создать OIDC-приложение в {{ org-full-name }} для интеграции с Cloud.ru

[Cloud.ru](https://cloud.ru/) — российский провайдер облачных услуг, предоставляющий IaaS- и PaaS-сервисы, инструменты для AI/ML-разработки, а также решения для публичных, частных и гибридных облаков с поддержкой миграции и эксплуатации ИТ-инфраструктуры. Cloud.ru поддерживает [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Cloud.ru с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications.md#oidc) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Cloud.ru.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в Cloud.ru:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `cloud-ru-oidc-app`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application create --help
     ```

  1. Создайте OAuth-клиент:

     ```bash
     yc iam oauth-client create \
       --name cloud-ru-oauth-client \
       --scopes openid,email,profile
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны Cloud.ru. Указаны атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `email` — адрес электронной почты пользователя.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: cloud-ru-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
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
       created_at: "2025-10-21T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Сохраните значение поля `secret_value`, оно понадобится для настройки Cloud.ru.

  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name cloud-ru-oidc-app \
       --description "OIDC-приложение для интеграции с Cloud.ru" \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes openid,email,profile \
       --group-distribution-type none
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../../../organization/operations/organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `--name` — имя OIDC-приложения. Обязательный параметр.
     * `--description` — описание OIDC-приложения. Необязательный параметр.
     * `--client-id` — идентификатор OAuth-клиента, полученный на втором шаге. Обязательный параметр.
     * `--authorized-scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `--group-distribution-type` — укажите `none`, так как группы пользователей не передаются в Cloud.ru.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: cloud-ru-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Cloud.ru с созданным OIDC-приложением в {{ org-full-name }}, выполните настройки на стороне Cloud.ru и на стороне {{ org-full-name }}.

### Настройте OIDC-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** разверните секцию **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** и скопируйте значения параметров, которые необходимо задать на стороне Cloud.ru:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` — уникальный идентификатор приложения.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` — URL с конфигурацией всех необходимых для настройки интеграции параметров.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_endpoint }}` — URL, на который поставщик услуг будет перенаправлять пользователя для прохождения аутентификации.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_token_endpoint }}` — URL, на который от внешнего приложения поступает запрос на получение ID-токена и токена доступа.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_user_info_endpoint }}` — URL, по которому внешнее приложение может получить атрибуты пользователя.

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите информацию о созданном OIDC-приложении:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения>
     ```

     Где `<идентификатор_приложения>` — это ID OIDC-приложения, полученный при создании.

     В результате вы получите информацию о приложении, включая:

     ```text
     id: ek0o663g4rs2********
     name: cloud-ru-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     ```

     Сохраните значение `client_id` — это Client ID для настройки Cloud.ru.

  1. Получите URL с конфигурацией OpenID Connect Discovery:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     Результат будет выглядеть так:

     ```text
     https://{{ auth-main-host }}/oauth/<идентификатор_OAuth-клиента>
     ```

     Сохраните этот URL — это OpenID Connect Discovery URL для настройки Cloud.ru.

  1. Используйте секрет OAuth-клиента, который был сохранен при создании приложения на предыдущем шаге. Если вы не сохранили секрет, создайте новый:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Сохраните значение `secret_value` из результата команды — это Client Secret для настройки Cloud.ru.

{% endlist %}

### Настройте OIDC-приложение на стороне Cloud.ru {#setup-sp}

1. Войдите в [консоль](https://console.cloud.ru/) Cloud.ru.
1. Перейдите в раздел **Администрирование**, на вкладку **Федерации**.
1. Нажмите **Создать федерацию** и выберите тип протокола **OpenID**.
1. Заполните название и описание федерации.
1. Задайте длительность сессии.
    
    {% note info %}

    Максимальное время жизни сессии SSO — от 30 минут до 7 дней. При отсутствии активности сессия автоматически завершается, после чего требуется повторная аутентификация.

    {% endnote %}

1. Заполните поля, используя значения из настройки OIDC‑приложения в {{ org-full-name }}:

    1. **Auth URL** — значение поля **{{ ui-key.yacloud_org.application.overview.oauth_field_auth_endpoint }}**.
    1. **Userinfo URL** — значение поля **{{ ui-key.yacloud_org.application.overview.oauth_field_user_info_endpoint }}**.
    1. **Token URL** — значение поля **{{ ui-key.yacloud_org.application.overview.oauth_field_token_endpoint }}**.
    1. **Logout URL** — значение параметра `end_session_endpoint` из `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`.
    1. **Client ID** — значение поля **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
    1. **Client Secret** — значение блока **{{ ui-key.yacloud_org.application.overview.secret_section_title }}**.
    1. **JWKS URI**  — значение параметра `jwks_uri` из `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`.

1. Нажмите на кнопку **Создать**.
1. В списке федераций найдите созданную федерацию и скопируйте её ID. Сохраните этот идентификатор — он понадобится в дальнейшем.

### Настройте Redirect URI на стороне {{ org-full-name }} {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите  ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите эндпоинт аутентификации для вашего экземпляра Cloud.ru в формате:
      
          ```text
          https://id.cloud.ru/auth/system/idp/<ID_федерации_Cloud.ru>/callback
          ```
          Например: `https://id.cloud.ru/auth/system/idp/5ca1bc33-7e8a-711a-b29a-a8a121eda1cd/callback`.

      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Обновите OAuth-клиент, указав Redirect URI:

     ```bash
     yc iam oauth-client update \
       --id <идентификатор_OAuth-клиента> \
       --redirect-uris "https://id.cloud.ru/auth/system/idp/<ID_федерации_Cloud.ru>/callback"
     ```

     Где:
     
     * `<идентификатор_OAuth-клиента>` — идентификатор OAuth-клиента, полученный при его создании.
     * `--redirect-uris` — эндпоинт аутентификации для вашего экземпляра Cloud.ru. Например: `https://id.cloud.ru/auth/system/idp/5ca1bc33-7e8a-711a-b29a-a8a121eda1cd/callback`.

     Результат:

     ```text
     id: ajeiu3otac08********
     name: cloud-ru-oauth-client
     redirect_uris:
       - https://id.cloud.ru/auth/system/idp/5ca1bc33-7e8a-711a-b29a-a8a121eda1cd/callback
     scopes:
       - openid
       - email
       - profile
     folder_id: b1gkd6dks6i1********
     status: ACTIVE
     ```

{% endlist %}

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в Cloud.ru с помощью OIDC‑приложения {{ org-full-name }}, необходимо явно добавить их учётные записи как в само приложение, так и в федерацию Cloud.ru.

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.

{% endnote %}

#### Добавьте пользователей в OIDC‑приложение {{ org-full-name }} {#add-app-users}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите требуемого пользователя.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md).

  1. Чтобы добавить в приложение пользователя:
   
     1. Посмотрите описание команды CLI для добавления пользователей в приложение:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments --help
        ```
   
     1. Выполните команду:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments \
          --id <идентификатор_приложения> \
          --subject-id <идентификатор_пользователя>
        ```
   
        Где:
   
        * `--id` — идентификатор OIDC-приложения.
        * `--subject-id` — идентификатор нужного пользователя.
   
        Результат:
   
        ```text
        assignment_deltas:
          - action: ADD
            assignment:
              subject_id: ajetvnq2mil8********
        ```

{% endlist %}

{% note alert %}

Убедитесь, что атрибут `email` пользователя заполнен и совпадает с адресом, который будет использован при создании учётной записи в федерации Cloud.ru.

{% endnote %}

#### Добавьте пользователей в федерацию Cloud.ru {#add-cloudru-users}

1. Войдите в [консоль](https://console.cloud.ru/) Cloud.ru.
1. Откройте раздел **Пользователи** и перейдите на вкладку **Федеративные пользователи**.
1. В правом верхнем углу нажмите **Добавить пользователя федерации**.
1. Выберите федерацию, в которую нужно включить пользователя.
1. Укажите email пользователя.
1. Выдайте пользователю необходимые права доступа к проектам и платформам.
1. Нажмите **Добавить**.

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить корректность работы OIDC‑приложения и его интеграцию с Cloud.ru, выполните аутентификацию в Cloud.ru под учётной записью одного из пользователей, добавленных в приложение.

Для этого:

1. В браузере откройте страницу входа в [консоль](https://console.cloud.ru/) Cloud.ru.
1. Если вы были авторизованы, выйдите из профиля.
1. На форме входа нажмите кнопку **SSO**.
1. В появившемся диалоге введите ID созданной вами федерации и нажмите **Войти**.
1. На странице аутентификации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя.
1. Убедитесь, что вы успешно аутентифицировались в Cloud.ru.
