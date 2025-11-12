# Creating a SAML app in {{ org-full-name }} for integration with {{ mgl-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

To authenticate your [organization's](../../../organization/concepts/organization.md) users to {{ mgl-full-name }} via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-name }} and configure it appropriately both in {{ org-name }} and {{ mgl-name }}.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

For the users of your organization to be able to access {{ mgl-name }}:

1. [Create a {{ GL }} instance](#create-mgl-instance).
1. [Create an app in {{ org-name }}](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create a {{ GL }} instance {#create-mgl-instance}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [{{ GL }}](../../../managed-gitlab/concepts/index.md#instance) instance.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
   1. Click **{{ ui-key.yacloud.gitlab.button_create-instance }}**.
   1. At the top of the page:

      1. Enter the instance name. It must be unique throughout {{ yandex-cloud }}.

   1. Under **{{ ui-key.yacloud.gitlab.label_configuration-section }}**:

      1. Select the [instance type](../../../managed-gitlab/concepts/index.md#config). After you create an instance, you can [change its type](../../../managed-gitlab/operations/instance/instance-update.md) to a higher performing one.
      1. Specify the [availability zone](../../../overview/concepts/geo-scope.md). After you create an instance, you cannot change its availability zone.
      1. Specify the [subnet](../../../vpc/concepts/network.md#subnet) where the instance will be hosted.
      1. Select a [security group](../../../vpc/concepts/security-groups.md) or create a new one:

         1. Click **{{ ui-key.yacloud.component.network-subnet-select.button_create-security-group }}**.
         1. Enter a name and description for the security group. You can add rules for the security group later in **{{ vpc-name }}**.
         1. Click **{{ ui-key.yacloud.common.create }}**.

      1. Select the [disk](../../../compute/concepts/disk.md) size. After you create an instance, [you can increase](../../../managed-gitlab/operations/instance/instance-update.md) its disk size.
      1. Specify the [instance domain name](../../../compute/concepts/network.md#hostname): relevant DNS records will be automatically created for it in the `.gitlab.yandexcloud.net` domain.

      1. Set up the retention period for automatic backups (in days).

   1. Under **{{ ui-key.yacloud.gitlab.label_admin-section }}**, specify:
      * **{{ ui-key.yacloud.gitlab.field_admin-email }}**: Email address of the {{ GL }} instance administrator. This is the address to receive the email with a link to create a password.
      * **{{ ui-key.yacloud.gitlab.field_admin-login }}**: Administrator login.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Wait for the instance to get ready: its status on the {{ mgl-name }} dashboard will change to **Running**. This may take some time.

{% endlist %}

## Create an app in {{ org-name }} {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

   1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
   1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `managed-gitlab-app`.
      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

         1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Enter a label in `key: value` format.
         1. Press **Enter**.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. Save the **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**, **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** and **{{ ui-key.yacloud_org.application.overview.field_cert-fingerprin }}** values as you will need them in the next step.

{% endlist %}

## Set up the integration {#setup-integration}

### Set up {{ GL }} authentication using OmniAuth {#setup-sp}

To enable {{ GL }} authentication using OmniAuth, add an authentication provider:

1. In the [management console]({{ link-console-main }}), go to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Click the instance you created and select the **{{ ui-key.yacloud.gitlab.title_omniauth }}** tab.
1. Click **{{ ui-key.yacloud.gitlab.button_setup-omniauth }}**.
1. To add an authentication provider, click **Add**.
1. Select `SAML` for the type and configure the provider as follows:

   * **Label**: Name of the authentication provider. Specify any name, e.g., `Identity Hub`.
   * **Assertion consumer service URL**: HTTPS endpoint of the {{ GL }} instance. To create this URL, add `/users/auth/saml/callback` to your {{ GL }} instance URL, such as `https://example.gitlab.yandexcloud.net/users/auth/saml/callback`.
   * **IDP certificate fingerprint**: SHA1 fingerprint of a public certificate key. Use the **{{ ui-key.yacloud_org.application.overview.field_cert-fingerprin }}** field value you got when creating the app in {{ org-name }}.
   * **IDP SSO target URL**: URL of the IdP. Use the **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** field value.
   * **Issuer**: Unique ID of the application where user authentication will be performed, such as `https://example.gitlab.yandexcloud.net`.
   * **Name identifier format**: Name ID format. Set it to `Persistent`.
   * **Allow single sign on**: Allow using SSO. Set the `true` value. If set to `false`, only users who already have a {{ GL }} account will be able to authenticate.
   * **Auto link users by email**: Map the username in OmniAuth to that in {{ GL }} if they have the same email address linked. Set the `true` value.
   * **Block auto-created users**: Automatically switch the created accounts to [Pending approval]({{ gl.docs }}/ee/administration/moderate_users.html#users-pending-approval) until they get approved by an administrator. Set the `false` value.
   * **External provider**: Set the _external_ attribute for the provider. Users authenticated through this provider will be treated as [external]({{ gl.docs }}/ee/user/admin_area/external_users.html) and will have no access to [internal projects]({{ gl.docs }}/ee/user/public_access.html#internal-projects-and-groups). Set the `false` value.
   * **Auto link LDAP user**: Create an LDAP entity for automatically created accounts. This parameter only applies to instances with an LDAP provider connected. Set the `false` value.

1. Click **{{ ui-key.yacloud.common.create }}**.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the {{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }} field, provide the endpoint URL you specified under **Issuer** when setting up OmniAuth.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, provide the endpoint URL you specified under **Assertion consumer service URL** when setting up OmniAuth, e.g., `https://example.gitlab.yandexcloud.net/users/auth/saml/callback`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Configure user attributes {#user-attributes}

{% note warning %}

For integration with {{ GL }}, users must have the `email` attribute.

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the desired app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
    1. Click the `emailaddress` attribute and do the following in the window that opens:

        1. Change the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field value to `email`.
        1. Click **{{ ui-key.yacloud.common.update }}**.

{% endlist %}

For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Add a user {#add-user}

For your organization's users to be able to authenticate in {{ GL }} with {{ org-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the SAML application.

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

To make sure both your SAML app and {{ GL }} integration work correctly, authenticate to {{ GL }} as one of the users you added to the app. Proceed as follows:

1. In your browser, open the URL of your {{ GL }} instance, e.g., `https://example.gitlab.yandexcloud.net`.
1. If you are already authenticated in {{ GL }}, log out.
1. On the {{ GL }} authentication page, click the name of the authentication provider you created (`Identity Hub` in this example).
1. On the {{ yandex-cloud }} authentication page, enter the user email address and password. The user or group they belong to must be added to the application. The user must also have their email address specified.
1. Make sure you have successfully authenticated in {{ GL }}.