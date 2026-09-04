# Создать SAML-приложение в {{ org-full-name }} для интеграции с LibreChat

[LibreChat](https://www.librechat.ai/) — это бесплатная платформа с открытым исходным кодом для удобной работы с [большими языковыми моделями](../../../glossary/llm.md), AI-агентами и [MCP-серверами](../../../glossary/mcp.md), которую можно развернуть в собственной инфраструктуре. LibreChat поддерживает стандарт [SAML](https://ru.wikipedia.org/wiki/SAML) для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в LibreChat с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications/saml.md) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне LibreChat.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

{% note info %}

Для успешной интеграции по стандарту SAML доступ к вашему экземпляру LibreChat должен быть настроен по протоколу `https` с использованием корректного TLS-сертификата.

{% endnote %}

Чтобы предоставить пользователям вашей организации доступ в LibreChat:

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
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `librechat-saml-app`.
      1. (Опционально) Задайте описание и добавьте [метки](../../../resource-manager/concepts/labels.md) приложения.
      1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
  1. На открывшейся странице вновь созданного приложения:
  
      1. В блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте и сохраните значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**, оно понадобится при настройке интеграции на стороне LibreChat.
      1. В блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}**, чтобы получить сертификат вашего SAML-приложения.

          Скопируйте полученный файл сертификата на сервер, на котором развернут ваш экземпляр LibreChat.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию LibreChat с созданным SAML-приложением, выполните настройки на стороне {{ org-full-name }} и на стороне LibreChat.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Настройте эндпоинты поставщика услуг. Для этого справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите любое значение, например адрес вашего экземпляра LibreChat: `https://librechat.example.com`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите адрес `https://<адрес_экземпляра_LibreChat>/oauth/saml/callback`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Настройте сопоставление для атрибута `username`, который будет использоваться в качестве имени пользователя при аутентификации в LibreChat. Для этого:

      1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
      1. В правом верхнем углу страницы нажмите ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** и в открывшемся окне:

          1. В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** введите `username`.
          1. В поле **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** выберите `SubjectClaims.preferred_username`.
          1. Нажмите **{{ ui-key.yacloud.common.add }}**.

      Подробнее о настройке атрибутов смотрите в разделе [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

{% endlist %}

### Настройте аутентификацию на стороне LibreChat {#setup-sp}

На хосте, на котором развернут ваш экземпляр LibreChat, в среде его выполнения задайте следующие переменные окружения, определяющие параметры интеграции LibreChat с SAML-приложением:

Имя переменной | Значение
--- | ---
`SAML_ENTRY_POINT` | Значение `{{ ui-key.yacloud_org.application.overview.saml_field_login }}`, сохраненное [ранее](#create-app).
`SAML_ISSUER` | Значение `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}`, заданное [ранее](#setup-idp) на стороне {{ org-full-name }}.</br></br>Например: `https://librechat.example.com`.
`SAML_CERT` | Локальный путь к файлу сертификата SAML-приложения, сохраненному [ранее](#create-app), в среде выполнения вашего экземпляра LibreChat.</br></br>Например: `"/app/saml-certs/librechat-saml-app.cer"`.
`SAML_CALLBACK_URL` | `"https://<адрес_экземпляра_LibreChat>/oauth/saml/callback"`
`SAML_SESSION_SECRET` | Дополнительный секрет, используемый для защиты сессий.</br></br>Самостоятельно сгенерируйте надежный секрет длиной не менее 32 символов.
`SAML_EMAIL_CLAIM` | `"emailaddress"`
`SAML_USERNAME_CLAIM` | `"username"`
`SAML_GIVEN_NAME_CLAIM` | `"givenname"`
`SAML_FAMILY_NAME_CLAIM` | `"surname"`
`SAML_NAME_CLAIM` | `"fullname"`
`SAML_BUTTON_LABEL` | `"Login with {{ org-full-name}}"`

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в LibreChat с помощью SAML-приложения {{ org-full-name }}, добавьте в SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md):

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

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

Чтобы убедиться в корректной работе SAML-приложения и интеграции с LibreChat, выполните аутентификацию в LibreChat от имени одного из добавленных в приложение пользователей. Для этого:

1. В окне браузера откройте страницу входа в ваш экземпляр LibreChat.
1. Выберите вход через {{ org-full-name }}.
1. Аутентифицируйтесь в {{ yandex-cloud }} с учетной записью пользователя вашей организации, добавленного в SAML-приложение.
1. Убедитесь, что вы успешно аутентифицировались в LibreChat.
