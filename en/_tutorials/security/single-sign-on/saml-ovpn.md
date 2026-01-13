# Creating a SAML app in {{ org-full-name }} for integration with OpenVPN Access Server

{% include [note-preview](../../../_includes/note-preview.md) %}

For your [organization's](../../../organization/concepts/organization.md) users to be able to authenticate in OpenVPN Access Server via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-name }} and configure it on the {{ org-name }} side and OpenVPN Access Server side.

[OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) is built on and compatible with the OpenVPN [open-source version](https://github.com/OpenVPN). It provides clients for Windows, Mac, Android, and iOS. You can also use its web UI to manage connections.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

To grant access to OpenVPN Access Server to the users of your organization:

1. [Get OpenVPN Access Server ready](#prepare-ovpn).
1. [Create an app in {{ org-name }}](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Get OpenVPN Access Server ready {#prepare-ovpn}

You can use an OpenVPN Access Server installation of your own, an SaaS version, or create a VM with OpenVPN Access Server in {{ yandex-cloud }}.

{% cut "Creating a VM with OpenVPN Access Server in {{ yandex-cloud }}" %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, specify `OpenVPN Access Server` in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field and select the [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) image.
   1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../../overview/concepts/geo-scope.md).
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username: `yc-user`.
      * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vpn-server`.
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
   1. This will open a window with the licensing model: BYOL (Bring Your Own License).
   1. Click **Create**.

{% endlist %}

### Get the administrator password {#get-admin-password}

{% include [openvpn-get-admin-password](../../_tutorials_includes/openvpn-get-admin-password.md) %}

{% endcut %}

## Create an app in {{ org-name }} {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

   1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
   1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `ovpn-app`.
      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

         1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Enter a label in `key: value` format.
         1. Press **Enter**.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. Save the **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}** value until the next step.

{% endlist %}

## Set up the integration {#setup-integration}

### Configure authentication on the OpenVPN Access Server side {#setup-sp}

{% note info %}

By default, the server has a self-signed certificate. If you need to replace this certificate, follow the steps [here](https://openvpn.net/vpn-server-resources/installing-a-valid-ssl-web-certificate-in-access-server/).

{% endnote %}

Add SAML authentication on the OpenVPN server:

1. In your browser, open the OpenVPN Access Server admin interface. Its default address is `https://<server_address>:943/admin`.
1. Enter the OpenVPN Access Server admin username and password.
1. Click **Agree**. This will open the OpenVPN Admin Web UI home page.
1. Expand the **Authentication** tab and open **SAML**.
1. Set the **Enable SAML authentication** checkbox to **Yes**.
1. Expand the **Configure Identity Provider (IdP) Automatically via Metadata** section.
1. In the **IdP Metadata URL** field, enter the metadata file address you copied earlier.
1. Click **Get**.
1. Click **Save settings**.
1. Copy the `SP Identity` and `SP ACS` values on this page.
   ```text
   These URLs depend on the hostname setting your current setting of '<server_address>'.
      SP Identity: https://<server_address>/saml/metadata
      SP ACS: https://<server_address>/saml/acs
   ```
1. Expand the **Authentication** tab and open **Settings**.
1. Under **Default Authentication System**, select **SAML**.
1. Click **Save settings**.
1. Click **Update running server**.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, paste the `SP Identity` address you copied earlier.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, paste the `SP ACS` address you copied earlier.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Add a user {#add-user}

For the users of your organization to be able to authenticate in OpenVPN Access Server with {{ org-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the SAML application.

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

To make sure your SAML app and OpenVPN Access Server integration work correctly, authenticate to OpenVPN Access Server as one of the users you added to the app. Proceed as follows:

1. In your browser, go to the OpenVPN Access Server client interface. Its default address is `https://<server_address>:943/`.
1. On the authentication page, click **Sign In With SAML**.
1. On the {{ yandex-cloud }} authentication page, enter the user email address and password. The user or group they belong to must be added to the application.
1. Make sure you have successfully authenticated to OpenVPN Access Server.