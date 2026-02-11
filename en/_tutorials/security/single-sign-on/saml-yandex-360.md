# Creating a SAML app in {{ org-full-name }} for integration with {{ yandex-360 }}

[Yandex 360](https://360.yandex.ru/) is a cloud platform for business offering tools for setting up corporate email addresses, collaboration, and document management. {{ yandex-360 }} supports SAML authentication to provide secure SSO for your organization’s users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to {{ yandex-360 }} via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-name }} and configure it appropriately both in {{ org-name }} and {{ yandex-360 }}.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

For the users of your organization to be able to access {{ yandex-360 }}:

1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `yandex360`.
        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To configure {{ yandex-360 }} integration with the SAML app you created in {{ org-name }}, complete the configuration both on the {{ org-name }} side and in {{ yandex-360 }}.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, specify `https://yandex.ru/`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter this address: `https://passport.yandex.ru/auth/sso/commit`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Configure user attributes {#user-attributes}

{% note warning %}

For integration with {{ yandex-360 }}, set the `User.EmailAddress`, `User.Firstname`, and `User.Surname` attributes.

{% endnote %}

Set user attributes for integration with {{ yandex-360 }}:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the desired app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
    1. Edit user attributes:

        1. Replace the `emailaddress` attribute with `User.EmailAddress`. Proceed as follows:
            1. Click the row with the `emailaddress` attribute.
            1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field, enter `User.EmailAddress`.
            1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** field, leave `SubjectClaims.email`.
            1. Click **{{ ui-key.yacloud.common.save }}**.

        1. Replace the `givenname` attribute with `User.Firstname`.
        1. Replace the `surname` attribute with `User.Surname`.
        1. You can delete the `fullname` attribute as you will no longer need it.

{% endlist %}

For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

#### Collect data for setting up {{ yandex-360 }} {#collect-idp-data}

To set up SSO in {{ yandex-360 }}, you need the following data from your SAML app:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
    1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** on the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, copy the following data:

        * **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}**: IdP entity ID.
        * **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**: Entry point URL address (Login URL).

    1. Under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** and save the token signing certificate in X.509 format to your device.

{% endlist %}

You will need this data to set up SSO in {{ yandex-360 }}.

### Set up SAML authentication in {{ yandex-360 }} {#setup-sp}

{% note info %}

To set up SAML authentication in {{ yandex-360 }}, the user needs the organization administrator permissions.

{% endnote %}

To set up SAML authentication in {{ yandex-360 }}:

1. Go to the [Yandex 360 for Business console](https://admin.yandex.ru/).
1. Navigate to the SSO settings section.
1. Provide the data you got in the previous step:
    * **IdP Entity ID**: IdP issuer.
    * **Login URL**: Entry point URL.
    * Upload the **token signing certificate** in X.509 format.
1. Save the settings.

{% note warning %}

Make sure the domain from the `User.EmailAddress` attribute in the SAML response matches the main domain or one of the alias domains of your {{ yandex-360 }} organization.

{% endnote %}

### Add users {#add-users}

For your organization's users to be able to authenticate in {{ yandex-360 }} with {{ org-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to your SAML application.

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

Add users to the application:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the required user or user group.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Make sure your application works correctly {#validate}

To make sure both your SAML app and {{ yandex-360 }} integration work correctly, authenticate to {{ yandex-360 }} as one of the users you added to the app. Proceed as follows:

1. In your browser, go to the {{ yandex-360 }} login page.
1. If you were logged in to {{ yandex-360 }}, log out.
1. On the authentication page, select Single Sign-On (SSO).
1. On the {{ yandex-cloud }} authentication page, enter your email address and user password. The user or group they belong to must be added to the application.
1. Make sure you are logged in to {{ yandex-360 }}.

### Troubleshooting setup issues {#troubleshooting}

If you have specified incorrect values when setting up the IdP, you will get the `Failed to log in` message and the following error code on an attempt to log in via SSO.

#### email.not_in_response {#email-not-in-response}

Specify attribute names in `User.Firstname`, `User.Surname`, `User.EmailAddress` format. If you specify another format, e.g., `Firstname`, you will not be able to log in.

#### request_your_admin {#request-your-admin}

This error occurs if the administrator of your organization’s user folder has restricted access to {{ yandex-360 }} for your account. For more details, contact your organization’s support team.

#### samlresponse.invalid {#samlresponse-invalid}

This error occurs if either the entry point URL, IdP issuer, or token signing certificate was specified incorrectly. You may also get this error within 14 days prior to the expiration of the token signing certificate or after it expires. Validate your SSO settings in {{ yandex-360 }}.

#### unsupportable_domain {#unsupportable-domain}

Make sure the domain from the `User.EmailAddress` email attribute in the [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) response matches the main domain or one of the alias domains of your {{ yandex-360 }} organization.
