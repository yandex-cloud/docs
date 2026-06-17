# Создать OIDC-приложение в {{ org-full-name }} для интеграции с Jenkins

[Jenkins](https://www.jenkins.io/) — программная система с открытым исходным кодом на Java, предназначенная для обеспечения процесса непрерывной интеграции программного обеспечения.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Jenkins с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications.md#oidc) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Jenkins.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

{% note info %}

Для интеграции с помощью OIDC для вашего экземпляра Jenkins должен быть настроен публичный домен и корректный SSL-сертификат.

{% endnote %}

Чтобы дать доступ пользователям вашей организации в Jenkins:

1. [Создайте приложение в {{ org-full-name }}](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение в {{ org-full-name }} {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `jenkins-oidc`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

         1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. В открывшемся окне на вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте и сохраните значение параметров `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` и `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`.
   1. Создайте [секрет приложения](../../../organization/concepts/applications.md#oidc-secret):

      {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Установите плагин OIDC в Jenkins {#install-oidc-plugin}

Чтобы настроить аутентификацию в Jenkins с помощью OIDC, установите плагин OIDC:

1. Войдите в Jenkins под пользователем с правами администратора.
1. В меню слева выберите **Manage Jenkins** > **Plugins**.
1. Перейдите на вкладку **Available** и в строке поиска введите `OpenId Connect Authentication`.
1. Найдите плагин [**OpenId Connect Authentication**](https://plugins.jenkins.io/oic-auth) и установите его, нажав **Install**.
1. Дождитесь завершения установки и перезапустите Jenkins, если это потребуется.

После установки плагина в разделе **Manage Jenkins** > **Security** появится новый вариант **Security Realm** – `Login with Openid Connect`.

### Настройте OIDC-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите эндпоинт аутентификации для тестового приложения `<адрес_инстанса_jenkins>/securityRealm/finishLogin`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Настройте аутентификацию на стороне Jenkins {#setup-sp}

1. Войдите в Jenkins под пользователем с правами администратора.
1. В меню слева выберите **Manage Jenkins** > **Security**.
1. В разделе **Security Realm** выберите `Login with Openid Connect`.
1. В поле **Client id** введите значение, скопированное при настройке OIDC-приложения в {{ org-full-name }} в поле **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
1. В поле **Client secret** введите значение, скопированное при настройке OIDC-приложения в {{ org-full-name }} в блоке **{{ ui-key.yacloud_org.application.overview.secret_section_title }}**.
1. В поле **Well-known configuration endpoint** введите URL, скопированный при настройке OIDC-приложения в {{ org-full-name }} в поле **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}**.
1. Нажмите **Advanced** и в поле **Override scopes** введите `openid email profile`.
1. Нажмите **User fields** и заполните поля:
   - **User name field name**: `preferred_username`
   - **Full name field name**: `name`
   - **Email field name**: `email`
1. Нажмите **Save**.

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Jenkins с помощью OIDC-приложения {{ org-full-name }}, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.

{% endnote %}

1. Добавьте пользователей в приложение:

   {% list tabs group=instructions %}

   - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
      1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
      1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
      1. В открывшемся окне выберите нужного пользователя или группу пользователей.
      1. Нажмите **{{ ui-key.yacloud.common.add }}**.

   {% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с Jenkins, выполните аутентификацию в Jenkins от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Jenkins.
1. Вы будете перенаправлены на страницу аутентификации {{ yandex-cloud }}. Укажите почту и пароль пользователя, которого вы добавили в приложение. Также у пользователя должна быть указана почта.
1. Убедитесь, что вы аутентифицировались в Jenkins.