# Создать OIDC-приложение в {{ org-full-name }} для интеграции с Grafana Cloud


{% include [note-preview](../../../_includes/note-preview.md) %}

[Grafana Cloud](https://grafana.com/products/cloud/) — это управляемая облачная платформа для мониторинга и наблюдаемости (observability), которая включает в себя Grafana, Prometheus, Loki и другие инструменты визуализации и анализа данных. Grafana Cloud поддерживает OpenID Connect (OIDC) аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Grafana Cloud с помощью технологии единого входа по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID_Connect), создайте [OIDC-приложение](../../../organization/concepts/applications.md#oidc) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне Grafana Cloud.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в Grafana Cloud:

1. [Создайте аккаунт в Grafana Cloud](#grafana-account).
1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate)

## Создайте аккаунт в Grafana Cloud {#grafana-account}

Если у вас нет аккаунта в Grafana Cloud, создайте его:

1. Перейдите на [страницу регистрации Grafana Cloud](https://grafana.com/auth/sign-up/).
1. Заполните регистрационную форму:
    - Укажите ваш email-адрес.
    - Создайте надежный пароль.
1. Нажмите **Create my account**.
1. Подтвердите регистрацию, следуя инструкциям в письме, отправленном на указанный email.
1. Выберите имя организации (это будет частью URL вашего экземпляра). Например `your-org`.
1. После входа в систему убедитесь, что у вас есть права администратора для настройки OIDC в вашей организации Grafana Cloud.
1. Запишите URL вашего экземпляра Grafana Cloud (например, `https://your-org.grafana.net`), который потребуется для настройки интеграции.

{% note info %}

Для настройки OIDC в Grafana Cloud требуются права администратора организации. Если у вас нет необходимых прав, обратитесь к администратору вашей организации в Grafana Cloud.

{% endnote %}

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `grafana-cloud-oidc-app`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Grafana Cloud с созданным OIDC-приложением в {{ org-name }}, выполните настройки на стороне Grafana Cloud и на стороне {{ org-name }}.

### Настройте OIDC-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** разверните секцию **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** и скопируйте значения параметров, которые необходимо задать на стороне Grafana Cloud:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` — уникальный идентификатор приложения.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` — URL с конфигурацией всех необходимых для настройки интеграции параметров.

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

#### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите  ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите эндпоинт аутентификации для вашего экземпляра Grafana Cloud в форме:

        ```
        <URL_экземпляра_Grafana_Cloud>/login/generic_oauth
        ```

        Например: `https://your-org.grafana.net/login/generic_oauth`.

      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Настройте OIDC-приложение на стороне Grafana Cloud {#setup-sp}

Чтобы настроить аутентификацию по стандарту OpenID Connect на стороне Grafana Cloud, в левой панели выберите раздел **Administration** и в нем подраздел **Authentication**.
В основном окне выберите **Generic OAuth**.

В настройках Generic OAuth:

1. В поле **Name** укажите: `OpenID Connect`.
1. В поле **Scopes** введите последовательно: `openid`, `email`, `profile`.
1. В поле **Client ID** укажите значение, скопированное при настройке OIDC-приложения в {{ org-name }} в поле **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
1. В поле **Client Secret** укажите значение, скопированное при настройке OIDC-приложения в {{ org-name }} в блоке **{{ ui-key.yacloud_org.application.overview.secret_section_title }}**.
1. Нажмите **Enter OpenID Connect Discovery URL** и в открывшемся окне укажите URL, скопированный при настройке OIDC-приложения в {{ org-name }} в поле **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}**.
1. **Allow sign up**: активируйте для автоматического создания пользователей при первом входе.

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Grafana Cloud с помощью OIDC-приложения {{ org-name }}, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

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

{% endlist %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с Grafana Cloud, выполните аутентификацию в Grafana Cloud от имени одного из добавленных в приложение пользователей.

Для этого:

1. В браузере перейдите по адресу вашего экземпляра Grafana Cloud (например, `https://your-org.grafana.net`).
1. Если вы были авторизованы в Grafana Cloud, выйдите из профиля.
1. На странице авторизации Grafana Cloud нажмите  **Sign in with OpenID Connect**.
1. На странице авторизации {{ yandex-cloud }} укажите email и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы авторизовались в Grafana Cloud.
