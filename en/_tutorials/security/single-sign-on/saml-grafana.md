# Creating a SAML application in {{ org-full-name }} for integration with Grafana Cloud

{% include [note-preview](../../../_includes/note-preview.md) %}

[Grafana Cloud](https://grafana.com/products/cloud/) is a managed cloud monitoring and observability platform that brings together Grafana, Prometheus, Loki, and other tools for data visualization and analysis. Grafana Cloud supports SAML authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to Grafana Cloud via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-name }} and configure it appropriately both in {{ org-name }} and Grafana Cloud.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

For the users of your organization to be able to access Grafana Cloud:

1. [Create a Grafana Cloud account](#grafana-account).
1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create a Grafana Cloud account {#grafana-account}

If you do not have a Grafana Cloud account, create one:

1. Go to the [Grafana Cloud sign up page](https://grafana.com/auth/sign-up/).
1. Fill out the registration form:
    - Enter your email address.
    - Create a secure password.
1. Click **Create my account**.
1. Verify your new account by following the instructions sent to the email address you provided.
1. Select a name for your organization; this name will be part of your instance's URL, e.g., `your-org`.
1. Once logged in, make sure you have administrator permissions to configure SAML in Grafana Cloud.

{% note info %}

To configure SAML in Grafana Cloud, you need organization administrator permissions. If you do not have the required permissions, contact your organization's administrator in Grafana Cloud.

{% endnote %}

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `grafana-cloud-app`.

        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up integration {#setup-integration}

To integrate Grafana Cloud with the SAML app you created in {{ org-name }}, complete the setup both on the Grafana Cloud side and in {{ org-name }}.

### Set up the SAML application in Grafana Cloud {#setup-sp}

1. To configure SAML authentication in Grafana Cloud, in the left-hand panel, navigate to **Administration** and then to **Authentication**.
1. In the main window, select **SAML**.

Then complete the steps below:

#### General settings {#general-settings}

Make sure to enable the **Allow signup** option to automatically create users in Grafana Cloud when they log in via SSO. If this option is disabled, only users who already have a Grafana Cloud account will be able to log in.

#### Signing requests {#sign-requests}

Configure a certificate to sign outgoing requests.

{% note tip %}

{{ org-full-name }} does not currently support request signature verification, so we recommend you leave the **Sign requests** option disabled.

{% endnote %}

#### Connecting Grafana to the IdP {#conect-idp}

Configure a link between Grafana Cloud and {{ org-name }}:

1. Under **Configure IdP using Grafana metadata**, copy and save the endpoint addresses for receiving metadata (*Metadata URL*) and sending user authentication requests (*Assertion Consumer Service URL*). You will need the latter in later steps when setting up integration in {{ org-name }}.
1. Configure the endpoint address to receive metadata from {{ org-name }}:

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}** field value.
    1. Return to Grafana Cloud and under **Finish configuring Grafana using IdP data**, paste the copied address into the **Metadata URL** field.

#### Mapping user attributes {#user-mapping}

Set up mapping between user object fields in Grafana Cloud and {{ org-name }}:

1. Under **Assertion attributes mappings**, specify:

    - **Name attribute**: `fullname`
    - **Login attribute**: `login`
    - **Email attribute**: `emailaddress`

1. If you want Grafana Cloud users to get one of the basic roles (Viewer, Editor, Admin) when they log in, add the user group attribute. To do this, select `groups` in the **Role attribute** field.

    {% note info %}

    If you do not configure role mapping, all users will log in with the default `Viewer` role.

    {% endnote %}

    Next, under **Role mapping**, specify the names of the groups whose users will receive the appropriate roles. Here is an example:

    - Under **Viewer**: `grafana-viewer`
    - Under **Editor**: `grafana-editor`
    - Under **Admin**: `grafana-admin`

    You will need to create the groups when setting up the app in {{ org-name }}.

1. Below, in the **Name identifier format** field, select `Email address`.

    To view and configure user attribute names in {{ org-name }}, use the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab in your application.

1. Save the settings by clicking **Save and enable**.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, paste the endpoint address you copied from the **Metadata URL** field in the third step when setting up the integration in Grafana Cloud.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, paste the endpoint address you copied from the **Assertion Consumer Service URL** field in the third step of setting up the integration in Grafana Cloud.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Configure user attributes {#user-attributes}

{% note warning %}

For integration with Grafana Cloud, users need the `login` attribute.

{% endnote %}

If users do not have the `login` attribute, add it:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the desired app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
    1. In the top-right corner, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** and in the window that opens:

        1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field, enter `login`.
        1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** field, select `SubjectClaims.preferred_username`.
        1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

If you have configured role mapping in Grafana Cloud, add the user group attribute. To do this:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. In the top-right corner, click ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** and in the window that opens.
    1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** field, select `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Add a user {#add-user}

For your organization's users to be able to authenticate in Grafana Cloud with {{ org-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the SAML application.

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

1. If you have configured role mapping in Grafana Cloud, [create](../../../organization/operations/create-group.md) the [groups](../../../organization/concepts/groups.md) as needed:

    {% list tabs group=instructions %}

    - {{ cloud-center }} UI {#cloud-center}

        1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. In the left-hand panel, select ![groups](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
        1. In the top-right corner of the page, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.
        1. Enter a name, e.g., `grafana-viewer`.
        1. Click **{{ ui-key.yacloud_org.groups.action_create-group }}**.
        1. Add users to the group:
            1. Navigate to the **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** tab.  
            1. Click **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
            1. In the window that opens, select the required users.
            1. Click **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

    {% endlist %}

    Similarly, create the `grafana-editor` and `grafana-admin` groups.

1. Add users to the application:

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

To make sure both your SAML app and Grafana Cloud integration work correctly, authenticate to Grafana Cloud as one of the users you added to the app. To do this:

1. In your browser, navigate to the address of your Grafana Cloud instance, e.g., `https://your-org.grafana.net`.
1. If you were logged in to Grafana Cloud, log out.
1. On the Grafana Cloud sign in page, click **Sign in with SAML**.
1. On the {{ yandex-cloud }} sign in page, enter the user email and password. The user or group they belong to must be added to the application.
1. Make sure you are logged in to Grafana Cloud.
1. If you have configured role mapping, go to the user profile in Grafana Cloud and make sure the appropriate role is displayed under **Organization**.  

