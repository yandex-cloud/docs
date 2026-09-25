# Creating a SAML app in {{ org-full-name }} for integration with LibreChat

[LibreChat](https://www.librechat.ai/) is a free open-source platform that provides an easy way to work with large language models, AI agents, and MCP servers and can be deployed in your own infrastructure. LibreChat supports the [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) standard to provide secure SSO for your organization's users.

For the users of your [organization](../../../organization/concepts/organization.md) to be able to authenticate to LibreChat via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications/saml.md) in {{ org-full-name }} and configure it both in {{ org-full-name }} and LibreChat.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

{% note info %}

For successful SAML integration, configure access to your LibreChat instance over `https` using a valid TLS certificate.

{% endnote %}

To provide your organization's users with access to LibreChat:

1. [Create an app in {{ org-full-name }}](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an app in {{ org-full-name }} {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:

      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `librechat-saml-app`.
      1. Optionally, enter the app description and add [labels](../../../resource-manager/concepts/labels.md).
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
  1. On the new app page that opens:
  
      1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy and save the **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** field value for later to configure the integration in LibreChat.
      1. Under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** to get your SAML app certificate.

          Copy the certificate file you got to the server where you deployed your LibreChat instance.

{% endlist %}

## Set up the integration {#setup-integration}

To configure LibreChat integration with the SAML app you created, complete the configuration both on the {{ org-full-name }} side and in LibreChat.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. Set up service provider endpoints. To do this, at the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, specify any value, e.g., your LibreChat instance address: `https://librechat.example.com`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter this address: `https://<LibreChat_instance_address>/oauth/saml/callback`.
      1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Configure mapping for the `username` attribute which will be used as the username when authenticating to LibreChat. Follow these steps:

      1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
      1. In the top-right corner, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** and in the window that opens:

          1. In the **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** field, enter `username`.
          1. In the **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** field, select `SubjectClaims.preferred_username`.
          1. Click **{{ ui-key.yacloud.common.add }}**.

      For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

{% endlist %}

### Set up authentication in LibreChat {#setup-sp}

On the host running your LibreChat instance, set the following environment variables in the instance runtime environment to configure the LibreChat integration with the SAML application:

Variable name | Value
--- | ---
`SAML_ENTRY_POINT` | `{{ ui-key.yacloud_org.application.overview.saml_field_login }}` value you [saved previously](#create-app).
`SAML_ISSUER` | `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}` value you [set previously](#setup-idp) on the {{ org-full-name }} side.</br></br>Here is an example: `https://librechat.example.com`.
`SAML_CERT` | Local path to the SAML app certificate file in the runtime of your LibreChat instance, which [you saved earlier](#create-app).</br></br>Here is an example: `"/app/saml-certs/librechat-saml-app.cer"`.
`SAML_CALLBACK_URL` | `"https://<LibreChat_instance_address>/oauth/saml/callback"`
`SAML_SESSION_SECRET` | Additional secret for session security.</br></br>Generate a strong secret of at least 32 characters.
`SAML_EMAIL_CLAIM` | `"emailaddress"`
`SAML_USERNAME_CLAIM` | `"username"`
`SAML_GIVEN_NAME_CLAIM` | `"givenname"`
`SAML_FAMILY_NAME_CLAIM` | `"surname"`
`SAML_NAME_CLAIM` | `"fullname"`
`SAML_BUTTON_LABEL` | `"Login with {{ org-full-name}}"`

### Add a user {#add-user}

For your organization's users to be able to authenticate to LibreChat with {{ org-full-name }} SAML app, explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the SAML application:

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
  1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
  1. In the window that opens, select the required user or user group.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Make sure your application works correctly {#validate}

To make sure both your SAML app and LibreChat integration work correctly, authenticate to LibreChat as one of the users you added to the app. Follow these steps:

1. In your browser, open the LibreChat instance login page.
1. Select login via {{ org-full-name }}.
1. Authenticate in {{ yandex-cloud }} as your organization’s user you added to the SAML app.
1. Make sure you have successfully authenticated to LibreChat.
