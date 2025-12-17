# Создать OIDC-приложение в {{ org-full-name }} для интеграции с Grafana OSS

{% include [note-preview](../../../_includes/note-preview.md) %}

[Grafana Open Source Software (OSS)](https://grafana.com/oss/) — это бесплатная платформа с открытым исходным кодом для мониторинга и визуализации данных, которую можно развернуть на собственной инфраструктуре. Grafana OSS поддерживает OpenID Connect (OIDC) аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Grafana OSS с помощью технологии единого входа по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID_Connect), создайте [OIDC-приложение](../../../organization/concepts/applications.md#oidc) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне Grafana OSS.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в Grafana OSS:

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
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `grafana-oss-oidc-app`.
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
       --name grafana-oss-oauth-client \
       --scopes openid,email,profile,groups
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны Grafana OSS. Указаны атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `email` — адрес электронной почты пользователя.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `groups` — [группы пользователей](../../../organization/concepts/groups.md) в организации.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: grafana-oss-oauth-client
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

     Сохраните значение поля `secret_value`, оно понадобится для настройки Grafana OSS.
  
  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name grafana-oss-oidc-app \
       --description "OIDC-приложение для интеграции с Grafana OSS" \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes openid,email,profile,groups \
       --group-distribution-type assigned-groups
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../../../organization/operations/organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `--name` — имя OIDC-приложения. Обязательный параметр.
     * `--description` — описание OIDC-приложения. Необязательный параметр.
     * `--client-id` — идентификатор OAuth-клиента, полученный на втором шаге. Обязательный параметр.
     * `--authorized-scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `--group-distribution-type` — укажите `assigned-groups`, чтобы передавать в Grafana OSS только группы, добавленные в приложение.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: grafana-oss-oidc-app
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
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Grafana OSS с созданным OIDC-приложением в {{ org-name }}, выполните настройки на стороне Grafana OSS и на стороне {{ org-name }}.

### Настройте OIDC-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** разверните секцию **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** и скопируйте значения параметров, которые необходимо задать на стороне Grafana OSS:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` — уникальный идентификатор приложения.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` — URL с конфигурацией всех необходимых для настройки интеграции параметров.

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
     name: grafana-oss-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
         - groups
     ```

     Сохраните значение `client_id` — это Client ID для настройки Grafana OSS.

  1. Получите URL с конфигурацией OpenID Connect Discovery:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     Результат будет выглядеть так:

     ```text
     https://{{ auth-main-host }}/oauth/<идентификатор_OAuth-клиента>
     ```

     Сохраните этот URL — это OpenID Connect Discovery URL для настройки Grafana OSS.

  1. Используйте секрет OAuth-клиента, который был сохранен при создании приложения на предыдущем шаге. Если вы не сохранили секрет, создайте новый:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Сохраните значение `secret_value` из результата команды — это Client Secret для настройки Grafana OSS.

{% endlist %}

#### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите эндпоинт аутентификации для вашего экземпляра Grafana OSS в формате:

         ```text
         <URL_экземпляра_Grafana_OSS>/login/generic_oauth
         ```

      1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** отметьте атрибут `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}` и выберите `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.

      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Обновите OIDC-приложение, указав Redirect URI:

  ```bash
  yc organization-manager idp application oauth application update <идентификатор_приложения> \
    --redirect-uris "<URL_экземпляра_Grafana_OSS>/login/generic_oauth"
  ```

  Где:
  
  * `<идентификатор_приложения>` — ID OIDC-приложения, полученный при создании.
  * `--redirect-uris` — эндпоинт аутентификации для вашего экземпляра Grafana OSS. Например: `https://your-domain/login/generic_oauth`.

  Результат:

  ```text
  id: ek0o663g4rs2********
  name: grafana-oss-oidc-app
  organization_id: bpf2c65rqcl8********
  redirect_uris:
    - https://your-domain/login/generic_oauth
  ```

{% endlist %}

### Настройте OIDC-приложение на стороне Grafana OSS {#setup-sp}

Чтобы настроить аутентификацию по стандарту OpenID Connect на стороне Grafana OSS, в левой панели выберите раздел **Administration** и в нем подраздел **Authentication**. В основном окне выберите **Generic OAuth**.

В настройках Generic OAuth:

1. В поле **Display name** укажите: `OpenID Connect`.
1. В поле **Client ID** укажите значение, скопированное при настройке OIDC-приложения в {{ org-name }} в поле **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
1. В поле **Client Secret** укажите значение, скопированное при настройке OIDC-приложения в {{ org-name }} в блоке **{{ ui-key.yacloud_org.application.overview.secret_section_title }}**.
1. В поле **Scopes** введите последовательно: `openid`, `email`, `profile`, `groups`.
1. Нажмите **Enter OpenID Connect Discovery URL** и в открывшемся окне укажите URL, скопированный при настройке OIDC-приложения в {{ org-name }} в поле **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}**.
1. **Allow sign up**: активируйте для автоматического создания пользователей при первом входе.

#### Настройте сопоставление ролей {#role-mapping}

{% note info %}

Для сопоставления ролей в Grafana OSS используются JMESPath выражения. См. [примеры использования JMESPath выражений в документации Grafana](https://grafana.com/docs/grafana/latest/setup-grafana/configure-access/configure-authentication/generic-oauth/#role-mapping-examples).

{% endnote %}

1. Разверните секцию **User mapping**.
1. В поле **Role attribute path** введите JMESPath выражение для сопоставления ролей.

Если пользователю, который находится в группе `grafana-users`, нужно сопоставить роль `Editor`, то в поле **Role attribute path** нужно ввести следующее выражение:

```text
contains(groups[*], 'grafana-users') && 'Editor' || 'Viewer'
```

Выражение означает, что если пользователь принадлежит группе `grafana-users`, ему будет назначена роль `Editor`, иначе — роль `Viewer`.

#### Настройте Redirect URI на стороне Grafana OSS {#setup-redirect-grafana}

Необходимо, чтобы Redirect URI, который вы ранее указали на стороне {{ org-full-name }}, и URI, который Grafana OSS отправляет в {{ org-full-name }}, совпадали.

Для этого:

1. Откройте [конфигурационный файл Grafana](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#configuration-file-location).
1. В секции `[server]` установите:

   ```text
   root_url = https://your-domain
   ```

1. [Перезапустите](https://grafana.com/docs/grafana/latest/setup-grafana/start-restart-grafana/) Grafana OSS.

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Grafana OSS с помощью OIDC-приложения {{ org-name }}, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

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

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с Grafana OSS, выполните аутентификацию в Grafana OSS от имени одного из добавленных в приложение пользователей.

Для этого:

1. В браузере перейдите по адресу вашего экземпляра Grafana OSS (например, `https://your-domain`).
1. Если вы были авторизованы в Grafana OSS, выйдите из профиля.
1. На странице авторизации Grafana OSS нажмите **Sign in with OpenID Connect**.
1. На странице авторизации {{ yandex-cloud }} укажите email и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы авторизовались в Grafana OSS.
1. Если вы настроили сопоставление ролей, перейдите в профиль пользователя в Grafana OSS и убедитесь, что в блоке Organizations отображается соответствующая роль.