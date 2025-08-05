On the top right, click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, enter the unique service provider ID.

    The value must be the same on the service provider's and {{ org-name }} side.
1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, specify the URL {{ org-name }} will send the SAML response to.

    {% include [saml-app-acs-url-paragraph](./saml-app-acs-url-paragraph.md) %}

    Optionally, use the **{{ ui-key.yacloud_org.organization.apps.SamlAppAcsUrlsField.add-acs-url_eMunC }}** button to specify multiple ACS URLs/indexes.

    {% include [saml-app-acs-url-warn](./saml-app-acs-url-warn.md) %}

1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}** field, select the SAML response elements that will be digitally signed:

    {% include [saml-app-sign-mode](./saml-app-sign-mode.md) %}

1. Click **{{ ui-key.yacloud.common.save }}**.