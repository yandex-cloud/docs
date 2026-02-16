On the top right, click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

1. Specify the address you got from the service provider in the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field.

    Click **{{ ui-key.yacloud_org.organization.apps.OauthAppRedirectUrlsField.add-redirect-url_rS5jw }}** to specify multiple redirect URIs at once.
1. In the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** field, select user attributes that will be available to the service provider.

    {% include [oidc-app-attribute-scopes](./oidc-app-attribute-scopes.md) %}

1. Click **{{ ui-key.yacloud.common.save }}**.