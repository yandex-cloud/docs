# Creating a SAML app in {{ org-full-name }} for integration with Selectel

[Selectel](https://selectel.ru/) is a cloud infrastructure and data center provider offering dedicated servers, cloud platforms, and data storage services. Selectel supports SAML authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users in Selectel via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-full-name }} and configure it appropriately both in {{ org-full-name }} and Selectel.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

For the users of your organization to be able to access Selectel:

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
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `selectel-app`.
        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):
            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To configure Selectel integration with the SAML app you created in {{ org-full-name }}, complete the configuration both on the Selectel side and in {{ org-full-name }}.

### Set up the SAML app in Selectel {#setup-sp}

{% note info %}

An [account owner](https://docs.selectel.ru/access-control/user-types/#account-owner) or user with the **iam_admin** role can create an identity federation in Selectel.

{% endnote %}

To set up SAML authentication in Selectel, create and configure an [identity federation](https://docs.selectel.ru/access-control/federations/about-federations/). Proceed as follows:

1. Log in to your Selectel account and select **Account** in the top panel.
1. In the left-hand panel, under **Access management**, select **Federations**.
1. Click **Add federation**.

After that, configure a link between Selectel and {{ org-full-name }}:

1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
1. In the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** and **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** field values.
1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** and save the file to your device.
1. Go back to Selectel, then in the **Create federation** menu:
    1. In the **Name** field, enter a name for the federation.
    1. Optionally, in the **Description** field, specify the federation description.
    1. Paste the copied values to the **IdP Issuer** and **IdP login page link** fields.
    1. Under **Session lifetime**, specify how long an authentication session will last until the user needs to reauthenticate, or leave the default value (24 hours).
    1. Optionally, to sign authentication requests, check the **Sign authentication requests** box.
    1. Optionally, to force users to authenticate after their Selectel session expires, check the **Forced IdP authentication** box.
    1. Click **Create federation**.
    1. In the **Certificate name** field, enter a name for the certificate.
    1. Use any text editor to open the certificate file you saved earlier, copy its contents, and paste it into the **Certificate** field.
    1. Click **Add** and then click **Complete adding federation**.
    1. On the new federation page, copy the **ID** field value.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
    1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
        1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, specify `https://api.selectel.ru/v1/federations/saml/<federation_id>`, where `federation_id` is the federation ID you copied at the end of the previous step.
        1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter this address: `https://api.selectel.ru/v1/auth/federations/<federation_id>/saml/acs`.
        1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Configure digital signature verification (optional) {#signature-verification}

If you checked the **Sign authentication requests** box when setting up your federation, configure digital signature verification:

1. [Download a Selectel certificate](https://docs.selectel.ru/access-control/federations/certificates/#download-certificate-for-request-verification).
1. In the top-right corner of your SAML app, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens, enable **{{ ui-key.yacloud_org.application.overview.saml_field_request_signing_enabled }}**:
1. Click **{{ ui-key.yacloud_org.entity.certificate.action.add }}**.
1. Choose how to add a certificate:
    * To add a certificate as a file, click **{{ ui-key.yacloud_components.fileinput.button_attach-file }}** and specify the path to it.
    * To paste the contents of a copied certificate, select the **{{ ui-key.yacloud_org.component.form-file-upload.method.manual }}** method and paste the contents.
1. Click **{{ ui-key.yacloud.common.add }}** and then click **{{ ui-key.yacloud.common.save }}**.

### Add users {#add-users}

For your organization's users to be able to authenticate in Selectel with {{ org-full-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to your SAML application. Also, explicitly add users to Selectel.

#### Add users to the SAML application {#add-users-idp}

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the required user or user group.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

#### Add users to Selectel {#add-users-sp}

Before adding a user to Selectel, copy their ID from {{ org-full-name }}:

1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
1. In the left-hand panel, select ![person](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**. Find the user your want to add to Selectel in the list.
1. Copy the **{{ ui-key.yacloud_org.entity.user.caption.username }}** column value.

Then add the user to your Selectel account:

1. Go back to Selectel, then select **Account** in the top panel:
1. Go to **Users**.
1. In the top-right corner, click **Add user**.
1. Under **User data**:
    1. In the **Login method** field, select **Federation (<federation_name>)**.
    1. Under **External ID**, enter the ID you copied.
    1. In the **Email** field, enter the user email address to receive instructions for completing the authentication.
    1. Optionally, provide a user description.
1. Under **Access settings**, configure the user permission. Proceed as follows:
    1. Select the access scope: **Account** or **Projects**. For the **Projects** access scope, select the projects in the **Project** field.
    1. Assign a role to the user. To assign the `member` role or higher to the user, your account balance must be at least ₽100.
    1. Optionally, click **Add permission** to add another permission.
1. Optionally, in the **Group** field, assign a group to the user.
1. Optionally, in the **Notifications** field, select notification categories to send to the user email address.
1. Click **Add user**.

## Make sure your application works correctly {#validate}

To make sure both your SAML app and Selectel integration work correctly, authenticate to Selectel as one of the users you added to the application. Proceed as follows:

1. Open the email notifying of granted access to a Selectel account. The email contains the federation ID and an SSO authentication link.
1. Click the link in the email to open the authentication page.
1. Enter the **Federation ID**.
1. Click **Log in**.
1. On the {{ yandex-cloud }} authentication page, enter the email address and user password. The user or group they belong to must be added to the application.
1. After successful authentication in {{ org-full-name }}, you will be redirected to the Selectel login page. Enter your full name in the **Full name** field.
1. Click **Log in**.
1. Make sure you have successfully authenticated in Selectel.
