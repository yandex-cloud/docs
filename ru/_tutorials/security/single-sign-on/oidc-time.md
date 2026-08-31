# Создать OIDC-приложение в {{ org-full-name }} для интеграции с Time

[Time](https://time-messenger.ru/) — корпоративный мессенджер с поддержкой единого входа по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC).

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Time с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Time.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в Time:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Добавьте пользователей](#add-users).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
        1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `time-oidc-app`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. (Опционально) Добавьте описание и [метки](../../../resource-manager/concepts/labels.md) приложения.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Time с созданным OIDC-приложением в {{ org-full-name }}, выполните настройки на стороне {{ org-full-name }} и на стороне Time.

### Получите учетные данные и создайте секрет приложения {#get-credentials-secret}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `time-oidc-app`.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение параметра **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
    1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

### Настройте OIDC-аутентификацию на стороне Time {#setup-sp}

1. Войдите в системную консоль Time по адресу `https://<имя_инстанса>.time-messenger.ru/admin_console/authentication/openid`, где `<имя_инстанса>` — имя вашего инстанса Time.
1. В разделе **Аутентификация**:
   1. Выберите **OpenID Connect**.
   1. В списке **Выберите провайдера** укажите **Подключение OpenID (Другое)**.
   1. (Опционально) В поле **Название кнопки** укажите текст, который будет отображаться на кнопке входа на странице авторизации, например `Используя OIDC`.
   1. (Опционально) Выберите цвет кнопки входа на странице авторизации.
   1. В поле **Ссылка на поставщика** укажите адрес провайдера OpenID Connect — `https://auth.yandex.cloud`.
   1. В поле **ID клиента** укажите значение **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**, скопированное из {{ org-full-name }}.
   1. В поле **Клиентский ключ** укажите секрет приложения, сгенерированный в {{ org-full-name }}.
1. Сохраните настройки.

### Настройте Redirect URI в {{ org-full-name }} {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `time-oidc-app`.
    1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
        1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите адрес обратного вызова `https://<имя_инстанса>.time-messenger.ru/signup/openid/complete`, где `<имя_инстанса>` — имя вашего инстанса Time (поддомена на `time-messenger.ru`).
        1. {% include [org-oidc-app-disable-pkce](../../../_tutorials/_tutorials_includes/org-oidc-app-disable-pkce.md) %}
        1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Добавьте пользователей {#add-users}

Для аутентификации в Time, добавьте в OIDC-приложение {{ org-full-name }} нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% include [oidc-manage-users](../../../_includes/organization/oidc-manage-users.md) %}

Чтобы добавить пользователей в SAML-приложение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `time-oidc-app`.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите нужных пользователей.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить корректность работы OIDC-приложения и интеграции с Time, выполните вход в Time под учетной записью одного из добавленных пользователей. Для этого:

1. В браузере откройте страницу входа вашего инстанса Time: `https://<имя_инстанса>.time-messenger.ru`.
1. Выберите вход через OpenID Connect.
1. Аутентифицируйтесь в {{ yandex-cloud }} под учетной записью пользователя из вашей организации.
1. Убедитесь, что после успешной аутентификации вы вошли в Time.
