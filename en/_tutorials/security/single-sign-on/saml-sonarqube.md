# Creating a SAML app in {{ org-full-name }} for integration with SonarQube

{% include [note-preview](../../../_includes/note-preview.md) %}

[SonarQube](https://www.sonarsource.com/products/sonarqube/) is a platform that automatically scans source code to identify errors and vulnerabilities and evaluate test coverage. SonarQube supports SAML authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to SonarQube via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-name }} and configure it appropriately both in {{ org-name }} and SonarQube.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

For the users of your organization to be able to access SonarQube:

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
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `sonarqube-app`.
        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):
            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

{% note info %}

SAML integration is supported for SonarQube Developer Edition and higher. 

{% endnote %}

To integrate SonarQube with the SAML app you created in {{ org-name }}, complete the configuration both on the SonarQube side and in {{ org-name }}.

### Set up the SAML app in SonarQube {#setup-sp}

{% note info %}

To set up the SAML app in SonarQube, the user needs the **Administer System** global permission. 

{% endnote %}

1. To configure SAML authentication in SonarQube, in the left-hand panel, navigate to **Administration** and then, in the menu that opens, go to **Configuration** -> **General Settings**. In the **General Settings** menu, select **Authentication** -> **SAML**.
1. Click **Create configuration**.

Then complete the steps below:

#### Connect SonarQube to the IdP {#connect-idp}

Configure a link between SonarQube and {{ org-name }}:

1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
1. In the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** and **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** field values.
1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** and save the file to your device.
1. Go back to SonarQube, then in the **Edit SAML configuration** menu:
    1. In the **Application ID** field, leave the default value, `sonarqube`.
    1. Paste the copied values ​​into the **Provider ID** and **SAML login url** fields.
    1. Open the saved certificate file in any text editor, copy its contents and paste it into the **Identity provider certificate** field.

#### Map user attributes {#user-mapping}

Set up mapping between user object fields in SonarQube and {{ org-name }}:

1. In the **SAML user login attribute** field, specify `login`.
1. In the **SAML user name attribute** field, specify `fullname`.
1. Optionally, in the **SAML user email attribute** field, specify `emailaddress`.
1. If you want SonarQube users to get assigned to one of the groups when they log in, add the user group attribute. To do this, specify `groups` under **SAML group attribute**.
1. Save the settings by clicking **Save configuration**.
1. Click **Enable configuration**.

#### Set the public URL {#set-domain}

In the **General Settings** menu, from the **Authentication** section, go to **General**. Under **General**, in the **Server base URL** field, enter `https://<your-domain>`.

#### Map user groups {#group-mapping}

{% note info %}

If you do not configure group mapping, all users will be assigned to the default `sonar-users` group when they log in.

{% endnote %}

You can set up which group to assign users to upon login. To do this, you need to create groups on the SonarQube side:

1. At the top of the page, from the **Configuration** section, go to **Security** -> **Groups**.
1. Click **Create Group**.
1. In the **Name** field, enter a name for the group, e.g., `test-group`. You will need to create the group when setting up the app in {{ org-name }}.
1. Click **Create**.
1. To configure permissions for the group:
    1. In the **Security** menu, go from the **Groups** section to the **Global Permissions** section.
    1. To the right of the `test-group`, check the required permissions.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. In the top-right corner, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. Set the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field value to `sonarqube`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter this address: `https://<your-domain>/oauth2/callback/saml`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Configure user attributes {#user-attributes}

{% note warning %}

For integration with SonarQube, users must have the `login` attribute.

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

If you have configured user group mapping in SonarQube, add the user group attribute. Proceed as follows:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. In the top-right corner, click ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** and in the window that opens:
       1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field, specify `groups`.
       1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** field, select `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.
       1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Add users {#add-users}

For your organization's users to be able to authenticate in SonarQube with {{ org-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to your SAML app.

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

1. If you have configured user group mapping on the SonarQube side, [create](../../../organization/operations/create-group.md) the required [group](../../../organization/concepts/groups.md):

    {% list tabs group=instructions %}

    - {{ cloud-center }} UI {#cloud-center}

        1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. In the left-hand panel, select ![groups](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
        1. In the top-right corner of the page, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.
        1. Enter the name: `test-group`.
        1. Click **{{ ui-key.yacloud_org.groups.action_create-group }}**.
        1. Add users to the group:
            1. Navigate to the **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** tab.  
            1. Click **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
            1. In the window that opens, select the required users.
            1. Click **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

    {% endlist %}

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

To ensure that your SAML app and integration with SonarQube are working correctly, authenticate to SonarQube as one of the users you added to the app. Proceed as follows:

1. In your browser, navigate to the address of your SonarQube instance, e.g., `https://<your-domain>`.
1. If you were logged in to SonarQube, log out.
1. On the SonarQube authentication page, click **Log in with SAML**.
1. On the {{ yandex-cloud }} authentication page, enter your email address and user password. The user or group they belong to must be added to the application.
1. Make sure you are logged in to SonarQube.
1. If you have configured role mapping, go to the user profile in SonarQube and make sure the appropriate group is displayed under **Groups**. 