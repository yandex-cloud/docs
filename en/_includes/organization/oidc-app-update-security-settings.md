Configure the OIDC application security settings (available only `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` [type](../../organization/concepts/applications/oidc.md#oidc-application-types) applications):

Under **{{ ui-key.yacloud_org.application.overview.oauth_security_section_title }}**:

* In the **{{ ui-key.yacloud_org.application.overview.oauth_field_authentication_methods }}** field, select your preferred [methods](../../organization/concepts/applications/oidc.md#secret-delivery) of providing the application secret:

    * `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_basic }}`: In the `Authorization: Basic` HTTP header.
    * `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_post }}`: In the POST request body.

    You can choose either method or both to provide the secret.
* Enable the **{{ ui-key.yacloud_org.organization.apps.AppEditPage.field-require-pkce_9rAab }}** option for {{ org-full-name }} to require the external application to use the [PKCE](*pkce_info) security extension when exchanging data.

    To stop using the extension, disable **{{ ui-key.yacloud_org.organization.apps.AppEditPage.field-require-pkce_9rAab }}**.