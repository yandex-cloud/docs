Настройте параметры безопасности OIDC-приложения (действие доступно только для приложений [типа](../../organization/concepts/applications/oidc.md#oidc-application-types) `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}`):

В блоке **{{ ui-key.yacloud_org.application.overview.oauth_security_section_title }}**:

* В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_authentication_methods }}** выберите нужные [способы](../../organization/concepts/applications/oidc.md#secret-delivery) передачи секрета приложения:

    * `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_basic }}` — чтобы секрет приложения передавался в HTTP-заголовке `Authorization: Basic`.
    * `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_post }}` — чтобы секрет приложения передавался в теле POST-запроса.

    Вы можете выбрать один или одновременно оба способа передачи секрета.
* Включите опцию **{{ ui-key.yacloud_org.organization.apps.AppEditPage.field-require-pkce_9rAab }}**, чтобы приложение {{ org-full-name }} при обмене данными требовало от внешнего приложения использовать расширение безопасности [PKCE](*pkce_info).

    Чтобы отказаться от использования этого расширения, отключите опцию **{{ ui-key.yacloud_org.organization.apps.AppEditPage.field-require-pkce_9rAab }}**.