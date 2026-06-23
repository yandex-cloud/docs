Справа сверху нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

1. В блоке **{{ ui-key.yacloud_org.application.overview.oauth_service_section_title }}** в поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите полученный у поставщика услуг адрес.

    Используйте кнопку **{{ ui-key.yacloud_org.organization.apps.OauthAppRedirectUrlsField.add-redirect-url_rS5jw }}**, чтобы указать одновременно несколько адресов Redirect URI.
1. {% include [oidc-app-update-security-settings](./oidc-app-update-security-settings.md) %}
1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** выберите набор атрибутов пользователей, которые будут доступны поставщику услуг:

    {% include [oidc-app-attribute-scopes](./oidc-app-attribute-scopes.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

[*pkce_info]: PKCE — это расширение безопасности, применяемое в стандарте OAuth 2.0 с целью минимизировать риски перехвата аутентификационных данных. Подробнее читайте в разделе [{#T}](../../organization/concepts/applications/oidc.md#pkce).