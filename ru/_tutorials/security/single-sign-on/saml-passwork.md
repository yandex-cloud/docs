# Создать SAML-приложение в {{ org-full-name }} для интеграции с Пассворк

[Пассворк](https://passwork.ru/) — это корпоративная платформа, предназначенная для безопасного и надежного хранения секретов (паролей, ключей, токенов и т.п.), управления секретами, а также автоматизации доступа сотрудников организации к секретам. Пассворк поддерживает SAML-аутентификацию для обеспечения безопасного [единого входа](../../../glossary/sso.md) пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Пассворк с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Пассворк.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы предоставить пользователям вашей организации доступ в Пассворк:

1. [Создайте SAML-приложение в {{ org-full-name }}](#create-app).
1. [Настройте интеграцию {{ org-full-name }} с Пассворк](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `passwork-app`.

        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

### Сохраните настройки поставщика удостоверений {#save-idp-settings}

На открывшейся странице с информацией о вновь созданном SAML-приложении `passwork-app` скопируйте и сохраните настройки, необходимые для установления отношений доверия между поставщиком удостоверений и поставщиком услуг на стороне Пассворк:

1. В блоке **{{ ui-key.yacloud_org.application.overview.oauth_idp_section_title }}** скопируйте и сохраните значения следующих полей:

    * **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}**;
    * **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**;
    * **{{ ui-key.yacloud_org.application.overview.saml_field_logout }}**.
1. В блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}**, чтобы скачать сертификат вашего SAML-приложения.

Сохраненные значения понадобятся позднее при настройке интеграции на стороне Пассворк.

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Пассворк с созданным SAML-приложением в {{ org-full-name }}, выполните настройки на стороне Пассворк и на стороне {{ org-full-name }}.

### Настройте SAML-приложение на стороне Пассворк {#setup-sp}

{% note info %}

Настройку SAML-приложения в Пассворк может выполнять пользователь с ролью администратора или владельца аккаунта. 

{% endnote %}

1. Аутентифицируйтесь в аккаунте Пассворк от имени владельца или администратора.
1. В верхней части экрана нажмите **Настройки и пользователи** и в появившемся списке выберите **Настройки SSO**. В открывшемся окне:

    * В блоке **Общие настройки** включите опции:

        * **Включить SSO**;
        * **Автоматически подтверждать новых пользователей из SSO**.
    * В блоке **Атрибуты пользователя** укажите имена [атрибутов](../../../organization/concepts/applications.md#saml-attributes) пользователей:

        * в поле **Атрибут для электронной почты** — `emailaddress`;
        * в поле **Атрибут для полного имени** — `fullname`.
    * В блоке **Поставщик удостоверений → Пассворк** укажите скопированные ранее (в приложении `passwork-app`) и сохраненные значения настроек:

        * в поле **Идентификатор (Entity ID)** укажите значение из поля **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** приложения `passwork-app`;
        * в поле **URL ответа (URL службы обработчика утверждений)** — значение из поля **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**;
        * в поле **URL выхода** — значение из поля **{{ ui-key.yacloud_org.application.overview.saml_field_logout }}**;
        * в поле **Сертификат** вставьте содержимое скачанного в приложении `passwork-app` сертификата.
1. В блоке **Пассворк → Поставщик удостоверений** скопируйте и сохраните значения настроек, необходимые для установления отношений доверия между поставщиком удостоверений и поставщиком услуг на стороне {{ org-full-name }}:

    * **Идентификатор (Entity ID)**;
    * **URL ответа (URL службы обработчика утверждений)**;
    * **URL выхода**.
1. Нажмите кнопку **Сохранить настройки**, чтобы сохранить заданные параметры единого входа.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите созданное ранее SAML-приложение `passwork-app`.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите значение, скопированное ранее из поля **Идентификатор (Entity ID)** на стороне Пассворк.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** — значение, скопированное из поля **URL ответа (URL службы обработчика утверждений)**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** — значение, скопированное из поля **URL выхода**.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Добавьте пользователей в SAML-приложение {{ org-full-name }} {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в Пассворк с помощью SAML-приложения {{ org-full-name }}, необходимо явно добавить в это приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md):

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите нужных пользователей или группы пользователей.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Пассворк, выполните аутентификацию в Пассворк от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Пассворк (например, `https://my-domain.passwork-cloud.ru`).
1. Если вы уже авторизованы в Пассворк, выйдите из профиля.
1. На странице аутентификации Пассворк нажмите **Войти через SSO**.
1. На странице аутентификации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.

    Если вы аутентифицируетесь от имени пользователя с [аккаунтом на Яндексе](../../../iam/concepts/users/accounts.md#passport), пройдите аутентификацию в Яндекс ID удобным вам способом.
1. Задайте мастер-пароль для нового пользователя, добавляемого в Пассворк.
1. Убедитесь, что вы аутентифицировались в Пассворк. В результате новый пользователь появится в настройках вашего экземпляра Пассворк, и вы сможете настраивать для него права на просмотр и управление секретами.