On the top right, click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

1. Under **{{ ui-key.yacloud_org.application.overview.oauth_service_section_title }}**, specify the address you got from the service provider in the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field.

    Click **{{ ui-key.yacloud_org.organization.apps.OauthAppRedirectUrlsField.add-redirect-url_rS5jw }}** to specify multiple redirect URIs at once.
1. {% include [oidc-app-update-security-settings](./oidc-app-update-security-settings.md) %}
1. In the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** field, select user attributes that will be available to the service provider.

    {% include [oidc-app-attribute-scopes](./oidc-app-attribute-scopes.md) %}

1. Click **{{ ui-key.yacloud.common.save }}**.

[*pkce_info]: PKCE is a security extension used in OAuth 2.0 to minimize the risk of authentication data interception. For more information, see [{#T}](../../organization/concepts/applications/oidc.md#pkce).