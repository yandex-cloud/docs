# Создать SAML-приложение в {{ org-full-name }} для интеграции с Sentry

[Sentry](https://sentry.io/) — это платформа для мониторинга и отслеживания ошибок в реальном времени в приложениях, позволяющая разработчикам оперативно обнаруживать, диагностировать и исправлять сбои и проблемы с производительностью.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Sentry с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Sentry.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

{% note info %}

Для интеграции с помощью SAML для вашего экземпляра Sentry должен быть настроен публичный домен и корректный SSL-сертификат.

{% endnote %}

Чтобы дать доступ пользователям вашей организации в Sentry:

1. [Создайте приложение в {{ org-full-name }}](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение в {{ org-full-name }} {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `sentry-app`.

      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

         1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. Сохраните значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}**, оно понадобится на следующем шаге.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Найдите слаг организации {#get-org-slug}

Для настройки эндпоинтов вам понадобится слаг организации (Organization Slug), по умолчанию имеет значение `sentry`. Чтобы найти слаг вашей организации:

1. Войдите в Sentry.
1. В меню слева нажмите кнопку **Settings**.
1. Во вкладке **Organization** выберите пункт **General Settings**.
1. Скопируйте значение поля **Organization Slug**.

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** вставьте значение `<адрес_инстанса_sentry>/saml/metadata/<слаг_организации>/`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** вставьте значение `<адрес_инстанса_sentry>/saml/acs/<слаг_организации>/`.
      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** вставьте значение `<адрес_инстанса_sentry>/saml/sls/<слаг_организации>/`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Настройте аутентификацию на стороне Sentry {#setup-sp}

1. Войдите в Sentry под пользователем с правами владельца организации.
1. В меню слева нажмите кнопку **Settings**.
1. Во вкладке **Organization** выберите пункт **Auth**.
1. В списке провайдеров выберите **SAML2**.
1. Нажмите **Configure**.
1. В поле **Metadata URL** введите адрес файла с метаданными, скопированный ранее.
1. Нажмите **Get metadata**.
1. В разделе **Map Identity Provider Attributes** заполните поля:
   * В поле **IdP User ID** введите `fullname`.
   * В поле **User Email** введите `emailaddress`.
   * (Опционально) В поле **First Name** введите `givenname`.
   * (Опционально) В поле **Last Name** введите `surname`.
1. Нажмите **Save Settings**.

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Sentry с помощью SAML-приложения {{ org-full-name }}, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

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

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Sentry, выполните аутентификацию в Sentry от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Sentry.
1. На странице аутентификации нажмите **Login with SAML2**.
1. На странице аутентификации {{ yandex-cloud }} укажите почту и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение. Также у пользователя должна быть указана почта.
1. Убедитесь, что вы аутентифицировались в Sentry.