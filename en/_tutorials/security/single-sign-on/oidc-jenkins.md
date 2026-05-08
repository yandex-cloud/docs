# Creating an OIDC application in {{ org-full-name }} for integration with Jenkins

[Jenkins](https://www.jenkins.io/) is an open-source Java-based software system designed to support continuous software integration.

For your [organization's](../../../organization/concepts/organization.md) users to be able to authenticate to Jenkins via OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications.md#oidc) in {{ org-full-name }} and configure it both in {{ org-full-name }} and Jenkins.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

{% note info %}

For OIDC integration, your Jenkins instance must have a public domain and a valid SSL certificate in place.

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
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `jenkins-oidc`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

         1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Specify a label in `key: value` format.
         1. Press **Enter**.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab of the window that opens, copy under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** and save the `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` and `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` values.
   1. Create an [app secret](../../../organization/concepts/applications.md#oidc-secret):

      {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

## Set up the integration {#setup-integration}

### Install the OIDC plugin in Jenkins {#install-oidc-plugin}

To configure authentication to Jenkins using OIDC, install the OIDC plugin:

1. Log in to Jenkins as a user with administrator privileges.
1. In the left-hand menu, select **Manage Jenkins** > **Plugins**.
1. Navigate to the **Available** tab and enter `OpenId Connect Authentication` in the search bar.
1. Find [**OpenId Connect Authentication**](https://plugins.jenkins.io/oic-auth) and click **Install**.
1. Wait for the installation to complete, and restart Jenkins if necessary.

After installing the plugin, a new **Security Realm** option, `Login with Openid Connect`, will appear under **Manage Jenkins** > **Security**.

### Configure your OIDC application in {{ org-full-name }} {#setup-idp}

#### Configure the redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the authentication endpoint for your test application: `<jenkins_instance_address>/securityRealm/finishLogin`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Configure authentication on the Jenkins side {#setup-sp}

1. Log in to Jenkins as a user with administrator privileges.
1. In the left-hand menu, select **Manage Jenkins** > **Security**.
1. Under **Security Realm**, select `Login with Openid Connect`.
1. In the **Client id** field, enter the value you copied from the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** field when setting up the OIDC application in {{ org-full-name }}.
1. In the **Client secret** field, enter the value you copied from the **{{ ui-key.yacloud_org.application.overview.secret_section_title }}** section when setting up the OIDC application in {{ org-full-name }}.
1. In the **Well-known configuration endpoint** field, enter the URL you copied from the **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** field when setting up the OIDC application in {{ org-full-name }}.
1. Click **Advanced** and enter `openid email profile` in the **Override scopes** field.
1. Click **User fields** and fill in the fields as follows:
   - **User name field name**: `preferred_username`
   - **Full name field name**: `name`
   - **Email field name**: `email`
1. Click **Save**.

### Add a user {#add-user}

For your organization's users to be able to authenticate in Jenkins with {{ org-full-name }}'s OIDC app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the OIDC application.

{% note info %}

Users and groups added to an OIDC application can be managed by a user with the `organization-manager.oidcApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) or higher.

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

To make sure both your OIDC app and Jenkins integration work correctly, authenticate to Jenkins as one of the users you added to the app. Follow these steps:

1. In your browser, navigate to your Jenkins instance address.
1. You will be redirected to the {{ yandex-cloud }} authentication page. Specify the email and password for the user you added to the app. The user must also have their email address specified.
1. Make sure you have successfully authenticated to Jenkins.