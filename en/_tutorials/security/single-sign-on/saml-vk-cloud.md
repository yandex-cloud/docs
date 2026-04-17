# Creating a SAML app in {{ org-full-name }} for integration with VK Cloud

[VK Cloud](https://cloud.vk.com/) is a Russian cloud platform offering IaaS and PaaS services, data and AI/ML tools, as well as solutions you need to build a cloud infrastructure. VK Cloud supports [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language)-based user authentication via an identity federation.

For your [organization's](../../../organization/concepts/organization.md) users to be able to authenticate in VK Cloud via SAML SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-full-name }} and configure it both on the {{ yandex-cloud }} and VK Cloud side.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

To give your organization's users access to VK Cloud:

1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Add users and configure permissions](#add-users).
1. [Make sure the application works correctly](#validate).

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `vkcloud-saml`.

        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To integrate VK Cloud with the SAML app you created in {{ org-full-name }}, complete the setup both on the VK Cloud and {{ org-full-name }} side.

### Configuring an identity federation on the VK Cloud side {#setup-sp}

{% note info %}

Only a project owner can create an identity federation in VK Cloud.

{% endnote %}

1. Get the metadata for the [new app](#create-app):

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      The downloaded [XML](https://en.wikipedia.org/wiki/XML) file contains the required metadata and a certificate used for SAML response signature verification.

1. Create an identity federation in VK Cloud using {{ org-full-name }} metadata:

    1. Go to your [VK Cloud account](https://cloud.vk.com/account).
    1. Open the **Identity federation** section and navigate to the **Federations** tab.
    1. Click **Create**.
    1. Click **Upload IdP metadata** and upload the XML metadata file you downloaded from {{ org-full-name }}.
    1. Click **Upload**.

1. In the new federation's info, copy and save the federation ID. You will need it to set up a SAML application in {{ org-full-name }} and to manage federated user sign-ins.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
    1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
        1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, specify the address `https://msk.cloud.vk.com/federation-service/v1/federation/saml/<federation_ID>/metadata`, where `<federation_ID>` is the federation ID you copied when [creating the federation in VK Cloud](#setup-sp).
        1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter this address: `https://msk.cloud.vk.com/federation-service/v1/federation/saml/<federation_ID>/acs`.
        1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Configure user attributes {#user-attributes}

{% note warning %}

For the federation to function correctly in VK Cloud, SAML attribute names must have URI prefixes: `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/` for user attributes; `http://schemas.xmlsoap.org/claims/` for group attribute.
Without these prefixes (and if there are case variations, e.g., `Group`), attribute mapping in VK Cloud may fail.

{% endnote %}

Set user attributes for integration with VK Cloud:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the desired app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
    1. Make sure the attributes are configured as follows:

        Attribute | Value
        --- | ---
        `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress` | `SubjectClaims.email`
        `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name` | `SubjectClaims.firstName`
        `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname` | `SubjectClaims.lastName`

    1. If you plan to use group mapping, add an attribute for group transfer:

        1. Click **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}**.
        1. In the **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** field, specify `http://schemas.xmlsoap.org/claims/Group`.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** field, specify `SubjectClaims.groups`.
        1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Add users and configure permissions {#add-users}

For the users of your organization to be able to authenticate in VK Cloud via a SAML application in {{ org-full-name }}, add them to the application and configure access permissions in VK Cloud.

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

### Add users to the {{ org-full-name }} SAML application {#add-app-users}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the users.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

### Configure group and role mapping in VK Cloud {#vkcloud-groups-roles}

To define federated users' access permissions in VK Cloud, configure mappings between IdP groups and VK Cloud roles.

1. Go to your [VK Cloud account](https://cloud.vk.com/account).
1. Open the **Identity federation** section and navigate to the **Groups** tab.
1. Select the project you want to configure the federation for.
1. Click **Add** (or **Add group** if groups already exist).
1. Specify the IdP group name in lowercase and select the scope of permissions (**Domain** or **Project**), then proceed to assign roles.
1. Click **Add**.

## Make sure your application works correctly {#validate}

To make sure your SAML app and its integration with VK Cloud work correctly, sign in to VK Cloud as one of the users you added to the app.

Proceed as follows:

1. In your browser, open the federated user sign-in URL: `https://cloud.vk.com/v1/federation/saml/<federation_ID>/signin`, where `<federation_ID>` is the federation ID you copied when [creating the federation in VK Cloud](#setup-sp).
1. Authenticate in {{ yandex-cloud }} under a user account from your organization.
1. Make sure you have signed in to VK Cloud following authentication.
