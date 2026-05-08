# Creating a SAML app in {{ org-full-name }} for integration with Jenkins

[Jenkins](https://www.jenkins.io/) is an open-source Java-based software system designed to support continuous software integration.

For your [organization's](../../../organization/concepts/organization.md) users to be able to authenticate to Jenkins via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-full-name }} and configure it both in {{ org-full-name }} and Jenkins.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

{% note info %}

For SAML integration, your Jenkins instance must have a valid SSL certificate in place.

{% endnote %}

To give the users of your organization access to Jenkins:

1. [Create an app in {{ org-full-name }}](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an app in {{ org-full-name }} {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

   1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
   1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `jenkins-saml`.

      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

         1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Specify a label in `key: value` format.
         1. Press **Enter**.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. Save the **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}** value, you will need it at the next step.

{% endlist %}

## Set up the integration {#setup-integration}

### Install the SAML plugin in Jenkins {#install-saml-plugin}

To configure authentication to Jenkins using SAML, install the SAML plugin:

1. Log in to Jenkins as a user with administrator privileges.
1. In the left-hand menu, select **Manage Jenkins** > **Plugins**.
1. Navigate to the **Available** tab and enter `SAML` in the search bar.
1. Locate [**SAML Plugin**](https://plugins.jenkins.io/saml) and **Install** it.
1. Wait for the installation to complete, and restart Jenkins if necessary.

After you install the plugin, a new **Security Realm** option, `SAML 2.0`, will appear in the **Manage Jenkins** > **Security** section.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, enter any value, e.g., `<jenkins_instance_address>/`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter `<jenkins_instance_address>/securityRealm/finishLogin`.
      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** field, enter `<jenkins_instance_address>/securityRealm/finishLogin`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Configure authentication on the Jenkins side {#setup-sp}

1. Log in to Jenkins as a user with administrator privileges.
1. In the left-hand menu, select **Manage Jenkins** > **Security**.
1. Under **Security Realm**, select `SAML 2.0`.
1. In the **IdP Metadata URL** field, enter the metadata file address you copied earlier.
1. In the **Display Name Attribute** field, enter `fullname`.
1. In the **Username Attribute** field, enter `preferred_username`.
1. In the **Email Attribute** field, enter `emailaddress`.
1. Enable the **Advanced Configuration** option. In the **SP Entity ID** field, enter the value you specified in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field on the {{ org-full-name }} side, e.g., `<jenkins_instance_address>/`.
1. Click **Save**.

### Configure user attributes {#user-attributes}

Add the `preferred_username` attribute to users, which will be used as the username when authenticating to Jenkins. Follow these steps:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the desired app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
    1. In the top-right corner, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** and in the window that opens:

        1. In the **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** field, specify `preferred_username`.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** field, select `SubjectClaims.preferred_username`.
        1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Add a user {#add-user}

For your organization's users to be able to authenticate to Jenkins with {{ org-full-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the SAML application.

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

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

To make sure both your SAML app and Jenkins integration work correctly, authenticate to Jenkins as one of the users you added to the app. Follow these steps:

1. In your browser, navigate to your Jenkins instance address.
1. You will be redirected to the {{ yandex-cloud }} authentication page. Specify the email and password for the user you added to the app. The user must also have their email address specified.
1. Make sure you have successfully authenticated to Jenkins.