# Creating a SAML app in {{ org-full-name }} for integration with the management console of Yandex Browser for organizations

[Yandex Browser for organizations](https://browser.yandex.ru/corp/) is an enterprise-grade browser based on the latest standard browser version and enhanced with dedicated business features and strict security controls. Centralized browser administration is available via the [management console](https://browser.yandex.ru/corp/builds). The management console supports SAML authentication to provide secure SSO for your organization's users.

For the users of your [organization](../../../organization/concepts/organization.md) to be able to authenticate to the management console of Yandex Browser for organizations via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-full-name }} and configure it both in {{ org-full-name }} and Yandex Browser for organizations.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

To give the users of your organization access to the management console of Yandex Browser for organizations:

1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `browser-cloud`.
        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):
            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Add a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To configure the integration between Yandex Browser for organizations and the SAML app you created in {{ org-full-name }}, complete the setup both in {{ org-full-name }} and Yandex Browser for organizations.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, specify `browser.yandex.ru`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter an address formatted as `https://<console_domain>/corp/api/sso/saml/callback`, e.g., `https://browser.yandex.ru/corp/api/sso/saml/callback`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}** field, select `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response_x7SKD }}`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Configure user attributes {#user-attributes}

{% note warning %}

For integration with the management console of Yandex Browser for organizations, you need to configure the `firstName` and `lastName` attributes.

{% endnote %}

Set user attributes for integration with Yandex Browser for organizations:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the desired app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
    1. Edit user attributes:

        1. Replace the `givenname` attribute with `firstName`.
        1. Replace the `surname` attribute with `lastName`.
        1. The `fullname` and `emailaddress` attributes are not required, so you can remove them.

{% endlist %}

For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

#### Collect data for setting up Yandex Browser for organizations {#collect-idp-data}

To set up SSO in Yandex Browser for organizations, you need the following data from your SAML app:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
    1. In the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, in the **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** field, copy the entry point URL (Login URL).
    1. Under **{{ ui-key.yacloud_org.application.overview.oauth_service_section_title }}**, in the **{{ ui-key.yacloud_org.application.overview.saml_field_sp_entity }}** field, copy the unique service provider ID.
    1. Under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** and save the token signature certificate in X.509 format to your device.

{% endlist %}

You will need this data to set up SSO in Yandex Browser for organizations.

### Set up SAML authentication in Yandex Browser for organizations {#setup-sp}

{% note info %}

To set up SAML authentication in Yandex Browser for organizations, the user needs the organization administrator permissions.

{% endnote %}

To set up SAML authentication in Yandex Browser for organizations:

1. Log in to the Yandex Browser for organizations [management console](https://browser.yandex.ru/corp/builds).
1. Go to **SSO** settings.
1. Specify the following:
    * **Domain**: [Domain](../../../organization/concepts/domains.md) in {{ org-full-name }}.
    * **SP Entity ID**: Unique service provider ID obtained in the previous step.
    * **Single sign-on service URL**: Login URL obtained in the previous step.
    * **Signing certificate**: Provide the previously saved **token signing certificate** in X.509 format.
1. Save the settings.
1. Click **Download certificate**.
1. Optionally, configure signature verification:
   1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
   1. Click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
   1. Enable **{{ ui-key.yacloud_org.application.overview.saml_field_request_signing_enabled }}** and click **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.add-cert-action }}**.
   1. In the window that opens, attach the certificate file you downloaded in the Yandex Browser management console.
   1. Click **{{ ui-key.yacloud.common.add }}**.
1. In the Yandex Browser for organizations management console, enable **SSO/SAML authentication**.
1. Wait until the domain is confirmed. To check the status, go to **SSO** settings.

### Add users {#add-users}

For your organization's users to be able to authenticate in the Yandex Browser for organizations management console with {{ org-full-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to your SAML application. You also need to add the relevant users as administrators in the Yandex Browser for organizations management console.

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

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

Add administrators:

1. Log in to the Yandex Browser for organizations [management console](https://browser.yandex.ru/corp/builds).
1. Go to the **Administrators** settings section.
1. Click **Add**.
1. Specify the email address of a user added to the app.
1. Repeat the previous steps for all users who need access to the console.

## Make sure your application works correctly {#validate}

To make sure both your SAML app and Yandex Browser for organizations integration management console work correctly, authenticate as one of the administrators you added to the app. Follow these steps:

1. In your browser, go to the Yandex Browser for organizations management console login page.
1. If you were previously logged in, log out.
1. On the authentication page, click **Log in via SSO**.
1. On the {{ yandex-cloud }} authentication page, enter the email address and user password. The user or group they belong to must be added to the application. The user must also be a management console administrator.
1. Make sure you have successfully authenticated in the Yandex Browser management console.
