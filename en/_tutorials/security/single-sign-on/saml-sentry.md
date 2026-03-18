# Creating a SAML app in {{ org-full-name }} for integration with Sentry

[Sentry](https://sentry.io/) is a real-time error monitoring and tracking platform for applications allowing developers to quickly detect, diagnose, and fix failures and performance issues.

To allow your [organization's](../../../organization/concepts/organization.md) users to authenticate in Sentry via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-name }} and configure it in {{ org-name }} and in Sentry.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

{% note info %}

For SAML integration, your Sentry instance must have a public domain and a valid SSL certificate in place.

{% endnote %}

For your organization's users to be able to access Sentry:

1. [Create an app in {{ org-name }}](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an app in {{ org-name }} {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

   1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
   1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `sentry-app`.

      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

         1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Enter a label in `key: value` format.
         1. Press **Enter**.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. Save the **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}** value, you will need it at the next step.

{% endlist %}

## Set up the integration {#setup-integration}

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Find the organization slug {#get-org-slug}

To set up endpoints, you need the organization slug, which is set to `sentry` by default. To find the slug of your organization:

1. Log in to Sentry.
1. In the left-hand menu, click **Settings**.
1. On the **Organization** tab, select **General Settings**.
1. Copy the **Organization Slug** field value.

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, paste the `<sentry_instance_address>/saml/metadata/<organization_slug>/` value.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, paste the `<sentry_instance_address>/saml/acs/<organization_slug>/` value.
      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** field, paste the `<sentry_instance_address>/saml/sls/<organization_slug>/` value.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Configure authentication on the Sentry side {#setup-sp}

1. Log in to Sentry as a user with the organization owner permissions.
1. In the left-hand menu, click **Settings**.
1. On the **Organization** tab, select **Auth**.
1. From the list of providers, select **SAML2**.
1. Click **Configure**.
1. In the **Metadata URL** field, enter the metadata file address you copied earlier.
1. Click **Get metadata**.
1. Under **Map Identity Provider Attributes**, fill out the following fields:
   * In the **IdP User ID** field, enter `fullname`.
   * In the **User Email** field, enter `emailaddress`.
   * Optionally, in the **First Name** field, enter `givenname`.
   * Optionally, in the **Last Name** field, enter `surname`.
1. Click **Save Settings**.

### Add a user {#add-user}

For your organization's users to be able to authenticate in Sentry with {{ org-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the SAML application.

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

To make sure both your SAML app and Sentry integration work correctly, authenticate to Sentry as one of the users you added to the app. Proceed as follows:

1. In your browser, navigate to your Sentry instance's address.
1. On the authentication page, click **Login with SAML2**.
1. On the {{ yandex-cloud }} authentication page, enter the user email address and password. The user or group they belong to must be added to the application. The user must also have their email address specified.
1. Make sure you have successfully authenticated in Sentry.