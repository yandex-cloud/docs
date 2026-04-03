# Creating a SAML app in {{ org-full-name }} for integration with Cloud.ru

[Cloud.ru](https://cloud.ru/) is a Russian provider of cloud services, spanning IaaS, PaaS, AI/ML tools, and solutions for public, private, and hybrid cloud deployments, including support for infrastructure migration and operation.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to Cloud.ru via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-full-name }} and configure it appropriately both in {{ org-full-name }} and Cloud.ru.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

For the users of your organization to be able to access Cloud.ru:

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
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `cloud-ru-saml-app`.

        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To configure Cloud.ru integration with the SAML app you created in {{ org-full-name }}, complete the setup both in Cloud.ru and {{ org-full-name }}.

### Set up the SAML app in Cloud.ru {#setup-sp}

1. Get the metadata for the [new app](#create-app):

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      The downloaded [XML](https://en.wikipedia.org/wiki/XML) file contains the required metadata and a certificate used for SAML response signature verification.

1. Set up SAML authentication for Cloud.ru.

    1. Log in to the Cloud.ru [console](https://console.cloud.ru/).
    1. Navigate to the **Federations** tab in the **Administration** section.
    1. Click **Create federation** and select the **SAML** protocol type.
    1. Upload the XML metadata file you got in {{ org-full-name }} in the previous step.
    1. Enter the federation name and description.
    1. Set the session duration.
        
        {% note info %}

        The maximum lifetime of an SSO session is from 30 minutes to 7 days. If there is no activity, the session is automatically terminated and re-authentication is required.
        
        {% endnote %}
    
    1. Check the settings in the **Single Logout Service** section, they should be imported from the XML metadata file. For **Default URL Binding**, set `Post`.
    1. Check the settings in the **Single Sign-On Service** section, they should be imported from the XML metadata file. For **Default URL Binding**, set `Redirect`.
    1. Make sure the signing certificate was imported from the XML metadata file and has the `Signing` type.
    1. Click **Create**.
    1. Download the provided XML file with Cloud.ru metadata, as it is required to complete the setup in {{ org-full-name }}.
    1. Click **Done**.
    1. In the list of federations, find the new federation and copy its ID. Save this ID as you will need it later.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
    1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
        1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, specify the `entityID` attribute value of the `EntityDescriptor` element from the Cloud.ru XML metadata file.
        1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, specify the `Location` attribute value of the `AssertionConsumerService` element from the Cloud.ru XML metadata file.
        1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Add users {#add-users}

To enable your organization's users to authenticate in Cloud.ru using the {{ org-full-name }} SAML application, you must explicitly add their accounts both to the application and the Cloud.ru federation.

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

#### Add users to the {{ org-full-name }} SAML application {#add-app-users}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the required user.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

#### Add users to the Cloud.ru federation {#add-cloudru-users}

1. Log in to the Cloud.ru [console](https://console.cloud.ru/).
1. Open the **Users** section and go to the **Federated users** tab.
1. In the top-right corner, click **Add federation user**.
1. Select the federation you want to add the user to.
1. Specify the user's email address.
1. Grant the user access permissions for projects and platforms.
1. Click **Add**.

## Make sure your application works correctly {#validate}

To make sure both your SAML app and its integration with Cloud.ru work correctly, authenticate to Cloud.ru as one of the users you added to the app.

Proceed as follows:

1. In your browser, open the Cloud.ru [console](https://console.cloud.ru/) login page.
1. If you were logged in, log out.
1. On the login screen, click **SSO**.
1. In the dialog that appears, enter the ID of the federation you created and click **Log in**.
1. On the {{ yandex-cloud }} authentication page, enter the email address and user password.
1. Make sure you have successfully authenticated to Cloud.ru.
