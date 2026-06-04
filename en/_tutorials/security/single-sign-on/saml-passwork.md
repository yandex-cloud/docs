# Creating a SAML app in {{ org-full-name }} for integration with Passwork

Passwork is a corporate platform designed for secure and reliable storage of secrets (passwords, keys, tokens, etc.), secret management, and automation of employee access to secrets within an organization. Passwork supports SAML authentication for secure SSO for the users of your organization.

For the users of your [organization](../../../organization/concepts/organization.md) to authenticate to Passwork via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-full-name }} and configure it both on the {{ org-full-name }} and Passwork side.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

To grant access to Passwork to the users of your organization:

1. [Create a SAML application in {{ org-full-name }}](#create-app).
1. [Set up {{ org-full-name }} integration with Passwork](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `passwork-app`.
        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Add a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

### Save the identity provider settings {#save-idp-settings}

On the info page of your newly created SAML application `passwork-app`, copy and save the settings required to establish a relying party trust between the IdP and the service provider on the Passwork side.

1. Under **{{ ui-key.yacloud_org.application.overview.oauth_idp_section_title }}**, copy and save the values of the following fields:

    * **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}**
    * **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**
    * **{{ ui-key.yacloud_org.application.overview.saml_field_logout }}**
1. Under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** to download your SAML app certificate.

You will need the saved values later when configuring the integration on the Passwork side.

## Set up the integration {#setup-integration}

To configure Passwork integration with the SAML app you created in {{ org-full-name }}, complete the setup both on the Passwork and {{ org-full-name }} side.

### Set up the SAML app in Passwork {#setup-sp}

{% note info %}

The SAML application can be set up in Passwork either by a user with the administrator role or the account owner. 

{% endnote %}

1. Sign in to the Passwork account as owner or administrator.
1. At the top of the screen, click **Settings and users**, and select **SSO settings** from the list that opens. In the window that opens:

    * Under **General settings**, enable these options:

        * **Enable SSO**.
        * **Automatically confirm new users from SSO**.
    * Under **User Attributes**, specify the user [attribute](../../../organization/concepts/applications.md#saml-attributes) names:

        * In the **Email attribute** field: `emailaddress`.
        * In the **Full name attribute** field: `fullname`.
    * Under **Identity Provider → Passwork**, specify the values you copied (in `passwork-app`) and saved earlier:

        * In the **Entity ID** field, put the value from the **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** field of the `passwork-app` app.
        * In the **Response URL (assertion consumer service URL)** field, put the value from the **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** field.
        * In the **Logout URL** field, put the value from the **{{ ui-key.yacloud_org.application.overview.saml_field_logout }}** field.
        * In the **Certificate** field, paste the contents of the certificate downloaded from the `passwork-app` app.
1. Under **Passwork → Identity Provider**, copy and save the settings required to establish a relying party trust between the IdP and the service provider on the {{ org-full-name }} side:

    * **Entity ID**
    * **Response URL (assertion consumer service URL)**
    * **Logout URL**
1. Click **Save settings** to save the SSO parameters.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the new SAML app `passwork-app`.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, specify the value copied earlier from the **Entity ID** field on the Passwork side.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, specify the value copied from the **Response URL (assertion consumer service URL)** field.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** field, specify the value copied from the **Logout URL** field.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Add users to the {{ org-full-name }} SAML application {#add-users}

For the users of your organization to be able to authenticate in Passwork with {{ org-full-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the app:

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select users or user groups.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Make sure your application works correctly {#validate}

To make sure both your SAML app and Passwork integration work correctly, sign in to Passwork as one of the users you added to the app. Follow these steps:

1. In your browser, navigate to your Passwork instance URL, e.g., `https://my-domain.passwork-cloud.ru`.
1. If already logged in to Passwork, sign out of your account.
1. On the Passwork authentication page, click **Log in via SSO**.
1. On the {{ yandex-cloud }} authentication page, enter the email address and user password. The user or group they belong to must be added to the application.

    If authenticating as a [Yandex account](../../../iam/concepts/users/accounts.md#passport) user, sign in to Yandex ID using your preferred method.
1. Set a master password for the new user you add to Passwork.
1. Make sure you have authenticated in Passwork. As a result, the new user will appear in your Passwork instance settings, and you will be able to configure their permissions to view and manage secrets.