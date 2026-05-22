# Создать OIDC-приложение в {{ org-full-name }} для интеграции с MWS


[МТС Web Services (MWS)](https://mws.ru/) — это экосистема сервисов и платформенных решений для построения IT-инфраструктуры и управления ею. MWS поддерживает [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в MWS с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications.md#oidc) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне MWS.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в MWS:

1. [Создайте аккаунт в MWS](#mws-account).
1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте аккаунт в MWS {#mws-account}

Если у вас нет аккаунта в MWS, создайте его:

1. На [странице входа в консоль MWS](https://console.mws.ru/) нажмите кнопку **Войти через МТС ID**.
1. Создайте аккаунт МТС ID:
    * Введите номер телефона. Номер будет привязан к аккаунту, и его нельзя будет заменить.
    * Введите код подтверждения из СМС.
1. Создайте аккаунт MWS:
    * Введите email, который будет привязан к вашему аккаунту MWS.
    * Нажмите кнопку **Далее**.
    * Подтвердите регистрацию, перейдя в письме по ссылке **Подтвердить почту**.
    * Примите условия пользовательского соглашения и нажмите кнопку **Войти в консоль**.
1. В меню слева перейдите в **Организация**, затем в **Об организации**.
1. Сохраните ID вашей организации MWS (например, `organization-test`), который потребуется для настройки интеграции.

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `mws-oidc-app`.
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
       --name mws-oauth-client \
       --scopes openid,email,profile
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны MWS. Указаны атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `email` — адрес электронной почты пользователя.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: mws-oauth-client
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

     Сохраните значение поля `secret_value`, оно понадобится для настройки MWS.
  
  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name mws-oidc-app \
       --description "OIDC-приложение для интеграции с MWS" \
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
     * `--group-distribution-type` — укажите `none`, так как группы пользователей не передаются в MWS.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: mws-oidc-app
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

Чтобы настроить интеграцию MWS с созданным OIDC-приложением в {{ org-full-name }}, выполните настройки на стороне MWS и на стороне {{ org-full-name }}.

### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** разверните секцию **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** и скопируйте значение параметра **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**, которое необходимо задать на стороне MWS.
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
     name: mws-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     ```

     Сохраните значение `client_id` — это Client ID для настройки MWS.

  1. Используйте секрет OAuth-клиента, который был сохранен при создании приложения на предыдущем шаге. Если вы не сохранили секрет, создайте новый:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Сохраните значение `secret_value` из результата команды — это Client Secret для настройки MWS.

{% endlist %}

### Настройте приложение на стороне MWS {#setup-sp}

Чтобы настроить аутентификацию по стандарту OIDC на стороне MWS, вам потребуется создать и настроить [федерацию](https://mws.ru/docs/cloud-platform/org-rm/general/federation-overview.html), а затем настроить OIDC-клиент на стороне MWS.

#### Настройте федерацию {#setup-federation}

1. Войдите в [консоль вашей организации](https://org.mws.ru).
1. В левой панели выберите раздел **Федерации**.
1. Нажмите кнопку **Создать**.
1. Настройте федерацию:
    1. Задайте имя федерации. Сохраните ID федерации (например, `federation-test`), который потребуется для настройки интеграции.
    1. (Опционально) Выберите роли, которые будут назначены пользователям, авторизованным через федерацию.

        {% note info %}

        Подробнее о настройке ролей федеративных пользователей вы можете прочитать [в документации MWS](https://mws.ru/docs/cloud-platform/org-rm/general/federation-roles.html).

        {% endnote %}

    1. Укажите время сессии, по истечении которой пользователю необходимо будет повторно авторизоваться.
    1. (Опционально) Введите описание федерации.
1. Нажмите кнопку **Создать**.

#### Настройте OIDC-клиент {#setup-provider}

1. После создания федерации нажмите кнопку **Добавить IdP**.
1. (Опционально) Введите описание провайдера.
1. Нажмите кнопку **Далее**.
1. В поле **Issuer** введите `https://{{ auth-main-host }}`, затем нажмите кнопку **Загрузить**. Конфигурация заполнится автоматически.
1. В поле **Client ID** введите значение, скопированное ранее из поля **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
1. В поле **Client Secret** введите сгенерированный ранее секрет приложения.
1. В блоке **Способ получения данных** выберите значение **Token Endpoint и UserInfo Endpoint** и нажмите **Далее**.
1. Напротив атрибута `mws.subject` в поле **IdP** введите `preferred_username` и нажмите **Далее**.
1. Проверьте конфигурацию и нажмите **Создать**.
1. После завершения настройки снова выберите добавленный IdP в разделе **Федерации**, после чего сохраните ID провайдера (например, `-testprov`), который потребуется для настройки интеграции.

### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите эндпоинт аутентификации для вашей федерации MWS в формате:

          ```text
          https://auth.mws.ru/api/iam/v1/organizations/<идентификатор_организации>/userFederations/<идентификатор_созданной_федерации>/providers/<идентификатор_провайдера>/login-callback
          ```

          Например: 

          ```text
          https://auth.mws.ru/api/iam/v1/organizations/organization-test/userFederations/federation-test/providers/-testprov/login-callback
          ```

      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Обновите OAuth-клиент, указав Redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <идентификатор_OAuth-клиента> \
    --redirect-uris "https://auth.mws.ru/api/iam/v1/organizations/<идентификатор_организации>/userFederations/<идентификатор_созданной_федерации>/providers/<идентификатор_провайдера>/login-callback"
  ```

  Где:
  
  * `<идентификатор_OAuth-клиента>` — идентификатор OAuth-клиента, полученный при его создании.
  * `--redirect-uris` — эндпоинт аутентификации для вашей федерации MWS. Например: 

     ```text
     https://auth.mws.ru/api/iam/v1/organizations/organization-test/userFederations/federation-test/providers/-testprov/login-callback
     ```

  Результат:

  ```text
  id: ajeiu3otac08********
  name: mws-oidc-app
  redirect_uris:
    - https://auth.mws.ru/api/iam/v1/organizations/organization-test/userFederations/federation-test/providers/-testprov/login-callback
  scopes:
    - openid
    - email
    - profile
  folder_id: b1gkd6dks6i1********
  status: ACTIVE
  ```

{% endlist %}

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в MWS с помощью OIDC-приложения {{ org-full-name }}, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.

{% endnote %}

Добавьте пользователя в приложение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите нужного пользователя или группу пользователей.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md) или [группы пользователей](../../../organization/operations/group-get-id.md).

  1. Чтобы добавить в приложение пользователя или группу пользователей:
   
     1. Посмотрите описание команды CLI для добавления пользователей в приложение:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments --help
        ```
   
     1. Выполните команду:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments \
          --id <идентификатор_приложения> \
          --subject-id <идентификатор_пользователя_или_группы>
        ```
   
        Где:
   
        * `--id` — идентификатор OIDC-приложения.
        * `--subject-id` — идентификатор нужного пользователя или группы пользователей.
   
        Результат:
   
        ```text
        assignment_deltas:
          - action: ADD
            assignment:
              subject_id: ajetvnq2mil8********
        ```

{% endlist %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с MWS, выполните аутентификацию в MWS от имени одного из добавленных в приложение пользователей.

Для этого:

1. В браузере перейдите в [консоль вашей организации](https://org.mws.ru).
1. В левой панели выберите раздел **Федерации**.
1. Выберите добавленный ранее IdP.
1. На странице провайдера скопируйте из секции **Основное** значение **Sign In URL**. Это ссылка для входа в консоль MWS в качестве пользователя федерации.
1. Выйдите из профиля MWS.
1. Введите в адресную строку браузера скопированную ссылку и перейдите по ней.
1. На странице аутентификации {{ yandex-cloud }} укажите email и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Прочитайте и примите условия использования, затем нажмите **Далее**.
1. Убедитесь, что вы аутентифицировались в MWS.